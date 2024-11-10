Return-Path: <linux-pci+bounces-16380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2719C318A
	for <lists+linux-pci@lfdr.de>; Sun, 10 Nov 2024 11:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE622817C6
	for <lists+linux-pci@lfdr.de>; Sun, 10 Nov 2024 10:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808631534FB;
	Sun, 10 Nov 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ax4X/MJW"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7875914264A;
	Sun, 10 Nov 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731233544; cv=none; b=pGrVQFawn7qevGgr785qMm/KFqCBpZ8sttCx7qYI1NyJ19qokaCmEyfzLtCk0YObrWqKa+b7YNvthS/B8KsJ1iN/d0CyoSp19xtkV/sdqyxdjRVtpc0ZgHFzPg4yT3UJ+N6W/qjLo0VN0ODNj7/OeEQvrZZeU/1ebs1ckvghF+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731233544; c=relaxed/simple;
	bh=QMjMp7BR5MB0OOm8XJfoI23UUhzdB6Mcvc+azu+SEH4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IHLWviH5RpmsiZUpn7yLiNmyTFn2QftrfQaops6SAbmc/T4lkK23tA5aE3tKH64ab1JWew2S2MM5rzymWNl/GlgziiQteuGauo3Qp0sUszRSMtQ6+VotAtDzL5bUvz7lpBzxHrZEmeaHj4ZsIAGYCUDWuBeEMEw9RxQFnRqSMq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ax4X/MJW; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731233531; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=o5Y8PKrty30UjY9+NIazgy7rrfgHtN8kD0lwJP9nY+U=;
	b=ax4X/MJW8JLtAPKAIR6Va04fseTOEhx58Ei1N3C/pP/aDxNsQmYY487141Fv5dZTaeV1Ga3kNQZLiCt2jo44Vt/jWB+8alTaGUgsFQvCZSEJ/S80i9CDk4q/5amYfEdDpP5rmjfvDjS9P+5DvdwnXPWgwvW4AvcruDAaaf/M6dQ=
Received: from 30.246.162.170(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WJ2WLGS_1731233530 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 10 Nov 2024 18:12:11 +0800
Message-ID: <faccb715-8d9f-4761-855a-0fb8be2ebad4@linux.alibaba.com>
Date: Sun, 10 Nov 2024 18:12:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [RFC PATCH] PCI: pciehp: Generate a RAS tracepoint for hotplug
 event
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, bhelgaas@google.com, tony.luck@intel.com,
 bp@alien8.de
References: <20241108030939.75354-1-xueshuai@linux.alibaba.com>
 <Zy-hbwLohwf-_hCN@wunner.de>
In-Reply-To: <Zy-hbwLohwf-_hCN@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/10 01:52, Lukas Wunner 写道:
> On Fri, Nov 08, 2024 at 11:09:39AM +0800, Shuai Xue wrote:
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/types.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/pci.h>
>> +#include <ras/ras_event.h>
>>   #include "pciehp.h"
> 
> Hm, why does the TRACE_EVENT() definition have to live in ras_event.h?
> Why not, say, in pciehp.h?

IMHO, it is a type of RAS related event, so I add it in ras_event.h, similar to
other events like aer_event and memory_failure_event.

I could move it to pciehp.h, if the maintainers prefer that location.

> 
>> @@ -245,6 +246,8 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>   		if (events & PCI_EXP_SLTSTA_PDC)
>>   			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>>   				  slot_name(ctrl));
>> +		trace_pciehp_event(dev_name(&ctrl->pcie->port->dev),
>> +				   slot_name(ctrl), ON_STATE, events);
>>   		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
>>   		break;
>>   	default:
> 
> I'd suggest using pci_name() instead of dev_name() as it's a little shorter.

Will use pci_name() instead.

> 
> Passing ON_STATE here isn't always accurate because there's
> "case BLINKINGOFF_STATE" with a fallthrough preceding the
> above code block.

Yes, you are right, I missed the above fallthrough case.

> 
> Wouldn't it be more readable to just log the event that occured
> as a string, e.g. "Surprise Removal" (and "Insertion" or "Hot Add"
> for the other trace event you're introducing) instead of the state?
> 
> Otherwise you see "ON_STATE" in the log but that's actually the
> *old* value so you have to mentally convert this to "previously ON,
> so now must be transitioning to OFF".

I see your point. "Surprise Removal" or "Insertion" is indeed the exact state
transition. However, I am concerned that using a string might make it difficult
for user space tools like rasdaemon to parse.

How about adding a new enum for state transition? For example:

	enum pciehp_trans_type {
		PCIEHP_SAFE_REMOVAL,
		PCIEHP_SURPRISE_REMOVAL,
		PCIEHP_Hot_Add,
	...
	}

And define the state transition as a int type for tracepoint, then rasdaemon
can parse the value easily.

	trace_pciehp_event(pci_name(&ctrl->pcie->port->dev),
		slot_name(ctrl), PCIEHP_SAFE_REMOVAL, events);

And TP_printk with symbolic name of the state transition.

	TRACE_EVENT(pciehp_event,
		TP_PROTO(const char *port_name,
			 const char *slot,
			 const int trans_state),
	
		TP_ARGS(port_name, slot, trans_state),
	
		TP_STRUCT__entry(
			__string(	port_name,	port_name	)
			__string(	slot,		slot		)
			__field(	int,		trans_state	)
		),
	
		TP_fast_assign(
			__assign_str(port_name, port_name);
			__assign_str(slot, slot);
			__entry->trans_state	= trans_state;
		),
	
		TP_printk("%s slot:%s, state:%d, events:%d\n",
			__get_str(port_name),
			__get_str(slot),
			__print_symbolic(__entry->trans_state, PCIEHP_SURPRISE_REMOVAL),
	);

> 
> I'm fine with adding trace points to pciehp, I just want to make sure
> we do it in a way that's easy to parse for admins.

Thank you for the positive feedback :)

> 
> Thanks,
> 
> Lukas

Best Regards,
Shuai

