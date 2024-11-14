Return-Path: <linux-pci+bounces-16717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259F59C8012
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 02:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4FA1F22380
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 01:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D7A1CD1ED;
	Thu, 14 Nov 2024 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jgOUJShC"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2D2EAE4;
	Thu, 14 Nov 2024 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731548399; cv=none; b=LhSduSNdBw6jpGMQiuHIAHz2vwK5vLcTebXFdiABtgjjLYMZr2eeMEYMKJExH/9112H0nH+C0nVV2xJrOjvbP7BMxEndaE+vvbADHFXV29QEwfn1r4f5ouNUvthxf5TlZd2HsM+Tzja8cdHjgHqYYV7PCrTnrQ0yH/FWJTDggWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731548399; c=relaxed/simple;
	bh=a2A54SSr0c1qCs3nPKNXpeh+74Tjkff3eIbfFePWiIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QCrBGRz/TIPrfjP8T0WZ9Awy5OolYAspu0fuVh10+OE7NiQo9a54PgJs04P/A4076CoAB3qalXAHxupYiHLReV3IPYnPaeJ9bMT5vH9unzH5Gb7vJMUIFSySpDkHJrCEAhFqvZMDIZbj0dPjr9vl1+6iO0Aze5C/Egl6XFScB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jgOUJShC; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731548394; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=P/hSXpVdo7PKZdAhKmI1GzhFLT4SslowHaqGplbep/s=;
	b=jgOUJShCxLcQCXFvi25932L8X5Mr1hk8c0Vla4tC6AsHU8XSLY7s3r6ffCTd1imJoOxUwPqCEHdyXqZpQ0yfHmSnr2c0h/bs9WGDes6c4bI2lwfGCevfROduGnrypoQ88q9y+1K6gXoPlSctZ7QLQ0SvOBXo2gZJQPhR58lMgaM=
Received: from 30.246.162.170(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WJMVcJr_1731548392 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 09:39:53 +0800
Message-ID: <16bf61ae-fc95-4c44-a2b4-81f467537349@linux.alibaba.com>
Date: Thu, 14 Nov 2024 09:39:52 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, bhelgaas@google.com, tony.luck@intel.com,
 bp@alien8.de
References: <ZzTTgOoCSqfC4cVR@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <ZzTTgOoCSqfC4cVR@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/14 00:27, Lukas Wunner 写道:
> On Tue, Nov 12, 2024 at 07:58:51PM +0800, Shuai Xue wrote:
>> Hotplug events are critical indicators for analyzing hardware health,
>> particularly in AI supercomputers where surprise link downs can
>> significantly impact system performance and reliability. The failure
>> characterization analysis illustrates the significance of failures
>> caused by the Infiniband link errors. Meta observes that 2% in a machine
>> learning cluster and 6% in a vision application cluster of Infiniband
>> failures co-occur with GPU failures, such as falling off the bus, which
>> may indicate a correlation with PCIe.[1]
>>
>> Add a generic RAS tracepoint for hotplug event to help healthy check.
> 
> It would be good if you could mention in the commit message that
> you intend to use rasdaemon for monitoring these tracepoints
> and that you're hence adding the enum to a uapi header.
> So that if someone wonders later on why you chose a uapi header,
> they will find breadcrumbs in the commit message.

Got it, will add it.

> 
> I think both patches can be squashed into one.

Will do it.

> 
> I'm not an expert on tracepoints, so when respinning, perhaps you
> could cc linux-trace-kernel@vger.kernel.org and maybe also tracing
> maintainers so that subject matter experts can look the patch over
> and ack it.

Sorry, I forget it. Will add the maillist.

> 
> 
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM hotplug
> 
> Maybe "pci_hotplug" to differentiate this from, say, cpu hotplug?

Yes, will fix it.

> 
> 
>> +#define PCI_HP_TRANS_STATE					\
>> +	EM(PCI_HOTPLUG_LINK_UP,			"Link Up")	\
>> +	EM(PCI_HOTPLUG_LINK_DOWN,		"Link Down")	\
>> +	EM(PCI_HOTPLUG_CARD_PRESENT,		"Card present")	\
>> +	EMe(PCI_HOTPLUG_CARD_NO_PRESENT,	"Card not present")
> 
> PCI_HOTPLUG_CARD_NOT_PRESENT would be neater I think.

Ok, will rename it.
>                     ^
> 
>> +PCI_HP_TRANS_STATE
> 
> Not sure what "trans state" stands for, maybe "state transition"?
> What if we add tracepoints going forward which aren't for state
> transitions but other types of events, such as "Power Failure"?
> Perhaps something more generic such as "PCI_HOTPLUG_EVENT" would
> be more apt?
> 

I see, will rename as PCI_HOTPLUG_EVENT.

> 
>> +enum pci_hotplug_trans_type {
>> +	PCI_HOTPLUG_LINK_UP,
>> +	PCI_HOTPLUG_LINK_DOWN,
>> +	PCI_HOTPLUG_CARD_PRESENT,
>> +	PCI_HOTPLUG_CARD_NO_PRESENT,
>> +};
> 
> I note that this is called "pci_hotplug_trans_type", perhaps for
> consistency use "pci_hotplug_trans_state" as everywhere else
> (or whatever you choose to substitute the name for, see above).
> 
> Other than these cosmetic things, the patches LGTM.
> Again, my knowledge on tracepoints is superficial, but broadly
> it looks reasonable.
> 
> Thanks,
> 
> Lukas

Thank you for valuable comments.

Best Regards,
Shuai



