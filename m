Return-Path: <linux-pci+bounces-33029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F808B1375F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 11:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14863A6838
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 09:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C157A1DF970;
	Mon, 28 Jul 2025 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A0yKQPCv"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46832186284;
	Mon, 28 Jul 2025 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694281; cv=none; b=c2WOK9xrr7tyDy1h2KOUDALsVRv2fl9lyaa5HcBs1INSGqFojXThRqsG7gXn0FxpupjPZWBWw1HrL71rXLCOPl8v/m/C9Nmf4z/qOOsykbQZwNl0Qlxie8Nj/NHcBnBvX4hLZdFCLoH2QOv30lLhftMVLb4TZVYMlQAlqBFjMCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694281; c=relaxed/simple;
	bh=N90rUimvvI6iTvKlbPRalCTVi/X8aM0kZrvlC/ipPCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCRvajsNXhjflYuUs5B/hi59v1bRpHHapcOvye2r889ivlJHUSeQBkghEu/EVCToVw0anFai6W9wLa+Cx4cs0R4pJbPI4kq/mHr0EwD7cBcDGOPlWzZ9XBOFra5rxq2FyzN7nrxSPxq5U6V0BGLnfQx8qo3homuHA90wlOJbZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A0yKQPCv; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753694270; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bnQr0tPn6s+2WwfwGAEU2d1/d/+uqBEcAW2G3ILPfGs=;
	b=A0yKQPCv9QxDITVy/ZoOnmYalddpoVWuZqyC/DVnryeHWgDf7cHOluRL3/qigHNzD2fMNM4ZsJk1dwI3U1RTvFLFonFOdW6+CNDfBT8jcwayKrBZzZNxGv88DXbk49YVkKiVqH540z3rC3E6+PbS1I7ZnNTVXiVZKWLV7iZVizI=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WkGLE.u_1753694267 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Jul 2025 17:17:48 +0800
Message-ID: <fe946c32-8fa8-45bf-908c-17aa7374b9ac@linux.alibaba.com>
Date: Mon, 28 Jul 2025 17:17:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: rostedt@goodmis.org, lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 mattc@purestorage.com, Jonathan.Cameron@huawei.com, bhelgaas@google.com,
 tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250725210921.GA3131414@bhelgaas>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250725210921.GA3131414@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/26 05:09, Bjorn Helgaas 写道:
> On Wed, Jul 23, 2025 at 11:31:08AM +0800, Shuai Xue wrote:
>> PCIe link speed degradation directly impacts system performance and
>> often indicates hardware issues such as faulty devices, physical layer
>> problems, or configuration errors.
>>
>> To this end, add a RAS tracepoint to monitor link speed changes,
>> enabling proactive health checks and diagnostic analysis.
>>
>> The output is like below:
>>
>> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_link_event/enable
>> $ cat /sys/kernel/debug/tracing/trace_pipe
>> cat /sys/kernel/debug/tracing/trace_pipe
>>             <...>-119     [002] .....   125.776171: pci_hp_event: 0000:00:03.0 slot:30, event:CARD_PRESENT
>>
>>             <...>-119     [002] .....   125.776197: pci_hp_event: 0000:00:03.0 slot:30, event:LINK_UP
>>
>>     irq/57-pciehp-119     [002] .....   125.904335: pcie_link_event: 0000:00:03.0 type:4, reason:4, cur_bus_speed:2.5 GT/s PCIe, max_bus_speed:16.0 GT/s PCIe, width:1, flit_mode:0, status:DLLLA
>>
>>     irq/57-pciehp-119     [002] .....   125.907051: pcie_link_event: 0000:00:03.0 type:4, reason:0, cur_bus_speed:2.5 GT/s PCIe, max_bus_speed:16.0 GT/s PCIe, width:1, flit_mode:0, status:DLLLA
> 
> I guess this example would actually require both of these enables, right?
> 
>    echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
>    echo 1 > /sys/kernel/debug/tracing/events/pci/pci_link_event/enable

Yes, you're absolutely right. I'll correct the commit log to show both
commands.

(As a side note, echo 1 > /sys/kernel/debug/tracing/events/pci/enable
would enable both events at once.)

(echo 1 > /sys/kernel/debug/tracing/events/pci/enable will enable both
of these event.)
> 
>> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> 
> I don't think I've suggested anything that really warrants this ;)
> 

Fair enough! I'll drop the Suggested-by tag.

>> ...
>> @@ -292,7 +292,7 @@ int pciehp_check_link_status(struct controller *ctrl)
>>   {
>>   	struct pci_dev *pdev = ctrl_dev(ctrl);
>>   	bool found;
>> -	u16 lnk_status, linksta2;
>> +	u16 lnk_status;
>>   
>>   	if (!pcie_wait_for_link(pdev, true)) {
>>   		ctrl_info(ctrl, "Slot(%s): No link\n", slot_name(ctrl));
>> @@ -319,8 +319,7 @@ int pciehp_check_link_status(struct controller *ctrl)
>>   		return -1;
>>   	}
>>   
>> -	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &linksta2);
>> -	__pcie_update_link_speed(ctrl->pcie->port->subordinate, lnk_status, linksta2);
>> +	pcie_update_link_speed(ctrl->pcie->port->subordinate, PCIE_HOTPLUG);
> 
> It kind of bugs me that the hot-add flow reads LNKSTA three times and
> generates both pci_hp_event LINK_UP and link_event tracepoints:
> 
>    pciehp_handle_presence_or_link_change
>      link_active = pciehp_check_link_active()
>        pcie_capability_read_word(PCI_EXP_LNKSTA)
>      if (link_active)
>        ctrl_info(ctrl, "Slot(%s): Link Up\n")
>        trace_pci_hp_event(PCI_HOTPLUG_LINK_UP)
>        pciehp_enable_slot
>          __pciehp_enable_slot
>            board_added
>              pciehp_check_link_status
>                pcie_capability_read_word(PCI_EXP_LNKSTA)
>                pcie_update_link_speed
>                  pcie_capability_read_word(PCI_EXP_LNKSTA)
>                  pcie_capability_read_word(PCI_EXP_LNKSTA2)
>                  trace_pcie_link_event(<REASON>)
> 
> Maybe there are good reasons for reading LNKSTA three times, but it
> does make me raise my eyebrows.  Not that this is a performance path,
> but it just offends my sense of propriety.
> 
> And maybe we need both a bare LINK_UP event and a link_event with all
> the details, but again it seems a little weird to me that there are
> two tracepoints when there's really only one event and we know all the
> link_event information from the very first LNKSTA read.
> 
> Bjorn

I understand your concern about the multiple LNKSTA reads and the
apparent duplication. Please see comments from Lukas.

Best Regards,
Shuai
















