Return-Path: <linux-pci+bounces-33567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD709B1DB81
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 18:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E0A625D31
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6B72676F4;
	Thu,  7 Aug 2025 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TaQDW1X1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0781E5B73;
	Thu,  7 Aug 2025 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583449; cv=none; b=MbL/MTzFVX9z94PbMBUc7FYjl+K9GAcT0w5vW5hUEZFAPA+NA7RG7iMepTWD3IJuXCM4TerDXi88LPeH5lZEzbfREu9+JhMIW4sArYwl7BZF0gl8B4uYRJCEO7lR4BdRV8e1+F2TDdZffwEJtqZ9U0rRDU1nxJAcMxvRBx7IFtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583449; c=relaxed/simple;
	bh=KXJ0W+Rq8+ZxkmoRIeTdA/TynKxtfU0rBAxR7DcWJ/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBSLlZ4FnDL7ttVugY7OKhQEh9H2GQUqwtpv8edkKd3pTEU2k6377iSO8mVOdkmPNEQy0smJSzqtq+hYBQAcvNdT06nCnO/cppnZ/SWF9/U5TGW4xXSgddU11A8VYwDFdJBIOy0Z7OB9oO60VuwaurxdhHluCf53LP7w5eQApvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TaQDW1X1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754583447; x=1786119447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KXJ0W+Rq8+ZxkmoRIeTdA/TynKxtfU0rBAxR7DcWJ/U=;
  b=TaQDW1X1gMNS30U9folm0N/JHhzk2uetBLKsIrYWsBHrQ9uxQy2tO0rv
   b6iBcaj643ko+1ME6uWITsDmIJoYNcGUknlft8RZ5EiMAi7z9ctQbog7J
   axnDYh7/fGDVHK6gpm94D/mzGpVI/739V14KUHuShg+L7xcRL7QwPVdBl
   2TAdAhqQtVE3b3HmfnjtI46Zw4IJbrO62tfUPQTwQjHG4xUG8b2JE706u
   b8JOTFwhFHdKuyX/Xe43VxqYlB6e5stLIU4DVpSGcQR0jLKfMyMegHKVO
   hWD2c60/AqWupyQZke+nYCPxRZj4STNBnU2F+UJaOgaUdHxx0nC2cmuPX
   Q==;
X-CSE-ConnectionGUID: XziIi5xHR/euVGMjSk03ww==
X-CSE-MsgGUID: Bk/y86h+Sye/+QrQ/Sta9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="55961731"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="55961731"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 09:17:26 -0700
X-CSE-ConnectionGUID: 8mkpCRJiRXydb7NU38x8CA==
X-CSE-MsgGUID: OhVh0fWGS5KxXNRWyyZs+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="169230907"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 09:17:26 -0700
Received: from [10.124.220.198] (unknown [10.124.220.198])
	by linux.intel.com (Postfix) with ESMTP id 928B720B571C;
	Thu,  7 Aug 2025 09:17:24 -0700 (PDT)
Message-ID: <64741634-6e61-48eb-84f3-2e8da6aea2b7@linux.intel.com>
Date: Thu, 7 Aug 2025 09:17:24 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] powerpc/eeh: Use result of error_detected() in
 uevent
To: Niklas Schnelle <schnelle@linux.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Linas Vepstas <linasvepstas@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Oliver O'Halloran
 <oohall@gmail.com>, Sinan Kaya <okaya@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20250807-add_err_uevents-v5-0-adf85b0620b0@linux.ibm.com>
 <20250807-add_err_uevents-v5-3-adf85b0620b0@linux.ibm.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250807-add_err_uevents-v5-3-adf85b0620b0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/7/25 6:55 AM, Niklas Schnelle wrote:
> Ever since uevent support was added for AER and EEH with commit
> 856e1eb9bdd4 ("PCI/AER: Add uevents in AER and EEH error/resume"), it
> reported PCI_ERS_RESULT_NONE as uevent when recovery begins.
>
> Commit 7b42d97e99d3 ("PCI/ERR: Always report current recovery status for
> udev") subsequently amended AER to report the actual return value of
> error_detected().
>
> Make the same change to EEH to align it with AER and s390.
>
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Link: https://lore.kernel.org/linux-pci/aIp6LiKJor9KLVpv@wunner.de/
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   arch/powerpc/kernel/eeh_driver.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 7efe04c68f0fe3fb1c3c13d97d58e79e47cf103b..20ed9685da8b7e6d419a4b02f715b52acfe715d3 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -334,7 +334,7 @@ static enum pci_ers_result eeh_report_error(struct eeh_dev *edev,
>   	rc = driver->err_handler->error_detected(pdev, pci_channel_io_frozen);
>   
>   	edev->in_error = true;
> -	pci_uevent_ers(pdev, PCI_ERS_RESULT_NONE);
> +	pci_uevent_ers(pdev, rc);
>   	return rc;
>   }
>   
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


