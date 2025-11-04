Return-Path: <linux-pci+bounces-40192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B000C30505
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 10:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41923BB077
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 09:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11282D0274;
	Tue,  4 Nov 2025 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D0rY8gFg"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C551552FD;
	Tue,  4 Nov 2025 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248880; cv=none; b=q1WcHgNCK85xzNhek3A7136lZwNpG9w1jbKzRXneA3nqsBtESPnaxaiKbzks05PilAg1jXwWBrTmr8QfwedOrAxG7GmdIA347ncnjml/F2isIP3j8nquzeydIWg5EkAw+pgPaEMxrIyGXJ8noUBgSLiy152e3JSaRlQhrUo8N7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248880; c=relaxed/simple;
	bh=fEVAyXwFyCE8r5KT4F927V7DbCxgjOnCllkSXe4iing=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqQ/ekI3lxGy0kcndZbHVdgYdCEtDkIrCkvjhkWJmBDv2Vw+X22wiuN/OeOyQx0xP7O+lHR2Reh5obXuNRfA8nVY4sX/fkmeMQOLVS6zAYdcKGNeYoGpfFkl45qw2ouZlCoayfn1TNzbrCLQC/cX1cji6Z9pmkc2GfAzep5qU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D0rY8gFg; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762248869; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lNLhVwUKGHNYLggea58Uh2dC8gupkSgEBYYu/uld89Y=;
	b=D0rY8gFgsqc9kIfoXchkwki2/IWkuoWXbQCl0wS5jo19ZgG44j2mR9m6IIeTmOf3DZeyMK4yTySNgNY4AzQGohMAXENtlhMR0Q58hXLHmspikFvP0Twas9gupUESkOdnZTWZH5gaDCg4ZmuktJG85PVcsn1+c6354A7bFz0j2sA=
Received: from 30.50.185.91(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WrgbbAl_1762248866 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Nov 2025 17:34:27 +0800
Message-ID: <1f9ee237-9d62-4c33-83c3-ce4d9ca9497f@linux.alibaba.com>
Date: Tue, 4 Nov 2025 17:34:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/3] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com, rostedt@goodmis.org,
 lukas@wunner.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com
References: <20251025114158.71714-1-xueshuai@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20251025114158.71714-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/25 19:41, Shuai Xue 写道:
> changes since v12:
> - add Reviewed-by tag for PATCH 1 from Steve
> - add Reviewed-by tag for PATCH 1-3 from Ilpo
> - add comments for why use string to define tracepoint per Steve
> - minor doc improvements from Ilpo
> - remove use pci_speed_string to fix PCI dependends which cause build error on sparc64
> 
> changes since v11:
> - rebase to Linux 6.18-rc1 (no functional changes)
> 
> changes since v10:
> - explicitly include header file per Ilpo
> - add comma on any non-terminator entry  per Ilpo
> - compile trace.o under CONFIG_TRACING per Ilpo
> 
> changes since v9:
> - add a documentation about PCI tracepoints per Bjorn
> - create a dedicated drivers/pci/trace.c that always defines the PCI tracepoints per Steve
> - move tracepoint callite into __pcie_update_link_speed() per Lukas and Bjorn
> 
> changes since v8:
> - rewrite commit log from Bjorn
> - move pci_hp_event to a common place (include/trace/events/pci.h) per Ilpo
> - rename hotplug event strings per Bjorn and Lukas
> - add PCIe link tracepoint per Bjorn, Lukas, and Ilpo
> 
> changes since v7:
> - replace the TRACE_INCLUDE_PATH to avoid macro conflict per Steven
> - pick up Reviewed-by from Lukas Wunner
> 
> Hotplug events are critical indicators for analyzing hardware health, and
> surprise link downs can significantly impact system performance and reliability.
> In addition, PCIe link speed degradation directly impacts system performance and
> often indicates hardware issues such as faulty devices, physical layer problems,
> or configuration errors.
> 
> This patch set add PCI hotplug and PCIe link tracepoint to help analyze PCI
> hotplug events and PCIe link speed degradation.
> 
> Shuai Xue (3):
>    PCI: trace: Add a generic RAS tracepoint for hotplug event
>    PCI: trace: Add a RAS tracepoint to monitor link speed changes
>    Documentation: tracing: Add documentation about PCI tracepoints
> 

Hi, Bjorn,

Gentle ping.

Do you have any further concerns about this patch set?

Shuai

