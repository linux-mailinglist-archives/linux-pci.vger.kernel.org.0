Return-Path: <linux-pci+bounces-22136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130D0A4141E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 04:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D08A1892AFA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 03:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA371A5BAF;
	Mon, 24 Feb 2025 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j8TUACTx"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D6FF510;
	Mon, 24 Feb 2025 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368334; cv=none; b=r4dd6v92RD8PVJOkYTvrwDMQXn1JxjsGJlEtCDG6A8CQzGBXlZ71e3k4/IwN94EiRtH5jm0d5u80jn4nxmxWaXy0QfmY4QVjWV7jqrinb8sKBmDGU/BXAiEANF81qbk23D3G8GNGqMchL2dqq1v7Z5rwCnV3p7NudlobLX7DhcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368334; c=relaxed/simple;
	bh=khPyexFgRrzKD4aS8Pr7cyj242wf3EyCfCMQCvtoNiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTX/5Re2T/rSEoN/98oNCO1cXvdiBkyj+3swhJspLkz/eFBDmnyHAhuqJ6hDCzW1WvUcAaJy1hPmnx4DSimhFCTT5lmwwq5Mf2dUSH0VBj+iDERRF//XfDo75UrotadMljC3sf0PAnrlIfoaTYsnODEmFzrwriqsF+HiEWby47I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j8TUACTx; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740368321; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zDYrXQDA4qm9LJorA4fiBczFbRiFUQ1RGHOU5r99wBQ=;
	b=j8TUACTxtSTK/lxfzbqGXTay5cMBroXpK5kHDpL6xiUdM2+D7FsIw7sIYt2K6M5lJKl50KfyPkT/XAm4n+5oO20yBiMxR6IkSafHa7cBl25kLaz8pkk39KwKtrE8YKbwEcm/h4wPZ5//Brfa2cOJP9h7G7E3yZTlzfSyceT6IEk=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQ1w.6n_1740368318 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 11:38:39 +0800
Message-ID: <fc8788ca-ffef-4166-a8d0-4c5748003de2@linux.alibaba.com>
Date: Mon, 24 Feb 2025 11:38:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com,
 rostedt@goodmis.org, lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250115013753.49126-1-xueshuai@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250115013753.49126-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/15 09:37, Shuai Xue 写道:
> Hotplug events are critical indicators for analyzing hardware health,
> particularly in AI supercomputers where surprise link downs can
> significantly impact system performance and reliability.
> 
> To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
> tracepoint for hotplug event to help healthy check, and generate
> tracepoints for pcie hotplug event. Add enum pci_hotplug_event in
> include/uapi/linux/pci.h so applications like rasdaemon can register
> tracepoint event handlers for it.
> 
> The output like below:
> 
> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
> $ cat /sys/kernel/debug/tracing/trace_pipe
>      <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, event:Link Down
> 
>      <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, event:Card not present
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> ---
> changes since v5:
> - move define of enum to include/uapi/linux/pci.h

Hi, Bjorn,

As this patch missed v6.13, should I rebase on pci/main (v6.14-rc1)?

Thanks.
Shuai


