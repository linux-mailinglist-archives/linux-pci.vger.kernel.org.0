Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E592BDB0E
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2019 11:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbfIYJd5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Sep 2019 05:33:57 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:57543 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732789AbfIYJdz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Sep 2019 05:33:55 -0400
X-Originating-IP: 86.250.200.211
Received: from windsurf (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 30D7820005;
        Wed, 25 Sep 2019 09:33:52 +0000 (UTC)
Date:   Wed, 25 Sep 2019 11:33:51 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Don't rely on jiffies while holding
 spinlock
Message-ID: <20190925113351.0b53d2e9@windsurf>
In-Reply-To: <20190901142303.27815-1-repk@triplefau.lt>
References: <20190901142303.27815-1-repk@triplefau.lt>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Remi,

Thanks for the patch, I have a few comments/questions below.

On Sun,  1 Sep 2019 16:23:03 +0200
Remi Pommarel <repk@triplefau.lt> wrote:

> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index fc0fe4d4de49..1fa6d04ad7aa 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -175,7 +175,8 @@
>  	(PCIE_CONF_BUS(bus) | PCIE_CONF_DEV(PCI_SLOT(devfn))	| \
>  	 PCIE_CONF_FUNC(PCI_FUNC(devfn)) | PCIE_CONF_REG(where))
>  
> -#define PIO_TIMEOUT_MS			1
> +#define PIO_RETRY_CNT			10
> +#define PIO_RETRY_DELAY			100 /* 100 us*/
>  
>  #define LINK_WAIT_MAX_RETRIES		10
>  #define LINK_WAIT_USLEEP_MIN		90000
> @@ -383,17 +384,16 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
>  static int advk_pcie_wait_pio(struct advk_pcie *pcie)
>  {
>  	struct device *dev = &pcie->pdev->dev;
> -	unsigned long timeout;
> +	size_t i;

Is it common to use a size_t for a loop counter ?

>  
> -	timeout = jiffies + msecs_to_jiffies(PIO_TIMEOUT_MS);
> -
> -	while (time_before(jiffies, timeout)) {
> +	for (i = 0; i < PIO_RETRY_CNT; ++i) {

I find it more common to use post-increment for loop counters rather
than pre-increment, but that's a really nitpick and I don't care much.

>  		u32 start, isr;
>  
>  		start = advk_readl(pcie, PIO_START);
>  		isr = advk_readl(pcie, PIO_ISR);
>  		if (!start && isr)
>  			return 0;
> +		udelay(PIO_RETRY_DELAY);

But the bigger issue is that this change causes a 100us delay at
*every* single PIO read or write operation.

Indeed, at the first iteration of the loop, the PIO operation has not
completed, so you will always hit the udelay(100) a first time, and
it's only at the second iteration of the loop that the PIO operation
has completed (for successful PIO operations of course, which don't hit
the timeout).

I took a measurement around wait_pio() with sched_clock before and
after the patch. Before the patch, I have measurements like this (in
nanoseconds):

[    1.562801] time = 6000
[    1.565310] time = 6000
[    1.567809] time = 6080
[    1.570327] time = 6080
[    1.572836] time = 6080
[    1.575339] time = 6080
[    1.577858] time = 2720
[    1.580366] time = 2720
[    1.582862] time = 6000
[    1.585377] time = 2720
[    1.587890] time = 2720
[    1.590393] time = 2720

So it takes a few microseconds for each PIO operation.

With your patch applied:

[    2.267291] time = 101680
[    2.270002] time = 100880
[    2.272852] time = 100800
[    2.275573] time = 100880
[    2.278285] time = 100800
[    2.281005] time = 100880
[    2.283722] time = 100800
[    2.286444] time = 100880
[    2.289264] time = 100880
[    2.291981] time = 100800
[    2.294690] time = 100800
[    2.297405] time = 100800

We're jumping to 100us for every PIO read/write operation. To be
honest, I don't know if this is very important, there are not that many
PIO operations, and they are not used in any performance hot path. But
I thought it was worth pointing out the additional delay caused by this
implementation change.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
