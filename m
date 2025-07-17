Return-Path: <linux-pci+bounces-32456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC130B0962F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 23:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790D31895331
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 21:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D101F9EC0;
	Thu, 17 Jul 2025 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWP1mnIr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FB952F88;
	Thu, 17 Jul 2025 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786044; cv=none; b=Dx2bB/qkk8hHnt8fads8B16A2b7MtZmMyJJif1Thr9ypHPU9/DClkg26NcwWh/FgcfApFpC62MskYVSEnRyZiE86w/dV8t0rIXSIkF6F/XN3poVihvQJJaew207nWgTiNeNBwqjaSXgpl5A6sCvPl3SXFxrEYidx6ynVgmvs3LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786044; c=relaxed/simple;
	bh=/EjOlRgaOAKxQ/Fnx16PJ9ZVpkCp4GhVajGljGUfwlI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iCG+GmbLB3NrgbekU5p9vUn18Js8RjE6p/fwBkCAhf2YXPkxi9SQhRMjml0r2bf33z+MF36y0X3NH86xtHLOtWKrtgxp2JRm9P7ibgIrmMj4Wpy5x8cSPgKycxnActEzZsrrxJ69ulficuVt2+QYiJkNSZiN5hh09nyRhopwTIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWP1mnIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA08C4CEE3;
	Thu, 17 Jul 2025 21:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752786044;
	bh=/EjOlRgaOAKxQ/Fnx16PJ9ZVpkCp4GhVajGljGUfwlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fWP1mnIrbJEQLgem/+IU3XUqtpSHOijqCm9SBr3S17fR5GtE5UlxwyLGZOgVCkEmS
	 HjP0rr46X76GQL+864wm4/EmpRLf1BwFJ7yC2CpWvgfnlUrJR4SLLOkpx++hQBzdHA
	 BFGvR1F5Aqr6sLxc7DE9vXe0yBQnqLVWSXYqLk0igTyzKKMQ4MAa7z+vglgjWPxZ4B
	 K5K/8d0uwGu0+0sec2F0vWF356dlAgAKib+mtXtKDhYOD84CBsJyc5dfn69LPBm/DF
	 NKS6+MR1DceNNPbgqxVxcST+cMpUeoj/SWvNG0XRxp3bcL2uVk8oAymmA4Vmzz5AsP
	 9pyRKfb2ZIkLA==
Date: Thu, 17 Jul 2025 16:00:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: brcmstb: Trivial changes
Message-ID: <20250717210043.GA2654580@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175275644815.7439.10347177721311626088.b4-ty@oss.qualcomm.com>

On Thu, Jul 17, 2025 at 06:17:28PM +0530, Manivannan Sadhasivam wrote:
> 
> On Tue, 24 Jun 2025 16:19:21 -0700, Florian Fainelli wrote:
> > The first patch removes Nicolas from the maintainers list since he has
> > not been active and the second patch uses an existing constant rather
> > than open code the value.
> > 
> > Florian Fainelli (2):
> >   MAINTAINERS: Drop Nicolas from maintaining pcie-brcmstb
> >   PCI: brcmstb: Replace open coded value with PCIE_T_RRS_READY_MS
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/2] MAINTAINERS: Drop Nicolas from maintaining pcie-brcmstb
>       commit: fde41f282590b46e96864ae88da2e2c20a967b3a
> [2/2] PCI: brcmstb: Replace open coded value with PCIE_T_RRS_READY_MS
>       commit: e8e7c1e95d6d4ccdc53654a5966d2183532ab115

Thanks, I updated s/PCIE_T_RRS_READY_MS/PCIE_RESET_CONFIG_WAIT_MS/
when merging this branch to account for the removal of
PCIE_T_RRS_READY_MS by
https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=bbc6a829ad3f
("PCI: rockchip-host: Use macro PCIE_RESET_CONFIG_WAIT_MS")

