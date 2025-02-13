Return-Path: <linux-pci+bounces-21343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A087DA3406D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 14:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070471886026
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE781F462A;
	Thu, 13 Feb 2025 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoMJvc9J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4778F23A98F
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453610; cv=none; b=db3HoeYE4qLk/HV0f0es+m0CqK757uEsTDhqENfevjhEZxJw8O2rIjM/i1XmEdGpSKkvxkHm2ZX46R8JVCcI0bnGv6v9BLHr6kAN5vpiQcGwWs/hNpsAIEk8jiP1g9IJzN0YH9iWfvft2lSBm75Qs7+/QKynoDxbMGCmqsA647Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453610; c=relaxed/simple;
	bh=kgYYi5gE9XFIXtE+llwT6I0YU7Locvddc9D9m9nyYkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5iOS47+chNkAVDyfwOoGUtgpKX8TSzl7lW9VXCb8s+/6UZz8i8bq8MA6TCTY26oBGGJl3ZBxDxHcddNLAH1xI9XQBGJplDlrGwavAkq1/rAL53cxFirHrfnSbskZvbkP9NhMHp1H+pznKVXqx0s4E0pG00oKLgRXiUJMGQxag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoMJvc9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1373C4CED1;
	Thu, 13 Feb 2025 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739453609;
	bh=kgYYi5gE9XFIXtE+llwT6I0YU7Locvddc9D9m9nyYkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EoMJvc9JuIEYgOOkNrD41jfgfLWkX2fVT+syW5KYDYOaw8ZYAsngR5ReQ6HDZRttl
	 iwJokiaisOLsxlbHPaXmx2zxtnF7yRnFYgYUpS9QxliBfm98Av8OgUSIR24Xh6yo8y
	 KOPts531v597Wc7amfy1I+NZQBX0zcizlSmcDDuJrgMplriivbduXrqeUNCHfDdHuZ
	 ylShMUAeSW9FOnwPVZbPPPATHw3rhWKvI1WfL+By6JPqIbvZ/6F0CGxL0SBjt+6qpK
	 kEi+iPlsIY0mLzH1wCGJ7B38YsZKA+LXjxM02DpGPdCK0PGXVp9AHKPPpvqPN46jvt
	 gjXdKeO6qyQEg==
Date: Thu, 13 Feb 2025 14:33:24 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 0/7] PCI: endpoint: Allow EPF drivers to configure the
 size of Resizable BARs
Message-ID: <Z630pORpGSqwcYxo@ryzen>
References: <20250131182949.465530-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131182949.465530-9-cassel@kernel.org>

On Fri, Jan 31, 2025 at 07:29:49PM +0100, Niklas Cassel wrote:
> The PCI endpoint framework currently does not support resizable BARs.
> 
> Add a new BAR type BAR_RESIZABLE, so that EPC drivers can support resizable
> BARs properly.
> 
> For a resizable BAR, we will only allow a single supported size.
> This is by design, as we do not need/want the complexity of the host side
> resizing our resizable BAR.
> 
> In the DWC driver specifically, the DWC driver currently handles resizable
> BARs using an ugly hack where a resizable BAR is force set to a fixed size
> BAR with 1 MB size if detected. This is bogus, as a resizable BAR can be
> configured to sizes other than 1 MB.
> 
> With these changes, an EPF driver will be able to call pci_epc_set_bar()
> to configure a resizable BAR to an arbitrary size, just like for
> BAR_PROGRAMMABLE. Thus, DWC based EPF drivers will no longer be forced to
> a bogus 1 MB forced size for resizable BARs.
> 
> 
> Tested/verified on a Radxa Rock 5b (rk3588) by:
> -Modifying pci-epf-test.c to request BAR sizes that are larger than 1 MB:
>  -static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
>  +static size_t bar_size[] = { SZ_1M, SZ_1M, SZ_2M, SZ_2M, SZ_4M, SZ_4M };
>  (Make sure to set CONFIG_CMA_ALIGNMENT=10 such that dma_alloc_coherent()
>   calls are aligned even for allocations larger than 1 MB.)
> -Rebooting the host to make sure that the DWC EP driver configures the BARs
>  correctly after receiving a link down event.
> -Modifying EPC features to configure a BAR as 64-bit, to make sure that we
>  handle 64-bit BARs correctly.
> -Modifying the DWC EP driver to set a size larger than 2 GB, to make sure
>  we handle BAR sizes larger than 2 GB (for 64-bit BARs) correctly.
> -Running the consecutive BAR test in pci_endpoint_test.c to make sure that
>  the address translation works correctly.
> 
> 
> Changes since V3:
> -Picked up tags.
> -Addressed comments from Mani.
> 
> 
> Kind regards,
> Niklas
> 
> Niklas Cassel (7):
>   PCI: endpoint: Allow EPF drivers to configure the size of Resizable
>     BARs
>   PCI: endpoint: Add pci_epc_bar_size_to_rebar_cap()
>   PCI: dwc: ep: Move dw_pcie_ep_find_ext_capability()
>   PCI: dwc: endpoint: Allow EPF drivers to configure the size of
>     Resizable BARs
>   PCI: keystone: Describe Resizable BARs as Resizable BARs
>   PCI: keystone: Specify correct alignment requirement
>   PCI: dw-rockchip: Describe Resizable BARs as Resizable BARs
> 
>  drivers/pci/controller/dwc/pci-keystone.c     |   6 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   | 218 +++++++++++++++---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c |  22 +-
>  drivers/pci/endpoint/pci-epc-core.c           |  31 +++
>  drivers/pci/endpoint/pci-epf-core.c           |   4 +
>  include/linux/pci-epc.h                       |   5 +
>  6 files changed, 239 insertions(+), 47 deletions(-)
> 
> -- 
> 2.48.1
> 

Considering that all patches are have at least one R-b tag,
any chance this series could get picked up?


Kind regards,
Niklas

