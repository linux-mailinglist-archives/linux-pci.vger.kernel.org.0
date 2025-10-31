Return-Path: <linux-pci+bounces-39891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC29C23522
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 07:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D3D4067F8
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 06:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9094A223DDD;
	Fri, 31 Oct 2025 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KW7YycEh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB7F2E6CB5
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 06:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891005; cv=none; b=WhUi33RZ7HaWLyzw/TR2jOpKfPNmDgo7qr+S3YHS+8aOPAXxIzSHy12PShwMaM+lplcnvDpc434KG6yNFFCR9kNif7G5PXNv1VzkOw9azcSPYU0xuzAVE9W8rLiIUnzpwUKvpdXUIpMj2FUkBnI4q19sr0N4em3AOhtPrgYe5S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891005; c=relaxed/simple;
	bh=IO+VEIdaI5SHWJFXfCDiRjRPgQINLlvxUQi630aLSc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCQ5C4a7upDKhGdn4QpiN+6wqszlIEEvcP5A3nsLo5DA0gv40ssJNby8vu2iUU7gZ4G9gQXUrrnN42ejn7ZaszpiF0Bj4D4xZur+hpCKur4Bu8EQVdzgsPhXnnujdNp66l8RWZ5QeCxw8TvuVTChb9popn1AH8FNl7IFR/VH7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KW7YycEh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761891003; x=1793427003;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IO+VEIdaI5SHWJFXfCDiRjRPgQINLlvxUQi630aLSc8=;
  b=KW7YycEhpUYZ5lccG420MrYMZW3kBo13TXxSQoCJ/FCPYbjxfThZs+T7
   upK7UkD2cOBlKHJ6jnOjBZodZpdeq7j2NQXO40dsZlH+PgIJMMVPLMREc
   oPhLzzxlApWQDbLCgz394Lv9aNnsqL7OJkpMyc5HeOO9x+SY5NBTcc3hC
   Ly30vTNPBtdNwuhCEEKW7Sbn4nZ7TpAPm2nW7XfaEGLdA9QTujfQifNJA
   QbOjQrgx/rkPkwK0AeIzV54ym4fFKmuCa+T0fqqaMsGChdEJy2yVFddmV
   bqlKNp1g0li8RPLzxrKc3mFhwRjnOTAw67e/2H+XNvbIcLxM9XcMv56+j
   A==;
X-CSE-ConnectionGUID: yjVwZAkCQSWGtj+ioy9nkA==
X-CSE-MsgGUID: lSxpF59dRLCeVPtk6AX8kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63065476"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="63065476"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 23:10:01 -0700
X-CSE-ConnectionGUID: 0WFfirbXSVmMoj2TrHaNOQ==
X-CSE-MsgGUID: UjxPHi2lQhq85/Kw2jKv1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="191297860"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 30 Oct 2025 23:10:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 93A0195; Fri, 31 Oct 2025 07:09:59 +0100 (CET)
Date: Fri, 31 Oct 2025 07:09:59 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI/PTM: Do not enable PTM solely based on the
 capability existense
Message-ID: <20251031060959.GY2912318@black.igk.intel.com>
References: <20251030134606.3782352-1-mika.westerberg@linux.intel.com>
 <20251030205937.GA1648870@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030205937.GA1648870@bhelgaas>

On Thu, Oct 30, 2025 at 03:59:37PM -0500, Bjorn Helgaas wrote:
> In subject, s/existense/existence/
> 
> Actually, I'd try to include something more specific like "enable PTM
> only if it advertises a role".

Okay.

> On Thu, Oct 30, 2025 at 02:46:05PM +0100, Mika Westerberg wrote:
> > It is not advisable to enable PTM solely based on the fact that the
> > capability exists. Instead there are separate bits in the capability
> > register that need to be set for the feature to be enabled for a given
> > component (this is suggestion from Intel PCIe folks, and also shown in
> > PCIe r7.0 sec 6.21.1 figure 6-21):
> 
> Can we start with a minimal statement of what's wrong?  Is the problem
> that 01:00.0 sent a PTM Request Message that 00:07.0 detected as an
> ACS violation?

