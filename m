Return-Path: <linux-pci+bounces-40927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E30E6C4ED85
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 16:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD03188A47B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E692FCBEF;
	Tue, 11 Nov 2025 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdGTbdIh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F7B26E146
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876019; cv=none; b=cimDWDle7IAWCzbLSkjzU6K1bdC7LhTMvMF0T9cJ8Z2bCd2yrjKNUg1oI2NacmxwXGlafYRyuB8uLj1qiMo15Izgy13xp1vIsu0k9+iFtXZNEKk25K7LBYqc4fOrGywjmiHf549LQllNmZlx9kDNI1JR4LCzEdBT/4imXxZURKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876019; c=relaxed/simple;
	bh=EWYFeMiR+cDVeEtIY4903y2dovG/LJ4RyR6T9SqSRx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0CGIafZU+2FXBy0GG7Pk9ZJZM0PIbBAdH3sr1aVbvNFnnMhnjC3tkdL+GqVlq/OTiuBBUC+rMY2ILyKnD5N9jw/CiI069604Yevj42q6qybKIUgQf+wbubQAKIGt2GE8kmKk+Q9x1/BkAQkEainet/875+1/SBy1KIBx9/sP2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdGTbdIh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762876017; x=1794412017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EWYFeMiR+cDVeEtIY4903y2dovG/LJ4RyR6T9SqSRx8=;
  b=FdGTbdIhm2iTMyks14X96IbRhgFnjRWTwZALFKSgkb+3uUp+7ZnWA7aW
   eSRy+7aa07PgrM3uVAQq6JOxL7Gv7Wy92eA22F+S5Dr8Ys98Js+Ca0ZAz
   4CFiBrpcyya4oVVTexc96fPk3UDIPbikY27FOhvvtoHGSdJixc/qP4krE
   /hU8rOFjeeKwU8AWNdOGEiW81wcBiI/eIzaZWYR8fR7wp9HHLoRF3R2wk
   eAh8a1yVHg7xijoRTyRNVM+SDH1uMmUx0wZ09C5n/fCjiQ1Smwd0gFMOP
   PxCxqoCkXfHw2HZXQh9p253PRK5oH/CpRBLd4zwjD3k3iJOCyV3cp9Iwm
   w==;
X-CSE-ConnectionGUID: h3swe4k8RfawHZPlHPFbcA==
X-CSE-MsgGUID: itbo9DzxTL62BZ7x0cOAxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="87568906"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="87568906"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 07:46:57 -0800
X-CSE-ConnectionGUID: CiWI1zW1Q1+EAAlhjkp+ew==
X-CSE-MsgGUID: An/nNLjLT3a8YR2DiZIbyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="189721716"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 11 Nov 2025 07:46:54 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B40BE96; Tue, 11 Nov 2025 16:46:53 +0100 (CET)
Date: Tue, 11 Nov 2025 16:46:53 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v4] PCI/PTM: Enable PTM only if it advertises a role
Message-ID: <20251111154653.GV2912318@black.igk.intel.com>
References: <20251111061048.681752-1-mika.westerberg@linux.intel.com>
 <20251111153942.GA2174680@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111153942.GA2174680@bhelgaas>

Hi,

