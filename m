Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69F66C00EA
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 10:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfI0IQs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 04:16:48 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:36737 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfI0IQs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 04:16:48 -0400
X-Originating-IP: 65.39.69.237
Received: from localhost (unknown [65.39.69.237])
        (Authenticated sender: repk@triplefau.lt)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 629F0240003;
        Fri, 27 Sep 2019 08:16:45 +0000 (UTC)
Date:   Fri, 27 Sep 2019 10:25:09 +0200
From:   Remi Pommarel <repk@triplefau.lt>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Don't rely on jiffies while holding
 spinlock
Message-ID: <20190927082508.GB1208@voidbox.localdomain>
References: <20190901142303.27815-1-repk@triplefau.lt>
 <20190925113351.0b53d2e9@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925113351.0b53d2e9@windsurf>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

Thanks for the review.

On Wed, Sep 25, 2019 at 11:33:51AM +0200, Thomas Petazzoni wrote:
> Hello Remi,
> 
> Thanks for the patch, I have a few comments/questions below.
> 
> On Sun,  1 Sep 2019 16:23:03 +0200
> Remi Pommarel <repk@triplefau.lt> wrote:
> 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index fc0fe4d4de49..1fa6d04ad7aa 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -175,7 +175,8 @@
> >  	(PCIE_CONF_BUS(bus) | PCIE_CONF_DEV(PCI_SLOT(devfn))	| \
> >  	 PCIE_CONF_FUNC(PCI_FUNC(devfn)) | PCIE_CONF_REG(where))
> >  
> > -#define PIO_TIMEOUT_MS			1
> > +#define PIO_RETRY_CNT			10
> > +#define PIO_RETRY_DELAY			100 /* 100 us*/
> >  
> >  #define LINK_WAIT_MAX_RETRIES		10
> >  #define LINK_WAIT_USLEEP_MIN		90000
> > @@ -383,17 +384,16 @@ static void advk_pcie_check_pio_status(struct advk_pcie *pcie)
> >  static int advk_pcie_wait_pio(struct advk_pcie *pcie)
> >  {
> >  	struct device *dev = &pcie->pdev->dev;
> > -	unsigned long timeout;
> > +	size_t i;
> 
> Is it common to use a size_t for a loop counter ?

It was for me but seem not to be used that much. I can change that to an
int.

> >  
> > -	timeout = jiffies + msecs_to_jiffies(PIO_TIMEOUT_MS);
> > -
> > -	while (time_before(jiffies, timeout)) {
> > +	for (i = 0; i < PIO_RETRY_CNT; ++i) {
> 
> I find it more common to use post-increment for loop counters rather
> than pre-increment, but that's a really nitpick and I don't care much.
> 

Will change that to post-increment.

> >  		u32 start, isr;
> >  
> >  		start = advk_readl(pcie, PIO_START);
> >  		isr = advk_readl(pcie, PIO_ISR);
> >  		if (!start && isr)
> >  			return 0;
> > +		udelay(PIO_RETRY_DELAY);
> 
> But the bigger issue is that this change causes a 100us delay at
> *every* single PIO read or write operation.
> 
> Indeed, at the first iteration of the loop, the PIO operation has not
> completed, so you will always hit the udelay(100) a first time, and
> it's only at the second iteration of the loop that the PIO operation
> has completed (for successful PIO operations of course, which don't hit
> the timeout).
> 
> I took a measurement around wait_pio() with sched_clock before and
> after the patch. Before the patch, I have measurements like this (in
> nanoseconds):
> 
> [    1.562801] time = 6000
> [    1.565310] time = 6000
> [    1.567809] time = 6080
> [    1.570327] time = 6080
> [    1.572836] time = 6080
> [    1.575339] time = 6080
> [    1.577858] time = 2720
> [    1.580366] time = 2720
> [    1.582862] time = 6000
> [    1.585377] time = 2720
> [    1.587890] time = 2720
> [    1.590393] time = 2720
> 
> So it takes a few microseconds for each PIO operation.
> 
> With your patch applied:
> 
> [    2.267291] time = 101680
> [    2.270002] time = 100880
> [    2.272852] time = 100800
> [    2.275573] time = 100880
> [    2.278285] time = 100800
> [    2.281005] time = 100880
> [    2.283722] time = 100800
> [    2.286444] time = 100880
> [    2.289264] time = 100880
> [    2.291981] time = 100800
> [    2.294690] time = 100800
> [    2.297405] time = 100800
> 
> We're jumping to 100us for every PIO read/write operation. To be
> honest, I don't know if this is very important, there are not that many
> PIO operations, and they are not used in any performance hot path. But
> I thought it was worth pointing out the additional delay caused by this
> implementation change.

Good catch thanks for the measurements, will move to a 2us delay.

-- 
Remi
