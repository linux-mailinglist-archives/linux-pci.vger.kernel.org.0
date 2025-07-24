Return-Path: <linux-pci+bounces-32897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3231B11166
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 21:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6C57B4B52
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 19:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAEE2EBDF2;
	Thu, 24 Jul 2025 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/iISoze"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074052D9EE1;
	Thu, 24 Jul 2025 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753384087; cv=none; b=KAavie70N4UAoi2PWfJoCGFm0dIDvZ/HE5o1FvP+1+P2UUN+0H8pL6DarSepvw0pOlXeXA77OunO0XUMbKppIjS2Dq2X8qcB+vxgJ2xu0pHHotYTZ4wFjUK7X+2P9k3nkISTOyHbOUJvPmt/GfLg86GINn7Fz/KLqNvHikuQU4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753384087; c=relaxed/simple;
	bh=uWh4x+mR1n0u6bohy+lADKX0ne5hhZ3KsRUW7OuUvt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIsviycNKYrSkEhal9XfmQautvZ2xgubAk7fnLlrl4Y5PRQGe8PPS2oWBo7nWbcfJgrdTyfzUkP9MVEZtPebYk9f+nCc3SPezv3Bk+Ws9sCPafchXWUZa8H1iBg4Yja6+9vLyDYzsBShLtZnjBZXtcRx9lOWmvPPZ1blfPb7isc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/iISoze; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753384086; x=1784920086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uWh4x+mR1n0u6bohy+lADKX0ne5hhZ3KsRUW7OuUvt4=;
  b=f/iISozeEf4ZojgY7VwtQa8xfVW0uYEN2B349LmlIoQcq6GHNRoc4sh3
   CQHQ0leNXEAwalT99A3CzjbgBWnIBo2gsMu4EhU63nqdJxg1dJf7xYHMq
   /Ll2+jHO6EBoOAUo5s4rg6zn25hNr3adhRFIFhCVUPLTH0zknxDIEyxIs
   bLJOxsG+u2t31nRKa+rt2uEWx8QYFyl//x8rQYpTL5GuFdbLuQycYC3Mp
   cZfC1sXm7V2MavrEmI2k9lPMs1loMfcI5EysWSiTHJiCWQEr/HOX2FwTT
   Kbe0OKPvyqCEbPz5JyDIcj46EMXVxiS/Pr4GuecEwTzFeOfdfQdpHlPDq
   g==;
X-CSE-ConnectionGUID: ESI0mMHPRAenqn4Q8245Cg==
X-CSE-MsgGUID: uOXSBpMLScSqMcUE+KsTxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="58335932"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="58335932"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 12:08:05 -0700
X-CSE-ConnectionGUID: HowpdGPpT2Knv1J3PNZTqg==
X-CSE-MsgGUID: kvCZJ5m3TMqKc+0Uh0u9dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="165773359"
Received: from mgoodin-mobl3.amr.corp.intel.com (HELO localhost) ([10.124.223.185])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 12:08:04 -0700
Date: Thu, 24 Jul 2025 12:08:03 -0700
From: David Box <david.e.box@linux.intel.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, bhelgaas@google.com, 
	vicamo.yang@canonical.com, kenny@panix.com, ilpo.jarvinen@linux.intel.com, 
	nirmal.patel@linux.intel.com, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Allow controller drivers to override default
 ASPM and CLKPM link state
Message-ID: <fiuyebro52meyyri2qamj3h2eijjebl3uhgnalo7wwjholwml7@rgpmcegwjxid>
References: <20250720190140.2639200-1-david.e.box@linux.intel.com>
 <c6757u3xdyxxuodcjsbpdje7m4qiq26tug5lfxvpbs5wm7r56l@ksy4yge7kg35>
 <CAJZ5v0jZrPyW9+Ccoo955Y4oje2SiAQA9aCChAoPgM28SJqf5g@mail.gmail.com>
 <arotuyooaoo6ustmp5gnoj64pkpyvcc3plekh4yt46siuemlik@sv6tjxnggznx>
 <CAJZ5v0hDEX_ZMiAZU-PwriCpURiw04f=JLAVwP9UJ54wv3HBEg@mail.gmail.com>
 <scajymgengcxt6e4ekl53hteig4mgu34wwif2r737xvtcdghg4@ej4qn2rbcxzg>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <scajymgengcxt6e4ekl53hteig4mgu34wwif2r737xvtcdghg4@ej4qn2rbcxzg>

