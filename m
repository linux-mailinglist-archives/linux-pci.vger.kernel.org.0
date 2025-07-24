Return-Path: <linux-pci+bounces-32885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DAFB10CC4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 16:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189DD3A569A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A13267729;
	Thu, 24 Jul 2025 14:07:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8DD4685;
	Thu, 24 Jul 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366031; cv=none; b=kMyp0YOiRLKztxkdaggpSc00x0xJH0d0fco1iyEproIjlpOchEg/xdq689vlRzWnatD1q8/4CJDwB3kg1RjKBHdSQ8t2r6KOyXTZo6eMaV/L5WysnY9IADZmXAjcIlowJeYICcU5uVPgl4VpOaAp+LZDrD7PxuebDQdiEae1lUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366031; c=relaxed/simple;
	bh=OkQND1FA8Zgiq+fCIXVzxfpptSSlpHzvRjGUS3FX33M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qo7Zq+SAedgxTywFipNDCpkeoDBGjVOV2kmeYSik/8PMqoSifut1ZoSiAGybmUJBFdIr+9BAY8ruN9xiD19KAug+qFQRu48pgy/tjZKqj29PPk21s4sYLcoqi7tVzpUMrKX4NLSYQtw/SKb8Xl4/mWb487i9AitOxMi0RKkZaqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id C93A61DA939;
	Thu, 24 Jul 2025 14:07:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id DE9FD20031;
	Thu, 24 Jul 2025 14:07:00 +0000 (UTC)
Date: Thu, 24 Jul 2025 10:06:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <lkp@intel.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, lukas@wunner.de,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com, oe-kbuild-all@lists.linux.dev,
 bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
Message-ID: <20250724100659.697b5972@batman.local.home>
In-Reply-To: <202507240322.nJGdyXsy-lkp@intel.com>
References: <20250723033108.61587-3-xueshuai@linux.alibaba.com>
	<202507240322.nJGdyXsy-lkp@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sj9jeatpcmgk3dhhg1j4rmu7omcno6er
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: DE9FD20031
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19yykztU+ewahSgXtlShevzjICByiY4Pc0=
X-HE-Tag: 1753366020-125808
X-HE-Meta: U2FsdGVkX1+TEXuVgYhshrbY4gdIu46q7I1W9e0mKfeNI4eMYQUVJZpoHvrdSo361H5fZTwriFyQm9cGE275G//RCB7TOVItLCTRulhEsmdN7+LyWt6m5pwcSy6OnZXg3zHNWwKc/9Fb2DgNjW3uizrNmcCJ9AH2ZVRJLHmHMtCFECwCKURhar6iqTUabZCYm2MqOJysS+9ckxENYuxHxICNHsZd3zOsbqYsxF72SfWePz5NTMKiukyzLPbFBKd4COZbrBeTsg4hzVM8bRiB261Ip+XuIxyWFX/svazljEli/DuBbFmukYshzY0skaoB9agmZtxki2a4QPYF6Ty+escxqP/FJ4n57uGO7z9h4FeaTRgKEARY5QIrJK9dtsGyCG8FJ8GzVSsLsxG/hhL5NFJZRwXJFHdxL6DmA9egTDjGNkBCg2YqrFzsKdv10imfDJZRMaytYkpBcl+VQJRbK2y/4R0/yvDD

On Thu, 24 Jul 2025 03:30:17 +0800
kernel test robot <lkp@intel.com> wrote:

> url:    https://github.com/intel-lab-lkp/linux/commits/Shuai-Xue/PCI-trace-Add-a-generic-RAS-tracepoint-for-hotplug-event/20250723-113454
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
> patch link:    https://lore.kernel.org/r/20250723033108.61587-3-xueshuai%40linux.alibaba.com
> patch subject: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link speed changes
> config: sparc-sparc64_defconfig (https://download.01.org/0day-ci/archive/20250724/202507240322.nJGdyXsy-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250724/202507240322.nJGdyXsy-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507240322.nJGdyXsy-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    sparc64-linux-ld: drivers/pci/probe.o: in function `pcie_update_link_speed':
> >> probe.c:(.text+0x370): undefined reference to `__tracepoint_pcie_link_event'
> >> sparc64-linux-ld: probe.c:(.text+0x37c): undefined reference to `__tracepoint_pcie_link_event'
> >> sparc64-linux-ld: probe.c:(.text+0x3dc): undefined reference to `__traceiter_pcie_link_event'  

The config has:

# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set

Which looks to me from the first patch, would enable the code that
defines the trace events via the:

+#define CREATE_TRACE_POINTS
+#include <trace/events/pci.h>

Thus, without compiling that file, the tracepoints would not be created
and you would get the above errors.

-- Steve

