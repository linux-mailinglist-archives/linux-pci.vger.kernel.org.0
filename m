Return-Path: <linux-pci+bounces-34796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C16FB3745A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 23:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF26204569
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 21:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A030D2FE04B;
	Tue, 26 Aug 2025 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPLGG/7V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9D28151E;
	Tue, 26 Aug 2025 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243450; cv=none; b=C3r6buO2OnCWnlWwLFbYf2IUejAnRHWtYNNKb9nJMkxsEbgmKE/FEsqOXGiOMn/4IkqTOoqCsMxpqryGCVsio+kB+85vP++UuU0c/VSlOkFn0R6oFsnYVZIANBp6QNsLnoUOE2elqjGdXbrH2SqeQm+u5GGqmbQnaZWTvZitfKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243450; c=relaxed/simple;
	bh=l883/XMWp2sJPEUKA3Wy082jQu7V8ivTJMDHeeXauTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHbM8VkbkfBjPs1FN5cLJryPP/2JG+8VbetcHsPDaqHAZz9xzDXKcPiOlRsY5bvjZNiS/o88TivvH9OPoi2eOixtO6QkAEcMi64Bp9bRycBXR4mkzNVui16eRIf306ydDn8NAkQPbx/DB9tIp4y4Qf555ORVkhMgN2pGnTrHWc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPLGG/7V; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756243449; x=1787779449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=l883/XMWp2sJPEUKA3Wy082jQu7V8ivTJMDHeeXauTU=;
  b=EPLGG/7V18wNdYewZSMWBjdnxb+DRe71eo3L4m3/+31Y1FFNomap68tU
   NQMLT2tA9RiVCJ1+azuuKb4eJxkNFO5xu+oTrzujPYjMcMbs0QHg6q946
   /uhfuafpy2f7QiqD6mbQ11zQvjm2IVRdM7XQiVT5Tzsbwv/9vedKjOuhU
   QuPNPznunH0CGIs5kCQvi9btNeo/B8PEQKX6jG1BQT50Kqc75IjJm4cmo
   soVIvbXiLcm0AFafXdxGpSilib/dSSTtT33FH3YvScUU5RMP2cNlCcFPV
   ByB6H3mZhuQj4FsrU0/lAjAMlIrxiUcfPWMxzXDKouV+mixk6tqGDiWwU
   w==;
X-CSE-ConnectionGUID: 2o0t4PlyTgWVBuaH9n42qQ==
X-CSE-MsgGUID: vUNrkn//SnGI9Y4jeIu7ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58644683"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="58644683"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 14:24:08 -0700
X-CSE-ConnectionGUID: FL09nxxnRhaPH9mjGQ3DxQ==
X-CSE-MsgGUID: ojYl6mGmTkKBIEZtGn/+eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200632650"
Received: from mgerlach-mobl1.amr.corp.intel.com (HELO localhost) ([10.124.223.116])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 14:24:07 -0700
Date: Tue, 26 Aug 2025 14:24:05 -0700
From: David Box <david.e.box@linux.intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath12k@lists.infradead.org, ath11k@lists.infradead.org, ath10k@lists.infradead.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/8] PCI/ASPM: Fix the behavior of
 pci_enable_link_state*() APIs
Message-ID: <qfw7nv53hmy6whxnf4zqfdtvjzkdxkvxn7eghuxzuuojmvxl34@sxw2jvxze4wm>
References: <20250825-ath-aspm-fix-v2-0-61b2f2db7d89@oss.qualcomm.com>
 <20250825-ath-aspm-fix-v2-2-61b2f2db7d89@oss.qualcomm.com>
 <f644fc83-31cc-1f0e-58cf-7c007e6173e4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f644fc83-31cc-1f0e-58cf-7c007e6173e4@linux.intel.com>

On Tue, Aug 26, 2025 at 03:55:42PM +0300, Ilpo Järvinen wrote:
> +David
> 
> On Mon, 25 Aug 2025, Manivannan Sadhasivam via B4 Relay wrote:
> 
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > pci_enable_link_state() and pci_enable_link_state_locked() APIs are
> > supposed to be symmectric with pci_disable_link_state() and
> > pci_disable_link_state_locked() APIs.
> > 
> > But unfortunately, they are not symmetric. This behavior was mentioned in
> > the kernel-doc of these APIs:
> > 
> > " Clear and set the default device link state..."
> > 
> > and
> > 
> > "Also note that this does not enable states disabled by
> > pci_disable_link_state()"
> > 
> > These APIs won't enable all the states specified by the 'state' parameter,
> > but only enable the ones not previously disabled by the
> > pci_disable_link_state*() APIs. But this behavior doesn't align with the
> > naming of these APIs, as they give the impression that these APIs will
> > enable all the specified states.
> > 
> > To resolve this ambiguity, allow these APIs to enable the specified states,
> > regardeless of whether they were previously disabled or not. This is
> > accomplished by clearing the previously disabled states from the
> > 'link::aspm_disable' parameter in __pci_enable_link_state() helper. Also,
> > reword the kernel-doc to reflect this behavior.
> > 
> > The current callers of pci_enable_link_state_locked() APIs (vmd and
> > pcie-qcom) did not disable the ASPM states before calling this API. So it
> > is evident that they do not depend on the previous behavior of this API and
> > intend to enable all the specified states.
> 
> While it might be "safe" in the sense that ->aspm_disable is not set by 
> anything, I'm still not sure if overloading this function for two 
> different use cases is a good idea.
> 
> I'd like to hear David's opinion on this as he grasps the ->aspm_default 
> vs ->aspm_disable thing much better than I do.

