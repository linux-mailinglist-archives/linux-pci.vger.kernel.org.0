Return-Path: <linux-pci+bounces-42070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D737BC8644A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 18:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 533A63426F8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 17:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8324932AAB5;
	Tue, 25 Nov 2025 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jfig/jpu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E0325735;
	Tue, 25 Nov 2025 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092584; cv=none; b=Hj6GihdjK88Fh/BTBLVOZ20tWCynnzk616yjvKmH+j8KL9QsdodvBXLgYmJmgr7xRoAG78pgIb2gPHXLipr/Gk41S3EYePqJsDjAJuo6GHhcAJUeVG64+t0GQ5pHGxDLYZAyAXq+FaOYc5Zwg+JXM9j4f0z0tkoqZa+Gw50dl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092584; c=relaxed/simple;
	bh=7KG5i1mNmQWFJnds+8rhq9qv7Msw5Lw3zPxusJTiGSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkoD0Be93u06vSikWKYg+qylRh6GbJDpMtG4Ra1qG2tN1slpIZgZfotr/pMphrMc7JQOI2KrprIfbx7xKZ8uHGiguJKYlkc6PVtVYdC6a0CffNaDNpHZdFvaqXYo/rfh8RR9/yKPWnwZry6kLnlUMV/uef8CcibxfitlPXXjLr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jfig/jpu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AC03640E0253;
	Tue, 25 Nov 2025 17:42:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id To3KnAzsrizz; Tue, 25 Nov 2025 17:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764092566; bh=Flf67ZijIH8cHplKxTy2qaA6YRgNZ0as3pFMcflAhlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfig/jpuvuAzxZouWtelYFbmMFFHxJ7ybHn8YOnj59P6YChLrwbQWwni5nlQpSTSs
	 bvB0xGsVpaXuVuxQIHKRHJrCMcbR/8UIOkp3o/5vWJY1p4U05ycL7Xf8V2mwPd9Ysd
	 2N/dsxxMZLLQ+sbecT2+TzFjuQQpnAaB0FE7InXjDiekXjcMYVi75X5IZIFqPTp5rx
	 SjQ6wkoQKeIdix2Hb6aDtl/4fLsqegxkJJcAwQ72jil2HjY0aNwSNvKIp5EyMxiIUm
	 pFsk0svA5WyubEzPDwun1ybZzgQQ5NWbj1QFmQz2Nwf/W5vb4MJa4r3FdPqyJ7NJZi
	 Jb7o5Sm5U6IHTmQ00HlXHUyc9wSb4KGbPlHz5ugmohz3eFGFsZYvglXeJHZOvLatVG
	 2hH/bHOFZBGc6Dp79RY0iYHubByFihteXMTQzInm6OIc5EoEoM1JDhoFNuoczlvLQF
	 O7yTMorRdwPGmA6D9asEgU7j4rKaqUnQ8AWUA1mmQWLFlf9GaI43ASOzy167gjY9jD
	 gI5yky67zV9afaW92sKmwuHdnykIYm9ktxVAHYiinDogo1jzo64TrcKPwVl/Fyv+hT
	 lTjQR5i4RqPcE4U56eBICJw8j0i3g1w3rtD8VYlCrgua2OZBRfQ4ijERPEzkll/t8Z
	 nAlDqigrayea84xsUnnD8vVs=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5046E40E015B;
	Tue, 25 Nov 2025 17:42:19 +0000 (UTC)
Date: Tue, 25 Nov 2025 18:42:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Breno Leitao <leitao@debian.org>, tony.luck@intel.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev, osandov@osandov.com,
	xueshuai@linux.alibaba.com, konrad.wilk@oracle.com,
	linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, kernel-team@meta.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
	Robert Moore <robert.moore@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH RESEND v5] vmcoreinfo: Track and log recoverable hardware
 errors
Message-ID: <20251125174211.GIaSXqc1tAdGejYYwh@fat_crate.local>
References: <20251010-vmcore_hw_error-v5-1-636ede3efe44@debian.org>
 <vpilvvscosdl4o4cvbmtsrrp4btfwr5iidywmuiawfrgtlcwrr@ubtdbxfqyqpu>
 <20251118141002.GEaRx-Oge8ZxtR4Vzi@fat_crate.local>
 <20251125093211.081d4ba0e18f1f9a85a0de5f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251125093211.081d4ba0e18f1f9a85a0de5f@linux-foundation.org>

On Tue, Nov 25, 2025 at 09:32:11AM -0800, Andrew Morton wrote:
> I don't feel I'll add much value here so please take it via the
> appropriate tree.

Yeah, that's the thing - judging from the diffstat your tree is probably the
most fitting one. So I think we're on the right track here.

:-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

