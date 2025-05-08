Return-Path: <linux-pci+bounces-27404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 980DBAAF09A
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 03:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC42A1B67CA9
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 01:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F1319309C;
	Thu,  8 May 2025 01:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q6OC6qNg"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F513C3F2;
	Thu,  8 May 2025 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667482; cv=none; b=Zr3F7JWV2DktPCJMVl0uKjACCkw7JbLpSAj0S44j97JftiPM+DP25cg+MpB9cA7YrsqabPiKMlk/KAA1ykgOtB24bxCV1P2z3Z22e4fSUm0W5I+xG3AtYOnvnrVeY91I9ZqlF11zwnt+h6snelPGGIF7ihRFWMcxpnoG5kjCyDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667482; c=relaxed/simple;
	bh=EhF0llYdqGK60ORKlAprxRI2CL2OWwYfHeHyGp3KMLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeYI50DdnVtN4vahTTkwyoCJBbQLbgNlke8CD10AOVxq60dIoFmqxAEvEwFM2yfVC2JbO2J/EV/UY0zxxpMW9aGTGdWosiM5zCC5Y5MnnHPMy5v2bLh/EPEdJzSvS3QMEVqSjJRiGSpBa4q7l6u+VSB8haYhaQF7Q2QbAYUrgKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q6OC6qNg; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746667475; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=r4FU8gNcJdDpKvrEL7EBVa/9XS+jcvfW76Wrf2Th1qI=;
	b=q6OC6qNgSF3wHVJ8AG8SyMd8o0owFgAwtb5rxGwT9SdFKtZ8Pd+x/Vpf/oWemx1H1bn2gXxRLz/ThVXjEDvlBPq4g++FrO9L8uGiwp3YYAoygQMTBgPKrUajhQHJzAdu3lXqydmCA4CcA0IeghjBxUE3d5mxrg5LMEgDDg3L50g=
Received: from 30.246.160.110(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WZyCaZY_1746667472 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 May 2025 09:24:33 +0800
Message-ID: <f88d35e2-c739-4432-a7fa-35c8a2dd2e9a@linux.alibaba.com>
Date: Thu, 8 May 2025 09:24:32 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250507011535.43800-1-xueshuai@linux.alibaba.com>
 <20250507113640.0b27d95f@gandalf.local.home>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250507113640.0b27d95f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/7 23:36, Steven Rostedt 写道:
> On Wed,  7 May 2025 09:15:35 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> +#endif /* _TRACE_HW_EVENT_PCI_HP_H */
>> +
>> +#undef TRACE_INCLUDE_PATH
>> +#define TRACE_INCLUDE_PATH  ../../drivers/pci/hotplug
> 
> Note, this is not always safe to do. If "drivers", "pci" or "hotplug" ever
> become a macro, the path will also be updated, and this will fail to build.
> 
>> +#undef TRACE_INCLUDE_FILE
>> +#define TRACE_INCLUDE_FILE trace
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>> diff --git a/include/uapi/linux/pci.h b/include/uapi/linux/pci.h
> 
> The safer way to do this is to have:
> 
> In drivers/pci/hotplug/Makefile:
> 
> CFLAGS_pciehp_ctrl.o := -I$(src)
> 
> And replace the TRACE_INCLUDE_PATH to:
> 
> #define TRACE_INCLUDE_PATH .
> 
> -- Steve

Got it. Will fix it in next version.

Thanks.

Shuai

