Return-Path: <linux-pci+bounces-28913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B23ACCEC5
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 23:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F133A507D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 21:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2AB225768;
	Tue,  3 Jun 2025 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Da0IuDH5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B18F4A23;
	Tue,  3 Jun 2025 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985302; cv=none; b=k/s2vmZa6h9cJPeB1sxqybIt7XXph6TeVtDUG+JBzXOBJRzBgYW9kaNNo8q4P9KJEQB1/hNMPB4pUbDM8LgOPol1xVD8JnSK0BgveUNsH6e0FOswzSzIeIFEM8see/G4Ig+YH980ojulNmtLkz6IfL5FkCHmTZKhpqFsQIGftEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985302; c=relaxed/simple;
	bh=+8XUA1Yj3EXGtJ0QJw8cNrvcC7jxpUxiyf5VO6aExHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJDIbREkBSr4he+mLiSz/PGTPqmHxMczzv6uTbGhsKx16EBvWxiMtWVu6IdFAPB9jSGlFfViFcisIx1UgLndQQGvx9+b9pHvHLr3AXdOpziRTUliE2yOhApbvJYZrlJmssNX8fmyiTCupCNTbUnewrvLp3iv57P181JWqzMk4t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Da0IuDH5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748985300; x=1780521300;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+8XUA1Yj3EXGtJ0QJw8cNrvcC7jxpUxiyf5VO6aExHY=;
  b=Da0IuDH5JvnQTQTL6s8DA92q2cScevlZZP3wQ7dLjsjcN/63kzCwKzvN
   ii2f1rEdLQAfotM8QWgJ5R/66DaeLUNgbT0SYWvKwhXlujJySILZk5Uka
   LMQR73ltt5BsZKh6GmMoF8fzzXwE7R28pvBePYzTWUwMdL0jG3JSUKCWc
   x4u8toPaTL1sNiAgg0ePeivo9Kdb1SVwoRhhhN2lHtRUQ3x/3ZRvAjEQx
   0ZXREjvYUXeZW9XqscqUv9GWGKnf5zXxLrdnAb4p5sqKgVp0aju+jwOy3
   l1WAtwQWOIiQwVwq1G2QUGwf3cDfu19hPE4DtFaMleZvKEU3yEixoDv/R
   g==;
X-CSE-ConnectionGUID: dW95g0ArRMqqlhsMHqoedg==
X-CSE-MsgGUID: VhBs7zIrTI69beat2+V5wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62401768"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="62401768"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 14:14:59 -0700
X-CSE-ConnectionGUID: hpPJib8GR+u14TohnCFh2Q==
X-CSE-MsgGUID: 6cFTCHi2Qb2p+BeJdAgY3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="145927047"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.110.198]) ([10.125.110.198])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 14:14:58 -0700
Message-ID: <d74249cf-e3e3-4e5c-a086-26e5a91750c7@intel.com>
Date: Tue, 3 Jun 2025 14:14:56 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4 v3] ACPI: extlog: Trace CPER Non-standard Section Body
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-edac@vger.kernel.org
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
References: <20250603155536.577493-1-fabio.m.de.francesco@linux.intel.com>
 <20250603155536.577493-2-fabio.m.de.francesco@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250603155536.577493-2-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/25 8:54 AM, Fabio M. De Francesco wrote:
> ghes_do_proc() has a catch-all for unknown or unhandled CPER formats
> (UEFI v2.10 Appendix N 2.3), extlog_print() does not. This gap was
> noticed by a RAS test that injected CXL protocol errors which were
> notified to extlog_print() via the IOMCA (I/O Machine Check
> Architecture) mechanism. Bring parity to the extlog_print() path by
> including a similar log_non_standard_event().
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/acpi_extlog.c | 6 ++++++
>  drivers/ras/ras.c          | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index f6b9562779de0..47d11cb5c9120 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -183,6 +183,12 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  			if (gdata->error_data_length >= sizeof(*mem))
>  				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
>  						       (u8)gdata->error_severity);
> +		} else {
> +			void *err = acpi_hest_get_payload(gdata);
> +
> +			log_non_standard_event(sec_type, fru_id, fru_text,
> +					       gdata->error_severity, err,
> +					       gdata->error_data_length);
>  		}
>  	}
>  
> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
> index a6e4792a1b2e9..ac0e132ccc3eb 100644
> --- a/drivers/ras/ras.c
> +++ b/drivers/ras/ras.c
> @@ -51,6 +51,7 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
>  {
>  	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
>  }
> +EXPORT_SYMBOL_GPL(log_non_standard_event);
>  
>  void log_arm_hw_error(struct cper_sec_proc_arm *err)
>  {


