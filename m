Return-Path: <linux-pci+bounces-7269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0577D8C05CE
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 22:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8502B1F20F06
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 20:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD38B130E24;
	Wed,  8 May 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViV+Jdut"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA7612E1F2;
	Wed,  8 May 2024 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200915; cv=none; b=pS3GPnYqXHsHJNEj8vZxeHnvJtvad4mnXItj+KgKxTP1+CreAjBZeqHoYXCLXVXQafQO+LjilRFV5WMvKmrrDUcqvOdQS+pktkZkljORgV3av27Zn+8dTGp6lFnMjjuaQESwEqV5kb+JslljTEf3wok17VSQSf4/UfRK0bmRAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200915; c=relaxed/simple;
	bh=USi/Hrk4lswhIdj/m3eWcABm1DsMPgb/VAZBlW6YQqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8pR/T1uyDi7dCgyRUpYsWQftCRV0NSsrOs4gimb46kNmCHyiDqFf3QcUXCComP897VNtOJbsSASJacZ4kinhgzGrgc8zGgjRVosGR6czadb63nTH3AFrmFmDLScJ7H8zwT1SwHrLyZDyZh+e/BuDLCx5CtzGN1H1oeb0SRSOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViV+Jdut; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715200914; x=1746736914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=USi/Hrk4lswhIdj/m3eWcABm1DsMPgb/VAZBlW6YQqc=;
  b=ViV+JdutyXYmrDqhrh/uBm/nIFJ1MjseZCdHsZCq+qGgtSrYOAG//aKK
   y14AxkjTbrXVtLPYwzS46Pv+Qrz3OPhIu3TaZu2TvHn5J/brH6da0d2Aa
   2zQNvlcmG38Th6dhdjGAhuSG5QrX8zFpxC6pua+Rn51JFLcf7tQ/ARa5n
   HgMY6sdj264z2NZVcEoev4bYLK+HCPwJ54F/yLlyIln4YfQ4qOg5w8OPu
   hjbhzJfVJL/yo/qviZOaTMJFGIg6rEZkrIsUlxbYj2hePNxea1VTgr7zh
   EuIcRPBHkUvdP2wFS7As3X2rMFYJeSY6nBoCm9xdkao2cONDntkVfFiy5
   w==;
X-CSE-ConnectionGUID: v1P09qWmTdSDrQ+24yNIQQ==
X-CSE-MsgGUID: PVchHRpbSxuyWwzDrhFVfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14037173"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="14037173"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 13:41:54 -0700
X-CSE-ConnectionGUID: hTiUB2NmRwCV8sjpVkh8xQ==
X-CSE-MsgGUID: Yd9MhfAsS+a9hbsrZrrK1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="33526297"
Received: from jdoman-desk1.amr.corp.intel.com (HELO [10.124.222.255]) ([10.124.222.255])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 13:41:53 -0700
Message-ID: <42444c18-0e67-4c7c-b11c-2b50200b7825@linux.intel.com>
Date: Wed, 8 May 2024 13:41:52 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI/EDR: Align EDR implementation with PCI firmware
 r3.3 spec
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Thatchanamurthy Satish <Satish.Thatchanamurt@dell.com>
References: <20240508201430.GA1785648@bhelgaas>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240508201430.GA1785648@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/8/24 1:14 PM, Bjorn Helgaas wrote:
> On Wed, May 01, 2024 at 02:25:43AM +0000, Kuppuswamy Sathyanarayanan wrote:
>> During the Error Disconnect Recover (EDR) spec transition from r3.2 ECN
>> to PCI firmware spec r3.3, improvements were made to definitions of
>> EDR_PORT_DPC_ENABLE_DSM (0x0C) and EDR_PORT_LOCATE_DSM(0x0D) _DSMs.
>>
>> Specifically,
>>
>> * EDR_PORT_DPC_ENABLE_DSM _DSM version changed from 5 to 6, and
>>   arg4 is now a package type instead of an integer in version 5.
>> * EDR_PORT_LOCATE_DSM _DSM uses BIT(31) to return the status of the
>>   operation.
>>
>> Ensure _DSM implementation aligns with PCI firmware r3.3 spec
>> recommendation. More details about the EDR_PORT_DPC_ENABLE_DSM and
>> EDR_PORT_LOCATE_DSM _DSMs can be found in PCI firmware specification,
>> r3.3, sec 4.6.12 and sec 4.6.13.
>>
>> While at it, fix a typo in EDR_PORT_LOCATE_DSM comments.
>>
>> Fixes: ac1c8e35a326 ("PCI/DPC: Add Error Disconnect Recover (EDR) support")
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> I split this into two patches and applied them to pci/edr for v6.10,
> thanks!
>
> Take a look here:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=edr
> and make sure I didn't mess it up (only differences are comments and
> commit logs).
>

Thanks for doing it. It looks good to me.

>> ---
>>  drivers/pci/pcie/edr.c | 23 +++++++++++++++++------
>>  1 file changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
>> index 5f4914d313a1..fea098e22e3e 100644
>> --- a/drivers/pci/pcie/edr.c
>> +++ b/drivers/pci/pcie/edr.c
>> @@ -35,7 +35,7 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
>>  	 * Behavior when calling unsupported _DSM functions is undefined,
>>  	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
>>  	 */
>> -	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> +	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 6,
>>  			    1ULL << EDR_PORT_DPC_ENABLE_DSM))
>>  		return 0;
>>  
>> @@ -47,11 +47,11 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
>>  	argv4.package.elements = &req;
>>  
>>  	/*
>> -	 * Per Downstream Port Containment Related Enhancements ECN to PCI
>> -	 * Firmware Specification r3.2, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
>> -	 * optional.  Return success if it's not implemented.
>> +	 * Per PCI Firmware Specification r3.3, sec 4.6.12,
>> +	 * EDR_PORT_DPC_ENABLE_DSM is optional. Return success if it's not
>> +	 * implemented.
>>  	 */
>> -	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>> +	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 6,
>>  				EDR_PORT_DPC_ENABLE_DSM, &argv4);
>>  	if (!obj)
>>  		return 0;
>> @@ -86,7 +86,7 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
>>  
>>  	/*
>>  	 * Behavior when calling unsupported _DSM functions is undefined,
>> -	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
>> +	 * so check whether EDR_PORT_LOCATE_DSM is supported.
>>  	 */
>>  	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
>>  			    1ULL << EDR_PORT_LOCATE_DSM))
>> @@ -103,6 +103,17 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
>>  		return NULL;
>>  	}
>>  
>> +	/*
>> +	 * Per PCI Firmware Specification r3.3, sec 4.6.13, bit 31 represents
>> +	 * the success/failure of the operation. If bit 31 is set, the operation
>> +	 * is failed.
>> +	 */
>> +	if (obj->integer.value & BIT(31)) {
>> +		ACPI_FREE(obj);
>> +		pci_err(pdev, "Locate Port _DSM failed\n");
>> +		return NULL;
>> +	}
>> +
>>  	/*
>>  	 * Firmware returns DPC port BDF details in following format:
>>  	 *	15:8 = bus
>> -- 
>> 2.25.1
>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


