Return-Path: <linux-pci+bounces-3475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8743D855BCA
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 08:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54D1B27AE8
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 07:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFADDDD8;
	Thu, 15 Feb 2024 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMTXrk/M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2912B8B;
	Thu, 15 Feb 2024 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983016; cv=none; b=RI1Q/W4oSwzVZhKhj8LsCD28EMItIykKlsE5s9kd6ds8NaKC8MUrqrghqhLaSJICKa82iAHbXspuMn2ZSaxYlb/DsQFU6+GRoW85qWCSDBeLp1luBg/4i6L/0OU8cABnT4PSbOeUD0Kc3/xC6GB6iXlCKUWEHuZLp+ovcpdnFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983016; c=relaxed/simple;
	bh=Zab4zbYyzSEJ6rZgWp5a8PIv1/MD6puSacJ4VYyk8rk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y5GBSTcflgP0I1z/Eo73N4EUimhlJuuuBICgFz//A/Oh8te+cv8PvDbTM2UzLeDY4Ewq3cGWsCQZCVfE3Lu9k/JcbDMEKmN45DhC/xHpT0c9Aoax5DdBUeG12z9oKyX+KSfCIz+hDkqyO2Ll2Aiznx37vdj705kiKnwIllfR5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMTXrk/M; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707983013; x=1739519013;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zab4zbYyzSEJ6rZgWp5a8PIv1/MD6puSacJ4VYyk8rk=;
  b=nMTXrk/MteIcSV8zNRntvQ7VY16Nfb2WqNQ/QNRzOcqEgZgJ+37eJWza
   FG5aYlTVMdxDO9/6ieX0cnpu6W9qrnNh0TJT7R2DMey0Yruj8T7NFF9s0
   vqCHsCRXkg8NkdllWAkwSAy9nu6ppB/DejTP8pbBI1QT5HVttBmNukb5P
   O6DLB1zfiI+NRtSn2hcenLQa+0rDSyHH4gLXUfXgDgKzNSgKoc5wiaZXk
   /ndch+xHDY4KsSfG/72BNne5elffpo3Ucej0IfoU2KbyT7xnFcBu1po/k
   Wvi8+4PI76yiVwAD0tjzjrsOik+C/clsFaZIfsB6NUU7YXXpKEDpj3a+K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2202489"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="2202489"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 23:43:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="34260199"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 14 Feb 2024 23:43:29 -0800
Message-ID: <7cd18221-0d25-4b99-887b-3a344be0da9d@linux.intel.com>
Date: Thu, 15 Feb 2024 15:37:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Ethan Zhao <haifeng.zhao@linux.intel.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "will@kernel.org" <will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7adec292-9d38-41ab-a982-bd840b24f3ab@intel.com>
 <0aee453c-e98f-4b72-8107-31d4731abcdb@linux.intel.com>
 <BN9PR11MB5276D3372267CE9246170FA78C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <500c4582-ec05-4a9e-9b68-d2ae19aed49b@linux.intel.com>
 <20240130162958.GF50608@ziepe.ca>
 <6a48f023-2701-4f2f-8077-14fe348794dd@linux.intel.com>
 <20240201193427.GQ50608@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240201193427.GQ50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/24 3:34 AM, Jason Gunthorpe wrote:
> On Wed, Jan 31, 2024 at 02:21:20PM +0800, Baolu Lu wrote:
>> An rbtree for IOMMU device data for the VT-d driver would be beneficial.
>> It also benefits other paths of fault handling, such as the I/O page
>> fault handling path, where it currently still relies on the PCI
>> subsystem to convert a RID value into a pci_device structure.
>>
>> Given that such an rbtree would be helpful for multiple individual
>> drivers that handle PCI devices, it seems valuable to implement it in
>> the core?
> rbtree is already supposed to be a re-usable library.
> 
> There is already good helper support in rbtree to make things easy to
> implement. I see arm hasn't used them yet, it should look something
> like this:

I have posted a similar implementation for the vt-d driver here:

https://lore.kernel.org/linux-iommu/20240215072249.4465-1-baolu.lu@linux.intel.com/

Based on this implementation, only patches 1 and 2 are required. The
last patch could be like below (code compiled but not tested, comments
not changed yet):

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index f9b63c2875f7..30a659a4d3ed 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1272,6 +1272,7 @@ static int qi_check_fault(struct intel_iommu 
*iommu, int index, int wait_index)
  {
         u32 fault;
         int head, tail;
+       u64 iqe_err, ite_sid;
         struct q_inval *qi = iommu->qi;
         int shift = qi_shift(iommu);

@@ -1316,6 +1317,13 @@ static int qi_check_fault(struct intel_iommu 
*iommu, int index, int wait_index)
                 tail = readl(iommu->reg + DMAR_IQT_REG);
                 tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;

+               /*
+                * SID field is valid only when the ITE field is Set in 
FSTS_REG
+                * see Intel VT-d spec r4.1, section 11.4.9.9
+                */
+               iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
+               ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
+
                 writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
                 pr_info("Invalidation Time-out Error (ITE) cleared\n");

@@ -1325,6 +1333,19 @@ static int qi_check_fault(struct intel_iommu 
*iommu, int index, int wait_index)
                         head = (head - 2 + QI_LENGTH) % QI_LENGTH;
                 } while (head != tail);

+               /*
+                * If got ITE, we need to check if the sid of ITE is the 
same as
+                * current ATS invalidation target device, if yes, don't 
try this
+                * request anymore if the target device isn't present.
+                * 0 value of ite_sid means old VT-d device, no ite_sid 
value.
+                */
+               if (ite_sid) {
+                       struct device *dev = device_rbtree_find(iommu, 
ite_sid);
+
+                       if (!dev || !pci_device_is_present(to_pci_dev(dev)))
+                               return -ETIMEDOUT;
+               }
+
                 if (qi->desc_status[wait_index] == QI_ABORT)
                         return -EAGAIN;
         }

Best regards,
baolu

