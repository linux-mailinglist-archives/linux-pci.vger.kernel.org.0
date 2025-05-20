Return-Path: <linux-pci+bounces-28081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0771ABD3E3
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 11:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005A11BA0935
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA8D26772A;
	Tue, 20 May 2025 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hv88sEO/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110A2673BF;
	Tue, 20 May 2025 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747734515; cv=none; b=fcxkJUM4MyvkDHnKZUvCH6rTfAQoczNoa7/m2EOyrIYeuttme8EVd96t3+Y8xCk+ExHSVdmul4js2mG6NiTdQQyO7Kgp8DtXe/Y/bUDpuR1qZqO/3fgqj+3KEnBFfNq9NuUz73AkikNLDzmfzWcq1TEfPpmquwIiUY1bS+C6zgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747734515; c=relaxed/simple;
	bh=YInY8B8y5563Kx6v9KHX8DTC+ccBeNLNuY2OZS7pm+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIri+PGOfT1ULns7kVlSZCYtJSGwMQPDyPJKQjLNqbwRlm+9fzAlHiC+KP2pOkKe7Jn7ZtAmKYsTy6wQEB6KUZhHPgI6rTYyGSL33HH4uCNEYDM1W4HEfUQSz9r7N7P7I3QgoeLd/3TKZmHLVhrSkygYRmJHpvHK749vYxxPxo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hv88sEO/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747734513; x=1779270513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YInY8B8y5563Kx6v9KHX8DTC+ccBeNLNuY2OZS7pm+E=;
  b=Hv88sEO/zdU6lED8TinLsjwGTOKGbqpJtujdoqQZq5RObu0YtNWyipIr
   kIz4ictyFeQg/lpw9j79rHD4MhHX6bkUgnDXOIwZWcFRlfDi2xhePl5ME
   sg8zlBI/oIqRyIy7+qv2kcotqv10xbWS7ILDcT9RjDCUnb1ILcMLAFQxB
   v1R7VPlI7phSFqEAAPeXFm+5cqFcS4qsq+qAPHBEYcM5EPdyr+kgkjc58
   F51QUWuIg7nwmF4o/Urs7EcPtRTc2spZDyQ4jqTyFm03cveBArK/bYiMM
   D4oLHrD3bIGvXVZfOEUSeenmbh8LtdqAl+ChPtBMNK+2BYLf69C2Ryjxp
   A==;
X-CSE-ConnectionGUID: LEqzrGbDQvmR4zt1r4D3xQ==
X-CSE-MsgGUID: tvh1FZdCSdq1R29deP6y6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49561499"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49561499"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 02:48:32 -0700
X-CSE-ConnectionGUID: 1ZIPiQVWRoiM70JcEPyE9Q==
X-CSE-MsgGUID: Pt8ek9pzSbiCaoCqjc4/Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144388640"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 02:48:30 -0700
Date: Tue, 20 May 2025 12:48:26 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Denis Benato <benato.denis96@gmail.com>
Cc: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, lukas@wunner.de,
	aravind.iddamsetty@linux.intel.com, superm1@kernel.org
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous
 device
Message-ID: <aCxP6vQ8Ep9LftPv@black.fi.intel.com>
References: <20250519102808.4130271-1-raag.jadav@intel.com>
 <aCsK743YSuahPtnH@black.fi.intel.com>
 <85ed0b91-c84f-4d24-8e19-a8cb3ba02b14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85ed0b91-c84f-4d24-8e19-a8cb3ba02b14@gmail.com>