On Tue, Nov 11, 2025 at 09:39:42AM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 11, 2025 at 07:10:48AM +0100, Mika Westerberg wrote:
> > We have a Upstream Port (2b:00.0) that has following in the PTM capability:
> > 
> >   Capabilities: [220 v1] Precision Time Measurement
> > 		PTMCap: Requester- Responder- Root-
> > 
> > Linux enables PTM for this without looking into what roles it actually
> > supports. Immediately after enabling PTM we start getting these:
> > 
> >   pci 0000:2b:00.0: [8086:5786] type 01 class 0x060400 PCIe Switch Upstream Port
> >   ...
> >   pci 0000:2b:00.0: PTM enabled, 4ns granularity
> >   ...
> >   pcieport 0000:00:07.1: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.1
> >   pcieport 0000:00:07.1: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
> >   pcieport 0000:00:07.1:   device [8086:e44f] error status/mask=00200000/00000000
> >   pcieport 0000:00:07.1:    [21] ACSViol                (First)
> >   pcieport 0000:00:07.1: AER:   TLP Header: 0x34000000 0x00000052 0x00000000 0x00000000
> > 
> > Fix this by enabling PTM only if any of the following conditions are
> > true (see more in PCIe r7.0 sec 6.21.1 figure 6-21):
> > 
> >   - PCIe Endpoint that has PTM capability must to declare requester
> >     capable
> >   - PCIe Switch Upstream Port that has PTM capability must declare
> >     at least responder capable
> >   - PCIe Root Port must declare root port capable.
> > 
> > While there make the enabling happen for all in __pci_enable_ptm() instead
> > of enabling some in pci_ptm_init() and some in __pci_enable_ptm().
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> > Previous versions can be seen:
> > 
> >   v3: https://lore.kernel.org/linux-pci/20251030134606.3782352-1-mika.westerberg@linux.intel.com/
> >   v2: https://lore.kernel.org/linux-pci/20251028060427.2163115-1-mika.westerberg@linux.intel.com/
> >   v1: https://lore.kernel.org/linux-pci/20251021104833.3729120-1-mika.westerberg@linux.intel.com/
> > 
> > Changes from v3:
> > 
> >   - Cache the responder and requester capability bits.
> >   - Enable PTM only in __pci_enable_ptm().
> >   - Update $subject and commit message.
> >   - Since this is changed quite a lot, I dropped the Reviewed-by from Lukas
> >     and also stable tag.
> > 
> > Changes from v2:
> > 
> >   - Limit the check in __pci_enable_ptm() to Endpoints and Legacy
> >     Endpoints.
> >   - Added stable tags suggested by Lukas, and PCIe spec reference.
> >   - Added Reviewed-by tag from Lukas (hope it is okay to keep).
> > 
> > Changes from v1:
> > 
> >   - Limit Switch Upstream Port only to Responder, not both Requester and
> >     Responder.
> > 
> >  drivers/pci/pcie/ptm.c | 41 ++++++++++++++++++++++++++++++++++++++---
> >  include/linux/pci.h    |  2 ++
> >  2 files changed, 40 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > index 65e4b008be00..30e25f1ad28e 100644
> > --- a/drivers/pci/pcie/ptm.c
> > +++ b/drivers/pci/pcie/ptm.c
> > @@ -81,9 +81,12 @@ void pci_ptm_init(struct pci_dev *dev)
> >  		dev->ptm_granularity = 0;
> >  	}
> >  
> > -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > -	    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
> > -		pci_enable_ptm(dev, NULL);
> > +	if (cap & PCI_PTM_CAP_RES)
> > +		dev->ptm_responder = 1;
> > +	if (cap & PCI_PTM_CAP_REQ)
> > +		dev->ptm_requester = 1;
> > +
> > +	pci_enable_ptm(dev, NULL);
> 
> This seems nice and clean overall.
> 
> I do wonder about the fact that previously we automatically enabled
> PTM only for Root Ports and Switch Upstream Ports, but we didn't
> enable it for Endpoints until a driver called pci_enable_ptm().

Oh, that's good point actually.

Yeah it should be like this still:

if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
    pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM)
	pci_enable_ptm(dev, NULL);

To keep the behaviour same.

> With this change, it looks like we automatically enable PTM for every
> device that supports it.  Worth a mention in the commit log, and we
> might also want to revisit the drivers (ice, idpf, igc, mlx5) that
> explicitly enable it to remove the enable and disable calls there.
> 
> PTM consumes some link bandwidth, so the idea was to avoid paying that
> cost unless a driver actually wanted to use PTM.  PTM Messages are
> local, so they terminate at the Switch Downstream Port or Root Port
> that receives them.  I assumed that Switches would only send PTM
> Requests upstream if they received a PTM Request from a downstream
> device, so I thought it would be free to enable PTM on the Switch.
> 
> But apparently that isn't true; these errors happen immediately when
> enabling PTM on the Switch, before it's enabled on any downstream
> device.  And it makes sense that a Switch could provide better service
> if it kept its local Time Source updated so it could generate PTM
> Responses directly instead of sending a request upstream, waiting for
> a response, and passing it along downstream.
> 
> I still feel like it's worth avoiding the bandwidth cost by leaving
> PTM disabled unless a driver wants it.  The cost is probably small,
> but why pay it if we're not using PTM?  What are your thoughts?

Fully agree. It was my mistake. If no objections I'll submit v5 with the
above added back (+ the newline inconsistency thing Lukas mentioned).

