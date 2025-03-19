Return-Path: <linux-pci+bounces-24187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFA9A69C12
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 23:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A361897583
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 22:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908B21C17B;
	Wed, 19 Mar 2025 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0NiihJw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B197E1
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423371; cv=none; b=FgsQTsk09ZEEf2K3QQzxfZ4lVJY4uXSgicEAuxKdugu92tWPXtrTzGphR1nkZpfc210EUucjFwV11mThLicNjgjIJA+W6KjYzzXGYoOOsYiiD2+u4rEpESeIsyWXA/vcrFKP7kVHhLQjQGJbyUub0hzSpSWwB3ZXVr0hnT3v0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423371; c=relaxed/simple;
	bh=v2iXFSSL3TlOTn1D7AnfxdJ8zHloXM7Z085NkCxJlxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aw0+k1/4TGopbmYKMKIDUsC+p4LefzFndXzVk0nKhU2X11vOTAd0ELVAx99RmVTk6YPKNgn8pdmuoDLljeyEzN0wQz8aMPV7iuuKE8vqowpYxN/ErSKrLMyVm9F96vT9cG/N3Hrucmqd1iNOBSU3F1dqV1mRn6xXLMbM7dJCPs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0NiihJw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742423370; x=1773959370;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v2iXFSSL3TlOTn1D7AnfxdJ8zHloXM7Z085NkCxJlxw=;
  b=g0NiihJwM+121BBlIttskhtZHJb1RBeRCZw5lD5QD/joB4e1DZZ7OgO+
   ygs+4ipKYNMDjmPXFevTx76iB98Iqt1FOLIuZedfBGjQRILpJDRIqMUk7
   QuNVtSpTovtte6X/c937efsgY1DL5NqkwhZQvAz/qzemT2ytxf8xrRN6S
   3Z5SIzKG+djyu7m/7FN3S791zH/h3ZSa4QZ0loqjvd/sEIUsOcZ3iq7Z4
   JbDDM+TomOYviCvS4nThS4KsxeBSxPSBA4RQ5H2WORnnEYjTzr7sbrJl6
   bky3CgvgsXIrR6NSBmYOkmUuRu8Pqm/Z6q3jcrZbx//BHeiENKF0HlUNy
   g==;
X-CSE-ConnectionGUID: B8KO+BF/Smql7b1ARDDKJg==
X-CSE-MsgGUID: 3xWdyMdgT3a+nHpQLRYv9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43747302"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43747302"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 15:29:29 -0700
X-CSE-ConnectionGUID: CHgcvB+JSDqRev1gJ1SdPQ==
X-CSE-MsgGUID: joRNH7CeQEigbWNi4uNQzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="128041115"
Received: from uaeoff-desk2.amr.corp.intel.com (HELO [10.124.220.142]) ([10.124.220.142])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 15:29:28 -0700
Message-ID: <e03bf65b-c961-4196-8844-c61ac59a4a1c@linux.intel.com>
Date: Wed, 19 Mar 2025 15:29:17 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Rate limit AER logs
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Terry Bowman <Terry.bowman@amd.com>
References: <20250319084050.366718-1-pandoh@google.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250319084050.366718-1-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jon,

On 3/19/25 1:40 AM, Jon Pan-Doh wrote:
> Proposal
> ========
>
> When using native AER, spammy devices can flood kernel logs with AER errors
> and slow/stall execution. Add per-device per-error-severity ratelimits
> for more robust error logging. Allow userspace to configure ratelimits
> via sysfs knobs.
>
> Motivation
> ==========
>
> Several OCP members have issues with inconsistent PCIe error handling,
> exacerbated at datacenter scale (myriad of devices).
> OCP HW/Fault Management subproject set out to solve this by
> standardizing industry:
>
> - PCIe error handling best practices
> - Fault Management/RAS (incl. PCIe errors)
>
> Exposing PCIe errors/debug info in-band for a userspace daemon (e.g.
> rasdaemon) to collect/pass on to repairability services is part of the
> roadmap.
>
> Background
> ==========
>
> AER error spam has been observed many times, both publicly (e.g. [1], [2],
> [3]) and privately. While it usually occurs with correctable errors, it can
> happen with uncorrectable errors (e.g. during new HW bringup).
>
> There have been previous attempts to add ratelimits to AER logs ([4],
> [5]). The most recent attempt[5] has many similarities with the proposed
> approach.
>
> Patch organization
> ==================
> 1-4 AER logging cleanup
> 5-8 Ratelimits and sysfs knobs
>
> Outstanding work
> ================
> Cleanup:
> - Consolidate aer_print_error() and pci_print_error() path
>
> Roadmap:
> - IRQ ratelimiting

What is the baseline version for this patch set? When I tried to apply it on
v6.14-rc7 or linux-next, it does not apply cleanly.

> v3:
> - Ratelimit aer_print_port_info() (drop Patch 1)
> - Add ratelimit enable toggle
> - Move trace outside of ratelimit
> - Split log level (Patch 2) into two
> - More descriptive documentation/sysfs naming
> v2:
> - Rebased on top of pci/aer (6.14.rc-1)
> - Split series into log and IRQ ratelimits (defer patch 5)
> - Dropped patch 8 (Move AER sysfs)
> - Added log level cleanup patch[6] from Karolina's series
> - Fixed bug where dpc errors didn't increment counters
> - "X callbacks suppressed" message on ratelimit release -> immediately
> - Separate documentation into own patch
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=215027
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=201517
> [3] https://bugzilla.kernel.org/show_bug.cgi?id=196183
> [4] https://lore.kernel.org/linux-pci/20230606035442.2886343-2-grundler@chromium.org/
> [5] https://lore.kernel.org/linux-pci/cover.1736341506.git.karolina.stolarek@oracle.com/
> [6] https://lore.kernel.org/linux-pci/edd77011aafad4c0654358a26b4e538d0c5a321d.1736341506.git.karolina.stolarek@oracle.com/
>
> Jon Pan-Doh (6):
>    PCI/AER: Move AER stat collection out of __aer_print_error()
>    PCI/AER: Rename struct aer_stats to aer_report
>    PCI/AER: Introduce ratelimit for error logs
>    PCI/AER: Add ratelimits to PCI AER Documentation
>    PCI/AER: Add sysfs attributes for log ratelimits
>    PCI/AER: Update AER sysfs ABI filename
>
> Karolina Stolarek (2):
>    PCI/AER: Check log level once and propagate down
>    PCI/AER: Make all pci_print_aer() log levels depend on error type
>
>   ...es-aer_stats => sysfs-bus-pci-devices-aer} |  34 +++
>   Documentation/PCI/pcieaer-howto.rst           |  16 +-
>   drivers/pci/pci-sysfs.c                       |   1 +
>   drivers/pci/pci.h                             |   4 +-
>   drivers/pci/pcie/aer.c                        | 276 +++++++++++++-----
>   drivers/pci/pcie/dpc.c                        |   3 +-
>   include/linux/pci.h                           |   2 +-
>   7 files changed, 266 insertions(+), 70 deletions(-)
>   rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (77%)
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


