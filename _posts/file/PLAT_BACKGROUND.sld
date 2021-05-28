<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" 
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" 
xmlns:xlink="http://www.w3.org/1999/xlink" 
xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" 
xmlns:se="http://www.opengis.net/se">
  <NamedLayer>
    <se:Name>VDT_MRO_ROAD_GRID10_DAY_GEO</se:Name>
    <UserStyle>
      <se:Name>VDT_MRO_ROAD_GRID10_DAY_GEO</se:Name>
      <se:FeatureTypeStyle>
        <se:Rule>
          <se:Name> Platform</se:Name>
          <se:Description>
            <se:Title> Platform</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>OBJECT_TYPE</ogc:PropertyName>
                <ogc:Literal>Platform</ogc:Literal>
              </ogc:PropertyIsEqualTo>
            </ogc:And>
          </ogc:Filter>
          <se:PointSymbolizer>
      <se:Graphic>
              <se:Mark>
                <se:WellKnownName>circle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#fffafa</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
              <se:SvgParameter name="stroke">#000000</se:SvgParameter>
              <se:SvgParameter name="stroke-opacity">0.80</se:SvgParameter>
              <se:SvgParameter name="stroke-width">1.20</se:SvgParameter>
              <se:SvgParameter name="stroke-linejoin">bevel</se:SvgParameter>
              </se:Stroke>
              </se:Mark>
              <se:Size>10</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:MinScaleDenominator>100001</se:MinScaleDenominator>        
		  <se:MaxScaleDenominator>250001</se:MaxScaleDenominator>
          <se:TextSymbolizer>
            <se:Label>
              <ogc:PropertyName>STOP_NAME</ogc:PropertyName>
            </se:Label>
            <se:Font>
              <se:SvgParameter name="font-family">文泉驿点阵正黑</se:SvgParameter>
              <se:SvgParameter name="font-size">10</se:SvgParameter>
            </se:Font>
            <se:LabelPlacement>
              <se:PointPlacement>
                <se:AnchorPoint>
                  <se:AnchorPointX>1</se:AnchorPointX>
                  <se:AnchorPointY>0.5</se:AnchorPointY>
                </se:AnchorPoint>
              </se:PointPlacement>
            </se:LabelPlacement>
            <se:Fill>
				<se:SvgParameter name="fill">#000000</se:SvgParameter>
				<se:SvgParameter name="fill-opacity">1.0</se:SvgParameter>
			</se:Fill>
            <se:VendorOption name="maxDisplacement">1</se:VendorOption>
          </se:TextSymbolizer>
        </se:Rule>
		<se:Rule>
          <se:MinScaleDenominator>0</se:MinScaleDenominator>
		  <se:MaxScaleDenominator>100000</se:MaxScaleDenominator>
          <se:TextSymbolizer>
            <se:Label>
              <ogc:PropertyName>STOP_NAME</ogc:PropertyName>
            </se:Label>
            <se:Font>
              <se:SvgParameter name="font-family">文泉驿点阵正黑</se:SvgParameter>
              <se:SvgParameter name="font-size">18</se:SvgParameter>
            </se:Font>
            <se:LabelPlacement>
              <se:PointPlacement>
                <se:AnchorPoint>
                  <se:AnchorPointX>1</se:AnchorPointX>
                  <se:AnchorPointY>0.5</se:AnchorPointY>
                </se:AnchorPoint>
              </se:PointPlacement>
            </se:LabelPlacement>
            <se:Fill>
				<se:SvgParameter name="fill">#000000</se:SvgParameter>
				<se:SvgParameter name="fill-opacity">1.0</se:SvgParameter>
			</se:Fill>
             <se:VendorOption name="maxDisplacement">10</se:VendorOption>
          </se:TextSymbolizer>
        </se:Rule>
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>