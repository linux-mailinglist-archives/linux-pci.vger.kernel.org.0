Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DDE32B098
	for <lists+linux-pci@lfdr.de>; Wed,  3 Mar 2021 04:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCCBle (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Mar 2021 20:41:34 -0500
Received: from regular1.263xmail.com ([211.150.70.200]:60182 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239978AbhCBA6A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Mar 2021 19:58:00 -0500
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id A9F0B1D3C;
        Tue,  2 Mar 2021 08:51:23 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.31.83] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P4300T140473058449152S1614646282848643_;
        Tue, 02 Mar 2021 08:51:23 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <70828379c4121a288f7204a3ec28ee66>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v5 1/2] dt-bindings: rockchip: Add DesignWare based PCIe
 controller
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <20210222071721.30062-1-xxm@rock-chips.com>
From:   xxm <xxm@rock-chips.com>
Message-ID: <18d65524-e18f-fac6-cd11-1cd7b6bc6dd9@rock-chips.com>
Date:   Tue, 2 Mar 2021 08:51:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210222071721.30062-1-xxm@rock-chips.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

Any new comments to the patch V5?

ÔÚ 2021/2/22 15:17, Simon Xue Ð´µÀ:
> Document DT bindings for PCIe controller found on Rockchip SoC.
>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> ---
>   .../bindings/pci/rockchip-dw-pcie.yaml        | 141 ++++++++++++++++++
>   1 file changed, 141 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> new file mode 100644
> index 000000000000..142bbe577763
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -0,0 +1,141 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DesignWare based PCIe controller on Rockchip SoCs
> +
> +maintainers:
> +  - Shawn Lin <shawn.lin@rock-chips.com>
> +  - Simon Xue <xxm@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |+
> +  RK3568 SoC PCIe host controller is based on the Synopsys DesignWare
> +  PCIe IP and thus inherits all the common properties defined in
> +  designware-pcie.txt.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +# We need a select here so we don't match all nodes with 'snps,dw-pcie'
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: rockchip,rk3568-pcie
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: rockchip,rk3568-pcie
> +      - const: snps,dw-pcie
> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers
> +      - description: Rockchip designed configuration registers
> +      - description: Config registers
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: apb
> +      - const: config
> +
> +  clocks:
> +    items:
> +      - description: AHB clock for PCIe master
> +      - description: AHB clock for PCIe slave
> +      - description: AHB clock for PCIe dbi
> +      - description: APB clock for PCIe
> +      - description: Auxiliary clock for PCIe
> +
> +  clock-names:
> +    items:
> +      - const: aclk_mst
> +      - const: aclk_slv
> +      - const: aclk_dbi
> +      - const: pclk
> +      - const: aux
> +
> +  msi-map: true
> +
> +  num-lanes: true
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: pcie-phy
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ranges:
> +    maxItems: 2
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: pipe
> +
> +  vpcie3v3-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - msi-map
> +  - num-lanes
> +  - phys
> +  - phy-names
> +  - power-domains
> +  - resets
> +  - reset-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie3x2: pcie@fe280000 {
> +            compatible = "rockchip,rk3568-pcie", "snps,dw-pcie";
> +            reg = <0x3 0xc0800000 0x0 0x390000>,
> +                  <0x0 0xfe280000 0x0 0x10000>,
> +                  <0x3 0x80000000 0x0 0x100000>;
> +            reg-names = "dbi", "apb", "config";
> +            bus-range = <0x20 0x2f>;
> +            clocks = <&cru 143>, <&cru 144>,
> +                     <&cru 145>, <&cru 146>,
> +                     <&cru 147>;
> +            clock-names = "aclk_mst", "aclk_slv",
> +                          "aclk_dbi", "pclk",
> +                          "aux";
> +            device_type = "pci";
> +            linux,pci-domain = <2>;
> +            max-link-speed = <2>;
> +            msi-map = <0x2000 &its 0x2000 0x1000>;
> +            num-lanes = <2>;
> +            phys = <&pcie30phy>;
> +            phy-names = "pcie-phy";
> +            power-domains = <&power 15>;
> +            ranges = <0x81000000 0x0 0x80800000 0x3 0x80800000 0x0 0x100000>,
> +                     <0x83000000 0x0 0x80900000 0x3 0x80900000 0x0 0x3f700000>;
> +            resets = <&cru 193>;
> +            reset-names = "pipe";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +        };
> +    };
> +...


