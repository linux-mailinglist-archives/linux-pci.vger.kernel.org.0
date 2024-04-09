Return-Path: <linux-pci+bounces-5966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C3F89E2ED
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 21:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48461C20B14
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 19:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC4E156F43;
	Tue,  9 Apr 2024 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7P4cNN8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222E415623E;
	Tue,  9 Apr 2024 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689693; cv=none; b=aWIL54ooH+Rh1C4fh/HH7fFpp5wvoXTnGF1XsSSFzSw4FNjdLQR/BYECFC7n7DejBjHLDAoCP3ffT+CUwMKNoOYxmSKjV3y0Q72KbfO44wqUJY9nN9EaoYJqa4WCXEUsL89Dh8cnt1oe/SjIf/eHev0hXIhhbFZlGokYwqtYcqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689693; c=relaxed/simple;
	bh=yEJbl9oyBunO2YVwvMLkxlAZCzhbL8O4ABgqpXSaO9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYRsc2W2PyKgqKbYxm7SSPma+hF0jnkgQISlxJb5ssOPClU0EGM1FiPlDQylkRiFs8GwBjX3hBDFXLz7s96oqZ3+MJYic7jYs57Yutr44JKPfEA/OknLPBvlpDIVWQ2L8oLRwKHMU6ln/JrmDaFS26DMOZuAlKVbIBq3+uYTi2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7P4cNN8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712689691; x=1744225691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yEJbl9oyBunO2YVwvMLkxlAZCzhbL8O4ABgqpXSaO9Y=;
  b=G7P4cNN88KxehsRXraZnEMlsBjMyIUJ50/701QefUzrYgPTpHdryRUMc
   /u1zvKgqfDXyTQ0Htbx7lfkcwGuZ3D1819lClQRunHzA4XPbAvmTHOCgi
   HyS2siXaIr/eJjMiBjv3gIuR2armaf46+XOrmnjfTXH7+JXb00wizBxM6
   3TP4+Ukb2xTUDuA7MbkxGtTIXPeL/CZdJUtskwh6pfHgyYCKS41S45IVG
   nl72w+ByUgwlp0nO4znOYdMhzw5YmcPTyrghHMGMpCVgpd2342CvNxVID
   3ZITJ3j1y4PQBwsbiI3Yce3YUqpfD6O3vrrKULUw707jjJZlswV8BRwwQ
   g==;
X-CSE-ConnectionGUID: yJfX66uOTfiWg7hS9dI0pQ==
X-CSE-MsgGUID: tcLeEQHjRf+7xWCTbixIcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7880372"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7880372"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 12:08:08 -0700
X-CSE-ConnectionGUID: 7zSpGlQDS/u4gk38YuWJrw==
X-CSE-MsgGUID: NFeynZ0USHSBUdPvPeoROQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20791070"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.183.123]) ([10.213.183.123])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 12:08:08 -0700
Message-ID: <84c52acf-54af-4370-983d-e03c92564774@intel.com>
Date: Tue, 9 Apr 2024 12:08:07 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] cxl: Add rcd_regs to cxl_rcrb_info
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
 kobayashi.da-06@jp.fujitsu.com, linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com, linux-pci@vger.kernel.org, mj@ucw.cz,
 dan.j.williams@intel.com
References: <20240409073528.13214-1-kobayashi.da-06@fujitsu.com>
 <20240409073528.13214-2-kobayashi.da-06@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240409073528.13214-2-kobayashi.da-06@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/24 12:35 AM, Kobayashi,Daisuke wrote:
> Add rcd regs to cxl_rcrb_info to cache the RCD register values.

I suggest you squash this patch with 2/3. There's not much meaning of adding variables without showing usage.

> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> ---
>  drivers/cxl/cxl.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 003feebab79b..2dc827c301a1 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -647,6 +647,9 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>  struct cxl_rcrb_info {
>  	resource_size_t base;
>  	u16 aer_cap;
> +	u16 rcd_lnkctrl;
> +	u16 rcd_lnkstatus;
> +	u32 rcd_lnkcap;
>  };
>  
>  /**

