Return-Path: <linux-pci+bounces-27783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C3DAB8571
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 13:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339F44E160E
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 11:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ED42989AE;
	Thu, 15 May 2025 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pc6bVOvq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213D7298271;
	Thu, 15 May 2025 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747310321; cv=none; b=hc7M4Lh31mqeu2i2Egrx9Pi9kWMFnVY1+bkd6ewuE0FVznDhmgtLIT277sHy4O2vcDmp2mcvTQfW/NO2CQga/hTz3LeRU8k9D3DaDsAddwGo0Jz0YSHOBC6L07/50f0UO35qukIP+ZcrcQ4syGsiTdjxrvxbwbuIlVWgAhasIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747310321; c=relaxed/simple;
	bh=Vzbg0N6Iq4k1P3M3nzi5F1PiOtlcXPSXgTwjX5upVls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3GQC3i1uyQwe7bYlaset9FEurexhbyNPPhw2CLEU5+Ct2t4opttbYYFeRhEcxm6o2eB22Jqu76OnsEH/qAc227z0gn+60HTRNq/qHSBkOYxWaxTHx+IUf/SCGpTYH0MPmFXxtaaujsrOp/a9jlYi28UMmk4RCX0f9VIA4FV+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pc6bVOvq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747310320; x=1778846320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vzbg0N6Iq4k1P3M3nzi5F1PiOtlcXPSXgTwjX5upVls=;
  b=Pc6bVOvqRgkXyNET4/+K3CdnVqCIfNv/VkxwHEPs12icwkollzXXxAdo
   sM66xgUbx50eNhdINBwCWCMklCWiWiZq2v/hgHt/JlMgQfs4FaDAEpRBv
   cPT0W1/okWsxB8wVG08VgFyAWMWLAjfAauIaBBH7292qM0+i0xhmgCwNl
   ylOSH2bgkJbOFI4OSfbywES1bDLj9BSyoPb6AsnW6+zGnon5g1vKBh9u8
   LJyx7jkNU5xl64Iv2YbWeIm35rh/TN92i39W8vlY4OnKyI032gCj3miyu
   mNgjHL1+rB/JPESjEN0NzWb4zUHr3cBZRqhSh7B9p27xgHSYyjz3V8w3a
   A==;
X-CSE-ConnectionGUID: ODdQC628S0+nomopPCWXuA==
X-CSE-MsgGUID: nCH2mGZWRf+m7xQCJj1f4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="71751202"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="71751202"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 04:58:31 -0700
X-CSE-ConnectionGUID: l7KTccinQTK6rJaTTQ5cfg==
X-CSE-MsgGUID: REzV7ZHQR3KuaTioUqVMzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="142360904"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 04:58:27 -0700
Date: Thu, 15 May 2025 14:58:25 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>, rafael@kernel.org,
	mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, lukas@wunner.de,
	aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v3] PCI: Prevent power state transition of erroneous
 device
Message-ID: <aCXW4c-Ocly4t6yF@black.fi.intel.com>
References: <20250504090444.3347952-1-raag.jadav@intel.com>
 <7dbb64ee-3683-4b47-b17d-288447da746e@gmail.com>
 <384a2c60-2f25-4a1d-b8a6-3ea4ea34e2c2@kernel.org>
 <350f35dd-757e-459f-81f7-666a4457e736@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <350f35dd-757e-459f-81f7-666a4457e736@gmail.com>

On Wed, May 14, 2025 at 11:25:36PM +0200, Denis Benato wrote:
> On 5/14/25 21:53, Mario Limonciello wrote:
> > On 5/14/2025 11:29 AM, Denis Benato wrote:
> >> Hello,
> >>
> >> Lately I am experiencing a few problems related to either (one of or both) PCI and/or thunderbolt and Mario Limonciello pointed me to this patch.
> >>
> >> you can follow an example of my problems in this [1] bug report.
> >>
> >> I tested this patch on top of 6.14.6 and this patch comes with a nasty regression: s2idle resume breaks all my three GPUs, while for example the sound of a YT video resumes fine.
> >>
> >> You can see the dmesg here: https://pastebin.com/Um7bmdWi

Thanks for the report. From logs it looks like a hotplug event is triggered
for presence detect which is disabling the slot and in turn loosing the device
on resume. The cause of it is unclear though (assuming it is not a manual
intervention).

> >> I will also say that, on the bright side, this patch makes my laptop behave better on boot as the amdgpu plugged on the thunderbolt port is always enabled on power on, while without this patch it is random if it will be active immediately after laptop has been turned on.
> >>
> >
> > Just for clarity - if you unplug your eGPU enclosure before suspend is everything OK?  IE this patch only has an impact to the USB4/TBT3 PCIe tunnels?
> >
> Laptop seems to enter and exit s2idle with the thunderbolt amdgpu disconnected using this patch too.
> 
> Probably this either unveils a pre-existing thunderbolt bug or creates a new one.  If you need assistance in finding the bug or investigating in any other mean let me know as I want to see this patch merged once it stops regressing sleep with egpu.