The problem is that once the PCIe Switch is hotplugged we get tons of AER
errors like below (here upstream port is 2b:00.0, in the previous example
it was 01:00.0):

[  156.337979] pci 0000:2b:00.0: PTM enabled, 4ns granularity
[  156.350822] pcieport 0000:00:07.1: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.1
[  156.361417] pcieport 0000:00:07.1: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver I
D)
[  156.372656] pcieport 0000:00:07.1:   device [8086:e44f] error status/mask=00200000/00000000
[  156.381041] pcieport 0000:00:07.1:    [21] ACSViol                (First)
[  156.387842] pcieport 0000:00:07.1: AER:   TLP Header: 0x34000000 0x00000052 0x00000000 0x00000000
[  156.396731] pcieport 0000:00:07.1: AER: broadcast error_detected message
[  156.403498] pcieport 0000:00:07.1: AER: broadcast mmio_enabled message
[  156.410060] pcieport 0000:00:07.1: AER: broadcast resume message
[  156.416131] pcieport 0000:00:07.1: AER: device recovery successful
[  156.422345] pcieport 0000:00:07.1: AER: Uncorrectable (Non-Fatal) error message received from 0000:00:07.1

Here 00:07.1 is the PCIe Root Port.

> I guess we enabled PTM on 01:00.0 even though it doesn't advertise any
> roles in the PTM Capability, and it sent a PTM Request Message anyway?

Yes, I think so.

> Weird to expose a PTM Capability and not advertise any roles, and also
> weird to send PTM Messages when enabled in that case.
> 
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
> 
> I don't think the windows are relevant.

Okay.

> >   pci 0000:01:00.0: PTM enabled, 4ns granularity
> >   ...
> >   pcieport 0000:00:07.0: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.0
> >   pcieport 0000:00:07.0: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
> >   pcieport 0000:00:07.0:   device [8086:e44e] error status/mask=00200000/00000000
> >   pcieport 0000:00:07.0:    [21] ACSViol                (First)
> 
> Is there any Header Log info here?  I assume if there is, it would
> show a PTM Message?

I pasted it above. Does it tell anything useful to you?

> > The 01:00.0 PCIe Upstream Port has this:
> > 
> >   Capabilities: [220 v1] Precision Time Measurement
> > 		PTMCap: Requester- Responder- Root-
> > 
> > This happens because Linux sees the PTM capability and blindly enables
> > PTM which then causes the AER error to trigger.
> > 
> > Fix this by enabling PTM only if the above described criteria is met.
> > ...
> 
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
> > @@ -144,6 +159,18 @@ static int __pci_enable_ptm(struct pci_dev *dev)
> >  			return -EINVAL;
> >  	}
> >  
> > +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
> > +	    pci_pcie_type(dev) == PCI_EXP_TYPE_LEG_END) {
> > +		u32 cap;
> > +		/*
> > +		 * PCIe Endpoint must declare Requester Capable before we
> > +		 * can enable PTM for it.
> > +		 */
> > +		pci_read_config_dword(dev, ptm + PCI_PTM_CAP, &cap);
> > +		if (!(cap & PCI_PTM_CAP_REQ))
> > +			return -EINVAL;
> > +	}
> 
> The asymmetry of testing PCI_PTM_CAP_ROOT back in pci_ptm_init() (via
> dev->ptm_root) but testing PCI_PTM_CAP_REQ here feels a little
> confusing to me.
> 
> Also, we already read PCI_PTM_CAP in pci_ptm_init(), and we did cache
> ptm_root.  Maybe we should also cache ptm_responder and ptm_requester
> and test all of them here in __pci_enable_ptm() and drop the tests in
> pci_ptm_init()?

Sure I can do it that way too.

> >  	pci_read_config_dword(dev, ptm + PCI_PTM_CTRL, &ctrl);
> >  
> >  	ctrl |= PCI_PTM_CTRL_ENABLE;
> > -- 
> > 2.50.1
> > 

