Return-Path: <linux-pci+bounces-20852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC3CA2B78F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 02:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7A91887F6B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 01:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9DA200CD;
	Fri,  7 Feb 2025 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOCjwLbg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178CF2417F6;
	Fri,  7 Feb 2025 01:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738890060; cv=none; b=csbgbv6sAkH3xHLwNIJcqiuQjA+/4K2Y1TthZ5bT+1DXDQQzSXbgLimCGYSx3Cq11v/fqFN/Um/IWb7algRtpUgS9g4P2NuMk6znyNDEhAwPUrDcfJUPUqV+boCBaJpYtSotHxUNVfPzDyAxBjwIB8AEdoJYVDKoYDB60F8hBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738890060; c=relaxed/simple;
	bh=2zlBRXFp285eW8jH670CREg2IMoxrfPKqqFCyMt7Vx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOLyLfv5KkjepM4b6UfSI01rPDRmkq3diswO4lhlY6H+NrP141lfIWUP0hJA93oKrNfwGXdfJhXkplGvezwJ+Px7VEvBrO/woiXOa5s4Bs6sncZFwAguY8a0cTJyKNtVTSY8+yH8XMCLMJMz1z7WL/GEYyQ+i9ihZeeMb4NvmA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOCjwLbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD95C4CEDD;
	Fri,  7 Feb 2025 01:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738890059;
	bh=2zlBRXFp285eW8jH670CREg2IMoxrfPKqqFCyMt7Vx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOCjwLbgj36OdK+znGM+w3lQld2L0iwXrGCKtXo1KOEnl3iB37J7ZwpJp4heUohD1
	 VeVqi0EDPI5guj4r5PGVpk6bSCYOpN55tpiV8oBChfmkzcTkOSSpW8FyqC4o+Y2aHM
	 B0Hb2AkRmbbC2FDNZCmM/HCRQACaNucikEOFVCzxN/cMdaVAAhrhHDa9+chh+vken9
	 tuZbVSH5tQpPpJo7yaRDRdMYZgNCAW7bOSXaDTJZDWX36d8ZddBhYinsBjhrdmkp6r
	 gr9kEyK7oerD73avSIPqMeW8rtCndt+klnezRdKwbeYSNScy+rEzst99AljGjwhgCm
	 0D4eSvZRGcOCA==
Date: Thu, 6 Feb 2025 17:00:59 -0800
From: Kees Cook <kees@kernel.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	apopple@nvidia.com, jhubbard@nvidia.com, jgg@nvidia.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] x86/kaslr: Revisit entropy when CONFIG_PCI_P2PDMA is
 enabled
Message-ID: <202502061700.5C52C6D453@keescook>
References: <20250206234234.1912585-1-balbirs@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206234234.1912585-1-balbirs@nvidia.com>

On Fri, Feb 07, 2025 at 10:42:34AM +1100, Balbir Singh wrote:
> When CONFIG_PCI_P2PDMA is enabled, it maps the PFN's via a
> ZONE_DEVICE mapping using devm_memremap_pages(). The mapped
> virtual address range corresponds to the pci_resource_start()
> of the BAR address and size corresponding to the BAR length.
> 
> When KASLR is enabled, the direct map range of the kernel is
> reduced to the size of physical memory plus additional padding.
> If the BAR address is beyond this limit, PCI peer to peer DMA
> mappings fail.
> 
> Fix this by not shrinking the size of direct map when CONFIG_PCI_P2PDMA
> is enabled. This reduces the total available entropy, but it's
> better than the current work around of having to disable KASLR
> completely.
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/lkml/20250206023201.1481957-1-balbirs@nvidia.com/
> 
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>

Thanks for the update!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

