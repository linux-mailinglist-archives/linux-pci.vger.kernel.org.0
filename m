Return-Path: <linux-pci+bounces-21045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EB1A2E20F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 02:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23391887BB1
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 01:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FA81119A;
	Mon, 10 Feb 2025 01:39:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DBD23CB;
	Mon, 10 Feb 2025 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739151593; cv=none; b=oUHfvgunDLCjvXg6Rzyk5skCytPxJybT+Hh7vc1jPHTedU7oqPh+1DLefO4GOkZg+Q5M4DG3y2QCK5PSFuLLQvHepyImXLlmNi3RTHDFY57U+1NOu1zvsWmGtMOyRCeaaPMrG+1hRQnvHjqDt2E8HNtIh/iumIDZ6DT++W3fORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739151593; c=relaxed/simple;
	bh=6tI7QAXib5VmS3pEdyl1MKQdUwVYq/ESMzWC+7SK860=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JA8gv4Yce2+F9fpl2H7QW42c/QiV2vzQ9jS75R0D6zxlldeBNodcXvRJrjjYxEKvwwHbjDtNV0WO7NNBn9jLxlv/VBHswQzIxLgJSlG116aoOc/MlonOTsmUKwCadqB6I82FZLsxi7FWePFAoeoR1n8iZ1riJfMa3RAERbbKYQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 10 Feb 2025 10:39:43 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 8D8232006EA4;
	Mon, 10 Feb 2025 10:39:43 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Mon, 10 Feb 2025 10:39:43 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id 32C5CAB187;
	Mon, 10 Feb 2025 10:39:43 +0900 (JST)
Message-ID: <90c7077f-0e2e-4d9e-912d-913a51170acc@socionext.com>
Date: Mon, 10 Feb 2025 10:39:42 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] misc: pci_endpoint_test: Avoid issue of interrupts
 remaining after request_irq error
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
 <20250122022446.2898248-2-hayashi.kunihiko@socionext.com>
 <20250128141242.pog2tuorvqmobain@thinkpad>
 <2cdb5e43-47e0-43ba-ba17-87e8d5dc602d@socionext.com>
 <20250207180229.klwodx7m3rmmopnq@thinkpad>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20250207180229.klwodx7m3rmmopnq@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Manivannan,

On 2025/02/08 3:02, Manivannan Sadhasivam wrote:
> On Wed, Jan 29, 2025 at 04:54:46PM +0900, Kunihiko Hayashi wrote:
>> Hi Manivannan,
>>
>> On 2025/01/28 23:12, Manivannan Sadhasivam wrote:
>>> On Wed, Jan 22, 2025 at 11:24:44AM +0900, Kunihiko Hayashi wrote:
>>>> After devm_request_irq() fails with error,
>>>> pci_endpoint_test_free_irq_vectors() is called to free allocated
>>>> vectors
>>>> with pci_free_irq_vectors().
>>>>
>>>
>>> You should mention the function name which you are referring to. Here it
>>> is,
>>> pci_endpoint_test_request_irq().
>>
>> I see. I'll make the commit message more clear.
>>
>>>> However some requested IRQs are still allocated, so there are still
>>>
>>> This is confusing. Are you saying that the previously requested IRQs are
>>> not
>>> freed when an error happens during the for loop in
>>> pci_endpoint_test_request_irq()?
>>
>> Yes, after jumping to "fail:" label, it just prints an error message and
>> returns the function.
>>
>> The pci_endpoint_test_request_irq() is called from the following
>> functions:
>> - pci_endpoint_test_probe()
>> - pci_endpoint_test_set_irq()
>>
>> Both call pci_endpoint_test_free_irq_vectors() after the error, though,
>> requested IRQs are not freed anywhere.
>>
> 
> You should not use the word 'allocated' since that has a different meaning
> and the source of confusion.

Surely, 'allocated' means the vectors allocated with pci_irq_vectors(), not
the interrupts requested with request_irq().

I'll rewrite with a right description.

>>>> /proc/irq/* entries remaining and we encounters WARN() with the
>>>> following
>>>> message:
>>>>
>>>>       remove_proc_entry: removing non-empty directory 'irq/30', leaking
>>>> at
>>>>       least 'pci-endpoint-test.0'
>>>>       WARNING: CPU: 0 PID: 80 at fs/proc/generic.c:717
>>>> remove_proc_entry
>>>>       +0x190/0x19c
>>>
>>> When did you encounter this WARN?
>>
>> Usually request_irq() can successfully get an interrupt.
>> If request_irq() returned an error, pci_endpoint_test_free_irq_vectors()
>> was
>> called and the following call-trace was obtained:
>>
>> [   18.772522] Call trace:
>> [   18.773743]  remove_proc_entry+0x190/0x19c
>> [   18.775789]  unregister_irq_proc+0xd0/0x104
>> [   18.777881]  free_desc+0x4c/0xcc
>> [   18.779495]  irq_free_descs+0x68/0x8c
>> [   18.781325]  irq_domain_free_irqs+0x15c/0x1bc
>> [   18.783502]  msi_domain_free_locked.part.0+0x184/0x1d4
>> [   18.786069]  msi_domain_free_irqs_all_locked+0x64/0x8c
>> [   18.788637]  pci_msi_teardown_msi_irqs+0x48/0x54
>> [   18.790947]  pci_free_msi_irqs+0x18/0x38
>> [   18.792907]  pci_free_irq_vectors+0x64/0x8c
>> [   18.794997]  pci_endpoint_test_ioctl+0x7e8/0xf40
>> [   18.797304]  __arm64_sys_ioctl+0xa4/0xe8
>> [   18.799265]  invoke_syscall+0x48/0x110
>> [   18.801139]  el0_svc_common.constprop.0+0x40/0xe8
>> [   18.803489]  do_el0_svc+0x20/0x2c
>> [   18.805145]  el0_svc+0x30/0xd0
>> [   18.806673]  el0t_64_sync_handler+0x13c/0x158
>> [   18.808850]  el0t_64_sync+0x190/0x194
>> [   18.810680] ---[ end trace 0000000000000000 ]---
>>
> 
> Please add this info to the patch description.

Okay, I'll add the call trace into the patch.

Thank you,

---
Best Regards
Kunihiko Hayashi

