Return-Path: <linux-pci+bounces-20562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B2EA226B3
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 00:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F30163E9A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 23:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA85F1B2182;
	Wed, 29 Jan 2025 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HS0WnlgQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34E18FDCE;
	Wed, 29 Jan 2025 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738191836; cv=none; b=WUKxFvk7vTtnYI4qT9wKOwmaj2c0E8VCBQvGUtowulpRqONKW0tSybtg7MSpa5/8o3lFLsGIWupmvgE6CDR+hyhGEqUMqEyFuiXnHRbogvLkaXxVTXLomxW8lFi8roPJ/WEuuHffGLfirnYrMa3x3ShFyOn3tKaIon1GkxdjecU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738191836; c=relaxed/simple;
	bh=0STYCAtnIMzJJnc9eqHSbmfmtTIfcWZihGjQi7tCkWI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GEEQo00D6+E6N0s7BjI5N8NIHjCTQfLuhwbNeWZa6q6qSd/vpGAjgq0JppyJvvcf+n+jI88IjmW7D5u16HiSDvWaQxMn2WsC3x4HxQK/YUYotZCrwIngGUd14Rh5cJubSbPFfJ/lkNFcyGzBaFpHx5SI7r3vv+l2L0hLslX9GDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HS0WnlgQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738191835; x=1769727835;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0STYCAtnIMzJJnc9eqHSbmfmtTIfcWZihGjQi7tCkWI=;
  b=HS0WnlgQYd7o+c4uXRtkZfKfvitp/xKufytUqf2Qhe2fEqE5XRF78VtU
   jnuWylO+LvT0jlLyDZt2sZLkAue8oIb000DstsTqMDTRW1ISeocRDPHp+
   OVCi5ks91M5T13RXFsnyYc/+JRwOIRu7m4N5gAqLGl2RPsgBwPeRSRfBK
   8jcXo7xD+eXGHAFvP7wP+geO1M2dlc2nc1Bk2wc0Sm4B/4e5gFedLw5aI
   9/6uP7ssDdXnlHdKJyZREsH/city4OnNXIYwiXQWZjDhkbvt2MC3Xf/Xz
   wXCpwcMMNix/1zSQS120HRYyiT5FWYjUD43MXDQBayQc/C5wleeeQjQqn
   A==;
X-CSE-ConnectionGUID: QOJ4DUdkQt2xNX/WYiJx9Q==
X-CSE-MsgGUID: YKwTkI/+ROatqDFzLRzQTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="37929787"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="37929787"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 15:03:05 -0800
X-CSE-ConnectionGUID: 8xWdFe6DTn+7aCdrSkyeig==
X-CSE-MsgGUID: zBL/IjM8SVy3+uKvhZN1OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140049108"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 15:03:04 -0800
Date: Wed, 29 Jan 2025 15:03:04 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    peter.colberg@altera.com, 
    "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>
Subject: Re: [PATCH v5 5/5] PCI: altera: Add Agilex support
In-Reply-To: <793b4cf1-bdf4-4010-aece-79c720ed05ad@kernel.org>
Message-ID: <5bfc352a-c6e1-7593-ad4-9079f2e0852@linux.intel.com>
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com> <20250127173550.1222427-6-matthew.gerlach@linux.intel.com> <793b4cf1-bdf4-4010-aece-79c720ed05ad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Wed, 29 Jan 2025, Krzysztof Kozlowski wrote:

> On 27/01/2025 18:35, Matthew Gerlach wrote:
>> +
>>  static const struct of_device_id altera_pcie_of_match[] = {
>>  	{.compatible = "altr,pcie-root-port-1.0",
>>  	 .data = &altera_pcie_1_0_data },
>>  	{.compatible = "altr,pcie-root-port-2.0",
>>  	 .data = &altera_pcie_2_0_data },
>> +	{.compatible = "altr,pcie-root-port-3.0-f-tile",
>> +	 .data = &altera_pcie_3_0_f_tile_data },
>> +	{.compatible = "altr,pcie-root-port-3.0-p-tile",
>> +	 .data = &altera_pcie_3_0_p_tile_data },
>> +	{.compatible = "altr,pcie-root-port-3.0-r-tile",
>> +	 .data = &altera_pcie_3_0_r_tile_data },
>
> Please run scripts/checkpatch.pl and fix reported warnings. After that,
> run also `scripts/checkpatch.pl --strict` and (probably) fix more
> warnings. Some warnings can be ignored, especially from --strict run,
> but the code here looks like it needs a fix. Feel free to get in touch
> if the warning is not clear.
I will fix the duplicate signature warning.

Thanks,
Matthew Gerlach
>
> Best regards,
> Krzysztof
>

