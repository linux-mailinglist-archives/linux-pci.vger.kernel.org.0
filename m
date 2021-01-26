Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F66303575
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 06:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbhAZFmZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 00:42:25 -0500
Received: from regular1.263xmail.com ([211.150.70.203]:56484 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbhAZCuG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 21:50:06 -0500
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 89F66842;
        Tue, 26 Jan 2021 10:44:24 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.31.83] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P11934T140583622674176S1611629063737209_;
        Tue, 26 Jan 2021 10:44:24 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <3500669ea1cd2ec8e8f0b3c623afdafc>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v3_1/2=5d_dt-bindings=3a_rockchip=3a_Add_D?=
 =?UTF-8?B?ZXNpZ25XYXJlIGJhc2VkIFBDSWUgY29udHJvbGxlcuOAkOivt+azqOaEj++8jA==?=
 =?UTF-8?B?6YKu5Lu255Sxcm9iaGVycmluZzJAZ21haWwuY29t5Luj5Y+R44CR?=
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <20210125024824.634583-1-xxm@rock-chips.com>
 <20210125152632.GA381616@robh.at.kernel.org>
From:   xxm <xxm@rock-chips.com>
Message-ID: <e22ea1ed-9b3b-98ae-5b78-6c3c10af3589@rock-chips.com>
Date:   Tue, 26 Jan 2021 10:44:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125152632.GA381616@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Thanks for reply.

在 2021/1/25 23:26, Rob Herring 写道:
> On Mon, Jan 25, 2021 at 10:48:24AM +0800, Simon Xue wrote:
>> Document DT bindings for PCIe controller found on Rockchip SoC.
>>
>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
>> ---
>>   .../bindings/pci/rockchip-dw-pcie.yaml        | 133 ++++++++++++++++++
>>   1 file changed, 133 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>> new file mode 100644
>> index 000000000000..24ea42203c14
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>> @@ -0,0 +1,133 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: DesignWare based PCIe RC controller on Rockchip SoCs
>> +
>> +maintainers:
>> +  - Shawn Lin <shawn.lin@rock-chips.com>
>> +  - Simon Xue <xxm@rock-chips.com>
>> +  - Heiko Stuebner <heiko@sntech.de>
>> +
>> +description: |+
>> +  RK3568 SoC PCIe host controller is based on the Synopsys DesignWare
>> +  PCIe IP and thus inherits all the common properties defined in
>> +  designware-pcie.txt.
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-bus.yaml#
>> +
>> +# We need a select here so we don't match all nodes with 'snps,dw-pcie'
>> +select:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        const: rockchip,rk3568-pcie
>> +  required:
>> +    - compatible
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: rockchip,rk3568-pcie
>> +      - const: snps,dw-pcie
>> +
>> +  reg:
>> +    items:
>> +      - description: Data Bus Interface (DBI) registers
>> +      - description: Rockchip designed configuration registers
>> +
>> +  clocks:
>> +    items:
>> +      - description: AHB clock for PCIe master
>> +      - description: AHB clock for PCIe slave
>> +      - description: AHB clock for PCIe dbi
>> +      - description: APB clock for PCIe
>> +      - description: Auxiliary clock for PCIe
>> +
>> +  clock-names:
>> +    items:
>> +      - const: aclk_mst
>> +      - const: aclk_slv
>> +      - const: aclk_dbi
>> +      - const: pclk
>> +      - const: aux
>> +
>> +  msi-map: true
>> +
>> +  num-lanes: true
>> +
>> +  phys:
>> +    maxItems: 1
>> +
>> +  phy-names:
>> +    const: pcie-phy
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  ranges:
>> +    maxItems: 3
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    const: pipe
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - clocks
>> +  - clock-names
>> +  - msi-map
>> +  - num-lanes
>> +  - phys
>> +  - phy-names
>> +  - power-domains
>> +  - resets
>> +  - reset-names
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    bus {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        pcie3x2: pcie@fe280000 {
>> +            compatible = "rockchip,rk3568-pcie", "snps,dw-pcie";
>> +            reg = <0x3 0xc0800000 0x0 0x400000>,
>> +                  <0x0 0xfe280000 0x0 0x10000>;
>> +            reg-names = "pcie-dbi", "pcie-apb";
> I believe I already said use 'dbi'. The DBI is also not 4MB. The config
> space goes here too, not in 'ranges'.

Sorry for missing  update in yaml.

I think yaml is used to describe the resources of specific SoC, it 
reserves 4MB for DBI on Rockchip SoC.

So, I think assign 4MB here is reasonable.

>> +            bus-range = <0x20 0x2f>;
>> +            clocks = <&cru 143>, <&cru 144>,
>> +                     <&cru 145>, <&cru 146>,
>> +                     <&cru 147>;
>> +            clock-names = "aclk_mst", "aclk_slv",
>> +                          "aclk_dbi", "pclk",
>> +                          "aux";
>> +            device_type = "pci";
>> +            linux,pci-domain = <2>;
>> +            max-link-speed = <2>;
>> +            msi-map = <0x2000 &its 0x2000 0x1000>;
>> +            num-lanes = <2>;
>> +            phys = <&pcie30phy>;
>> +            phy-names = "pcie-phy";
>> +            power-domains = <&power 15>;
>> +            ranges = <0x00000800 0x0 0x80000000 0x3 0x80000000 0x0 0x800000>,
>> +                     <0x81000000 0x0 0x80800000 0x3 0x80800000 0x0 0x100000>,
>> +                     <0x83000000 0x0 0x80900000 0x3 0x80900000 0x0 0x3f700000>;
>> +            resets = <&cru 193>;
>> +            reset-names = "pipe";
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +        };
>> +    };
>> +...
>> -- 
>> 2.25.1
>>
>>
>>
>
>


