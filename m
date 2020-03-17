Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 028681890F6
	for <lists+linux-pci@lfdr.de>; Tue, 17 Mar 2020 23:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgCQWDh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Mar 2020 18:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgCQWDh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Mar 2020 18:03:37 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BC4B20714;
        Tue, 17 Mar 2020 22:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584482616;
        bh=NRUE2ckhs8n5Ozlq9QGah87GvPHMhCBA9ESXYy5Zdtg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1QGfUU91mkGNhqaAE5qkukrE5YGD0RThABDfnFSsg6yyPBnpZ/OoVSS8JJFuWo23r
         ThYXwUFPgcoopP7DR1QbWF1dlJInVWRqKWlMr64DZHN0CZJTsg5h3FzHB7jeKPHdn0
         O36i7OCDqShLa3H4tFGVcqvDcEDogrn3BnfyYFBg=
Date:   Tue, 17 Mar 2020 17:03:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Aman Sharma <amanharitsh123@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Mans Rullgard <mans@mansr.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 4/5] pci: handled return value of platform_get_irq
 correctly
Message-ID: <20200317220334.GA230141@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313215642.GA202015@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 13, 2020 at 04:56:42PM -0500, Bjorn Helgaas wrote:
> On Fri, Mar 13, 2020 at 10:05:58PM +0100, Thomas Gleixner wrote:
> > Bjorn Helgaas <helgaas@kernel.org> writes:
> > > On Thu, Mar 12, 2020 at 10:53:06AM +0100, Marc Gonzalez wrote:
> > >> Last time around, my understanding was that, going forward,
> > >> the best solution was:
> > >> 
> > >> 	virq = platform_get_irq(...)
> > >> 	if (virq <= 0)
> > >> 		return virq ? : -ENODEV;
> > >> 
> > >> i.e. map 0 to -ENODEV, pass other errors as-is, remove the dev_err
> > >> 
> > >> @Bjorn/Lorenzo did you have a change of heart?
> > >
> > > Yes.  In 10006651 (Oct 20, 2017), I thought:
> > >
> > >   irq = platform_get_irq(pdev, 0);
> > >   if (irq <= 0)
> > >     return -ENODEV;
> > >
> > > was fine.  In 11066455 (Aug 7, 2019), I said I thought I was wrong and
> > > that:
> > >
> > >   platform_get_irq() is a generic interface and we have to be able to
> > >   interpret return values consistently.  The overwhelming consensus
> > >   among platform_get_irq() callers is to treat "irq < 0" as an error,
> > >   and I think we should follow suit.
> > >   ...
> > >   I think the best pattern is:
> > >
> > >     irq = platform_get_irq(pdev, i);
> > >     if (irq < 0)
> > >       return irq;
> > 
> > Careful. 0 is not a valid interrupt.
> 
> Should callers of platform_get_irq() check for a 0 return value?
> About 900 of them do not.
> 
> Or should platform_get_irq() return a negative error instead of 0?
> If 0 is not a valid interrupt, I think it would be easier to use the
> interface if we made it so platform_get_irq() could never return 0,
> which I think would also fit the interface documentation better:
> 
>  * Return: IRQ number on success, negative error number on failure.

Trying again -- I'm not quite catching your meaning, Thomas.

If platform_get_irq*() can return 0, but 0 is not a valid IRQ, I think
it's sort of complicated to parse that return value.  Drivers that
require an IRQ would do this:

  irq = platform_get_irq(pdev, i);
  if (irq < 0)
    return irq;
  if (irq == 0)
    return -EINVAL;         # error since driver requires IRQ
  return devm_request_irq(dev, irq, ...);

Drivers that can either use an IRQ or do polling would do this:

  irq = platform_get_irq(pdev, i);
  if (irq <= 0)
    return setup_polling();
  return devm_request_irq(dev, irq, ...);

I think those are sort of ungainly, especially the first.  If we made
it so those functions never returned 0, drivers that need an IRQ could
do this:

  irq = platform_get_irq(pdev, i);
  if (irq < 0)
    return irq;
  return devm_request_irq(dev, irq, ...);

and drivers that support polling could do this:

  irq = platform_get_irq(pdev, i);
  if (irq < 0)
    return setup_polling();
  return devm_request_irq(dev, irq, ...);

That seems a lot easier to get correct, and it matches what most of
the callers already do.
