Return-Path: <linux-pci+bounces-9387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC4491AE93
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 19:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF30D1C20829
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 17:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5862513F441;
	Thu, 27 Jun 2024 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjPjtTtx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BDB18645;
	Thu, 27 Jun 2024 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510816; cv=none; b=uQ1M2FYn26604rPrz10iYWResSD0RG326Viss8G2++HaA1Iudyl+upjRoicyvKvBV0/YhOJum3dPcpHqTwS8IUrZfU62Sdc1DxIInsIQY2F0MtgdzB3D9H/AoRUKw6lJmZ4AOhvYmOFcWEksygmy3H85ti235E3zBhmUkUFzEEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510816; c=relaxed/simple;
	bh=zR/DvixaFDlAESFnfJVYO12k6N/AVnfp7kdRgzhkGAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhqKwFj/zHqnKl5WfnaCIr+sjQNRwi2WTVH24D5IfPmDJdRy0lxKvijpwV4EoOi82kfGyVU7KcqL2Q/EVpIHzicN7DxM1jpImmpAzwwHrn8ZswXwe04MN9lxpt6qD+doQBCaFveiv3g6+N2QAyGVijljVNdMKGA5zo8EeW++u3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjPjtTtx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719510815; x=1751046815;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zR/DvixaFDlAESFnfJVYO12k6N/AVnfp7kdRgzhkGAA=;
  b=fjPjtTtxsCsYOlA3irkMTx25p5408nDA/bfkxEyInp4vbwnqZiac4tn9
   y5gYJ0MP41/iNF5zuDa7eON9FXEETIbuIAa10H+dEUt8jbMkv6fnCftVP
   oQneQcRevTLCcT9brMJXjNY/ZM+WDY7T8HgDmIHTJqWpuugpkIgcBfC7U
   xQwKCbNtzVBHtMovrIMZfIrZI8zNsuzHnSiufBCZzlZaFML//XDn6PWmx
   W6DYTV6bLs5vzKNG24My5d+3IsXUmblN4xpfpcmsMCkyZukTXrR8oiF3Y
   ouSROMDpFmanZNOdjP9mO3hZrSWEWtnO5IpF5pR01ql7xFh8zfTIp/Aqi
   w==;
X-CSE-ConnectionGUID: FN6Hy3srRXuQMtAo8PZsCA==
X-CSE-MsgGUID: uFEWNkfPTqOExAAOEpli3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20423928"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="20423928"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 10:53:34 -0700
X-CSE-ConnectionGUID: Yq+Sxb2XROudERi7TdRWpw==
X-CSE-MsgGUID: TIq0IGmsTQaJ2ikmVlsROA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="49427989"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.110.45]) ([10.125.110.45])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 10:53:34 -0700
Message-ID: <da7d82d8-5fbd-4042-84be-16b520add8da@intel.com>
Date: Thu, 27 Jun 2024 10:53:32 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] cxl: Preserve the CDAT access_coordinate for an
 endpoint
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
References: <20240618231730.2533819-1-dave.jiang@intel.com>
 <20240618231730.2533819-2-dave.jiang@intel.com>
 <667d77ee16b31_2ccbfb2949@iweiny-mobl.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <667d77ee16b31_2ccbfb2949@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/27/24 7:32 AM, Ira Weiny wrote:
> Dave Jiang wrote:
>> Keep the access_coordinate from the CDAT tables for region perf
>> calculations. The region perf calculation requires all participating
>> endpoints to have arrived in order to determine if there are limitations
>> of bandwidth data due to shared uplink.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/core/cdat.c | 10 ++++++----
>>  drivers/cxl/cxlmem.h    |  1 +
>>  2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index bb83867d9fec..fea214340d4b 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -15,7 +15,7 @@ struct dsmas_entry {
>>  	struct range dpa_range;
>>  	u8 handle;
>>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>> -
>> +	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
>>  	int entries;
>>  	int qos_class;
>>  };
>> @@ -163,7 +163,7 @@ static int cdat_dslbis_handler(union acpi_subtable_headers *header, void *arg,
>>  	val = cdat_normalize(le16_to_cpu(le_val), le64_to_cpu(le_base),
>>  			     dslbis->data_type);
>>  
>> -	cxl_access_coordinate_set(dent->coord, dslbis->data_type, val);
>> +	cxl_access_coordinate_set(dent->cdat_coord, dslbis->data_type, val);
>>  
>>  	return 0;
>>  }
>> @@ -220,7 +220,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>>  	xa_for_each(dsmas_xa, index, dent) {
>>  		int qos_class;
>>  
>> -		cxl_coordinates_combine(dent->coord, dent->coord, ep_c);
>> +		cxl_coordinates_combine(dent->coord, dent->cdat_coord, ep_c);
>>  		dent->entries = 1;
>>  		rc = cxl_root->ops->qos_class(cxl_root,
>>  					      &dent->coord[ACCESS_COORDINATE_CPU],
>> @@ -241,8 +241,10 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>>  static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
>>  			      struct cxl_dpa_perf *dpa_perf)
>>  {
>> -	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++)
>> +	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>>  		dpa_perf->coord[i] = dent->coord[i];
>> +		dpa_perf->cdat_coord[i] = dent->cdat_coord[i];
>> +	}
>>  	dpa_perf->dpa_range = dent->dpa_range;
>>  	dpa_perf->qos_class = dent->qos_class;
>>  	dev_dbg(dev,
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 19aba81cdf13..fb365453f996 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -402,6 +402,7 @@ enum cxl_devtype {
>>  struct cxl_dpa_perf {
>>  	struct range dpa_range;
>>  	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>> +	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
> 
> Need to update the kdoc.

Will update.

> 
> Other than that.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Thanks!
> 
>>  	int qos_class;
>>  };
>>  
>> -- 
>> 2.45.1
>>
> 
> 

