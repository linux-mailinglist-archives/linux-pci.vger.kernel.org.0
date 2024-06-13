Return-Path: <linux-pci+bounces-8744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF00907809
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 18:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2741C239F3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 16:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92593130A66;
	Thu, 13 Jun 2024 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYumNiry"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E107412EBC2;
	Thu, 13 Jun 2024 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295345; cv=none; b=Pd0pRY51JGd7w/elX8TELS3J0qt2WurR76KwM40Zt5Vlbvo6LnK5Y7nnO4z89TK0ZknlYCOMfT4KXnUaNT3ICy6QhbQAnpc2U3s4k8eHSWiYMvjmN+bSF0HpO1+OWYMZoy8HdppdsybjkSeNvd6oYyaMHrKkDJpBrVwh4nrZa8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295345; c=relaxed/simple;
	bh=Ir6aMlMU76URUanDBPqAAtxolLoQvV6liNw0P13aboM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IngAD4xabyE1taWjHOTDNavmRublXPGdvhvy1asbX55lJgPG2SMTzJxRjqQaEuK5nFfK51qrUZLAE74zPwamKqwZCPh5O0ngj4cPwxIHcirhR4TmXHsyepZ6qLI7lWS7H1eKew6ghsPsINjwdZzwzyxtb5iuKQ1hApc+ciNEn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYumNiry; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718295344; x=1749831344;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ir6aMlMU76URUanDBPqAAtxolLoQvV6liNw0P13aboM=;
  b=jYumNiryu6jJTEX7heYPQlHnYhz6/ixru7vyDGAEdrjwpl4wrCTp+yBr
   lcafF2th3gR1jlP8Aert7eE4PbEr5lR0BkC8CnvEBJ9z0uQC4hHK2w6b0
   yGyYs1EJfTT2Ei+D1639NRrAhAxf75k6N5vQYGN3ihh1N2txzKQeBnbCq
   k5dLWiGSCcXW7E5xBnH4ar3YYpTeKMEOeB3gg4ojXMdCFl6lcT7oisAXg
   6zxCVi7rMOXQM/4oopg1bFmq4Wg9V8obz99S21YtJHqk3RBgYdC5ucdBB
   3Z+QbvdF3CUxqtodwxa6+U2pyXstAq6Uf4zD0nYLyFnbHJ59JXOIYnHd8
   g==;
X-CSE-ConnectionGUID: Qkj3zOA6Tee2MFLs+fYjPg==
X-CSE-MsgGUID: YRaazzxUSCuZCBJ+/8ykPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25808660"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="25808660"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 09:15:30 -0700
X-CSE-ConnectionGUID: iK6CXFrGTjuYXDdqOyQiGQ==
X-CSE-MsgGUID: X8YqcHs1T6awowXC7DxeaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="40083225"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.209])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 09:15:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Jun 2024 19:15:23 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Uros Bizjak <ubizjak@gmail.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
    Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: hotplug: Use atomic_{fetch_}andnot() where
 appropriate
In-Reply-To: <20240613155134.GA1062951@bhelgaas>
Message-ID: <aa9d3320-d31a-1577-cf55-9473864bd04c@linux.intel.com>
References: <20240613155134.GA1062951@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 13 Jun 2024, Bjorn Helgaas wrote:

> [+cc Lukas, Ilpo]
> 
> On Thu, Jun 13, 2024 at 10:24:24AM +0200, Uros Bizjak wrote:
> > Use atomic_{fetch_}andnot(i, v) instead of atomic_{fetch_}and(~i, v).
> 
> If the purpose is to improve readability, let's mention that here.
> Since this only touches pciehp, make the subject line "PCI: pciehp:
> ..." as was done in the past.
> 
> It looks like every use of atomic_and() uses a ~value and is hence a
> candidate for a similar change, but I'm not sure that converting to
> "andnot" and removing the explicit bitwise NOT is really a readability
> benefit.
> 
> If it were named something like "atomic_clear_bits", I'd be totally in
> favor since that's a little higher-level description, but that ship
> has long since sailed.
> 
> But I don't really care and if this is the trend, I'm fine with this
> if Lukas and Ilpo agree.

I'm pretty much aligned with Bjorn, I don't find it clearer but I don't 
feel too strongly now that I've seen how to interpret this. As he pointed 
out, there would have been much better names for this operation ("andnot"
feels similar to using double negations which easily gets confusing unless
one maps it inside head into positive logic).

-- 
 i.

> > No functional changes intended.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > ---
> >  drivers/pci/hotplug/pciehp_ctrl.c | 4 ++--
> >  drivers/pci/hotplug/pciehp_hpc.c  | 8 ++++----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> > index dcdbfcf404dd..7c775d9a6599 100644
> > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> > @@ -121,8 +121,8 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
> >  		msleep(1000);
> >  
> >  		/* Ignore link or presence changes caused by power off */
> > -		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
> > -			   &ctrl->pending_events);
> > +		atomic_andnot(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC,
> > +			      &ctrl->pending_events);
> >  	}
> >  
> >  	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
> > diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> > index b1d0a1b3917d..6d192f64ea19 100644
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -307,8 +307,8 @@ int pciehp_check_link_status(struct controller *ctrl)
> >  
> >  	/* ignore link or presence changes up to this point */
> >  	if (found)
> > -		atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
> > -			   &ctrl->pending_events);
> > +		atomic_andnot(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC,
> > +			      &ctrl->pending_events);
> >  
> >  	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> >  	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
> > @@ -568,7 +568,7 @@ static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
> >  	 * Could be several if DPC triggered multiple times consecutively.
> >  	 */
> >  	synchronize_hardirq(irq);
> > -	atomic_and(~PCI_EXP_SLTSTA_DLLSC, &ctrl->pending_events);
> > +	atomic_andnot(PCI_EXP_SLTSTA_DLLSC, &ctrl->pending_events);
> >  	if (pciehp_poll_mode)
> >  		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
> >  					   PCI_EXP_SLTSTA_DLLSC);
> > @@ -702,7 +702,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
> >  	pci_config_pm_runtime_get(pdev);
> >  
> >  	/* rerun pciehp_isr() if the port was inaccessible on interrupt */
> > -	if (atomic_fetch_and(~RERUN_ISR, &ctrl->pending_events) & RERUN_ISR) {
> > +	if (atomic_fetch_andnot(RERUN_ISR, &ctrl->pending_events) & RERUN_ISR) {
> >  		ret = pciehp_isr(irq, dev_id);
> >  		enable_irq(irq);
> >  		if (ret != IRQ_WAKE_THREAD)
> > -- 
> > 2.45.2
> > 
> 

