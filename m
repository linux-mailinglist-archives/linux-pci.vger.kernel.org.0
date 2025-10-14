Return-Path: <linux-pci+bounces-38081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C195EBDB043
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 21:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C53534EFD50
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 19:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AF42C030E;
	Tue, 14 Oct 2025 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQfNSLMc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA612BE7A6;
	Tue, 14 Oct 2025 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469212; cv=none; b=hTsWl5tlqyXvWrnduf4nf7SdDsr7HKF5StKEgAwyYhvEcqxiq9690RcUIMQPJrb3DJFPRmZl0B6Dj1SEldX6Zs0vAf7p37wmTcry9Kav/jX0yHkRUTqd4p90D8ikR6xWmf1Gdg892Gsk9Z65bdfwtEKeHKnXMNvD5C9Nzjchkm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469212; c=relaxed/simple;
	bh=VeQgHIyvUFeBDOXS6P2izT3xDp9jOMmhgF0q1loUIqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Edk2k7L7qike1+d3ki1BV/4f0EQWGVFiU36giGJeKkt/2nPeAih60GmtIKnHXSi034TIP+ezOAaj8PyVcm2JXiPAQt/kx5ou6LV9JnyxRUUIAd1LeGun/PHYa93S7hm+1dcxZraBOvw8H0Za+zx3UO4BuJzUqKu4kmkMtsO0GkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQfNSLMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24428C4CEE7;
	Tue, 14 Oct 2025 19:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760469212;
	bh=VeQgHIyvUFeBDOXS6P2izT3xDp9jOMmhgF0q1loUIqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CQfNSLMcWllvP4XtgkrBezgM3iRNGCyeKHBos3S3qa4N1X+3aEqm7qoex1o/DWiHu
	 Yaz5ZLyWoXTC34ZpeMV8JzWCin3oeYT43/Nz5I53XoaKJL6xrnlUNkIsjbxQsFpj4x
	 XrDB8FbFJ2XfYkay4HeuyItd468Dchp1gxdPRh9oHqcV4RB/Yqhzf+f31yKnw/SJjP
	 3OIGyLc5xXh0IkS5UfkOLTckUIQCRavAwnEjY0wy3VmUqaMag7tlAODjWXBJJ94D2k
	 2HGte1SMbgW2nODLKC26lCixwhZsOg/ElWKH1epxu24IImyN5upkf1DhDTUXR4gabt
	 fPfbWlujJWXlg==
Date: Tue, 14 Oct 2025 14:13:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] PCI: rcar-host: Add OF Kconfig dependency to avoid
 objtool no-cfi warning
Message-ID: <20251014191330.GA899677@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-rcar_pcie_probe-avoid-nocfi-objtool-warning-v2-1-6e0204b002c6@kernel.org>

On Tue, Oct 14, 2025 at 11:20:27AM -0700, Nathan Chancellor wrote:
> After commit 894af4a1cde6 ("objtool: Validate kCFI calls"), compile
> testing pcie-rcar-host.c with CONFIG_FINEIBT=y and CONFIG_OF=n results
> in a no-cfi objtool warning in rcar_pcie_probe():
> 
>   $ cat allno.config
>   CONFIG_CFI=y
>   CONFIG_COMPILE_TEST=y
>   CONFIG_CPU_MITIGATIONS=y
>   CONFIG_GENERIC_PHY=y
>   CONFIG_MITIGATION_RETPOLINE=y
>   CONFIG_MODULES=y
>   CONFIG_PCI=y
>   CONFIG_PCI_MSI=y
>   CONFIG_PCIE_RCAR_HOST=y
>   CONFIG_X86_KERNEL_IBT=y
> 
>   $ make -skj"$(nproc)" ARCH=x86_64 KCONFIG_ALLCONFIG=1 LLVM=1 clean allnoconfig vmlinux
>   vmlinux.o: warning: objtool: rcar_pcie_probe+0x191: no-cfi indirect call!
> 
> When CONFIG_OF is unset, of_device_get_match_data() returns NULL, so
> LLVM knows this indirect call has no valid destination and drops the
> kCFI setup before the call, triggering the objtool check that makes sure
> all indirect calls have kCFI setup.
> 
> This driver depends on OF for probing with non-NULL data for every match
> so this call will never be NULL in practice. Add a hard Kconfig
> dependency on OF to avoid the warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510092124.O2IX0Jek-lkp@intel.com/
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2134
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Changes in v2:
> - Switch from NULL check to avoiding CONFIG_OF=n case altogether (Mani,
>   Geert).
> - Drop Peter and Kees's reviews, as solution is not the same.
> - Link to v1: https://patch.msgid.link/20251013-rcar_pcie_probe-avoid-nocfi-objtool-warning-v1-1-552876b94f04@kernel.org
> ---
>  drivers/pci/controller/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 41748d083b93..d8688abc5b27 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -243,6 +243,7 @@ config PCI_TEGRA
>  config PCIE_RCAR_HOST
>  	bool "Renesas R-Car PCIe controller (host mode)"
>  	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on OF

Ugh.  This might be the best solution, but it's a bit problematic
without a hint about why "depends on OF" is here.  Theoretically there
are stubs for everything to make COMPILE_TEST work, so I think we're
about to drop all the dependencies on OF.

This dependency to avoid a no-cfi warning looks like the kind of thing
that could someday go away if the tools get smarter.  Maybe we can add
a Kconfig comment here, but I don't really know enough to write one.
Something like this?

  depends on OF   # avoid no-cfi warning https://lore.kernel.org/r/202510092124.O2IX0Jek-lkp@intel.com/

