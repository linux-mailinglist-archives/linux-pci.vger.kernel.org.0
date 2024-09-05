Return-Path: <linux-pci+bounces-12825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 658DD96D361
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 11:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82BF1F29FE3
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 09:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A20E2564;
	Thu,  5 Sep 2024 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OU6WpO8T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8B4194AD6;
	Thu,  5 Sep 2024 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528813; cv=none; b=AiaF7Os6auso45yQTlPSSCKgvIkpsOcifzX36wcuLWJYPegnIfz23zkLDsLOZvvgcb3QIx70V25EHE+/hJ2bgJpUjvHgeBAwODtIAg5MX/d09F8hjM/BhicwUEcw9WJYDMr0gA6JLIY1DxDFcKF4V1370YQXHFPakdpT4tAxDoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528813; c=relaxed/simple;
	bh=0dGaRFdKC7oYO/LEcQPRahQRLGsH4BSOn7ODZ4lykbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7iGhf/CSW90aHF0euma8kYas9ZX4XcXq+u/7s5abJl2CTv15VHLdEADHFuzGc4/Q2zUikzT4bc3wVzeWd0gL7h+/kt2YAUQgmu95KH2T4EBUXo+3agQ/683iNw3/7r7C9I1BrlWtTRF5C9W9FtqrT8ZWKYv0iARFlcABP0vBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OU6WpO8T; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725528812; x=1757064812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0dGaRFdKC7oYO/LEcQPRahQRLGsH4BSOn7ODZ4lykbI=;
  b=OU6WpO8TrYdB4ndnK9tgDkv+nRTzrjkom8vk/D3j5C2XBnR2rF/5qCqe
   oy0XSXCAHYpnZrfQBg2gnNm/Mdg0cqD43/+4kpCHXohTTj7HvxZuHUtkx
   H6YOXa88KkAU8rDjECaMXZMmfnTHamBpQrq7yOQxBLK7xOsx7KZw+kIpN
   /2MCJFr5CWqh0EmEzdELX6gPRt1frfbJzgXOkZc24UgycOnH7loiFI6wZ
   JjOhqkH+hy+qCcyuBbfScxPGSIbCLBblo2Dg+BbJV0T82fVMETMrdzTJn
   vJXx+jM0MYskIwMKkjuQorAKPDwqbR8itxBGuh2pxzxLmboB+Q4HF+7xR
   Q==;
X-CSE-ConnectionGUID: 1B9GDW5yTqS4VwjEEpzdoQ==
X-CSE-MsgGUID: PU/SCH3zT4K3mOIe3av3yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="24394983"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="24394983"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 02:33:30 -0700
X-CSE-ConnectionGUID: x6XLeCpVT+OCUNaVD2OVnA==
X-CSE-MsgGUID: XuRiJXNsTGS6v1UZl0V3iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="69976691"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 05 Sep 2024 02:33:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id D6760179; Thu, 05 Sep 2024 12:33:25 +0300 (EEST)
Date: Thu, 5 Sep 2024 12:33:25 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Gary Li <Gary.Li@amd.com>,
	Mario Limonciello <superm1@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	"open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
Message-ID: <20240905093325.GJ1532424@black.fi.intel.com>
References: <20240903182509.GA260253@bhelgaas>
 <525214d1-793e-412c-b3b2-b7e20645b9cf@amd.com>
 <20240904120545.GF1532424@black.fi.intel.com>
 <2bf715fb-509b-4b00-a28d-1cc83c0bb588@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bf715fb-509b-4b00-a28d-1cc83c0bb588@amd.com>

Hi,

