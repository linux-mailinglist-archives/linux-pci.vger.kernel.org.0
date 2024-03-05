Return-Path: <linux-pci+bounces-4487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB73487135C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 03:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CEB1C20ED1
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 02:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B233518B1B;
	Tue,  5 Mar 2024 02:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AcRR3ivT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFD118AE0;
	Tue,  5 Mar 2024 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604567; cv=none; b=EtqMFK0jlCAp3X5lgCQxZDcRIPN9654zCARBW4Xu+TMGGgAQ9iRK9jHSNn3UexyiSFNEIx7eINnXfBJ3/BSIq0acjWmFKgbks2vpPZpHi4NUQFDbyE5PTnzDS70Moa+jLd2fPjTi+5GumyAkCpYk/BkQQb/ExaqeADvNUVihYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604567; c=relaxed/simple;
	bh=qj75dh2h3V0Ogr8LY76p+EKGod0M/RRoAdWgom9wj64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxnLGORuTq07Mx+qtoWzRXc0SecLLHep8DluHzn1blysFPhpytwc529n1gfZMVHV6v66ZZTd0YfO0jCTtkPcrms5WHhGjbHB7Z5rq4M8Ic6i1dMuTyE0zXmdQtdsCLSF78n1ZOVqXkdsINvYhmQ5SnE/zilU/SrrfThYCcqMCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AcRR3ivT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709604566; x=1741140566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qj75dh2h3V0Ogr8LY76p+EKGod0M/RRoAdWgom9wj64=;
  b=AcRR3ivTEFwxlY5bJjV4eTMNCHH1UvLPECEUS61ZagIMtaQc178PxgTQ
   9f0STqg5bI2QZuTq9z4r4tJB4Z5DydMJSrE81LvCQ0nnXSAqvG/jdkswp
   khChCXutI1AT7ACaWRdjWWY8B2GakwF6uheW8TUaNszjrDuTbTSLjnmol
   GM2J3PQJnROEAujPxbjNmnUzCJorBN0gvz6TEcXzszDHGfUBFTXzNaPIn
   TI/HUR4bxsuIJFzKkja3zb3fbxmLb2rRVfsZ5180yB5oXxuH1CAPHRvo1
   oL6y4JouhPzMYqrttBHegcj48+goDgYK1gswc4wNNP5tPPqy+GQ8LjfLj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="14775174"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14775174"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 18:09:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="40083153"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 18:09:21 -0800
Message-ID: <f9fd8861-6bbb-469d-b0cb-2edc8598ecca@linux.intel.com>
Date: Tue, 5 Mar 2024 10:09:20 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH pci-next] pci/edr: Ignore Surprise Down error on hot
 removal
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, Smita.KoralahalliChannabasappa@amd.com,
 ilpo.jarvinen@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kbusch@kernel.org
References: <20240304090819.3812465-1-haifeng.zhao@linux.intel.com>
 <20240304115844.GA3541@wunner.de>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240304115844.GA3541@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/2024 7:58 PM, Lukas Wunner wrote:
> On Mon, Mar 04, 2024 at 04:08:19AM -0500, Ethan Zhao wrote:
>> Per PCI firmware spec r3.3 sec 4.6.12, for firmware first mode DPC
>> handling path, FW should clear UC errors logged by port and bring link
>> out of DPC, but because of ambiguity of wording in the spec, some BIOSes
>> doesn't clear the surprise down error and the error bits in pci status,
>> still notify OS to handle it. thus following trick is needed in EDR when
>> double reporting (hot removal interrupt && dpc notification) is hit.
> Please provide more detailed information about the hardware and BIOS
> affected by this.
>
You know, to disclose the detail hardware and BIOS info list might invovle
very complex internal legal approval process.

To put it simply, at least one platform, such SPR and one customer's BIOS
is affected.

If FFM(firmware first mode) and hotplug are executed. the side effect can
be observed if it is affected, UC errors are reported along with pciehp
log.

>> -static void dpc_handle_surprise_removal(struct pci_dev *pdev)
>> +bool  dpc_handle_surprise_removal(struct pci_dev *pdev)
>>   {
>> +	if (!dpc_is_surprise_removal(pdev))
>> +		return false;
> This change of moving dpc_is_surprise_removal() into
> dpc_handle_surprise_removal() seems unrelated to the problem at hand.
>
> Please drop it if it's unnecessary to fix the issue.

To only export one function dpc_is_surprise_removal()... or I have to
export them both.
Seems I should keep them intact or refactor them in separated patch ?

>
>
>> --- a/drivers/pci/pcie/edr.c
>> +++ b/drivers/pci/pcie/edr.c
>> @@ -184,6 +184,9 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>>   		goto send_ost;
>>   	}
>>   
>> +	if (dpc_handle_surprise_removal(edev))
>> +		goto send_ost;
>> +
>>   	dpc_process_error(edev);
>>   	pci_aer_raw_clear_status(edev);
> This seems to be the only necessary change.  Please reduce the
> patch to contain only it and no other refactoring.
>
> Please capitalize the "PCI/EDR: " prefix in the subject and add
> a Fixes tag.

Sure !

Thanks,
Ethan

> Thanks,
>
> Lukas

