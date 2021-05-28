<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" 
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" 
xmlns:se="http://www.opengis.net/se" version="1.1.0" xmlns:xlink="http://www.w3.org/1999/xlink" 
xmlns:ogc="http://www.opengis.net/ogc">
  <NamedLayer>
    <se:Name>metro</se:Name>
    <UserStyle>
      <se:Name>CFG_MAP_ROAD_TIELU</se:Name>
      <se:FeatureTypeStyle>
        <se:Rule> 
          <se:Name>123</se:Name>
          <se:Description>
            <se:Title>123</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>ROAD_TYPE</ogc:PropertyName>
              <ogc:Literal>metro</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:SvgParameter name="stroke">#848587</se:SvgParameter>
              <se:SvgParameter name="stroke-width">2</se:SvgParameter>
              <se:SvgParameter name="stroke-opacity">1.0</se:SvgParameter>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:MinScaleDenominator>100001</se:MinScaleDenominator>
          <se:TextSymbolizer>
            <se:Geometry>
              <ogc:Function name="startPoint">
                <ogc:PropertyName>GEOM</ogc:PropertyName>
              </ogc:Function>
            </se:Geometry>
            <se:Label>
              <ogc:PropertyName>ROAD_NAME</ogc:PropertyName>
            </se:Label>
            <se:Font>
              <se:SvgParameter name="font-family">文泉驿等宽微米黑</se:SvgParameter>
              <se:SvgParameter name="font-size">12</se:SvgParameter>
              <se:SvgParameter name="font-style">oblique</se:SvgParameter>
            </se:Font>
            <se:LabelPlacement>
              <se:PointPlacement>
                <se:Displacement>
                  <se:DisplacementX>1</se:DisplacementX>
                  <se:DisplacementY>0</se:DisplacementY>
                </se:Displacement>
                <se:Rotation>-45</se:Rotation>
              </se:PointPlacement>
            </se:LabelPlacement>
			<se:Halo>
			<se:Radius>2</se:Radius>
			 <se:Fill>
				<se:SvgParameter name="fill">#ffffff</se:SvgParameter>
				<se:SvgParameter name="fill-opacity">1.0</se:SvgParameter>
			 </se:Fill>
			</se:Halo>
            <se:Fill>
              <se:SvgParameter name="fill">#7092be</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">1.0</se:SvgParameter>
            </se:Fill>
            <se:VendorOption name="maxDisplacement">10</se:VendorOption>
          </se:TextSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:MinScaleDenominator>0</se:MinScaleDenominator>
          <se:MaxScaleDenominator>100000</se:MaxScaleDenominator>
          <se:TextSymbolizer>
            <se:Geometry>
              <ogc:Function name="startPoint">
                <ogc:PropertyName>GEOM</ogc:PropertyName>
              </ogc:Function>
            </se:Geometry>

            <se:Label>
              <ogc:PropertyName>ROAD_NAME</ogc:PropertyName>
            </se:Label>

            <se:Font>
              <se:SvgParameter name="font-family">文泉驿等宽微米黑</se:SvgParameter>
              <se:SvgParameter name="font-size">20</se:SvgParameter>
              <se:SvgParameter name="font-style">oblique</se:SvgParameter>
            </se:Font>
            <se:LabelPlacement>
              <se:PointPlacement>
                <se:Displacement>
                  <se:DisplacementX>1</se:DisplacementX>
                  <se:DisplacementY>0</se:DisplacementY>
                </se:Displacement>
                <se:Rotation>-45</se:Rotation>
              </se:PointPlacement>
            </se:LabelPlacement>
			<se:Halo>
			<se:Radius>2</se:Radius>
			 <se:Fill>
				<se:SvgParameter name="fill">#ffffff</se:SvgParameter>
				<se:SvgParameter name="fill-opacity">1.0</se:SvgParameter>
			 </se:Fill>
			</se:Halo>
            <se:Fill>
              <se:SvgParameter name="fill">#7092be</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">1.0</se:SvgParameter>
            </se:Fill>
            <se:VendorOption name="maxDisplacement">10</se:VendorOption>
          </se:TextSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:MinScaleDenominator>100001</se:MinScaleDenominator>
          <se:TextSymbolizer>
            <se:Geometry>
              <ogc:Function name="endPoint">
                <ogc:PropertyName>GEOM</ogc:PropertyName>
              </ogc:Function>
            </se:Geometry>
            <se:Label>
              <ogc:PropertyName>ROAD_NAME</ogc:PropertyName>
            </se:Label>
            <se:Font>
              <se:SvgParameter name="font-family">文泉驿等宽微米黑</se:SvgParameter>
              <se:SvgParameter name="font-size">12</se:SvgParameter>
              <se:SvgParameter name="font-style">oblique</se:SvgParameter>
            </se:Font>
            <se:LabelPlacement>
              <se:PointPlacement>
                <se:Displacement>
                  <se:DisplacementX>1</se:DisplacementX>
                  <se:DisplacementY>-1</se:DisplacementY>
                </se:Displacement>
                <se:Rotation>-45</se:Rotation>
              </se:PointPlacement>
            </se:LabelPlacement>
			<se:Halo>
			<se:Radius>2</se:Radius>
			 <se:Fill>
				<se:SvgParameter name="fill">#ffffff</se:SvgParameter>
				<se:SvgParameter name="fill-opacity">1.0</se:SvgParameter>
			 </se:Fill>
			</se:Halo>
            <se:Fill>
              <se:SvgParameter name="fill">#7092be</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">1.0</se:SvgParameter>
            </se:Fill>
            <se:VendorOption name="maxDisplacement">10</se:VendorOption>
          </se:TextSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:MinScaleDenominator>0</se:MinScaleDenominator>
          <se:MaxScaleDenominator>100000</se:MaxScaleDenominator>
          <se:TextSymbolizer>
            <se:Geometry>
              <ogc:Function name="endPoint">
                <ogc:PropertyName>GEOM</ogc:PropertyName>
              </ogc:Function>
            </se:Geometry>

            <se:Label>
              <ogc:PropertyName>ROAD_NAME</ogc:PropertyName>
            </se:Label>

            <se:Font>
              <se:SvgParameter name="font-family">文泉驿等宽微米黑</se:SvgParameter>
              <se:SvgParameter name="font-size">20</se:SvgParameter>
              <se:SvgParameter name="font-style">oblique</se:SvgParameter>
            </se:Font>
            <se:LabelPlacement>
              <se:PointPlacement>
                <se:Displacement>
                  <se:DisplacementX>1</se:DisplacementX>
                  <se:DisplacementY>-1</se:DisplacementY>
                </se:Displacement>
                <se:Rotation>-45</se:Rotation>
              </se:PointPlacement>
            </se:LabelPlacement>
			<se:Halo>
			<se:Radius>2</se:Radius>
			 <se:Fill>
				<se:SvgParameter name="fill">#ffffff</se:SvgParameter>
				<se:SvgParameter name="fill-opacity">1.0</se:SvgParameter>
			 </se:Fill>
			</se:Halo>
            <se:Fill>
              <se:SvgParameter name="fill">#7092be</se:SvgParameter>
              <se:SvgParameter name="fill-opacity">1.0</se:SvgParameter>
            </se:Fill>
            <se:VendorOption name="maxDisplacement">10</se:VendorOption>
          </se:TextSymbolizer>
        </se:Rule>

      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>