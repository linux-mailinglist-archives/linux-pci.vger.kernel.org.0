Return-Path: <linux-pci+bounces-33997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5249B25724
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218031885433
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDCA27A928;
	Wed, 13 Aug 2025 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vf8De1r8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F7301478
	for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 23:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755126078; cv=none; b=XR60TZlGXW9S9wX8jdlIJ5BMcZsoYxFLyPyvsNM8Mv6kBcBL55toGdEkIEVQLJyMJPFj3wnb6lWiRxeo3hUb+V7rtcBaEFXl/6gXbh/U5ivo2h/XCYCzZTSad2bX08udytvew19EhixjfLCbLNasasNCG8CMtbDDP/MoTcyx9fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755126078; c=relaxed/simple;
	bh=T/oGmnpZYLbQ/X1losF5l3hVhIs+ynk8KckKBGcM9UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOYa4Y9b8VE4FaDLAyFEf7Cl3sC+06fWQmSKVWyHSmOj//e8Gs7/n7u8U5bdTl4K0+xBnrHYI954B0+OuOTFk/F+wtuBFoLeq6heOAtgklLvb8WLkGxjLJW0/XMF+ZP0Pv3vWUK17A6k3+ktLvVCHphn3oxPU3QOIexMl+XI04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vf8De1r8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755126076; x=1786662076;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T/oGmnpZYLbQ/X1losF5l3hVhIs+ynk8KckKBGcM9UM=;
  b=Vf8De1r8EA3imX1RT73eoJu+577xF6gd/S1MFS7YWHcXAKzUA//7slUS
   fxijlSY2e0ClchfwsVEVZPl5Xk5+obBZZdU4IlThbwSh88hKiE2elLhqX
   xNOS9jCT3WlAS1nAm0Pq6gdRJIga/jr2ocYyL/gT/zv1nsMBFuU5c9gND
   nc3Pfi9MNzrA8cUiA1ilABFolTsZdaoWpAIRAts2gkQoLnmJBvwQY5+cK
   0V+hL60OJmFdv8JlgjgzzheeFpV6bmmDx2KXH2l+GvVfb8MGkIGTKGKwJ
   lWAh6pBaJX8Jcvm4uFv+bBDiVrA0aAgsctoJ/YkZ6cnzPZurjWXB5SX9s
   A==;
X-CSE-ConnectionGUID: m1X6GOVFSBWRMV0ipLIYOw==
X-CSE-MsgGUID: DV2oUlWUQZKl981DxozAeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57514943"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57514943"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 16:01:15 -0700
X-CSE-ConnectionGUID: S+HCdQf+RVeegPNw4j471A==
X-CSE-MsgGUID: 1k0azmVhQRmHyHIkBrj//g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="165823247"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 16:01:15 -0700
Received: from [10.124.222.231] (unknown [10.124.222.231])
	by linux.intel.com (Postfix) with ESMTP id B8DD920B571C;
	Wed, 13 Aug 2025 16:01:14 -0700 (PDT)
Message-ID: <cd952c82-9f8b-4396-9170-b34d539a8fac@linux.intel.com>
Date: Wed, 13 Aug 2025 16:01:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] PCI/AER: Allow drivers to opt in to Bus Reset on
 Non-Fatal Errors
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>,
 Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
 "Sean C. Dardis" <sean.c.dardis@intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Linas Vepstas <linasvepstas@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
References: <cover.1755008151.git.lukas@wunner.de>
 <28fd805043bb57af390168d05abb30898cf4fc58.1755008151.git.lukas@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <28fd805043bb57af390168d05abb30898cf4fc58.1755008151.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/12/25 10:11 PM, Lukas Wunner wrote:
