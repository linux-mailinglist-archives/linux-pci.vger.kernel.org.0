Return-Path: <linux-pci+bounces-24605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E679A6E8A3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 04:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB7C27A344C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 03:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7512419DFAB;
	Tue, 25 Mar 2025 03:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBcMZ2az"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450761FDD;
	Tue, 25 Mar 2025 03:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742872670; cv=none; b=GygaoAIhzin0F8ETaRu49fAy9+gmn9zQZIRLY4zm3hgMtzBMXmyPsz2Q/10WPIc18uw6XzcttGCTJPInb5tPblcfTVhqFCw29pKnQ+G9BIcoKWaei6c6L2Ig4Zzckcyz9/KtD0zo9gbmwUA69wdzpD3nLiDuJ8r2EfoA3ZrswOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742872670; c=relaxed/simple;
	bh=gYwpeb2EZNZ+wO6LD2t7gQ6MM0ApL/ziRmZDPDwMe2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fboV+LVVmA4T35m8SEd9CRiJuLgrHqs8+UP8QuaW40VDlX5MgJOoXpqzu4w2WpzvsOV8PBqXcmG1L3yF2+3+6ZD0npcmRNPv66bAussAHPKripFZFb2lCqQ+xlJMuSTZw/O8w+NOxucUYl1QLtIkm5NMVihm2a7BKGalq/tb0VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBcMZ2az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860E5C4CEDD;
	Tue, 25 Mar 2025 03:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742872669;
	bh=gYwpeb2EZNZ+wO6LD2t7gQ6MM0ApL/ziRmZDPDwMe2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBcMZ2azJwZUFWvH0QcEl7V/6CguV/7xugJWN8URvPwSE7X56fmHII3KKBvHKz3ev
	 tZGvpNesO8pAvfXhQRiXS8Yv3BaoepPd/Zc50g/IqtbUpi62Zfu08pSmWDymlIQ1MV
	 GjG6aHi5Q29/ggZtILQlgxEzhWEIgKpNWpdj3C6zcTrbAqdHTNdiOuCPZShVRjrmkX
	 AtjX2uR69bfua9gSwQW1OIVX77eZD8nxQWGAmj+/7Ih2Jjd0JpWzUUJ8i0CVOxasvC
	 r0hJ7pZI2j+pCEXOGgYm0+XjZ30IHODMjjZ9xXmpGwjQKB7Ba3d9BczVrCng7cBc0m
	 SP2c3m691exrg==
Date: Mon, 24 Mar 2025 22:17:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Greentime Hu <greentime.hu@sifive.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Tom Joseph <tjoseph@cadence.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, Jim Quinlan <jim2101024@gmail.com>,
	devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-riscv@lists.infradead.org,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: Correct indentation and style in
 DTS example
Message-ID: <174287266828.1624468.7570940248858053984.robh@kernel.org>
References: <20250324125202.81986-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324125202.81986-1-krzysztof.kozlowski@linaro.org>


On Mon, 24 Mar 2025 13:52:01 +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pci/brcm,stb-pcie.yaml           |  81 +++++++------
>  .../bindings/pci/cdns,cdns-pcie-ep.yaml       |  16 +--
>  .../bindings/pci/intel,keembay-pcie-ep.yaml   |  26 ++--
>  .../bindings/pci/intel,keembay-pcie.yaml      |  38 +++---
>  .../bindings/pci/microchip,pcie-host.yaml     |  54 ++++-----
>  .../devicetree/bindings/pci/rcar-pci-ep.yaml  |  34 +++---
>  .../bindings/pci/rcar-pci-host.yaml           |  46 +++----
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 112 +++++++++---------
>  8 files changed, 202 insertions(+), 205 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


