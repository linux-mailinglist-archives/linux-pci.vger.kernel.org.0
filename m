Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3A22CF700
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 23:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgLDWmS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 17:42:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgLDWmS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 17:42:18 -0500
Date:   Fri, 4 Dec 2020 16:41:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607121697;
        bh=qiQD6O0CcX089MHWDBucfbDBjg5y9WFVZdTDvIoZspg=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=nXtsb7/Xwuhz/L5mBbYJFfiwpdai47Moj6nVCQI/lpEgEhwnNbPs+G/U+/OBhZ7lr
         njNLQC6ibc+xSQJdKlzt5IKDQR1K19dJBsmgJCTmyF/6nZ3ZgrXCZgzmN8jVG2N70h
         IFxUUa5lGEiUdBIGauV1/AY3iDPmsx6G5ScUpgyB8qCpXORNn1CpbRTIzPTwEzZx1F
         iT9PbQ5O75Cwqwm+JvJnSzVhDGarEwX8JMjbqLGRFQOsEZ6wzQG1UDfGEyxbiUypCR
         gjTSuJVx3oMTTiGRTLsj2u7b3yH55CvdX19OpIQdW3IZ+iR3pEvB/4QzHtb9GpHEtN
         0jOe6Yya7HXYA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move Jason Cooper to CREDITS
Message-ID: <20201204224135.GA1975685@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128103707.332874-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 28, 2020 at 10:37:07AM +0000, Marc Zyngier wrote:
> Jason's email address has now been bouncing for weeks, and no
> reply was received when trying to reach out on other addresses.
> 
> We really hope he is OK. But until we hear of his whereabouts,
> let's move him to the CREDITS file so that people stop Cc-ing
> him.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Applied to for-linus for v5.10 since there's no risk and the bounces
are annoying.

> ---
>  CREDITS     | 5 +++++
>  MAINTAINERS | 4 ----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/CREDITS b/CREDITS
> index 8592e45e3932..cf112d3e9382 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -740,6 +740,11 @@ S: (ask for current address)
>  S: Portland, Oregon
>  S: USA
>  
> +N: Jason Cooper
> +D: ARM/Marvell SOC co-maintainer
> +D: irqchip co-maintainer
> +D: MVEBU PCI DRIVER co-maintainer
> +
>  N: Robin Cornelius
>  E: robincornelius@users.sourceforge.net
>  D: Ralink rt2x00 WLAN driver
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e451dcce054f..7ba26942a573 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2012,7 +2012,6 @@ M:	Philipp Zabel <philipp.zabel@gmail.com>
>  S:	Maintained
>  
>  ARM/Marvell Dove/MV78xx0/Orion SOC support
> -M:	Jason Cooper <jason@lakedaemon.net>
>  M:	Andrew Lunn <andrew@lunn.ch>
>  M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>  M:	Gregory Clement <gregory.clement@bootlin.com>
> @@ -2029,7 +2028,6 @@ F:	arch/arm/plat-orion/
>  F:	drivers/soc/dove/
>  
>  ARM/Marvell Kirkwood and Armada 370, 375, 38x, 39x, XP, 3700, 7K/8K, CN9130 SOC support
> -M:	Jason Cooper <jason@lakedaemon.net>
>  M:	Andrew Lunn <andrew@lunn.ch>
>  M:	Gregory Clement <gregory.clement@bootlin.com>
>  M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> @@ -9255,7 +9253,6 @@ F:	kernel/irq/
>  
>  IRQCHIP DRIVERS
>  M:	Thomas Gleixner <tglx@linutronix.de>
> -M:	Jason Cooper <jason@lakedaemon.net>
>  M:	Marc Zyngier <maz@kernel.org>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
> @@ -13405,7 +13402,6 @@ F:	drivers/pci/controller/mobiveil/pcie-mobiveil*
>  
>  PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
>  M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> -M:	Jason Cooper <jason@lakedaemon.net>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> -- 
> 2.29.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
