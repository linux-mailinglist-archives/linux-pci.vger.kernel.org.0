Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F328356D63
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344467AbhDGNhh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 09:37:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233071AbhDGNhg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 09:37:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E11861246;
        Wed,  7 Apr 2021 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617802647;
        bh=mrQ+Tm9p4blQbqcBd/No61KqFpi6MoGU+N73xYe9Hd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dakhUNsMCUgRJpYExHY5DP+8MwFdh9zNH2uIlFX0ZjA8RarfeVZSM33KYVPWEl4D8
         gDWhEH70bTa21CdezzxVT0Z3kjYG6dzK0pqDVOAxWorEC9248v2pNJPxYfs9p7P+s8
         4NKnYbuXwM+Z3HiQuGVbdIqY10XjinL8cODJ5lyk4stD3d0qgWE8dInb40jp5C6/ju
         CnFdHqzHyMXN/32hc+NXjs0rzo/ps8xbJE/p8h0oau8vY5gKSJbPt9aLr8zJsE1fbF
         cwLafD3dNmnXZNELYOzEWfi99TJgetlRskL8dClWEeT4h4kh7Vj9ZFwVSK/psq/jlP
         Z9XxWwBrKz+qw==
Date:   Wed, 7 Apr 2021 16:37:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "ameynarkhede03@gmail.com" <ameynarkhede03@gmail.com>
Cc:     Raphael Norwitz <raphael.norwitz@nutanix.com>,
        AlexWilliamson@archlinux, alex.williamson@redhat.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: merge slot and bus reset implementations
Message-ID: <YG21k6/4QQNrw41S@unreal>
References: <20210401053656.16065-1-raphael.norwitz@nutanix.com>
 <YGW8Oe9jn+n9sVsw@unreal>
 <20210401105616.71156d08@omen>
 <YGlzEA5HL6ZvNsB8@unreal>
 <20210406081626.31f19c0f@x1.home.shazbot.org>
 <YG1eBUY0vCTV+Za/@unreal>
 <20210407082356.53subv4np2fx777x@archlinux>
 <YG2l+AbQW1N0bbQ9@unreal>
 <20210407130601.aleyww5d5mttitry@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407130601.aleyww5d5mttitry@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 07, 2021 at 06:36:01PM +0530, ameynarkhede03@gmail.com wrote:
> On 21/04/07 03:30PM, Leon Romanovsky wrote:
> > On Wed, Apr 07, 2021 at 01:53:56PM +0530, ameynarkhede03@gmail.com wrote:
> > > On 21/04/07 10:23AM, Leon Romanovsky wrote:
> > > > On Tue, Apr 06, 2021 at 08:16:26AM -0600, Alex Williamson wrote:
> > > > > On Sun, 4 Apr 2021 11:04:32 +0300
> > > > > Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > > On Thu, Apr 01, 2021 at 10:56:16AM -0600, Alex Williamson wrote:
> > > > > > > On Thu, 1 Apr 2021 15:27:37 +0300
> > > > > > > Leon Romanovsky <leon@kernel.org> wrote:
> > > > > > >
> > > > > > > > On Thu, Apr 01, 2021 at 05:37:16AM +0000, Raphael Norwitz wrote:
> > > > > > > > > Slot resets are bus resets with additional logic to prevent a device
> > > > > > > > > from being removed during the reset. Currently slot and bus resets have
> > > > > > > > > separate implementations in pci.c, complicating higher level logic. As
> > > > > > > > > discussed on the mailing list, they should be combined into a generic
> > > > > > > > > function which performs an SBR. This change adds a function,
> > > > > > > > > pci_reset_bus_function(), which first attempts a slot reset and then
> > > > > > > > > attempts a bus reset if -ENOTTY is returned, such that there is now a
> > > > > > > > > single device agnostic function to perform an SBR.
> > > > > > > > >
> > > > > > > > > This new function is also needed to add SBR reset quirks and therefore
> > > > > > > > > is exposed in pci.h.
> > > > > > > > >
> > > > > > > > > Link: https://lkml.org/lkml/2021/3/23/911
> > > > > > > > >
> > > > > > > > > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > > > > > > > > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > > > > > > > > Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/pci/pci.c   | 17 +++++++++--------
> > > > > > > > >  include/linux/pci.h |  1 +
> > > > > > > > >  2 files changed, 10 insertions(+), 8 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > > > > > index 16a17215f633..12a91af2ade4 100644
> > > > > > > > > --- a/drivers/pci/pci.c
> > > > > > > > > +++ b/drivers/pci/pci.c
> > > > > > > > > @@ -4982,6 +4982,13 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
> > > > > > > > >  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +int pci_reset_bus_function(struct pci_dev *dev, int probe)
> > > > > > > > > +{
> > > > > > > > > +	int rc = pci_dev_reset_slot_function(dev, probe);
> > > > > > > > > +
> > > > > > > > > +	return (rc == -ENOTTY) ? pci_parent_bus_reset(dev, probe) : rc;
> > > > > > > >
> > > > > > > > The previous coding style is preferable one in the Linux kernel.
> > > > > > > > int rc = pci_dev_reset_slot_function(dev, probe);
> > > > > > > > if (rc != -ENOTTY)
> > > > > > > >   return rc;
> > > > > > > > return pci_parent_bus_reset(dev, probe);
> > > > > > >
> > > > > > >
> > > > > > > That'd be news to me, do you have a reference?  I've never seen
> > > > > > > complaints for ternaries previously.  Thanks,
> > > > > >
> > > > > > The complaint is not to ternaries, but to the function call as one of
> > > > > > the parameters, that makes it harder to read.
> > > > >
> > > > > Sorry, I don't find a function call as a parameter to a ternary to be
> > > > > extraordinary, nor do I find it to be a discouraged usage model within
> > > > > the kernel.  This seems like a pretty low bar for hard to read code.
> > > >
> > > > It is up to us where this bar is set.
> > > >
> > > > Thanks
> > > On the side note there are plenty of places where this pattern is used
> > > though
> > > for example -
> > > kernel/time/clockevents.c:328:
> > > return force ? clockevents_program_min_delta(dev) : -ETIME;
> > >
> > > kernel/trace/trace_kprobe.c:233:
> > > return tk ? within_error_injection_list(trace_kprobe_address(tk)) :
> > >        false;
> > >
> > > kernel/signal.c:3104:
> > > return oset ? put_compat_sigset(oset, &old_set, sizeof(*oset)) : 0;
> > > etc
> >
> > Did you look when they were introduced?
> >
> > Thanks
> >
> that code trace_kprobe in 2 years old.
> If you want more recent example checkout
> drivers/pci/controller/pcie-brcmstb.c:1112,1117:
> return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
> which was introduced 7 months ago.
> There are lot of examples in pci.c also.

Yeah, I know, copy-paste is a powerful tool.

Can we please progress with this patch instead of doing
archaeological research?

Thanks

> 
> Thanks,
> Amey
