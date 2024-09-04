Return-Path: <linux-pci+bounces-12748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E4D96BBAD
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 14:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0A91C242A1
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 12:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3061DB925;
	Wed,  4 Sep 2024 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P3VQFYR3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168811DB54F;
	Wed,  4 Sep 2024 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451553; cv=none; b=GorZM1XEG06lXF4/kfM3DO8gvAbJWm3KBSXJZdcISYTyUAPkNZlRAuFuwu3IpE+ic0EWHad/2H7DyS06jS+WmnSBQ3JK0qrC13oIyQPobPv2bC2eIJijgS2oSevPJSI+2dSOYcgehcYx2IcnWkp/YOgzI9KKDxsL+kExLZmKmkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451553; c=relaxed/simple;
	bh=SgmrCust3oEATibES8ZZVRSqeZ8VTNZXAxnvXuj1f0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3hqPQDrZetCbsX4g8tp0orNV4bQtTL30XbvrMZdelUDYhKb3Cndna4/JofhEbist9qr+cmqQjPBuvhdHvsUN9qYEZnjYqQAqs4R2KdxAx/9bZsx/lTV19sQ5ymTnP27ayNMvDQ2rM5JSLsyhbDIxDKLaEFzn71qrJgiKnYfkaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P3VQFYR3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725451552; x=1756987552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SgmrCust3oEATibES8ZZVRSqeZ8VTNZXAxnvXuj1f0Y=;
  b=P3VQFYR3QSdMxWCuNpLkBOb2Xt/kXdtdA4cLba5temyEci7wPkANFXMS
   VZdZmm8XpAxVKG+qkAtcTqhD7YrA3VfyLSnoyapqUaRfiy9Mtz7brWAyo
   G2qRHKdWSi5w2bvJLknPybFU0vwswDUOj2jGzZJxTPW4JtoienbC7rJ6a
   FemMNpULQFpGIp0hne7owRQY5fU/CpXKVyu+ZMexYj8si2rKg9ViDXCLP
   Ky/Q56IjJpVCQD6y+onqQ+IDxYxSzY1NxmYjc6y6YFwoslQm5OZB2kcHw
   5E+zYraxjiI2FOg3uk+lYLQxeJCZe9S2FyvxQQjOs8HLCb6h8qOyJBFL1
   Q==;
X-CSE-ConnectionGUID: Rmvvdao4Qzu0aPCiKnhK1Q==
X-CSE-MsgGUID: +d1cOigpRtC1P/N43xSbeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24268744"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="24268744"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:05:51 -0700
X-CSE-ConnectionGUID: rMHvMWCDTQGZhNO+g5vN3w==
X-CSE-MsgGUID: B6XUC9GJQbSCo0+uCbo5xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="96046651"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 04 Sep 2024 05:05:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 07915AF3; Wed, 04 Sep 2024 15:05:45 +0300 (EEST)
Date: Wed, 4 Sep 2024 15:05:45 +0300
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
Message-ID: <20240904120545.GF1532424@black.fi.intel.com>
References: <20240903182509.GA260253@bhelgaas>
 <525214d1-793e-412c-b3b2-b7e20645b9cf@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <525214d1-793e-412c-b3b2-b7e20645b9cf@amd.com>

Hi,

On Tue, Sep 03, 2024 at 01:32:30PM -0500, Mario Limonciello wrote:
> On 9/3/2024 13:25, Bjorn Helgaas wrote:
> > On Tue, Sep 03, 2024 at 12:31:00PM -0500, Mario Limonciello wrote:
> > > On 9/3/2024 12:11, Bjorn Helgaas wrote:
> > > ...
> > 
> > > >     8) The USB4 stack sees the device and assumes it is in D0, but it
> > > >     seems to still be in D3cold.  What is this based on?  Is there a
> > > >     config read that returns ~0 data when it shouldn't?
> > > 
> > > Yes there is.  From earlier in the thread I have a [log] I shared.
> > > 
> > > The message emitted is from ring_interrupt_active():
> > > 
> > > "thunderbolt 0000:e5:00.5: interrupt for TX ring 0 is already enabled"
> > 
> > Right, that's in the cover letter, but I can't tell from this what the
> > ioread32(ring->nhi->iobase + reg) returned.  It looks like this is an
> > MMIO read of BAR 0, not a config read.
> > 
> 
> Yeah.  I suppose another way to approach this problem is to make something
> else in the call chain poll PCI_PM_CTRL.
> 
> Polling at the start of nhi_runtime_resume() should also work.  For the
> "normal" scenario it would just be a single read to PCI_PM_CTRL.
> 
> Mika, thoughts?

I'm starting to wonder if we are looking at the correct place ;-) This
reminds me that our PCIe SV people recently reported a couple of Linux
related issues which they recommended to fix, and these are on my list
but I'll share them because maybe they are related?

First problem, and actually a PCI spec violation, is that Linux does not
clear Bus Master, MMIO and IO space enables when it programs the device
to D3 on runtime suspend path. It does so on system sleep path though.
Something like below (untested) should do that:

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f412ef73a6e4..79a566376301 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1332,6 +1332,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
 
 	if (!pci_dev->state_saved) {
 		pci_save_state(pci_dev);
+		pci_pm_default_suspend(pci_dev);
 		pci_finish_runtime_suspend(pci_dev);
 	}
 

The second thing is that Thunderbolt driver, for historical reasons,
leaves the MSI enabled when entering D3. This too might be related. I
think we can unconditionally disable it so below hack should do that
(untested as well). I wonder if you could try if any of these or both
can help here? Both of these issues can result unwanted events during D3
entry as far as I understand.

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index dc1f456736dc..73b815fbbceb 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -659,12 +659,11 @@ struct tb_ctl *tb_ctl_alloc(struct tb_nhi *nhi, int index, int timeout_msec,
 	if (!ctl->frame_pool)
 		goto err;
 
-	ctl->tx = tb_ring_alloc_tx(nhi, 0, 10, RING_FLAG_NO_SUSPEND);
+	ctl->tx = tb_ring_alloc_tx(nhi, 0, 10, 0);
 	if (!ctl->tx)
 		goto err;
 
-	ctl->rx = tb_ring_alloc_rx(nhi, 0, 10, RING_FLAG_NO_SUSPEND, 0, 0xffff,
-				   0xffff, NULL, NULL);
+	ctl->rx = tb_ring_alloc_rx(nhi, 0, 10, 0, 0, 0xffff, 0xffff, NULL, NULL);
 	if (!ctl->rx)
 		goto err;
 

