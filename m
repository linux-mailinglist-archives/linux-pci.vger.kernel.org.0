Return-Path: <linux-pci+bounces-43748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC5FCDF1FE
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 00:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 629643000B63
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 23:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE13621FF5B;
	Fri, 26 Dec 2025 23:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIBvyqte"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB552B2DA;
	Fri, 26 Dec 2025 23:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766792813; cv=none; b=iYD/gMwYjvjyHrh5AxoRhTCfZThhCC1H3jqebR9Wn8ifiTTh++/JSPciuYarOqKcWQ/lDR3gMBY5zmFY4x0mkSrFulCWM2xvU1dryvQZ6nR7mooPoEbobpupfit61efeaECTCSa5eo016ux6900/C6i482zf0GToMffuCnDo7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766792813; c=relaxed/simple;
	bh=mNwbS3FHpwKCBARgVxIQ6GeM8kLKlZvOA+pbE6NdXDE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mmqIVC0HP8tL6lNS00kdt7qr6Yihu/LM/yh2BbbeCXn9CX4r9J8daZVdshrbGyMd12N/XURK8t/SP8t9acLiIA8Dq9VOeXItxPJExtxFgQljXLdYQ6b5mE1K2CpAIkGXzGWNDBOnSA+U9MAagPVhIu03TYRMPw/2skEOPFLkvts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIBvyqte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF764C4CEF7;
	Fri, 26 Dec 2025 23:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766792813;
	bh=mNwbS3FHpwKCBARgVxIQ6GeM8kLKlZvOA+pbE6NdXDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DIBvyqtesOH1on+kWKFitpmCpw/8xWzrnv7rSzSGryD0GOIUb+sKtUrpI6+CDoRNg
	 zGWmE25HQHVAqO5tJIvzr80CbDxNA461ZRdVpEtJi6Ko8seHti6uMPavxHxYWdmgGm
	 q2oW4/5lPMyE3DpoadKBUp4ES3mgFHusPRSSvbheeC5DcBmR5s7ZFbaO7DxigGCwGg
	 Q0p/lmlei0OvDHTZrhzyC0Wyhr1udB+4bsqHn2iAxPz2UPATX42YQF3DXPcP9JVxFE
	 r3qXkatr5isuw3GZkZC9+9P5DL95FB21CLac4Xe993XTuDt/Fp/aU6qqOOyMa7Lrj0
	 RnLnTX+brEQXA==
Date: Fri, 26 Dec 2025 17:46:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] PCI: rcar-host: Add OF Kconfig dependency to avoid
 objtool no-cfi warning
Message-ID: <20251226234651.GA4148926@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176603538085.6580.3625113457403612097.b4-ty@kernel.org>

On Thu, Dec 18, 2025 at 10:53:00AM +0530, Manivannan Sadhasivam wrote:
> On Tue, 14 Oct 2025 11:20:27 -0700, Nathan Chancellor wrote:
> > After commit 894af4a1cde6 ("objtool: Validate kCFI calls"), compile
> > testing pcie-rcar-host.c with CONFIG_FINEIBT=y and CONFIG_OF=n results
> > in a no-cfi objtool warning in rcar_pcie_probe():
> > 
> >   $ cat allno.config
> >   CONFIG_CFI=y
> >   CONFIG_COMPILE_TEST=y
> >   CONFIG_CPU_MITIGATIONS=y
> >   CONFIG_GENERIC_PHY=y
> >   CONFIG_MITIGATION_RETPOLINE=y
> >   CONFIG_MODULES=y
> >   CONFIG_PCI=y
> >   CONFIG_PCI_MSI=y
> >   CONFIG_PCIE_RCAR_HOST=y
> >   CONFIG_X86_KERNEL_IBT=y
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] PCI: rcar-host: Add OF Kconfig dependency to avoid objtool no-cfi warning
>       commit: 57833f84f6f5967134c9c1119289f7acdd1c93e9

Is this v6.19 material?  The patch is old, 894af4a1cde6 appeared in
v6.18, and it's not really a regression, but it only affects
PCIE_RCAR_HOST and it looks like it papers over a headache for static
analysis.

Bjorn

