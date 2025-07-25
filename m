Return-Path: <linux-pci+bounces-32911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A951B1167B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 04:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2933ADAAB
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 02:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E780A23183A;
	Fri, 25 Jul 2025 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cBMlU+YI"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75ED846F;
	Fri, 25 Jul 2025 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753410719; cv=none; b=i1m10wQvvJedinCKpwpXrGprB2HU2XtW9uc65Gtnk9lqxn380aIEB0ICzq0A8v/+g0TwxUeNOSwe987Hgolg5/lbs8dIYLftBq1EVu159YeZWMTgBV7XU6X9Yt95XsKSPamnPd3lZ2WznHu863zXJ1RRlvLUMt8xgZYZd818ABM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753410719; c=relaxed/simple;
	bh=qw22ZWveSnNXYOvVUnPPp98LlSg6iUvGggEgz0HG03Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kckv0zxYxXHrW7VVOx0ZU+tnTL9dWsa5hiBGZT8ZqvrHt6pdIqtkdWvp+Rcm0SIf7IvvA2RFlYx8IPO7K4fqyZB5H3Bs9FeBXKaOlJ4eUdE8xHYpl22Bnr9j/9GtRm5na4VX9kVZDxxYLF0tZM0w449lHVFCJxZXn42/X4m50dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cBMlU+YI; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753410709; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=btxZweO/rGd+0DSVVWK88KFtafqY/KJF2asyq9ovbKU=;
	b=cBMlU+YImIMUMoTyGIMGUFdjRDGGTrSXDcADa/GpI89BuiXGSZaibZC6GXuFrKP4A1mg5GBwI6N1wQkiMbxMN5nMym1kyXjW19KrMGg0L5NAfcR+0dsqPOsGJPvwWZK+o0cIg80zZVr59K9rACVvi2MC6Erwcq6lkukJgQJlBYc=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WjuqHYV_1753410706 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 10:31:47 +0800
Message-ID: <4b41e3e2-ebac-48c3-b1a3-ce24a5bed475@linux.alibaba.com>
Date: Fri, 25 Jul 2025 10:31:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
To: Steven Rostedt <rostedt@goodmis.org>, kernel test robot <lkp@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com, oe-kbuild-all@lists.linux.dev,
 tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250723033108.61587-3-xueshuai@linux.alibaba.com>
 <202507240322.nJGdyXsy-lkp@intel.com>
 <20250724100659.697b5972@batman.local.home>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250724100659.697b5972@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Steven,

在 2025/7/24 22:06, Steven Rostedt 写道:
> On Thu, 24 Jul 2025 03:30:17 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
>> url:    https://github.com/intel-lab-lkp/linux/commits/Shuai-Xue/PCI-trace-Add-a-generic-RAS-tracepoint-for-hotplug-event/20250723-113454
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
>> patch link:    https://lore.kernel.org/r/20250723033108.61587-3-xueshuai%40linux.alibaba.com
>> patch subject: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link speed changes
>> config: sparc-sparc64_defconfig (https://download.01.org/0day-ci/archive/20250724/202507240322.nJGdyXsy-lkp@intel.com/config)
>> compiler: sparc64-linux-gcc (GCC) 15.1.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250724/202507240322.nJGdyXsy-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202507240322.nJGdyXsy-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>     sparc64-linux-ld: drivers/pci/probe.o: in function `pcie_update_link_speed':
>>>> probe.c:(.text+0x370): undefined reference to `__tracepoint_pcie_link_event'
>>>> sparc64-linux-ld: probe.c:(.text+0x37c): undefined reference to `__tracepoint_pcie_link_event'
>>>> sparc64-linux-ld: probe.c:(.text+0x3dc): undefined reference to `__traceiter_pcie_link_event'
> 
> The config has:
> 
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> 
> Which looks to me from the first patch, would enable the code that
> defines the trace events via the:
> 
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/pci.h>
> 
> Thus, without compiling that file, the tracepoints would not be created
> and you would get the above errors.

Thanks for the detailed analysis! You're absolutely right about the root
cause.

The issue is that I have the tracepoint usage in drivers/pci/probe.c
(which is always compiled), but the tracepoint definition with:

#define CREATE_TRACE_POINTS
#include<trace/events/pci.h>

is in drivers/pci/hotplug/pciehp_ctrl.c that's conditionally compiled
based on CONFIG_HOTPLUG_PCI_PCIE=y, creating the undefined reference
when that config is not set.

I can see a few ways to fix this:

- Move tracepoint definition to always-compiled code - Create a dedicated drivers/pci/trace.c that always defines the PCI tracepoints
- Make the tracepoint usage conditional - Wrap the trace calls with the same config dependency
- Create a PCI-specific trace config - Add a CONFIG_PCI_TRACE option

I'm leaning toward option 1 (dedicated trace.c file) as it's the
cleanest approach and follows the pattern used in other subsystems. Does
that sound reasonable to you?

> 
> -- Steve

Thanks for valuable feedback.

Best Regards,
Shuai
















