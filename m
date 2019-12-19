Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA34D127190
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 00:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfLSXfa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 18:35:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39977 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLSXf3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 18:35:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id w21so1567300otj.7;
        Thu, 19 Dec 2019 15:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RRqDAkLWobOuOYSCFG7J0bbEa5xYLcQverv9nWpPuIA=;
        b=NloW0NIe8rSvYLdL5vThD/P9xy0DF/fAVISnCid+T7rbCfrIY39tgOTfB9z2AxAjEz
         M3RWNRv7Auysp8jBnlZAKEYwzwU4/ELqCNppHMHt3LX/zjh6RVj0My48m5kaVBxjdkmV
         +568c5/rs9md5QdL48C4CESZwkcTvC5z3fI3RB+0GX6fnT/16me2LL78LErMH9oigzbp
         JvYg9xX0aJj8HyUDl/9EDdJwYtp5uyHEoGAAnn5otOjJ4A2nH7nlO2aigQLeJHHDylYw
         MQAWIlj/H1Fgh5kzfS0sQjA6Rp+KSS48GGL9W0InVRFJ7dLtFZ21p1QxRaex+mLO750J
         nDOQ==
X-Gm-Message-State: APjAAAXULZl4fCB1m1tjWhrWu5qX/xrQpgSWCzXzGpO4xvDn6nr1pMaR
        mAmAVWrFS69ulFu0clafvA==
X-Google-Smtp-Source: APXvYqzP7ZyQmIJlVYu5boWchd07kvVVJcGu77F6fpUDlaRoVSLg9EHtJ3yKHNipgk1av59pNOCtIg==
X-Received: by 2002:a9d:7b4e:: with SMTP id f14mr11756439oto.355.1576798528860;
        Thu, 19 Dec 2019 15:35:28 -0800 (PST)
Received: from localhost (ip-184-205-174-147.ftwttx.spcsdns.net. [184.205.174.147])
        by smtp.gmail.com with ESMTPSA id m68sm2525707oig.50.2019.12.19.15.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 15:35:27 -0800 (PST)
Date:   Thu, 19 Dec 2019 17:35:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [v2 4/6] dt-bindings: PCI: rcar: Add bindings for R-Car PCIe
 endpoint controller
Message-ID: <20191219233525.GA9478@bogus>
References: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191213084748.11210-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213084748.11210-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 13, 2019 at 08:47:46AM +0000, Lad Prabhakar wrote:
> From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> This patch adds the bindings for the R-Car PCIe endpoint driver.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../devicetree/bindings/pci/rcar-pci-ep.txt        | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.txt

Please make this a DT schema.

> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
> new file mode 100644
> index 0000000..7f0a97e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
> @@ -0,0 +1,37 @@
> +* Renesas R-Car PCIe Endpoint Controller DT description
> +
> +Required properties:
> +	    "renesas,pcie-ep-r8a774c0" for the R8A774C0 SoC;

Normal ordering is: renesas,r8a774c0-pcie-ep

> +	    "renesas,pcie-ep-rcar-gen3" for a generic R-Car Gen3 or
> +				     RZ/G2 compatible device.
> +
> +	    When compatible with the generic version, nodes must list the
> +	    SoC-specific version corresponding to the platform first
> +	    followed by the generic version.
> +
> +- reg: base address and length of the PCIe controller registers.
> +- outbound-ranges: outbound windows base address and length including the flags.
> +- resets: Must contain phandles to PCIe-related reset lines exposed by IP block

How many?

> +- clocks: from common clock binding: clock specifiers for the PCIe controller
> +	 clock.
> +- clock-names: from common clock binding: should be "pcie".
> +
> +Optional Property:
> +- max-functions: Maximum number of functions that can be configured (default 1).
> +
> +Example:
> +
> +SoC-specific DT Entry:
> +
> +	pcie_ep: pcie_ep@fe000000 {

pcie-ep@ 

> +		compatible = "renesas,pcie-ep-r8a774c0", "renesas,pcie-rcar-gen2";
> +		reg = <0 0xfe000000 0 0x80000>;
> +		outbound-ranges = <0xa 0x0 0xfe100000 0 0x000100000
> +				   0xa 0x0 0xfe200000 0 0x000200000
> +				   0x6 0x0 0x30000000 0 0x008000000
> +				   0x6 0x0 0x38000000 0 0x008000000>;
> +		clocks = <&cpg CPG_MOD 319>;
> +		clock-names = "pcie";
> +		power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
> +		resets = <&cpg 319>;
> +	};
> -- 
> 2.7.4
> 
