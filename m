Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AB21C8DD4
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 16:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgEGOJS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 10:09:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33146 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgEGOJL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 10:09:11 -0400
Received: by mail-ot1-f66.google.com with SMTP id j26so4561339ots.0;
        Thu, 07 May 2020 07:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zxy1VYlySamy/54ZCy3MVykfYMPHma2/B2G6ctk5KFo=;
        b=WlkgoTSi0oSdWNkyJ7Fh7up4AXvG28RaJqYRJo+eDsQ/bzV6BwVSKkpsQYoLwpok4D
         AUITi43Xj36nB7mfijZeayI74cf4tiYY4RK2qLpG3OJDK/4vmelML2RIqEQf0Adre/Pk
         kRepMupYJeFYqGWMiRUvJPyPOjHMB0voWMI4Twt7XEQnC/oVbeNPNULXh8o4nsj3Ht6v
         naUKUubPixZUZ3gnCO7Xx5zBO+nMdyNMfSoc2Y4+8vE6/XRHUAGO/DhyYozsDtkS9aRr
         BJ5kD9zmga9pWiSJgBrSZk/M1DbusKSP35KDqfYft8ZgZUSLwQPtpKpu/rOrqgjuVgcu
         pbqA==
X-Gm-Message-State: AGi0PuY+hJ00mqg5WrpDot96iErIdRlWVmAuwI7webboub2ASisXolnA
        2JuvKvnQravfv57onorY5g==
X-Google-Smtp-Source: APiQypKuEb23tqT5lHsR9WW8dsCVzi95vv3SvgIuptykvvHFTCJe8uyjd1G5ZZJOCUu2wxRqWspPqw==
X-Received: by 2002:a05:6830:30b8:: with SMTP id g24mr10356153ots.225.1588860550347;
        Thu, 07 May 2020 07:09:10 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r67sm1380336oie.19.2020.05.07.07.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 07:09:09 -0700 (PDT)
Received: (nullmailer pid 4842 invoked by uid 1000);
        Thu, 07 May 2020 14:09:08 -0000
Date:   Thu, 7 May 2020 09:09:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, William Wu <william.wu@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 4/6] dt-bindings: rockchip: Add DesignWare based PCIe
 controller
Message-ID: <20200507140908.GA22326@bogus>
References: <1581574091-240890-1-git-send-email-shawn.lin@rock-chips.com>
 <1581574091-240890-5-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581574091-240890-5-git-send-email-shawn.lin@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 13, 2020 at 02:08:09PM +0800, Shawn Lin wrote:
> From: Simon Xue <xxm@rock-chips.com>
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - fix yaml format
> 
>  .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  | 148 +++++++++++++++++++++
>  1 file changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> new file mode 100644
> index 0000000..527c770
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -0,0 +1,148 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DesignWare based PCIe RC controller on Rockchip SoCs
> +
> +maintainers:
> +  - Shawn Lin <shawn.lin@rock-chips.com>
> +  - Simon Xue <xxm@rock-chips.com>
> +
> +# We need a select here so we don't match all nodes with 'snps,dw-pcie'
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: rockchip,rk1808-pcie
> +  required:
> +    - compatible
> +

Need to reference pci-bus.yaml.

> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk1808-pcie
> +      - snps,dw-pcie

Doesn't match the example. This says 1 string that either of the 2 
strings.

> +
> +  reg:
> +    maxItems: 1

Example shows 2. If so, need to define here what each one is.

