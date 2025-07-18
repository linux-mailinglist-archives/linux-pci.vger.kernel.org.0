Return-Path: <linux-pci+bounces-32496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF43B09AF2
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 07:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024795A20DF
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 05:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7578A1E3772;
	Fri, 18 Jul 2025 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="W46kVCg0"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5882E3701;
	Fri, 18 Jul 2025 05:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752816573; cv=none; b=SZTwxaddmKnn9TsNcgPenzZiRZphY/8k6H/nBYDuYrb/vfQ1qkmAn6R8cN5XBSzotUErZ3e5yBbaYcVscBeI42DaY7bO5EWiyOjtKO/lwnzHJ3z1La+eUHv3sJg/U7wx94XqNNph9inML5MK6kc7YVkP8TtzDqzbtis8QQT51mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752816573; c=relaxed/simple;
	bh=m2miZFl5NgGe92LTcMBCK2TMuOH0GrVO+wRE0y1hl6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9VsfHwNOtpB2rc2Dnqxetwt/qhvxjn+6RXQb3AEl8kcqCdJvzxgLkv5YWnwr6pSLtwn8c1+4vppfp7lxS8hkghVQB3q8rUu7rWR4i56Z2wHZRLcJ8C/M1iwBfVaDNV2a+kHz7ZT7uwtgKYlNODXdpjyeDDYT/t4bEJnjzzucz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=W46kVCg0; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752816561; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zqVP7ZJu/yyqnzJzHTqxeHX8EL7nFVPdLIswEFCIT7k=;
	b=W46kVCg0VGYhkosD+BO6CLUHv3WWgUbg7XlIyVW76x7qBzmdGBtOyzaFKNwwB7Z4baooZgaNwNrEln/Ghvuj+B4Sd/ffJeNw49sOyn7/lI69k4lP11c/166RArmH3gQhDnQ53enOymSH46B7ZJqmeDL+v3bQ7Q166T87xfXwgRI=
Received: from 30.246.162.71(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WjBAWRW_1752816558 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Jul 2025 13:29:20 +0800
Message-ID: <e92f8d1f-457c-4248-8397-81b0e20ff4af@linux.alibaba.com>
Date: Fri, 18 Jul 2025 13:29:18 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Matthew W Carlis <mattc@purestorage.com>, helgaas@kernel.org,
 lukas@wunner.de, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: anil.s.keshavamurthy@intel.com, bhelgaas@google.com, bp@alien8.de,
 davem@davemloft.net, ilpo.jarvinen@linux.intel.com,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 lukas@wunner.de, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, naveen@kernel.org, oleg@redhat.com,
 peterz@infradead.org, rostedt@goodmis.org, tianruidong@linux.alibaba.com,
 tony.luck@intel.com
References: <20250717235055.GA2664149@bhelgaas>
 <20250718034616.26250-1-mattc@purestorage.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250718034616.26250-1-mattc@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/18 11:46, Matthew W Carlis 写道:
> On Thu, Jul 17, 2025 Bjorn Helgaas wrote
>> So I think your idea of adding current link speed/width to the "Link
>> Up" event is still on the table, and that does sound useful to me.
> 
> We're already reading the link status register here to check DLLA so
> it would be nice. I guess if everything is healthy we're probably already
> at the maximum speed by this point.
> 
>> In the future we might add another tracepoint when we enumerate the
>> device and know the Vendor/Device ID.
> 
> I think we might have someone who would be interested in doing it.


Hi, all,

IIUC, the current hotplug event (or presence event) is enough for Matthew.
and we would like a new tracepoing for link speed change which reports
speeds.

For hotplug event, I plan to send a new version to

1. address Bjorn' concerns about event strings by removing its spaces.

#define PCI_HOTPLUG_EVENT							\
	EM(PCI_HOTPLUG_LINK_UP,			"PCI_HOTPLUG_LINK_UP")		\
	EM(PCI_HOTPLUG_LINK_DOWN,		"PCI_HOTPLUG_LINK_DOWN")	\
	EM(PCI_HOTPLUG_CARD_PRESENT,		"PCI_HOTPLUG_CARD_PRESENT")	\
	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,	"PCI_HOTPLUG_CARD_NOT_PRESENT")

2. address Ilpo comments by moving pci_hp_event to a common place
(include/trace/events/pci.h) so that the new comming can also use it.

For link speed change event (perhaps named as pci_link_event),
I plan to send a seperate patch, which provides:

	TP_STRUCT__entry(
		__string(	port_name,	port_name	)
		__field(	unsigned char,	cur_bus_speed	)
		__field(	unsigned char,	max_bus_speed	)
  		__field(	unsigned char,	width		)
  		__field(	unsigned int,	flit_mode	)
		__field(	unsigned char,	reason		)
		),

The reason field is from Lukas ideas which indicates why the link speed
changed, e.g. "hotplug", "autonomous", "thermal", "retrain", etc.

Are you happy with above changes?

Thanks.
Shuai

