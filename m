Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6ED46D772
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 16:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhLHP53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 10:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhLHP53 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 10:57:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC22C061746;
        Wed,  8 Dec 2021 07:53:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93E7DCE220E;
        Wed,  8 Dec 2021 15:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F76C341CC;
        Wed,  8 Dec 2021 15:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638978833;
        bh=EmRlyzDZj8c+x+fMXGXEvkznNGDfzJmgYTytF/U3qpI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UilMV3iRDDlKXVdW7L5bVg+PFeQx8BUBxDNTfO+YqM/2yIIwUWA/cDiQFLjF9IymJ
         P56DZQgEn6eryFW05gYUMYzRk/L4e/La0Cck/imYwL7hGiOBUh1PYcE5lap5fvxcAO
         lTEjR86U95rsEqgG5gz/oUNd9C3n1jthFy7uTWCDZzFBQ6tmHYMllzdGy8H8pSc4gw
         RHv9TL3pfvoEzJLnKzKaOqBrHFq/Y3YP8Sp/cNiuccZE0oPwoVLk10TY/y0Z3ZR2bJ
         k3YENWD7ImdSUHP366W/wzBptHI4ElWN/GJSWghuIO+qrs5apXSyeI9+03fX6sZp17
         7amTTaL5m5Aug==
Received: by mail-ed1-f53.google.com with SMTP id r11so9693679edd.9;
        Wed, 08 Dec 2021 07:53:53 -0800 (PST)
X-Gm-Message-State: AOAM5320JWetupXBWPhRLoAuHWgBV7uIc6C7gX4wv0ycoXv+KLXIavGo
        +1LY3Gx7Q8vXAtkdKftzf52lYcdsZY1tv99AWw==
X-Google-Smtp-Source: ABdhPJxT9QT24d63R7snDbL93QrHMNF74rLQLEz0i0HR4x2atExf+ZCCCMCpjbQRyQ3x+8tCRwVoW7FkDkKrei/oRds=
X-Received: by 2002:a17:907:3f24:: with SMTP id hq36mr8387666ejc.390.1638978828248;
 Wed, 08 Dec 2021 07:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20211208040432.3658355-1-f.fainelli@gmail.com> <20211208040432.3658355-2-f.fainelli@gmail.com>
In-Reply-To: <20211208040432.3658355-2-f.fainelli@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 Dec 2021 09:53:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKv0M-njPuPoGjLubaPv=6DWK=cLTiPvMrNfuJFTvC6gg@mail.gmail.com>
Message-ID: <CAL_JsqKv0M-njPuPoGjLubaPv=6DWK=cLTiPvMrNfuJFTvC6gg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] ARM: dts: Cygnus: Fixed iProc PCIe controller properties
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 7, 2021 at 10:04 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Rename the msi controller unit name to 'msi' to avoid collisions
> with the 'msi-controller' boolean property and add the missing
> 'interrupt-controller' property which is necessary. We also need to

'interrupt-controller'part should be dropped...

> re-arrange the 'ranges' property to show the two cells as being separate
> instead of combined since the DT checker is not able to differentiate
> otherwise.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 8ecb7861ce10..d6e2b2ba3a19 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -274,8 +274,8 @@ pcie0: pcie@18012000 {
>                         #address-cells = <3>;
>                         #size-cells = <2>;
>                         device_type = "pci";
> -                       ranges = <0x81000000 0 0          0x28000000 0 0x00010000
> -                                 0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
> +                       ranges = <0x81000000 0 0          0x28000000 0 0x00010000>,
> +                                <0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
>
>                         phys = <&pcie0_phy>;
>                         phy-names = "pcie-phy";
> @@ -283,7 +283,7 @@ pcie0: pcie@18012000 {
>                         status = "disabled";
>
>                         msi-parent = <&msi0>;
> -                       msi0: msi-controller {
> +                       msi0: msi {
>                                 compatible = "brcm,iproc-msi";
>                                 msi-controller;
>                                 interrupt-parent = <&gic>;
> @@ -298,6 +298,7 @@ pcie1: pcie@18013000 {
>                         compatible = "brcm,iproc-pcie";
>                         reg = <0x18013000 0x1000>;
>
> +                       interrupt-controller;

Missed dropping this?

>                         #interrupt-cells = <1>;
>                         interrupt-map-mask = <0 0 0 0>;
>                         interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> @@ -309,8 +310,8 @@ pcie1: pcie@18013000 {
>                         #address-cells = <3>;
>                         #size-cells = <2>;
>                         device_type = "pci";
> -                       ranges = <0x81000000 0 0          0x48000000 0 0x00010000
> -                                 0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
> +                       ranges = <0x81000000 0 0          0x48000000 0 0x00010000>,
> +                                <0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
>
>                         phys = <&pcie1_phy>;
>                         phy-names = "pcie-phy";
> @@ -318,7 +319,7 @@ pcie1: pcie@18013000 {
>                         status = "disabled";
>
>                         msi-parent = <&msi1>;
> -                       msi1: msi-controller {
> +                       msi1: msi {
>                                 compatible = "brcm,iproc-msi";
>                                 msi-controller;
>                                 interrupt-parent = <&gic>;
> --
> 2.25.1
>