If you're observing this only on thunderbolt port, one experiment I could
think of is to configure the port power delivery to be always on during suspend
and observe. Perhaps enable both thunderbolt and PCI logging to help figure out
what's really happening.

> I will add that as a visible effect entering and exiting s2idle, even without the egpu connected (so when sleep works), makes the screen backlight to turn off and on rapidly about 6 times and it's a bit "concerning" to see, also I have the impression that it takes slightly longer to enter/exit s2idle.

Yes, I'm expecting a lot of hidden issues to be surfaced by this patch. Since
you've confirmed the machine itself is working fine, I'm hoping there are no
serious regressions.

Raag

> > The errors after resume in amdgpu /look/ like the device is "missing" from the bus or otherwise not responding.
> >
> > I think it would be helpful to capture the kernel log with a baseline of 6.14.6 but without this patch for comparison of what this patch is actually causing.
> >
> I have a dmesg of the same 6.14.6 minus this patch ready: https://pastebin.com/kLZtibcD
> >>
> >> [1] https://lore.kernel.org/all/965c9753-f14b-4a87-9f6d-8798e09ad6f5@gmail.com/
> >>
> >> On 5/4/25 11:04, Raag Jadav wrote:
> >>
> >>> If error flags are set on an AER capable device, most likely either the
> >>> device recovery is in progress or has already failed. Neither of the
> >>> cases are well suited for power state transition of the device, since
> >>> this can lead to unpredictable consequences like resume failure, or in
> >>> worst case the device is lost because of it. Leave the device in its
> >>> existing power state to avoid such issues.
> >>>
> >>> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> >>> ---
> >>>
> >>> v2: Synchronize AER handling with PCI PM (Rafael)
> >>> v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
> >>>      Elaborate "why" (Bjorn)
> >>>
> >>> More discussion on [1].
> >>> [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
> >>>
> >>>   drivers/pci/pci.c      | 12 ++++++++++++
> >>>   drivers/pci/pcie/aer.c | 11 +++++++++++
> >>>   include/linux/aer.h    |  2 ++
> >>>   3 files changed, 25 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >>> index 4d7c9f64ea24..25b2df34336c 100644
> >>> --- a/drivers/pci/pci.c
> >>> +++ b/drivers/pci/pci.c
> >>> @@ -9,6 +9,7 @@
> >>>    */
> >>>     #include <linux/acpi.h>
> >>> +#include <linux/aer.h>
> >>>   #include <linux/kernel.h>
> >>>   #include <linux/delay.h>
> >>>   #include <linux/dmi.h>
> >>> @@ -1539,6 +1540,17 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
> >>>          || (state == PCI_D2 && !dev->d2_support))
> >>>           return -EIO;
> >>>   +    /*
> >>> +     * If error flags are set on an AER capable device, most likely either
> >>> +     * the device recovery is in progress or has already failed. Neither of
> >>> +     * the cases are well suited for power state transition of the device,
> >>> +     * since this can lead to unpredictable consequences like resume
> >>> +     * failure, or in worst case the device is lost because of it. Leave the
> >>> +     * device in its existing power state to avoid such issues.
> >>> +     */
> >>> +    if (pci_aer_in_progress(dev))
> >>> +        return -EIO;
> >>> +
> >>>       pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> >>>       if (PCI_POSSIBLE_ERROR(pmcsr)) {
> >>>           pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
> >>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >>> index a1cf8c7ef628..4040770df4f0 100644
> >>> --- a/drivers/pci/pcie/aer.c
> >>> +++ b/drivers/pci/pcie/aer.c
> >>> @@ -237,6 +237,17 @@ int pcie_aer_is_native(struct pci_dev *dev)
> >>>   }
> >>>   EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
> >>>   +bool pci_aer_in_progress(struct pci_dev *dev)
> >>> +{
> >>> +    u16 reg16;
> >>> +
> >>> +    if (!pcie_aer_is_native(dev))
> >>> +        return false;
> >>> +
> >>> +    pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
> >>> +    return !!(reg16 & PCI_EXP_AER_FLAGS);
> >>> +}
> >>> +
> >>>   static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
> >>>   {
> >>>       int rc;
> >>> diff --git a/include/linux/aer.h b/include/linux/aer.h
> >>> index 02940be66324..e6a380bb2e68 100644
> >>> --- a/include/linux/aer.h
> >>> +++ b/include/linux/aer.h
> >>> @@ -56,12 +56,14 @@ struct aer_capability_regs {
> >>>   #if defined(CONFIG_PCIEAER)
> >>>   int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> >>>   int pcie_aer_is_native(struct pci_dev *dev);
> >>> +bool pci_aer_in_progress(struct pci_dev *dev);
> >>>   #else
> >>>   static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
> >>>   {
> >>>       return -EINVAL;
> >>>   }
> >>>   static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> >>> +static inline bool pci_aer_in_progress(struct pci_dev *dev) { return false; }
> >>>   #endif
> >>>     void pci_print_aer(struct pci_dev *dev, int aer_severity,
> >

