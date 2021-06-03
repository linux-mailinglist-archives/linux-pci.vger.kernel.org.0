Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A2739A97B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 19:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFCRs2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 13:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbhFCRs2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 13:48:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4634E60FDB;
        Thu,  3 Jun 2021 17:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622742403;
        bh=+HHp4UXAo+J8a+FEibLbKaSIdzhKyVOgbNvxhLjQ67s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cIhN9HTmAcrwOaZNHlrI7jNC3nzsQngkt8tqQ/quCYpTWlbzz50gQt2nuyMrrW5VP
         e5Y2h1wTb9Goc4M9PyavwDRD0rYnV3w7PdqaQJtSsvp6s1Mbzszvktl88RHunu3LGy
         t1mz6BzvyGo6IpdEHvAyEaMw0Vk+xx6KSH2ssBDtdTUkocN6bs/D2ygOYFRHNBqa/5
         n+8FFQ6zI8arOc+QYHTpN/wj7C9n8+t4bXWLNycuOQfsOCOZ1INP6CLYmYAfZy4NMi
         y9/ak7o+o/94guPHH9S6/R0pI2ADC3Aj50sXui/OliRU2Wa+p0rgy5oYBiXx2pmLqu
         Wnf7Ijk0tLHmg==
Date:   Thu, 3 Jun 2021 12:46:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     linux-pci@vger.kernel.org, lukas@wunner.de, rjw@rjwysocki.net,
        andreas.noever@gmail.com
Subject: Re: PING: Re: PING: Re: [PATCH v2] PCI: don't call firmware hooks on
 suspend unless it's fw-controlled
Message-ID: <20210603174641.GA2127071@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e5bf5bdd0238b6fb7ee79d68d4d834b5899d22b.camel@yandex.ru>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 03, 2021 at 11:36:43AM +0300, Konstantin Kharlamov wrote:
> On Fri, 2021-05-28 at 10:39 +0300, Konstantin Kharlamov wrote:
> > On Fri, 2021-05-21 at 02:55 +0300, Konstantin Kharlamov wrote:
> > > On Macbook 2013 resuming from s2idle resulted in external monitor no
> > > longer being detected, and dmesg having errors like:
> > > 
> > >     pcieport 0000:06:00.0: can't change power state from D3hot to D0 (config
> > > space inaccessible)
> > > 
> > > and a stacktrace. The reason is that in s2idle (and in S1 as noted by
> > > Rafael) we do not call firmware code to handle suspend, and as result
> > > while waking up firmware also does not handle resume.
> > > 
> > > This means, for the Thunderbolt controller that gets disabled in the
> > > quirk by calling the firmware methods, there's no one to wake it back up
> > > on resume.
> > > 
> > > To quote Rafael Wysocki:
> > > 
> > > > "Passing control to the platform firmware" means letting
> > > > some native firmware code (like SMM code) run which happens at the end
> > > > of S2/S3/S4 suspend transitions and it does not happen during S1
> > > > (standby) and s2idle suspend transitions.
> > > > 
> > > > That's why using SXIO/SXFP/SXLF is only valid during S2/S3/S4 suspend
> > > > transitions and it is not valid during s2idle and S1 suspend
> > > > transitions (and yes, S1 is also affected, so s2idle is not special in
> > > > that respect at all).
> > > 
> > > Thus, return early from the quirk when suspend mode isn't one that calls
> > > firmware.
> > > 
> > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212767
> > > Signed-off-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> > > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > > ---
> > >  drivers/pci/quirks.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 653660e3ba9e..f86b6388a04a 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -27,6 +27,7 @@
> > >  #include <linux/nvme.h>
> > >  #include <linux/platform_data/x86/apple.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <linux/suspend.h>
> > >  #include <linux/switchtec.h>
> > >  #include <asm/dma.h>   /* isa_dma_bridge_buggy */
> > >  #include "pci.h"
> > > @@ -3646,6 +3647,15 @@ static void quirk_apple_poweroff_thunderbolt(struct
> > > pci_dev *dev)
> > >                 return;
> > >         if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
> > >                 return;
> > > +
> > > +       /*
> > > +        * SXIO/SXFP/SXLF turns off power to the Thunderbolt controller.  We
> > > don't
> > > +        * know how to turn it back on again, but firmware does, so we can
> > > only use
> > > +        * SXIO/SXFP/SXLF if we're suspending via firmware.
> > > +        */
> > > +       if (!pm_suspend_via_firmware())
> > > +               return;
> > > +
> > >         bridge = ACPI_HANDLE(&dev->dev);
> > >         if (!bridge)
> > >                 return;
> > 
> > 
> 
> 

Don't worry, I haven't forgotten, but I've been busy with some other
patches.  If you ever want to check on the status, you can search for
the patch on https://patchwork.kernel.org/project/linux-pci/list.  The
patchwork search is not super convenient (it's buried in the "Show
patches with" link), but here's your patch:

https://patchwork.kernel.org/project/linux-pci/patch/20210520235501.917397-1-Hi-Angel@yandex.ru/

It's currently "New" which means it's still in my queue.  I change the
state to "Accepted," "Not Applicable," "Superseded," etc., when I
apply or drop patches.
