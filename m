Return-Path: <linux-pci+bounces-32913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A032B116C8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 04:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5AE5A1435
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 02:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1F9238C11;
	Fri, 25 Jul 2025 02:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f5CFj9sX"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1C7236431;
	Fri, 25 Jul 2025 02:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753412365; cv=none; b=Ab7FyDDYPt0RhkQcAqimsyErKJR19g7kWlqiMW3+el2KGkz9GQ89r9Yfhs2+pXBmPq1+qkKR87StlRXR1yVR/mnWcUTUmUaPN829QehG8FCR+/xZa2fGGRS35k9+9s6clqupkUXlLDu3+HgTRhk2S49775Wh2/XSm2BoGXbsZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753412365; c=relaxed/simple;
	bh=8exFeMWBFjBwAGhQy1yCpCEe3ewba/ziDS+LBKSq1i8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdcUUJkZ19hgirg7MWLNEbBT2Si9ltPLmfruuiF8O/dVqvghNezbe3P+xMX/R3IuvM8+ehDMKZBBjABZaPsAxa75fsekdF6oDL36fE9VY8DIzcT3UtZGciJMlUg94srBAPP5WmmgK/MTsMZdaavfJynAWXdugrB+mMa3RPLpdSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f5CFj9sX; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753412360; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Iv5xiIaVXnRlWY2yuS29Q5y+R/jOh7G7miW9asrp4AE=;
	b=f5CFj9sXbEbC8AqF5hm+4o8NLkYbSAd3jRG0EbBVjc80MAes9p/Yvq/dAkXuu7V24mi9W8MqjpJ/VifO2pvgGuH/xppJOAzrxN0BfGnGBBx/1BdbSKII2crIMPs6EQJpkrlr5dk3SBx00shDn2vO3yuLLcL1yIXKr05XPwJNoLs=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wjv8nHq_1753412357 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 10:59:18 +0800
Message-ID: <d87b1029-b572-4995-82a9-c7d83551900e@linux.alibaba.com>
Date: Fri, 25 Jul 2025 10:59:16 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com, bhelgaas@google.com, tony.luck@intel.com,
 bp@alien8.de, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
 anil.s.keshavamurthy@intel.com, mark.rutland@arm.com, peterz@infradead.org,
 tianruidong@linux.alibaba.com
References: <20250723033108.61587-1-xueshuai@linux.alibaba.com>
 <20250723033108.61587-3-xueshuai@linux.alibaba.com>
 <20250723100559.7f0adb3c@batman.local.home>
 <0611d06d-e198-4617-a0ba-3050ca6191c6@linux.alibaba.com>
 <20250724222510.7b00ea79@gandalf.local.home>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250724222510.7b00ea79@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/25 10:25, Steven Rostedt 写道:
> On Fri, 25 Jul 2025 10:11:10 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> For the libtraceevent implementation, I believe we'd
>> need to:
>>
>> - Add the PCI speed mapping table to libtraceevent
>> - Create a print function similar to other existing parsers
>> - Ensure perf, trace-cmd, and rasdaemon can all benefit from it
>>
>> Would you like me to investigate the libtraceevent changes, or do you
> 
> Yeah, just update libtraceevent. In fact, libtraceevent has plugins for
> things like this.
> 
> You can use this as an example:
> 
>    https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/tree/plugins/plugin_jbd2.c
> 
> That adds two functions that are used in print fmt strings. Here's one:
> 
> static unsigned long long
> process_jbd2_dev_to_name(struct trace_seq *s, unsigned long long *args)
> {
> 	unsigned int dev = args[0];
> 
> 	trace_seq_printf(s, "%d:%d", MAJOR(dev), MINOR(dev));
> 	return 0;
> }
> 
> 
> int TEP_PLUGIN_LOADER(struct tep_handle *tep)
> {
> 	tep_register_print_function(tep,
> 				    process_jbd2_dev_to_name,
> 				    TEP_FUNC_ARG_STRING,
> 				    "jbd2_dev_to_name",
> 				    TEP_FUNC_ARG_INT,
> 				    TEP_FUNC_ARG_VOID);
> [..]
> 
> The above defines:
> 
> 	char *jbd2_dev_to_name(int arg0);
> 
> And when this is found in the parsing, it calls process_jbd2_dev_to_name()
> passing it the arguments that was found in the trace.
> 
> You would have something like:
> 
> 	tep_register_print_function(tep,
> 				    process_pci_speed_string,
> 				    TEP_FUNC_ARG_STRING,
> 				    "pci_speed_string",
> 				    TEP_FUNC_ARG_INT,
> 				    TEP_FUNC_ARG_VOID);
> 
> Which will return a string and take an integer as an argument. Then you
> would just implement the process_pci_speed_string() function to do the same
> thing as the pci_speed_string() does in the kernel.
> 
> Oh, and here's the man page for you on tep_register_print_function()
> 
>    https://trace-cmd.org/Documentation/libtraceevent/libtraceevent-reg_print_func.html

Hi Steve,

Thank you so much for the detailed guidance and the excellent example!
This makes it much clearer how to implement the libtraceevent support.

Should I include the libtraceevent plugin patch in the same kernel patch
series, or submit it separately? I'm not sure about the best practice
here.

> 
> -- Steve

I'll work on the libtraceevent patch and submit it according to your
guidance. Thanks again for the clear direction and the documentation
link!

Thanks.
Shuai

