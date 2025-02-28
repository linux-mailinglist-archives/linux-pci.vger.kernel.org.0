Return-Path: <linux-pci+bounces-22614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936C3A49195
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 07:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291E43ACE4A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 06:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE4C1C4A3D;
	Fri, 28 Feb 2025 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YKUVPqLo"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD7C1C1F05;
	Fri, 28 Feb 2025 06:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724185; cv=none; b=Toq6d1mpC5u31MIhn/0AjuHAqieQWm4GWIHmqk9fbgnZ7BMssfYfy3nocH6jcXmQbXl3QZpS2+8TvUgAs9Xv1QEtsXHT4p1bk+9IHH/LCAmQiuRYVGcAXlfNJ5lE1q5kyz/8SMItVJAHyyTB0W+6gXrIE5CQ7iF9MCKl50lN7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724185; c=relaxed/simple;
	bh=RbC4xfF6h61NbHPK5qi+JyBTdX+MGZZT6MCYbiS3ZDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipFz3YmdLw4SeUz9KA5+LrE7ghPBQ2bccPmXX6VlrinMttN0wRykKB064hpSeT84GzIw2JXg0KBo1phdPrjYdf2lxhUlsbgLjTjLyR1G8Hu62y9NiWkGCJ2NCYvCVSiSTK4BlXEIVGvwgE69cBVuunQyli8q08oI7Q75Lf8VRGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YKUVPqLo; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740724171; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=P/gHqdTH6OvF6sFxyThANlSajf5KaqwskiX012+vXJw=;
	b=YKUVPqLoiYr9s1nN/ZxQKjI0qA1DfnrkOTh8xlbyb68EpsWv3yzobZr0fPaHWASDdMR/LM8b08r26wwFH4CJX/K9BVglC1ye9WqWa2t8VFpL79Sa9ARFyWgTSDya0mkdjTJL/qiDL+kiEI8oOqTtG5r80T6f4WhkukGXcEwynog=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WQOmTnc_1740724170 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 14:29:31 +0800
Date: Fri, 28 Feb 2025 14:29:29 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Lukas Wunner <lukas@wunner.de>, rafael@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Markus Elfring <Markus.Elfring@web.de>, lkp@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] PCI/portdrv: Add necessary wait for disabling
 hotplug events
Message-ID: <Z8FXyVyMyAe4_bI3@U-2FWC9VHC-2323.local>
References: <20250224034500.23024-1-feng.tang@linux.alibaba.com>
 <20250224034500.23024-3-feng.tang@linux.alibaba.com>
 <Z7y2e-EJLijQsp8D@wunner.de>
 <Z70zyhZe6OrxNNT3@U-2FWC9VHC-2323.local>
 <Z71Ap7kpV4rfhFDU@wunner.de>
 <Z71KHDbgrPFaoPO7@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z71KHDbgrPFaoPO7@U-2FWC9VHC-2323.local>

On Tue, Feb 25, 2025 at 12:42:04PM +0800, Feng Tang wrote:
 
> > 
> > > There might be some misunderstaning here :), I responded in
> > > https://lore.kernel.org/lkml/Z6LRAozZm1UfgjqT@U-2FWC9VHC-2323.local/
> > > that your suggestion could solve our issue.
> > 
> > Well, could you test it please?
> 
> I don't have the hardware right now, will try to get from firmware
> developers. But from code logic, your suggestion can surely solve the
> issue unless I still miss something. From bug report (also commit log),
> the first PCIe hotplug command issued is here, and the second command
> comes from pciehp driver. In our kernel config, CONFIG_HOTPLUG_PCI_PCIE=y,
> so the first command won't happen, and all following commands come
> from pciehp driver, which setup its own waiting for command logic.
> 

Hi Lucas,

We just tried the patch on the hardware and initial 5.10 kernel, and
the problem cannot be reproduced, as the first PCIe hotplug command
of disabling CCIE and HPIE was not issued. 

Should I post a new version patch with your suggestion? You analysis
in previous sounded sane to me. Also for the original context, if the
BIOS has enabled the hotplug interrupt, it has been there since OS
boot for quite some time, this solution just affects a very small
time window from here to the loading of pciehp driver.  

Also I would like to separate this patch from the patch dealing the
nomsi irq storm issue. How do you think?

Thanks,
Feng

> > > 
> > > The code comment from 2bd50dd800b5 is:
> > > 
> > > 	/*
> > > 	 * Disable hot-plug interrupts in case they have been
> > > 	 * enabled by the BIOS and the hot-plug service driver
> > > 	 * is not loaded.
> > > 	 */
> > > 
> > > The "is not loaded" has 2 possible meanings:
> > > 1. the pciehp driver is not loaded yet at this point inside
> > >    get_port_device_capability(), and will be loaded later
> > > 2. the pciehp will never be loaded, i.e. CONFIG_HOTPLUG_PCI_PCIE=n 
> > > 
> > > If it's case 2, your suggestion can solve it nicely, but for case 1,
> > > we may have to keep the interrupt disabling.
> > 
> > The pciehp driver cannot be bound to the PCIe port when
> > get_port_device_capability() is running.  Because at that point,
> > portdrv is still figuring out which capabilities the port has and
> > it will subsequently instantiate the port service devices to which
> > the drivers (such as pciehp) will bind.
>  
> Yes, the time window between here and the following initialization of
> pciehp service driver is very small, and your suggestion sounds quite
> safe to me.
> 
> > So in that sense, case 1 cannot be what the code comment is
> > referring to.
> 
> Hi Rafel,
> 
> Could you help to confirm this?
> 
> > 
> > My point is that if CONFIG_HOTPLUG_PCI_PCIE=y, there may indeed be
> > another write to the Slot Control register before the command written
> > by portdrv has been completed.  Because pciehp will write to the
> > register on probe.  But in this case, there shouldn't be a need for
> > portdrv to quiesce the interrupt because pciehp will do that anyway
> > shortly afterwards.
> > 
> > And in the CONFIG_HOTPLUG_PCI_PCIE=n case, pciehp will not quiesce
> > the interrupt, so portdrv has to do that.  I believe that's what
> > the code comment is referring to.  It should be safe to just write
> > to the Slot Control register without waiting for the command to
> > complete because there shouldn't be another Slot Control write
> > afterwards (not by pciehp anyway).
> > 
> > If making the Slot Control write in portdrv conditional on
> > CONFIG_HOTPLUG_PCI_PCIE=n does unexpectedly *not* solve the issue,
> > please try to find out where the second Slot Control write is
> > coming from.  E.g. you could amend pcie_capability_write_word()
> > with something like:
> > 
> > 	if (pos == PCI_EXP_SLTCTL) {
> > 		pci_info(dev, "Writing %04hx SltCtl\n", val);
> > 		dump_stack();
> > 	}
> 
> Thanks for the suggestion, and we added similar debug to figure
> out them.
> 
> Thanks,
> Feng

