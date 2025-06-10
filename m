Return-Path: <linux-pci+bounces-29363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B88AD42B2
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 21:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1223A0682
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 19:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487842620C8;
	Tue, 10 Jun 2025 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbkEg9dt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D926159D;
	Tue, 10 Jun 2025 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749582775; cv=none; b=SeIh8Qt1JWywNlj6yo2BxRrmCSqRzr/0z8TyPvHODOAEcPUTcBDKAYXjnF71kx1QXc2Q2/oGKwo2K2eXt8pM2fMFk1YHBBxAFgVEnRSc1KxUJDGGveotEFkDnc9HyTv2t71p6WmOKG4iZdt3gGzOckram4ongsMnPHuBF2oLGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749582775; c=relaxed/simple;
	bh=MkL+yCkTlVRPMl3I1W8UosEvrkNCnEgFMpcNSMX4iYk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k+umv7SKcmiW9nxGPkUsTqb/S4zZNM4zXDnbpXXPK1SstBzX4oh9rIK5lcuB7OV5oKGRCllAGQR81HLoNrzQRV4gyxerGDTAwhtdgSjSXSXWHsqdLhkR7LAQEf34KhCLShTEXfxizcEcVe7BORBbXfBNft55ikqBH0HaH/SXa7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbkEg9dt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D65FC4CEED;
	Tue, 10 Jun 2025 19:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749582774;
	bh=MkL+yCkTlVRPMl3I1W8UosEvrkNCnEgFMpcNSMX4iYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MbkEg9dthwa2baq75Dx0k/Ao34Hg+0Lps/kfKNtnUino7oCQ0MF1drypvKffIZQu0
	 uiRTQ9av8P0Hx2NYRk3UAFk8i62vKtbgPUJa7yCPvQbqnfGOYyTG2vIBX0BgVgHKph
	 GtUEbXPecCetvmHALutL7aVaIEkDF0Ej+3DrO6t3N/FPG+aVWHYuLxVmpX0+A2IIHb
	 8JYsSfKW7lTkARyKIW1S5LJaa58QcMHMCg+T7XPSbX7LqdW+1KSvgc7viiC7Ziu9P9
	 ycSnaZp8yG0WDbXsyHd2xwJJ9Ym9oxWnnXPtidAt9naJL59hbR5CDPKeC7yaGo2aD7
	 x+8PJRxiQTbwg==
Date: Tue, 10 Jun 2025 14:12:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: xilinx: Wait for link-up status during
 initialization
Message-ID: <20250610191253.GA820218@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610143919.393168-1-mike.looijmans@topic.nl>

On Tue, Jun 10, 2025 at 04:39:03PM +0200, Mike Looijmans wrote:
> When the driver loads, the transceiver and endpoint may still be setting
> up a link. Wait for that to complete before continuing. This fixes that
> the PCIe core does not work when loading the PL bitstream from
> userspace. Existing reference designs worked because the endpoint and
> PL were initialized by a bootloader. If the endpoint power and/or reset
> is supplied by the kernel, or if the PL is programmed from within the
> kernel, the link won't be up yet and the driver just has to wait for
> link training to finish.

> +static int xilinx_pci_wait_link_up(struct xilinx_pcie *pcie)
> +{
> +	u32 val;
> +
> +	/*
> +	 * PCIe r6.0, sec 6.6.1 provides 100ms timeout. Since this is FPGA
> +	 * fabric, we're more lenient and allow 200 ms for link training.

Does this FPGA fabric refer to the Root Port or to the Endpoint?  We
should know whether this issue is common to all xilinx Root Ports or
specific to certain Endpoints.

I assume that even if we wait for the link to come up and then wait
PCIE_T_RRS_READY_MS before sending config requests, this Endpoint is
still not ready to return an RRS response?  I'm looking at this text
from sec 6.6.1:

  Unless Readiness Notifications mechanisms are used, the Root Complex
  and/or system software must allow at least 1.0 s following exit from
  a Conventional Reset of a device, before determining that the device
  is broken if it fails to return a Successful Completion status for a
  valid Configuration Request. This period is independent of how
  quickly Link training completes.

  Note: This delay is analogous to the Trhfa parameter specified for
  PCI/PCI-X, and is intended to allow an adequate amount of time for
  devices which require self initialization.

It seems like the PCI core RRS handling should already account for
this 1.0 s period.

> +	 */
> +	return readl_poll_timeout(pcie->reg_base + XILINX_PCIE_REG_PSCR, val,
> +			(val & XILINX_PCIE_REG_PSCR_LNKUP), 2 * USEC_PER_MSEC,
> +			2 * PCIE_T_RRS_READY_MS * USEC_PER_MSEC);
> +}

