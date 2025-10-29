Return-Path: <linux-pci+bounces-39595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E78CC184C0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 06:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6323BE448
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 05:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2AE22D0C7B;
	Wed, 29 Oct 2025 05:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0+IApN7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDB02E3B08
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 05:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716038; cv=none; b=u6H9bGNAHbzLyPwllTS9aHAkN8PTMfV2bcs2EYu2f+jlofMcadNz/I3KuT7/JiwtkKGmJi3a7Ud95z2piJD3kBRTz6/xsK66zK6WsftJlrVNIr/mVsF+RORbpnAp3P1RYl0Lb5kXgJ4kp5JqI7iIoad2wnDdrqu+XvASckdgA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716038; c=relaxed/simple;
	bh=RWhLJiIYo76jtzFbGpMNLV3Pzlubr+Fpvat0f/j8nmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovQuhlBrwQIpOPqZ4aftZsoyQVvWQ7mTBXJBW1sv2ooNladXlwZHICauKguvtLiJGL33gwrq/qDAqMrPai5U19Gd8oziUwzn7T7ZGmJBrbO1DxnwkciXkdkjL0QZkfYCGBhD2pYCqytIhSTm0KX3+Hx51JUYMk1budR4WU9qM4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0+IApN7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761716037; x=1793252037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RWhLJiIYo76jtzFbGpMNLV3Pzlubr+Fpvat0f/j8nmU=;
  b=F0+IApN7AOeUkzd1s4A10d7V9dh5C6sPLZQeOEnX5olJF0lSMOJtegP6
   EUNrJErCZ84k8tIHIqAmlSG147T6j5H/qwl1BFpHCSKjdLgrLmQM20q4e
   VlLXoZJ6069rAeh5wb2/tWv+lSaJDPWDj5GbxjeaAMGHI4cLla5M9nqmN
   YF25yncdZc+VLZ9gQw8R4XPSAHWx8pCxVBT3q5AQ02ZzpySL0YcD4lxN+
   r6s3EJWKDar/HUph8uybbMoz2LcWDi+YwqCgMjwSuP0C156f5eWxwAOfY
   4597x52l+iK3vySM8wxIr9R92KUA9VcugVSb1TTjKXWWtUyxjrs26dEnV
   w==;
X-CSE-ConnectionGUID: MMHgtJFGSseQvp0aur9B1g==
X-CSE-MsgGUID: q+zNe4a0S5u1CUFRm9QOTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63528723"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="63528723"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 22:33:57 -0700
X-CSE-ConnectionGUID: yVIv4r9QSkS8+uTM/O6dPA==
X-CSE-MsgGUID: /vZ2KxRZRse62vQ3Y+lLKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="186016310"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 28 Oct 2025 22:33:55 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 75FC195; Wed, 29 Oct 2025 06:33:54 +0100 (CET)
Date: Wed, 29 Oct 2025 06:33:54 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] PCI/PTM: Do not enable PTM solely based on the
 capability existense
Message-ID: <20251029053354.GV2912318@black.igk.intel.com>
References: <20251028060427.2163115-1-mika.westerberg@linux.intel.com>
 <20251028170639.GA1518773@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028170639.GA1518773@bhelgaas>

On Tue, Oct 28, 2025 at 12:06:39PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 28, 2025 at 07:04:27AM +0100, Mika Westerberg wrote:
> > It is not advisable to enable PTM solely based on the fact that the
> > capability exists. Instead there are separate bits in the capability
> > register that need to be set for the feature to be enabled for a given
> > component (this is suggestion from Intel PCIe folks):
> > 
> >   - PCIe Endpoint that has PTM capability must to declare requester
> >     capable
> >   - PCIe Switch Upstream Port that has PTM capability must declare
> >     at least responder capable
> >   - PCIe Root Port must declare root port capable.
> > 
> > Currently we see following:
> > 
> >   pci 0000:01:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Upstream Port
> >   pci 0000:01:00.0: PCI bridge to [bus 00]
> >   pci 0000:01:00.0:   bridge window [io  0x0000-0x0fff]
> >   pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff]
> >   pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> >   ...
> >   pci 0000:01:00.0: PTM enabled, 4ns granularity
> >   ...
> >   pcieport 0000:00:07.0: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.0
> >   pcieport 0000:00:07.0: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
> >   pcieport 0000:00:07.0:   device [8086:e44e] error status/mask=00200000/00000000
> >   pcieport 0000:00:07.0:    [21] ACSViol                (First)
> > 
> > The 01:00.0 PCIe Upstream Port has this:
> > 
> >   Capabilities: [220 v1] Precision Time Measurement
> > 		PTMCap: Requester- Responder- Root-
> > 
> > This happens because Linux sees the PTM capability and blindly enables
> > PTM which then causes the AER error to trigger.
> > 
> > Fix this by enabling PTM only if the above described criteria is met.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> > Previous version can be seen:
> > 
> >   https://lore.kernel.org/linux-pci/20251021104833.3729120-1-mika.westerberg@linux.intel.com/
> > 
> > Changes from the previous version:
> > 
> >   - Limit Switch Upstream Port only to Responder, not both Requester and
> >     Responder.
> > 
> >  drivers/pci/pcie/ptm.c | 31 +++++++++++++++++++++++++++----
> >  1 file changed, 27 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > index 65e4b008be00..5ebb2edb4dec 100644
> > --- a/drivers/pci/pcie/ptm.c
> > +++ b/drivers/pci/pcie/ptm.c
> > @@ -81,9 +81,24 @@ void pci_ptm_init(struct pci_dev *dev)
> >  		dev->ptm_granularity = 0;
> >  	}
> >  
> > -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > -	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
> > -		pci_enable_ptm(dev, NULL);
> > +	switch (pci_pcie_type(dev)) {
> > +	case PCI_EXP_TYPE_ROOT_PORT:
> > +		/*
> > +		 * Root Port must declare Root Capable if we want to
> > +		 * enable PTM for it.
> > +		 */
> > +		if (dev->ptm_root)
> > +			pci_enable_ptm(dev, NULL);
> > +		break;
> > +	case PCI_EXP_TYPE_UPSTREAM:
> > +		/*
> > +		 * Switch Upstream Ports must at least declare Responder
> > +		 * Capable if we want to enable PTM for it.
> > +		 */
> > +		if (cap & PCI_PTM_CAP_RES)
> > +			pci_enable_ptm(dev, NULL);
> > +		break;
> > +	}
> >  }
> >  
> >  void pci_save_ptm_state(struct pci_dev *dev)
> > @@ -125,7 +140,7 @@ static int __pci_enable_ptm(struct pci_dev *dev)
> >  {
> >  	u16 ptm = dev->ptm_cap;
> >  	struct pci_dev *ups;
> > -	u32 ctrl;
> > +	u32 cap, ctrl;
> >  
> >  	if (!ptm)
> >  		return -EINVAL;
> > @@ -144,6 +159,14 @@ static int __pci_enable_ptm(struct pci_dev *dev)
> >  			return -EINVAL;
> >  	}
> >  
> > +	/*
> > +	 * PCIe Endpoint must declare Requester Capable before we can
> > +	 * enable PTM for it.
> > +	 */
> > +	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
> > +	if (!(cap & PCI_PTM_CAP_REQ))
> > +		return -EINVAL;
> 
> Isn't this going to prevent enabling PTM on Root Ports?

Isn't this function called only for Endpoints? Root Ports and Switch Ports
are enabled in pci_ptm_init() instead.

> >  	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
> >  
> >  	ctrl |= PCI_PTM_CTRL_ENABLE;
> > -- 
> > 2.50.1
> > 

