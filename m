Return-Path: <linux-pci+bounces-33993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62770B25541
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C6516A6D9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 21:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09A52D47F7;
	Wed, 13 Aug 2025 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hom5yvlZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1195286D6B;
	Wed, 13 Aug 2025 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120141; cv=none; b=swxG4WD9xX6XRvnu7hBLmfw5d9x7OPgX9c9aq9+/TpHks/BuXxP+8NpqwMgws7jDWonsYV2N7+P8PFQXLGXTwpESk0ALbclEcNE/BGxA29EsA9lga5St1TUSmv2OV4hYZYixDKGuQom9ZQB/k8gPMCTHBi2kmE/7JtVGZTAwF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120141; c=relaxed/simple;
	bh=jOyMn9dtqvh/9ep6s+bvq0jUruv1N2SPd6/+nQzCeFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UC3qjth0euG1Ym9lUPz3M4eSdgDwi/wno2I3XWGArLE+DxvCbVYChZ0C7v1/Kj82XNW7BMpFxuMvHgr1HwWjMlAXuRghtQIgwgD6xLC+qFFadeP0KJ8gd+FXxKCrmBNG/VA3yQD09NWaeNDjmfMwn6haGuIUK7UatD9iA/Itx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hom5yvlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AD0C4CEEB;
	Wed, 13 Aug 2025 21:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755120141;
	bh=jOyMn9dtqvh/9ep6s+bvq0jUruv1N2SPd6/+nQzCeFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hom5yvlZtVVD3nCZUEXH0Z98bLXFdGzwRvl/ETxGqpXkfdL8sLWcB735nkfn8dp/I
	 5h5jst3Dppot5DcWTitHbMczp85JgskbTDJczbb18BIAAUUiE9LaqwUaJ6sM4AdBuN
	 VlreHRRzSYB92KzUjg8b1+5KPXSh3akG2bUa/gshp/Gz+9z6J84oCwsqhHAgFYdAL4
	 IaowqSOXnvDM3RxaXV9xOp7allA3vRJxXZ/U9nL7dcQK3WOERfCNi2YA1V6vMimm0G
	 RlYoT73E7Tgb5T1QzsnZDJd7Pn8vrHHVa/fhVVinCuA/x4DRzjSqZRGOwqfXTrRU0b
	 hlSR1tqJJXsWw==
Date: Wed, 13 Aug 2025 16:22:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	dlan@gentoo.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	tglx@linutronix.de, johan+linaro@kernel.org,
	thippeswamy.havalige@amd.com, namcao@linutronix.de,
	mayank.rana@oss.qualcomm.com, shradha.t@samsung.com,
	inochiama@gmail.com, quic_schintav@quicinc.com, fan.ni@samsung.com,
	devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] PCI: spacemit: introduce SpacemiT PCIe host driver
Message-ID: <20250813212219.GA294849@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813184701.2444372-6-elder@riscstar.com>

On Wed, Aug 13, 2025 at 01:46:59PM -0500, Alex Elder wrote:
> Introduce a driver for the PCIe root complex found in the SpacemiT
> K1 SoC.  The hardware is derived from the Synopsys DesignWare PCIe IP.
> The driver supports three PCIe ports that operate at PCIe v2 transfer
> rates (5 GT/sec).  The first port uses a combo PHY, which may be
> configured for use for USB 3 instead.

I assume "PCIe v2" means what most people call "PCIe gen2", but the
spec encourages avoidance "genX" because it's ambiguous.

> +config PCIE_K1
> +	bool "SpacemiT K1 host mode PCIe controller"

Style of nearby entries is:

  "SpacemiT K1 PCIe controller (host mode)"

Please alphabetize by the company name ("SpacemiT") in the menu entry.

> +#define K1_PCIE_VENDOR_ID	0x201f
> +#define K1_PCIE_DEVICE_ID	0x0001

I assume this (0x201f) has been reserved by the PCI-SIG?  I don't see
it at:

  https://pcisig.com/membership/member-companies?combine=0x201f

Possibly rename this to PCI_VENDOR_ID_K1 (or maybe
PCI_VENDOR_ID_SPACEMIT?) to match the usual format in
include/linux/pci_ids.h, since it seems likely to end up there
eventually.

> +#define PCIE_RC_PERST			BIT(12)	/* 0: PERST# high; 1: low */

Maybe avoid confusion by describing as "1: assert PERST#" or similar?

> +	/* Wait the PCIe-mandated 100 msec before deasserting PERST# */
> +	mdelay(100);

I think this is PCIE_T_PVPERL_MS.  Comment is superfluous then.

> +static int k1_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dw_pcie_rp *pp;
> +	struct dw_pcie *pci;
> +	struct k1_pcie *k1;
> +	int ret;
> +
> +	k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
> +	if (!k1)
> +		return -ENOMEM;
> +	dev_set_drvdata(dev, k1);

Most neighboring drivers use platform_set_drvdata().  Personally, I
would set drvdata after initializing k1 because I don't like to
advertise pointers to uninitialized things.

> +static void k1_pcie_remove(struct platform_device *pdev)
> +{
> +	struct k1_pcie *k1 = dev_get_drvdata(&pdev->dev);

Neighbors use platform_get_drvdata().

> +	struct dw_pcie_rp *pp = &k1->pci.pp;
> +
> +	dw_pcie_host_deinit(pp);
> +}

