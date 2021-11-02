Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC715443165
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 16:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhKBPUx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 11:20:53 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:44601 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhKBPUr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Nov 2021 11:20:47 -0400
Received: by mail-oo1-f53.google.com with SMTP id w23-20020a4a9d17000000b002bb72fd39f3so5940756ooj.11;
        Tue, 02 Nov 2021 08:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2EIwvka6HY0tt1mWfUfg0OA139r7CHLfgZe4bS2xaN8=;
        b=Gv24YAWs7aLoDGqLU+wNSi765fZtzJVnY9bHzEB6qL1s0p84ZB6Wz43O2YCzQ9UE8g
         2QigRhI1Wbz1jLLMr4yzku8nDOJFqfgJP6Ym6eTnWZRzDrkTddIpnlLFiCU6U5GKLIi5
         aQWqJ/PzP6wZl8bm5iDkN0ZLgOGSBuAPRjJtEx+gZjbE7IwnVY0ghCHiHNjEfxlmVnl4
         yVjojSFEDzRcHSRg0R28xq8ueqjcks3v9d3JKbB/GC/FJBU+dyXhWeJ+dOUAbpCKF55P
         1+XS2TVhhTpNOb++FLC/dtLCv8EC4ilAEQHHCSSR17lBTmekFf5S0kRBfKX0GZnONAsq
         vv4A==
X-Gm-Message-State: AOAM530u/iaRgRD/btQkA4lvl/Sk3wniVG7U+jafU0nkgc136eJW/2O5
        iJJ0QwklzWnfHJZchucr7Q==
X-Google-Smtp-Source: ABdhPJz0/37WePS8h7rPOcKD03943wRIiB/hsuVsiy+jnaSiOa93DnFJu1gnimNb3NyeLukbT6gIbA==
X-Received: by 2002:a4a:c304:: with SMTP id c4mr24984263ooq.34.1635866292338;
        Tue, 02 Nov 2021 08:18:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t141sm331675oie.25.2021.11.02.08.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:18:11 -0700 (PDT)
Received: (nullmailer pid 2901202 invoked by uid 1000);
        Tue, 02 Nov 2021 15:18:09 -0000
Date:   Tue, 2 Nov 2021 10:18:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/9] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <YYFWsenSLJ4yzgp3@robh.at.kernel.org>
References: <20211029200319.23475-1-jim2101024@gmail.com>
 <20211029200319.23475-3-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029200319.23475-3-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 29, 2021 at 04:03:10PM -0400, Jim Quinlan wrote:
> Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
> allows optional regulators to be attached and controlled by the PCIe RC
> driver.  That being said, this driver searches in the DT subnode (the EP
> node, eg pci-ep@0,0) for the regulator property.
> 
> The use of a regulator property in the pcie EP subnode such as
> "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> file at
> 
> https://github.com/devicetree-org/dt-schema/pull/63
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../bindings/pci/brcm,stb-pcie.yaml           | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 508e5dce1282..d90d867deb5c 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -62,6 +62,10 @@ properties:
>  
>    aspm-no-l0s: true
>  
> +  vpcie12v-supply: true
> +  vpcie3v3-supply: true
> +  vpcie3v3aux-supply: true
> +

You've put these in the host bridge node and in *any* bridge node for 
pci-bus.yaml, but that's not where you have them in the example.

The question is where is the right place. Normally, I'd say that's in 
the node consuming or connected to the resource. That would be as you 
have the example. However, as we're talking about standard slots (or at 
least standard slot rails), we likely don't have node for the device in 
the slot and can't add one since it is likely unknown what the device 
is. In other cases, we'd define a connector or slot node, but there's 
not really a way to do that given the PCI bus topology is already 
defined. So I think the right place is the bridge node on the upstream 
side of the slot/connector. So the 'pci@0,0' node in your case.

Rob

>    brcm,scb-sizes:
>      description: u64 giving the 64bit PCIe memory
>        viewport size of a memory controller.  There may be up to
> @@ -158,5 +162,28 @@ examples:
>                                   <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
>                      brcm,enable-ssc;
>                      brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
> +
> +                    /* PCIe bridge */
> +                    pci@0,0 {
> +                            #address-cells = <3>;
> +                            #size-cells = <2>;
> +                            reg = <0x0 0x0 0x0 0x0 0x0>;
> +                            compatible = "pciclass,0604";
> +                            device_type = "pci";
> +                            ranges;
> +
> +                            /* PCIe endpoint */
> +                            pci-ep@0,0 {
> +                                    assigned-addresses =
> +                                        <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
> +                                    reg = <0x0 0x0 0x0 0x0 0x0>;
> +                                    compatible = "pci14e4,1688";
> +                                    vpcie3v3-supply = <&vreg7>;
> +                                    #address-cells = <3>;
> +                                    #size-cells = <2>;
> +
> +                                    ranges;
> +                            };
> +                    };
>              };
>      };
> -- 
> 2.17.1
> 
> 
