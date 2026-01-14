Return-Path: <linux-pci+bounces-44854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E7DD2125F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02840302D51F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A05330F92D;
	Wed, 14 Jan 2026 20:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCW0j0wh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6FF30F55A;
	Wed, 14 Jan 2026 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768421807; cv=none; b=LFxoxK4cDqOPP0I8Z+G4rFML2gp3Ju5DcifWZXLq8ptUJ/N/gYnbt+WYSZqcIDU6BRbxOjPRdGLXPU2KkdPqFsLem5iZ3TdoXqGddeBPH0sq/muH+kSlI8PkRle6o1xM/NpMxeiqR7AFF4bY7/YsUlestbqUqCPbCE0o3JJ8ubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768421807; c=relaxed/simple;
	bh=uVfOahXf3Le74bfhNQxVZCFzdiyT11601SyEf/nDILs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z88uMvXXo85Rqeidf9G9lmEYQk3YkiSU+W6YLMSOFvMJ6GjtiRM8CYF1+NZojLfEqRbeM6GyINyU0qVfmdDt5RMDSqST31ICzrbk0voQtANoDF8stcGu0bn5KHr2PR0kOMvOtHWo0VumZFtLmzOrPi0Qg8mRtfB9ZXm+FPYiNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCW0j0wh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768421805; x=1799957805;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uVfOahXf3Le74bfhNQxVZCFzdiyT11601SyEf/nDILs=;
  b=aCW0j0wh92EXsdctdp9u6ZQZhFPVyGjs8uVtQcwWtFnNiFi/TioMmpe3
   ThEyUlA3LjDfwSXLwVgw8b74U7nfa6NzsR3qGx537iAv97qTFEMVceTGI
   jSzCHfUwyJxdS69hHgKOXR+pSIzCVDMRRW2EtE4OwhI9mJpgCRU3s3Fhg
   2FGxg2FQjvSlC3QKv6qRu+sSYnfu2pu+xL9H2CVlrQ8xziKHBUcL3STTE
   ldMUYUvJsIIUSnSd3Mvy1NIfWjfZSt39+SzAFQ6i/Wq9mMy/Clz2GJlwv
   wrLKa3Izf9dzo/p/Ge2u5CafbHoLPo3RrE5cNP69aEOZuBY8hIoZxze34
   g==;
X-CSE-ConnectionGUID: TqlHVT7/RFCJz7OM75/b2Q==
X-CSE-MsgGUID: Qf1xZ9V2QoGNyIHoRC7DvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="73362645"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="73362645"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:16:45 -0800
X-CSE-ConnectionGUID: /2OnqvKsQHesmiwd+eA3+g==
X-CSE-MsgGUID: GfHdyixKQL6Pm4QO/tlb3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="203910374"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:16:44 -0800
Message-ID: <a320573f-e4b7-4fae-bd3e-4d4a6159967b@intel.com>
Date: Wed, 14 Jan 2026 13:16:43 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 06/34] PCI: Replace cxl_error_is_native() with
 pcie_aer_is_native()
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, alison.schofield@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-7-terry.bowman@amd.com>
 <20260114185523.000046b1@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114185523.000046b1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:55 AM, Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 12:20:27 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> The AER driver includes a CXL support function cxl_error_is_native(). This
>> function adds no additional value from pcie_aer_is_native().
>>
>> Simplify the codebase by removing cxl_error_is_native() and replace
>> occurrences of cxl_error_is_native() with pcie_aer_is_native().
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> Dave, if for any reason the rest gets delayed, nice if we can
> pick this one up anyway.

Needs an Ack from Bjorn one way or another.


