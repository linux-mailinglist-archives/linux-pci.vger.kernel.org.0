Return-Path: <linux-pci+bounces-1967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2761829327
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 06:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93497B24810
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 05:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B82CA4A;
	Wed, 10 Jan 2024 05:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YDDeqim8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465FDD512;
	Wed, 10 Jan 2024 05:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704863074; x=1736399074;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k64/f9r7Qp36i1XX1i9jcMtrmGXtcJyhgHq6uyIFl64=;
  b=YDDeqim8fSjoE4zYkzLIvVa6FjWGHOs9v7u6o3goFL/oiEY+QLiTCpqx
   iJRFjdMGAMJPZjpBU1wqTifvhewGw31VgIGNtMWshdnilxmLcQ7ASaVrs
   Wt5ZSOF5jYvYKsgXCVzldNC4ywvJ5XaxsPOFiO4XBtTxm5faUm9eIBuPk
   0zxUCNn2k4Ozyk935r/FHB4DRb0Rx7//R4qAAOVFXVI6vkTA7ahsCMKYF
   juk+nVCu8oDx5lBXLMLCEUVvFmlNl+ga9MAMR0BtTuGAzRgpIvJrgd0Yb
   shvRdxj5k4TLEMyhm5MvOLnqKgLeeCDvVkp7EIbqcmAZm68PGHDs1mcpG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="429596918"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="429596918"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 21:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="16511841"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa002.fm.intel.com with ESMTP; 09 Jan 2024 21:04:30 -0800
Message-ID: <a2e507b3-a018-44d8-9e92-459670505bcd@linux.intel.com>
Date: Wed, 10 Jan 2024 12:59:16 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v10 1/5] iommu/vt-d: add pci_dev parameter to
 qi_submit_sync and refactor callers
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, kevin.tian@intel.com,
 bhelgaas@google.com, dwmw2@infradead.org, will@kernel.org,
 robin.murphy@arm.com, lukas@wunner.de
References: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
 <20231228170206.720675-2-haifeng.zhao@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231228170206.720675-2-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/29/23 1:02 AM, Ethan Zhao wrote:
> Signed-off-by: Ethan Zhao<haifeng.zhao@linux.intel.com>

Please don't leave the message body empty. You should describe why do
you want to add the change in this patch.

> ---
>   drivers/iommu/intel/dmar.c          | 45 +++++++++++++++++++++--------
>   drivers/iommu/intel/iommu.c         | 26 +++++------------
>   drivers/iommu/intel/iommu.h         | 17 +++++------
>   drivers/iommu/intel/irq_remapping.c |  2 +-
>   drivers/iommu/intel/pasid.c         | 11 ++-----
>   drivers/iommu/intel/svm.c           | 13 ++++-----
>   6 files changed, 58 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 23cb80d62a9a..3d661f2b7946 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1344,7 +1344,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
>    * can be part of the submission but it will not be polled for completion.
>    */
>   int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
> -		   unsigned int count, unsigned long options)
> +		   unsigned int count, unsigned long options, struct pci_dev *pdev)

How about adding a bit in options parameter to tell whether the @pdev is
valid?

Best regards,
baolu

