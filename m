Return-Path: <linux-pci+bounces-3266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEE284EECB
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 03:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033471C24650
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 02:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921E9EBB;
	Fri,  9 Feb 2024 02:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzDU3xgY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91122139B;
	Fri,  9 Feb 2024 02:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707444541; cv=none; b=rioN/mnlVi8O4GuwZpv+dVnu6Rs5p45pnVMxTvL/Mhwz5D7gZF2VXU9IOj3hurcstkk+fiYUKOJ6kwLQ3g0Tt+CpZaCZlvKXFAhvRIsEv6LyH9waJ8pOABP7YHwrV4kXY9mm3pqQA/X0bWh9tqMp58/E/8+s68VpTIx52/3lvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707444541; c=relaxed/simple;
	bh=v8o7vfqnfzKhev8X7dFatWmQOop7Opbrjtjs3z6LDBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9tGiObUPlOlCEoLJyuqjccoiPDZ3ETLhPgqo8S5rkIY47L5JCKK2LkiIfqb+oeVYsC8ffHH9lB3vWL0hy8zr0XH8utTSNBWS3czpRwqINh0lhQhtMhXVGwzqlkyhoL19E4naDQARMfdm4fNfPyAE2HG/GH3++OB4iQ/DphQlFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzDU3xgY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707444536; x=1738980536;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v8o7vfqnfzKhev8X7dFatWmQOop7Opbrjtjs3z6LDBk=;
  b=BzDU3xgYLeqBY6+gHqEC7Tp5J3mNB//i+GoThQXDbiEaYS3ijyqNjSKZ
   /Fk3Cb86HZjr3WyZEwAP6XoniKotNprcqY3npTwF6ZZRPpVKoL2hsDTvw
   oCW99t3i7s5TgR1KM6S1OOCzggluVhZ4ZWhQ3PR6v13J1SeK0r+wWrZ6j
   tZ2LHXUPIQdW1YxEkWq1UBhZz8IuDdy8AxwTHxqqwpp4hswuRJk1WIlGm
   lpEu9CoZDktpsjguHTTg+MMUn77urklMaQR1MImEYLHk7zE/4qkJ5ZGBE
   J27aAWctXCBOAgWDuscMzo5RMi8fDrgI8aZxM15ZqQHLIxwagDg2IsesZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="18862430"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="18862430"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 18:08:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1829406"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.249.169.150]) ([10.249.169.150])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 18:08:51 -0800
Message-ID: <290d9e43-5d71-4c25-b299-37d3854fb714@linux.intel.com>
Date: Fri, 9 Feb 2024 10:08:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/5] iommu/vt-d: pass pdev parameter for
 qi_check_fault() and refactor callers
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 baolu.lu@linux.intel.com, bhelgaas@google.com, robin.murphy@arm.com,
 jgg@ziepe.ca
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, kevin.tian@intel.com,
 dwmw2@infradead.org, will@kernel.org, lukas@wunner.de, yi.l.liu@intel.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <b0b45e40-7510-4107-92a0-27fafb5d7bf7@moroto.mountain>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <b0b45e40-7510-4107-92a0-27fafb5d7bf7@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/8/2024 3:15 PM, Dan Carpenter wrote:
> Hi Ethan,
>
> kernel test robot noticed the following build warnings:
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Zhao/PCI-make-pci_dev_is_disconnected-helper-public-for-other-drivers/20240129-115259
> base:   41bccc98fb7931d63d03f326a746ac4d429c1dd3
> patch link:    https://lore.kernel.org/r/20240129034924.817005-5-haifeng.zhao%40linux.intel.com
> patch subject: [PATCH v12 4/5] iommu/vt-d: pass pdev parameter for qi_check_fault() and refactor callers
> config: x86_64-randconfig-161-20240207 (https://download.01.org/0day-ci/archive/20240208/202402080321.n77hu71Y-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202402080321.n77hu71Y-lkp@intel.com/
>
> smatch warnings:
> drivers/iommu/intel/dmar.c:1533 qi_flush_dev_iotlb() error: we previously assumed 'info->dev' could be null (see line 1533)
>
> vim +1533 drivers/iommu/intel/dmar.c
>
> 20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1522  void qi_flush_dev_iotlb(struct intel_iommu *iommu,
> 20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1523  			struct device_domain_info *info, u64 addr,
> 20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1524  			unsigned int mask)
> 6ba6c3a4cacfd6 drivers/pci/dmar.c         Yu Zhao      2009-05-18  1525  {
> c830e699e08a6c drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1526  	struct pci_dev *pdev = NULL;
> 20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1527  	u16 sid, qdep, pfsid;
> 6ba6c3a4cacfd6 drivers/pci/dmar.c         Yu Zhao      2009-05-18  1528  	struct qi_desc desc;
> 6ba6c3a4cacfd6 drivers/pci/dmar.c         Yu Zhao      2009-05-18  1529
> 20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1530  	if (!info || !info->ats_enabled)
> 20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1531  		return;
> 20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1532
> c830e699e08a6c drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28 @1533  	if (info->dev || !dev_is_pci(info->dev))
>
> Missing ! character.  if (!info->dev

Got it, thanks.

>
> c830e699e08a6c drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1534  		return;
> c830e699e08a6c drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1535
> c830e699e08a6c drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1536  	pdev = to_pci_dev(info->dev);
> 20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1537  	sid = info->bus << 8 | info->devfn;
> 20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1538  	qdep = info->ats_qdep;
> 20da7293134024 drivers/iommu/intel/dmar.c Ethan Zhao   2024-01-28  1539  	pfsid = info->pfsid;
>

