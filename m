Return-Path: <linux-pci+bounces-44867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A877D21514
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 22:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 710CC3033D71
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4039035E55E;
	Wed, 14 Jan 2026 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVzf6B0c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8EC329E6A;
	Wed, 14 Jan 2026 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425801; cv=none; b=P/bKkiZPnKMYW6Z1yrsR0gV5UYlnlDtv8gOniHQoApBsZSIdNRlUTjSoLzk9ebczOLf+us8P9Ew5hDR97za15kLEpzxN0KYX0SqZLIdEJphv1pI8yP5IOj8KCHh3T0js/7usg3oYOq59inypjKZzV5J9oss/84nMsv1sJepgI6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425801; c=relaxed/simple;
	bh=MhS8t9ss4tv7spb/03IYQZv2yvsopqcBc/jzywCLIro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsK5KiyM4jemma1BynSr8gJW9nXciSuyyMx25M/bAEJMBx1RDSf+u1mhnYBld23dtESP7IBib9N3vEdUqsQHqwop0O0wh6jjWqpq78XcCj46UlEtvFUwSxPpwF60cIRfvRjHHyZr1X0JArRY++t4IjXVzwPmJ38ABLHI5B2IvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVzf6B0c; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768425800; x=1799961800;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MhS8t9ss4tv7spb/03IYQZv2yvsopqcBc/jzywCLIro=;
  b=XVzf6B0cilfo/Z2E54984gs3SJ7tSSPMeLj/Ro52W5YYhLrx33tPhwh4
   PTZPCtmn0MsmgrSvhKVBiLcDaJYMsyp26vf1QjhfwLhonFgFdFkaLJLSB
   2VAXhR/0ndwmvCONmr2nRplNHjTVijCWbxLPYKfa6KOs0FA11Qm7dznJJ
   QFda3io9w4XXfuvWGp/m1mUEuysxNFvz+gCycCe+aPqXl7dDoMVV04fOi
   l/ld44eDhnZPjjMZsQLyGJrPVxjGpZClDvUkz+dkPryoZmcx5NNeg/gGy
   plY31IZMENuyPmIX/i7foyBEPs3BZGI3yjIAbTCNbtn7h+JYJKZ+LSjZQ
   Q==;
X-CSE-ConnectionGUID: g6pOAINwQtupginKTqOCPA==
X-CSE-MsgGUID: ifj/WK44Qn+lbfIqHnZ9+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="80454382"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="80454382"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:23:19 -0800
X-CSE-ConnectionGUID: +kbHENDyTueF41UaCO/VXg==
X-CSE-MsgGUID: 9wuqGN1JT8OYP71eMzH+IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="204001202"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:23:18 -0800
Message-ID: <f0f6d666-cd79-42a2-ace3-41460a199fb3@intel.com>
Date: Wed, 14 Jan 2026 14:23:17 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 18/34] cxl/port: Remove "enumerate dports" helpers
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
 <20260114182055.46029-19-terry.bowman@amd.com>
 <20260114195048.00004526@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114195048.00004526@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 12:50 PM, Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 12:20:39 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> From: Dan Williams <dan.j.williams@intel.com>
>>
>> Now that cxl_switch_port_probe() no longer walks potential dports, because
>> they are enumerated dynamically on descendant endpoint arrival, remove the
>> dead code.
>>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Terry Bowman <terry.bowman@amd.com>
> 
> Patch description doesn't match patch. 

Looks like it's the clean up of this commit that's upstream.
Fixes: 3f5b8f7f34f6 ("cxl/port: Remove devm_cxl_port_enumerate_dports()")

> 
>>
>> ---
>>
>> Changes in v13 -> v14:
>> - New patch
>> ---
>>  drivers/cxl/core/pci.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index b838c59d7a3c..0305a421504e 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -71,6 +71,14 @@ struct cxl_dport *__devm_cxl_add_dport_by_dev(struct cxl_port *port,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_dport_by_dev, "CXL");
>>  
>> +struct cxl_walk_context {
>> +	struct pci_bus *bus;
>> +	struct cxl_port *port;
>> +	int type;
>> +	int error;
>> +	int count;
>> +};
>> +
>>  static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
>>  {
>>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> @@ -820,14 +828,6 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
>>  	return 0;
>>  }
>>  
>> -struct cxl_walk_context {
>> -	struct pci_bus *bus;
>> -	struct cxl_port *port;
>> -	int type;
>> -	int error;
>> -	int count;
>> -};
>> -
>>  static int count_dports(struct pci_dev *pdev, void *data)
>>  {
>>  	struct cxl_walk_context *ctx = data;
> 


