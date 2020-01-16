Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 821DA13D0DD
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 01:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbgAPAEA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 19:04:00 -0500
Received: from lucky1.263xmail.com ([211.157.147.134]:46598 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbgAPAD7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 19:03:59 -0500
Received: from localhost (unknown [192.168.167.32])
        by lucky1.263xmail.com (Postfix) with ESMTP id 826EE4E735;
        Thu, 16 Jan 2020 08:03:55 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P9174T140331144181504S1579133034317848_;
        Thu, 16 Jan 2020 08:03:55 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <161c3253a650a55ec4915d63e8b13e0c>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: xxm@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com, devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        William Wu <william.wu@rock-chips.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Simon Xue <xxm@rock-chips.com>
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_1/6=5d_dt-bindings=3a_add_binding_for_Rock?=
 =?UTF-8?B?Y2hpcCBjb21ibyBwaHkgdXNpbmcgYW4gSW5ub3NpbGljb24gSVDjgJDor7fms6g=?=
 =?UTF-8?B?5oSP77yM6YKu5Lu255SxbGludXgtcm9ja2NoaXAtYm91bmNlcytzaGF3bi5saW49?=
 =?UTF-8?B?cm9jay1jaGlwcy5jb21AbGlzdHMuaW5mcmFkZWFkLm9yZ+S7o+WPkeOAkQ==?=
To:     Rob Herring <robh@kernel.org>
References: <1578986580-71974-1-git-send-email-shawn.lin@rock-chips.com>
 <1578986580-71974-2-git-send-email-shawn.lin@rock-chips.com>
 <20200114234323.GA5823@bogus>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <75a1b9d2-6dff-eaad-dab5-87321a7ca9cd@rock-chips.com>
Date:   Thu, 16 Jan 2020 08:03:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114234323.GA5823@bogus>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020/1/15 7:43, Rob Herring wrote:
> On Tue, Jan 14, 2020 at 03:22:55PM +0800, Shawn Lin wrote:
>> This IP could supports USB3.0 and PCIe.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>>   .../bindings/phy/rockchip,inno-combophy.yaml       | 84 ++++++++++++++++++++++
>>   1 file changed, 84 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml
> 
> Fails 'make dt_binding_check':
> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml:
> ignoring, error in schema: properties: rockchip,combphygrf
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11:
> Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml:
> properties:rockchip,combphygrf: {'items': [{'description': 'The grf for
> COMBPHY configuration and state registers.'}]} is not valid under any of
> the given schemas (Possible causes of the failure):
> 	
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml:
> properties:rockchip,combphygrf: 'description' is a required property
> 

Thanks Rob, will fix them in v2.

> 
>>
>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml
>> new file mode 100644
>> index 0000000..d647ab3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml
>> @@ -0,0 +1,84 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/rockchip,inno-combophy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Rockchip USB3.0/PCI-e combo phy
>> +
>> +maintainers:
>> +        - Shawn Lin <shawn.lin@rock-chips.com>
>> +        - William Wu <william.wu@rock-chips.com>
> 
> 2 space indent.
> 
>> +
>> +properties:
>> +  "#phy-cells":
>> +    const: 1
>> +
>> +  compatible:
>> +    enum:
>> +      - rockchip,rk1808-combphy
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: PLL reference clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: refclk
>> +
>> +  resets:
>> +    items:
>> +      - description: OTG unit reset line
>> +      - description: POR unit reset line
>> +      - description: APB interface reset line
>> +      - description: PIPE unit reset line
>> +
>> +  reset-names:
>> +    items:
>> +      - const: otg-rst
>> +      - const: combphy-por
>> +      - const: combphy-apb
>> +      - const: combphy-pipe
>> +
>> +  rockchip,combphygrf:
>> +    items:
>> +      - description: The grf for COMBPHY configuration and state registers.
>> +
>> +required:
>> +  - "#phy-cells"
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - rockchip,combphygrf
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    combphy_grf: syscon@fe018000 {
>> +        compatible = "rockchip,usb3phy-grf", "syscon";
>> +        reg = <0x0 0xfe018000 0x0 0x8000>;
>> +    };
>> +
>> +    combphy: phy@ff380000 {
>> +        compatible = "rockchip,rk1808-combphy";
>> +        reg = <0x0 0xff380000 0x0 0x10000>;
>> +        #phy-cells = <1>;
>> +        clocks = <&cru SCLK_PCIEPHY_REF>;
>> +        clock-names = "refclk";
>> +        assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
>> +        assigned-clock-rates = <25000000>;
>> +        resets = <&cru SRST_USB3_OTG_A>, <&cru SRST_PCIEPHY_POR>,
>> +                 <&cru SRST_PCIEPHY_P>, <&cru SRST_PCIEPHY_PIPE>;
>> +        reset-names = "otg-rst", "combphy-por",
>> +                      "combphy-apb", "combphy-pipe";
>> +        rockchip,combphygrf = <&combphy_grf>;
>> +    };
>> +
>> +...
>> -- 
>> 1.9.1
>>
>>
>>
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> 
> 


