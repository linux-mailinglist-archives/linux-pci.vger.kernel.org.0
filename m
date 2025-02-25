Return-Path: <linux-pci+bounces-22285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB2AA4343E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 05:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7FB77A4E44
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 04:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297E924EF96;
	Tue, 25 Feb 2025 04:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IK4Q1qfa"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6504D5AB;
	Tue, 25 Feb 2025 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740458538; cv=none; b=aRB1q6nTsnjpb68uNuj1uMscLw3Q0LbwdNwEEtT3Co+IbzzVfQTjnly7v9t0becMi/T4hhaqUo1iYjLGmbfQ3Ih7AVtwHGjAnIOS7oMnBSklKmvXoneo1wblI3DSqe2gWfaRQPBODBW6XU/o+U3JXsl63VF0IBtTAsMQD/HHsA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740458538; c=relaxed/simple;
	bh=v9T+B0y3NgzEn7lGEYaaaJwmIjnTy+JIkpd0BYOY/6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdhXnGuQa5ySrBUcnlVGLhMmiJZOXXeb5jXlTX6fiwMtWLU0jsjCXSI7U4sr6jxpO+JapU663t+9lKUfnT5Cv9sK2gRGCr82K/7DwINiHLe/OaXDKv3nZMZVQDU20y3Q07RxZrn+alJgu6Fo+GnxcP3704h2YatTMoOu6UbTXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IK4Q1qfa; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740458526; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=cBUl1NEp9OqdS9s8T2iCnWrW+e1GgC4qCc83R/nWRZ4=;
	b=IK4Q1qfawfPwJxjXXr9DBSbixTgSvuLFCNiIsAyBCyTtCKmppoXfFc7pcB44HMj/KxqklHsaFrz6SKgnQMyvPB6EP4OKB5Kmu5pWJvFyjcCCsxFjrV8JumQoZIbVRR6S7eMHZy59bWeiVC3Cf0iFeHHJUcar3c+Yqtz/PzJcX70=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WQDJ-d-_1740458525 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 12:42:05 +0800
Date: Tue, 25 Feb 2025 12:42:04 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Lukas Wunner <lukas@wunner.de>, rafael@kernel.org
Cc: rafael@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI/portdrv: Add necessary wait for disabling
 hotplug events
Message-ID: <Z71KHDbgrPFaoPO7@U-2FWC9VHC-2323.local>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
 <20250224034500.23024-3-feng.tang@linux.alibaba.com>
 <Z7y2e-EJLijQsp8D@wunner.de>
 <Z70zyhZe6OrxNNT3@U-2FWC9VHC-2323.local>
 <Z71Ap7kpV4rfhFDU@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z71Ap7kpV4rfhFDU@wunner.de>

Hi Lukas,

On Tue, Feb 25, 2025 at 05:01:43AM +0100, Lukas Wunner wrote:
> On Tue, Feb 25, 2025 at 11:06:50AM +0800, Feng Tang wrote:
> > On Mon, Feb 24, 2025 at 07:12:11PM +0100, Lukas Wunner wrote:
> > > On Mon, Feb 24, 2025 at 11:44:58AM +0800, Feng Tang wrote:
> > > > @@ -255,8 +271,7 @@ static int get_port_device_capability(struct pci_dev *dev)
> > > >  		 * Disable hot-plug interrupts in case they have been enabled
> > > >  		 * by the BIOS and the hot-plug service driver is not loaded.
> > > >  		 */
> > > > -		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
> > > > -			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
> > > > +		pcie_disable_hp_interrupts_early(dev);
> > > >  	}
> > > 
> > > Moving the Slot Control code from pciehp to portdrv (as is done in
> > > patch 1 of this series) is hackish.  It should be avoided if at all
> > > possible.
> > 
> > I tried to remove the code duplication of 2 waiting function, according
> > to Bjorn's comment in https://lore.kernel.org/lkml/20250218223354.GA196886@bhelgaas/.
> > Maybe I didn't git it right. Any suggestion?
> 
> My point is just that you may not need to move the code from pciehp to
> portdrv at all if you follow my suggestion.
 
