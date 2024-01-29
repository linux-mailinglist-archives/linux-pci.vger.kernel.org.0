Return-Path: <linux-pci+bounces-2689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE66B83FDA9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 06:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6990A1F237B2
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 05:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7614205B;
	Mon, 29 Jan 2024 05:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEOxhakh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2BC45958;
	Mon, 29 Jan 2024 05:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706505392; cv=none; b=RVL+ug5VQp3jQaENNG+s9XevbKl49doFVrbEoDbBYTSibWidJ3WHW7PNw5cDoJ8yzHy6yCj4OhVFifMpEoofIeCoV0Rb9kpxYjeYiwLonWtSDZbPOKObnObio2/x0I7utEJ7AQUyazBr3UF7aAhPwrrERSrKiofQqh5DY8hptsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706505392; c=relaxed/simple;
	bh=OLiMGRJGayaxtLxGD6OEIq8U1cY6UW2Pt3FJy+pS75c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f59M0vMJCwX0eCjsw5NYKGPYGp808tvf7Ma1gQxy5IO0BdR7ZxVv841mc+rohnJg6cBH15fLl5So31EpRVWa2GPDywyFzyL7znP+eXKQ9SXKNUDpsGUj6zTm3bUIhY4KidhU9AEDlUCivPXtMrD7vnA2/I4tAQ/jAcDxagM5gvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eEOxhakh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706505391; x=1738041391;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OLiMGRJGayaxtLxGD6OEIq8U1cY6UW2Pt3FJy+pS75c=;
  b=eEOxhakh1eqQ5sWy7zwnQSBxXe5cFXmshKfDARWkCvWqY4+odsyL9lu/
   t70vfLO6OmiCo44odd6e+qMhzqKLwRYnDc9V1+6OKE5IZcYYRDdd4FrGs
   C168/BxP1TSSldcFfW7ITLaZe5EWzyu6vhROtE6eYf283pUyl866kLqno
   WYxPtTR+4AW2T2L6qunUXqHmoDWtjQtvomRb15JB9x7h4Wa8Gchu4mbL7
   KS34ojiQdcRsIUibhbMXBEzqSuJHhdGzhH+pq4zZGFSFkwlt7NWzNWhwe
   3lRu+nOg5sSCCmhqnRQevf5NnE3hh7sAY/GLdYWzwqi/fxvniDmbOfTCt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="21382644"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="21382644"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 21:16:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="960790661"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="960790661"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.255.29.114]) ([10.255.29.114])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 21:16:25 -0800
Message-ID: <f7617140-0f9d-4907-aa8f-55894de830b0@linux.intel.com>
Date: Mon, 29 Jan 2024 13:16:23 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/5] fix vt-d hard lockup when hotplug ATS capable
 device
To: baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
 jgg@ziepe.ca
Cc: kevin.tian@intel.com, dwmw2@infradead.org, will@kernel.org,
 lukas@wunner.de, yi.l.liu@intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Bjorn,

