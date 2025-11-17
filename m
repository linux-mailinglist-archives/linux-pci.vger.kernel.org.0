Return-Path: <linux-pci+bounces-41391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6DFC63EA6
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 12:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F653ACE5B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 11:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E6624169F;
	Mon, 17 Nov 2025 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULVNTPgB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A032BF52
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763379906; cv=none; b=MjWNFBRVrGNX8C6kBs60aGSna274qIQ7GwvkgoWzjaZXEO50RYN8ThsbAHZCduSVg+jSiYy2I/rEt77VwdYoH+zZ3JRYhInYgnmNcROMw4U8/RD27GMs9bMKy75CdLIGA4C5mPpBFvbd1RiWGSyeW+O1C45hvWiN1OcMPFYms6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763379906; c=relaxed/simple;
	bh=b8UEmyIEHVd/wRnZxevk3cjz8QwPhham+18nUqTmW3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doJfhb1b6yGQ06CdN8QMKp9/+tyhoeIOemowXoxdkzpEzlo88KPqQSt2BlEYNiMoHTIXts/GmywMFipoa/Ni4PxPaoYjelbzXRacae3/rhVLTLLfnTsmgQXR1AV/lVQniTwu3mMMKRjp/z8kg6JbujIVmgE9excjO91ItULVzuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULVNTPgB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763379905; x=1794915905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b8UEmyIEHVd/wRnZxevk3cjz8QwPhham+18nUqTmW3s=;
  b=ULVNTPgB5w3I8FwaDXMEKU5WgatzKyUQ8OKb9mucO1ipa/yUUNyUU7PV
   Re5Pd2bWTh8FNokEmpSv0kWzpPlNTDOA3mNUHWS7DnvBjH43Mfo1VJ6Gd
   opZokDc2+NYeXyDy2osdHbjNHeBeLzlS8knh4+d0Whn7+5DxpJgjzKEwA
   rrNemlvSe2d7CFGhV3/8bxFRB4LgNzSsIGxJ2IkMKP4IW3/+MFF96uADk
   ZsC2JWBIKYKhBISQC3zLT9ZHJYenNxqF+Lxd/9OISnyu9zHvgnHEIpypQ
   zBMrKXgCyBXS/B77rkeKd/VCFTHY3PtmrlRxN2MZe5s9IInAwqCJR3zc+
   Q==;
X-CSE-ConnectionGUID: ADGcvhc8RF6eync/Iskxrw==
X-CSE-MsgGUID: etc6CSTzSm+7ez4eK650LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="64378580"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="64378580"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 03:45:04 -0800
X-CSE-ConnectionGUID: g5gO1ENiSCyqxNxEshUpIw==
X-CSE-MsgGUID: sGGDHlWBQE63md90Y85KLA==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 17 Nov 2025 03:45:03 -0800
Date: Mon, 17 Nov 2025 19:30:20 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-pci@vger.kernel.org, linux-coco@lists.linux.dev,
	Jonathan.Cameron@huawei.com
Subject: Re: [PATCH v2 6/8] PCI/TSM: Add pci_tsm_bind() helper for
 instantiating TDIs
Message-ID: <aRsHTPWvTPpCrRTx@yilunxu-OptiPlex-7050>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
 <20251113021446.436830-7-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113021446.436830-7-dan.j.williams@intel.com>

> +int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
> +void pci_tsm_unbind(struct pci_dev *pdev);
> +void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
> +			     struct kvm *kvm, u32 tdi_id);
>  #else
>  static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
>  {
> @@ -147,5 +174,12 @@ static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
>  static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
>  {
>  }
> +static inline int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
                                                                         ^

s/u64/u32

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>