I see.

> 
> > There might be some misunderstaning here :), I responded in
> > https://lore.kernel.org/lkml/Z6LRAozZm1UfgjqT@U-2FWC9VHC-2323.local/
> > that your suggestion could solve our issue.
> 
> Well, could you test it please?

I don't have the hardware right now, will try to get from firmware
developers. But from code logic, your suggestion can surely solve the
issue unless I still miss something. From bug report (also commit log),
the first PCIe hotplug command issued is here, and the second command
comes from pciehp driver. In our kernel config, CONFIG_HOTPLUG_PCI_PCIE=y,
so the first command won't happen, and all following commands come
from pciehp driver, which setup its own waiting for command logic.

> A small change like the one I proposed is definitely preferable to
> moving dozens of lines of code around.

Agree.

> 
> > And the reason I didn't take it is I was afraid that it might hurt
> > the problem what commit 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port
> > services during port initialization") tried to solve.
> > 
> > As you mentioned, the comment for 2bd50dd800b5 is "a bit confusing",
> > and I tried to guess in my previous reply: 
> > "
> > I'm not sure what problem this piece of code try to avoid, maybe
> > something simliar to the irq storm isseu as mentioned in the 2/2 patch?
> > The code comments could be about the small time window between this
> > point and the loading of pciehp driver, which will request_irq and
> > enable hotplug interrupt again.
> > "
> > 
> > The code comment from 2bd50dd800b5 is:
> > 
> > 	/*
> > 	 * Disable hot-plug interrupts in case they have been
> > 	 * enabled by the BIOS and the hot-plug service driver
> > 	 * is not loaded.
> > 	 */
> > 
> > The "is not loaded" has 2 possible meanings:
> > 1. the pciehp driver is not loaded yet at this point inside
> >    get_port_device_capability(), and will be loaded later
> > 2. the pciehp will never be loaded, i.e. CONFIG_HOTPLUG_PCI_PCIE=n 
> > 
> > If it's case 2, your suggestion can solve it nicely, but for case 1,
> > we may have to keep the interrupt disabling.
> 
> The pciehp driver cannot be bound to the PCIe port when
> get_port_device_capability() is running.  Because at that point,
> portdrv is still figuring out which capabilities the port has and
> it will subsequently instantiate the port service devices to which
> the drivers (such as pciehp) will bind.
 
Yes, the time window between here and the following initialization of
pciehp service driver is very small, and your suggestion sounds quite
safe to me.

> So in that sense, case 1 cannot be what the code comment is
> referring to.

Hi Rafel,

Could you help to confirm this?

> 
> My point is that if CONFIG_HOTPLUG_PCI_PCIE=y, there may indeed be
> another write to the Slot Control register before the command written
> by portdrv has been completed.  Because pciehp will write to the
> register on probe.  But in this case, there shouldn't be a need for
> portdrv to quiesce the interrupt because pciehp will do that anyway
> shortly afterwards.
> 
> And in the CONFIG_HOTPLUG_PCI_PCIE=n case, pciehp will not quiesce
> the interrupt, so portdrv has to do that.  I believe that's what
> the code comment is referring to.  It should be safe to just write
> to the Slot Control register without waiting for the command to
> complete because there shouldn't be another Slot Control write
> afterwards (not by pciehp anyway).
> 
> If making the Slot Control write in portdrv conditional on
> CONFIG_HOTPLUG_PCI_PCIE=n does unexpectedly *not* solve the issue,
> please try to find out where the second Slot Control write is
> coming from.  E.g. you could amend pcie_capability_write_word()
> with something like:
> 
> 	if (pos == PCI_EXP_SLTCTL) {
> 		pci_info(dev, "Writing %04hx SltCtl\n", val);
> 		dump_stack();
> 	}

Thanks for the suggestion, and we added similar debug to figure
out them.

Thanks,
Feng