> When Advanced Error Reporting was introduced in September 2006 by commit
> 6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriver"), it
> sought to adhere to the recovery flow and callbacks specified in
> Documentation/PCI/pci-error-recovery.rst.
>
> That document had been added in January 2006, when Enhanced Error Handling
> (EEH) was introduced for PowerPC with commit 065c6359071c ("[PATCH] PCI
> Error Recovery: documentation").
>
> However the AER driver deviates from the document in that it never
> performs a Secondary Bus Reset on Non-Fatal Errors, but always on Fatal
> Errors.  By contrast, EEH allows drivers to opt in or out of a Bus Reset
> regardless of error severity, by returning PCI_ERS_RESULT_NEED_RESET or
> PCI_ERS_RESULT_CAN_RECOVER from their ->error_detected() callback.  If all
> drivers agree that they can recover without a Bus Reset, EEH skips it.
> Should one of them request a Bus Reset, it overrides all other drivers.
>
> This inconsistency between EEH and AER seems problematic because drivers
> need to be aware of and cope with it.
>
> The file Documentation/PCI/pcieaer-howto.rst hints at a rationale for
> always performing a Bus Reset on Fatal Errors:  "Fatal errors [...] cause
> the link to be unreliable.  [...] This [reset_link] callback is used to
> reset the PCIe physical link when a fatal error happens.  If an error
> message indicates a fatal error, [...] performing link reset at upstream
> is necessary."

In the code we don't seem to differentiate link_reset and slot_reset. But
the Documentation calls them into two steps. Do you think we should
fix the Documentation?

> There's no such rationale provided for never performing a Bus Reset on
> Non-Fatal Errors.
>
> The "xe" driver has a need to attempt a reset of local units on graphics
> cards upon a Non-Fatal Error.  If that is insufficient for recovery, the
> driver wants to opt in to a Bus Reset.
>
> Accommodate such use cases and align AER more closely with EEH by
> performing a Bus Reset in pcie_do_recovery() if drivers request it and the
> faulting device's channel_state is pci_channel_io_normal.  The AER driver
> sets this channel_state for Non-Fatal Errors.  For Fatal Errors, it uses
> pci_channel_io_frozen.
>
> This limits the deviation from Documentation/PCI/pci-error-recovery.rst
> and EEH to the unconditional Bus Reset on Fatal Errors.
>
> pcie_do_recovery() is also invoked by the Downstream Port Containment and
> Error Disconnect Recover drivers.  They both set the channel_state to
> pci_channel_io_frozen, hence pcie_do_recovery() continues to always invoke
> the ->reset_subordinates() callback in their case.  That is necessary
> because the callback brings the link back up at the containing Downstream
> Port.
>
> There are two behavioral changes resulting from this commit:
>
> First, if channel_state is pci_channel_io_normal and one of the affected
> drivers returns PCI_ERS_RESULT_NEED_RESET from its ->error_detected()
> callback, a Bus Reset will now be performed.  There are drivers doing this
> and although it would be possible to avoid a behavioral change by letting
> them return PCI_ERS_RESULT_CAN_RECOVER instead, the impression I got from
> examination of all drivers is that they actually expect or want a Bus
> Reset (cxl_error_detected() is a case in point).  In any case, if they can
> cope with a Bus Reset on Fatal Errors, they shouldn't have issues with a
> Bus Reset on Non-Fatal Errors.
>
> Second, if channel_state is pci_channel_io_frozen and all affected drivers
> return PCI_ERS_RESULT_CAN_RECOVER from ->error_detected(), their
> ->mmio_enabled() callback is now invoked prior to performing a Bus Reset,
> instead of afterwards.  This actually makes sense:  For example,
> drivers/scsi/sym53c8xx_2/sym_glue.c dumps debug registers in its
> ->mmio_enabled() callback.  Doing so after reset right now captures the
> post-reset state instead of the faulting state, which is useless.
>
> There is only one other driver which implements ->mmio_enabled() and
> returns PCI_ERS_RESULT_CAN_RECOVER from ->error_detected() for
> channel_state pci_channel_io_frozen, drivers/scsi/ipr.c (IBM Power RAID).
> It appears to only be used on EEH platforms.  So the second behavioral
> change is limited to these two drivers.
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>   drivers/pci/pcie/err.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index de6381c690f5..e795e5ae6b03 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -217,15 +217,10 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
>   
>   	pci_dbg(bridge, "broadcast error_detected message\n");
> -	if (state == pci_channel_io_frozen) {
> +	if (state == pci_channel_io_frozen)
>   		pci_walk_bridge(bridge, report_frozen_detected, &status);
> -		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
> -			pci_warn(bridge, "subordinate device reset failed\n");
> -			goto failed;
> -		}
> -	} else {
> +	else
>   		pci_walk_bridge(bridge, report_normal_detected, &status);
> -	}
>   
>   	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>   		status = PCI_ERS_RESULT_RECOVERED;
> @@ -233,6 +228,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   		pci_walk_bridge(bridge, report_mmio_enabled, &status);
>   	}
>   
> +	if (status == PCI_ERS_RESULT_NEED_RESET ||
> +	    state == pci_channel_io_frozen) {

Why not let report_frozen_detected() update status to
PCI_ERS_RESULT_NEED_RESET?

For fatal errors, I believe most driver callbacks already return
PCI_ERS_RESULT_NEED_RESET by default. Even if that’s not always the case,
since a reset is required anyway, it might make more sense to update the
status there.If you do it, you can skip the above check.
> +		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
> +			pci_warn(bridge, "subordinate device reset failed\n");
> +			goto failed;
> +		}
> +	}

For pci_channel_io_frozen,
> +
>   	if (status == PCI_ERS_RESULT_NEED_RESET) {
>   		/*
>   		 * TODO: Should call platform-specific

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


