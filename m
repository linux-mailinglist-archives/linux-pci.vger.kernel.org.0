Return-Path: <linux-pci+bounces-27611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFEBAB4C77
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 09:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3487A27AF
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 07:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176711EB1A9;
	Tue, 13 May 2025 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="s0M+IzV8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002B91EDA2C
	for <linux-pci@vger.kernel.org>; Tue, 13 May 2025 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120119; cv=none; b=uq8EDhJU6d0eVWcbMknNj/3z0JWRLOK+zibWIMGvS4qPIyP3n7Spub1wERWJ9MekqcfXPwl3I9fmoYDHWXFwZyPlyB/5tNAv6FYOMXGAgb/8q/11wWpiR++VKPYwaIf5utrIfleU/urH5VjTa+Zxn+Yqqa894kNHOsMCpE/PFeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120119; c=relaxed/simple;
	bh=Loe6TzB5ohL/4Ce5AQmXhlxmASWaIASXEpvdB+/Oxc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcHzE02YxIvk+bjIWEXGY+cTn5SwC+fHkHEsbE1NR9szN1CqA9bgGHAnGDzZGYhXpoq1L/eXaZ+uZEO2zPAzf8mXHr5B3u4c2XbrHqeTi6ggCxku5rYTs1Y39zos1IvAPX/yHUKSTi496VBCrsS5vkKS7JpwdXRuv0iiYvXF7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=s0M+IzV8; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6EFF04AC65;
	Tue, 13 May 2025 09:08:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1747120110;
	bh=Loe6TzB5ohL/4Ce5AQmXhlxmASWaIASXEpvdB+/Oxc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0M+IzV8qkVF4MnnP9DQAOKyytLifVa+gDXnxIVtKoGlOlRx8h7g0SFeKmAWVQbPh
	 ItmCWFhAytiJbc0zLG8trGAiBdCFP/qtZXOwjpQgH5tDwwAJl0xJUcn7Xj9gNAhxPi
	 lvKVHwrWgqkefpjte5F8SW3hNR2xKRVUtPOOKN5JKieoIQMlMTOmv1XCmvES6Gav2+
	 fyYwXQr5zLqq4hevNYYIU8WBtTR8VQvqj7SRKfI7UGVCl1SQRHQ1MEzQfeEgMt2l6X
	 YgycamEtVMYJ35H1YK52RYXmJ1U4kBn87AmQwASCsEJxGvoVIYzfUie73+hJ5h5Cg8
	 hJRhnFvLgyWkg==
Date: Tue, 13 May 2025 09:08:29 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] Revert "iommu/amd: Prevent binding other PCI drivers
 to IOMMU PCI devices"
Message-ID: <aCLv7cN_s1Z4abEl@8bytes.org>
References: <cover.1745572340.git.lukas@wunner.de>
 <9a3ddff5cc49512044f963ba0904347bd404094d.1745572340.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a3ddff5cc49512044f963ba0904347bd404094d.1745572340.git.lukas@wunner.de>

On Fri, Apr 25, 2025 at 11:24:21AM +0200, Lukas Wunner wrote:
> Commit 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and
> pcibios_free_irq()") changed IRQ handling on PCI driver probing.
> It inadvertently broke resume from system sleep on AMD platforms:
> 
>   https://lore.kernel.org/r/20150926164651.GA3640@pd.tnic/
> 
> This was fixed by two independent commits:
> 
> * 8affb487d4a4 ("x86/PCI: Don't alloc pcibios-irq when MSI is enabled")
> * cbbc00be2ce3 ("iommu/amd: Prevent binding other PCI drivers to IOMMU
>                  PCI devices")
> 
> The breaking change and one of these two fixes were subsequently reverted:
> 
> * fe25d078874f ("Revert "x86/PCI: Don't alloc pcibios-irq when MSI is
>                  enabled"")
> * 6c777e8799a9 ("Revert "PCI, x86: Implement pcibios_alloc_irq() and
>                  pcibios_free_irq()"")
> 
> This rendered the second fix unnecessary, so revert it as well.  It used
> the match_driver flag in struct pci_dev, which is internal to the PCI core
> and not supposed to be touched by arbitrary drivers.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Acked-by: Joerg Roedel <jroedel@suse.de>


