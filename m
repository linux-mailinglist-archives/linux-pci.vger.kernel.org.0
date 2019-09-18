Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8ACB6F1A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2019 23:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbfIRV5K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Sep 2019 17:57:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46989 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732268AbfIRV5J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Sep 2019 17:57:09 -0400
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id b726423193c484be; Wed, 18 Sep 2019 23:57:07 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mario.Limonciello@dell.com
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ryan.Hong@dell.com, Crag.Wang@dell.com, sjg@google.com,
        Jared.Dominguez@dell.com, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into deepest state
Date:   Wed, 18 Sep 2019 23:57:07 +0200
Message-ID: <10489808.bq04Fa26WH@kreacher>
In-Reply-To: <346fd9ced98e40229d0cc0871ad5ed32@AUSX13MPC105.AMER.DELL.COM>
References: <1568245353-13787-1-git-send-email-mario.limonciello@dell.com> <4858057.cjDlXVALXj@kreacher> <346fd9ced98e40229d0cc0871ad5ed32@AUSX13MPC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, September 18, 2019 11:43:28 PM CEST Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Sent: Wednesday, September 18, 2019 4:31 PM
> > To: Limonciello, Mario
> > Cc: Keith Busch; Jens Axboe; Christoph Hellwig; Sagi Grimberg; linux-
> > nvme@lists.infradead.org; LKML; Hong, Ryan; Wang, Crag; sjg@google.com;
> > Dominguez, Jared; Linux PCI; Linux PM
> > Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into deepest
> > state
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Thursday, September 12, 2019 1:42:33 AM CEST Mario Limonciello wrote:
> > > The action of saving the PCI state will cause numerous PCI configuration
> > > space reads which depending upon the vendor implementation may cause
> > > the drive to exit the deepest NVMe state.
> > >
> > > In these cases ASPM will typically resolve the PCIe link state and APST
> > > may resolve the NVMe power state.  However it has also been observed
> > > that this register access after quiesced will cause PC10 failure
> > > on some device combinations.
> > >
> > > To resolve this, move the PCI state saving to before SetFeatures has been
> > > called.  This has been proven to resolve the issue across a 5000 sample
> > > test on previously failing disk/system combinations.
> > 
> > This sounds reasonable to me, but it would be nice to CC that to linux-pm
> > and/or linux-pci too.
> > 
> > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > ---
> > >  drivers/nvme/host/pci.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > index 732d5b6..9b3fed4 100644
> > > --- a/drivers/nvme/host/pci.c
> > > +++ b/drivers/nvme/host/pci.c
> > > @@ -2894,6 +2894,13 @@ static int nvme_suspend(struct device *dev)
> > >  	if (ret < 0)
> > >  		goto unfreeze;
> > >
> > > +	/*
> > > +	 * A saved state prevents pci pm from generically controlling the
> > > +	 * device's power. If we're using protocol specific settings, we don't
> > > +	 * want pci interfering.
> > > +	 */
> > > +	pci_save_state(pdev);
> > > +
> > >  	ret = nvme_set_power_state(ctrl, ctrl->npss);
> > >  	if (ret < 0)
> > >  		goto unfreeze;
> > > @@ -2908,12 +2915,6 @@ static int nvme_suspend(struct device *dev)
> > 
> > This is the case in which the PCI layer is expected to put the device into
> > D3, so you need
> > 
> > pdev->state_saved = 0;
> > 
> > at this point, because you have saved the config space already.
> > 
> > >  		ret = 0;
> > >  		goto unfreeze;
> > 
> > And here you don't need to jump to "unfreeze" any more.
> > 
> > >  	}
> > > -	/*
> > > -	 * A saved state prevents pci pm from generically controlling the
> > > -	 * device's power. If we're using protocol specific settings, we don't
> > > -	 * want pci interfering.
> > > -	 */
> > > -	pci_save_state(pdev);
> > >  unfreeze:
> > >  	nvme_unfreeze(ctrl);
> > >  	return ret;
> > >
> > 
> > 
> > 
> 
> Thanks, I actually followed up with something along that line in a v2 sent out
> today.  My apology you weren't in CC, but here is a weblink to it.
> http://lists.infradead.org/pipermail/linux-nvme/2019-September/027251.html
> 

I don't think that pci_load_saved_state() will work, because it sets
state_saved at the end again (if all goes well).  You simply only need to
clear state_saved here.