On Wed, Sep 04, 2024 at 10:24:26AM -0500, Mario Limonciello wrote:
> On 9/4/2024 07:05, Mika Westerberg wrote:
> > Hi,
> > 
> > On Tue, Sep 03, 2024 at 01:32:30PM -0500, Mario Limonciello wrote:
> > > On 9/3/2024 13:25, Bjorn Helgaas wrote:
> > > > On Tue, Sep 03, 2024 at 12:31:00PM -0500, Mario Limonciello wrote:
> > > > > On 9/3/2024 12:11, Bjorn Helgaas wrote:
> > > > > ...
> > > > 
> > > > > >      8) The USB4 stack sees the device and assumes it is in D0, but it
> > > > > >      seems to still be in D3cold.  What is this based on?  Is there a
> > > > > >      config read that returns ~0 data when it shouldn't?
> > > > > 
> > > > > Yes there is.  From earlier in the thread I have a [log] I shared.
> > > > > 
> > > > > The message emitted is from ring_interrupt_active():
> > > > > 
> > > > > "thunderbolt 0000:e5:00.5: interrupt for TX ring 0 is already enabled"
> > > > 
> > > > Right, that's in the cover letter, but I can't tell from this what the
> > > > ioread32(ring->nhi->iobase + reg) returned.  It looks like this is an
> > > > MMIO read of BAR 0, not a config read.
> > > > 
> > > 
> > > Yeah.  I suppose another way to approach this problem is to make something
> > > else in the call chain poll PCI_PM_CTRL.
> > > 
> > > Polling at the start of nhi_runtime_resume() should also work.  For the
> > > "normal" scenario it would just be a single read to PCI_PM_CTRL.
> > > 
> > > Mika, thoughts?
> 
> We did this experiment to throw code to poll PCI_PM_CTRL at the start of
> nhi_runtime_resume() but this also fails.  From that I would hypothesize the
> device transitioned to D0uninitialized sometime in the middle of
> pci_pm_runtime_resume() before the call to pm->runtime_resume(dev);
> 
> > 
> > I'm starting to wonder if we are looking at the correct place ;-) This
> > reminds me that our PCIe SV people recently reported a couple of Linux
> > related issues which they recommended to fix, and these are on my list
> > but I'll share them because maybe they are related?
> 
> Thanks for sharing those.  We had a try with them but sorry to say no
> improvements to the issue at hand.

Okay, thanks for checking.

Few additional side paths here, though. This is supposed to work so that
once the host router sleep bit is set the driver is supposed to allow
the domain to enter sleep (e.g it should not be waken up before it is
fully transitioned). That's what we do:

1. All tunneled PCIe Root/Downstream ports are in D3.
2. All tunneled USB 3.x ports are in U3.
3. No DisplayPort is tunneled.
4. Thunderbolt driver enables wakes.
5. Thunderbolt driver writes sleep ready bit of the host router.
6. Thunderbolt driver runtime suspend is complete.
7. ACPI method is called (_PS3 or _PR3.OFF) that will trigger the "Sleep
Event".

If between 5 and 7 there is device connected, it should not "abort" the
sequence. Unfortunately this is not explict in the USB4 spec but the
connection manager guide has similar note. Even if the connect happens
there the "Sleep Event" should happen but after that it can trigger
normal wakeup which will then bring everything back.

Would it be possible to enable tracing around these steps so that we
could see if there is hotplug notification somewhere there that is not
expected? Here are instructions how to get pretty accurate trace:

https://github.com/intel/tbtools?tab=readme-ov-file#tracing

Please also take full dmesg.

It is entirely possible that this has nothing to do with the issue but I
think it is worth checking.

The second thing we could try is to check the wake status bits after
this has happened, like:

  # tbdump -r 0 -a <ADAPTER> -vv -N 1 PORT_CS_18

(where <ADAPTER> is the lane 0 adapter of the USB4 port the device was
connected).

The third thing to try is to comment out TB_WAKE_ON_CONNECT in
tb_switch_suspend(). This should result no wake even if the device is
connected. This tells us that it is really the connect on USB4 port that
triggered the wake.

These could (also) explain why the host router appears to be in D3 even
if it should be in D0 already.

