Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59FF2E3915
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409916AbfJXRA0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405976AbfJXRAZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:00:25 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8CA620650;
        Thu, 24 Oct 2019 17:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571936425;
        bh=UDrL7Eh7U+eVIgDXosqXMSMhduI5UY6yvtzf3Iu2KLo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K/FZbRWQuMpqS+6cyL7g0IqL6xVs2eJwzYG2NRs4oNg5To1xEo5ukILSYaTLiSpsB
         gTjRi8KiCTnsnVyTDrajfuPx/rOBbF2ogQmOwgcwlKMt0knR8C/sZU/m3iefvTHHUp
         XQ5kVHp8GJkqHHrcjhOEkPw7HiBABTr/deI+2Kd0=
Date:   Thu, 24 Oct 2019 12:00:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
Message-ID: <20191024170023.GA135695@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8Lp46KZmTzxjYN6T7u1xH0AODr38hFcCgR-COtvduK9ZuANQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 24, 2019 at 11:28:59AM +0800, Daniel Drake wrote:
> On Thu, Oct 24, 2019 at 6:40 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > I think we need something like the patch below.  We already do
> > basically the same thing in pci_pm_reset().
> >
> > [1] https://gist.github.com/dsd/bd9370b35defdf43680b81ecb34381d5
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index e7982af9a5d8..e8702388830f 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -883,9 +883,10 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
> >          * Mandatory power management transition delays; see PCI PM 1.1
> >          * 5.6.1 table 18
> >          */
> > -       if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
> > +       if (state == PCI_D3hot || dev->current_state == PCI_D3hot) {
> >                 pci_dev_d3_sleep(dev);
> > -       else if (state == PCI_D2 || dev->current_state == PCI_D2)
> > +               pci_dev_wait(dev, "D3 transition", PCIE_RESET_READY_POLL_MS);
> > +       } else if (state == PCI_D2 || dev->current_state == PCI_D2)
> >                 udelay(PCI_PM_D2_DELAY);
> >
> >         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> 
> You also need to move the pci_dev_wait function definition higher up
> in the file.

OK, that would need a little tweaking.  Also, we should only need this
for the D3hot->D0 transition and probably only when No_Soft_Reset is
clear.  We shouldn't need it for the D0->D3hot transition, since
that's not a reset.

> Tested and that doesn't help this case unfortunately. pci_dev_wait
> doesn't do anything since PCI_COMMAND value at this point is 0x100403

That's really strange.  Your original message showed:

  xhci_hcd 0000:03:00.4: Refused to change power state, currently in D3
  xhci_hcd 0000:03:00.4: enabling device (0000 -> 0002)

The first line is from pci_raw_set_power_state() reading PCI_PM_CTRL,
but we can't tell whether the read failed and we got ~0, or it
succeeded and we got something with just the low two bits set.  Can
you print out the whole value so we can see what happened?

The second line is from pci_enable_resources() reading PCI_COMMAND,
and it got *0*, not 0x0403 as you got from the CRS experiment.
