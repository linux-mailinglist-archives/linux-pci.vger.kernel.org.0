Return-Path: <linux-pci+bounces-32916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF33B11701
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 05:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F39EF7AB009
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 03:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA42226D0C;
	Fri, 25 Jul 2025 03:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lO47ubIk"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49A2746A;
	Fri, 25 Jul 2025 03:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753413663; cv=none; b=nHZsbpPPyaR1foz1ZXbSaZF0pr8XLTk4UXshuTcN5t7cguJ/p/Q1wZxhDWUtdL4mGDkYUTdqlAOw18B2G0MEJwI1pcZVUa66JSi1pZrfrouk4jXlzHDr9L0M6mzgUbwkuDkh3/gth73cVwgmxFd8Zdfbl9/cHBNSa+Mk72nNw2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753413663; c=relaxed/simple;
	bh=Ks8PD4/+GKfDJQjYfODLfjfLRa2F6HI0MpMsPYaHyNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5Yn3Q9m0E99U0ENhnfFlzWwsmnkRt5tXye1NN2xD0Kyrvszuxk796REE+hjNjQrh/ZJlbbqC0S8OKQwEEKwIXr6+At5j8qqN+8esEz0jkC/qNGYADpNsKWODmRFA3wlhQNTiCN3Ov1S4QxInxco24iLtl5i/AoNXOk3RLNrftc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lO47ubIk; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753413652; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VtZStHR034jpixzNWekXCnzaXZ2lgorBS+o9tGPWUbM=;
	b=lO47ubIkOHaKrqv2WndCHn5b6rJBR2FWXUm8CK5Mep1Pgl3t/Hu3D2wFIEumnu/L2oJqR0s2QSaW+xbuyW2cZnUdc6CDBreDB1QM+qfSSxxqxwG3BeeyiVrV6/AFKQVXI4tLQP2OYInLhWakMkv8x8joGMdXBZ23Gv5kZmRfjwQ=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wjv3y4v_1753413325 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 11:15:27 +0800
Message-ID: <bcc697cb-bee6-4295-8488-8ad6b46491cf@linux.alibaba.com>
Date: Fri, 25 Jul 2025 11:15:25 +0800
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
 <d87b1029-b572-4995-82a9-c7d83551900e@linux.alibaba.com>
 <20250724230647.1875702f@gandalf.local.home>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250724230647.1875702f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/25 11:06, Steven Rostedt 写道:
> On Fri, 25 Jul 2025 10:59:16 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> Thank you so much for the detailed guidance and the excellent example!
>> This makes it much clearer how to implement the libtraceevent support.
>>
>> Should I include the libtraceevent plugin patch in the same kernel patch
>> series, or submit it separately? I'm not sure about the best practice
>> here.
> 
> No, libtraceevent lives outside the kernel tree.
> 
>>
>>>
>>> -- Steve
>>
>> I'll work on the libtraceevent patch and submit it according to your
>> guidance. Thanks again for the clear direction and the documentation
>> link!
> 
> Make a patch against: git://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git
> 
> Follow the same procedure as you would for submitting to the linux kernel,
> but instead of sending it to LKML, send it to: linux-trace-devel@vger.kernel.org
> 
> You don't even need to Cc me. I'll get it from that mailing list.
> 
> Patchwork is here: https://patchwork.kernel.org/project/linux-trace-devel/list/
> 
> -- Steve

Hi Steve,

Perfect, thank you for the clear instructions!

I'll work on the plugin and submit it to the trace-devel list once this
patch set is merged in upstream.

Thanks again for all the guidance!
Best regards,
Shuai


