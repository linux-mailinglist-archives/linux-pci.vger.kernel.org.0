Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E089C32DF08
	for <lists+linux-pci@lfdr.de>; Fri,  5 Mar 2021 02:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCEBW4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 4 Mar 2021 20:22:56 -0500
Received: from mail-il1-f173.google.com ([209.85.166.173]:37406 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCEBW4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Mar 2021 20:22:56 -0500
Received: by mail-il1-f173.google.com with SMTP id k2so517722ili.4;
        Thu, 04 Mar 2021 17:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=5dXDTIfniutS6uzqjw8zBJUQTlzR7ceI5gHS7+10y1M=;
        b=AbfxJVMsljnw4reT9RFpFlE6sVIriQF2s9AD0HVmzGkquqK+lNAV55YWz6HgpXIRhl
         30zb0ALbQgZWX7e+1qNEWNt4mMEqk+LK83oghrxKSCU1Qw3m4oYEvle7MZYsoxaZZk25
         o8OTtcYFdcLOvLYj7yIQbcwMlOVhJ+J91an8YTtVThgIAVEL24wa/UahxNsi2xGPWJeb
         yTzF5jgE2ZHn+/CWJ1vI1lwH2jgeuXT/Nke9gw+lOj3AGegY6XshpB+ph+gm3XJH9uSu
         Wl19CVpXEQA6FH8ICEJRFa8gW2lVDBpLayK3vrsoIkfzdVPH/vVA8av6y82712RK6WRx
         2dZQ==
X-Gm-Message-State: AOAM5300N7an4r5hMTmWZeRQ7xSTTJgJyjxf7VyLWEgl9TMkdMhn/Oc6
        VT/gWPal+aG0JK1XYL5qv8Wj3SSTvbY7tUVjfu8=
X-Google-Smtp-Source: ABdhPJyBJNX2lvdeKFiZMA8i5B5MbXNiLK+oZiDgsRWUuLcCFKXVEWhYFwRK/nMFIpYmQL+/XcHcmkebdmFiLdCC3mw=
X-Received: by 2002:a05:6e02:1d0e:: with SMTP id i14mr5918179ila.69.1614907375650;
 Thu, 04 Mar 2021 17:22:55 -0800 (PST)
MIME-Version: 1.0
From:   Kever Yang <kever.yang@rock-chips.com>
Date:   Fri, 5 Mar 2021 09:22:44 +0800
Message-ID: <CAKUh=RxtV0Ji6iw2Awh=2B0NRG4ZTafh5PsXTjyQiDEiHR7j9w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: rockchip: Add DesignWare based PCIe controller
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-pci@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simon Xue <xxm@rock-chips.com> 于2021年2月22日周一 下午3:17写道：
>
> Document DT bindings for PCIe controller found on Rockchip SoC.
>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>

Patch looks good to me.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml        | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
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
> --
> 2.25.1
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
>
>
