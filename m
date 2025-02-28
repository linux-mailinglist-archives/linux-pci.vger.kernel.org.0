Return-Path: <linux-pci+bounces-22629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81318A49584
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 10:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308171883444
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 09:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B5E2580DE;
	Fri, 28 Feb 2025 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9V64Wxw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B12257453
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735696; cv=none; b=LYzPotgdinWgoQxihOO04NWiraRKJ2F8m33Xk/UejJtlJBORkGZZmm9XYa95ftLRb8oiVxwmY+GH3lPZTxcGImOtRB2fLXzJgRtTexUlGlGXOjLAqTUFc/XhJMdbYxdGqRxEC4WfhlRMfHngROrrEGzj9kH4H6UlDxw8PVbQB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735696; c=relaxed/simple;
	bh=C3CXwGP4pl/Oi5exvrJFsIGEN9hT+m73R0spxjZAhVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6+PJHSSrqZtu5IJPLj73G34UsOZTTiZn2Xqs9+ZlFxkOfGl/cXlDZVh/QRN5PfMMDIRuSKQudCyR6dWf7t8/vRrUtGqrYv3hRtep+4czEgmqNCnKnNKzdSds8U9yFUvsm0rlZx1ltb97qfdSBKDatfTe+Jk0x8PeSUxmdVpy6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9V64Wxw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740735694; x=1772271694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C3CXwGP4pl/Oi5exvrJFsIGEN9hT+m73R0spxjZAhVQ=;
  b=Z9V64WxwNBZ0fQiBk2hmITHootz/VCE/TtVMuDdgpMk7LaFp1oJb1bX5
   ryEv7AzNF5ieIoS8xmzHlW6NzTNjFFevBMjX38sv6+2gZUMdTZz5APSAT
   pF5/UBYZ+tExNX8cgVezzXuNsMeEaoyunYXVbDTaDzCaygvlQkR1WUgTj
   J66ytksXHmDIznVtmu/68MF7mcAQfJNKNROLOX52UDbCFah+CGiK7y9As
   LbdKKS1E+T4HK4opgwbkVWIGA9erliPiE4UlvFrd0pSNddG8Pdf5qcgcr
   JldC6hJtJKDHSywmG3zrPhxy4WYPxPhBVYOG2gF7Ru6aZAqGPRwXhm2+L
   A==;
X-CSE-ConnectionGUID: A+9NuhcvTZipAzVEvWw3AA==
X-CSE-MsgGUID: KdjrZ5ERQm2/oj+Ul195cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41910303"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="41910303"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:41:33 -0800
X-CSE-ConnectionGUID: WTnXgPaCTI+IcSCwv3r+RA==
X-CSE-MsgGUID: LR9NkcDlS6aFQhUWBzAlsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="122233454"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 28 Feb 2025 01:41:27 -0800
Date: Fri, 28 Feb 2025 17:39:31 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <Z8GEU3be8HTCZmNY@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <Z1qx2nAHbZN72Ljf@yilunxu-OptiPlex-7050>
 <67b9252c8cac0_1c530f29484@dwillia2-xfh.jf.intel.com.notmuch>
 <Z7xRzVrR0t6ap3+y@yilunxu-OptiPlex-7050>
 <67c1001e8ae57_1a772941@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67c1001e8ae57_1a772941@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Feb 27, 2025 at 04:15:26PM -0800, Dan Williams wrote:
