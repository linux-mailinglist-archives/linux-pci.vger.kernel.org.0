Return-Path: <linux-pci+bounces-22188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15162A41C13
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 12:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4E3188722E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 11:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983D5255E57;
	Mon, 24 Feb 2025 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CL4ZQn1R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062FC2566EF
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395065; cv=none; b=GteKGYVhAtQQ0Zmjel53NBX8pUuI6IKiGkRixdamCAlTM8gjyxzjTYpITqLMpTyj64nsU+yTG7Wct8npLF8PfVQ7eojXKxMQ8bFk1dpxLct+220jENYYmn88vCy4atSzw/abymbalKR5/EEDRnyT3KzqbDo9tBpwcgPc7pEN0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395065; c=relaxed/simple;
	bh=XnrWYFKLdcBwHlb3JP9w96Sdf1jponZtSCVf/ck+LnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGRdGEaTm68YD40W/30ZHcTuRFAEGxPS8JNHJk3fydyhuVCffYj8aKtAcp0HYBXE9ncU+uayclvGRhoneXhL/z/MRJc058W6PvossVBb4xC5NOi6svzTFtemu9YQF6EzthayjL7DEZlrUxP8tyT9hLSh5dvjNPtFdKpYcG2Hauc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CL4ZQn1R; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740395064; x=1771931064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XnrWYFKLdcBwHlb3JP9w96Sdf1jponZtSCVf/ck+LnA=;
  b=CL4ZQn1RUU3j4aKZiVaG+ZfGHNiW0GhEIYvoOZ5hgLO3clL0WaNzZXDg
   dZ3Wk2CHf0C2tMA6/XxJmcC2G3rjqiYsXJKlnJANSL2MDMQRglzngf3Z3
   XaYCFp9dpqaSxYvSvCiHlWcVRgPnl4UF7ndNIvL6rRts65mGRWzOsT3iX
   8W8TC0lb+8+Hstwc+8VikNpKrgNEOZOfuiY2vLW81NLCHPT9mVhYiLpGo
   v6wSB2JIOTPdDuT1sQNDcLlRzU2xilnq6R5ONAi1EXQG26cUFsf6ukkNV
   ttHyTGbqSqo352e++WYkzllBhGgMBKqhxT9PVs9ob0ZqNevpYkzDH2vT7
   w==;
X-CSE-ConnectionGUID: 6gKwkz1LTFSmisOfvuaPjQ==
X-CSE-MsgGUID: MK2TTWMZSBq4Z3mH/xKbKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="41282921"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41282921"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 03:04:23 -0800
X-CSE-ConnectionGUID: X/Du1pqRS4SICKnvC7mIMg==
X-CSE-MsgGUID: ZWBarRrkQg+Ge2QpJoLDLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120152385"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 24 Feb 2025 03:04:22 -0800
Date: Mon, 24 Feb 2025 19:02:37 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <Z7xRzVrR0t6ap3+y@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <Z1qx2nAHbZN72Ljf@yilunxu-OptiPlex-7050>
 <67b9252c8cac0_1c530f29484@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b9252c8cac0_1c530f29484@dwillia2-xfh.jf.intel.com.notmuch>

On Fri, Feb 21, 2025 at 05:15:24PM -0800, Dan Williams wrote:
> Xu Yilun wrote:
> > > +static int pci_tsm_disconnect(struct pci_dev *pdev)
> > > +{
> > > +	struct pci_tsm *pci_tsm = pdev->tsm;
> > > +
> > > +	lockdep_assert_held(&pci_tsm_rwsem);
> > > +	if_not_guard(mutex_intr, &pci_tsm->lock)
> > > +		return -EINTR;
> > > +
> > > +	if (pci_tsm->state < PCI_TSM_CONNECT)
> > > +		return 0;
> > > +	if (pci_tsm->state < PCI_TSM_INIT)
> > > +		return -ENXIO;
> > 
> > Check PCI_TSM_INIT first, or this condition will never hit.
> > 
> >   if (pci_tsm->state < PCI_TSM_INIT)
> > 	return -ENXIO;
> >   if (pci_tsm->state < PCI_TSM_CONNECT)
> > 	return 0;
> > 
> > I suggest the same sequence for pci_tsm_connect().
> 
> Good catch, fixed.
> 
> [..]
> > > +
> > > +static void __pci_tsm_init(struct pci_dev *pdev)
> > > +{
> > > +	bool tee_cap;
> > > +
> > > +	if (!is_physical_endpoint(pdev))
> > > +		return;
> > 
> > This Filters out virtual functions, just because not ready for support,
> > is it?
> 
> Do you see a need for PCI core to notify the TSM driver about the
> arrival of VF devices?

I think yes.

> 
> My expectation is that a VF TDI communicates with the TSM driver
> relative to its PF.

It is possible, but the PF TSM still need to manage the TDI context for
all it's VFs, like:

struct pci_tdi;

struct pci_tsm {
	...
	struct pci_dsm *dsm;
	struct xarray tdi_xa; // struct pci_tdi array
};


An alternative is we allow VFs has their own pci_tsm, and store their
own tdi contexts in it.

struct pci_tsm {
	...
	struct pci_dsm *dsm; // point to PF's dsm.
	struct pci_tdi *tdi;
};

I perfer the later cause we don't have to seach for TDI context
everytime we have a pdev for VF and do tsm operations on it.

> 
> > > +
> > > +	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
> > > +
> > > +	if (!(pdev->ide_cap || tee_cap))
> > > +		return;
> > > +
> > > +	lockdep_assert_held_write(&pci_tsm_rwsem);
> > > +	if (!tsm_ops)
> > > +		return;
> > > +
> > > +	struct pci_tsm *pci_tsm __free(kfree) = kzalloc(sizeof(*pci_tsm), GFP_KERNEL);
> > > +	if (!pci_tsm)
> > > +		return;
> > > +
> > > +	/*
> > > +	 * If a physical device has any security capabilities it may be
> > > +	 * a candidate to connect with the platform TSM
> > > +	 */
> > > +	struct pci_dsm *dsm __free(dsm_remove) = tsm_ops->probe(pdev);
> > 
> > IIUC, pdev->tsm should be for every pci function (physical or virtual),
> > pdev->tsm->dsm should be only for physical functions, is it?
> 
> Per above I was only expecting physical function, but the bind flow
> might introduce the need for per function (phyiscal or virtual) TDI
> context. I expect that is separate from the PF pdev->tsm context.

Could we embed TDI context in PF's pdev->tsm AND VF's pdev->tsm? From
TDISP spec, TSM covers TDI management so I think it is proper
struct pci_tsm contains TDI context.

Thanks,
Yilun

