Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 169E113B614
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 00:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgANXn1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 18:43:27 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33390 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbgANXn1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 18:43:27 -0500
Received: by mail-oi1-f193.google.com with SMTP id v140so13693436oie.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2020 15:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MKlK2szQ42loiytEFafzt++ib8OsDGlgenNJAhJSpmM=;
        b=YX4YS38KOadsiu0C63fK4/bzwzNja58odJObRAqwEB49NxP7iPtbDOg/0b4w2G/cBS
         NxxkEXVzIce3X39cr9kkLwiWgUdW7nig7N+u/F3qU9l0NiPIbv0e4FcoSrJV+Gvghro5
         jJ4fB8BUPuX98N5pf+fGG8bh+iXyyhLcjZPa7eb8EqjnTk/UlkE1mHD0WOqE2ScWUERw
         ghhkqmRK9g0sbhICKXGR4itE4ltTpE3/03wzCzIaMmag//mJXeP1CT0Fe7sesH45oHNb
         BTY2qtiK2KipvWK/I68o3B+zx3j++pbjc+fiS+iwGERulPlES7mgqI9mA1ZiKYQPtOjG
         yoHQ==
X-Gm-Message-State: APjAAAVFm6jAyt+MTl3TeEJcmQvZcdg2fW72NRz05XDuwTLNwulAy+1v
        raJil3s/dnvnNmXoBtBP7+VopDI=
X-Google-Smtp-Source: APXvYqw/sj5DKhQDJuiNcFpohCk2vK9s75UO8UlX5sybHMgcS8cM09mapgRbzN79T/c/FVpvah80Qw==
X-Received: by 2002:aca:39d6:: with SMTP id g205mr17563211oia.122.1579045405559;
        Tue, 14 Jan 2020 15:43:25 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n2sm5090234oia.58.2020.01.14.15.43.24
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 15:43:24 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220a2e
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 17:43:23 -0600
Date:   Tue, 14 Jan 2020 17:43:23 -0600
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
Subject: Re: [PATCH 1/6] dt-bindings: add binding for Rockchip combo phy
 using an Innosilicon IP
Message-ID: <20200114234323.GA5823@bogus>
References: <1578986580-71974-1-git-send-email-shawn.lin@rock-chips.com>
 <1578986580-71974-2-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578986580-71974-2-git-send-email-shawn.lin@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 03:22:55PM +0800, Shawn Lin wrote:
> This IP could supports USB3.0 and PCIe.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
>  .../bindings/phy/rockchip,inno-combophy.yaml       | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml

Fails 'make dt_binding_check':

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml: 
ignoring, error in schema: properties: rockchip,combphygrf
Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: 
Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml: 
properties:rockchip,combphygrf: {'items': [{'description': 'The grf for 
COMBPHY configuration and state registers.'}]} is not valid under any of 
the given schemas (Possible causes of the failure):
	
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml: 
properties:rockchip,combphygrf: 'description' is a required property


> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml
> new file mode 100644
> index 0000000..d647ab3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rockchip,inno-combophy.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/rockchip,inno-combophy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip USB3.0/PCI-e combo phy
> +
> +maintainers:
> +        - Shawn Lin <shawn.lin@rock-chips.com>
> +        - William Wu <william.wu@rock-chips.com>

2 space indent.

> +
> +properties:
> +  "#phy-cells":
> +    const: 1
> +
> +  compatible:
> +    enum:
> +      - rockchip,rk1808-combphy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PLL reference clock
> +
> +  clock-names:
> +    items:
> +      - const: refclk
> +
> +  resets:
> +    items:
> +      - description: OTG unit reset line
> +      - description: POR unit reset line
> +      - description: APB interface reset line
> +      - description: PIPE unit reset line
> +
> +  reset-names:
> +    items:
> +      - const: otg-rst
> +      - const: combphy-por
> +      - const: combphy-apb
> +      - const: combphy-pipe
> +
> +  rockchip,combphygrf:
> +    items:
> +      - description: The grf for COMBPHY configuration and state registers.
> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - rockchip,combphygrf
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    combphy_grf: syscon@fe018000 {
> +        compatible = "rockchip,usb3phy-grf", "syscon";
> +        reg = <0x0 0xfe018000 0x0 0x8000>;
> +    };
> +
> +    combphy: phy@ff380000 {
> +        compatible = "rockchip,rk1808-combphy";
> +        reg = <0x0 0xff380000 0x0 0x10000>;
> +        #phy-cells = <1>;
> +        clocks = <&cru SCLK_PCIEPHY_REF>;
> +        clock-names = "refclk";
> +        assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
> +        assigned-clock-rates = <25000000>;
> +        resets = <&cru SRST_USB3_OTG_A>, <&cru SRST_PCIEPHY_POR>,
> +                 <&cru SRST_PCIEPHY_P>, <&cru SRST_PCIEPHY_PIPE>;
> +        reset-names = "otg-rst", "combphy-por",
> +                      "combphy-apb", "combphy-pipe";
> +        rockchip,combphygrf = <&combphy_grf>;
> +    };
> +
> +...
> -- 
> 1.9.1
> 
> 
> 
