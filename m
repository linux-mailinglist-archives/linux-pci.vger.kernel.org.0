Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59B03C6221
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 19:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbhGLRr7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 13:47:59 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:34657 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhGLRr6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 13:47:58 -0400
Received: by mail-il1-f173.google.com with SMTP id e13so20460331ilc.1;
        Mon, 12 Jul 2021 10:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ajatf6nQwEZ59cgaPAdaASubAC/UcMPkKKVknAE5bvM=;
        b=UOrhL9WFjK9Og7nV3L3vTiCCFzpDqyGAGopFpFEb7xD7q0AIc8c4jvv2GX/fajgsKX
         5OuWfyndm3dHJp0B28FGqtrIVGH+H0cMQp9w+XfORIyRpKlrrnChpNviVNATxhIO902H
         8XJP0tbnZVyj+DSV7zb+okAqffwQ8sqZhQY8o9nN3iChBqtB+gvH3hV0KhUD4+4sGcHp
         WaLK2Xu0R1AHxo2Z1yKALH/Dhh1uQxDiQzzRDNXxtCiiNTd3c6d7elPMWSjdtMz6HQ4o
         1uU25yHFgXpDsmJh29ezjrb07GzApi0e0Z16bILlo+Cn/jn8WbuXc070EkYMUQp0syT4
         n1Rw==
X-Gm-Message-State: AOAM531C2OGyJfv+IxOBaqTBhGkWzsmLdm5Q9qRC+wnkKxsnH8NQvcgX
        d/uzQWvHvapdb5acu9ruvg==
X-Google-Smtp-Source: ABdhPJz+gM/VO4P/82jsvkZWlHe7Tbh91b89uvKUK6Unkmnu28V43rFcrXtWt/sWhVVdbHLLVtcvbw==
X-Received: by 2002:a92:6d03:: with SMTP id i3mr41675ilc.66.1626111908570;
        Mon, 12 Jul 2021 10:45:08 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n13sm8436717ilq.5.2021.07.12.10.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 10:45:07 -0700 (PDT)
Received: (nullmailer pid 2178008 invoked by uid 1000);
        Mon, 12 Jul 2021 17:45:04 -0000
Date:   Mon, 12 Jul 2021 11:45:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: designware-pcie.txt: convert it
 to yaml
Message-ID: <20210712174504.GA2158814@robh.at.kernel.org>
References: <cover.1625838920.git.mchehab+huawei@kernel.org>
 <fa846c83165894accdac1715c3fddfbdcb060958.1625838920.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa846c83165894accdac1715c3fddfbdcb060958.1625838920.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 09, 2021 at 03:57:42PM +0200, Mauro Carvalho Chehab wrote:
