Return-Path: <linux-pci+bounces-32918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69409B11772
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 06:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C18BC7A65BC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 04:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28DE235044;
	Fri, 25 Jul 2025 04:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="URfuyDGv"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B003BB67F;
	Fri, 25 Jul 2025 04:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753418025; cv=none; b=TI4N0GEByGmNDC1SOsmt+1qtSkIg2Y880xAm0uJz4tQ7JWCj2iWEQ/6gOBRzrzHGZs6P7ZzOgB7/geI9kPZeOUiUVmDqLeybEgTycuG5qtJkXB9EFgMc4IHqzSowEJr7yZHxWhS+Tz2RyqPniF5t0LgnINHxBZCDY0bZ1sAaSEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753418025; c=relaxed/simple;
	bh=DvCuXTcxb33ssJVUTsPMeqM9dealENq4lV3LnOgcXb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByjsF/qc62spjSwwc70K3nZ2itp8xGDnq2ZVnJFEsummyofl9yuJr+ChDhxkzOXJ/Td+jLCidxTntUTVuWqpi5HmVjRmELDGqcMnC4IzQkFZinUPsaSxTnHOa0ZS6zXnxXR8F7OEriNOfDYFZPC9MSZwO0zzKqDLL6NegcFmtoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=URfuyDGv; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753418013; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hgetHy/NDFvjaN9zFpcpTM6FZ0YncbaeFP6jCHxwjjs=;
	b=URfuyDGvuZKbYwnV7ILYL+ygQpblAgsQMJLLeFhZc/K9sw+HCOpqSnqhwx9yviohk14+f3N5FR5K116rKDgM5kWz2Uo8E5ff0X3R8nhvL1WC/VqlB/YfD6vOpoEuGFGRR18l43Tl/D6hMr2sVQnndlgqG6pVVqmjZ8LE6/YRRIU=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WjvnV7U_1753418010 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 12:33:31 +0800
Message-ID: <99e6c2f0-2790-4d23-85fa-15e137d4d2c5@linux.alibaba.com>
Date: Fri, 25 Jul 2025 12:33:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: rostedt@goodmis.org, lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bhelgaas@google.com,
 tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250724222759.GA3065374@bhelgaas>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250724222759.GA3065374@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/25 06:27, Bjorn Helgaas 写道:
> On Wed, Jul 16, 2025 at 05:25:33PM -0500, Bjorn Helgaas wrote:
>> ...
> 
>> Anyway, I applied this on pci/trace for v6.17.  If there's anything
>> you want to tweak in the commit log or event text, we can still do
>> that.
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=trace
> 
> Given the ongoing discussion, I deferred this series so we don't end
> up adding trace events and immediately changing them next cycle.
> 
> Bjorn

Hi, Bjorn,

Thank you for the thoughtful decision to defer the series.

Please review v9 when you have a chance:

	https://lore.kernel.org/all/20250723033108.61587-1-xueshuai@linux.alibaba.com/

I believe it addresses the concerns raised in the discussions.

Thanks.
Shuai