On Thu, Jul 24, 2025 at 10:18:47PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jul 24, 2025 at 11:58:40AM GMT, Rafael J. Wysocki wrote:
> > On Wed, Jul 23, 2025 at 11:27 PM David Box <david.e.box@linux.intel.com> wrote:
> > >
> > > On Wed, Jul 23, 2025 at 01:54:41PM +0200, Rafael J. Wysocki wrote:
> > > > On Mon, Jul 21, 2025 at 10:24 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > > >
> > > > > On Sun, Jul 20, 2025 at 12:01:37PM GMT, David E. Box wrote:
> > > > > > Synthetic PCIe hierarchies, such as those created by Intel VMD, are not
> > > > > > visible to firmware and do not receive BIOS-provided default ASPM and CLKPM
> > > > > > configuration. As a result, devices behind such domains operate without
> > > > > > proper power management, regardless of platform intent.
> > > > > >
> > > > > > To address this, allow controller drivers to supply an override for the
> > > > > > default link state by setting aspm_dflt_link_state for their associated
> > > > > > pci_host_bridge. During link initialization, if this field is non-zero,
> > > > > > ASPM and CLKPM defaults are derived from its value instead of being taken
> > > > > > from BIOS.
> > > > > >
> > > > > > This mechanism enables drivers like VMD to achieve platform-aligned power
> > > > > > savings by statically defining the expected link configuration at
> > > > > > enumeration time, without relying on runtime calls such as
> > > > > > pci_enable_link_state(), which are ineffective when ASPM is disabled
> > > > > > globally.
> > > > > >
> > > > > > This approach avoids per-controller hacks in ASPM core logic and provides a
> > > > > > general mechanism for domains that require explicit control over link power
> > > > > > state defaults.
> > > > > >
> > > > > > Link: https://lore.kernel.org/linux-pm/0b166ece-eeec-ba5d-2212-50d995611cef@panix.com
> > > > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > > > ---
> > > > > >
> > > > > > Changes from RFC:
> > > > > >
> > > > > >   -- Rename field to aspm_dflt_link_state since it stores
> > > > > >      PCIE_LINK_STATE_XXX flags, not a policy enum.
> > > > > >   -- Move the field to struct pci_host_bridge since it's being applied to
> > > > > >      the entire host bridge per Mani's suggestion.
> > > > > >   -- During testing noticed that clkpm remained disabled and this was
> > > > > >      also handled by the formerly used pci_enable_link_state(). Add a
> > > > > >      check in pcie_clkpm_cap_init() as well to enable clkpm during init.
> > > > > >
> > > > > >  drivers/pci/controller/vmd.c | 12 +++++++++---
> > > > > >  drivers/pci/pcie/aspm.c      | 13 +++++++++++--
> > > > > >  include/linux/pci.h          |  4 ++++
> > > > > >  3 files changed, 24 insertions(+), 5 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > > > > > index 8df064b62a2f..6f0de95c87fd 100644
> > > > > > --- a/drivers/pci/controller/vmd.c
> > > > > > +++ b/drivers/pci/controller/vmd.c
> > > > > > @@ -730,7 +730,7 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
> > > > > >  }
> > > > > >
> > > > > >  /*
> > > > > > - * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
> > > > > > + * Enable LTR settings on devices that aren't configured by BIOS.
> > > > > >   */
> > > > > >  static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> > > > > >  {
> > > > > > @@ -770,7 +770,6 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
> > > > > >        * PCIe r6.0, sec 5.5.4.
> > > > > >        */
> > > > > >       pci_set_power_state_locked(pdev, PCI_D0);
> > > > >
> > > > > This call becomes useless now.
> > >
> > > Missed this. I'll remove it.
> > >
> > > > >
> > > > > > -     pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> > > > > >       return 0;
> > > > > >  }
> > > > > >
> > > > > > @@ -785,6 +784,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > > > > >       resource_size_t membar2_offset = 0x2000;
> > > > > >       struct pci_bus *child;
> > > > > >       struct pci_dev *dev;
> > > > > > +     struct pci_host_bridge *vmd_host_bridge;
> > > > > >       int ret;
> > > > > >
> > > > > >       /*
> > > > > > @@ -911,8 +911,14 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
> > > > > >               return -ENODEV;
> > > > > >       }
> > > > > >
> > > > > > +     vmd_host_bridge = to_pci_host_bridge(vmd->bus->bridge);
> > > > > > +
> > > > > > +#ifdef CONFIG_PCIEASPM
> > > > > > +     vmd_host_bridge->aspm_dflt_link_state = PCIE_LINK_STATE_ALL;
> > > > > > +#endif
> > > > >
> > > > > I think it is better to provide an API that accepts the link state. We can
> > > > > provide a stub if CONFIG_PCIEASPM is not selected. This will avoid the ifdef
> > > > > clutter in the callers. Like:
> > > > >
> > > > > void pci_set_default_link_state(struct pci_host_bridge *host_bridge,
> > > > >                                 unsigned int state)
> > > > > {
> > > > > #ifdef CONFIG_PCIEASPM
> > > > >          host_bridge->aspm_default_link_state = state;
> > > > > #endif
> > > > > }
> > > > >
> > > > > Or you can stub the entire function to align with other ASPM APIs.
> > > > >
> > > > > One more thought: Since this API is only going to be called by the host bridge
> > > > > drivers, we can place it in drivers/pci/controller/pci-host-common.c and name it
> > > > > as pci_host_common_set_default_link_state().
> > >
> > > This would require VMD to select PCI_HOST_COMMON just to set one field in a
> > > common struct. Seems heavy-handed. Thoughts? Also, with this and dropping the D0
> > > call, I'll split the VMD cleanup into a separate patch again.
> > 
> > So maybe define a __weak pci_host_set_default_pcie_link_state() doing
> > nothing in the ASPM core and let VMD override it with its own
> > implementation?
> > 
> 
> No. There are other controller drivers (like pcie-qcom) going to use this API.
> So please move it to the pci-host-common library as it should be.

I was going to suggest that it could simply stay in aspm.c.
pci_enable_link_state_() is there and currently only used by controllers as
well.

David

