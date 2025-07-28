Return-Path: <linux-pci+bounces-33030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC679B13786
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 11:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B74707A029D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5563322FF35;
	Mon, 28 Jul 2025 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tgc4xQSj"
X-Original-To: linux-pci@vger.kernel.org
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA46224B04;
	Mon, 28 Jul 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694934; cv=none; b=j70nkJXSeTroPjQzncUaUdup0j0KAV8ak7qGBhfKZZh27icwippmn2iXq24Aow+W8AODaxvVqWV02VatOusVikoP8Vqp0A8W8KdKPxw4LMXeswarNJ56PFbi9ETkxbWcx3T0zw6LZC5aOlw1hMQgGX0owxnOlRQ/CyByf/G97/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694934; c=relaxed/simple;
	bh=wEOK1xAURgW6Ytv2Br14Bpge7BO2wUGPNJlIORD5TVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=at0b4WNJHWv72Dalb8jIt29XASu8pfFf8INesD0uqGZKWqRgj3Cfp7F5HFXLQBvWSGdrkT2Go2Uolbpa3RcWOAQzblSAxLZP9mvWrghk74qjl5qZm24MqSSnS0I0gNzEibMYFfigv2RV+O6rQPflRofn8IImN3r0TgiWvnWAbPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tgc4xQSj; arc=none smtp.client-ip=47.90.199.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753694911; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=M8FVPMMMRjlGh3vDVwp+zm4wCWL4AZ9kqfeszC7kZ74=;
	b=tgc4xQSjpTLJsMSkkKgzQ4XuJTILsbPkfdrkbQizAXq5wZ8nbAGIHZtHZm8ypo1uPOYZS7WigHnT8StrOm4kGIoTOpgd3xgjLEosjUxf3FtskYQLH8sjZR4c0S0+xEvTIWvE6L4bONNakELDT6D9CZnXdvtNFB3L0YR2gQX6OUg=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WkGaor9_1753694908 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Jul 2025 17:28:29 +0800
Message-ID: <61ec82be-a081-4b32-aa4a-a3ad6e564d23@linux.alibaba.com>
Date: Mon, 28 Jul 2025 17:28:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: rostedt@goodmis.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 mattc@purestorage.com, Jonathan.Cameron@huawei.com, bhelgaas@google.com,
 tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250723033108.61587-3-xueshuai@linux.alibaba.com>
 <20250725210921.GA3131414@bhelgaas> <aISJHjFrHkxVNFzJ@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aISJHjFrHkxVNFzJ@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/26 15:51, Lukas Wunner 写道:
> On Fri, Jul 25, 2025 at 04:09:21PM -0500, Bjorn Helgaas wrote:
>>> @@ -319,8 +319,7 @@ int pciehp_check_link_status(struct controller *ctrl)
>>>   		return -1;
>>>   	}
>>>   
>>> -	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &linksta2);
>>> -	__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status, linksta2);
>>> +	pcie_update_link_speed(ctrl->pcie->port->subordinate, PCIE_HOTPLUG);
>>
>> It kind of bugs me that the hot-add flow reads LNKSTA three times and
>> generates both pci_hp_event LINK_UP and link_event tracepoints:
>>
>>    pciehp_handle_presence_or_link_change
>>      link_active = pciehp_check_link_active()
>>        pcie_capability_read_word(PCI_EXP_LNKSTA)
>>      if (link_active)
>>        ctrl_info(ctrl, "Slot(%s): Link Up\n")
> 
> This LNKSTA read decides whether to bring up the slot.
> It can't be eliminated.
> 
>>        trace_pci_hp_event(PCI_HOTPLUG_LINK_UP)
>>        pciehp_enable_slot
>>          __pciehp_enable_slot
>>            board_added
>>              pciehp_check_link_status
>>                pcie_capability_read_word(PCI_EXP_LNKSTA)
> 
> This is sort of a final check whether the link is (still) active
> before commencing device enumeration.  Doesn't look like it can
> safely be eliminated either.
> 
>>                pcie_update_link_speed
>>                  pcie_capability_read_word(PCI_EXP_LNKSTA)
>>                  pcie_capability_read_word(PCI_EXP_LNKSTA2)
>>                  trace_pcie_link_event(<REASON>)
> 
> This third register read is introduced by the present patch and is
> indeed somewhat a step back, given that pciehp_check_link_status()
> currently deliberately calls __pcie_update_link_speed() to pass
> the already read LNKSTA value.

Hi Lukas, and Bjorn:

Thanks for the excellent technical analysis!

You're absolutely right. I introduced an unnecessary regression by
adding a third LNKSTA read when pciehp_check_link_status() already has
the LNKSTA value and was specifically designed to pass it to
__pcie_update_link_speed().

> 
> I'm wondering if the tracepoint can be moved down to
> __pcie_update_link_speed()?

Yes, that's a much better approach. Will fix it in next version.

> 
>> And maybe we need both a bare LINK_UP event and a link_event with all
>> the details, but again it seems a little weird to me that there are
>> two tracepoints when there's really only one event and we know all the
>> link_event information from the very first LNKSTA read.
> 
> One of the reasons is that a "Link Down" event would have to
> contain dummy values for link speed etc, so it seemed cleaner
> to separate the hotplug event from the link speed event.
> 
> Thanks,
> 
> Lukas

I agree with Lukas and I completely agree with this separation. The two
tracepoints serve different purposes:

- pci_hp_event: Pure hotplug state changes (LINK_UP/LINK_DOWN,
   CARD_PRESENT/CARD_NOT_PRESENT)
- pcie_link_event: Actual link parameter information when meaningful
   values exist

For LINK_DOWN events, we don't have meaningful speed/width values, so
forcing them into a single tracepoint would indeed require dummy/invalid
values, making the interface confusing.

Thanks for the clear technical guidance and for catching my regression!

Best regards,
Shuai

