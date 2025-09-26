Return-Path: <linux-pci+bounces-37141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD534BA532E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 23:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED12381FE5
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 21:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75662A1CA;
	Fri, 26 Sep 2025 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoLzZOtT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48B1D9324;
	Fri, 26 Sep 2025 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921966; cv=none; b=CEC0GCNcKtcm/7N9QSawikyAf6hC4a6zH0oefebXRfNzNimPhABSxH5haKioshJX2NAFyTR3IzQalxd1xgruS0tgQnHhdspjywUt85TjkPLirl+WSXez14F4n/6u8abaAc+LJfrNB6FkvEqZlHWinZXBeY/K6P/sprUitkEJZ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921966; c=relaxed/simple;
	bh=qLf+NYdvcCf3oU4Vb7zAhtUhczGd0GCFHpCg1pVFT0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3obPoBO6NWUr1m6P0TV8EY+un5qIRbHMp/no8UNldNeESZ+WijBq30fQ9TJs3yaXAn6RCi2DdiTOzeE5QuiCYPOgcElZwuk3a51NULfQLlkykw7y8aEBWdqY938SMwnqfeVpsFc72MdStBBlva51+FM5i+sN/HMHqV/wNyKUrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoLzZOtT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758921965; x=1790457965;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qLf+NYdvcCf3oU4Vb7zAhtUhczGd0GCFHpCg1pVFT0Q=;
  b=hoLzZOtTE/0Awfia1pxV3OubzmpIoJNeQ19Ync6EBoU5W9+l2JXDjlMr
   I7TzLFQQdc7LuXjpWLtb66kG4sSZol0V2FYw3dzSxQHTXssomrGoV4Ull
   B6C+fe8/w+1M9LwRpAQOxvwKQmLz4cLimHjfFa43RsdflrHJ732JmvvOI
   X2XHFlCBhuQuzxfBvQNMIuYbXCumE8PPg5ACdf4qZuhheHOm/K6JMMNtb
   +/Xm7ajZGxNSRlsr93CMAvhTnM8RCU2+DmArKajxWijajVnSfgpR5933v
   DzEzFs3nxxYUB8SIPgZAZC72+SZQ4o0+xgn0ZXfHu1A0KXrg7mI5jiixN
   Q==;
X-CSE-ConnectionGUID: vaJwsi6fQDWpwOwDS4t7ow==
X-CSE-MsgGUID: x0euilLDQq6fGVAYgACsoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="61428254"
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="61428254"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 14:26:03 -0700
X-CSE-ConnectionGUID: z/NfbGmATNupqUifnChzmg==
X-CSE-MsgGUID: R84/w1B4S9efXt5xnirSXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="177765649"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.69]) ([10.125.109.69])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 14:26:02 -0700
Message-ID: <ba93061a-09dd-4132-bde0-6af319a56405@intel.com>
Date: Fri, 26 Sep 2025 14:26:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 16/25] CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-17-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250925223440.3539069-17-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 3:34 PM, Terry Bowman wrote:
> The CXL driver's error handling for uncorrectable errors (UCE) will be
> updated in the future. A required change is for the error handlers to
> to force a system panic when a UCE is detected.
> 
> Introduce PCI_ERS_RESULT_PANIC as a 'enum pci_ers_result' type. This will
> be used by CXL UCE fatal and non-fatal recovery in future patches. Update
> PCIe recovery documentation with details of PCI_ERS_RESULT_PANIC.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Changes v11 -> v12:
> - Documentation requested by (Lukas)
> ---
>  Documentation/PCI/pci-error-recovery.rst | 6 ++++++
>  include/linux/pci.h                      | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
> index 42e1e78353f3..f823a6c1fb23 100644
> --- a/Documentation/PCI/pci-error-recovery.rst
> +++ b/Documentation/PCI/pci-error-recovery.rst
> @@ -102,6 +102,8 @@ Possible return values are::
>  		PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
>  		PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
>  		PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
> +		PCI_ERS_RESULT_NO_AER_DRIVER, /* No AER capabilities registered for the driver */
> +		PCI_ERS_RESULT_PANIC,       /* System is unstable, panic. Is CXL specific */
>  	};
>  
>  A driver does not have to implement all of these callbacks; however,
> @@ -116,6 +118,10 @@ The actual steps taken by a platform to recover from a PCI error
>  event will be platform-dependent, but will follow the general
>  sequence described below.
>  
> +PCI_ERS_RESULT_PANIC is currently unique to CXL and handled in CXL
> +cxl_do_recdovery(). The PCI pcie_do_recovery() routine does not report or
> +handle PCI_ERS_RESULT_PANIC.
> +
>  STEP 0: Error Event
>  -------------------
>  A PCI bus error is detected by the PCI hardware.  On powerpc, the slot
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 53a45e92c635..bc3a7b6d0f94 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -889,6 +889,9 @@ enum pci_ers_result {
>  
>  	/* No AER capabilities registered for the driver */
>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
> +
> +	/* System is unstable, panic. Is CXL specific */
> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>  };
>  
>  /* PCI bus error event callbacks */


