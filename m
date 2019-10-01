Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0778C441B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2019 01:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfJAXGZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 19:06:25 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33873 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfJAXGZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 19:06:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id m19so13130499otp.1;
        Tue, 01 Oct 2019 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fytjfeL2hboW36P5ZuUGnqHSPo8QfeVFETfrBcqUG5k=;
        b=ZTGpaP2g4NMZOIs14s7NeYu98JVG+DdiPC2DrhYdw0NmT1LIaAPI5iTpREmTgsLPdp
         HGu9TEyjKdC0OTGR1OrigUrTyvZ5dwS6mIPygsz+72Vrr1iyJC0Q9U141rTy1QjqrnTV
         ydZVxuUx2q9hvwThFYZ2nyl7Yg8+S88jj8j8nl010bU568L6ctG554GKEBw9L03a56ry
         jHeZVx5qFKacKkog2Kt3adYCp+itsdoXRl3uMai8yuMo0w99IwyBVIk8EEtHe6d97uy5
         bZgWwweRtHhMoS9lV/N21m/4wYFybZhl1VuN+8gJ56vSV5WYMTO9g1XK/9hjqp8wSPnL
         Y+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fytjfeL2hboW36P5ZuUGnqHSPo8QfeVFETfrBcqUG5k=;
        b=UsUF7zUhrMp4CouyCVBvQP4xFE6wD+kxhf5vGtI9vFoen3mPp7ExAU5S2DDQi2xLay
         ENBwCyzFtUdFnZYOgEQ31Pl/gX+lho1rnXOrsZhrKFBE9IrWVJ4cIhqrybU3UGtQZxb8
         NiJNdlm3HY3mqR+Y38RShZ6/Notav6O7WFYb9DOBPehO/BnMc0LNncE6dr6wkuTM3+ll
         d9OQni0/BJ0hpN0aWpzhAnQ2UxB4ygr24B2EN+HleV4B/WDcZg2xNZOTZVVVq83i8qDD
         SpREdOsxIerllflkpjbQ/lyt52mKTKVcxcQ5khgErHRbR8OekNg8l403oopGrnyu+4dp
         sR/w==
X-Gm-Message-State: APjAAAXt1FOgtdTgiKHz4o57TXt2BkvJRvzMPSu2gciAib6tT/xUmAEO
        tvyfl5UbX+twPuUCfVvJoTL0Fw+hgOESupDqsgM=
X-Google-Smtp-Source: APXvYqyAPbUlTT2vTBJG8UBvvwFR8eifgmKPhHf1LuKPLyTznT9OARbyY06LozvEjr7X0NWxRQKfFlKkdHazJLzmEy4=
X-Received: by 2002:a9d:6a59:: with SMTP id h25mr344859otn.324.1569971184510;
 Tue, 01 Oct 2019 16:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191001211419.11245-1-stuart.w.hayes@gmail.com>
 <20191001211419.11245-4-stuart.w.hayes@gmail.com> <b37c8640-9f48-8d0d-9e2e-80920c1e19e7@gmail.com>
In-Reply-To: <b37c8640-9f48-8d0d-9e2e-80920c1e19e7@gmail.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Date:   Tue, 1 Oct 2019 18:06:12 -0500
Message-ID: <CAL5oW00xbnYk5=nT9v3rS4QTLShGfvzBgQLtsFh7xO2OyZqL3A@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: pciehp: Add dmi table for in-band presence disabled
To:     "Alex G." <mr.nuke.me@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lukas@wunner.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 1, 2019 at 4:36 PM Alex G. <mr.nuke.me@gmail.com> wrote:
>
>
>
> On 10/1/19 4:14 PM, Stuart Hayes wrote:
> > Some systems have in-band presence detection disabled for hot-plug PCI slots,
> > but do not report this in the slot capabilities 2 (SLTCAP2) register.  On
> > these systems, presence detect can become active well after the link is
> > reported to be active, which can cause the slots to be disabled after a
> > device is connected.
> >
> > Add a dmi table to flag these systems as having in-band presence disabled.
> >
> > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > ---
> >   drivers/pci/hotplug/pciehp_hpc.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> > index 1282641c6458..1dd01e752587 100644
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -14,6 +14,7 @@
> >
> >   #define dev_fmt(fmt) "pciehp: " fmt
> >
> > +#include <linux/dmi.h>
> >   #include <linux/kernel.h>
> >   #include <linux/types.h>
> >   #include <linux/jiffies.h>
> > @@ -26,6 +27,16 @@
> >   #include "../pci.h"
> >   #include "pciehp.h"
> >
> > +static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
> > +     {
> > +             .ident = "Dell System",
> > +             .matches = {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
> > +             },
> > +     },
> > +     {}
> > +};
> > +
>
> I'm not sure that all Dell systems that were ever made or will be made
> have in-band presence disabled on all their hotplug slots.
>
> This was a problem with the NVMe hot-swap bays on 14G servers. I can't
> guarantee that any other slot or machine will need this workaround. The
> best way I found to implement this is to check for the PCI-ID of the
> switches behind the port.
>
> Alex

That is definitely true, not all Dell systems actually disable in-band
presence detect and need this.  However, we have a number of systems
that need this, and we don't have the PCI IDs for all of these yet, so
we decided it was preferable to just make all Dell systems wait for
presence detect to go active.  Since all of our systems support
presence detect (either in-band or out-of-band), it shouldn't have any
negative effects--on systems that support in-band presence, it will
already be active and it won't spend any extra time waiting for it.
If someone plugs in a device that has hot-plug slots with no support
for presence detect at all (even though Dell doesn't support any), it
should still work--it'll just take an extra second for them to come
up.
