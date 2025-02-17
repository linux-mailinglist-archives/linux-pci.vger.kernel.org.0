Return-Path: <linux-pci+bounces-21604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4D3A3819E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 12:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2518A3A9DBE
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 11:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D122C217713;
	Mon, 17 Feb 2025 11:26:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951462135C7;
	Mon, 17 Feb 2025 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791565; cv=none; b=i8EBZ89mrmUJGwX9qCnYSOqfCv2PwWEgg848EQj3JKoWaoXioB24i6EfbH/qvxXIAqR2CXNRzJH1U4K5/LzsOdOWXsyZBlnX7l0u8SXneCz7klf5V4LJ1EHWfPJVwf6tmF/Q/J8f0h2LtLJH3IAqnDuITiaAbsmwmRCBMjT8hv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791565; c=relaxed/simple;
	bh=zwrZXcz8kUFQtW0/zwqY0uqd82Wgg/WRh74T4km+69A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFSKAlK1l+PEOg47MdCNm/a6/kzPd+BMUekaMuWUBY3HVmkXhHDEa/LM8WzRf7cE2DJZ2JyyaODaCwIJNSAV70FteMMqeFhRFYzFE/Qqy23TrK72iWzMRi8tZIp/gqkAz5FETtXGFrQkukqvHOH4TKK5UgDTmdppPsBuIII76AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 17 Feb 2025 20:24:53 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id AB7E52019C91;
	Mon, 17 Feb 2025 20:24:53 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Mon, 17 Feb 2025 20:24:53 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id D11C294B21;
	Mon, 17 Feb 2025 20:24:52 +0900 (JST)
Message-ID: <2dda0bd7-abdb-446b-b1ba-cd5245d18da0@socionext.com>
Date: Mon, 17 Feb 2025 20:24:52 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] misc: pci_endpoint_test: Avoid issue of interrupts
 remaining after request_irq error
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof Wilczynski <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
 <20250210075812.3900646-2-hayashi.kunihiko@socionext.com>
 <20250214172138.setswcgqz3dbf65t@thinkpad>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20250214172138.setswcgqz3dbf65t@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Manivannan,

On 2025/02/15 2:21, Manivannan Sadhasivam wrote:
> On Mon, Feb 10, 2025 at 04:58:08PM +0900, Kunihiko Hayashi wrote:
>> After devm_request_irq() fails with error in
>> pci_endpoint_test_request_irq(), pci_endpoint_test_free_irq_vectors() is
>> called assuming that all IRQs have been released.
>>
>> However some requested IRQs remain unreleased, so there are still
>> /proc/irq/* entries remaining and we encounters WARN() with the following
> 
> s/we encounters/this results in WARN()

I see. I'll fix it.

>> message:
>>
>>      remove_proc_entry: removing non-empty directory 'irq/30', leaking at
>>      least 'pci-endpoint-test.0'
>>      WARNING: CPU: 0 PID: 202 at fs/proc/generic.c:719 remove_proc_entry
>>      +0x190/0x19c
>>
>> And show the call trace that led to this issue:
> 
> You can remove this backtrace.

I'll add more information instead.

> 
>>
>>      [   12.050005] Call trace:
>>      [   12.051226]  remove_proc_entry+0x190/0x19c (P)
>>      [   12.053448]  unregister_irq_proc+0xd0/0x104
>>      [   12.055541]  free_desc+0x4c/0xd0
>>      [   12.057155]  irq_free_descs+0x68/0x90
>>      [   12.058984]  irq_domain_free_irqs+0x15c/0x1bc
>>      [   12.061161]  msi_domain_free_locked.part.0+0x184/0x1d4
>>      [   12.063728]  msi_domain_free_irqs_all_locked+0x64/0x8c
>>      [   12.066296]  pci_msi_teardown_msi_irqs+0x48/0x54
>>      [   12.068604]  pci_free_msi_irqs+0x18/0x38
>>      [   12.070564]  pci_free_irq_vectors+0x64/0x8c
>>      [   12.072654]  pci_endpoint_test_ioctl+0x870/0x1068
>>      [   12.075006]  __arm64_sys_ioctl+0xb0/0xe8
>>      [   12.076967]  invoke_syscall+0x48/0x110
>>      [   12.078841]  el0_svc_common.constprop.0+0x40/0xe8
>>      [   12.081192]  do_el0_svc+0x20/0x2c
>>      [   12.082848]  el0_svc+0x30/0xd0
>>      [   12.084376]  el0t_64_sync_handler+0x144/0x168
>>      [   12.086553]  el0t_64_sync+0x198/0x19c
>>      [   12.088383] ---[ end trace 0000000000000000 ]---
>>
>> To solve this issue, set the number of remaining IRQs to test->num_irqs
>> and release IRQs in advance by calling pci_endpoint_test_release_irq().
>>
>> Cc: stable@vger.kernel.org
>> Fixes: e03327122e2c ("pci_endpoint_test: Add 2 ioctl commands")
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thank you,

---
Best Regards
Kunihiko Hayashi

