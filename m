Return-Path: <linux-pci+bounces-23398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0264CA5B66E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 03:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E71171B70
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 02:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932ED1E32C3;
	Tue, 11 Mar 2025 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zhc8taC7"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D323FD1;
	Tue, 11 Mar 2025 02:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741658826; cv=none; b=QpamHjAlJBEWxCUvi6tFWLOmIux8yoOxdNQ72/HT9bfsKyF6zqysudnB7H258CvX4ATTgF/Ykf6WczRIeQlZD+dFEXIxW/dcW3OaLcmGmOAD9fBLKXitPC4hz1LKjZ7DNz+GiaTCgkFhEpXWoMQOl2PW0BMIVLjHOHNHPMM+S8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741658826; c=relaxed/simple;
	bh=z6jVo03j7ZbrcOq9bBY8qnIpoBkz5o6+15aKdHE31EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SghBUYtJZEjE9w3T0LVupL0S1ALgolZAGvRu7c1petUwEvIQ8TXiy31RMvQCRjNAovTCxI3cSqEhJ7A6YviiBlDGkcBWsA9pttpUZH+suX3QKNXgya7kw3kxRrgtOhbaCGbA1jxd5jEiWRHyYqKYUZXPxaIKzQtr0DP2jpKKBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zhc8taC7; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741658819; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BzglBtV+XA2a3PeBuIhCqkESUNYrOmlDABzPylPcK5w=;
	b=Zhc8taC7P9/Vc4IPGJCdNWp7AvNo3j5UUAusoCH7u5pFUXHvrYF2uZNVIjtbBa+R8JYeGHT4dUVRi110e7pZ4j8iydYjHt0GrsoZLht4UgWBNsnN/ZxC/qS0Kr/Vn6o1eo8EjNXgv9obFmQxMfT7C/GC3+sjqBGlytYh4azfxLs=
Received: from 30.221.130.118(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WR7LvPK_1741658816 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Mar 2025 10:06:57 +0800
Message-ID: <47785d3f-3560-4832-b88a-031a80d1fd28@linux.alibaba.com>
Date: Tue, 11 Mar 2025 10:06:56 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250109025543.56830-1-xueshuai@linux.alibaba.com>
 <20250113155503.71467082@gandalf.local.home>
 <deb6f0c4-77b8-431e-9b81-555a8344c750@linux.alibaba.com>
 <20250310105044.129dc354@gandalf.local.home>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250310105044.129dc354@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/10 22:50, Steven Rostedt 写道:
> On Mon, 10 Mar 2025 11:59:55 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> Hi, Steve,
>>
>> If I move PCI_HOTPLUG_EVENT into one place, `include/upai/linux/pci.h`,
>> I need to include:
>>
>>       #include <linux/tracepoint.h>
>>
>> Then, kernel build fails with CONFIG_UAPI_HEADER_TEST=y:
> 
> Just move the enum definitions, not the entire event file.
> 
> That is, have one place has the PCI_HOTPLUG_EVENT macro, and have both the
> uapi header as well as the tracepoint header include that header.
> 
> I guess I need to see the entire change.
> 

Hi, Steven,

IMHO, the problem is that the PCI_HOTPLUG_EVENT macro needs to include
"linux/tracepoint.h" but it is not allowed in userspace.

The entire change in v6 build fails with CONFIG_UAPI_HEADER_TEST=y:

   https://lore.kernel.org/lkml/202501190108.tRReJA1Z-lkp@intel.com/T/#mae507b91b8b80c386dfa9e63fbbdd45826c2e003

(sorry, I did not see the problem because my local .config do not set
CONFIG_UAPI_HEADER_TEST)

Thanks
Shuai

