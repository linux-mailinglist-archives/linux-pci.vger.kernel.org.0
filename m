Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C501344F2D5
	for <lists+linux-pci@lfdr.de>; Sat, 13 Nov 2021 12:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhKMLll (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Nov 2021 06:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232925AbhKMLlk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Nov 2021 06:41:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70EA2610A1;
        Sat, 13 Nov 2021 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636803528;
        bh=XnFsCOh7+ZQSvOwVOReC7fne9fxxNTruS9Wkfka6JZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4gQK/TR/e8aa1qGhRiCxvwcgRYnKzPW3ga3Vj2AUhROup7f3YPZSGDqwsnUJc52w
         +L6FnKtCp5cVkKD6tjQzr17/CoUMwP33aPODqbewUZnBpMD+HJNn/G1yLhFJGd3yNu
         A0lXhgqsWUuISH4VAYYBdlBab3Cn3an5CmsHsGrP1krtCSBDbI8DPSDciRvdU//9Fl
         WXQ3JTIMpZ+ctuyPnKy0pbJxuZ8O+o3nvwHAiijbI+fPMVkfZcsS+RJioZjV6Ki3kg
         ofSNhvXCUFHwoTdopFhyJY9GC33KlooDijJ3LENwSdYDcqTMbWBQbFMc3K7w+vrgMw
         KId3eVvIzPikQ==
Received: by pali.im (Postfix)
        id 5DD69819; Sat, 13 Nov 2021 12:38:46 +0100 (CET)
Date:   Sat, 13 Nov 2021 12:38:46 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 3/8] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <20211113113846.oqdnov2hvbmlx5hi@pali>
References: <20211110221456.11977-1-jim2101024@gmail.com>
 <20211110221456.11977-4-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110221456.11977-4-jim2101024@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 10 November 2021 17:14:43 Jim Quinlan wrote:
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
>  .../bindings/pci/brcm,stb-pcie.yaml           | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 508e5dce1282..ef2427320b7d 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -158,5 +158,28 @@ examples:
>                                   <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
>                      brcm,enable-ssc;
>                      brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
> +
> +                    /* PCIe bridge */
> +                    pci@0,0 {

Hello! I think that above comment should be "PCIe Root Port" (and not
PCIe bridge) as this node really describes Root Port device in PCIe Root
Complex (correct me if I deduced it wrongly). lspci (-vv) show type of
device on the line "Capabilities: [..] Express".

> +                            #address-cells = <3>;
> +                            #size-cells = <2>;
> +                            reg = <0x0 0x0 0x0 0x0 0x0>;
> +                            compatible = "pciclass,0604";
> +                            device_type = "pci";
> +                            vpcie3v3-supply = <&vreg7>;
> +                            ranges;
> +
> +                            /* PCIe endpoint */
> +                            pci-ep@0,0 {
> +                                    assigned-addresses =
> +                                        <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
> +                                    reg = <0x0 0x0 0x0 0x0 0x0>;
> +                                    compatible = "pci14e4,1688";
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
