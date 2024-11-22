Return-Path: <linux-pci+bounces-17192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E73D49D5963
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 07:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86752B20D7B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 06:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B23A15E5CA;
	Fri, 22 Nov 2024 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ElM9F3yH"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3222081;
	Fri, 22 Nov 2024 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732256750; cv=none; b=VtRvCnMsnCxV1mtM4uxjn0aiTPzHa85Y86LQjrXMOQwtVu8A+UP+veK14Q47CfMIMwNSEMxmmsGuUis+Pn8l46F5kj7aFRjt3aPkWiWrEFodnrBxaoXm5+Ywm++Gc6LWyvKtl5y1vu86LYEpcryoNwoxBLg7aQNqWFmzN9gtTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732256750; c=relaxed/simple;
	bh=JLGGC2upSRBy4NpebIatpx8yC3XQt7hVH/2hVqksfPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmqN1L90Uf6BIUSbg+wlX1Ql9vpIkK/ZbFWpmAIi5vHOolfz9W3xiGzjFelrNmscLhwdMMYt+khc7TA7mRNO/uIG4EYaqcCcGJDBQJg3kIUB8qrUFTtfWeaQBsGqZ5SmXvhdUwtzvSS4LaP4OcjF8Al8KENRXeIrztdGNZ5F7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ElM9F3yH; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732256737; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nnbly2k9u+G1ysjd0T5docpjLl2DZDHcRC0xrhPVEsM=;
	b=ElM9F3yHEeeqzbXFv4SnhcMYfFdYim22+rYUk5qraM3YZlPOKSegJizE4r41oCYzyPGjzv9cgrASxtKJhPQCSZj0YmyKmKFb/NG9zCCkccyDtYGe3q6hyMBi7AF7gSZwgPun3jm8yuIVjhHFP3d/3ssZM1XQTtMkYFD5e7RU6BI=
Received: from 30.246.161.197(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WJzY5u4_1732256734 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 22 Nov 2024 14:25:35 +0800
Message-ID: <e96ed0ee-01c8-4429-a903-17bc7813d78a@linux.alibaba.com>
Date: Fri, 22 Nov 2024 14:25:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Steven Rostedt <rostedt@goodmis.org>, Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org
References: <20241120124328.19111-1-xueshuai@linux.alibaba.com>
 <Zz786zZljAy2J5i7@wunner.de>
 <7002248c-f3af-42aa-ba42-a65cd738ae37@linux.alibaba.com>
 <20241121084354.4a554829@gandalf.local.home> <Zz-9vviSWP8oRPUx@wunner.de>
 <20241121190826.78506b40@gandalf.local.home>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241121190826.78506b40@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/22 08:08, Steven Rostedt 写道:
> On Fri, 22 Nov 2024 00:09:50 +0100
> Lukas Wunner <lukas@wunner.de> wrote:
> 
>> Would something like
>>
>>    /sys/kernel/debug/tracing/events/pci/hotplug_event
>>
>> be possible?  It would seem more elegant than
>>
>>    /sys/kernel/debug/tracing/events/pci/pci_hp_event
>>
>> because it avoids the duplication of "pci" in the path.
> 
> Most events have the name of the system in it (see the sched events).
> That's to prevent the duplicates in other places. Also, in the trace
> output, only the event name is shown and not the system. That is, if you
> have more than one "hotplug_event" enabled, the trace will not
> differentiate them.
> 
> My suggestion is the "pci_hp_event" as it will be more obvious in the trace
> output.
> 
> -- Steve

Agreed. pci_hp_event is more reasonable. Than is:

- system: pci
- event: pci_hp_event

/sys/kernel/debug/tracing/events/pci/pci_hp_event

@Lukas, if you have any other concerns, please let me know.


Thank you.
Best Regards,
Shuai

