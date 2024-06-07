Return-Path: <linux-pci+bounces-8464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E8E900A19
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 18:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F791F295CA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 16:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6352A19AA49;
	Fri,  7 Jun 2024 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRBQz89/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766EB19A29C;
	Fri,  7 Jun 2024 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776755; cv=none; b=XrtssHqR3kJKYGd2SNkKyeWI/hugmpYiK1p38Z3s/5utgWzlZwmhcOLEuI/oZSgr2PnGGkYNKV1V/giXVkVJZiCRVE0zQFJMXg7EQsvOo/0y6RNNniPtloOaIurrM08YGeS4B6idDFDlAz8T5eCOtk9SHi0A8CPRFDV9kHAO4Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776755; c=relaxed/simple;
	bh=1apQS5QX6CG41xVsIn6G2GB9QRmPru8LkSC5FPl+x5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXGBIaDIqpf4975PdWJIYjGTP1+KhHFm67xF2iw0xrYIq6Jmmjr+yQPQC0F44v5nq7viBAS1wWJ+T6JvmB4J7LInxvHSlVOffGgnwlh/PxXB8F9EN02H+BjECnPNHbmyzr8yvLYSc4Udsoxvs9GfWRFHYS6LRKf8CjWn5xGJAU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRBQz89/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717776753; x=1749312753;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1apQS5QX6CG41xVsIn6G2GB9QRmPru8LkSC5FPl+x5c=;
  b=kRBQz89/Wf1fMyFvYX69zCv+Stn5nUUNnwuHEboYshD9KzKKgo5CrmUq
   dn3iiXpPiZxHnhteK0z0oVin+fqBr6Jzm8UxipJ50A6Dlz6OezZ7zdjt+
   gMtKNRY97y3jD6Dn3mhTSOuVHVpBHOfPuHXzIDaN4rrQXFVarca/gs7+9
   xSWbSZojTNTDtULEeHGShpBl2MMoGmjCUAfJI7P23PN2xZ9JhEVcnpHmA
   GTwPK5HLRBrY/+u4PKVgBCBZRDkwR+DDvBtcsnv6VcXU/p7S4sbLb3r1O
   /hxgrWW0/Np85pHFU0fbKt2giVkbpq6ecK+bfu5RJmGHiuQIQWf0rZVO8
   g==;
X-CSE-ConnectionGUID: 8ICpMyD+TYuzVpyPRz+wOQ==
X-CSE-MsgGUID: b9fXgrBkRtquQyjaqcAdSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="18359012"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="18359012"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 09:12:33 -0700
X-CSE-ConnectionGUID: K67IVxukSha2EP0YOKc4tA==
X-CSE-MsgGUID: KqCD/xPnTQWNEo5cTTBCxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38297044"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.239]) ([10.125.109.239])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 09:12:32 -0700
Message-ID: <92744829-dbb8-4681-914d-c36797518e3c@intel.com>
Date: Fri, 7 Jun 2024 09:12:31 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cxl: Calculate region bandwidth of targets with
 shared upstream link
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, dave@stgolabs.net
References: <20240529214357.1193417-1-dave.jiang@intel.com>
 <20240529214357.1193417-3-dave.jiang@intel.com>
 <20240605151936.000031df@Huawei.com>
 <c5e2b730-8274-48d0-9553-4c1b8cf4945a@intel.com>
 <20240607153042.000046c9@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240607153042.000046c9@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/7/24 7:30 AM, Jonathan Cameron wrote:
> 
>>>> +		if (is_cxl_root(parent_port)) {
>>>> +			ctx->port = parent_port;
>>>> +			cxl_coordinates_combine(ctx->coord, ctx->coord,
>>>> +						dport->coord);  
>>>
>>> I'm a bit lost in all the levels of iteration so may have missed it.
>>>
>>> Do we assume that GP BW (which is the root bridge) is shared across multiple root
>>> ports on that host bridge if they are both part of the interleave set?  
>>
>> Do we need to count the number of RPs under a HB and do min(aggregated_RPs_BW, (GP_BW / no of RPs) * affiliated_RPs_in_region)?
> 
> I'm not 100% sure I understand the question.
> 
> Taking this again and expanding it another level.
> 
> 
> 
>       Host CPU
> ______________________________________
>         |                           |
>         |                           |
>         | 3 from GP/HMAT            | 3 from GP/HMAT
>    _____|_____               _______|______
>   RP         RP             RP            RP
>   2|          |2           2|             |2
>  __|__     ___|__         __|___        __|____
> |1    |1  1|     |1      |1     |1     |1      |1
> EP   EP    EP    EP     EP     EP      EP     EP
> 
> Then your maths
> 
> aggregated RPs BW is 8
> (GP_BW/no of RPS) * affliated RPS in region.
> = (3/2 * 4)
> = 6

While the result is the same, the math would be this below right?
min((3/2 * 2), 4) + min((3/2 * 2), 4)

> Which is correct. So yes, I think that works if we assume everything is balanced.
> I'm fine with that assumption as that should be the common case.
> 
> 
> Jonathan
> 
> 

