Return-Path: <linux-pci+bounces-17155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C3B9D4C0A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 12:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9651F212D1
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 11:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D7B1CB316;
	Thu, 21 Nov 2024 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZSycXVH6"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07401C578C;
	Thu, 21 Nov 2024 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188889; cv=none; b=DN8aqKEtNOgVn0MlgL2KaH2uH1Y9hoBHshXp/F0b4sApsWQvlV+MdLncZcCDJh1tjW+QzvhCNErBVySR/iWTteCqdMR2i0UI1j6NKdMpg5ecLE/t9IA0PCGd6C6/uLMxAntDVTXnGDxhVucQ+lfhOSF2/0FozAK8hTBuqjJ9nGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188889; c=relaxed/simple;
	bh=vucmF/xedC4wjhdZeZ8wYdcTFDxnTsuYOSrTji52vVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3bTVbZAifKBBDCIXoSK9LyjQtMf5yvmsIgtLBvBFxLMSSEyrjXZeTkeStPrshhUskt7VdxiOHSwhvhkimeUMWMcQ8+LmZWEgT8W+N/dd9RNJ6igWoYp0RfG0gcVrTX/cMIjyXQOXjG4EiLevzTJMEJDwYq1YdBfBuPJiSb8ouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZSycXVH6; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732188876; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tInUvV9amHF6Ghq811sNVWZAtZ7ilPNUqZfPT4F1Dh4=;
	b=ZSycXVH6C0oe/M1Ber23hbbme6aVdaeiYyIHOuwTqYI/qMM8VQtEN2m12MajUAkG/5LKZHIMuwcbzExoY0qM61YZffEK5cXtMtOsABvfLGeA/SVCTwV6SQTZ81sQEm5Hx6eAExmzRu8Ek6uMWiz7EOJFHKNum2MMK9HM4n0eybE=
Received: from 30.246.161.197(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WJwtBb2_1732188873 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Nov 2024 19:34:35 +0800
Message-ID: <7002248c-f3af-42aa-ba42-a65cd738ae37@linux.alibaba.com>
Date: Thu, 21 Nov 2024 19:34:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org
References: <20241120124328.19111-1-xueshuai@linux.alibaba.com>
 <Zz786zZljAy2J5i7@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <Zz786zZljAy2J5i7@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/21 17:27, Lukas Wunner 写道:
> On Wed, Nov 20, 2024 at 08:43:28PM +0800, Shuai Xue wrote:
>> $ echo 1 > /sys/kernel/debug/tracing/events/hotplug/pci_hp_event/enable
>                                                ^^^^^^^
> I think this should now be "pci_hotplug" because you've renamed the
> TRACE_SYSTEM in v3.

Yes, you are right. Will fix it.

> 
> I'm wondering if we'll have other categories besides "pci_hp_event"
> below "pci_hotplug".  Maybe not.  Is it possible to omit the "pci_hotplug"
> and make "pci_hp_event" top level?  Or should this be grouped below "pci"
> instead of "pci_hotplug"?  I'm somewhat at a loss here as I'm not
> familiar with the conventions used in the tracing subsystem.

Sure, I can reorganize the directory. You have two optional proposals:

1. /sys/kernel/debug/tracing/events/pci_hp_event
2. /sys/kernel/debug/tracing/events/pci/pci_hp_event

I personally prefer the second approach. However, I'll defer the final decision
to the tracing subsystem maintainer, considering their expertise and
familiarity with the existing conventions.

> 
>  From a PCI hotplug perspective, this patch LGTM, so:
> 
> Reviewed-by: Lukas Wunner <lukas@wunner.de>


Thank you.

Best Regards,
Shuai

