Return-Path: <linux-pci+bounces-27368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E4EAADCFF
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 13:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1338C3A9303
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 11:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35E4215F58;
	Wed,  7 May 2025 11:09:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF21A840A;
	Wed,  7 May 2025 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616167; cv=none; b=C+hW+qtnCDGOH4V3zu3ME+5PSh3hc/hgtVylNj71JClLitpAUZZhpxtH1cKRM/4twFqlDf4cQWAetA1zb2gt9m4OMzpKWJhLIRNDerryUgyTzuBP/tIigZqt0oh8UEi0kD0hCOlcG0BswPAQlJoiWLihTz31h3gK/WKQgHx8C3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616167; c=relaxed/simple;
	bh=KTrpOrlvbgFFznzPI9VvP10OovXWihDkhZQhy98mDvA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cACsw4uc5yIvH1GVcA0EdXzUgVWPDnWGm86B0XNMtr6qF5HCXLo/Wcc+1FmL72bboTmGXmWCQ/EkI+X61y/5AfGP2nN8LUFDwGGT7kC1mNgfzgC7TLseaZdU9rqkjGTM7pFY8xl3XmFvQ8/gpu/ROsfR9w/jM2TyKknvQaEUsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zssq21nc5z6M512;
	Wed,  7 May 2025 19:04:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2773514081B;
	Wed,  7 May 2025 19:09:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 7 May
 2025 13:09:16 +0200
Date: Wed, 7 May 2025 12:09:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <rostedt@goodmis.org>, <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <helgaas@kernel.org>,
	<bhelgaas@google.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, <oleg@redhat.com>,
	<naveen@kernel.org>, <davem@davemloft.net>, <anil.s.keshavamurthy@intel.com>,
	<mark.rutland@arm.com>, <peterz@infradead.org>,
	<tianruidong@linux.alibaba.com>
Subject: Re: [PATCH v7] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20250507120914.000001c8@huawei.com>
In-Reply-To: <20250507011535.43800-1-xueshuai@linux.alibaba.com>
References: <20250507011535.43800-1-xueshuai@linux.alibaba.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed,  7 May 2025 09:15:35 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

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
>     <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, event:Link Down
> 
>     <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, event:Card not present
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
FWIW looks good to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Any userspace tooling planned for this? 

