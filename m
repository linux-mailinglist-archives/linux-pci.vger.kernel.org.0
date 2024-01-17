Return-Path: <linux-pci+bounces-2241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B9482FF44
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 04:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8121C23A74
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 03:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A361B1C11;
	Wed, 17 Jan 2024 03:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIlBgVMk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575C1C0F;
	Wed, 17 Jan 2024 03:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705461858; cv=none; b=OLWEHdQBQdNq9Y58LpJGPG/LVinGl+k/5LzPFyZ05GDHPtUDhdBnFXaO+ZNBBvSePDMx3q5CsLF+Gg9XkjKU7jjhza/r7mn+1km/TG9dzD4lS00x3zaqg8gOE5II1ZMNdX0cbYrIP5CkT3GWOIoiR479nDPJ4QJe2G18PbbJEEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705461858; c=relaxed/simple;
	bh=lQVzJfW4PzGfq9ar+uuKtn+tGVuy7nvv+1dL8Gzr7hw=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Cc:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding; b=Lgos4jtLMTSlnaXpMyC/FR9ngGp7pm9q4E4dQc3a0WB7oIb2pCUOcukdoldDaanVaj6J+yv8Igwi3HSdml+UzPZivzNgWfpLIO3vb/Dw46O2HW1FGpZ+ZtlYQn8EZtsWGVWrbKyyu58rnwnL+vG+Ourn50q57fGnxKsCV9Ax1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dIlBgVMk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705461857; x=1736997857;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lQVzJfW4PzGfq9ar+uuKtn+tGVuy7nvv+1dL8Gzr7hw=;
  b=dIlBgVMke2GYF8Gx931wPR1AS887YNQdJIUrm8vNL7oGaA1lbfIZ+f0O
   BSYkOKM+2zl+N+aRh86Vi6n4wbcmgynCEJbBWSRBMezAvmFK7wQOAAlGv
   f56nc/q8NnW5t41Lwpg5kwfTGVPlYfwFicdIlvlSZrDQ5Q9TnvVHOdp6N
   Q0lQasFHcqnTlZAqIh/vXbzzhVLT2ng/cy+SIR45J0A/3csoDt70sq+nx
   JuWYLAEaS4niRs7RKKGmVCJlKgIX5Hz9/JvHJnEr9JJgmeoeiyoAKjpCr
   4CBWLeGlmvSKOwDf1obvdmaUyxZws2AQnCkTxkNOnHPRWUCd6oUXbnIMO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6814146"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="6814146"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 19:24:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="777303816"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="777303816"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.146]) ([10.249.171.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 19:24:12 -0800
Message-ID: <3ee904e9-8a93-4bd9-8df7-6294885589e4@linux.intel.com>
Date: Wed, 17 Jan 2024 11:24:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v10 0/5] fix vt-d hard lockup when hotplug ATS capable
 device
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, kevin.tian@intel.com,
 bhelgaas@google.com, dwmw2@infradead.org, will@kernel.org,
 robin.murphy@arm.com, lukas@wunner.de
References: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
 <1a2a4069-c737-4a3c-a2f6-cce06823331b@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1a2a4069-c737-4a3c-a2f6-cce06823331b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/1/15 15:58, Ethan Zhao wrote:
> -static int qi_check_fault(struct intel_iommu *iommu, int index, int 
> wait_index)
> +static int qi_check_fault(struct intel_iommu *iommu, int index, int 
> wait_index,
> +                  pci_dev *target_pdev)
>   {
>          u32 fault;
>          int head, tail;
> +       u64 iqe_err, ice_sid;
>          struct q_inval *qi = iommu->qi;
>          int shift = qi_shift(iommu);
> 
>          if (qi->desc_status[wait_index] == QI_ABORT)
>                  return -EAGAIN;
> 
> +       /*
> +        * If the ATS invalidation target device is gone this moment 
> (surprise
> +        * removed, died, no response) don't try this request again. this
> +        * request will not get valid result anymore. but the request was
> +        * already submitted to hardware and we predict to get a ITE in
> +        * followed batch of request, if so, it will get handled then.
> +        */

We can't leave the ITE triggered by this request for the next one, which
has no context about why this happened. Perhaps move below code down to
the segment that handles ITEs.

Another concern is about qi_dump_fault(), which pr_err's the fault
message as long as the register is set. Some faults are predictable,
such as cache invalidation for surprise-removed devices. Unconditionally
reporting errors with pr_err() may lead the user to believe that a more
serious hardware error has occurred. Probably we can refine this part of
the code as well.

Others look sane to me.

> +       if (target_pdev && !pci_device_is_present(target_pdev))
> +               return -EINVAL;
> +
>          fault = readl(iommu->reg + DMAR_FSTS_REG);
>          if (fault & (DMA_FSTS_IQE | DMA_FSTS_ITE | DMA_FSTS_ICE))
>                  qi_dump_fault(iommu, fault);
> @@ -1315,6 +1327,13 @@ static int qi_check_fault(struct intel_iommu 
> *iommu, int index, int wait_index)
>                  tail = readl(iommu->reg + DMAR_IQT_REG);
>                  tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
> 
> +               /*
> +                * SID field is valid only when the ITE field is Set in 
> FSTS_REG
> +                * see Intel VT-d spec r4.1, section 11.4.9.9
> +                */
> +               iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
> +               ice_sid = DMAR_IQER_REG_ITESID(iqe_err);
> +
>                  writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>                  pr_info("Invalidation Time-out Error (ITE) cleared\n");
> 
> @@ -1324,6 +1343,16 @@ static int qi_check_fault(struct intel_iommu 
> *iommu, int index, int wait_index)
>                          head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>                  } while (head != tail);
> 
> +               /*
> +                * If got ITE, we need to check if the sid of ITE is the 
> same as
> +                * current ATS invalidation target device, if yes, don't 
> try this
> +                * request anymore, the target device has a response 
> time beyound
> +                * expected. 0 value of ice_sid means old device, no 
> ice_sid value.
> +                */
> +               if (target_pdev && ice_sid && ice_sid ==
> +                   pci_dev_id(pci_physfn(target_pdev))
> +                               return -ETIMEDOUT;
> +
>                  if (qi->desc_status[wait_index] == QI_ABORT)
>                          return -EAGAIN;
>          }

Best regards,
baolu