The concern I see is that this would override the init-time blacklist which is
set in pcie_aspm_sanity_check() and only consulted during initialization.
__pci_disable_link_state() doesn't do this. It ORs in bits to aspm_disable.  By
contrast, this change would clear bits from aspm_disable in the enable path,
which allows ASPM to be enabled on links that pcie_aspm_sanity_check()
determined should be disabled.

But I noticed the sysfs path, aspm_attr_store_common(), already permits this
override. That may be unintentional though since the comment in
pcie_aspm_sanity_check() implies the blacklist can only be overridden with
pcie_aspm=force. At minimum, that needs to be clarified.

David

> 
> > And the other API, pci_enable_link_state() doesn't have a caller for now,
> > but will be used by the 'atheros' WLAN drivers in the subsequent commits.
> > 
> > Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> This tag sound like I'm endorsing this approach which is not the case. I'd 
> prefer separate functions for each use case, setting aspm_default and 
> another for the enable state.
> 
> -- 
>  i.
> 
> > Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 33 ++++++++++++++++++---------------
> >  1 file changed, 18 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index be9bd272057c3472f3e31dc9568340b19d52012a..fac46113a90c7fac6c97125e6a7e385045780005 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1459,6 +1459,7 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
> >  		down_read(&pci_bus_sem);
> >  	mutex_lock(&aspm_lock);
> >  	link->aspm_default = pci_calc_aspm_enable_mask(state);
> > +	link->aspm_disable &= ~state;
> >  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> >  
> >  	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
> > @@ -1471,17 +1472,18 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
> >  }
> >  
> >  /**
> > - * pci_enable_link_state - Clear and set the default device link state so that
> > - * the link may be allowed to enter the specified states. Note that if the
> > - * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
> > - * touch the LNKCTL register. Also note that this does not enable states
> > - * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> > + * pci_enable_link_state - Enable device's link state
> > + * @pdev: PCI device
> > + * @state: Mask of ASPM link states to enable
> > + *
> > + * Enable device's link state, so the link will enter the specified states.
> > + * Note that if the BIOS didn't grant ASPM control to the OS, this does
> > + * nothing because we can't touch the LNKCTL register.
> >   *
> >   * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
> >   * PCIe r6.0, sec 5.5.4.
> >   *
> > - * @pdev: PCI device
> > - * @state: Mask of ASPM link states to enable
> > + * Return: 0 on success, a negative errno otherwise.
> >   */
> >  int pci_enable_link_state(struct pci_dev *pdev, int state)
> >  {
> > @@ -1490,19 +1492,20 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
> >  EXPORT_SYMBOL(pci_enable_link_state);
> >  
> >  /**
> > - * pci_enable_link_state_locked - Clear and set the default device link state
> > - * so that the link may be allowed to enter the specified states. Note that if
> > - * the BIOS didn't grant ASPM control to the OS, this does nothing because we
> > - * can't touch the LNKCTL register. Also note that this does not enable states
> > - * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> > + * pci_enable_link_state_locked - Enable device's link state
> > + * @pdev: PCI device
> > + * @state: Mask of ASPM link states to enable
> > + *
> > + * Enable device's link state, so the link will enter the specified states.
> > + * Note that if the BIOS didn't grant ASPM control to the OS, this does
> > + * nothing because we can't touch the LNKCTL register.
> >   *
> >   * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
> >   * PCIe r6.0, sec 5.5.4.
> >   *
> > - * @pdev: PCI device
> > - * @state: Mask of ASPM link states to enable
> > - *
> >   * Context: Caller holds pci_bus_sem read lock.
> > + *
> > + * Return: 0 on success, a negative errno otherwise.
> >   */
> >  int pci_enable_link_state_locked(struct pci_dev *pdev, int state)
> >  {
> > 
> > 