On Mon, May 19, 2025 at 11:42:31PM +0200, Denis Benato wrote:
> On 5/19/25 12:41, Raag Jadav wrote:
> > On Mon, May 19, 2025 at 03:58:08PM +0530, Raag Jadav wrote:
> >> If error status is set on an AER capable device, most likely either the
> >> device recovery is in progress or has already failed. Neither of the
> >> cases are well suited for power state transition of the device, since
> >> this can lead to unpredictable consequences like resume failure, or in
> >> worst case the device is lost because of it. Leave the device in its
> >> existing power state to avoid such issues.
> >>
> >> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> >> ---
> >>
> >> v2: Synchronize AER handling with PCI PM (Rafael)
> >> v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
> >>     Elaborate "why" (Bjorn)
> >> v4: Rely on error status instead of device status
> >>     Condense comment (Lukas)
> > Since pci_aer_in_progress() is changed I've not included Rafael's tag with
> > my understanding of this needing a revisit. If this was a mistake, please
> > let me know.
> >
> > Denis, Mario, does this fix your issue?
> >
> Hello,
> 
> Unfortunately no, I have prepared a dmesg but had to remove the bootup process because it was too long of a few kb: https://pastebin.com/1uBEA1FL

Thanks for the test. It seems there's no hotplug event this time around
and endpoint device is still intact without any PCI related failure.

Also,

amdgpu 0000:09:00.0: PCI PM: Suspend power state: D3hot

Which means whatever you're facing is either not related to this patch,
or at best exposed some nasty side-effect that's not handled correctly
by the driver.

I'd say amdgpu folks would be of better help for your case.

Raag

> >> More discussion on [1].
> >> [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
> >>
> >>  drivers/pci/pci.c      |  9 +++++++++
> >>  drivers/pci/pcie/aer.c | 13 +++++++++++++
> >>  include/linux/aer.h    |  2 ++
> >>  3 files changed, 24 insertions(+)
> >>
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index 4d7c9f64ea24..a20018692933 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -9,6 +9,7 @@
> >>   */
> >>  
> >>  #include <linux/acpi.h>
> >> +#include <linux/aer.h>
> >>  #include <linux/kernel.h>
> >>  #include <linux/delay.h>
> >>  #include <linux/dmi.h>
> >> @@ -1539,6 +1540,14 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
> >>  	   || (state == PCI_D2 && !dev->d2_support))
> >>  		return -EIO;
> >>  
> >> +	/*
> >> +	 * If error status is set on an AER capable device, it is not well
> >> +	 * suited for power state transition. Leave it in its existing power
> >> +	 * state to avoid issues like unpredictable resume failure.
> >> +	 */
> >> +	if (pci_aer_in_progress(dev))
> >> +		return -EIO;
> >> +
> >>  	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> >>  	if (PCI_POSSIBLE_ERROR(pmcsr)) {
> >>  		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> index a1cf8c7ef628..617fbac0d38a 100644
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -237,6 +237,19 @@ int pcie_aer_is_native(struct pci_dev *dev)
> >>  }
> >>  EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
> >>  
> >> +bool pci_aer_in_progress(struct pci_dev *dev)
> >> +{
> >> +	int aer = dev->aer_cap;
> >> +	u32 cor, uncor;
> >> +
> >> +	if (!pcie_aer_is_native(dev))
> >> +		return false;
> >> +
> >> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS, &cor);
> >> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &uncor);
> >> +	return cor || uncor;
> >> +}
> >> +
> >>  static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
> >>  {
> >>  	int rc;
> >> diff --git a/include/linux/aer.h b/include/linux/aer.h
> >> index 02940be66324..e6a380bb2e68 100644
> >> --- a/include/linux/aer.h
> >> +++ b/include/linux/aer.h
> >> @@ -56,12 +56,14 @@ struct aer_capability_regs {
> >>  #if defined(CONFIG_PCIEAER)
> >>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> >>  int pcie_aer_is_native(struct pci_dev *dev);
> >> +bool pci_aer_in_progress(struct pci_dev *dev);
> >>  #else
> >>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
> >>  {
> >>  	return -EINVAL;
> >>  }
> >>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> >> +static inline bool pci_aer_in_progress(struct pci_dev *dev) { return false; }
> >>  #endif
> >>  
> >>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
> >> -- 
> >> 2.34.1
> >>

