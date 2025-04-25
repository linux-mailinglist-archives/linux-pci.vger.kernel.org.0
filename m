Return-Path: <linux-pci+bounces-26754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CFFA9C9DC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 15:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F35B9A8536
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EE324A074;
	Fri, 25 Apr 2025 13:14:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D524E00D;
	Fri, 25 Apr 2025 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745586851; cv=none; b=rKEY0utMGXcqJMLnV7HFLzLvzaR3wmW0uZu65+mbVdsJHVCbJJzIbIZ05Syp0T+96lGy/+yASEJ4wjUX5EcmhnjeOEa+c1kLgGGH9NSVlUZFxMtL53SY6zSdMdKgT307pUedg3tBh8LToFFqyqO8UvyXTW/79DrSGSUFXEUFMAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745586851; c=relaxed/simple;
	bh=p9uvMC7OUclf4qAiBvQ87dCW505h28sVCCqJAIvv5/8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cpaesw+/QuljJMTZAlqABUzHQ4Tpl1uGwcOO6f5pC2U63JZnu6E9lHm91LZld3P7kpbfaz/boLiI6obpHPKKwinHkKg7WgkqTwazuhVyyhK83rUeeVaHq9tmyQuFfExgcJN2Syj3fxvmGmhqrw8Nyb2GPXgO5hIOBqOEIdhe5Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZkY8v1fQYz6M4vJ;
	Fri, 25 Apr 2025 21:09:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A5BB91404F5;
	Fri, 25 Apr 2025 21:14:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Apr
 2025 15:14:02 +0200
Date: Fri, 25 Apr 2025 14:14:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Karolina Stolarek <karolina.stolarek@oracle.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, "Shen, Yijun" <Yijun.Shen@dell.com>,
	Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Jon Pan-Doh
	<pandoh@google.com>, Terry Bowman <terry.bowman@amd.com>, Len Brown
	<lenb@kernel.org>, James Morse <james.morse@arm.com>, Tony Luck
	<tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Ben Cheatham
	<Benjamin.Cheatham@amd.com>, Ira Weiny <ira.weiny@intel.com>, Shuai Xue
	<xueshuai@linux.alibaba.com>, Liu Xinpeng <liuxp11@chinatelecom.cn>, "Darren
 Hart" <darren@os.amperecomputing.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI/AER: Consolidate CXL, ACPI GHES and native AER
 reporting paths
Message-ID: <20250425141401.0000067b@huawei.com>
In-Reply-To: <61d3f860-9411-4c86-b9c4-a4524ec8ea6d@oracle.com>
References: <20250424172809.GA492728@bhelgaas>
	<61d3f860-9411-4c86-b9c4-a4524ec8ea6d@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 25 Apr 2025 12:32:10 +0200
Karolina Stolarek <karolina.stolarek@oracle.com> wrote:

> On 24/04/2025 19:28, Bjorn Helgaas wrote:
> > [+to Yijun @Dell in case there's some testing opportunity, thread at
> > https://lore.kernel.org/r/81c040d54209627de2d8b150822636b415834c7f.1742900213.git.karolina.stolarek@oracle.com]
> > 
> > On Thu, Apr 24, 2025 at 11:01:11AM +0200, Karolina Stolarek wrote:  
>  >>
> >> The only way to inject GHES errors I'm aware of is Mauro's patch for
> >> qemu[1], so I went down the virtualization path. As for working with the
> >> actual hardware, I'd need to ask around and learn more about the platform.  
> > 
> > I'd be surprised if the qemu firmware supports firmware-first
> > handling, so I wouldn't expect to be able to exercise this path that
> > way.  I think there are some bits in HEST and similar tables that tell
> > us about this, e.g., ACPI r6.5, sec 18.3.2.4.  
> 
> It's possible that some of the nuances of this escaped me. I decided to 
> pick up the series, as I saw "PCI Express bus error injection via GHES" 
> script and thought it might be useful.

With Mauro's series you can inject (on ARM64 virt) any CPER record you
like.  That doesn't synchronize the wider state of the system though
so may not exercise everything (PCI registers etc not updated as it
is only injecting the record).  Mostly it just works, as remarkably 
few error handlers actually take the state of the components on which
the error is reported into account.

The aim is specifically to allow exercising FW first error handling
paths because it's a pain to get real systems that have firmware to inject
the full range of what the kernel etc need to handle.

x86 support for emulated injection is a work in progress (more of a mess wrt
to the different ways the event signaling is handled than it is on arm64).

I did have an earlier version of that work wired up to the same
hooks as the native CXL error injection but I dropped it from my QEMU
CXL staging tree for now as it was a pain to rebase whilst Mauro was rapidly
revising the infrastructure.  I'll bring it back when I get time.

Jonathan

> 
> > Unfortunately there are some typos in the spec (FIRMWARE_FIRST,
> > FIRMWAREFIRST in 18.4), so it's a little hard to find all the
> > references.  
> 
> Thanks for the pointers, I'll take a look.
> 
> > It's a long shot, but I added Yijun as a Dell contact that who might
> > have a pointer to someone who could possibly test GHES logging on a
> > Dell box with and without your patch so we could have a concrete
> > comparison of the dmesg log differences.  
> 
> Thank you very much. Let's see, maybe we'll get lucky :)
> 
> All the best,
> Karolina
> 
> >   
> >>> If you can't produce actual logs for comparison, I think we can take
> >>> info from a sample log somebody has posted and synthesize what the
> >>> changes would be after this patch.  
> >>
> >> I also found some logs at some point, mostly from 2021 and 2023, but I felt
> >> bad about mocking up the messages and tried to produce actual logs. If I
> >> can't find a way to get this working in two weeks, I'll revisit this idea.
> >>
> >> All the best,
> >> Karolina
> >>
> >> -------------------------------------------------------------
> >> [1] - https://lore.kernel.org/lkml/76824dfc6bb5dd23a9f04607a907ac4ccf7cb147.1740653898.git.mchehab+huawei@kernel.org/  
> 
> 


