Return-Path: <linux-pci+bounces-29272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE16CAD2C9F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 06:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E2E3B038C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 04:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13B025DCFF;
	Tue, 10 Jun 2025 04:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSIXrrzR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C53747F;
	Tue, 10 Jun 2025 04:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749529677; cv=none; b=B4ydrCndqCR9fYv+unSSsxzqt8T0mLM8ZahPsH7BOgTBWg3aRq6ifrh6eUnlNjGS61fcpl3HVvFeOBeck719J8YVxje7+KItJwicRbxCxXQgROVs6/tCNMLQGR0yd5F4JHHheZHYxB+TaalKkRYRY7TfMGMASgIIVyixJU3MWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749529677; c=relaxed/simple;
	bh=bABhSsjxKZ0piICCcKMoHsdmRblKy52gHCDlFNdDTTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+ZSwALaKC/NswphsTqQN7ERbsV9utXEKpUU3nAMvy/1e/g627D5lY3eAiAX+N2+eEV1BIhJQwh5ytXHwa+FJOceB52eEuty05xSiYvqGR4RGWHlp53f53XDCZLXeKdUf/IFMv6GncOtnxltIsbgDo+LqWNwBt1hHk+HYxR7S44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSIXrrzR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749529676; x=1781065676;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bABhSsjxKZ0piICCcKMoHsdmRblKy52gHCDlFNdDTTk=;
  b=RSIXrrzR9b56c/uHKY3dj4tZ9XnOt9rHwhag/MICWNBjFJMq5tfe+XxN
   DArdmv07RM1+QqZM41cTnbUKPg/Yd5/GpLuYrDErthUESHQiE3w03mPU1
   Qeda88Cd+K+Xd0nUmz6wp0mOsE87LoUQT8qHaSYwMFmZRZ1rfMDwXQBVM
   tGWGehSHg3xxGAVr+60+k1SWB/OzyAn4EzTr9dHJbIiGZoYgEXU70lDRo
   7k4ZcFFFzrQXri+ivIeBS9Ga5glLQFY+zyMRzM6usUa/pF3D5hSD8OGDn
   qUKaHivgJSChXRitAKbeTItx93Qtj5SikKtiC77Kerfou4Ld0ryy03k5j
   Q==;
X-CSE-ConnectionGUID: kfn00KGpTWK9anQBOEvXWQ==
X-CSE-MsgGUID: A/aCioQ3RTKUht5HzskIIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="54253719"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="54253719"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 21:27:56 -0700
X-CSE-ConnectionGUID: ILtEZ1+rTOWRrlJcfV9EDw==
X-CSE-MsgGUID: yGjo7KvoSn+NESx7FbV2aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="146597903"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 21:27:53 -0700
Message-ID: <34442ab9-08e1-4e9a-b08e-3b81a581fec3@linux.intel.com>
Date: Tue, 10 Jun 2025 12:27:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 2/2] pci: Suspend ATS before doing FLR
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, patches@lists.linux.dev, pjaroszynski@nvidia.com,
 vsethi@nvidia.com
References: <cover.1749494161.git.nicolinc@nvidia.com>
 <29cc1268dfdae2a836dbdeaa4eea3bedae564497.1749494161.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <29cc1268dfdae2a836dbdeaa4eea3bedae564497.1749494161.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/25 02:45, Nicolin Chen wrote:
> Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software should disable ATS
> before initiating a Function Level Reset.
> 
> Call iommu_dev_reset_prepare() before FLR and iommu_dev_reset_done() after,
> in the two FLR Functions. This will dock the device at IOMMU_DOMAIN_BLOCKED
> during the FLR function, which should allow the IOMMU driver to pause DMA
> traffic and invode pci_disable_ats() and pci_enable_ats() respectively.
> 
> Add a warning if ATS isn't disabled, in which case IOMMU driver should fix
> itself to disable ATS following the design in iommu_dev_reset_prepare().
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   drivers/pci/pci.c | 42 ++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e9448d55113b..61535435bde1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -13,6 +13,7 @@
>   #include <linux/delay.h>
>   #include <linux/dmi.h>
>   #include <linux/init.h>
> +#include <linux/iommu.h>
>   #include <linux/msi.h>
>   #include <linux/of.h>
>   #include <linux/pci.h>
> @@ -4518,13 +4519,26 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>    */
>   int pcie_flr(struct pci_dev *dev)
>   {
> +	int ret = 0;
> +
>   	if (!pci_wait_for_pending_transaction(dev))
>   		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
>   
> +	/*
> +	 * Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software disables ATS
> +	 * before initiating a Function Level Reset. So notify the iommu driver
> +	 * that actually enabled ATS. Have to call it after waiting for pending
> +	 * DMA transaction.
> +	 */
> +	if (iommu_dev_reset_prepare(&dev->dev))
> +		pci_err(dev, "failed to stop IOMMU\n");

Need to abort here?

Thanks,
baolu

