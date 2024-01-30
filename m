Return-Path: <linux-pci+bounces-2768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72089841C93
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 08:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C301F26404
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 07:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24C24F1F5;
	Tue, 30 Jan 2024 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+uQvlLt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E94D583;
	Tue, 30 Jan 2024 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706599847; cv=none; b=QeNrtp7EHkDKx6JivBO+tTYhrioc2eYBTj1zHTtpwNiSQ8TACp6ocrTNl6ba6Osk0B4ooWred39f6si/WrpcVOrudPfJB3HUq5jwM2jKZ9+7kKXxTwCNVEsDF6KXy+l1709TIDC/A1pHoJD3PCYqMGGKTRp9HTn+XCiXUnJHVIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706599847; c=relaxed/simple;
	bh=foOvR8njiSdEDNybt1uvmEL+bBp2j5RmuiwsLhRfcE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOR0OR3g40y3unNVw1lgYPcxsS07nS1ucc6r5RsxhzHJP9GP6zwiEzMXyuIyqX01x6W6uwBdvgnexttYISe0iyTqhrKb7C2PpzRpl00CR58PWHsH28Z5pHiEgzvruaTBMKAf1DpWBUk1rMJ7CFloqzB/sFXnaURemdn44R/hs2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+uQvlLt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706599846; x=1738135846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=foOvR8njiSdEDNybt1uvmEL+bBp2j5RmuiwsLhRfcE8=;
  b=A+uQvlLtHwGlNOMpjlM3NlUcmhAMhzSaexY2fKLoUwjSv/mEcjNeTy7C
   zn1xZetU7vhMBVJr9Sl72z60iSJwaFd6dh5nBQPPoMYj3l/jLkZWZw5zT
   FiLJuRHv8u/T116DwBzqZiRZIfNgqgZeDGcL1mNeUvLs/n5v8eQuQ9t3q
   DO+S/F4Wu5K72EN9Q2yUlhGXmC0rfK7fm91oFZETP5kjeWHyCql6CcRaP
   s5pcWzFxpjUqkpVfdlRRYGUO3YmWXqfZfshUyOViWZQnLVRvL+PSAKbmg
   ZxDuKdB3MbbWHF8788ZzijE3awvX3JoWx6L34oBLxNMZdPtIp9ksUXbBg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3029061"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3029061"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 23:30:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="931352719"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="931352719"
Received: from hexu1-mobl1.ccr.corp.intel.com (HELO [10.249.174.131]) ([10.249.174.131])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 23:30:42 -0800
Message-ID: <b3af83cf-b6c7-4543-b793-f2a9547ca9d2@linux.intel.com>
Date: Tue, 30 Jan 2024 15:30:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/5] iommu/vt-d: pass pdev parameter for
 qi_check_fault() and refactor callers
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "will@kernel.org" <will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-5-haifeng.zhao@linux.intel.com>
 <BN9PR11MB5276BAB9620D3A7B07B24F328C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <BN9PR11MB5276BAB9620D3A7B07B24F328C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/29/2024 4:58 PM, Tian, Kevin wrote:
>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> Sent: Monday, January 29, 2024 11:49 AM
>>
>> to check state of ATS capable pci device in qi_check_fault() for surprise
>> removal case, we need to pass the target pci device of ATS invalidation
>> request to qi_check_fault(). if pdev is valid, means current request is for
>> ATS invalidation, vice vesa.
>>
>> no function change.
> qi_submit_sync() is used for all kinds of iotlb/cache/devtlb invalidations.
> it's a bit weird to see a device pointer (even being NULL) in places where
> a device doesn't even matter.
>
> having a new qi_submit_sync_devtlb() wrapper sounds cleaner to me,
> with an internal __qi_submit_sync() helper to accept a device pointer.
>
> qi_submit_sync() calls __qi_submit_sync() with a null device pointer then
> non-devtlb paths are intact.

Make sense !

That way, could keep about 10 qi_submit_sync() calling intact, while

only 2-3 qi_submit_sync_devtlb() wrapper calling needed.

Thanks,

Ethan


