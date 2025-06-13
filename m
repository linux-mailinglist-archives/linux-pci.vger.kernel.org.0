Return-Path: <linux-pci+bounces-29773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A207AD9610
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 22:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8291E5C2E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 20:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D1124DCE0;
	Fri, 13 Jun 2025 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAJP7Rai"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43824BC1A;
	Fri, 13 Jun 2025 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845652; cv=none; b=Neezzc1ajfAaagum4ndyVBFaD7hZpTUz1j0qrkV/lDn9FicYq9KECzaApKavibTu9/BlweMRXgN6IElg8m5q/v1u6h0BGvWQedeeb/+E/jwhv/KCzR+jcDKrLE3BMFrJLe3yNrV7OhrlJ5oofcnr1ZJlSEVzJRq61kz0DDwcPbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845652; c=relaxed/simple;
	bh=Zio/9ed1ISRgWicUqk/j1UAIrxh6W2Aq1NctnSkSqjg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XZdu1lTl3Zujx837SLA58wS62U0U8nA8hWoBY9aQXXe338nIzaLNUFM/1+p+0IvJ/KvXsU9IcziD/gUkaJB7zgeH+Hx0LVqWv/wltYr3XWw5GnrU2lwOUaF+lDLfwuUM+sMlSCfE2HGyRv1aYtDPvD85NV2u6B72dUiBQ64LPpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAJP7Rai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C517AC4CEE3;
	Fri, 13 Jun 2025 20:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749845650;
	bh=Zio/9ed1ISRgWicUqk/j1UAIrxh6W2Aq1NctnSkSqjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IAJP7Raic0SQjqE3t8ej2YiZWcFDLxcJmuLnstD+ww4P3KgdECE5SlqmEi5uEyddi
	 YDto2pIAg7qcILAQnVArh8oefuPEdsdPYiixPquLyBIkr/ecbhxxM/Ryqsj1wQkYdF
	 7IStXXPPxsQTSt4dgXOxj/IGLRXwBb3sI4ATE9EgyHlKr2gMKp1GSaJbIbG7+cx5p0
	 ujnOhVrJN0B60glcRgz01Ju042eHHU+Yn4ueM1WQ2Lkbl5aiVnwjm2onOwvA8YvZnd
	 OT1IdOTIiJ5QEuP2Mx533U8q53XlJY5TtZ2CxpYL4QOXbtVSTEROAeAqEpPKADmbge
	 PPBLYTUp8U3jg==
Date: Fri, 13 Jun 2025 15:14:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v4 1/5] PCI: rockchip: Use standard PCIe
 defines
Message-ID: <20250613201409.GA973486@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <992ab6278af59b8f2f82521bf4611f69a916bbe1.1749827015.git.geraldogabriel@gmail.com>

On Fri, Jun 13, 2025 at 12:05:31PM -0300, Geraldo Nascimento wrote:
> Current code uses custom-defined register offsets
> and bitfields for standard PCIe registers. Change
> to using standard PCIe defines.

Wrap to fill 75 columns so there's space for "git log" to add
indentation.

> @@ -40,18 +40,18 @@ static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
>  {
>  	u32 status;
>  
> -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
>  	status |= (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
>  }
>  
>  static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
>  {
>  	u32 status;
>  
> -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
>  	status |= (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16;

It looks funny to write PCI_EXP_LNKCTL with bits from PCI_EXP_LNKSTA.
I guess this is because rockchip_pcie_write() does 32-bit writes, but
PCI_EXP_LNKCTL and PCI_EXP_LNKSTA are adjacent 16-bit registers.

If the hardware supports it, adding rockchip_pcie_readw() and
rockchip_pcie_writew() for 16-bit accesses would make this read
better.

Hopefully the hardware *does* support this (it's required per spec at
least for config accesses, which would be a different path in the
hardware).  Doing the 32-bit write of PCI_EXP_LNKCTL above is
problematic because writes PCI_EXP_LNKSTA as well, and PCI_EXP_LNKSTA
includes some RW1C bits that may be unintentionally cleared.

> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
>  }
>  
>  static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
> @@ -269,7 +269,7 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
>  	scale = 3; /* 0.001x */
>  	curr = curr / 1000; /* convert to mA */
>  	power = (curr * 3300) / 1000; /* milliwatt */
> -	while (power > PCIE_RC_CONFIG_DCR_CSPL_LIMIT) {
> +	while (power > FIELD_MAX(PCI_EXP_DEVCAP_PWR_VAL)) {
>  		if (!scale) {
>  			dev_warn(rockchip->dev, "invalid power supply\n");
>  			return;
> @@ -278,10 +278,10 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
>  		power = power / 10;
>  	}
>  
> -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCR);
> -	status |= (power << PCIE_RC_CONFIG_DCR_CSPL_SHIFT) |
> -		  (scale << PCIE_RC_CONFIG_DCR_CPLS_SHIFT);
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
> +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
> +	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
> +	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_SCL, scale);

This assumes the value you read from PCI_EXP_DEVCAP had zeroes in
these bits.  It might, but it would look safer to do:

  status &= ~(PCI_EXP_DEVCAP_PWR_VAL | PCI_EXP_DEVCAP_PWR_SCL);
  status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
  status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_SCL, scale);

> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
>  }

>  /**
> @@ -309,14 +309,14 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  	rockchip_pcie_set_power_limit(rockchip);
>  
>  	/* Set RC's clock architecture as common clock */
> -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
>  	status |= PCI_EXP_LNKSTA_SLC << 16;
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
>  
>  	/* Set RC's RCB to 128 */
> -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
>  	status |= PCI_EXP_LNKCTL_RCB;
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
>  
>  	/* Enable Gen1 training */
>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
> @@ -341,9 +341,9 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  		 * Enable retrain for gen2. This should be configured only after
>  		 * gen1 finished.
>  		 */
> -		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
>  		status |= PCI_EXP_LNKCTL_RL;
> -		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
>  
>  		err = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
>  					 status, PCIE_LINK_IS_GEN2(status), 20,
> @@ -380,15 +380,15 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  
>  	/* Clear L0s from RC's link cap */
>  	if (of_property_read_bool(dev->of_node, "aspm-no-l0s")) {
> -		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LINK_CAP);
> -		status &= ~PCIE_RC_CONFIG_LINK_CAP_L0S;
> -		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LINK_CAP);
> +		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
> +		status &= ~PCI_EXP_LNKCAP_ASPM_L0S;
> +		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
>  	}
>  
> -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCSR);
> -	status &= ~PCIE_RC_CONFIG_DCSR_MPS_MASK;
> -	status |= PCIE_RC_CONFIG_DCSR_MPS_256;
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
> +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
> +	status &= ~PCI_EXP_DEVCTL_PAYLOAD;
> +	status |= PCI_EXP_DEVCTL_PAYLOAD_256B;
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);

Similar problem here; PCI_EXP_DEVCTL is only 16 bits, and writing the
adjacent PCI_EXP_DEVSTA may clear RW1C bits you didn't want to clear.

Bjorn

