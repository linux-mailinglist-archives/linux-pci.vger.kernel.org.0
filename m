Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2177885585
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 00:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfHGWIk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Aug 2019 18:08:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfHGWIj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Aug 2019 18:08:39 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7257021872;
        Wed,  7 Aug 2019 22:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565215718;
        bh=Anq0fyzHSpNvpzissPJGid5WBnHTC6apYNeaT7/QbSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z48flQZqTjJaDYD05Ot7rpnOYeugqEJHgGY4XFE3IO059jgqSn5smN/EywZdfTVMs
         95zjsbsMzzwvJ+g8xBwap1ChAgu2CCvyplWosfaT/+gtusd69kWVbk08gnqT6F/Eef
         MD29vTCgdlJYft00UMFW6aUKhb3KhFfsuZoJyyGQ=
Date:   Wed, 7 Aug 2019 17:08:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mans Rullgard <mans@mansr.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v6 31/57] pci: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190807220837.GZ151852@google.com>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <20190730181557.90391-32-swboyd@chromium.org>
 <20190730215626.GA151852@google.com>
 <fece42c0-f511-173a-b16a-5b1f3a1c1a4e@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fece42c0-f511-173a-b16a-5b1f3a1c1a4e@free.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 07, 2019 at 04:09:10PM +0200, Marc Gonzalez wrote:
> On 30/07/2019 23:56, Bjorn Helgaas wrote:
> 
> >> diff --git a/drivers/pci/controller/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
> >> index 21a208da3f59..b87aa9041480 100644
> >> --- a/drivers/pci/controller/pcie-tango.c
> >> +++ b/drivers/pci/controller/pcie-tango.c
> >> @@ -273,10 +273,8 @@ static int tango_pcie_probe(struct platform_device *pdev)
> >>  		writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
> >>  
> >>  	virq = platform_get_irq(pdev, 1);
> >> -	if (virq <= 0) {
> >> -		dev_err(dev, "Failed to map IRQ\n");
> >> +	if (virq <= 0)
> >>  		return -ENXIO;
> >
> > Why <= 0 and -ENXIO?
> 
> Smirk. I remember discussing this in the past...
> Here it is:
> 
> 	https://patchwork.kernel.org/patch/10006651/

Sigh, what a mess.  I did say in that discussion that it wasn't worth
changing existing "irq <= 0" tests.  I can't remember why I said that,
but I think I was wrong.

platform_get_irq() is a generic interface and we have to be able to
interpret return values consistently.  The overwhelming consensus
among platform_get_irq() callers is to treat "irq < 0" as an error,
and I think we should follow suit.

> A) AFAIU platform_get_irq() = 0 signals an error.
> 
> 	https://yarchive.net/comp/linux/zero.html
> 	https://lkml.org/lkml/2016/2/9/212
> 	https://patchwork.ozlabs.org/patch/486056/
> 
> B) I don't remember why I picked ENXIO.
> Perhaps it made more sense to me (at the time) than EINVAL or ENODEV.

I think the best pattern is:

  irq = platform_get_irq(pdev, i);
  if (irq < 0)
    return irq;

There's not an overwhelming consensus on whether to return the result
of platform_get_irq() or a hard-coded -ENXIO/-EINVAL/-ENODEV etc, but
why throw away information?

Bjorn
