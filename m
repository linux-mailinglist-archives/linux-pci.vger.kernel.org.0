Return-Path: <linux-pci+bounces-39629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3882FC19FAE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 12:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8F0E347F11
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 11:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE6A33B976;
	Wed, 29 Oct 2025 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6VmYy1c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D443375C5
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736879; cv=none; b=g1K1TlmJTX7enQADZyeLWAjoXcoQvlDpFAXnD6AXisDTGVAop3gVNk1b9LNPcF5F/atFRHRMZgMh0pY8bpTlYv+ZeG53I7qHaiC9eb4wwYKDlu8+CDp0Q2lMTFAJatv97hveF5HzjMAcLiW2REgrZ+Pf92NsV5B7rwpafLrGMXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736879; c=relaxed/simple;
	bh=JgL2Utc9HJ5/0CQ4Gn53bHlvqOBcIwUnk9+yI3kzKpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6AN4jUCpJ4ENLn8nIgawDJA1jNdeZzLrugNgDaynRtBZCRN+8oknCOMaS4m71u9O2mEJ6hbFKpIo2TyI4TiArY2WPIiKRcbn82WN/pI1z0p/jr0T8MpJvKJUZA/6H+Hq+9k8r3yY2aC+AF/1z3mjww1nTaF3J6WhX/uYApfDlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6VmYy1c; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761736876; x=1793272876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JgL2Utc9HJ5/0CQ4Gn53bHlvqOBcIwUnk9+yI3kzKpc=;
  b=e6VmYy1cIr6NUU/J1FYQk++5wRNFnIhrnYsnQVO0hS7q0Mh5WT30rM7g
   E6Ch0VH4ZLKCtM8ZiAkVsm5KHJ4/IH9rMUQqLDW5D5Lxw5or/fbpS6t1C
   KLkpiE0R2UzG/2gulCqJ78VUo7RN/RGl1T+UBrsYKSSLrSnnPMRcEX59g
   qhYQ1XwVb2TB2mwDg+r3peLsaO8E9KbrLtWPaxlgfqdWemDjI7mCeCPVm
   4OvHqf9quQ4Gq2lCM//TE7SOszEZFk6mPLfzRCEd496VJ728pYg3V0FV8
   T1bOKgUFX36M9mkfDkWenR3hBEYOMZAANcOrCjqQMgVQvw+KiWI2HhfgL
   A==;
X-CSE-ConnectionGUID: yFwf/CcwRw+pJYPTfWbrig==
X-CSE-MsgGUID: xi54kWcaQbiR1Z0nh8oeDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63758385"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63758385"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 04:20:55 -0700
X-CSE-ConnectionGUID: dHlcl7M7Qfe9ZNbrUlhrvg==
X-CSE-MsgGUID: WG4HlY/hSRyjK/2SeLk4CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="189982827"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 29 Oct 2025 04:20:54 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 2ABEE95; Wed, 29 Oct 2025 12:20:53 +0100 (CET)
Date: Wed, 29 Oct 2025 12:20:53 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI/PTM: Do not enable PTM solely based on the
 capability existense
Message-ID: <20251029112053.GW2912318@black.igk.intel.com>
References: <20251028060427.2163115-1-mika.westerberg@linux.intel.com>
 <20251028170639.GA1518773@bhelgaas>
 <20251029053354.GV2912318@black.igk.intel.com>
 <aQHyPWYNSVTeOdYs@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQHyPWYNSVTeOdYs@wunner.de>

On Wed, Oct 29, 2025 at 11:53:49AM +0100, Lukas Wunner wrote:
> On Wed, Oct 29, 2025 at 06:33:54AM +0100, Mika Westerberg wrote:
> > On Tue, Oct 28, 2025 at 12:06:39PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Oct 28, 2025 at 07:04:27AM +0100, Mika Westerberg wrote:
> > > > @@ -125,7 +140,7 @@ static int __pci_enable_ptm(struct pci_dev *dev)
> > > >  {
> > > >  	u16 ptm = dev->ptm_cap;
> > > >  	struct pci_dev *ups;
> > > > -	u32 ctrl;
> > > > +	u32 cap, ctrl;
> > > >  
> > > >  	if (!ptm)
> > > >  		return -EINVAL;
> > > > @@ -144,6 +159,14 @@ static int __pci_enable_ptm(struct pci_dev *dev)
> > > >  			return -EINVAL;
> > > >  	}
> > > >  
> > > > +	/*
> > > > +	 * PCIe Endpoint must declare Requester Capable before we can
> > > > +	 * enable PTM for it.
> > > > +	 */
> > > > +	pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
> > > > +	if (!(cap & PCI_PTM_CAP_REQ))
> > > > +		return -EINVAL;
> > > 
> > > Isn't this going to prevent enabling PTM on Root Ports?
> > 
> > Isn't this function called only for Endpoints? Root Ports and Switch Ports
> > are enabled in pci_ptm_init() instead.
> 
> The function is also called for Root Ports:
> 
>   pci_ptm_init()
>     pci_enable_ptm()
>       __pci_enable_ptm()

Ah, indeed. How did I miss that? ;-)

> So I guess you need to constrain this to:
> 
>   PCI_EXP_TYPE_ENDPOINT
>   PCI_EXP_TYPE_LEG_END

Sure I'll do that in v3.

Thanks!

