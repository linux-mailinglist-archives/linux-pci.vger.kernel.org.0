Return-Path: <linux-pci+bounces-11880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9E89587D3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 15:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD7EB218D3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 13:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AA3190497;
	Tue, 20 Aug 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AYrIMXUr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5218C91C
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2024 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160346; cv=none; b=euGRYhljw1YhKbHayKTwEqoz9CS9Q+mIPgUJroiydw4/hkXmk+ceczVOm5i1KBMdgnGpgoNb7YUEnmWMVoeGraz21dF88Kv1G4edToTlGPjfD4tYvEeLKXyH+U+q9zK2Qj3339yh15nUyMVw6t+Ggco6mi1ULWWem22CMKWDqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160346; c=relaxed/simple;
	bh=ysVWcc3Xr4bVXRfwxq2I577fsr0xGUW0dqEai/VdpD8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvKPv9b4zMUizs9xfu+qCqJG5+1TSmUWQBeckoy+jjaNO5ua3TzpgXS9wVu3Nwout6IIcDb28hLTbB5ApBCqALg0qARLHtJmqiYpUg3nnT+YqpEXgabJfomrzy2fXXab3mqJI3a0WeDp2UUMaTmzFz4kUosOnpOm8edGyVmgaBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AYrIMXUr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724160345; x=1755696345;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ysVWcc3Xr4bVXRfwxq2I577fsr0xGUW0dqEai/VdpD8=;
  b=AYrIMXUraq5ZefjxOeBJvTmy8WIOMxKgT5PTcb6zrg3VZ9JHjUNQSGAa
   Wck0Y+DTuQs0ZNjVBcUbX3k08IUNx3YwTZsi23L/VumkHI2e82bRWtOUf
   URi/837Nsomlq/vgcMKbKLZt/oG/E3zjB9aXuKOwuiJt4gZQno+zJxtvD
   FKwDw06QB40fGUvMt7+pKZCscvpyWEi0UNExJcaXxnElpv5WU2VcSLYEd
   7BcHPME/9RO0e2NO+n6I47gtzfw6SV4Gpqi3ElYJTuWvXa4XxAzNGLmAC
   YFyNdhHoZrSUxClS/2Iydat4ImF/P68qnn/fBvzdW2O23F1Lzwa4pRsMy
   A==;
X-CSE-ConnectionGUID: Hc9TbvlcTGmNJjT+QOrnjQ==
X-CSE-MsgGUID: im+0mQMRSGuayYzgtUsFjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22589450"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22589450"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 06:25:44 -0700
X-CSE-ConnectionGUID: e/7r+yUbQuyoOtOfcTxLNA==
X-CSE-MsgGUID: gHS4A33YTQOSWDJldw+4dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="65593500"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.245.82.157])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 06:25:41 -0700
Date: Tue, 20 Aug 2024 15:25:36 +0200
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, Christoph
 Hellwig <hch@lst.de>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Stuart Hayes <stuart.w.hayes@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Dan
 Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Keith Busch <kbusch@kernel.org>, Marek Behun
 <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap
 <rdunlap@infradead.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240820152536.0000433a@linux.intel.com>
In-Reply-To: <20240815174248.GA50357@bhelgaas>
References: <Zr2V5XqTAMSiEDJ-@wunner.de>
	<20240815174248.GA50357@bhelgaas>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 12:42:48 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Aug 15, 2024 at 07:45:09AM +0200, Lukas Wunner wrote:
