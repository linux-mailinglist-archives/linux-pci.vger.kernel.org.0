Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 461C713B652
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 01:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgAOAFF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 19:05:05 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41179 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgAOAFF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 19:05:05 -0500
Received: by mail-oi1-f195.google.com with SMTP id i1so13690586oie.8
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2020 16:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6InMAA6tVFUJhW/7SSG7pRmKfUrz13sPRb9GJnKNkk8=;
        b=WbLrCK3LTYPe0zmqYwyEdoOZwihMhq5EcNsCToHqzw57EF60q3A754ByPdHs48jOae
         o5a1eJt0f9scOQ4AtM8IpR3L1STnpVyUnIaw7IwKwsa4+EpkpEr0VnoHcJZ3BSxzdVVl
         yEmHsyR8Q+pO2Ebp9m2oMYKtolIdImWQBAnSd8/xOueFW/OUbpFzTASNUUgjoMBeQES/
         8zjl7NMTVbd/D4TmMeWxmCi7gwwTPJNQijVS7FecGRzuPq8ErpVr5RzhBgJXONo2WE2w
         nvog1fOaiU+vuEE+d0rwAMWwbAu5tBvhHA1HYfgNY5qqnOOi7srIpI+lEuGqirTuhc24
         3bmQ==
X-Gm-Message-State: APjAAAU+P+znH11NxN5R8+D9mDWD+SI6HDD1PSnqJXFqpdYHVVK7hz/H
        oxSCfyaJ5Ncx85Yxo67+y1pgMO0=
X-Google-Smtp-Source: APXvYqzV5K/ET8cGH4dFw0VgculfnvRwTVjHOBPIslnrFdQpLOgLIh+7JJXumOvTtzduPVUIKtt7+w==
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr17857047oij.66.1579046703739;
        Tue, 14 Jan 2020 16:05:03 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p21sm5988702otc.21.2020.01.14.16.05.02
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 16:05:02 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220a2e
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 18:05:02 -0600
Date:   Tue, 14 Jan 2020 18:05:02 -0600
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
Subject: Re: [PATCH 4/6] dt-bindings: rockchip: Add DesignWare based PCIe
 controller
Message-ID: <20200115000502.GA27530@bogus>
References: <1578986580-71974-1-git-send-email-shawn.lin@rock-chips.com>
 <1578986580-71974-5-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578986580-71974-5-git-send-email-shawn.lin@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 03:22:58PM +0800, Shawn Lin wrote:
> From: Simon Xue <xxm@rock-chips.com>
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  | 132 +++++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml: 
properties:rockchip,usbpciegrf: {'items': [{'description': 'The grf for 
COMBPHY configuration and state registers.'}]} is not valid under any of 
the given schemas (Possible causes of the failure):
	
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml: 
properties:rockchip,usbpciegrf: 'description' is a required property

> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> new file mode 100644
> index 0000000..c5205f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -0,0 +1,132 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DesignWare based PCIe RC controller on Rockchip SoCs
> +
> +maintainers:
> +        - Shawn Lin <shawn.lin@rock-chips.com>
> +        - Simon Xue <xxm@rock-chips.com>

indent 2 spaces.

> +

You need to reference pci-bus.yaml.

> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk1808-pcie
> +      - snps,dw-pcie

This means the compatible is one of these 2 strings.

It's also going to be a problem because it will match on all DTs with 
'snps,dw-pcie'. Look at some of the 'arm,primecell' schema for how to 
avoid that with 'select'.

> +
> +  reg:
> +    maxItems: 2
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
> +    items:
> +      - description: The grf for COMBPHY configuration and state registers.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - msi-map
> +  - num-lanes
> +  - phys
> +  - phy-names
> +  - resets
> +  - reset-names
> +  - rockchip,usbpciegrf
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usb_pcie_grf: syscon@fe040000 {
> +        compatible = "rockchip,usb-pcie-grf", "syscon";
> +        reg = <0x0 0xfe040000 0x0 0x1000>;
> +    };
> +
> +    pcie0: pcie@fc400000 {
> +        compatible = "rockchip,rk1808-pcie", "snps,dw-pcie";
> +        reg = <0x0 0xfc000000 0x0 0x400000>,
> +              <0x0 0xfc400000 0x0 0x10000>;
> +        clocks = <&cru HSCLK_PCIE>, <&cru LSCLK_PCIE>,
> +                 <&cru ACLK_PCIE>, <&cru PCLK_PCIE>,
> +                 <&cru SCLK_PCIE_AUX>;
> +        clock-names = "hsclk", "lsclk",
> +                      "aclk", "pclk",
> +                      "sclk-aux";
> +        msi-map = <0x0 &its 0x0 0x1000>;
> +        num-lanes = <2>;
> +        phys = <&combphy PHY_TYPE_PCIE>;
> +        phy-names = "pcie-phy";
> +        resets = <&cru SRST_PCIE_NIU_H>, <&cru SRST_PCIE_NIU_L>,
> +                 <&cru SRST_PCIEGRF_P>, <&cru SRST_PCIECTL_P>,
> +                 <&cru SRST_PCIECTL_POWERUP>, <&cru SRST_PCIECTL_MST_A>,
> +                 <&cru SRST_PCIECTL_SLV_A>, <&cru SRST_PCIECTL_DBI_A>,
> +                 <&cru SRST_PCIECTL_BUTTON>, <&cru SRST_PCIECTL_PE>,
> +                 <&cru SRST_PCIECTL_CORE>, <&cru SRST_PCIECTL_NSTICKY>,
> +                 <&cru SRST_PCIECTL_STICKY>, <&cru SRST_PCIECTL_PWR>,
> +                 <&cru SRST_PCIE_NIU_A>, <&cru SRST_PCIE_NIU_P>;
> +        reset-names = "niu-h", "niu-l", "grf-p", "ctl-p",
> +                      "ctl-powerup", "ctl-mst-a", "ctl-slv-a",
> +                      "ctl-dbi-a", "ctl-button", "ctl-pe",
> +                      "ctl-core", "ctl-nsticky", "ctl-sticky",
> +                      "ctl-pwr", "ctl-niu-a", "ctl-niu-p";
> +        rockchip,usbpciegrf = <&usb_pcie_grf>;

You are missing a number of common, required PCI properties.

> +    };
> +
> +...
> -- 
> 1.9.1
> 
> 
> 
