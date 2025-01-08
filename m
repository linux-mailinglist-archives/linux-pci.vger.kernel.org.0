Return-Path: <linux-pci+bounces-19484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C07C3A04FDC
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 02:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB06C1654AA
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 01:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BF238DE3;
	Wed,  8 Jan 2025 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NjdW/bdh"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDE38F4A;
	Wed,  8 Jan 2025 01:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300868; cv=none; b=obqCZLbEGOXMZyVgwlyqW9OKUJS5v+sM1eOSqt3JliaOIj7eQ2MrfNNa2B7Z6U+8RJta/vRe957B//9cpm7fVA+Mv9rQs6oyh/jEFOqCuI9TjfrZd9Nbn2h3mx7TlR5rVB7ldaWz0WwU7rFaFYBsUk4J/9XUkgYLJoGt9q/HtUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300868; c=relaxed/simple;
	bh=vC1DPCdWFRHkCD6zvYZO4qD9ZrkFStN908SHZWzJYN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XecccyNNeOTiY8x+MqyiLCe3h7adrHHlNhKdvOGneT8eMsFXde4sDuZkcT5U8AIthZWxxvFcly6QY1Nc1Ooku4gWp7blE/iVZtuvnM0aMSSjDCDLl9VEc3RW3OZYnEzfPIkMFx4VYmNkkD0UpBu0jn/m50N6mUKYtJq4c8LM9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NjdW/bdh; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736300861; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ji00vlo07RTr6KchdayJquUqZkoLdmRMm41UALNM1a0=;
	b=NjdW/bdhwv5hHxxANaNGaSNvzVsGHCXEPS207MvFDCUAoPrK6Jwvw1cfAY2hiiupDNJW/Fi95SKv8z0kGPzecleNz30Nl+CTD2MwrphUJLZS2lNm9h/VFzLD0KKwjQXWwx1mYMc/ps49rKUIOn/vsqz5HpqBY49Bg0MSFeUpScg=
Received: from 30.246.161.230(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WNC7mWh_1736300858 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jan 2025 09:47:39 +0800
Message-ID: <2cc5fa71-ef31-4562-8f94-0753bf8724ca@linux.alibaba.com>
Date: Wed, 8 Jan 2025 09:47:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org, rostedt@goodmis.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20241123113108.29722-1-xueshuai@linux.alibaba.com>
 <f77669b5-c174-48c7-8f0f-187d1f54ea91@linux.alibaba.com>
 <Z30jxlgo63Js6G74@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <Z30jxlgo63Js6G74@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/7 20:53, Lukas Wunner 写道:
> On Tue, Jan 07, 2025 at 07:30:28PM +0800, Shuai Xue wrote:
>> 2024/11/23 19:31, Shuai Xue:
>>> To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
>>> tracepoint for hotplug event to help healthy check, and generate
>>> tracepoints for pcie hotplug event. To monitor these tracepoints in
>>> userspace, e.g. with rasdaemon, put `enum pci_hotplug_event` in uapi
>>> header.
> [...]
>> I would like to inquire that if there are any further actions required
>> from my end to proceed for this patch?
>>
>> Additionally, I would appreciate if you could inform me about who will be
>> pick up this patch.
> 
> I'm fine with this patch, as indicated by the Reviewed-by,
> so no actions required from you for now.  This will be
> picked up by Bjorn once he gets to it (assuming he's happy with it).
> A lot of folks were on holidays and are catching up on e-mails,
> so please be patient.
> 
> Thanks,
> 
> Lukas

Got it, thank you:)

Sorry for the noise.

Best Regards,
Shuai

