Return-Path: <linux-pci+bounces-42069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDEAC8638A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 18:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF9DC3530F5
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 17:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E3032B9A4;
	Tue, 25 Nov 2025 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nr6cZGfS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1A6207A0B;
	Tue, 25 Nov 2025 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764091933; cv=none; b=TLbf07Bh5u30pMW7lQwNTmYzOqgmWKBjE74kuep4VU446iWLGUz378ZY1H1Tdrby63qFwXmLv722acJYCsf8kw1E3X8tgcpVlu4D9SZYSMLo+of8Dl4qT7Rt3lnkuhMh5Xf0Wwd3Ocyk8omdaphaXiXmPZJd/RzgrFAu5G1r0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764091933; c=relaxed/simple;
	bh=nnAEPQ59gqP0qnrmNI3FJEAbvJ+MZOEUAcLlq2prKCE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rEMrZJiCWrtiQ96d4TNBsUZADJGAHcSxpEYeQg2cVnpuaiWdCu81s4VBTzo+Q/t1SWkKKigJPOW5Qv/ajgwH4gz30IOjVT4zZWJvRnNcS5yFfOK+eEfDZGz556HGb5dQJMgT0zvOtDZ3lky7eK5JdZyAAEc5ueQNkjlsy242fWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nr6cZGfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC08C4CEF1;
	Tue, 25 Nov 2025 17:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1764091932;
	bh=nnAEPQ59gqP0qnrmNI3FJEAbvJ+MZOEUAcLlq2prKCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nr6cZGfS3O34sgUcHJr7KtS+Mp52RlENxbRA2dOu/d4YFQzwnvtmp3Sq5//ODUpfl
	 +JTv5kdtE8yRGxiVrRPo0z9izXQ4Qd7pOleXhGLoV+myrsB8q9Z1Q0r5elNASWV8mA
	 SkTNueFUG1lHdCCOI0S/bo6eQeJ5jJCa5HA65TtY=
Date: Tue, 25 Nov 2025 09:32:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Breno Leitao <leitao@debian.org>, tony.luck@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev, osandov@osandov.com,
 xueshuai@linux.alibaba.com, konrad.wilk@oracle.com,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, kernel-team@meta.com, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse
 <james.morse@arm.com>, Robert Moore <robert.moore@intel.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver
 O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH RESEND v5] vmcoreinfo: Track and log recoverable
 hardware errors
Message-Id: <20251125093211.081d4ba0e18f1f9a85a0de5f@linux-foundation.org>
In-Reply-To: <20251118141002.GEaRx-Oge8ZxtR4Vzi@fat_crate.local>
References: <20251010-vmcore_hw_error-v5-1-636ede3efe44@debian.org>
	<vpilvvscosdl4o4cvbmtsrrp4btfwr5iidywmuiawfrgtlcwrr@ubtdbxfqyqpu>
	<20251118141002.GEaRx-Oge8ZxtR4Vzi@fat_crate.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Nov 2025 15:10:02 +0100 Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Nov 18, 2025 at 05:01:47AM -0800, Breno Leitao wrote:
> > Do you know what is the right tree for this patch?
> > 
> > I am wondering if it should go through Kdump, x86 or RAS/MCE tree?
> 
> I can take it if akpm wants me to...
> 

I don't feel I'll add much value here so please take it via the
appropriate tree.

I'll toss it in mm.git for linux-next exposure and shall drop it again
when it appears in -next via another route.

It's a shame it took us two weeks to get onto this - it's a bit late
for the upcoming merge window.

