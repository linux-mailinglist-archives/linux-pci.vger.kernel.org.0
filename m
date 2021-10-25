Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDDC43A674
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 00:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhJYW1F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 18:27:05 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:37642 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhJYW1E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 18:27:04 -0400
Received: by mail-ot1-f41.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso17027883otl.4;
        Mon, 25 Oct 2021 15:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L/hlTtZupHzj4/jWdWv9ULYOvkBrN5PlWdyav0V4CCU=;
        b=iEAQrY/4yILkKuZMGsF8UU8JkZoANHyoD6clDsukJjeKrGPV6YSZ7LtuRFFQAuJ7jg
         SamzHxzuZwPX8PGYhBSkMCdUFPo6MObuNhhR0X8ahnNeyBWi1OJFACAqJZ/TOiZZUwwU
         Hevtp/kLvcKHBFmt6dyqIlXtm70E/l6bHT05kKSuQvy2+v78RLv5n8WyXAo0mqNAX/Vr
         gAY1obKzthWwsXzu1Ni5MYHgt4vlVp80oildW8IyYrm4PiqfAf62AXZwfvLH07iPVbaI
         b+MuM3FJrVvp1OvouSDdLa+8xtNB+hXOyEFnHbTpa6YM7xMmbY3dYMsxFwGPikEUA4xY
         55gw==
X-Gm-Message-State: AOAM5303qeQrIsV3ltnBz7eZht6cKgXxvl1QK1O46h04b1qgSq+HK5tB
        9iMN09S1sUVzQJjYMNSoYg==
X-Google-Smtp-Source: ABdhPJy6PWKHQYzOWadWPt0ynalGKvun/QJa8ePrjt0bfrFipgAtZNmeZZGxpq1/mujmp7vzBtfbmg==
X-Received: by 2002:a9d:6d99:: with SMTP id x25mr7187510otp.168.1635200681358;
        Mon, 25 Oct 2021 15:24:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 3sm3996343oif.12.2021.10.25.15.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:24:40 -0700 (PDT)
Received: (nullmailer pid 1194223 invoked by uid 1000);
        Mon, 25 Oct 2021 22:24:39 -0000
Date:   Mon, 25 Oct 2021 17:24:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <YXcup7d6ROmmPCuD@robh.at.kernel.org>
References: <20211022140714.28767-1-jim2101024@gmail.com>
 <20211022140714.28767-2-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022140714.28767-2-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 22, 2021 at 10:06:54AM -0400, Jim Quinlan wrote:
> Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
> allows optional regulators to be attached and controlled by the PCIe RC
> driver.  That being said, this driver searches in the DT subnode (the EP
> node, eg pci@0,0) for the regulator property.
> 
> The use of a regulator property in the pcie EP subnode such as
> "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> file at
> 
> https://github.com/devicetree-org/dt-schema/pull/54
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  .../bindings/pci/brcm,stb-pcie.yaml           | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index b9589a0daa5c..fec13e4f6eda 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -154,5 +154,28 @@ examples:
>                                   <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
>                      brcm,enable-ssc;
>                      brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
> +
> +                    /* PCIe bridge */

More specifically, the root port.

> +                    pci@0,0 {
> +                            #address-cells = <3>;
> +                            #size-cells = <2>;
> +                            reg = <0x0 0x0 0x0 0x0 0x0>;
> +                            device_type = "pci";
> +                            ranges;
> +
> +                            /* PCIe endpoint */
> +                            pci@0,0 {
> +                                    device_type = "pci";

This means this device is a PCI bridge which wouldn't typically be the 
endpoint. Is that intended? 

> +                                    assigned-addresses = <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
> +                                    reg = <0x0 0x0 0x0 0x0 0x0>;
> +                                    compatible = "pci14e4,1688";
> +                                    vpcie3v3-supply = <&vreg7>;
> +
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
