Return-Path: <linux-pci+bounces-32921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D82B1194D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 09:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0DC3B2ACE
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 07:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0922BD5AB;
	Fri, 25 Jul 2025 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Pu1FjGjc"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BA1259C9C;
	Fri, 25 Jul 2025 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753429273; cv=none; b=QxJLMzBf7HVFyB7WEDRX/ksy/d6CSIbr3PSJ7/wCrghrQgqHfn1AOsFu2d1KE4J8FtvvHtBCV7r3a0hF9kF01r/Jgmd3UeWgKNlkFRd/rYca03SKRA3SPxkq/JJHOfSS0aRL7CK5X/KDFbwWf5DtoKRQGRqyrphX6mcuDFAw8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753429273; c=relaxed/simple;
	bh=iU5YGJ3I54OU4ddGrVGqJomYispYiE0YPsCVGcijQGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwpVzJtt9OqYDaJ73mJvhH1jowNiDppBjZ9KRsIXq4QQu6+n56SwiO6lvlzm/qT3GzPYg7zEHguLoRp3E7bQJuR649ODVfR93clja+ftWzt5/dTxVlW8Lg57tYXgzA/TCeL/BXdgPrRW4AXX9KXW6RjCAxXMW8xbFbWltZyoJ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Pu1FjGjc; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753429268; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1QOs6c7uf/ZoRQrUor4J2oiDON93b/HTe+azTB+u2VE=;
	b=Pu1FjGjcYN4Ie+VCfYctSAt0vQitJ8ySfH1gJ0adaTfEBww1ZjGZUUfQaWtStUvNK2mTmkU8egtEzO8qMhl59iCDrfkZQdxelYHEzoP+2zlufaGTOaHeFDTWZQu12ztdbNh2tivFxUk81cF/g6hBYw4PJ2227IfTCBEUbloBJbQ=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wjwd8Jg_1753429264 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 15:41:05 +0800
Message-ID: <fdb5dced-ea5a-48b8-bbb4-fc3ade7f3df8@linux.alibaba.com>
Date: Fri, 25 Jul 2025 15:40:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vmcoreinfo: Track and log recoverable hardware errors
To: Breno Leitao <leitao@debian.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, Robert Moore <robert.moore@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev, osandov@osandov.com, konrad.wilk@oracle.com,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, kernel-team@meta.com
References: <20250722-vmcore_hw_error-v3-1-ff0683fc1f17@debian.org>
 <7ce9731a-b212-4e27-8809-0559eb36c5f2@linux.alibaba.com>
 <4qh2wbcbzdajh2tvki26qe4tqjazmyvbn7v7aqqhkxpitdrexo@ucch4ppo7i4e>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <4qh2wbcbzdajh2tvki26qe4tqjazmyvbn7v7aqqhkxpitdrexo@ucch4ppo7i4e>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/24 21:34, Breno Leitao 写道:
> Hello Shuai,
> 
> On Thu, Jul 24, 2025 at 04:00:09PM +0800, Shuai Xue wrote:
>> 在 2025/7/23 00:56, Breno Leitao 写道:
>>> Introduce a generic infrastructure for tracking recoverable hardware
>>> errors (HW errors that did not cause a panic) and record them for vmcore
>>> consumption. This aids post-mortem crash analysis tools by preserving
>>> a count and timestamp for the last occurrence of such errors.
>>>
>>> Add centralized logging for three common sources of recoverable hardware
>>> errors:
>>
>> The term "recoverable" is highly ambiguous. Even within the x86
>> architecture, different vendors define errors differently. I'm not
>> trying to be pedantic about classification. As far as I know, for 2-bit
>> memory errors detected by scrub, AMD defines them as deferred errors
>> (DE) and handles them with log_error_deferred, while Intel uses
>> machine_check_poll. For 2-bit memory errors consumed by processes,
>> both Intel and AMD use MCE handling via do_machine_check(). Does your
>> HWERR_RECOV_MCE only focus on synchronous UE errors handled in
>> do_machine_check? What makes it special?
> 
> I understand that deferred errors (DE) detected by memory scrubbing are
> typically silent and may not significantly impact system stability. In
> other words, I’m not convinced that including DE metrics in crash dumps
> would be helpful for correlating crashes with hardware issues—it might
> just add noise.
> 
> Do you think it would be valuable to also log these events within
> log_error_deferred()?

Not really, as you meationed, the DE is typically silent in backgroud.
But I hope it is well documented.
> 
>>> -	if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC)
>>> +	sev = ghes_severity(estatus->error_severity);
>>> +	if (sev == GHES_SEV_RECOVERABLE || sev ==  GHES_SEV_CORRECTED)
>>> +		hwerr_log_error_type(HWERR_RECOV_GHES);
>>
>> APEI does not define an error type named GHES. GHES is just a kernel
>> driver name. Many hardware error types can be handled in GHES (see
>> ghes_do_proc), for example, AER is routed by GHES when firmware-first
>> mode is used. As far as I know, firmware-first mode is commonly used in
>> production. Should GHES errors be categorized into AER, memory, and CXL
>> memory instead?
> 
> I also considered slicing the data differently initially, but then
> realized it would add more complexity than necessary for my needs.
> 
> If you believe we should further subdivide the data, I’m happy to do so.
> 
> You’re suggesting a structure like this, which would then map to the
> corresponding CPER_SEC_ sections:
> 
> 	enum hwerr_error_type {
> 	HWERR_RECOV_AER,     // maps to CPER_SEC_PCIE
> 	HWERR_RECOV_MCE,     // maps to default MCE + CPER_SEC_PCIE

CPER_SEC_PCIE is typo?

> 	HWERR_RECOV_CXL,     // maps to CPER_SEC_CXL_*
> 	HWERR_RECOV_MEMORY,  // maps to CPER_SEC_PLATFORM_MEM
> 	}
> 
> Additionally, what about events related to CPU, Firmware, or DMA
> errors—for example, CPER_SEC_PROC, CPER_SEC_FW, CPER_SEC_DMAR? Should we
> include those in the classification as well?

I would like to split a error from ghes to its own type,
it sounds more reasonable. I can not tell what happened from HWERR_RECOV_AERat all :(
> 
> 
> Thanks for your review and for the ongoing discussion!
> --breno

Thanks.
Shuai


