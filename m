Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7000D2A2F91
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 17:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgKBQTg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 11:19:36 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34474 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgKBQTf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 11:19:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id j14so2894911ots.1;
        Mon, 02 Nov 2020 08:19:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BO7O+YN2tlCKdU4I/z4UPEv+3qihFtAtK3mMGXYcXO4=;
        b=NuhdStL+S/9fhs530kcaNrq5aPNMkl2nnpTIbd9WClPxqXyvJxvYp5g/W7SIjczOSR
         Gmp9zLZcWRfi0UW7+Yyh7Qyo4kPQ7pSprKY4IKoF6z6zmLsM5ltvaxczLBqyDeItfFdt
         obOt1xa3CZGv1w56Rtc+fuebn6Jb30G0EIpKXhfLjXGxYa5X0s5mtAhTb/1RXZxO9xCE
         chLyHR+iKBryyeNNQgSrzw92LQ7OHr1lBaAnJGSVc2McLPaeo5MYeaBe4xx8rd5lfWLN
         CfXZxErz3sVoSffuD9SQm3gYmmTEwoW/I1GSpcXN3SCRT5Qx6waB3smleLdYSxsD/NIu
         Z2rQ==
X-Gm-Message-State: AOAM5320J8F4z2WQIRV/ppAJ5PL3os5mCwEpKWlQrF47+fGb8N6VP2S9
        dH5SNiv2niUhQmVdSm/y0A==
X-Google-Smtp-Source: ABdhPJyR1X6GeJm+dCYy15tJ273TNlzVEyQm04Jgu9YdIUpqv/a6WrGerM/SK+srBl/K367/4mOVeg==
X-Received: by 2002:a05:6830:1e70:: with SMTP id m16mr12295679otr.51.1604333972544;
        Mon, 02 Nov 2020 08:19:32 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k15sm3470621oor.11.2020.11.02.08.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 08:19:31 -0800 (PST)
Received: (nullmailer pid 3991041 invoked by uid 1000);
        Mon, 02 Nov 2020 16:19:31 -0000
Date:   Mon, 2 Nov 2020 10:19:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chuanjia Liu <chuanjia.liu@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        yong.wu@mediatek.com, Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v7 1/4] dt-bindings: pci: mediatek: Modified the Device
 tree bindings
Message-ID: <20201102161931.GA3985668@bogus>
References: <20201029081513.10562-1-chuanjia.liu@mediatek.com>
 <20201029081513.10562-2-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029081513.10562-2-chuanjia.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 29, 2020 at 04:15:10PM +0800, Chuanjia Liu wrote:
> Split the PCIe node and add pciecfg node to fix MSI issue.

I still think if you are changing the binding this much, then further 
work should be done removing the slot nodes.

> 
> Signed-off-by: Chuanjia Liu <chuanjia.liu@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-cfg.yaml       |  39 ++++++
>  .../devicetree/bindings/pci/mediatek-pcie.txt | 129 +++++++++++-------
>  2 files changed, 118 insertions(+), 50 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
> new file mode 100644
> index 000000000000..d3ecbcd032a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-cfg.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/mediatek-pcie-cfg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek PCIECFG controller
> +
> +maintainers:
> +  - Chuanjia Liu <chuanjia.liu@mediatek.com>
> +  - Jianjun Wang <jianjun.wang@mediatek.com>
> +
> +description: |
> +  The MediaTek PCIECFG controller controls some feature about
> +  LTSSM, ASPM and so on.
> +
> +properties:
> +  compatible:
> +      items:
> +        - enum:
> +            - mediatek,generic-pciecfg
> +        - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pciecfg: pciecfg@1a140000 {
> +        compatible = "mediatek,generic-pciecfg", "syscon";
> +        reg = <0x1a140000 0x1000>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> index 7468d666763a..c14a2745de37 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.txt
> @@ -8,7 +8,7 @@ Required properties:
>  	"mediatek,mt7623-pcie"
>  	"mediatek,mt7629-pcie"
>  - device_type: Must be "pci"
> -- reg: Base addresses and lengths of the PCIe subsys and root ports.
> +- reg: Base addresses and lengths of the root ports.
>  - reg-names: Names of the above areas to use during resource lookup.
>  - #address-cells: Address representation for root ports (must be 3)
>  - #size-cells: Size representation for root ports (must be 2)
> @@ -143,56 +143,71 @@ Examples for MT7623:
>  
>  Examples for MT2712:
>  
> -	pcie: pcie@11700000 {
> +	pcie1: pcie@112ff000 {
>  		compatible = "mediatek,mt2712-pcie";
>  		device_type = "pci";
> -		reg = <0 0x11700000 0 0x1000>,
> -		      <0 0x112ff000 0 0x1000>;
> -		reg-names = "port0", "port1";
> +		reg = <0 0x112ff000 0 0x1000>;
> +		reg-names = "port1";
>  		#address-cells = <3>;
>  		#size-cells = <2>;
> -		interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&topckgen CLK_TOP_PE2_MAC_P0_SEL>,
> -			 <&topckgen CLK_TOP_PE2_MAC_P1_SEL>,
> -			 <&pericfg CLK_PERI_PCIE0>,
> +		interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "pcie_irq";
> +		clocks = <&topckgen CLK_TOP_PE2_MAC_P1_SEL>,
>  			 <&pericfg CLK_PERI_PCIE1>;
> -		clock-names = "sys_ck0", "sys_ck1", "ahb_ck0", "ahb_ck1";
> -		phys = <&pcie0_phy PHY_TYPE_PCIE>, <&pcie1_phy PHY_TYPE_PCIE>;
> -		phy-names = "pcie-phy0", "pcie-phy1";
> +		clock-names = "sys_ck1", "ahb_ck1";
> +		phys = <&u3port1 PHY_TYPE_PCIE>;
> +		phy-names = "pcie-phy1";
>  		bus-range = <0x00 0xff>;
> -		ranges = <0x82000000 0 0x20000000  0x0 0x20000000  0 0x10000000>;
> +		ranges = <0x82000000 0 0x11400000  0x0 0x11400000  0 0x300000>;
>  
> -		pcie0: pcie@0,0 {
> -			reg = <0x0000 0 0 0 0>;
> +		slot1: pcie@1,0 {

Does the driver still work if this is devfn 0 instead of 1 (or swap 0 
and 1 slots)? I'll bet it does. 

The reason being is that AFAICT, the Mediatek PCI controller is 
Designware based. The registers at 0x70c and 0x73c are DWC 'port logic' 
registers. The DWC RC also has a quirk that it doesn't filter config 
accesses to only devfn 0 (see pci_dw_valid_device()), so your config 
accesses to the RP should work no matter what devfn you use. You'll have 
to get rid of the ports list and just get the mtk_pcie_port from 
bus->sysdata instead.

Rob

