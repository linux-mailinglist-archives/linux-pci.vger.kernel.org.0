Return-Path: <linux-pci+bounces-27371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6747CAADDFF
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 14:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF24C502FC0
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 12:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514AF257AD3;
	Wed,  7 May 2025 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="amRANy8W"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B41FF7B4;
	Wed,  7 May 2025 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619421; cv=none; b=B7buI/9BLs/+sJKqGJtlYLbkzZ8psNWB4v/KJcMSTGiMDnpp64ToADujAGzBLv4GQeO3bk4ZEfmzZp0+/KE3DbhnJOgrsVbXkmkQoDgA3dAanxqVoArF5Agm5HV3YVwvTFigwNjHeC1AdUyMSvkC0Jp5H24bSxu63M6ScSVcgPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619421; c=relaxed/simple;
	bh=XQ/rIt1s2mOL0+ga7HTjobxdM7XRJ3LDtydxR0plKbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuC+VWlEhFFtQN9N8357EeuOZxVxvM6HGjBlR4cysw+RN1fRZSippnNYBh8oFK4epFJJ4finhhjVIyLJELPLKN4KdkXDRyJ+cWEBaAWM++btBmIRc+cte1YhhX/Faxd+tTypeYFU96v6MeuWqk3Ncd752/FtRYgXuTPaUK4qPDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=amRANy8W; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746619407; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ShXk2Ny+OfZP5082cR19VWEAQCtfhGVK83M3eG6Emmc=;
	b=amRANy8W+6m3Zw+h1199J1IABJDbD8K7m3qhWMqrY+qStB/RTPTEbgwcXtuSVsJ4TuuPJ6PbY1/X3+5zsjN9/drQ9r3SB3VzmHSF6S9zRuS5XB2KgKWHRQQVQr6R20B3ijRfchUKhJk7K41JQXmTexWRJDIVO6WIdNDIr+sRz1A=
Received: from 30.246.160.110(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WZqjoua_1746619403 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 May 2025 20:03:25 +0800
Message-ID: <16fd041f-0c51-4c1f-941d-0906fcc6885c@linux.alibaba.com>
Date: Wed, 7 May 2025 20:03:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: rostedt@goodmis.org, lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, helgaas@kernel.org, bhelgaas@google.com,
 tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250507011535.43800-1-xueshuai@linux.alibaba.com>
 <20250507120914.000001c8@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250507120914.000001c8@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/7 19:09, Jonathan Cameron 写道:
> On Wed,  7 May 2025 09:15:35 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> Hotplug events are critical indicators for analyzing hardware health,
>> particularly in AI supercomputers where surprise link downs can
>> significantly impact system performance and reliability.
>>
>> To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
>> tracepoint for hotplug event to help healthy check, and generate
>> tracepoints for pcie hotplug event. Add enum pci_hotplug_event in
>> include/uapi/linux/pci.h so applications like rasdaemon can register
>> tracepoint event handlers for it.
>>
>> The output like below:
>>
>> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
>> $ cat /sys/kernel/debug/tracing/trace_pipe
>>      <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, event:Link Down
>>
>>      <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, event:Card not present
>>
>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> FWIW looks good to me.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks :)

> 
> Any userspace tooling planned for this?

Yep, we plan to monitor this tracepoint in rasdaemon after this patch merged.

Best Regards,
Shuai


