Return-Path: <linux-pci+bounces-38696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948EBBEF030
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 03:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5441C3B7C20
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 01:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391A51DD9AD;
	Mon, 20 Oct 2025 01:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A/I4KpPu"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17D6381C4;
	Mon, 20 Oct 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760923998; cv=none; b=Qfd/2rSwTKQbLpC4HMSi9mo7AG/oec6b5LVNINxljvaJoxSnaBlsga2eIAXvDdC/CtMp4MJ7H8QlxfzZacYbB73QZ4aF9aGuAhGC5lqUd/yINxrab7QM2/jrEFHr8QeoYTqci/LtvHRpiH7fR+p5EQP5rgtaJAhc3CX8DOgngJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760923998; c=relaxed/simple;
	bh=ofk02Di0z7QJ5R5tyn++24FCaI4zjVFa0YuHthRB/eU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:Cc:
	 In-Reply-To:Content-Type; b=Mk4z0E7hbknRtfvmU/DYliMGH/KvnrNmYak+6xqzytdaE/mRJp8J7oE7ieP1al8gJeX6v6VMLIrO9u1GhpgBRe13QIYGMNVBZQWXqMLBCqrhLufAV2Ivg5mCKLkCWiYByaicMQUfCEZSi6HUcNrWCFErG3jbHsbfAPphZLlE43M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A/I4KpPu; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760923986; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=8HtiQ1/6jPC4jIfRpjGfQyv2Kxh6q4GRK1n+lo+1Quc=;
	b=A/I4KpPuM66y0Yb1pPQDHerJgcSpO+wJSU5F+VFgGfQLO+bDfs9IhWnJsCcR0OjIhNKaNNTnYPXJCK5Z/xL1Wov7T9tkyH2+BBeOQ967KRKuO7F/DkeRbo+eMr/JL+YIw//J3RVlwiKU9m/8lr2HqEO5s1xLB86vdJzXCKt+EuM=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqVPDBo_1760923983 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Oct 2025 09:33:04 +0800
Message-ID: <82098b0d-d460-4657-9db6-3721dcc9a162@linux.alibaba.com>
Date: Mon, 20 Oct 2025 09:32:59 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v12 1/3] PCI: trace: Add a generic RAS tracepoint for
 hotplug event
To: Steven Rostedt <rostedt@goodmis.org>
References: <20251014123159.57764-1-xueshuai@linux.alibaba.com>
 <20251014123159.57764-2-xueshuai@linux.alibaba.com>
 <20251014114029.4c59bb1a@gandalf.local.home>
 <b6353617-048a-4e12-a1d4-6d1484619927@linux.alibaba.com>
 <20251015103757.3d6f6cf7@gandalf.local.home>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com, bhelgaas@google.com, tony.luck@intel.com,
 bp@alien8.de, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
 anil.s.keshavamurthy@intel.com, mark.rutland@arm.com, peterz@infradead.org,
 tianruidong@linux.alibaba.com
In-Reply-To: <20251015103757.3d6f6cf7@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/15 22:37, Steven Rostedt 写道:
> On Wed, 15 Oct 2025 14:29:07 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> Hi, Steve,
>>
>> Thank you for your suggestion about passing the controller directly to
>> the trace event. I investigated this approach, but unfortunately we
>> cannot implement it due to structural limitations in the PCI hotplug
>> subsystem.
> 
> Ah, that makes sense. Perhaps add a comment about this by the TRACE_EVENT()
> so that I don't recommend this again ;-)
> 

Hi Steve,

Got it, will add a comment.

If you don't have any other concerns with this patch, would you mind
adding your Reviewed-by tag?

> -- Steve

Best Regards,
Shuai


