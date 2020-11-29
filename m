Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713E42C78AE
	for <lists+linux-pci@lfdr.de>; Sun, 29 Nov 2020 12:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgK2LCZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Nov 2020 06:02:25 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:45799 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgK2LCY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Nov 2020 06:02:24 -0500
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6364320005;
        Sun, 29 Nov 2020 11:01:41 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     kernel-team@android.com, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] MAINTAINERS: Move Jason Cooper to CREDITS
In-Reply-To: <20201128103707.332874-1-maz@kernel.org>
References: <20201128103707.332874-1-maz@kernel.org>
Date:   Sun, 29 Nov 2020 12:01:41 +0100
Message-ID: <871rgcl94a.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Marc Zyngier <maz@kernel.org> writes:

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

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory


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

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
