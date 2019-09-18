Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBDCFB6F2E
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2019 00:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfIRWEK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Sep 2019 18:04:10 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42821 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730553AbfIRWEK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Sep 2019 18:04:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id c10so1261888otd.9;
        Wed, 18 Sep 2019 15:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bJQPPaEQfRujWhva+eG3XWYsZN4JmOiFGTYIBU8GRfQ=;
        b=pRYjGPKum5sL1wmzZ9BkqD8WS3k+maV7QIjP9a80SpLanQdxpuhayzpRdkmhrZa7Tp
         lI7wrYSKIr9rz5AhAhuyg50ioxU1QDlWlfmIc/3R4mJB6yN5jQiJnXd5q29TkCGw9DZs
         NVwCPi6WVfvLjoJ+nUFQ3FKrIK7ofeuo1oYuLhnOwlzWAoQKdzOIfC/XVSiKvI2ke5T6
         TtjhjurAKAXa8x4Y9CrvuIEfAvds/noLSLEB+kUkZGjBBIkIBpW5s//DHHASaoHD+LXu
         7NrzbIBqGWR2viBFoYfME+UXeV9dBF66B0xgk3PJ61felxO6/KpyvMK0bNN7WF2/0CkF
         FKaw==
X-Gm-Message-State: APjAAAVZSHR66Z20NEGjyWlv/uXrjyYpKrNXM1qCmW0o0+aYMvlgP3SM
        0vaAoTDIyQDj5cVueIiwlgRs+iyL3MW2GDFdV3I=
X-Google-Smtp-Source: APXvYqy4t38dZCR52mMACnH8PhL4bjKROen1EQLwOHpraGIwLh95YbB75ppd/j9YGKJ3hGlXh2Xry/BpznO93HaN/dM=
X-Received: by 2002:a9d:798c:: with SMTP id h12mr4348107otm.167.1568844249341;
 Wed, 18 Sep 2019 15:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <1568245353-13787-1-git-send-email-mario.limonciello@dell.com>
 <4858057.cjDlXVALXj@kreacher> <346fd9ced98e40229d0cc0871ad5ed32@AUSX13MPC105.AMER.DELL.COM>
 <10489808.bq04Fa26WH@kreacher> <247e1ed126774d32b0d70092b65adb6a@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <247e1ed126774d32b0d70092b65adb6a@AUSX13MPC105.AMER.DELL.COM>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Sep 2019 00:03:57 +0200
Message-ID: <CAJZ5v0iwovZtCnnu+CF5Z6DjRsC2a43Jdi+9SEufADAOF8sCcg@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into
 deepest state
To:     Mario Limonciello <Mario.Limonciello@dell.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ryan.Hong@dell.com, Crag.Wang@dell.com, sjg@google.com,
        Jared.Dominguez@dell.com, Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 19, 2019 at 12:00 AM <Mario.Limonciello@dell.com> wrote:
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Sent: Wednesday, September 18, 2019 4:57 PM
> > To: Limonciello, Mario
> > Cc: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-
> > nvme@lists.infradead.org; linux-kernel@vger.kernel.org; Hong, Ryan; Wang,
> > Crag; sjg@google.com; Dominguez, Jared; linux-pci@vger.kernel.org; linux-
> > pm@vger.kernel.org
> > Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into deepest
> > state
> >
> >
> > [EXTERNAL EMAIL]
> >
> > On Wednesday, September 18, 2019 11:43:28 PM CEST
> > Mario.Limonciello@dell.com wrote:
> > > > -----Original Message-----
> > > > From: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > > Sent: Wednesday, September 18, 2019 4:31 PM
> > > > To: Limonciello, Mario
> > > > Cc: Keith Busch; Jens Axboe; Christoph Hellwig; Sagi Grimberg; linux-
> > > > nvme@lists.infradead.org; LKML; Hong, Ryan; Wang, Crag; sjg@google.com;
> > > > Dominguez, Jared; Linux PCI; Linux PM
> > > > Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into
> > deepest
> > > > state
> > > >
> > > >
> > > > [EXTERNAL EMAIL]
> > > >
> > > > On Thursday, September 12, 2019 1:42:33 AM CEST Mario Limonciello wrote:
> > > > > The action of saving the PCI state will cause numerous PCI configuration
> > > > > space reads which depending upon the vendor implementation may cause
> > > > > the drive to exit the deepest NVMe state.
> > > > >
> > > > > In these cases ASPM will typically resolve the PCIe link state and APST
> > > > > may resolve the NVMe power state.  However it has also been observed
> > > > > that this register access after quiesced will cause PC10 failure
> > > > > on some device combinations.
> > > > >
> > > > > To resolve this, move the PCI state saving to before SetFeatures has been
> > > > > called.  This has been proven to resolve the issue across a 5000 sample
> > > > > test on previously failing disk/system combinations.
> > > >
> > > > This sounds reasonable to me, but it would be nice to CC that to linux-pm
> > > > and/or linux-pci too.
> > > >
> > > > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > > > ---
> > > > >  drivers/nvme/host/pci.c | 13 +++++++------
> > > > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > > > index 732d5b6..9b3fed4 100644
> > > > > --- a/drivers/nvme/host/pci.c
> > > > > +++ b/drivers/nvme/host/pci.c
> > > > > @@ -2894,6 +2894,13 @@ static int nvme_suspend(struct device *dev)
> > > > >         if (ret < 0)
> > > > >                 goto unfreeze;
> > > > >
> > > > > +       /*
> > > > > +        * A saved state prevents pci pm from generically controlling the
> > > > > +        * device's power. If we're using protocol specific settings, we don't
> > > > > +        * want pci interfering.
> > > > > +        */
> > > > > +       pci_save_state(pdev);
> > > > > +
> > > > >         ret = nvme_set_power_state(ctrl, ctrl->npss);
> > > > >         if (ret < 0)
> > > > >                 goto unfreeze;
> > > > > @@ -2908,12 +2915,6 @@ static int nvme_suspend(struct device *dev)
> > > >
> > > > This is the case in which the PCI layer is expected to put the device into
> > > > D3, so you need
> > > >
> > > > pdev->state_saved = 0;
> > > >
> > > > at this point, because you have saved the config space already.
> > > >
> > > > >                 ret = 0;
> > > > >                 goto unfreeze;
> > > >
> > > > And here you don't need to jump to "unfreeze" any more.
> > > >
> > > > >         }
> > > > > -       /*
> > > > > -        * A saved state prevents pci pm from generically controlling the
> > > > > -        * device's power. If we're using protocol specific settings, we don't
> > > > > -        * want pci interfering.
> > > > > -        */
> > > > > -       pci_save_state(pdev);
> > > > >  unfreeze:
> > > > >         nvme_unfreeze(ctrl);
> > > > >         return ret;
> > > > >
> > > >
> > > >
> > > >
> > >
> > > Thanks, I actually followed up with something along that line in a v2 sent out
> > > today.  My apology you weren't in CC, but here is a weblink to it.
> > > http://lists.infradead.org/pipermail/linux-nvme/2019-September/027251.html
> > >
> >
> > I don't think that pci_load_saved_state() will work, because it sets
> > state_saved at the end again (if all goes well).  You simply only need to
> > clear state_saved here.
>
> Explicitly calling it with NULL as the saved state to restore seemed to have that effect
> of clearing state (there is an explicit check in there if it's NULL to just return 0).

Ah, OK, right.

I still would rather clear the flag directly, though, as using
pci_load_saved_state() for that is just more convoluted. :-)
