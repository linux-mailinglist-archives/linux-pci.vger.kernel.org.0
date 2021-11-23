Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8D45AB2B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 19:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbhKWSTz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 13:19:55 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:65042 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbhKWSTz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 13:19:55 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 97695463;
        Tue, 23 Nov 2021 19:16:45 +0100 (CET)
Date:   Tue, 23 Nov 2021 19:16:45 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, pali@kernel.org, alyssa@rosenzweig.io,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        luca@lucaceresoli.net, kernel-team@android.com
In-Reply-To: <20211123180636.80558-3-maz@kernel.org> (message from Marc
        Zyngier on Tue, 23 Nov 2021 18:06:35 +0000)
Subject: Re: [PATCH v3 2/3] arm64: dts: apple: t8103: Fix PCIe #PERST polarity
References: <20211123180636.80558-1-maz@kernel.org> <20211123180636.80558-3-maz@kernel.org>
Message-ID: <d3caf90f3d319cdf@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Marc Zyngier <maz@kernel.org>
> Date: Tue, 23 Nov 2021 18:06:35 +0000
> 
> As the name indicates, #PERST is active low. So fix the DT description
> to match the HW behaviour.
> 
> Fixes: ff2a8d91d80c ("arm64: apple: Add PCIe node")
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  arch/arm64/boot/dts/apple/t8103.dtsi | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index fc8b2bb06ffe..e22c9433d5e0 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -7,6 +7,7 @@
>   * Copyright The Asahi Linux Contributors
>   */
>  
> +#include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/apple-aic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/apple.h>
> @@ -281,7 +282,7 @@ pcie0: pcie@690000000 {
>  			port00: pci@0,0 {
>  				device_type = "pci";
>  				reg = <0x0 0x0 0x0 0x0 0x0>;
> -				reset-gpios = <&pinctrl_ap 152 0>;
> +				reset-gpios = <&pinctrl_ap 152 GPIO_ACTIVE_LOW>;
>  				max-link-speed = <2>;
>  
>  				#address-cells = <3>;
> @@ -301,7 +302,7 @@ port00: pci@0,0 {
>  			port01: pci@1,0 {
>  				device_type = "pci";
>  				reg = <0x800 0x0 0x0 0x0 0x0>;
> -				reset-gpios = <&pinctrl_ap 153 0>;
> +				reset-gpios = <&pinctrl_ap 153 GPIO_ACTIVE_LOW>;
>  				max-link-speed = <2>;
>  
>  				#address-cells = <3>;
> @@ -321,7 +322,7 @@ port01: pci@1,0 {
>  			port02: pci@2,0 {
>  				device_type = "pci";
>  				reg = <0x1000 0x0 0x0 0x0 0x0>;
> -				reset-gpios = <&pinctrl_ap 33 0>;
> +				reset-gpios = <&pinctrl_ap 33 GPIO_ACTIVE_LOW>;
>  				max-link-speed = <1>;
>  
>  				#address-cells = <3>;
> -- 
> 2.30.2
> 
> 