> +
> +  clocks:
> +    items:
> +      - description: High speed clock for PCIe
> +      - description: Low speed clock for PCIe
> +      - description: AHB clock for PCIe
> +      - description: APB clock for PCIe
> +      - description: Auxiliary clock for PCIe
> +
> +  clock-names:
> +    items:
> +      - const: hsclk
> +      - const: lsclk
> +      - const: aclk
> +      - const: pclk
> +      - const: sclk-aux
> +
> +  resets:
> +    items:
> +      - description: PCIe niu high reset line
> +      - description: PCIe niu low reset line
> +      - description: PCIe grf reset line
> +      - description: PCIe control reset line
> +      - description: PCIe control powerup reset line
> +      - description: PCIe control master reset line
> +      - description: PCIe control slave reset line
> +      - description: PCIe control dbi reset line
> +      - description: PCIe control button reset line
> +      - description: PCIe control power engine reset line
> +      - description: PCIe control core reset line
> +      - description: PCIe control non-sticky reset line
> +      - description: PCIe control sticky reset line
> +      - description: PCIe control power reset line
> +      - description: PCIe niu ahb reset line
> +      - description: PCIe niu apb reset line
> +
> +  reset-names:
> +    items:
> +      - const: niu-h
> +      - const: niu-l
> +      - const: grf-p
> +      - const: ctl-p
> +      - const: ctl-powerup
> +      - const: ctl-mst-a
> +      - const: ctl-slv-a
> +      - const: ctl-dbi-a
> +      - const: ctl-button
> +      - const: ctl-pe
> +      - const: ctl-core
> +      - const: ctl-nsticky
> +      - const: ctl-sticky
> +      - const: ctl-pwr
> +      - const: ctl-niu-a
> +      - const: ctl-niu-p
> +
> +  rockchip,usbpciegrf:
> +    enum:
> +      - rockchip,usbpciegrf
> +    description: The grf for COMBPHY configuration and state registers.

COMBOPHY?

Why isn't this part of the phy node?

> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - reg
> +  - clocks
> +  - clock-names
> +  - msi-map
> +  - num-lanes
> +  - phys
> +  - phy-names
> +  - ranges
> +  - resets
> +  - reset-names
> +  - rockchip,usbpciegrf
> +  - reset-gpios
> +
> +additionalProperties: false

With pci-bus.yaml included, this will have to be 
'unevaluatedProperties: false'.

> +
> +examples:
> +  - |
> +    pcie0: pcie@fc400000 {

Unit address should be first entry in 'reg'.

> +      compatible = "rockchip,rk1808-pcie", "snps,dw-pcie";
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      bus-range = <0x0 0x1f>;
> +      reg = <0x0 0xfc000000 0x0 0x400000>,
> +            <0x0 0xfc400000 0x0 0x10000>;
> +      clocks = <&cru HSCLK_PCIE>, <&cru LSCLK_PCIE>,
> +               <&cru ACLK_PCIE>, <&cru PCLK_PCIE>,
> +               <&cru SCLK_PCIE_AUX>;
> +      clock-names = "hsclk", "lsclk",
> +                    "aclk", "pclk",
> +                    "sclk-aux";
> +      msi-map = <0x0 &its 0x0 0x1000>;
> +      num-lanes = <2>;
> +      phys = <&combphy PHY_TYPE_PCIE>;

Not documented.

> +      phy-names = "pcie-phy";

Not documented. Not really needed if only 1.

> +      ranges = <0x00000800 0x0 0xf8000000 0x0 0xf8000000 0x0 0x800000
> +                0x83000000 0x0 0xf8800000 0x0 0xf8800000 0x0 0x3700000
> +                0x81000000 0x0 0xfbf00000 0x0 0xfbf00000 0x0 0x100000>;
> +      resets = <&cru SRST_PCIE_NIU_H>, <&cru SRST_PCIE_NIU_L>,
> +               <&cru SRST_PCIEGRF_P>, <&cru SRST_PCIECTL_P>,
> +               <&cru SRST_PCIECTL_POWERUP>, <&cru SRST_PCIECTL_MST_A>,
> +               <&cru SRST_PCIECTL_SLV_A>, <&cru SRST_PCIECTL_DBI_A>,
> +               <&cru SRST_PCIECTL_BUTTON>, <&cru SRST_PCIECTL_PE>,
> +               <&cru SRST_PCIECTL_CORE>, <&cru SRST_PCIECTL_NSTICKY>,
> +               <&cru SRST_PCIECTL_STICKY>, <&cru SRST_PCIECTL_PWR>,
> +               <&cru SRST_PCIE_NIU_A>, <&cru SRST_PCIE_NIU_P>;
> +      reset-names = "niu-h", "niu-l", "grf-p", "ctl-p",
> +                    "ctl-powerup", "ctl-mst-a", "ctl-slv-a",
> +                    "ctl-dbi-a", "ctl-button", "ctl-pe",
> +                    "ctl-core", "ctl-nsticky", "ctl-sticky",
> +                    "ctl-pwr", "ctl-niu-a", "ctl-niu-p";
> +      rockchip,usbpciegrf = <&usb_pcie_grf>;
> +      reset-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
> +    };
> +
> +...
> -- 
> 1.9.1
> 
> 
> 
