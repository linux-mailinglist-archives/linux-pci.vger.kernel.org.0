Return-Path: <linux-pci+bounces-27287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE315AACBCB
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 19:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6BB164DBB
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F112D252282;
	Tue,  6 May 2025 17:03:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F30280003;
	Tue,  6 May 2025 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550987; cv=none; b=agoIJe70KINe4oKv3zpL17H5s0Mmu41TeQedRyutdaSVC6el9U0Az1tpUqqzR4TOndZgnLjfI/e8y1334qSu5a9c1UEuWhdoqL5W8iCNaNFNxgeRskf0IEWIa1QrdG3lDHgvtRhXFlX3EN64W/2gJtqyBR84DEjP9q6aUuQYZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550987; c=relaxed/simple;
	bh=0WOaw5RZ043+rJnJTVHll4zM5aaNrrkCl4+hWKBWnZA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJFEPP/u5m8aie1rdn4dqnsHOCIlk3lDMCrMxFRvms9/5quFgCX8e4BMCpyZM5b4EORFYxFN108m3e9M2l/XxjTSsuvvnuMfo+JSQkMkVlJZtKqLv5c1SkpbbUVNJLUga6sTH/p6d0Ft745rfdAIFoyqpeg0CAyDHPrOQZso4J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZsPm619ypz6L52x;
	Wed,  7 May 2025 01:00:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D90C1402ED;
	Wed,  7 May 2025 01:03:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 6 May
 2025 19:03:01 +0200
Date: Tue, 6 May 2025 18:03:00 +0100
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
Message-ID: <20250506180300.00006527@huawei.com>
In-Reply-To: <1fb6b57b-4317-404d-8361-19e1c3bd499c@oracle.com>
References: <20250424172809.GA492728@bhelgaas>
	<61d3f860-9411-4c86-b9c4-a4524ec8ea6d@oracle.com>
	<20250425141401.0000067b@huawei.com>
	<0f4944a4-fd05-4365-9416-378a7385547b@oracle.com>
	<20250429165410.00002c86@huawei.com>
	<1fb6b57b-4317-404d-8361-19e1c3bd499c@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 5 May 2025 11:58:25 +0200
Karolina Stolarek <karolina.stolarek@oracle.com> wrote:

> On 29/04/2025 17:54, Jonathan Cameron wrote:
> > On Fri, 25 Apr 2025 16:12:26 +0200
> > Karolina Stolarek <karolina.stolarek@oracle.com> wrote:  
> >>
> >> OK, that means even if we manage to inject a PCIe error, AER wouldn't be
> >> able to look up the Source ID and other values it needs to report an
> >> error, which is not quite the solution I was looking for.  
> > 
> > Isn't the source ID in the CPER record? (Device ID field) or do
> > you mean something else?  
> 
> Ah, sorry, I got confused on the way. I meant that even if we have the 
> Device ID in CPER set, the specific device has no data in aer_regs if we 
> inject an error using the GHES error injection script. We probably would 
> end up with !info->status in aer_print_error(), thus printing only a 
> line about "Inaccessible" agent and return early.

If you were feeling creative with scripts you might be able to make this
work today...  Qemu does allow native aer injection via pcie_aer_inject_error
which will fill in the stuff in the device and 'try' to trigger an interrupt.
That last bit will fail (I think) if we are doing fw first handling.
(you might need to just prevent the interrupt generation in a similar fashion
to this code did here:

https://gitlab.com/jic23/qemu/-/commit/ce801e4d5b5cc5417cc7c7e5ecdaaa2ca5d6efe3#8eeec1fb38fa7149cc37b7a56dc193d69281ee96_704_708

At that point if you were to inject GHES error using Mauro's stuff it will work
and find that pre injected hardware info.

If not we need a refresh of that patch to hook up record generation with
Mauro's new handling. That's what I plan to get to but will be a while yet.

J



> 
> >>> The aim is specifically to allow exercising FW first error handling
> >>> paths because it's a pain to get real systems that have firmware to inject
> >>> the full range of what the kernel etc need to handle.  
> >>
> >> Does this include PCIe errors? If so, that probably doesn't make sense
> >> to try to test my patch on an actual system?  
> > 
> > Ideally test it on a real system as well, but indeed the intent is to
> > allow testing of PCI errors on emulation.  
> 
> I understand. Do you have pointers on how to inject it on a real system? 
> All info I could find about FW error injection pointed to the qemu 
> scripts I mentioned.

Sorry no.  It maybe system specific and disabled on production bios.

> 
> >>> x86 support for emulated injection is a work in progress (more of a mess wrt
> >>> to the different ways the event signaling is handled than it is on arm64).
> >>>
> >>> I did have an earlier version of that work wired up to the same
> >>> hooks as the native CXL error injection but I dropped it from my QEMU
> >>> CXL staging tree for now as it was a pain to rebase whilst Mauro was rapidly
> >>> revising the infrastructure.  I'll bring it back when I get time.  
> >>
> >> I understand, I saw some of your series while looking for ways to test
> >> my patch. Thank you very much for your work. As you can see, there are
> >> people actually looking forward to it :)  
> > 
> > Great!  I'll try and get back to wiring it all up again sometime soon.  
> 
> Awesome, thanks.
> 
> Bjorn, is this patch blocking the ratelimiting series? Would it be 
> acceptable to use public logs in the commit message? I'm asking because 
> it looks like there's no easy way to trigger the GHES path, or it would 
> take some time, further delaying the ratelimiting work.
> 
> All the best,
> Karolina
> 
> > 
> > Jonathan
> >   
> 


