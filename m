Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF1B2FC07B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 21:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391994AbhAST7l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 14:59:41 -0500
Received: from foss.arm.com ([217.140.110.172]:48218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391928AbhAST7Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 14:59:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07628D6E;
        Tue, 19 Jan 2021 11:58:39 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 859C43F719;
        Tue, 19 Jan 2021 11:58:37 -0800 (PST)
Subject: Re: [PATCH 2/3] dt-bindings: rockchip: Add DesignWare based PCIe
 controller
To:     Johan Jonker <jbx6244@gmail.com>, Simon Xue <xxm@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
References: <20210118091739.247040-1-xxm@rock-chips.com>
 <20210118091739.247040-2-xxm@rock-chips.com>
 <e143ad9e-1cfd-e59d-0079-513c036981ba@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <df742787-07c8-7ca8-8f3a-32ea38ff44c8@arm.com>
Date:   Tue, 19 Jan 2021 19:58:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <e143ad9e-1cfd-e59d-0079-513c036981ba@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-01-19 13:07, Johan Jonker wrote:
> Hi Simon,
> 
> Thank you for this patch for rk3568 pcie.
> 
> Include the Rockchip device tree maintainer and all other people/lists
> to the CC list.
> 
> ./scripts/checkpatch.pl --strict <patch1> <patch2>
> 
>   ./scripts/get_maintainer.pl --noroles --norolestats --nogit-fallback
> --nogit <patch1> <patch2>
> 
> git send-email --suppress-cc all --dry-run --annotate --to
> heiko@sntech.de --cc <..> <patch1> <patch2>
> 
> This SoC has no support in mainline linux kernel yet.
> In all the following yaml documents for rk3568 we need headers with
> defines for clocks and power domains, etc.
> 
> For example:
> #include <dt-bindings/clock/rk3568-cru.h>
> #include <dt-bindings/power/rk3568-power.h>
> 
> Could Rockchip submit first clocks and power drivers entries and a basic
> rk3568.dtsi + evb dts?
> Include a patch to this serie with 3 pcie nodes added to rk3568.dtsi.
> 
> A dtbs_check only works with a complete dtsi and evb dts.

This is a bizarrely circular argument - we can't have a binding without 
a DT to try validating against it? That's not how it usually works. We 
review and merge bindings first, then drivers that consume them and DTs 
that implement them.

Examples within a binding itself do not need to represent a whole SoC, 
in fact that would usually just make them unnecessarily complicated. 
They do need to compile correctly in the `make dt_binding_check` 
environment, but if anything it makes more sense to strip down and 
simplify the example to fit that environment than to pile in enough 
other crap to realistically model all the supporting components from a 
particular SoC. Not least because the more extra stuff has to be crammed 
in, the more it distracts from the fundamental purpose of demonstrating 
*that specific binding* in use. For instance, a "clocks" property can 
quite happily use arbitrary numeric specifiers targeting a dummy clock 
controller node; requiring that some device binding depend on a 
particular clock controller binding being upstreamed just so that 
SoC-specific identifiers can then be used in an example would be rather 
absurd.

Robin.

> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> 
> On 1/18/21 10:17 AM, Simon Xue wrote:
>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
>> ---
>>   .../bindings/pci/rockchip-dw-pcie.yaml        | 101 ++++++++++++++++++
>>   1 file changed, 101 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>> new file mode 100644
>> index 000000000000..fa664cfffb29
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>> @@ -0,0 +1,101 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: DesignWare based PCIe RC controller on Rockchip SoCs
>> +
> 
>> +maintainers:
>> +  - Shawn Lin <shawn.lin@rock-chips.com>
>> +  - Simon Xue <xxm@rock-chips.com>
> 
> maintainers:
>    - Heiko Stuebner <heiko@sntech.de>
> 
> Add only people with maintainer rights.
> 
> 
> allOf:
>    - $ref: /schemas/pci/pci-bus.yaml#
> 
> designware-pcie.txt is in need for conversion to yaml.
> Include the things that are needed in this document for now.
> 
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
> 
>> +    enum:
>> +      - rockchip,rk3568-pcie
>> +      - snps,dw-pcie
> 
>      items:
>        - const: rockchip,rk3568-pcie
>        - const: snps,dw-pcie
> 
>> +
>> +  reg:
>> +    maxItems: 1
> 
>      interrupts:
>        - description:
>        - description:
>        - description:
>        - description:
>        - description:
> 
>    interrupt-names:    items:
>        - const: sys
>        - const: pmc
>        - const: msg
>        - const: legacy
>        - const: err
> 
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
> 
> 
>    msi-map: true
> 
>    power-domains:
>      maxItems: 1
> 
>> +  resets:	maxItems: 1
> 
>> +    items:
>> +      - description: PCIe pipe reset line
> 
> remove
> 
>> +
>> +  reset-names:
> 	const: pipe
> 
>> +    items:
>> +      - const: pipe
> 
> remove
> 
>> +
>> +required:
>> +  - compatible
> 
>> +  - "#address-cells"
>> +  - "#size-cells"
> 
> already required in pci-bus.yaml
> 
>> +  - bus-range
>> +  - reg
>> +  - reg-names
>> +  - clocks
>> +  - clock-names
> 
>> +  - msi-map
> 
> not defined in pci-bus.yaml and designware-pcie.txt
> add to document
> 
>> +  - num-lanes
> 
>> +  - phys
>> +  - phy-names
> 
> not defined in pci-bus.yaml and designware-pcie.txt
> add to document
> 
>     - power-domains
> 
>> +  - ranges
> 
> already required in pci-bus.yaml
> 
>> +  - resets
>> +  - reset-names
>> +
> 
>> +additionalProperties: false
> 
> unevaluatedProperties: false
> 
> If other documents are included use unevaluatedProperties.
> 
>> +
>> +examples:
>> +  - |
> 
> #include <dt-bindings/clock/rk3568-cru.h>
> #include <dt-bindings/interrupt-controller/arm-gic.h>
> #include <dt-bindings/power/rk3568-power.h>
> 
> Missing defines
> 
> 
>      bus {
>          #address-cells = <2>;
>          #size-cells = <2>;
> 
> dt-check uses standard 32 bit regs
> this example is for 64 bit
> 
>> +    pcie3x2: pcie@fe280000 {
>> +      compatible = "rockchip,rk3568-pcie", "snps,dw-pcie";
> 
>> +      #address-cells = <3>;
>> +      #size-cells = <2>;
> 
> sort things that start with # below
> 
>> +      bus-range = <0x20 0x2f>;
> 
> sort order is:
> compatible
> reg
> interrupt
> the rest in alphabetical order
> things with #
> no status in yaml examples
> 
> 
>> +      reg = <0x3 0xc0800000 0x0 0x400000>,
>> +            <0x0 0xfe280000 0x0 0x10000>;
>> +      reg-names = "pcie-dbi", "pcie-apb";
> 
> 		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> 		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
> 
>> +      clocks = <&cru ACLK_PCIE30X2_MST>, <&cru ACLK_PCIE30X2_SLV>,
>> +               <&cru ACLK_PCIE30X2_DBI>, <&cru PCLK_PCIE30X2>,
>> +               <&cru CLK_PCIE30X2_AUX_NDFT>;
>> +      clock-names = "aclk_mst", "aclk_slv",
>> +                    "aclk_dbi", "pclk",
>> +                    "aux";
>> +      msi-map = <0x2000 &its 0x2000 0x1000>;
>> +      num-lanes = <2>;
>> +      phys = <&pcie30phy>;
>> +      phy-names = "pcie-phy";
> 
>      power-domains = <&power RK3568_PD_PIPE>;
> 
>> +      ranges = <0x00000800 0x0 0x80000000 0x3 0x80000000 0x0 0x800000
>> +                0x81000000 0x0 0x80800000 0x3 0x80800000 0x0 0x100000
>> +                0x83000000 0x0 0x80900000 0x3 0x80900000 0x0 0x3f700000>;
>> +      resets = <&cru SRST_PCIE30X2_POWERUP>;
>> +      reset-names = "pipe";
>> +    };
> 
> };
> 
>> +
>> +...
>>
> 
> Make sure that all properties that show up in this node are checked!
> 
> 	pcie2x1: pcie@fe260000 {
> 		compatible = "rockchip,rk3568-pcie", "snps,dw-pcie";
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 		bus-range = <0x0 0xf>;
> 		clocks = <&cru ACLK_PCIE20_MST>, <&cru ACLK_PCIE20_SLV>,
> 			 <&cru ACLK_PCIE20_DBI>, <&cru PCLK_PCIE20>,
> 			 <&cru CLK_PCIE20_AUX_NDFT>;
> 		clock-names = "aclk_mst", "aclk_slv",
> 			      "aclk_dbi", "pclk", "aux";
> 		device_type = "pci";
> 		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> 			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> 		interrupt-names = "sys", "pmc", "msg", "legacy", "err";
> 		linux,pci-domain = <0>;
> 		num-ib-windows = <6>;
> 		num-ob-windows = <2>;
> 		max-link-speed = <2>;
> 		msi-map = <0x0 &its 0x0 0x1000>;
> 		num-lanes = <1>;
> 		phys = <&combphy2_psq PHY_TYPE_PCIE>;
> 		phy-names = "pcie-phy";
> 		power-domains = <&power RK3568_PD_PIPE>;
> 		ranges = <0x00000800 0x0 0x00000000 0x3 0x00000000 0x0 0x800000
> 			  0x81000000 0x0 0x00800000 0x3 0x00800000 0x0 0x100000
> 			  0x83000000 0x0 0x00900000 0x3 0x00900000 0x0 0x3f700000>;
> 		reg = <0x3 0xc0000000 0x0 0x400000>,
> 		      <0x0 0xfe260000 0x0 0x10000>;
> 		reg-names = "pcie-dbi", "pcie-apb";
> 		resets = <&cru SRST_PCIE20_POWERUP>;
> 		reset-names = "pipe";
> 		status = "disabled";
> 	};
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