> > On Wed, Aug 14, 2024 at 04:49:30PM -0500, Bjorn Helgaas wrote:  
> > > On Wed, Aug 14, 2024 at 02:28:59PM +0200, Mariusz Tkaczyk wrote:  
> > > > +	/*
> > > > +	 * Use lazy loading for active_indications to not play with
> > > > initcalls.
> > > > +	 * It is needed to allow _DSM initialization on DELL
> > > > platforms, where
> > > > +	 * ACPI_IPMI must be loaded first.
> > > > +	 */
> > > > +	unsigned int active_inds_initialized:1;  
> > > 
> > > What's going on here?  I hope we can at least move this to the _DSM
> > > patch since it seems related to that, not to the NPEM capability.  I
> > > don't understand the initcall reference or what "lazy loading" means.  
> > 
> > In previous iterations of this series, the status of all LEDs was
> > read on PCI device enumeration.  That was done so that when user space
> > reads the brightness is sysfs, it gets the correct value.  The value
> > is cached, it's not re-read from the register on every brightness read.
> > 
> > (It's not guaranteed that all LEDs are off on enumeration.  E.g. boot
> > firmware may have fiddled with them, or the enclosure itself may have
> > turned some of them on by itself, typically the "ok" LED.)
> > 
> > However Stuart reported issues when the _DSM interface is used on
> > Dell servers, because the _DSM requires IPMI drivers to access the
> > NPEM registers.  He got a ton of errors when LED status was read on
> > enumeration because that was simply too early.    
> 
> The dependency of _DSM on IPMI sounds like a purely ACPI problem.  Is
> there no mechanism in ACPI to express that dependency?
> 
> If _DSM claims the function is supported before the IPMI driver is
> ready, that sounds like a BIOS defect to me.
> 
> If we're stuck with this, maybe the comment can be reworded.  "Lazy
> loading" in a paragraph that also mentions initcalls and the
> "ACPI_IPMI" module makes it sound like we're talking about loading the
> *module* lazily, not just (IIUC) reading the LED status lazily.
> 
> Maybe it could also explicitly say that the GET_STATE_DSM function
> depends on IPMI.
> 
> I'm unhappy that we're getting our arm twisted here.  If functionality
> depends on IPMI, there really needs to be a way for OSPM to manage
> that dependency.  If we're working around a firmware defect, we need
> to be clear about that.

Hi,

I will move active_inds_initialized:1 to DSM commit and I will add better
justification. For NPEM commit, get_active_indications() will be called once in
pci_npem_init() to avoid referring _DSM specific issues in NPEM commit.

> 
> > > > +void pci_npem_create(struct pci_dev *dev)
> > > > +{
> > > > +	const struct npem_ops *ops = &npem_ops;
> > > > +	int pos = 0, ret;
> > > > +	u32 cap;
> > > > +
> > > > +	if (!npem_has_dsm(dev)) {
> > > > +		pos = pci_find_ext_capability(dev,
> > > > PCI_EXT_CAP_ID_NPEM);
> > > > +		if (pos == 0)
> > > > +			return;
> > > > +
> > > > +		if (pci_read_config_dword(dev, pos + PCI_NPEM_CAP,
> > > > &cap) != 0 ||
> > > > +		    (cap & PCI_NPEM_CAP_CAPABLE) == 0)
> > > > +			return;
> > > > +	} else {
> > > > +		/*
> > > > +		 * OS should use the DSM for LED control if it is
> > > > available
> > > > +		 * PCI Firmware Spec r3.3 sec 4.7.
> > > > +		 */
> > > > +		return;
> > > > +	}  
> > > 
> > > I know this is sort of a transient state since the next patch adds
> > > full _DSM support, but I do think (a) the fact that NPEM will stop
> > > working simply because firmware adds _DSM support is unexpected
> > > behavior, and (b) npem_has_dsm() and the other ACPI-related stuff
> > > would fit better in the next patch.  It's a little strange to have
> > > them mixed here.  
> > 
> > PCI Firmware Spec r3.3 sec 4.7 says:
> > 
> >    "OSPM should use this _DSM when available. If this _DSM is not
> >     available, OSPM should use Native PCIe Enclosure Management (NPEM)
> >     or SCSI Enclosure Services (SES) instead, if available."
> > 
> > I realize that a "should" is not a "must", so Linux would in principle
> > be allowed to use direct register access despite presence of the _DSM.
> > 
> > However that doesn't feel safe.  If the _DSM is present, I think it's
> > fair to assume that the platform firmware wants to control at least
> > a portion of the LEDs itself.  Accessing those LEDs directly, behind the
> > platform firmware's back, may cause issues.  Not exposing the LEDs
> > to the user in the _DSM case therefore seems safer.
> > 
> > Which is why the ACPI stuff to query for _DSM presence is already in
> > this patch instead of the succeeding one.  
> 
> The spec is regrettably vague about this, but that assumption isn't
> unreasonable.  It does deserve a more explicit callout in the commit
> log and probably a dmesg note about why NPEM used to work but no
> longer does.
> 

In fact, there is theoretical case that after firmware update DSM is no longer
available and NPEM is chosen. Given that, I will log chosen backed instead of
trying to predict a change. It is easier to implement it this way. User can
compare working/not-working dmesg logs to see a difference so printing backend
used is enough I think.

Thanks,
Mariusz

