Return-Path: <linux-pci+bounces-3166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014DA84B9D8
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 16:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849DBB23BDF
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C931212E1D8;
	Tue,  6 Feb 2024 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDtf/zr3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F5133400;
	Tue,  6 Feb 2024 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233863; cv=none; b=g1E/qwxqe7s6t+WM5hNTLsQXniKX3Vy/qs3i+TsNEDfPLe1wfbJ9gCrCI/rhVVjXeGdvWzy+iMlS72Qp0hiQMmD6jlwZvZeqXJc0Ed7hwwMJDTBF20KPg1YNndKFGaSaPrU49MpTk7L2KF+ohx8ucIX2rQmrMctHcp0XSVGXSVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233863; c=relaxed/simple;
	bh=weLBCm7VqoVkfSv/kFpruNdiNEC8HDEh1i2mwCaLPL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKpcE30sGdFF6g2E4H12PV8MarmuiQdt9lxvUVKwmq2WxBYL2fmurWUxQY51iZtCcPMPFpeE0dJlRdTQWOJzLzmMDjeMRbPCSKT8m4KOO/5GC2TYq1YH1J3JZn7dEXa2vxYUJWHL2AMxzI2zHGbjL9cpvL452Ul0HtkGd3A/T5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDtf/zr3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707233862; x=1738769862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=weLBCm7VqoVkfSv/kFpruNdiNEC8HDEh1i2mwCaLPL8=;
  b=mDtf/zr30kiRAmhdR/5JAROjKLzKbmDsgaOhU2xVddrIgQQsXY0pZTVw
   3sR0C8Ayc93F9kDMArfBS/RDLkKEa6+WA57rmd8bTFBCRqWeaUEpoeJJn
   Mun5uyoaj0PaXIsqVng7ceKwE7JD/mF5G6vnTAGvOZ40rPRoV/wpNIZE0
   +IflqWITLv6Xzyc3Fu7SAhEgdejUEx2W/Kk3leF8GtLxx2kGIbKlCbPDu
   g4dN3qm+z0gMqIplP1plqmcE7aG814dOoABKVaibjD6PTb5qxbH4Qq520
   qXczcnGAcHvPS12jLsh0RkbyZIMoFIWSDDYC03vnv4tbpO3J1OD6KXYR+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="921685"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="921685"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 07:37:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="5815898"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.60.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 07:37:39 -0800
Date: Tue, 6 Feb 2024 16:37:36 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [RFC] PCI/AER: Block runtime suspend when handling errors
Message-ID: <ZcJSQFF6XCgPjwx/@linux.intel.com>
References: <20240123090016.281252-1-stanislaw.gruszka@linux.intel.com>
 <20240130001436.GA488226@bhelgaas>
 <ZbtmB2GXPIwW1fLl@linux.intel.com>
 <CAJZ5v0gsojXKwQk4CL9ZpENcFs7X9pywfwNG-_ech5_G8pHRVw@mail.gmail.com>
 <ZcE0wWb6/CGFTKi/@linux.intel.com>
 <CAJZ5v0hLXS1EJZgUPn_i6Sp1RNJ2tH1oJ6AKvAQAM4Um_bwHPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hLXS1EJZgUPn_i6Sp1RNJ2tH1oJ6AKvAQAM4Um_bwHPA@mail.gmail.com>