On 1/29/2024 11:49 AM, Ethan Zhao wrote:
> This patchset is used to fix vt-d hard lockup reported when surprise
> unplug ATS capable endpoint device connects to system via PCIe switch
> as following topology.
>
>       +-[0000:15]-+-00.0  Intel Corporation Ice Lake Memory Map/VT-d
>       |           +-00.1  Intel Corporation Ice Lake Mesh 2 PCIe
>       |           +-00.2  Intel Corporation Ice Lake RAS
>       |           +-00.4  Intel Corporation Device 0b23
>       |           \-01.0-[16-1b]----00.0-[17-1b]--+-00.0-[18]----00.0
>                                             NVIDIA Corporation Device 2324
>       |                                           +-01.0-[19]----00.0
>                            Mellanox Technologies MT2910 Family [ConnectX-7]
>
> User brought endpoint device 19:00.0's link down by flapping it's hotplug
> capable slot 17:01.0 link control register, as sequence DLLSC response,
> pciehp_ist() will unload device driver and power it off, durning device
> driver is unloading an iommu device-TLB invalidation (Intel VT-d spec, or
> 'ATS Invalidation' in PCIe spec) request issued to that link down device,
> thus a long time completion/timeout waiting in interrupt context causes
> continuous hard lockup warnning and system hang.
>
> Other detail, see every patch commit log.
>
> patch [1&2] were tested by yehaorong@bytedance.com on stable v6.7-rc4.
> patch [1-5] passed compiling on stable v6.8-rc2.
>
> change log:
> v12:
> - use base-commit tag to format patch.
> - fix building issue on v6.8-rc2 repported by lkp@intel.com.
> v11:
> - update per latest comment and suggestion from Baolu and YiLiu.
> - split refactoring patch into two patches, [3/5] for simplify parameters
>    and [4/5] for pdev parameter passing.
> - re-order patches.
> - fold target device presence check into qi_check_fault().
> - combine patch[2][5] in v10 into one patch[5].
> - some commit description correctness.
> - add fixes tag to patch[2/5].
> - rebased on 6.8rc1
> v10:
> - refactor qi_submit_sync() and its callers to get pci_dev instance, as
>    Kevin pointed out add target_flush_dev to iommu is not right.
> v9:
> - unify all spelling of ATS Invalidation adhere to PCIe spec per Bjorn's
>    suggestion.
> v8:
> - add a patch to break the loop for timeout device-TLB invalidation, as
>    Bjorn said there is possibility device just no response but not gone.
> v7:
> - reorder patches and revise commit log per Bjorn's guide.
> - other code and commit log revise per Lukas' suggestion.
> - rebased to stable v6.7-rc6.
> v6:
> - add two patches to break out device-TLB invalidation if device is gone.
> v5:
> - add a patch try to fix the rare case (surprise remove a device in
>    safe removal process). not work because surprise removal handling can't
>    re-enter when another safe removal is in process.
> v4:
> - move the PCI device state checking after ATS per Baolu's suggestion.
> v3:
> - fix commit description typo.
> v2:
> - revise commit[1] description part according to Lukas' suggestion.
> - revise commit[2] description to clarify the issue's impact.
> v1:
> - https://lore.kernel.org/lkml/20231213034637.2603013-1-haifeng.zhao@
> linux.intel.com/T/
>
>
> Thanks,
> Ethan
>
>   
>
>
> Ethan Zhao (5):
>    PCI: make pci_dev_is_disconnected() helper public for other drivers
>    iommu/vt-d: don't issue ATS Invalidation request when device is
>      disconnected
>    iommu/vt-d: simplify parameters of qi_submit_sync() ATS invalidation
>      callers
>    iommu/vt-d: pass pdev parameter for qi_check_fault() and refactor
>      callers
>    iommu/vt-d: improve ITE fault handling if target device isn't present
>
>   drivers/iommu/intel/dmar.c          | 71 +++++++++++++++++++++++------
>   drivers/iommu/intel/iommu.c         | 29 +++---------
>   drivers/iommu/intel/iommu.h         | 20 ++++----
>   drivers/iommu/intel/irq_remapping.c |  2 +-
>   drivers/iommu/intel/nested.c        |  9 +---
>   drivers/iommu/intel/pasid.c         | 12 ++---
>   drivers/iommu/intel/svm.c           | 23 +++++-----
>   drivers/pci/pci.h                   |  5 --
>   include/linux/pci.h                 |  5 ++
>   9 files changed, 98 insertions(+), 78 deletions(-)
>
>
> base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3

I got mail delivery failure message from Gmail for "unsolicited mail", I 
don't

know if you could read it by linux-pci mail list. the vt-d maintainer is 
going

to pick up this patchset, may I ask your 'ack' for the pci change if no 
more

comment from you ?

Thanks,

Ethan


