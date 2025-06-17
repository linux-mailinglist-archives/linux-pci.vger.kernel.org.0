Return-Path: <linux-pci+bounces-29945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A0CADD569
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 18:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C4240015A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F782EA17A;
	Tue, 17 Jun 2025 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iadDBGZU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C5521018A;
	Tue, 17 Jun 2025 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176512; cv=none; b=r4rDV00cXjZbUfqXp3hUhbYPngeyAElVVe4M59sK2NRMY9SpSgHQTI+S1TJCDx1J3SO3g4rdDebPdUVd2NcLAHBWn1/P1MyY7trE+LNyf4SocxqH+zC0MeZmijwpYufQpR1VfNyCQxyMVUUrtzsb1sbYXMzg7Iw5vtmC/j7B2M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176512; c=relaxed/simple;
	bh=PGfPZ4jTLlzp0soWT5Kna5ae2Q1pKDI1WP51XvYIZbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pq2q9FMBgnL/hKP/MX1ds/sAwNt1xnsirAs/XS/Hbd7NkKXVjouy2KEQx4JjkOaOR+C8eteZ18Byg3VERAvbipixVi1XDxarFwxmZN8eFtgZbFVBXB4SE4Tj6WGVd6vax26jvSn6ZChHUHCPMOKm521OcGdYJHCkEdXoYpexQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iadDBGZU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750176510; x=1781712510;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PGfPZ4jTLlzp0soWT5Kna5ae2Q1pKDI1WP51XvYIZbU=;
  b=iadDBGZUehfDV2868ELiM0neA4sDUJgg16LKXZdC7ItwoFhl1xhuoHuT
   0huLdI5+n4/gQ95R57BSubiO0nO2BvD4mg4MM6e0qrak67Evp5FpkVB46
   mOSvWKtkoNeAprqFMKC2i6NbQIM5BcoUwN1Bo6kHI4GmmX+oH54zj8J1z
   WLjp9/BmpHdJSehWFSjHmqy8iMrvonlxAmHUwA3aHAs1Ps1XTYwugJ6VN
   lX1m5YJJL7LHqB6qhwg4P8qGQWu/dYEV+7RMHgy5RxqeUpd2LLFved6Lm
   crchDJXrszuMjZy57IuX5aAEgRqr1zGd7u6yKYGQCpnvDjJha1b7zIpNY
   A==;
X-CSE-ConnectionGUID: a+7vuGvyRJOcrMuf1kUm6Q==
X-CSE-MsgGUID: sH9E2Ra4SN+BZSckzE5A4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63018515"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="63018515"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 09:08:29 -0700
X-CSE-ConnectionGUID: IxbxU0ZNQ1aN1ZpkTN73XQ==
X-CSE-MsgGUID: 02+xtRrdS46bfBcK2NodMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="153773404"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.108.59]) ([10.125.108.59])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 09:08:28 -0700
Message-ID: <79e86754-710a-4335-8a09-a756201f7ae4@intel.com>
Date: Tue, 17 Jun 2025 09:08:27 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
To: Lukas Wunner <lukas@wunner.de>, "Bowman, Terry" <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 rrichter@amd.com, peterz@infradead.org,
 fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-5-terry.bowman@amd.com> <aEexYj8uImRt0kr9@wunner.de>
 <aad4372e-d73b-47f9-9736-31dc1e6e03b0@amd.com>
 <a602603b-e075-46a1-a4bf-3653954faa08@amd.com> <aEkIXiM3jaCvKw3o@wunner.de>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aEkIXiM3jaCvKw3o@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/10/25 9:38 PM, Lukas Wunner wrote:
> On Tue, Jun 10, 2025 at 04:20:53PM -0500, Bowman, Terry wrote:
>> On 6/10/2025 1:07 PM, Bowman, Terry wrote:
>>> On 6/9/2025 11:15 PM, Lukas Wunner wrote:
>>>> On Tue, Jun 03, 2025 at 12:22:27PM -0500, Terry Bowman wrote:
>>>>> --- a/drivers/cxl/core/ras.c
>>>>> +++ b/drivers/cxl/core/ras.c
>>>>> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>>>>> +{
>>>>> +	struct cxl_prot_error_info *err_info = data;
>>>>> +	struct pci_dev *pdev_ref __free(pci_dev_put) = pci_dev_get(pdev);
>>>>> +	struct cxl_dev_state *cxlds;
>>>>> +
>>>>> +	/*
>>>>> +	 * The capability, status, and control fields in Device 0,
>>>>> +	 * Function 0 DVSEC control the CXL functionality of the
>>>>> +	 * entire device (CXL 3.0, 8.1.3).
>>>>> +	 */
>>>>> +	if (pdev->devfn != PCI_DEVFN(0, 0))
>>>>> +		return 0;
>>>>> +
>>>>> +	/*
>>>>> +	 * CXL Memory Devices must have the 502h class code set (CXL
>>>>> +	 * 3.0, 8.1.12.1).
>>>>> +	 */
>>>>> +	if ((pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
>>>>> +		return 0;
>>>>> +
>>>>> +	if (!is_cxl_memdev(&pdev->dev) || !pdev->dev.driver)
>>>>> +		return 0;
>>>>
>>>> Is the point of the "!pdev->dev.driver" check to ascertain that
>>>> pdev is bound to cxl_pci_driver?
>>>>
>>>> If so, you need to check "if (pdev->driver != &cxl_pci_driver)"
>>>> directly (like cxl_handle_cper_event() does).
>>>>
>>>> That's because there are drivers which may bind to *any* PCI device,
>>>> e.g. vfio_pci_driver.
>>
>> Looking closer to implement this change I find the cxl_pci_driver is
>> defined static in cxl/pci.c and is unavailable to reference in
>> cxl/core/ras.c as-is. Would you like me to export cxl_pci_driver to
>> make available for this check?
> 
> I'm not sure you need an export.  The consumer you're introducing
> is located in core/ras.c, which is always built-in, never modular,
> hence just making it non-static and adding a declaration to cxlpci.h
> may be sufficient.
> 
> An alternative would be to keep it static, but add a non-static helper
> cxl_pci_drv_bound() or something like that.
> 
> I'm passing the buck to CXL maintainers for this. :)

I don't have a good solution to this. Moving the declaration of cxl_pci driver to core would be pretty messy. Perhaps doing the dance of calling try_module_get() is less messy? Or maybe Dan has a better idea....

DJ

> 
>> The existing class code check guarantees it is a CXL EP. Is it not
>> safe to expect it is bound to a the CXL driver?
> 
> Just checking for the pci_dev being bound seems insufficient to me
> because of the vfio_pci_driver case and potentially others.
> 
> HTH,
> 
> Lukas
> 


