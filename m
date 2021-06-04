Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3AF39B4E1
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 10:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFDIcI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 04:32:08 -0400
Received: from forward104o.mail.yandex.net ([37.140.190.179]:52091 "EHLO
        forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229900AbhFDIcH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 04:32:07 -0400
Received: from myt5-4fa6d87d1832.qloud-c.yandex.net (myt5-4fa6d87d1832.qloud-c.yandex.net [IPv6:2a02:6b8:c12:2507:0:640:4fa6:d87d])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id 40D47943357;
        Fri,  4 Jun 2021 11:30:20 +0300 (MSK)
Received: from myt4-1dda227af9a8.qloud-c.yandex.net (myt4-1dda227af9a8.qloud-c.yandex.net [2a02:6b8:c00:3c83:0:640:1dda:227a])
        by myt5-4fa6d87d1832.qloud-c.yandex.net (mxback/Yandex) with ESMTP id NcmETYSBFZ-UKJaZAWU;
        Fri, 04 Jun 2021 11:30:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1622795420;
        bh=COX8rlRgjdvgTLn/IGYbno+47uPWqRmZTNPUJbFgEus=;
        h=In-Reply-To:Cc:To:From:Subject:Message-ID:References:Date;
        b=fVhi3j7E8/OgALcA7A1biAsf9sy3L7Qp5rsE8iUH0drIxk/MK/9y7a4pO9HgzQ/77
         2TelGMtacpYI7KgUOwoghz+AW6RlVqx3b+FZzTn7QkeiNnKddk0UknJQTdg50qjeOW
         EJz94z2ldEyg9eABSAIrXsgunKakOWXjn3GHOLE8=
Authentication-Results: myt5-4fa6d87d1832.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt4-1dda227af9a8.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id FoWKTwhQ98-UJM0bCTB;
        Fri, 04 Jun 2021 11:30:19 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <f7e1788b71569937ebe94c29210311e677aba69f.camel@yandex.ru>
Subject: Re: PING: Re: PING: Re: [PATCH v2] PCI: don't call firmware hooks
 on suspend unless it's fw-controlled
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, lukas@wunner.de, rjw@rjwysocki.net,
        andreas.noever@gmail.com
Date:   Fri, 04 Jun 2021 11:30:17 +0300
In-Reply-To: <20210603174641.GA2127071@bjorn-Precision-5520>
References: <20210603174641.GA2127071@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cool, I see, thank you very much!

On Thu, 2021-06-03 at 12:46 -0500, Bjorn Helgaas wrote:
> On Thu, Jun 03, 2021 at 11:36:43AM +0300, Konstantin Kharlamov wrote:
> > On Fri, 2021-05-28 at 10:39 +0300, Konstantin Kharlamov wrote:
> > > On Fri, 2021-05-21 at 02:55 +0300, Konstantin Kharlamov wrote:
> > > > On Macbook 2013 resuming from s2idle resulted in external monitor no
> > > > longer being detected, and dmesg having errors like:
> > > > 
> > > >     pcieport 0000:06:00.0: can't change power state from D3hot to D0
> > > > (config
> > > > space inaccessible)
> > > > 
> > > > and a stacktrace. The reason is that in s2idle (and in S1 as noted by
> > > > Rafael) we do not call firmware code to handle suspend, and as result
> > > > while waking up firmware also does not handle resume.
> > > > 
> > > > This means, for the Thunderbolt controller that gets disabled in the
> > > > quirk by calling the firmware methods, there's no one to wake it back up
> > > > on resume.
> > > > 
> > > > To quote Rafael Wysocki:
> > > > 
> > > > > "Passing control to the platform firmware" means letting
> > > > > some native firmware code (like SMM code) run which happens at the end
> > > > > of S2/S3/S4 suspend transitions and it does not happen during S1
> > > > > (standby) and s2idle suspend transitions.
> > > > > 
> > > > > That's why using SXIO/SXFP/SXLF is only valid during S2/S3/S4 suspend
> > > > > transitions and it is not valid during s2idle and S1 suspend
> > > > > transitions (and yes, S1 is also affected, so s2idle is not special in
> > > > > that respect at all).
> > > > 
> > > > Thus, return early from the quirk when suspend mode isn't one that calls
> > > > firmware.
> > > > 
> > > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212767
> > > > Signed-off-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> > > > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > > > ---
> > > >  drivers/pci/quirks.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > index 653660e3ba9e..f86b6388a04a 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -27,6 +27,7 @@
> > > >  #include <linux/nvme.h>
> > > >  #include <linux/platform_data/x86/apple.h>
> > > >  #include <linux/pm_runtime.h>
> > > > +#include <linux/suspend.h>
> > > >  #include <linux/switchtec.h>
> > > >  #include <asm/dma.h>   /* isa_dma_bridge_buggy */
> > > >  #include "pci.h"
> > > > @@ -3646,6 +3647,15 @@ static void
> > > > quirk_apple_poweroff_thunderbolt(struct
> > > > pci_dev *dev)
> > > >                 return;
> > > >         if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
> > > >                 return;
> > > > +
> > > > +       /*
> > > > +        * SXIO/SXFP/SXLF turns off power to the Thunderbolt
> > > > controller.  We
> > > > don't
> > > > +        * know how to turn it back on again, but firmware does, so we
> > > > can
> > > > only use
> > > > +        * SXIO/SXFP/SXLF if we're suspending via firmware.
> > > > +        */
> > > > +       if (!pm_suspend_via_firmware())
> > > > +               return;
> > > > +
> > > >         bridge = ACPI_HANDLE(&dev->dev);
> > > >         if (!bridge)
> > > >                 return;
> > > 
> > > 
> > 
> > 
> 
> Don't worry, I haven't forgotten, but I've been busy with some other
> patches.  If you ever want to check on the status, you can search for
> the patch on https://patchwork.kernel.org/project/linux-pci/list.  The
> patchwork search is not super convenient (it's buried in the "Show
> patches with" link), but here's your patch:
> 
> https://patchwork.kernel.org/project/linux-pci/patch/20210520235501.917397-1-Hi-Angel@yandex.ru/
> 
> It's currently "New" which means it's still in my queue.  I change the
> state to "Accepted," "Not Applicable," "Superseded," etc., when I
> apply or drop patches.


