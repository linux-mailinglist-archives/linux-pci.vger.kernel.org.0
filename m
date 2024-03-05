Return-Path: <linux-pci+bounces-4488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B427871380
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 03:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5732F28762E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 02:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965D017C9E;
	Tue,  5 Mar 2024 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULEtZplt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620218030;
	Tue,  5 Mar 2024 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709605167; cv=none; b=ZddwWYn3UAgPPkXqh8dNy5goay3U6giLmimqtpMX2UC7tQFG+oNUm2pnBsvWA0r1qp1P8Bu0Hv+rl5rDMC3gKzdx/KEt1zhvsCriayyN7WiGiJcb2BnjeMOmvE0rPmk3dsIqWxUHdr1MnUmkBbfUDYndNtdKToCM/WxTiokyeBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709605167; c=relaxed/simple;
	bh=b1vg0e17e6fTT1a+wPfrKj9tx2VdWRx7fF7BtQL5Qfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R12+ByndsLWkuBMuA34/JYcjq1XEBX5BSnBMWTsyF8nDmnnGe8ASsqjsMGX+L4X5KWYsZfhffK83nR3QHjVSgBMhtJtV1XCTQ1kqQPrjrvA8zL40lf9AsIdk9sWMyKGTgDB7V3sSGl/RkDcK6DbIT6x/X9qQX11+OAMtjD5COl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULEtZplt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709605166; x=1741141166;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b1vg0e17e6fTT1a+wPfrKj9tx2VdWRx7fF7BtQL5Qfw=;
  b=ULEtZpltGSwESuuAmbl8bWaGUVETpLXAT7FRnxXVawTvDWAYZPwV5mlW
   gNNzo2BrNB6AbZbPs3TDpTk93wxuTD4vCCKiLKM6wX7nBFpcY1e1K9lAp
   WfzApBgK9MM3sUTNfJRwnZgKORlDghKt0h6uqtvm36n/Zb3dv7mfs5fSw
   ZrDo8v1Jfo8N1bDJv45BQKKwU9uPzRwXOaahY8HbGsdcJDWj3SfoY8rX3
   WHx++q8D9u+zvRx67nVK9TOwj9U25PikOC5Tbw8y8ytUCXJY9WOVYSDpV
   67Nr6IrKKf0BBLg7knwup7MSZPp4AS+XPG/W5rFydOTGJban6+9vhwfZY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4014688"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4014688"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 18:19:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13876766"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 18:19:23 -0800
Message-ID: <0c17c2d4-9834-4451-8c6b-8eaa0b66dabe@linux.intel.com>
Date: Tue, 5 Mar 2024 10:19:20 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH pci-next] pci/edr: Ignore Surprise Down error on hot
 removal
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kbusch@kernel.org
References: <20240304090819.3812465-1-haifeng.zhao@linux.intel.com>
 <20240304115844.GA3541@wunner.de>
 <ff3918bc-ebd2-60e2-971f-5b48ba929335@amd.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <ff3918bc-ebd2-60e2-971f-5b48ba929335@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/5/2024 3:33 AM, Smita Koralahalli wrote:
> Hi Ethan,
>
> On 3/4/2024 3:58 AM, Lukas Wunner wrote:
>> On Mon, Mar 04, 2024 at 04:08:19AM -0500, Ethan Zhao wrote:
>>> Per PCI firmware spec r3.3 sec 4.6.12, for firmware first mode DPC
>>> handling path, FW should clear UC errors logged by port and bring link
>>> out of DPC, but because of ambiguity of wording in the spec, some 
>>> BIOSes
>>> doesn't clear the surprise down error and the error bits in pci status,
>>> still notify OS to handle it. thus following trick is needed in EDR 
>>> when
>>> double reporting (hot removal interrupt && dpc notification) is hit.
>
> Please correct me if I'm wrong.
>
> When there is double reporting (hot removal interrupt && dpc 
> notification), won't the DPC handler be called always which takes care 
> of clearing the surprise down errors? Do we need it again from EDR 
> handler?

My understanding, if firmware first mode is enabled, DPC driver wouldn't
be enabled, EDR is notified instead, though some of the common functions
are used in EDR, such as dpc_process_error() is called in edr_handle_event(),
but dpc_handler() isn't called, so does the dpc_handle_surprise_removal().

Thanks,
Ethan

>
> Thanks
> Smita
>
>>
>> Please provide more detailed information about the hardware and BIOS
>> affected by this.
>>
>>
>>> -static void dpc_handle_surprise_removal(struct pci_dev *pdev)
>>> +bool  dpc_handle_surprise_removal(struct pci_dev *pdev)
>>>   {
>>> +    if (!dpc_is_surprise_removal(pdev))
>>> +        return false;
>>
>> This change of moving dpc_is_surprise_removal() into
>> dpc_handle_surprise_removal() seems unrelated to the problem at hand.
>>
>> Please drop it if it's unnecessary to fix the issue.
>>
>>
>>> --- a/drivers/pci/pcie/edr.c
>>> +++ b/drivers/pci/pcie/edr.c
>>> @@ -184,6 +184,9 @@ static void edr_handle_event(acpi_handle handle, 
>>> u32 event, void *data)
>>>           goto send_ost;
>>>       }
>>>   +    if (dpc_handle_surprise_removal(edev))
>>> +        goto send_ost;
>>> +
>>>       dpc_process_error(edev);
>>>       pci_aer_raw_clear_status(edev);
>>
>> This seems to be the only necessary change.  Please reduce the
>> patch to contain only it and no other refactoring.
>>
>> Please capitalize the "PCI/EDR: " prefix in the subject and add
>> a Fixes tag.
>>
>> Thanks,
>>
>> Lukas
>>

