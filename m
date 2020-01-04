Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6831F12FF83
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2020 01:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgADAVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 19:21:55 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45193 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgADAVz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2020 19:21:55 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so43058172ioi.12
        for <linux-pci@vger.kernel.org>; Fri, 03 Jan 2020 16:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GRrMCIevFS+50QdWWWGaYeUVyp1OjoJAsbXHKCUBzfs=;
        b=rA2dVEyyIa0fKIAOyP1digNNfVzcnHP/wIBtS0WrSqgDZfH3v3E5e1JQE8D4cjmiv1
         LSXNk5Rq01yiGyXSl3nyuPGZ360NwUmqdeunN07DsyB2Ptb7vtGYc1JTOJi6hXKqSbWA
         xJuJBrUg4kO/3XTUv4z2aqvBiAU7i7o6rCw/9Olfm/dfw5osoJ15V341dR/gQMjvVZj3
         PEEhLVwmh74sH5jxcC12VT/6iICKMaYJKq+Tj5Z/0mKtP+xB7GI3kQu5dkDdcvcK0kl7
         bixEsSu6iY8ppwzXpnDuapA9gleD7I4VUxZREwq7Du59ttiIpQpVPpnRfizaR3z7YNbP
         paYQ==
X-Gm-Message-State: APjAAAUReJEFiVyp5pZfL7tSFABNsLB2zsWhk2Hh2zx8RilPFJCObqfS
        bojft7cVouiN5vSSOKiwHYMievg=
X-Google-Smtp-Source: APXvYqxyMnSJMZxpNBfwElWkzgxj2fHxrQVZsEFav1BWWNRS+nSVJrS2PRj1jFR5242AHsnsUqfudw==
X-Received: by 2002:a5d:9041:: with SMTP id v1mr51974709ioq.303.1578097314031;
        Fri, 03 Jan 2020 16:21:54 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n22sm15228727iog.14.2020.01.03.16.21.52
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:21:53 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a5
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 17:21:52 -0700
Date:   Fri, 3 Jan 2020 17:21:52 -0700
From:   Rob Herring <robh@kernel.org>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: PCI: meson: Update PCIE bindings
 documentation
Message-ID: <20200104002152.GA32487@bogus>
References: <20191224173942.18160-1-repk@triplefau.lt>
 <20191224173942.18160-5-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224173942.18160-5-repk@triplefau.lt>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 24, 2019 at 06:39:41PM +0100, Remi Pommarel wrote:
> Now that a new PHYs has been introduced for AXG SoC family, update
> dt bindings documentation.

This breaks compatibility. If that's okay, say so and why it is.

If only someone had said putting the phy here in the first place was 
wrong:

https://lore.kernel.org/linux-amlogic/20180829004122.GA25928@bogus/

> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  .../bindings/pci/amlogic,meson-pcie.txt       | 22 ++++++++-----------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> index 84fdc422792e..b6acbe694ffb 100644
> --- a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> @@ -18,7 +18,6 @@ Required properties:
>  - reg-names: Must be
>  	- "elbi"	External local bus interface registers
>  	- "cfg"		Meson specific registers
> -	- "phy"		Meson PCIE PHY registers for AXG SoC Family
>  	- "config"	PCIe configuration space
>  - reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
>  - clocks: Must contain an entry for each entry in clock-names.
> @@ -26,13 +25,13 @@ Required properties:
>  	- "pclk"       PCIe GEN 100M PLL clock
>  	- "port"       PCIe_x(A or B) RC clock gate
>  	- "general"    PCIe Phy clock
> -	- "mipi"       PCIe_x(A or B) 100M ref clock gate for AXG SoC Family
>  - resets: phandle to the reset lines.
> -- reset-names: must contain "phy" "port" and "apb"
> -       - "phy"         Share PHY reset for AXG SoC Family
> +- reset-names: must contain "port" and "apb"
>         - "port"        Port A or B reset
>         - "apb"         Share APB reset
> -- phys: should contain a phandle to the shared phy for G12A SoC Family
> +- phys: should contain a phandle to the PCIE phy
> +- phy-names: must contain "pcie"
> +
>  - device_type:
>  	should be "pci". As specified in designware-pcie.txt
>  
> @@ -43,9 +42,8 @@ Example configuration:
>  			compatible = "amlogic,axg-pcie", "snps,dw-pcie";
>  			reg = <0x0 0xf9800000 0x0 0x400000
>  					0x0 0xff646000 0x0 0x2000
> -					0x0 0xff644000 0x0 0x2000
>  					0x0 0xf9f00000 0x0 0x100000>;
> -			reg-names = "elbi", "cfg", "phy", "config";
> +			reg-names = "elbi", "cfg", "config";
>  			reset-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
>  			interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
>  			#interrupt-cells = <1>;
> @@ -58,17 +56,15 @@ Example configuration:
>  			ranges = <0x82000000 0 0 0x0 0xf9c00000 0 0x00300000>;
>  
>  			clocks = <&clkc CLKID_USB
> -					&clkc CLKID_MIPI_ENABLE
>  					&clkc CLKID_PCIE_A
>  					&clkc CLKID_PCIE_CML_EN0>;
>  			clock-names = "general",
> -					"mipi",
>  					"pclk",
>  					"port";
> -			resets = <&reset RESET_PCIE_PHY>,
> -				<&reset RESET_PCIE_A>,
> +			resets = <&reset RESET_PCIE_A>,
>  				<&reset RESET_PCIE_APB>;
> -			reset-names = "phy",
> -					"port",
> +			reset-names = "port",
>  					"apb";
> +			phys = <&pcie_phy>;
> +			phy-names = "pcie";
>  	};
> -- 
> 2.24.0
> 