> Convert the file to DT schema.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/pci/amlogic,meson-pcie.txt       |   4 +-
>  .../bindings/pci/axis,artpec6-pcie.txt        |   2 +-
>  .../bindings/pci/designware-pcie.txt          |  77 ----------
>  .../bindings/pci/fsl,imx6q-pcie.txt           |   2 +-
>  .../bindings/pci/hisilicon-histb-pcie.txt     |   2 +-
>  .../devicetree/bindings/pci/kirin-pcie.txt    |   2 +-
>  .../bindings/pci/layerscape-pci.txt           |   2 +-
>  .../bindings/pci/nvidia,tegra194-pcie.txt     |   4 +-
>  .../devicetree/bindings/pci/pci-armada8k.txt  |   2 +-
>  .../devicetree/bindings/pci/pcie-al.txt       |   2 +-
>  .../devicetree/bindings/pci/qcom,pcie.txt     |  14 +-
>  .../bindings/pci/samsung,exynos-pcie.yaml     |   2 +-
>  .../bindings/pci/sifive,fu740-pcie.yaml       |   2 +-
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 135 ++++++++++++++++++
>  .../pci/socionext,uniphier-pcie-ep.yaml       |   2 +-
>  .../devicetree/bindings/pci/ti-pci.txt        |   4 +-
>  .../devicetree/bindings/pci/uniphier-pcie.txt |   2 +-
>  MAINTAINERS                                   |   2 +-
>  18 files changed, 160 insertions(+), 102 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> index b6acbe694ffb..c3a75ac6e59d 100644
> --- a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> @@ -3,7 +3,7 @@ Amlogic Meson AXG DWC PCIE SoC controller
>  Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
>  It shares common functions with the PCIe DesignWare core driver and
>  inherits common properties defined in
> -Documentation/devicetree/bindings/pci/designware-pcie.txt.
> +Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
>  
>  Additional properties are described here:
>  
> @@ -33,7 +33,7 @@ Required properties:
>  - phy-names: must contain "pcie"
>  
>  - device_type:
> -	should be "pci". As specified in designware-pcie.txt
> +	should be "pci". As specified in snps,dw-pcie.yaml
>  
>  
>  Example configuration:
> diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
> index 979dc7b6cfe8..cc6dcdb676b9 100644
> --- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
> @@ -1,7 +1,7 @@
>  * Axis ARTPEC-6 PCIe interface
>  
>  This PCIe host controller is based on the Synopsys DesignWare PCIe IP
> -and thus inherits all the common properties defined in designware-pcie.txt.
> +and thus inherits all the common properties defined in snps,dw-pcie.yaml.
>  
>  Required properties:
>  - compatible: "axis,artpec6-pcie", "snps,dw-pcie" for ARTPEC-6 in RC mode;
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> deleted file mode 100644
> index 78494c4050f7..000000000000
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ /dev/null
> @@ -1,77 +0,0 @@
> -* Synopsys DesignWare PCIe interface
> -
> -Required properties:
> -- compatible:
> -	"snps,dw-pcie" for RC mode;
> -	"snps,dw-pcie-ep" for EP mode;
> -- reg: For designware cores version < 4.80 contains the configuration
> -       address space. For designware core version >= 4.80, contains
> -       the configuration and ATU address space
> -- reg-names: Must be "config" for the PCIe configuration space and "atu" for
> -	     the ATU address space.
> -    (The old way of getting the configuration address space from "ranges"
> -    is deprecated and should be avoided.)
> -RC mode:
> -- #address-cells: set to <3>
> -- #size-cells: set to <2>
> -- device_type: set to "pci"
> -- ranges: ranges for the PCI memory and I/O regions
> -- #interrupt-cells: set to <1>
> -- interrupt-map-mask and interrupt-map: standard PCI
> -	properties to define the mapping of the PCIe interface to interrupt
> -	numbers.
> -EP mode:
> -- num-ib-windows: number of inbound address translation windows
> -- num-ob-windows: number of outbound address translation windows
> -
> -Optional properties:
> -- num-lanes: number of lanes to use (this property should be specified unless
> -  the link is brought already up in BIOS)
> -- reset-gpio: GPIO pin number of power good signal
> -- clocks: Must contain an entry for each entry in clock-names.
> -	See ../clocks/clock-bindings.txt for details.
> -- clock-names: Must include the following entries:
> -	- "pcie"
> -	- "pcie_bus"
> -- snps,enable-cdm-check: This is a boolean property and if present enables
> -   automatic checking of CDM (Configuration Dependent Module) registers
> -   for data corruption. CDM registers include standard PCIe configuration
> -   space registers, Port Logic registers, DMA and iATU (internal Address
> -   Translation Unit) registers.
> -RC mode:
> -- num-viewport: number of view ports configured in hardware. If a platform
> -  does not specify it, the driver assumes 2.
> -- bus-range: PCI bus numbers covered (it is recommended for new devicetrees
> -  to specify this property, to keep backwards compatibility a range of
> -  0x00-0xff is assumed if not present)
> -
> -EP mode:
> -- max-functions: maximum number of functions that can be configured
> -
> -Example configuration:
> -
> -	pcie: pcie@dfc00000 {
> -		compatible = "snps,dw-pcie";
> -		reg = <0xdfc00000 0x0001000>, /* IP registers */
> -		      <0xd0000000 0x0002000>; /* Configuration space */
> -		reg-names = "dbi", "config";
> -		#address-cells = <3>;
> -		#size-cells = <2>;
> -		device_type = "pci";
> -		ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000
> -			  0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
> -		interrupts = <25>, <24>;
> -		#interrupt-cells = <1>;
> -		num-lanes = <1>;
> -	};
> -or
> -	pcie: pcie@dfc00000 {
> -		compatible = "snps,dw-pcie-ep";
> -		reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
> -		      <0xdfc01000 0x0001000>, /* IP registers 2 */
> -		      <0xd0000000 0x2000000>; /* Configuration space */
> -		reg-names = "dbi", "dbi2", "addr_space";
> -		num-ib-windows = <6>;
> -		num-ob-windows = <2>;
> -		num-lanes = <1>;
> -	};
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index de4b2baf91e8..5cee38ce711b 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -1,7 +1,7 @@
>  * Freescale i.MX6 PCIe interface
>  
>  This PCIe host controller is based on the Synopsys DesignWare PCIe IP
> -and thus inherits all the common properties defined in designware-pcie.txt.
> +and thus inherits all the common properties defined in snps,dw-pcie.yaml.
>  
>  Required properties:
>  - compatible:
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
> index 760b4d740616..5f0cf6c2fef3 100644
> --- a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
> @@ -3,7 +3,7 @@ HiSilicon STB PCIe host bridge DT description
>  The HiSilicon STB PCIe host controller is based on the DesignWare PCIe core.
>  It shares common functions with the DesignWare PCIe core driver and inherits
>  common properties defined in
> -Documentation/devicetree/bindings/pci/designware-pcie.txt.
> +Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
>  
>  Additional properties are described here:
>  
> diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> index 585aadfeafd1..3a36eeb1c434 100644
> --- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> @@ -3,7 +3,7 @@ HiSilicon Kirin SoCs PCIe host DT description
>  Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
>  It shares common functions with the PCIe DesignWare core driver and
>  inherits common properties defined in
> -Documentation/devicetree/bindings/pci/designware-pcie.txt.
> +Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
>  
>  Additional properties are described here:
>  
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 6d898dd4a8e2..f36efa73a470 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -1,7 +1,7 @@
>  Freescale Layerscape PCIe controller
>  
>  This PCIe host controller is based on the Synopsys DesignWare PCIe IP
> -and thus inherits all the common properties defined in designware-pcie.txt.
> +and thus inherits all the common properties defined in snps,dw-pcie.yaml.
>  
>  This controller derives its clocks from the Reset Configuration Word (RCW)
>  which is used to describe the PLL settings at the time of chip-reset.
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> index bd43f3c3ece4..498a7b3bd2a6 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> @@ -1,7 +1,7 @@
>  NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
>  
>  This PCIe controller is based on the Synopsis Designware PCIe IP
> -and thus inherits all the common properties defined in designware-pcie.txt.
> +and thus inherits all the common properties defined in snps,dw-pcie.yaml.
>  Some of the controller instances are dual mode where in they can work either
>  in root port mode or endpoint mode but one at a time.
>  
> @@ -22,7 +22,7 @@ Required properties:
>    property.
>  - reg-names: Must include the following entries:
>    "appl": Controller's application logic registers
> -  "config": As per the definition in designware-pcie.txt
> +  "config": As per the definition in snps,dw-pcie.yaml
>    "atu_dma": iATU and DMA registers. This is where the iATU (internal Address
>               Translation Unit) registers of the PCIe core are made available
>               for SW access.
> diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> index 7a813d0e6d63..ff25a134befa 100644
> --- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> +++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
> @@ -1,7 +1,7 @@
>  * Marvell Armada 7K/8K PCIe interface
>  
>  This PCIe host controller is based on the Synopsys DesignWare PCIe IP
> -and thus inherits all the common properties defined in designware-pcie.txt.
> +and thus inherits all the common properties defined in snps,dw-pcie.yaml.
>  
>  Required properties:
>  - compatible: "marvell,armada8k-pcie"
> diff --git a/Documentation/devicetree/bindings/pci/pcie-al.txt b/Documentation/devicetree/bindings/pci/pcie-al.txt
> index 557a5089229d..2ad1fe466eab 100644
> --- a/Documentation/devicetree/bindings/pci/pcie-al.txt
> +++ b/Documentation/devicetree/bindings/pci/pcie-al.txt
> @@ -2,7 +2,7 @@
>  
>  Amazon's Annapurna Labs PCIe Host Controller is based on the Synopsys DesignWare
>  PCI core. It inherits common properties defined in
> -Documentation/devicetree/bindings/pci/designware-pcie.txt.
> +Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
>  
>  Properties of the host controller node that differ from it are:
>  
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 0da458a051b6..1226b19b8c3d 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -33,22 +33,22 @@
>  - device_type:
>  	Usage: required
>  	Value type: <string>
> -	Definition: Should be "pci". As specified in designware-pcie.txt
> +	Definition: Should be "pci". As specified in snps,dw-pcie.yaml
>  
>  - #address-cells:
>  	Usage: required
>  	Value type: <u32>
> -	Definition: Should be 3. As specified in designware-pcie.txt
> +	Definition: Should be 3. As specified in snps,dw-pcie.yaml
>  
>  - #size-cells:
>  	Usage: required
>  	Value type: <u32>
> -	Definition: Should be 2. As specified in designware-pcie.txt
> +	Definition: Should be 2. As specified in snps,dw-pcie.yaml
>  
>  - ranges:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> -	Definition: As specified in designware-pcie.txt
> +	Definition: As specified in snps,dw-pcie.yaml
>  
>  - interrupts:
>  	Usage: required
> @@ -63,17 +63,17 @@
>  - #interrupt-cells:
>  	Usage: required
>  	Value type: <u32>
> -	Definition: Should be 1. As specified in designware-pcie.txt
> +	Definition: Should be 1. As specified in snps,dw-pcie.yaml
>  
>  - interrupt-map-mask:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> -	Definition: As specified in designware-pcie.txt
> +	Definition: As specified in snps,dw-pcie.yaml
>  
>  - interrupt-map:
>  	Usage: required
>  	Value type: <prop-encoded-array>
> -	Definition: As specified in designware-pcie.txt
> +	Definition: As specified in snps,dw-pcie.yaml
>  
>  - clocks:
>  	Usage: required
> diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> index 1810bf722350..3f49c8017c7a 100644
> --- a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> @@ -13,7 +13,7 @@ maintainers:
>  description: |+
>    Exynos5433 SoC PCIe host controller is based on the Synopsys DesignWare
>    PCIe IP and thus inherits all the common properties defined in
> -  designware-pcie.txt.
> +  snps,dw-pcie.yaml.
>  
>  allOf:
>    - $ref: /schemas/pci/pci-bus.yaml#
> diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> index b03cbb9b6602..0cc1998a9d46 100644
> --- a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> @@ -10,7 +10,7 @@ description: |+
>    SiFive FU740 PCIe host controller is based on the Synopsys DesignWare
>    PCI core. It shares common features with the PCIe DesignWare core and
>    inherits common properties defined in
> -  Documentation/devicetree/bindings/pci/designware-pcie.txt.
> +  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
>  
>  maintainers:
>    - Paul Walmsley <paul.walmsley@sifive.com>
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> new file mode 100644
> index 000000000000..de463338b6ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/snps,dw-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare PCIe interface
> +
> +maintainers:
> +  - Jingoo Han <jingoohan1@gmail.com>
> +  - Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> +
> +description: |
> +  Synopsys DesignWare PCIe host controller
> +
> +properties:
> +  compatible:
> +    anyOf:
> +      - {}
> +      - items:
> +          contains:

