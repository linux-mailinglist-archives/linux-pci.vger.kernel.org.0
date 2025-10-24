Return-Path: <linux-pci+bounces-39245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF4BC048B2
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 08:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FED83B9AD3
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 06:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D341122422D;
	Fri, 24 Oct 2025 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M7Eck+Sn"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1251EE7DC;
	Fri, 24 Oct 2025 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288251; cv=none; b=TOZ7SRk7Z4s8blIio5EhBQX29uG7drYWsf8ZbQJ3tage2CHwWEelyHH+Cs4/m651EVyEpZVTxrLkzpuIRNczgzcYIe01JD1dtuEuB2HJ0jDK3KLS9q+6LqTRqfFNsOaypxH1dDCHbXg6appzpz6/9cQb/bFfzdgwlRKckVXKHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288251; c=relaxed/simple;
	bh=fE0WFTUanwNAWzYo/9yEs8wOyV0QjQDak4p5lvWUgPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byw4e6uYD2H54ZxtqXSqTcdvx8PTwD8w8rZMcQZlmMRy9gogNqLZVr0BphkQ3QbbCXvsnXon22bvoCWG2P73sXaUc1b3mWKJ8kbrIZ7zrqSIVElSaMKqSegiAcBxrsbtESyQ5gG6HfZJPgrNpRvm0sKJC6cCbXk+5weQDQp8ff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M7Eck+Sn; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761288238; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+PtR/2mY5lY5Xflgf0MxYoKPmgArqRLPqH9rrelUPf8=;
	b=M7Eck+Sn4bm3uPpaUPkvvUbBrXy7WwpmiaSBuobz83G9ksGqiLRcGJb9dfLbbfFWeHEtuMdlscPUr22UuIUX3wmz0HnpMBagztmBU90enklRggaHYdLCCwlTp+LjxVBcbbOipD10cbWJGkW496rM9anSat62ThEtI//OFhnmSs4=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqtPi1u_1761288236 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Oct 2025 14:43:57 +0800
Message-ID: <239a003e-24dc-4e75-b677-a2c596b31c32@linux.alibaba.com>
Date: Fri, 24 Oct 2025 14:43:56 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
 tianruidong@linux.alibaba.com
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-4-xueshuai@linux.alibaba.com>
 <aPYKe1UKKkR7qrt1@wunner.de>
 <6d7143a3-196f-49f8-8e71-a5abc81ae84b@linux.alibaba.com>
 <aPY--DJnNam9ejpT@wunner.de>
 <43390d36-147f-482c-b31a-d02c2624061f@linux.alibaba.com>
 <aPZGNP79kJO74W4J@wunner.de>
 <30fe11dd-3f21-4a61-adb0-74e39087c84c@linux.alibaba.com>
 <aPoIDW_Yt90VgHL8@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aPoIDW_Yt90VgHL8@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/23 18:48, Lukas Wunner 写道:
> On Mon, Oct 20, 2025 at 11:20:58PM +0800, Shuai Xue wrote:
>> 2025/10/20 22:24, Lukas Wunner:
>>> On Mon, Oct 20, 2025 at 10:17:10PM +0800, Shuai Xue wrote:
>>>>>>      .slot_reset()
>>>>>>        => pci_restore_state()
>>>>>>          => pci_aer_clear_status()
>>>>>
>>>>> This was added in 2015 by b07461a8e45b.  The commit claims that
>>>>> the errors are stale and can be ignored.  It turns out they cannot.
>>>>>
>>>>> So maybe pci_restore_state() should print information about the
>>>>> errors before clearing them?
>>>>
>>>> While that could work, we would lose the error severity information at
>>>
>>> Wait, we've got that saved in pci_cap_saved_state, so we could restore
>>> the severity register, report leftover errors, then clear those errors?
>>
>> You're right that the severity register is also sticky, so we could
>> retrieve error severity directly from AER registers.
>>
>> However, I have concerns about implementing this approach:
> [...]
>> 3. Architectural consistency: As you noted earlier, "pci_restore_state()
>> is only supposed to restore state, as the name implies, and not clear
>> errors." Adding error reporting to this function would further violate
>> this principle - we'd be making it do even more than just restore state.
>>
>> Would you prefer I implement this broader change, or shall we proceed
>> with the targeted helper function approach for now? The helper function
>> solves the immediate problem while keeping the changes focused on the
>> AER recovery path.
> 
> My opinion is that b07461a8e45b was wrong and that reported errors
> should not be silently ignored. 

Thanks for your input and for discussing the history of commit
b07461a8e45b. I understand its intention to ignore errors specifically
during enumeration. As far as I know, AdvNonFatalErr events can occur in
this phase and typically should be ignored to simplify handling.

> What I'd prefer is that if
> pci_restore_state() discovers unreported errors, it asks the AER driver
> to report them.
> 
> We've already got a helper to do that:  aer_recover_queue()
> It queues up an entry in AER's kfifo and asks AER to report it.
> 
> So far the function is only used by GHES.  GHES allocates the
> aer_regs argument from ghes_estatus_pool using gen_pool_alloc().
> Consequently aer_recover_work_func() uses ghes_estatus_pool_region_free()
> to free the allocation.  That prevents using aer_recover_queue()
> for anything else than GHES.  It would first be necessary to
> refactor aer_recover_queue() + aer_recover_work_func() such that
> it can cope with arbitrary allocations (e.g. kmalloc()).

I agree that aer_recover_queue() and aer_recover_work_func() offer a
generalized way to report errors.

However, I’d like to highlight some concerns regarding error discovery
during pci_restore_state():

- Errors During Enumeration via Hotplug: Errors such as AdvNonFatalErr
   seen during enumeration or hotplug are generally intended to be
   ignored, as handling them adds unnecessary complexity without
   practical benefits.

- Errors During Downstream Port Containment (DPC): When an error is
   detected and not masked, it is expected to propagate through the usual
   AER path, either reported directly to the OS or to the firmware.
   Finally, these errors should be cleared and reported in a single
   cohesive step.

For missed fatal errors during DPC, queuing additional work to report
these errors using aer_recover_queue() could introduce significant
overhead. Specifically: It may result in the bus being reset and the
device reset again, which could unnecessarily disrupt system operation.

Do we really need the heavy way?

I would appreciate more feedback from the community on whether queuing
another recovery task for errors detected during pci_restore_state()

Thanks
Shuai

