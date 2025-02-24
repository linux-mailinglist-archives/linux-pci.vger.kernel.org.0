Return-Path: <linux-pci+bounces-22262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE85A42D49
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 21:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9227F3AA42E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 20:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4F5155CB3;
	Mon, 24 Feb 2025 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntCgV/Fj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1642571A8;
	Mon, 24 Feb 2025 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427383; cv=none; b=nr2lxqyZZFMh28/3wa5PtC0GHmULVJcbb1X4a2BbiPnazUmrg9+oY6Z+naCHSuOEwXqkFmyz8iuc1YbLzgPnQAEenYHLgzU4p4Nk2s+6wwN6q29BPsxBmgPz+Uf3oLEf9XaC8RvJq2OeYzL7qurACDnAOSz9ZwNz+mdauMZLckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427383; c=relaxed/simple;
	bh=+Wgzs5V7WqoWJII1yMuFCzRJM9tIcRQS6YUTom0Ieko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R5x4zLkp/Iyo+ISbWtTlv4j9jPz3KfipfzqPfFiWMFBrMBJ8a8uwN0AyvK3ew9oIMpaTn7P+TrweSXa7NLJeWsvEgAncA6M5G6yT1sNBj4ztUDP65f2h7MIOJrvQ3v8zLqi+2O7nbdK2NbU25+XtfmIvQDymCw3G7LzdboCQbng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntCgV/Fj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02257C4CED6;
	Mon, 24 Feb 2025 20:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740427383;
	bh=+Wgzs5V7WqoWJII1yMuFCzRJM9tIcRQS6YUTom0Ieko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ntCgV/FjGaG1emKU+Urx0iHvHUKwJgx4PVa5uqLWI+jgbUFZ6VTkWxjj7LaUItdNS
	 0mWZ2XFhpjzH4S9U1i0l7moB36bcdaaspVVYVQN7dYXgEgUBwSMinEXzpg5hcC4yIz
	 UJm3laZrQD1Ov0rVnjAATtdbNGJR+2sjsbZZbH/oPlhEr70ZuZsQHtqyKcBppSSoxz
	 8p3i1a9kD7TQSZUql0uRG3t+wnWXsMfvqdCOH/CnnVBo/pRNcMLVSCJhp+nGbjHUKH
	 2HhQWE840jW1pE1U4dNXbt9NHKI+tNgtKQlmlF11iq9QjaMd6j1xM80Ukz/ItEcNRF
	 p+pQAB9/8amIQ==
Date: Mon, 24 Feb 2025 14:03:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com, bharat.kumar.gogada@amd.com,
	jingoohan1@gmail.com
Subject: Re: [PATCH v14 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250224200301.GA465730@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224073117.767210-4-thippeswamy.havalige@amd.com>

On Mon, Feb 24, 2025 at 01:01:17PM +0530, Thippeswamy Havalige wrote:
> Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.
> 
> The Versal2 devices include MDB Module. The integrated block for MDB along
> with the integrated bridge can function as PCIe Root Port controller at
> Gen5 32-Gb/s operation per lane.
> 
> Bridge supports error and legacy interrupts and are handled using platform
> specific interrupt line in Versal2.

s/legacy/INTx/ (I assume that's what you mean here)

> +config PCIE_AMD_MDB
> +	bool "AMD MDB Versal2 PCIe Host controller"
> +	depends on OF || COMPILE_TEST
> +	depends on PCI && PCI_MSI
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want to enable PCIe controller support on AMD
> +	  Versal2 SoCs. The AMD MDB Versal2 PCIe controller is based on
> +	  DesignWare IP and therefore the driver re-uses the Designware core
> +	  functions to implement the driver.

s/Designware/DesignWare/

> +static void amd_mdb_intx_irq_unmask(struct irq_data *data)
> +{
> +	struct amd_mdb_pcie *pcie = irq_data_get_irq_chip_data(data);
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct dw_pcie_rp *port = &pci->pp;
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&port->lock, flags);
> +	val = FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
> +			 AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
> +
> +	/*
> +	 * Writing '1' to a bit in AMD_MDB_TLP_IR_ENABLE_MISC enables that interrupt.
> +	 * Writing '0' has no effect.

Wrap to fit in 80 columns like the rest of the file.

> +	 */
> +	pcie_write(pcie, val, AMD_MDB_TLP_IR_ENABLE_MISC);
> +	raw_spin_unlock_irqrestore(&port->lock, flags);
> +}