Drop 'contains'. 'items' schema applies to array elements whereas 
'contains' applies to an array.

> +            enum:
> +              - snps,dw-pcie
> +              - snps,dw-pcie-ep
> +
> +  reg:
> +    description: |
> +      It should contain Data Bus Interface (dbi, dbi2) registers for all
> +      versions.

Not all versions have dbi2.

> +      For designware cores version < 4.80, contains the configuration
> +      address space. For designware core version >= 4.80,
> +      contains the configuration and ATU address space.

config space should always be present. For a brief time (around 2014), 
it was not required but has been since. For purposes of the schema, we 
can say always required.

ATU is optional in 4.80 or later. 

> +    minItems: 2
> +    maxItems: 4
> +
> +  reg-names:
> +    minItems: 2
> +    maxItems: 4
> +    items:
> +      contains:

Drop contains.

> +        enum: [dbi, dbi2, config, atu, addr_space]
> +
> +  num-lanes:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: |
> +      number of lanes to use (this property should be specified unless
> +      the link is brought already up in BIOS)
> +    maxItems: 1

Drop. Not an array. 'maximum: 16' is needed though pci-bus.yaml may 
cover that already.

> +
> +  reset-gpio:
> +    description: GPIO pin number of PERST# signal
> +    maxItems: 1

