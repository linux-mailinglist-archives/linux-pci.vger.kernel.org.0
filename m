Return-Path: <linux-pci+bounces-28791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3198ACA981
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 08:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35893B37BF
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 06:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB9029CE6;
	Mon,  2 Jun 2025 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghNO+zd7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71C530100;
	Mon,  2 Jun 2025 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748845813; cv=none; b=pMaHqrDsuryZbVlZonYqqJ1wgrIh1GeWB0T8ccr5XPTVwJ+Uco3M7ENOIcoB506Z3/4vjWcuCGPgq3URQ3339+oWrlmaLSeCkFgK7EHCY0aUxefWRYyQxXAp6WiRKl7duC/B2mQelxrjvGdUd0UdprbZvf8zlVXdHduviFdAQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748845813; c=relaxed/simple;
	bh=iZsdRW2eWSM0CYYMYUe4/FaSLJwa7Tu9tmz6E/97JQk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ziz/BAXwufPlm3bdl5QqbAbtVfRo+6rLjR83doobZHaAB+2vF2erJEMqo5EPQ/TesnsKgRw4qcdZegB7gSUEGjkg0IwJPnMUgtB6wM4OINnuePU2cUGRsPfsRgzDbxC2N+AaQZbLUJ85L1xPh6FivwZ7TC8EQpzTGW2Tpey5L2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghNO+zd7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748845811; x=1780381811;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iZsdRW2eWSM0CYYMYUe4/FaSLJwa7Tu9tmz6E/97JQk=;
  b=ghNO+zd7jVDDqu1yBMm0dbh4cbzt4zB99WgaK4ui2xFo0xYEnMauQVXW
   v7W3nwKQwFKmABajit/IGmMdR4sz3XNUG1o6zvVl0VO1LDA8CoSupYu1g
   POISsCHry0FrPFGNxcT3oMRC75cSjIetm+sMFM0V66qhVsonyrLY5B8wl
   ofYvecHSXzofhSQtcmEAi3j557m7WJT/31A9ogpff1iJ3M63OynyJMUCc
   umsh43HEzG8+/2WfhtNg0aWI6CX7M0LKwxIg0fYsV+4pP9ZikgjaMrc+D
   tbbiwfmWscs5hsK7slaYjSWLYkPHgy+Qc5oh78QKzz4glIlQiMB1spwyD
   g==;
X-CSE-ConnectionGUID: 5d/Hi8DpS8W4SUteUzNyzA==
X-CSE-MsgGUID: dRWGdx/2SICtO+xm4sXiLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="49973213"
X-IronPort-AV: E=Sophos;i="6.16,202,1744095600"; 
   d="scan'208";a="49973213"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2025 23:30:10 -0700
X-CSE-ConnectionGUID: Ta+mIcmBS6Ss9Ett8EMblg==
X-CSE-MsgGUID: E9sDq5bRTMuFqCtiVhAY/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,202,1744095600"; 
   d="scan'208";a="144422014"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.134])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2025 23:30:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 2 Jun 2025 09:30:02 +0300 (EEST)
To: Shuai Xue <xueshuai@linux.alibaba.com>, Lukas Wunner <lukas@wunner.de>
cc: rostedt@goodmis.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, helgaas@kernel.org, 
    bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de, 
    mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com, 
    naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com, 
    mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
In-Reply-To: <20250512013839.45960-1-xueshuai@linux.alibaba.com>
Message-ID: <6b4d1351-805e-c8fc-3484-11c0ec466cf0@linux.intel.com>
References: <20250512013839.45960-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 May 2025, Shuai Xue wrote:

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
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> changes since v7:
> - replace the TRACE_INCLUDE_PATH to avoid macro conflict per Steven
> - pick up Reviewed-by from Lukas Wunner
> ---
>  drivers/pci/hotplug/Makefile      |  3 ++
>  drivers/pci/hotplug/pciehp_ctrl.c | 33 ++++++++++++---
>  drivers/pci/hotplug/trace.h       | 68 +++++++++++++++++++++++++++++++
>  include/uapi/linux/pci.h          |  7 ++++
>  4 files changed, 105 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/pci/hotplug/trace.h
> 
> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
> index 40aaf31fe338..a1a9d1e98962 100644
> --- a/drivers/pci/hotplug/Makefile
> +++ b/drivers/pci/hotplug/Makefile
> @@ -3,6 +3,9 @@
>  # Makefile for the Linux kernel pci hotplug controller drivers.
>  #
>  
> +# define_trace.h needs to know how to find our header
> +CFLAGS_pciehp_ctrl.o				:= -I$(src)
> +
>  obj-$(CONFIG_HOTPLUG_PCI)		+= pci_hotplug.o
>  obj-$(CONFIG_HOTPLUG_PCI_COMPAQ)	+= cpqphp.o
>  obj-$(CONFIG_HOTPLUG_PCI_IBM)		+= ibmphp.o
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index d603a7aa7483..f9beb4d3a9b8 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -23,6 +23,9 @@
>  #include "../pci.h"
>  #include "pciehp.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include "trace.h"

Hi,

Instead of spreading tracepoint creating into subdriver code like this, 
should we place it into one place, e.g., drivers/pci/pci-trace.c (which is 
what I seem to have used in my yet to be submitted patch that adds 
tracepoints into bwctrl link speed events)?

> diff --git a/drivers/pci/hotplug/trace.h b/drivers/pci/hotplug/trace.h
> new file mode 100644
> index 000000000000..21329c198019
> --- /dev/null
> +++ b/drivers/pci/hotplug/trace.h

Perhaps in include/trace/events/pci.h (or 
include/trace/events/pci-hotplug.h)?

I don't know what is the general rule having them inside drivers/ vs 
include/trace/events, Documentation/trace/tracepoints.rst only mentions 
the latter, but there seems to be plenty under drivers/ too.

> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#if !defined(_TRACE_HW_EVENT_PCI_HP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_HW_EVENT_PCI_HP_H
> +
> +#include <linux/tracepoint.h>
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM pci
> +
> +#define PCI_HOTPLUG_EVENT					\

-- 
 i.


