Return-Path: <linux-pci+bounces-29357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8954AAD4255
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 20:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6FF189E9B5
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 18:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6C824679D;
	Tue, 10 Jun 2025 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QV0k40cI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439451022;
	Tue, 10 Jun 2025 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581858; cv=none; b=aS5oBTGxMih4X7QJ8fv6lqGvk9sFgkY6/ieBdOEg01dCotMoEnyAPT9W8PAKwz57crA98vSg1wBPMB2qh5X30JQzJoCyUE7XPJsdp6qAN8KkPSAlEOggelTSrbleH/1PzAwzL9vJM+jxl9Rex+JTWZnoyJzBoMOBkji3eA/X1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581858; c=relaxed/simple;
	bh=OIqP5Jyjh/Zt9q5rwTEUSZK+gMMSTXEdZyQY0v11QIE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H1uCe9ysNZ3a8onA1suZUPHUsksaRU3BTe5I8YUJkznOAXerUtxLNfmjnrbhAJDWlp9xDbBmlBMo5ZH7qPcHkXhUWq76CbNijCjcwZzHrPlDJR4xZJ/3uFW5iVOCqptSHuf4k1CquZU1l0kVwtV5SRR9WLbL7iHv6bfSd/rZU3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QV0k40cI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F16C4CEED;
	Tue, 10 Jun 2025 18:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749581856;
	bh=OIqP5Jyjh/Zt9q5rwTEUSZK+gMMSTXEdZyQY0v11QIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QV0k40cIaAJN23wkamzSxqlueLdARxjZKy8rxwv2854Oh1h115PUGcDuu6BM3zgMJ
	 spw476G6878zTXSN0E+1aW8qP2lncOpTnABxuIp0aN+0ZMl8Y8Z/xOp+H0DOMMzQsT
	 d3pm2xfNePcu9Dzo1F/UiVapHpvnW5HHhHn0ba3MyAR9KzF69sAg1O4UKp+O3O4i45
	 iVYPQS+W4zkZNscu97+OrYDgOZHpFSfqPIPfMRh+JzNjExkDeyRy08qDdThBuyzFEx
	 G4A+nx6VAbAcu4uA2Ax+N/tZHV+VZgXuI+VG8K4O0T/gPfLYRtgtAv1or3Q1H3eJBC
	 CDPXb2EFpwl5Q==
Date: Tue, 10 Jun 2025 13:57:34 -0500
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
Message-ID: <20250610185734.GA819344@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
> 
> As the PCIe spec allows up to 100 ms time to establish a link, we'll
> allow up to 200ms before giving up.

> +static int xilinx_pci_wait_link_up(struct xilinx_pcie *pcie)
> +{
> +	u32 val;
> +
> +	/*
> +	 * PCIe r6.0, sec 6.6.1 provides 100ms timeout. Since this is FPGA
> +	 * fabric, we're more lenient and allow 200 ms for link training.
> +	 */
> +	return readl_poll_timeout(pcie->reg_base + XILINX_PCIE_REG_PSCR, val,
> +			(val & XILINX_PCIE_REG_PSCR_LNKUP), 2 * USEC_PER_MSEC,
> +			2 * PCIE_T_RRS_READY_MS * USEC_PER_MSEC);
> +}

I don't think this is what PCIE_T_RRS_READY_MS is for.  Sec 6.6.1
requires 100ms *after* the link is up before sending config requests:

  For cases where system software cannot determine that DRS is
  supported by the attached device, or by the Downstream Port above
  the attached device:

    ◦ With a Downstream Port that does not support Link speeds greater
      than 5.0 GT/s, software must wait a minimum of 100 ms following
      exit from a Conventional Reset before sending a Configuration
      Request to the device immediately below that Port.

    ◦ With a Downstream Port that supports Link speeds greater than
      5.0 GT/s, software must wait a minimum of 100 ms after Link
      training completes before sending a Configuration Request to the
      device immediately below that Port. Software can determine when
      Link training completes by polling the Data Link Layer Link
      Active bit or by setting up an associated interrupt (see §
      Section 6.7.3.3).  It is strongly recommended for software to
      use this mechanism whenever the Downstream Port supports it.

Bjorn

