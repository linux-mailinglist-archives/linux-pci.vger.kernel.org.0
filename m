Return-Path: <linux-pci+bounces-2748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D628B84171E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 00:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B3C1C21B07
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 23:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D3353E29;
	Mon, 29 Jan 2024 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NClr7Kfn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869253E24;
	Mon, 29 Jan 2024 23:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571989; cv=none; b=J9DA9mBEOZcCYokA2zzTBjl2L0LEW1leiM3jFR8QZSOp6GmeO4Vo9Zul2wmGVZzdZaTpaTp5LzlwZU8upkI2HmSgUrwriCA5hl3Kin12D4KNz1Fks4X/9XVxtwWWHxpDxLvlo/rWIEdspvsSOsLwgOiwFQc4f9whNWezqE746OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571989; c=relaxed/simple;
	bh=cpXCtIujLMZQdsxt28UBk2BvsjLuYdx+fvr2xcxohvw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jemYC7g4ii2tkG9sve5q8+FcVwaUnU+O2ofqF1a3dUbfgUp0ghLPN3Df2+VYC4hK6bZYUJTROgoj3YIOcEF/rL68tYr+BpJOAIXw7imgn+F1UQzw6NqLZ12+YbauRXSUf/V0rUzTz1Adqbz3mtw6Q4X095+RZgGl8shKCi8DAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NClr7Kfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F366C43394;
	Mon, 29 Jan 2024 23:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706571988;
	bh=cpXCtIujLMZQdsxt28UBk2BvsjLuYdx+fvr2xcxohvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NClr7Kfnhc8HKEZ7PRgBd01SHUvK/vdBeLPHv1PNjEQao4xcYyA15tk/CbD3jjxdb
	 SFJTu1zvsz/9tNLPgnrcpX29SY5HN6ijYB0NlDcLrwNzsMvkE+0Vgg8j44GVQ/TiXP
	 lRgcmtJ8s2M5LptuXveifrfAN71rpSzrj1ztFyvbig4APCt2K39d0R9KXNhH3BQUdY
	 QRMY3Zipka53Ubk/Qe3lw6s1DhWXySI1t+s6FlGuVFOAHVYlH27yzYGMB8ykH1R5M2
	 t7AC1mLYr4VYeGMAKJYUgclaKqg6M/a7J+c+rgUVw8f/dn5uc7eOi5Wgt2t++X3p8D
	 o9X72JDZg8dMg==
Date: Mon, 29 Jan 2024 17:46:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: mika.westerberg@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com, rjw@rjwysocki.net, tasev.stefanoska@skynet.be,
	enriquezmark36@gmail.com, kernel@witt.link, wse@tuxedocomputers.com,
	vidyas@nvidia.com, kai.heng.feng@canonical.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, ricky_wu@realtek.com,
	mario.limonciello@amd.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Always build aspm.c
Message-ID: <20240129234627.GA487749@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128233212.1139663-1-david.e.box@linux.intel.com>

On Sun, Jan 28, 2024 at 03:32:07PM -0800, David E. Box wrote:
> Here is the series to always build aspm.c, add back L1SS save/restore, and
> consolidate all ASPM related code in aspm.c.
> 
> Patch 1 - Moves all PCI core functions running under CONFIG_PCIEASPM into
> aspm.c and changes they Makefile to always build it. No functional changes.
> 
> Patch 2 - Creates a separate function to save the L1SS offset and places it
> outside of CONFIG_PCIEASPM in aspm.c so that the offset is available for
> later use by the L1SS save/restore code which needs to run when
> CONFIG_PCIEASPM=n.
> 
> Patch 3 - Updated L1 Substate save/restore patch from previous V5 [1].
> 
> Patch 4 - Moves the LTR save/restore state functions into aspm.c outside of
> CONFIG_PCIEASPM.
> 
> Patch 5 - Moves the LTR save/restore state calls into
> pci_save/restore_pcie_state().
> 
> The series does not continue any of the ASPM robustness changes proposed by
> Ilpo [2]. But if we think it's worth combining with this series I can
> add it and help continue the work.
> 
> [1] https://lore.kernel.org/linux-pci/20231221011250.191599-1-david.e.box@linux.intel.com/
> [2] https://lore.kernel.org/linux-pci/20230918131103.24119-1-ilpo.jarvinen@linux.intel.com/
> 
> David E. Box (5):
>   PCI: Always build aspm.c
>   PCI: Create function to save L1SS offset
>   PCI/ASPM: Add back L1 PM Substate save and restore
>   PCI: Move pci_save/restore_ltr_state() to aspm.c
>   PCI: Call LTR save/restore state from PCIe save/restore
> 
>  drivers/pci/pci.c         |  91 ++++----------
>  drivers/pci/pci.h         |  10 +-
>  drivers/pci/pcie/Makefile |   2 +-
>  drivers/pci/pcie/aspm.c   | 257 ++++++++++++++++++++++++++++++++++++--
>  drivers/pci/probe.c       |  62 +--------
>  include/linux/pci.h       |   4 +-
>  6 files changed, 283 insertions(+), 143 deletions(-)
> 
> 
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a

Rebased to v6.8-rc1 and applied to pci/aspm for v6.9, thanks!

