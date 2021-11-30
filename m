Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490D6462A18
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 03:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhK3CFj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 21:05:39 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:35814 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhK3CFh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 21:05:37 -0500
Received: by mail-ot1-f46.google.com with SMTP id x43-20020a056830246b00b00570d09d34ebso28183650otr.2;
        Mon, 29 Nov 2021 18:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qy/w54uMaqbN75P0mXjmvS+7fmuQmydP/mR3OP5pDWc=;
        b=c+dYCOUE7wHXlHT7tq3+E22wRJnzlksMt6tp1A6OtnsgKknIGqlFj1WyllJmNjDWnY
         9w5CaKZCQXxleseKg9rbF+La2vu5mR7kC4Dc4/YtFQ3/l9lRnhVYT9oa289o+OMyl5Oe
         ca8yceqkZ872JN5VPUmmoAx0KYjnQH3t9Rb1sS9MBuOq9kzKONBr29FHqxo8qITvCbFr
         2HfPBP92WLitWOIzQjSwd5iGQYMPi8WPhLr4yXWZICgrghBn85sghYn5bUEdeMJaNce5
         XWuMIc9TBpsKNGwRbK5sEzf5dMuHXMteKsdz72T1mHPiboZR0ivQRNLpERQ1eomhCWoL
         UJKg==
X-Gm-Message-State: AOAM530SfGru+jGo0qQrNrFXyF3GRgKNQCJu7Nq46nVwOhpNxd/j5Q4V
        LuKphF+KqJMCW03+jppqRQ==
X-Google-Smtp-Source: ABdhPJwsup8Dn4d/RO+tKiI8fEo/X7mnrDBAC9Jp/INq+fmZKmIGVpwbOsqGxP+yJgMnhoAikElNLw==
X-Received: by 2002:a9d:2002:: with SMTP id n2mr47455183ota.95.1638237738963;
        Mon, 29 Nov 2021 18:02:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m12sm2965977ots.59.2021.11.29.18.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 18:02:18 -0800 (PST)
Received: (nullmailer pid 1022763 invoked by uid 1000);
        Tue, 30 Nov 2021 02:02:17 -0000
Date:   Mon, 29 Nov 2021 20:02:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH 4/4] dt-bindings: pci: layerscape-pci: define aer/pme
 interrupts
Message-ID: <YaWGKaBvTpx1pA/x@robh.at.kernel.org>
References: <20211120001621.21246-1-leoyang.li@nxp.com>
 <20211120001621.21246-5-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120001621.21246-5-leoyang.li@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 06:16:21PM -0600, Li Yang wrote:
> Some platforms using this controller have separated interrupt lines for
> aer or pme events instead of having a single interrupt line for
> miscellaneous events.  Define interrupts in the binding for these
> interrupt lines.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../devicetree/bindings/pci/layerscape-pci.txt     | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> index 8fd6039a826b..bcf11bfc4bab 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> @@ -31,8 +31,13 @@ Required properties:
>  - reg: base addresses and lengths of the PCIe controller register blocks.
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> -- interrupt-names: Must include the following entries:
> -  "intr": The interrupt that is asserted for controller interrupts
> +- interrupt-names: It could include the following entries:
> +  "aer": For interrupt line reporting aer events when non MSI/MSI-X/INTx mode
> +		is used
> +  "pme": For interrupt line reporting pme events when non MSI/MSI-X/INTx mode
> +		is used
> +  "intr": For interrupt line reporting miscellaneous controller events
> +  ......
>  - fsl,pcie-scfg: Must include two entries.
>    The first entry must be a link to the SCFG device node
>    The second entry is the physical PCIe controller index starting from '0'.
> @@ -52,8 +57,9 @@ Example:
>  		reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
>  		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
>  		reg-names = "regs", "config";
> -		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
> -		interrupt-names = "intr";
> +		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>, /* aer interrupt */
> +			<GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* pme interrupt */
> +		interrupt-names = "aer", "pme";

This isn't a compatible change. The h/w suddenly has no 'intr' 
interrupt?

>  		fsl,pcie-scfg = <&scfg 0>;
>  		#address-cells = <3>;
>  		#size-cells = <2>;
> -- 
> 2.25.1
> 
> 
