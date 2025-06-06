Return-Path: <linux-pci+bounces-29113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5107AD0916
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 22:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7A316906D
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 20:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8926E21B196;
	Fri,  6 Jun 2025 20:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AhdGzNHa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6242153ED;
	Fri,  6 Jun 2025 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749241819; cv=none; b=RFnfdYGQTC2CI1dnuBmQqyobI8+LznhGc7Ux5mhh4Ybp0gDUm+jATeFw6YvoFcwwZESXCW0FtGvQSrRhk9Vj21pWPu7Eo/QE7TkeDwCbtaA0oIE6Me5gOOuLxmv1GRxKF8RY397DGVnrxqRdWoKW9PpSMdPixFDx4naOX3g9FC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749241819; c=relaxed/simple;
	bh=9BNxksxWK2vMFzy4qfOBSxFnl8Y+JSZ8Hr5tlJXIV7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bFDtCQo5ehi0Xk8VtIoumjFzfi3tEPiqP5ZDAbw+SwARu4A0BLo/7uAMY90Lt3/qOqM185spgvLSAUAoRnNTzmX5fKCwf5nErw2eWeFNgi67MsaYpxKAz3L2ZTgcmEBzZtZelu3ukw663yWb2vdQ/nPS/ycZNa12W/ZacGyrsMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AhdGzNHa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749241818; x=1780777818;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=9BNxksxWK2vMFzy4qfOBSxFnl8Y+JSZ8Hr5tlJXIV7s=;
  b=AhdGzNHaqPoiAQZ6GAI74Gt/7zeTxnjML31vWX+97HUwMtdZFgBVaUAC
   kz+D4TY3axOUMsGGLEEKqV7w8QFwgkOcHTNqAMmV5Hpwq9QNBFpTtK/bs
   W9h4zUFLNjPT4XLjZbkm4W8MwwIQak2QyN4t9aA80GUHCqAQ70vk+aKut
   jPjUSWJQZQj8J+V+A62uRXE3t/nmENvPH7pYO7US38NE3csIU80q5GKJ3
   Jj5Y5aqPc21v4+EyJHFT1PWH9MEzUGNX7f/5tP1u75MT4/ALU2fYNiJUi
   BlFSo1bA4SSd8F9GyXT4yVzJtLFT//mSf0vrU+tGp+uzibN2w8UTd9510
   A==;
X-CSE-ConnectionGUID: 8qS7N8frQUid2DFMRzjz8Q==
X-CSE-MsgGUID: wHu2zNhaSsq30Rw58S9r8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="39036828"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="39036828"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 13:30:17 -0700
X-CSE-ConnectionGUID: TqXLZvvRQVu8Z2DbWDclJw==
X-CSE-MsgGUID: zPmIUBj+TYO9RPvUWlHRAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="150932447"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.111.33]) ([10.125.111.33])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 13:30:11 -0700
Message-ID: <e2d30ea5-1b9a-4e11-9065-3b30582de09a@intel.com>
Date: Fri, 6 Jun 2025 13:30:10 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/16] cxl/pci: Update __cxl_handle_cor_ras() to return
 early if no RAS errors
To: Terry Bowman <terry.bowman@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-12-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250603172239.159260-12-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/25 10:22 AM, Terry Bowman wrote:
> __cxl_handle_cor_ras() is missing logic to leave the function early in the
> case there is no RAS error. Update __cxl_handle_cor_ras() to exit early in
> the case there is no RAS errors detected after applying the mask.

This change is small enough that I would just fold it into the patch that introduces this function.

DJ

> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 0f4c07fd64a5..f5f87c2c3fd5 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -677,10 +677,11 @@ static void __cxl_handle_cor_ras(struct device *dev, u64 serial,
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(dev, serial, status);
> -	}
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> +		return;
> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +
> +	trace_cxl_aer_correctable_error(dev, serial, status);
>  }
>  
>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)