On Mon, Feb 05, 2024 at 10:00:45PM +0100, Rafael J. Wysocki wrote:
> On Mon, Feb 5, 2024 at 9:11 PM Stanislaw Gruszka
> <stanislaw.gruszka@linux.intel.com> wrote:
> >
> > On Thu, Feb 01, 2024 at 03:10:35PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Feb 1, 2024 at 10:36 AM Stanislaw Gruszka
> > > <stanislaw.gruszka@linux.intel.com> wrote:
> > > >
> > > > On Mon, Jan 29, 2024 at 06:14:36PM -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Jan 23, 2024 at 10:00:16AM +0100, Stanislaw Gruszka wrote:
> > > > > > PM runtime can be done simultaneously with AER error handling.
> > > > > > Avoid that by using pm_runtime_get_sync() just after pci_dev_get()
> > > > > > and pm_runtime_put() just before pci_dev_put() in AER recovery
> > > > > > procedures.
> > > > >
> > > > > I guess there must be a general rule here, like "PCI core must use
> > > > > pm_runtime_get_sync() whenever touching the device asynchronously,
> > > > > i.e., when it's doing something unrelated to a call from the driver"?
> > > >
> > > > Clear rules would be nice, that's for sure.
> > > >
> > > > > Probably would apply to all subsystem cores, not just PCI.
> > > >
> > > > If they have something similar like AER.
> > > >
> > > > > > I'm not sure about DPC case since I do not see get/put there. It
> > > > > > just call pci_do_recovery() from threaded irq dcd_handler().
> > > > > > I think pm_runtime* should be added to this handler as well.
> > > > >
> > > > > s/dcd_handler/dpc_handler/
> > > > >
> > > > > I'm guessing the "threaded" part really doesn't matter; just the fact
> > > > > that this is in response to an interrupt, not something directly
> > > > > called by a driver?
> > > >
> > > > Yes. I added "threaded" just to emphasis that it's safe to add sleeping
> > > > functions there. In context of possible solution, not related to
> > > > the problem itself.
> > > >
> > > > > > pm_runtime_get_sync() will increase dev->power.usage_count counter to
> > > > > > prevent any rpm actives. When there is suspending pending, it will wait
> > > > > > for it and do the rpm resume. Not sure if that problem, on my testing
> > > > > > I did not encounter issues with that.
> > > > >
> > > > > Sorry, I didn't catch your meaning here.
> > > > I tired to write two things:
> > > >
> > > > First, pm_runtime_get_sync() after exit prevents possibility of
> > > > runtime suspend, so we are sure device will not be powered off
> > > >
> > > > Second, if during pm_runtime_get_sync(), there is pending attempt
> > > > to suspend device, it will be synchronized and device will
> > > > be resumed.
> > >
> > > Not exactly.  pm_runtime_get_sync() will resume the device
> > > synchronously no matter what.
> > >
> > > > This can be problematic as device is in error state.
> > >
> > > If this is a real possibility (I mean, device in a low-power state and
> > > in an error state at the same time), it would be better to call
> > > __pm_runtime_disable(dev, false) instead of pm_runtime_get_sync(), as
> > > that would prevent runtime PM from changing the device state.
> >
> > __pm_runtime_disable(dev, false) does not work as reliable in my
> > test as pm_runtime_get_sync(), the
> >
> > igc 0000:02:00.0: Unable to change power state from D3hot to D0, device inaccessible
> >
> > message disappears, but sill have:
> >
> > igc 0000:02:00.0: not ready 65535ms after bus reset; giving up
> > pcieport 0000:00:1c.2: AER: Root Port link has been reset (-25)
> > pcieport 0000:00:1c.2: AER: subordinate device reset failed
> > pcieport 0000:00:1c.2: AER: device recovery fail
> 
> But what exactly do you do?
> 
> (1) __pm_runtime_disable(dev, false)
> (2) Check power state
>      (a) If D0 (and device runtime-active), proceed
>      (b) If > D0, remove power (if possible) and put into D0
> 
> or something else?

I just did point (1), did not check power state (2).
I tested below patch with replaced:

  pm_runtime_get_sync -> __pm_runtime_disable(false)
  pm_runtime_put -> pm_runtime_enable()

I could try to test with (1)+(2), but now sure how do do step (2b),
by:

pci_set_power_state(D3cold)
pci_set_power_state(D0)

?

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 59c90d04a609..705893b5f7b0 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -13,6 +13,7 @@
 #define dev_fmt(fmt) "AER: " fmt
 
 #include <linux/pci.h>
+#include <linux/pm_runtime.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -85,6 +86,18 @@ static int report_error_detected(struct pci_dev *dev,
 	return 0;
 }
 
+static int pci_pm_runtime_get_sync(struct pci_dev *pdev, void *data)
+{
+	pm_runtime_get_sync(&pdev->dev);
+	return 0;
+}
+
+static int pci_pm_runtime_put(struct pci_dev *pdev, void *data)
+{
+	pm_runtime_put(&pdev->dev);
+	return 0;
+}
+
 static int report_frozen_detected(struct pci_dev *dev, void *data)
 {
 	return report_error_detected(dev, pci_channel_io_frozen, data);
@@ -207,6 +220,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	else
 		bridge = pci_upstream_bridge(dev);
 
+	pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
+
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
@@ -251,10 +266,15 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pcie_clear_device_status(dev);
 		pci_aer_clear_nonfatal_status(dev);
 	}
+
+	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
+
 	pci_info(bridge, "device recovery successful\n");
 	return status;
 
 failed:
+	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
+
 	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
 
 	/* TODO: Should kernel panic here? */

