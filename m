Return-Path: <linux-pci+bounces-28265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8199DAC0909
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 11:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56D31BC536A
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D062874FA;
	Thu, 22 May 2025 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lbB3aUWk"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D45C2874FF;
	Thu, 22 May 2025 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747907415; cv=none; b=BUtE1v7oDWzPmHNYSQxhgIa8yQXZETBIosGeyRJAaHdqCnZrncxs+WOjx0/B+yb5lAjghTDxIYrbZTcCf9SFC0o46ezkrKAxy69JRHDWr8smuUMtoj8b0ohYf94k5pU0TYfYtHeqsNZNSQjHb7W5lNgcz/QiEFpDhgbthtCEEU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747907415; c=relaxed/simple;
	bh=uPadcDFqW+Afu3AbepXbHpMk1HbClZeMosDyjvWtlYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNA6z73DSHOQZmd6/AMJSU2Vnbg2K08lwKBzI6O4i4v349TcpgXnGYPqRTK6jISGLk0lPRR5snI2fpM6yozxrw8gRsAYduPw+J9gSSOQHSKFOlxM8FVttiKf67XVZLhnII+uzheEcBLsEq7Wcrh72hzvQH4XxQ/jV+RazIdfxkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lbB3aUWk; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747907409; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/p1NvwJmGvZf2d3EV2BZV35xlq2dlz85bhtTTGKN46A=;
	b=lbB3aUWkBgNy2YJ+JqhVXvuTm/SmxDpuJUyNfNm4RZYW7E4GGlu7HbnyoKvucf9gvz7rELkUQPAMvjDTJWtIlpUMndU8cllWATNAHxSwAxiL46yOP0DpAV+QOwTloJ35znZz0Z19sQsxNjGG5jk9A1q3mnAMhRlMvisEnCubuD4=
Received: from 30.246.160.208(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WbVZBx-_1747907406 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 May 2025 17:50:07 +0800
Message-ID: <6af283ea-bd36-44a7-949a-2ab8c80cf136@linux.alibaba.com>
Date: Thu, 22 May 2025 17:50:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Lukas Wunner <lukas@wunner.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: rostedt@goodmis.org, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, helgaas@kernel.org, bhelgaas@google.com,
 tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250512013839.45960-1-xueshuai@linux.alibaba.com>
 <87b1f8c6-bd72-b1a8-40a6-bbf552552806@linux.intel.com>
 <650cd4e4-561b-4d50-9cf2-c601518c9b9f@linux.alibaba.com>
 <31693574-e8bc-9a56-bad0-6a22280c4b6b@linux.intel.com>
 <aCxdFm_BpgOTFFUv@wunner.de> <aCxxA-4HEnZ-O2W0@wunner.de>
 <9b46a12b-90e2-c1ba-9394-5caa23a5cad7@linux.intel.com>
 <aCx_aXy9MEs6XKZE@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aCx_aXy9MEs6XKZE@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/20 21:11, Lukas Wunner 写道:
> On Tue, May 20, 2025 at 03:52:56PM +0300, Ilpo Järvinen wrote:
>> On Tue, 20 May 2025, Lukas Wunner wrote:
>>> A link speed event could contain a "reason" field
>>> which indicates why the link speed changed,
>>> e.g. "hotplug", "autonomous", "thermal", "retrain", etc.
>>>
>>> In other words, instead of mixing the infomation for hotplug
>>> and link speed events together in one event, a separate link
>>> speed event could point to hotplug as one possible reason for
>>> the new speed.
>>
>> It will be somewhat challenging to link LBMS into what caused it,
>> especially in cases where there is more than one LBMS following a single
>> Link Retraining.
>>
>> Do you have opinion on should the event be only recorded from LBMS/LABS
>> if the speed changed from the previous value? The speed should probably
>> also be reported also for the first time (initial enumeration, hotplugging
>> a new board).
> 
> One idea would be to amend struct pcie_bwctrl_data with an
> enum member describing the reason.
> 
> pcie_bwnotif_irq() uses that reason when reporting the speed change
> in a trace event.
> 
> After an Endpoint has been removed, the Downstream Port or Root Port
> above resets the reason to "hotplug", so that the next link event
> is assigned that reason.
> 
> Similarly pcie_set_target_speed() could be amended with an enum argument
> for the reason and it would set that in struct pcie_bwctrl_data before
> calling pcie_bwctrl_change_speed().
> 
> Thanks,
> 
> Lukas

Hi Lukas and Ilpo,

Thank you for the discussion.

As @Lukas points out, link speed changes and device plug/unplug events are
orthogonal issues.

Based on this thread discussion, I believe we need additional tweaking to
introduce a new tracepoint (perhaps named PCI_LINK_EVENT) to handle
link speed changes separately.

Regarding our next steps, would it be acceptable to merge the
PCI_HOTPLUG_EVENT to mainline first, and then work on implementing
the new link event tracepoint afterward?

Best regards,
Shuai

