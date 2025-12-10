Return-Path: <linux-pci+bounces-42900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2887ECB3824
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 17:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67C8B3011EC7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0359F323416;
	Wed, 10 Dec 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwopFP4j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C53233E3;
	Wed, 10 Dec 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765385009; cv=none; b=X1TPigmBJQLD9RvwLVwpvIt6UPU71mKywL7RM0hBmKtGBX5Uy1fkZxSYS1KV2lkUvPtzeSWS/SHpvXFyNI00aTF/58VIcmvZ1MJ4lfJoXWkK1okuCLYbduXZRzWrVz5uUrC9+vQvTmfZGChfaJWpFlLH/wjAt70sOalUuTz7Eb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765385009; c=relaxed/simple;
	bh=D6oMO8hz9iCEccabjb39VyXWX9MEu9ZISEEglyieFkE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AkNC6rhdTYd9G4QE5PzMv/YV/CZt0QDSlypB514LU1xFmSgsqVol8reCzQ3yMuTQMhLF2fFNkjbdU/L+X1MS8yHHyGPV0lz9NJGrObXWFF0CshLNyjoLBsLiMjdL6nlsaaDf0VGzbJ7oMurvwy2NVJn1BnDkDb/CZoZSZXQjJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwopFP4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C9CC4CEF1;
	Wed, 10 Dec 2025 16:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765385009;
	bh=D6oMO8hz9iCEccabjb39VyXWX9MEu9ZISEEglyieFkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jwopFP4jBNqfZmSihJanQd3drbFgmVOEHv4W3zy1K53cnGquk8vxqBX3CyB4t092w
	 Xi17V3xkxD1nSk2eZgvdYwRhIuNSeKZ8j7waJWD11k9LgM2KuLWM5cCw87OROWm0FT
	 9nGcR8pPD3SJsH+wLpInCEcF6CM9UNkiXExjc2HlYBxLtQYiZXnKaUDSDvRKJcK8AN
	 ZCdwaewQxLAxxk2LEwEAbWjjCuU7QN/ta9fJgaLmaphnYsfk6RoV+uGcE7qPbMWIAB
	 nvP1mAJlwXNadfSvw8y5Lz3obfoVQ+oC4xKdtLHS2ZoqWUUNfv/vI8XZMyBdjwO8VC
	 KapgOqfxgsc6w==
Date: Wed, 10 Dec 2025 10:43:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
Subject: Re: [PATCH v7 2/3] PCI: eic7700: Add Eswin PCIe host controller
 driver
Message-ID: <20251210164327.GA3477281@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202090406.1636-1-zhangsenchuan@eswincomputing.com>

On Tue, Dec 02, 2025 at 05:04:06PM +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> the DesignWare PCIe core, IP revision 5.96a. The PCIe Gen.3 controller
> supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> interrupts.

> +static int eic7700_pcie_host_init(struct dw_pcie_rp *pp)
> ...
> +	/*
> +	 * The PWR and DBI Reset signals are respectively used to reset the
> +	 * PCIe controller and the DBI registers.
> +	 * The PERST# signal is a reset signal that simultaneously controls the
> +	 * PCIe controller, PHY, and Endpoint.
> +	 * Before configuring the PHY, the PERST# signal must first be
> +	 * deasserted.
> +	 * The external reference clock is supplied simultaneously to the PHY
> +	 * and EP. When the PHY is configurable, the entire chip already has
> +	 * stable power and reference clock.
> +	 * The PHY will be ready within 20ms after writing app_hold_phy_rst
> +	 * register of ELBI register space.

Add blank lines between paragraphs.

> +static int eic7700_pcie_probe(struct platform_device *pdev)
> ...
> +	pci->no_pme_handshake = pcie->data->no_pme_handshake;

This needs to go in the 3/3 "PCI: dwc: Add no_pme_handshake flag and
skip PME_Turn_Off broadcast" patch because "no_pme_handshake" doesn't
exist yet so this patch doesn't build by itself.

> +static const struct dev_pm_ops eic7700_pcie_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(eic7700_pcie_suspend_noirq,
> +				  eic7700_pcie_resume_noirq)
> +};

Use DEFINE_NOIRQ_DEV_PM_OPS() instead.  The collection of PM-related
macros is confusing to say the least, and they're not used
consistently across the PCIe drivers, but I *think* the rule of thumb
should be:

  Prefer DEFINE_NOIRQ_DEV_PM_OPS() over NOIRQ_SYSTEM_SLEEP_PM_OPS()
  when possible and omit pm_sleep_ptr() and pm_ptr().

Bjorn