deprecated: true

And add 'reset-gpios'

> +
> +  "snps,enable-cdm-check":

Don't need quotes.

> +    type: boolean
> +    description: |
> +      This is a boolean property and if present enables
> +      automatic checking of CDM (Configuration Dependent Module) registers
> +      for data corruption. CDM registers include standard PCIe configuration
> +      space registers, Port Logic registers, DMA and iATU (internal Address
> +      Translation Unit) registers.
> +
> +  num-viewport:
> +    description: |
> +      number of view ports configured in hardware. If a platform
> +      does not specify it, the driver assumes 2.

That's no longer true. This and the next 2 properties are now detected 
if not specified.

> +    deprecated: true
> +
> +  num-ib-windows:
> +    description: number of inbound address translation windows
> +    maxItems: 1
> +    deprecated: true
> +
> +  num-ob-windows:
> +    description: number of outbound address translation windows
> +    maxItems: 1
> +    deprecated: true
> +
> +  # The following are optional properties for EP mode
> +
> +  max-functions:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: maximum number of functions that can be configured
> +
> +required:
> +  - reg
> +  - reg-names
> +  - compatible
> +
> +additionalProperties: false

unevaluatedProperties: false

so that we can have child PCI devices...

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: snps,dw-pcie
> +    then:
> +      allOf:
> +        - $ref: /schemas/pci/pci-bus.yaml#
> +
> +patternProperties:
> +  "pcie?_ep@[0-9a-f]+$":
> +    type: object
> +    properties:
> +      compatible:
> +        contains:
> +          const: snps,dw-pcie-ep

This doesn't make sense. This is defining a child node of the DW 
controller with 'snps,dw-pcie-ep'.

> +
> +  "pcie?@[0-9a-f]+$":
> +    type: object
> +
> +examples:
> +  - |
> +    pcie: pcie@dfc00000 {

Drop unused labels.

> +      compatible = "snps,dw-pcie";
> +      reg = <0xdfc00000 0x0001000>, /* IP registers */
> +            <0xd0000000 0x0002000>; /* Configuration space */
> +      reg-names = "dbi", "config";
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      device_type = "pci";
> +      ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
> +               <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
> +      interrupts = <25>, <24>;
> +      #interrupt-cells = <1>;
> +      num-lanes = <1>;
> +    };
> +    pcie_ep: pcie_ep@dfd00000 {

'pcie-ep' is preferred.

> +      compatible = "snps,dw-pcie-ep";
> +      reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
> +            <0xdfc01000 0x0001000>, /* IP registers 2 */
> +            <0xd0000000 0x2000000>; /* Configuration space */
> +      reg-names = "dbi", "dbi2", "addr_space";
> +    };