> Xu Yilun wrote:
> > On Fri, Feb 21, 2025 at 05:15:24PM -0800, Dan Williams wrote:
> > > Xu Yilun wrote:
> > > > > +static int pci_tsm_disconnect(struct pci_dev *pdev)
> > > > > +{
> > > > > +	struct pci_tsm *pci_tsm = pdev->tsm;
> > > > > +
> > > > > +	lockdep_assert_held(&pci_tsm_rwsem);
> > > > > +	if_not_guard(mutex_intr, &pci_tsm->lock)
> > > > > +		return -EINTR;
> > > > > +
> > > > > +	if (pci_tsm->state < PCI_TSM_CONNECT)
> > > > > +		return 0;
> > > > > +	if (pci_tsm->state < PCI_TSM_INIT)
> > > > > +		return -ENXIO;
> > > > 
> > > > Check PCI_TSM_INIT first, or this condition will never hit.
> > > > 
> > > >   if (pci_tsm->state < PCI_TSM_INIT)
> > > > 	return -ENXIO;
> > > >   if (pci_tsm->state < PCI_TSM_CONNECT)
> > > > 	return 0;
> > > > 
> > > > I suggest the same sequence for pci_tsm_connect().
> > > 
> > > Good catch, fixed.
> > > 
> > > [..]
> > > > > +
> > > > > +static void __pci_tsm_init(struct pci_dev *pdev)
> > > > > +{
> > > > > +	bool tee_cap;
> > > > > +
> > > > > +	if (!is_physical_endpoint(pdev))
> > > > > +		return;
> > > > 
> > > > This Filters out virtual functions, just because not ready for support,
> > > > is it?
> > > 
> > > Do you see a need for PCI core to notify the TSM driver about the
> > > arrival of VF devices?
> > 
> > I think yes.
> > 
> > > 
> > > My expectation is that a VF TDI communicates with the TSM driver
> > > relative to its PF.
> > 
> > It is possible, but the PF TSM still need to manage the TDI context for
> > all it's VFs, like:
> > 
> > struct pci_tdi;
> > 
> > struct pci_tsm {
> > 	...
> > 	struct pci_dsm *dsm;
> > 	struct xarray tdi_xa; // struct pci_tdi array
> > };
> > 
> > 
> > An alternative is we allow VFs has their own pci_tsm, and store their
> > own tdi contexts in it.
> > 
> > struct pci_tsm {
> > 	...
> > 	struct pci_dsm *dsm; // point to PF's dsm.
> > 	struct pci_tdi *tdi;
> > };
> > 
> > I perfer the later cause we don't have to seach for TDI context
> > everytime we have a pdev for VF and do tsm operations on it.
> 
> I do think it makes sense to have one ->tsm pointer from a PCI device to
> represent any possible TSM context, but I do not think it makes sense
> for that context to always contain members that are only relevant to PF
> Function 0.
> So, here is an updated proposal:
> 
> /**
>  * struct pci_tsm - Core TSM context for a given PCIe endpoint
>  * @pdev: indicates the type of pci_tsm object
>  *
>  * This structure is wrapped by a low level TSM driver and returned by
>  * tsm_ops.probe(), it is freed by tsm_ops.remove(). Depending on
>  * whether @pdev is physical function 0, another physical function, or a
>  * virtual function determines the pci_tsm object type. E.g. see 'struct
>  * pci_tsm_pf0'.
>  */
> struct pci_tsm {
>         struct pci_dev *pdev;
> };
> 
> /**
>  * struct pci_tsm_pf0 - Physical Function 0 TDISP context
>  * @state: reflect device initialized, connected, or bound
>  * @lock: protect @state vs pci_tsm_ops invocation
>  * @doe_mb: PCIe Data Object Exchange mailbox
>  */
> struct pci_tsm_pf0 {
>         enum pci_tsm_state state;
>         struct mutex lock;

I think the scope of the lock should expand to pci_tsm_ops::bind(), we
need to ensure the TDI bind won't race with its PF0's (dis)connect.

  struct pci_tsm {
	struct pci_dev *pdev;
	struct pci_tdi *tdi;
  };

  struct pci_tdi {
	struct pci_tsm_pf0 *tsm_pf0;
	...
  };

  int pci_tdi_lock(struct pci_tdi *tdi)
  {
	mutex_lock(&tdi->tsm_pf0->lock);
  }

Thanks,
Yilun

>         struct pci_doe_mb *doe_mb;
>         struct pci_tsm tsm;
> };
> 
> This arrangement lets the core 'struct pci_tsm' object hold
> common-to-all device-type details like a 'struct pci_tdi' pointer. For
> physical function0 devices the core does:
> 
>    container_of(pdev->tsm, struct pci_tsm_pf0, tsm)
> 
> ...to get to those exclusive details.
> 
> > > > > +
> > > > > +	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
> > > > > +
> > > > > +	if (!(pdev->ide_cap || tee_cap))
> > > > > +		return;
> > > > > +
> > > > > +	lockdep_assert_held_write(&pci_tsm_rwsem);
> > > > > +	if (!tsm_ops)
> > > > > +		return;
> > > > > +
> > > > > +	struct pci_tsm *pci_tsm __free(kfree) = kzalloc(sizeof(*pci_tsm), GFP_KERNEL);
> > > > > +	if (!pci_tsm)
> > > > > +		return;
> > > > > +
> > > > > +	/*
> > > > > +	 * If a physical device has any security capabilities it may be
> > > > > +	 * a candidate to connect with the platform TSM
> > > > > +	 */
> > > > > +	struct pci_dsm *dsm __free(dsm_remove) = tsm_ops->probe(pdev);
> > > > 
> > > > IIUC, pdev->tsm should be for every pci function (physical or virtual),
> > > > pdev->tsm->dsm should be only for physical functions, is it?
> > > 
> > > Per above I was only expecting physical function, but the bind flow
> > > might introduce the need for per function (phyiscal or virtual) TDI
> > > context. I expect that is separate from the PF pdev->tsm context.
> > 
> > Could we embed TDI context in PF's pdev->tsm AND VF's pdev->tsm? From
> > TDISP spec, TSM covers TDI management so I think it is proper
> > struct pci_tsm contains TDI context.
> 
> Yes, makes sense. I will work on moving the physical function0 data
> out-of-line from the core 'struct pci_tsm' definition.
> 
> So, 'struct pci_tdi' is common to 'struct pci_tsm' since any PCI
> function can become a TDI. If VFs or non-function0 functions need
> addtional context we could create a 'struct pci_tsm_vf' or similar for
> that data.

