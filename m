Return-Path: <linux-pci+bounces-16405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7589C3639
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 02:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313621F21F2C
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 01:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846DE28691;
	Mon, 11 Nov 2024 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kvZOEWsk"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D20C8F5A;
	Mon, 11 Nov 2024 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731289364; cv=none; b=Gru9jBFchnLzznvEdFjRaVUSetCiKS9jsdAaJtIsraYDbbu1pHNXo3ZioIybMJ7pImjDWHHUF/9BDN3uungkU4T9bQ3KdGlL9XvCrR5eRaQ+yBbT9FTlKCxO19UNRK4LkoHSBC+Ftl60Ob+L49CS0OsYWq1ML68iCjD6pSU0+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731289364; c=relaxed/simple;
	bh=XFM0+DgNVWnshPxqXAOIqtQd01+vILyrVKMg3RIyUr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Up6BT+zP/nx3qljRRfYSzXP9dFZ7XoA0gMTKPfjCFcVsBYOIjNetMY+TajYtdRaOIwjNlNQYiSQHov1AwzDKHTDllf96TbDHMg5X8qZ5PsydoUsu4MtoxZikNnQYvBqqhn4KSmCOPG2JQzqxP4msVutsx7Lz1PoQ3maD/TYh1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kvZOEWsk; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731289353; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8VViukfjMbx2qqtiXdalQW0F8s5DDq8F+DsNpt/pbvw=;
	b=kvZOEWsk+eWooQl7qjdKFr4SmH7avUVpiLipNw8G+LG2WytwB/1VZQ816SfBGvc0QkGM98V3lOpV1fP5cmE9rLObFxaanQ751DT/IVYHwhVo4Ieb6kxGT1Y/14hxI5kj+P67lgd5lsejQ0TORLJjTXELSrvpGdVyt/SNTH4Qmcg=
Received: from 30.246.162.170(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WJ3wEC0_1731289351 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 09:42:32 +0800
Message-ID: <cf830c9d-2652-4fd1-aadc-03ed31fa0d5b@linux.alibaba.com>
Date: Mon, 11 Nov 2024 09:42:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] PCI: pciehp: Generate a RAS tracepoint for hotplug
 event
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, bhelgaas@google.com, tony.luck@intel.com,
 bp@alien8.de
References: <20241108030939.75354-1-xueshuai@linux.alibaba.com>
 <Zy-hbwLohwf-_hCN@wunner.de>
 <faccb715-8d9f-4761-855a-0fb8be2ebad4@linux.alibaba.com>
 <ZzDjBQaO2YjUlsjz@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <ZzDjBQaO2YjUlsjz@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/11 00:44, Lukas Wunner 写道:
> On Sun, Nov 10, 2024 at 06:12:09PM +0800, Shuai Xue wrote:
>> 2024/11/10 01:52, Lukas Wunner:
>>> On Fri, Nov 08, 2024 at 11:09:39AM +0800, Shuai Xue wrote:
>>>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>>>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>>>> @@ -19,6 +19,7 @@
>>>>    #include <linux/types.h>
>>>>    #include <linux/pm_runtime.h>
>>>>    #include <linux/pci.h>
>>>> +#include <ras/ras_event.h>
>>>>    #include "pciehp.h"
>>>
>>> Hm, why does the TRACE_EVENT() definition have to live in ras_event.h?
>>> Why not, say, in pciehp.h?
>>
>> IMHO, it is a type of RAS related event, so I add it in ras_event.h,
>> similar to other events like aer_event and memory_failure_event.
>>
>> I could move it to pciehp.h, if the maintainers prefer that location.
> 
> IMO pciehp.h makes more sense than ras/ras_event.h.
> 
> The addition of AER to ras/ras_event.h was over a decade ago with
> commit 0a2409aad38e ("trace, AER: Move trace into unified interface").
> That commit wasn't acked by Bjorn.  It wasn't even cc'ed to linux-pci:
> 
> https://lore.kernel.org/all/1402475691-30045-3-git-send-email-gong.chen@linux.intel.com/
> 
> I can see a connection between AER and RAS, but PCI hotplug tracepoints
> are not exclusively RAS, they might be useful for other purposes as well.
> Note that pciehp is not just used on servers but also e.g. for Thunderbolt
> on mobile devices and the tracepoints might come in handy to debug that.

Got it, will move it to pciehp.h

> 
>>> Wouldn't it be more readable to just log the event that occured
>>> as a string, e.g. "Surprise Removal" (and "Insertion" or "Hot Add"
>>> for the other trace event you're introducing) instead of the state?
>>>
>>> Otherwise you see "ON_STATE" in the log but that's actually the
>>> *old* value so you have to mentally convert this to "previously ON,
>>> so now must be transitioning to OFF".
>>
>> I see your point. "Surprise Removal" or "Insertion" is indeed the exact
>> state transition. However, I am concerned that using a string might make
>> it difficult for user space tools like rasdaemon to parse.
> 
> If this is parsed by a user space daemon, put the enum in a uapi header,
> e.g. include/uapi/linux/pci.h.

Will do it.

> 
> 
>> How about adding a new enum for state transition? For example:
>>
>> 	enum pciehp_trans_type {
>> 		PCIEHP_SAFE_REMOVAL,
>> 		PCIEHP_SURPRISE_REMOVAL,
>> 		PCIEHP_Hot_Add,
>> 	...
>> 	}
> 
> In that case, I'd suggest adding an entry to the enum for all the
> ctrl_info() messages, i.e.
> 
> Link Up
> Link Down
> Card present
> Card not present
> 
> Amend pciehp_handle_presence_or_link_change() with curly braces
> around all the affected if-blocks and put a trace event next to the
> ctrl_info() message.

Will do it.

> 
> Also, since these events are not pciehp-specific, I'd call the enum
> something like pci_hotplug_event and the entries PCI_HOTPLUG_...
> (or PCI_HP_... if you prefer short names).  These trace events could
> in principle be raised by any of the other hotplug drivers in
> drivers/pci/hotplug/, not just pciehp.

I see. Will rename with PCI_HP_ prefix.
> 
> Thanks,
> 
> Lukas

Thank you for valuable comments.
Best Regards,
Shuai


