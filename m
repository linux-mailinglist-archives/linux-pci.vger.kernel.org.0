Return-Path: <linux-pci+bounces-27891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93385ABA28B
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 20:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CEB1890632
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 18:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FF62459FD;
	Fri, 16 May 2025 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIrDozf/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057CB2AEED;
	Fri, 16 May 2025 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419050; cv=none; b=GFMfGIYUAxuSV1+b8Mq2eYLep+KK3IU3EMkG1MbuwH/DmzqJXgVBDgAhR+jc2UQwoSuRTT4vnDdBnyqszmtEROqFGxkm45PFw7hdxAlzjXYd8PcTeNAVQFLE2Qz2pNeDhAxejrJ0sq+zRTL4mln2H/1APrboiaBroSW1VDWms2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419050; c=relaxed/simple;
	bh=wDKdX71pZ8RSkAEOfqZqETFChZbI516QjeBcBUpi1XQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rq6cZE93UAYqqPlKn0DGiOUO0XKy5QBZAlBSfwGjKaOl2dgfAQ82gCrPkiPCaTgZiII7IwbS72a3QDhQE/jMcGQsXVYt6k/kNF07+Bt76p8L4d3ukxMOmPtZznqfhRsYX/78y7CcKhgax5hrfpQ0RHyYXXs4zcJUqCYj5mpeuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIrDozf/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747419048; x=1778955048;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wDKdX71pZ8RSkAEOfqZqETFChZbI516QjeBcBUpi1XQ=;
  b=nIrDozf/Nr84Y/h9f0wWqoqRZUKNai1FbIghNn0hDqdF9EYVueed2GKd
   sTP00bWdfBt5NQxsfVYSi1vf1yspFkJ0WzwN88JYDDFC7dOpy8nbDKARr
   Qk3IVb7dBIuhXLiFk7A63UImvGDE3LZpEgQjdbT3Q5///YjaTnvJyaXfP
   HK/tqogKs3sT7Sf/WH5bab5Si6BQb7ShA4rKoyZ1e43vw5Mx2VFltHb3n
   aobo+iKC4GwG2Y7XU1mSa1N+x/ZxgmtPxN34xSvTFdSO3bukk2RkPUHNw
   56SvsrUSmN0LXH/kdkYxsWT7CViC6HkmyoaSbqYUJhI8Rz/1cnc6HJO4L
   w==;
X-CSE-ConnectionGUID: 0ag31V1kSYeDO4wJaqy+iA==
X-CSE-MsgGUID: Nih4q8YFTgmDeKoyfeTO9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49540258"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49540258"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:10:47 -0700
X-CSE-ConnectionGUID: 4tM8a3nFSWazvToF6VMjTA==
X-CSE-MsgGUID: FtR3MuS2RRCOpAPatdZMEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="139289169"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.124.220.15]) ([10.124.220.15])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:10:47 -0700
Message-ID: <a1fdd6e1-8cd9-46b0-bd27-526729a1199d@linux.intel.com>
Date: Fri, 16 May 2025 11:10:45 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] pci: implement "pci=aer_panic"
To: Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
 tglx@linutronix.de, kw@linux.com, manivannan.sadhasivam@linaro.org,
 mahesh@linux.ibm.com
Cc: oohall@gmail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20250516165518.125495-1-18255117159@163.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250516165518.125495-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/16/25 9:55 AM, Hans Zhang wrote:
> The following series introduces a new kernel command-line option aer_panic
> to enhance error handling for PCIe Advanced Error Reporting (AER) in
> mission-critical environments. This feature ensures deterministic recover
> from fatal PCIe errors by triggering a controlled kernel panic when device
> recovery fails, avoiding indefinite system hangs.

Why would a device recovery failure lead to a system hang? Worst case
that device may not be accessible, right?  Any real use case?

>
> Problem Statement
> In systems where unresolved PCIe errors (e.g., bus hangs) occur,
> traditional error recovery mechanisms may leave the system unresponsive
> indefinitely. This is unacceptable for high-availability environment
> requiring prompt recovery via reboot.
>
> Solution
> The aer_panic option forces a kernel panic on unrecoverable AER errors.
> This bypasses prolonged recovery attempts and ensures immediate reboot.
>
> Patch Summary:
> Documentation Update: Adds aer_panic to kernel-parameters.txt, explaining
> its purpose and usage.
>
> Command-Line Handling: Implements pci=aer_panic parsing and state
> management in PCI core.
>
> State Exposure: Introduces pci_aer_panic_enabled() to check if the panic
> mode is active.
>
> Panic Trigger: Modifies recovery logic to panic the system when recovery
> fails and aer_panic is enabled.
>
> Impact
> Controlled Recovery: Reduces downtime by replacing hangs with immediate
> reboots.
>
> Optional: Enabled via pci=aer_panic; no default behavior change.
>
> Dependency: Requires CONFIG_PCIEAER.
>
> For example, in mobile phones and tablets, when there is a problem with
> the PCIe link and it cannot be restored, it is expected to provide an
> alternative method to make the system panic without waiting for the
> battery power to be completely exhausted before restarting the system.
>
> ---
> For example, the sm8250 and sm8350 of qcom will panic and restart the
> system when they are linked down.
>
> https://github.com/DOITfit/xiaomi_kernel_sm8250/blob/d42aa408e8cef14f4ec006554fac67ef80b86d0d/drivers/pci/controller/pci-msm.c#L5440
>
> https://github.com/OnePlusOSS/android_kernel_oneplus_sm8350/blob/13ca08fdf0979fdd61d5e8991661874bb2d19150/drivers/net/wireless/cnss2/pci.c#L950
>
>
> Since the design schemes of each SOC manufacturer are different, the AXI
> and other buses connected by PCIe do not have a design to prevent hanging.
> Once a FATAL error occurs in the PCIe link and cannot be restored, the
> system needs to be restarted.
>
>
> Dear Mani,
>
> I wonder if you know how other SoCs of qcom handle FATAL errors that occur
> in PCIe link.
> ---
>
> Hans Zhang (4):
>    pci: implement "pci=aer_panic"
>    PCI/AER: Introduce aer_panic kernel command-line option
>    PCI/AER: Expose AER panic state via pci_aer_panic_enabled()
>    PCI/AER: Trigger kernel panic on recovery failure if aer_panic is set
>
>   .../admin-guide/kernel-parameters.txt          |  7 +++++++
>   drivers/pci/pci.c                              |  2 ++
>   drivers/pci/pci.h                              |  4 ++++
>   drivers/pci/pcie/aer.c                         | 18 ++++++++++++++++++
>   drivers/pci/pcie/err.c                         |  8 ++++++--
>   5 files changed, 37 insertions(+), 2 deletions(-)
>
>
> base-commit: fee3e843b309444f48157e2188efa6818bae85cf
> prerequisite-patch-id: 299f33d3618e246cd7c04de10e591ace2d0116e6
> prerequisite-patch-id: 482ad0609459a7654a4100cdc9f9aa4b671be50b

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


