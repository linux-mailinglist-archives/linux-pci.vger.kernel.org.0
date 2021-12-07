Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7B846BCEC
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 14:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbhLGNwu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 08:52:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41340 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhLGNwu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 08:52:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACB69B817AC;
        Tue,  7 Dec 2021 13:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EDFC341C3;
        Tue,  7 Dec 2021 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638884957;
        bh=MCrmhoOfiZaoNBZ0VF5Q8duq+I3/7+arLl4dMixJGQU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mnYrkdQJaclaNickXu+J2BknfkyfTfA0nTldjTAZ4uANM7VNpgX8nRJE1Jk98zHmD
         u/UgD5X3/ZE4ISqaiYC27w/sgRyOEds79z2zomwm1uFXWhnuPLFZXnouiQDe8xtQtb
         Ri4AaXPwt50Q1qU5xMywAFPXh4t2YNywrqVcu/jwqiO0Y0HMZyMQtjy+oY/bYibXmH
         0Ns1UROXa+AxBj+aUP8wx+o3gnXOuTLdn7Bpoz6i6Vefmk7VNh+fti0drdfC+ZmKi8
         1qVkfKLGUH1r653/gHLeRjG8UZUSCAW7ITEWHVhaGJ2FgUi409Ua1Z7Vh9D7pbx1zf
         r8USDnV4HrUAA==
Received: by mail-ed1-f43.google.com with SMTP id r25so56998535edq.7;
        Tue, 07 Dec 2021 05:49:17 -0800 (PST)
X-Gm-Message-State: AOAM530auEzKgLp6lQj5UFrqDgwZV162xEqTuFNKExIPMrKruYbwWgKa
        cnDqnnrhJk/eyKdtaktIzE7BG4w48I1RrKJFGg==
X-Google-Smtp-Source: ABdhPJxYibkcAorJmNqQ1tmkxWpKm0Rdagpd+pr3AgKn/CGY95tx/YJObidtIvCyVgPsVS/656cL5qA7zo+a0imlv6o=
X-Received: by 2002:a17:907:7f25:: with SMTP id qf37mr53785773ejc.147.1638884955679;
 Tue, 07 Dec 2021 05:49:15 -0800 (PST)
MIME-Version: 1.0
References: <20211206185242.2098683-1-f.fainelli@gmail.com> <20211206185242.2098683-2-f.fainelli@gmail.com>
In-Reply-To: <20211206185242.2098683-2-f.fainelli@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 7 Dec 2021 07:49:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKaOkByjwYzyW6G_b90zRjCWVHvi2V0gBx_MJ8v2FmOaw@mail.gmail.com>
Message-ID: <CAL_JsqKaOkByjwYzyW6G_b90zRjCWVHvi2V0gBx_MJ8v2FmOaw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ARM: dts: Cygnus: Fixed iProc PCIe controller properties
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

On Mon, Dec 6, 2021 at 12:52 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Rename the msi controller unit name to 'msi' to avoid collisions
> with the 'msi-controller' boolean property and add the missing
> 'interrupt-controller' property which is necessary. We also need to
> re-arrange the 'ranges' property to show the two cells as being separate
> instead of combined since the DT checker is not able to differentiate
> otherwise.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 8ecb7861ce10..ea19d1b56400 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -263,6 +263,7 @@ pcie0: pcie@18012000 {
>                         compatible = "brcm,iproc-pcie";
>                         reg = <0x18012000 0x1000>;
>
> +                       interrupt-controller;

How is this a fix? This doesn't even work before v5.16 with commit
041284181226 ("of/irq: Allow matching of an interrupt-map local to an
interrupt controller").


>                         #interrupt-cells = <1>;
>                         interrupt-map-mask = <0 0 0 0>;
>                         interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> @@ -274,8 +275,8 @@ pcie0: pcie@18012000 {
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
> @@ -283,7 +284,7 @@ pcie0: pcie@18012000 {
>                         status = "disabled";
>
>                         msi-parent = <&msi0>;
> -                       msi0: msi-controller {
> +                       msi0: msi {
>                                 compatible = "brcm,iproc-msi";
>                                 msi-controller;
>                                 interrupt-parent = <&gic>;
> @@ -298,6 +299,7 @@ pcie1: pcie@18013000 {
>                         compatible = "brcm,iproc-pcie";
>                         reg = <0x18013000 0x1000>;
>
> +                       interrupt-controller;
>                         #interrupt-cells = <1>;
>                         interrupt-map-mask = <0 0 0 0>;
>                         interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> @@ -309,8 +311,8 @@ pcie1: pcie@18013000 {
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
> @@ -318,7 +320,7 @@ pcie1: pcie@18013000 {
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
