Return-Path: <linux-pci+bounces-41499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2F7C6984A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 14:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 7413E28D56
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 13:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2569F2D97BC;
	Tue, 18 Nov 2025 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="v04/qdvc"
X-Original-To: linux-pci@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B123BCFF;
	Tue, 18 Nov 2025 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470941; cv=none; b=kGlYYKwI0gu7otjeV59HWxXUTaXRZ3rbRPgh50cyUFEY/8O/nZdWsYzfuScY8tFyf8nt44c2EEVncowfjxph44INTJAqBPshe4ofYXNbehADkJj+LGNffo99SwRB78KKd3k9MghCYTvIKRG7oSOGbeCLwV2R6Uz8rMzqIt/Lqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470941; c=relaxed/simple;
	bh=CB2uOReZgsobtwaBKBpmnV0Wphw1VrV1rB9pFCourqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoTfX4VphjOmNRpJg5VhE6Ja/5w0hbr10v6eS5fW7KnqEDsLgwPCovQAd/CCGJ5TfuzxJ6dqUTTdDeMIQFTSjxK6Oh/q8cwTmQLhe6a4fZTZy6I1CwN1iajDfOuqYdTQUl7eAgk6eXNVKULlAT1Qve6wtsI1hrnIMNCuMYEOVrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=v04/qdvc; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CB2uOReZgsobtwaBKBpmnV0Wphw1VrV1rB9pFCourqE=; b=v04/qdvc32+tt+zPP4pbDmrzkf
	zXGN+g/n7abQcm8ATAQLOOicg69LK54vwGhdR8jdcZh3yLsGHMNA3Ut6OlqqiMOMStHcN7gxFfKxN
	enI0+iv1n4sauXKQob6ILS8ypE7nUnadXxnfCJlEXdPaBj7rxfELh4+KlLT/MN2SBs8/tGY6r+j1s
	CViq6f347IAYD/ZBAw4f+BRM+uNF9RSbdew7zxtwQhEk2cL2iXEVhLh8nlUMvdMAnDuiu44RuoVai
	ciM5p5UncHRv9cYN7CNYAyQVHPxLxsepPQA/I94/WwnvGJaaw6RSksnJT8E8jby62YqZCLWtPio7B
	sRZNlS6w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vLLLH-00FHMs-OI; Tue, 18 Nov 2025 13:01:56 +0000
Date: Tue, 18 Nov 2025 05:01:47 -0800
From: Breno Leitao <leitao@debian.org>
To: tony.luck@intel.com, bp@alien8.de, akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linux.dev, osandov@osandov.com, xueshuai@linux.alibaba.com, 
	konrad.wilk@oracle.com, linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, kernel-team@meta.com, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Robert Moore <robert.moore@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH RESEND v5] vmcoreinfo: Track and log recoverable hardware
 errors
Message-ID: <vpilvvscosdl4o4cvbmtsrrp4btfwr5iidywmuiawfrgtlcwrr@ubtdbxfqyqpu>
References: <20251010-vmcore_hw_error-v5-1-636ede3efe44@debian.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-vmcore_hw_error-v5-1-636ede3efe44@debian.org>
X-Debian-User: leitao

Hello Andrew, Borislav, Tony,

On Fri, Oct 10, 2025 at 03:36:50AM -0700, Breno Leitao wrote:
> Introduce a generic infrastructure for tracking recoverable hardware
> errors (HW errors that are visible to the OS but does not cause a panic)
> and record them for vmcore consumption. This aids post-mortem crash
> analysis tools by preserving a count and timestamp for the last
> occurrence of such errors. On the other side, correctable errors, which
> the OS typically remains unaware of because the underlying hardware
> handles them transparently, are less relevant for crash dump
> and therefore are NOT tracked in this infrastructure.

<snip>

> Suggested-by: Tony Luck <tony.luck@intel.com>
> Suggested-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Do you know what is the right tree for this patch?

I am wondering if it should go through Kdump, x86 or RAS/MCE tree?

Thanks
--breno

