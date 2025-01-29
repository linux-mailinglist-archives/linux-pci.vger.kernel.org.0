Return-Path: <linux-pci+bounces-20564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706C3A226E5
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 00:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 309847A3384
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 23:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFCD1B87C9;
	Wed, 29 Jan 2025 23:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHwWQvo0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADD442A92;
	Wed, 29 Jan 2025 23:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738193032; cv=none; b=WrpWyFKEQ1rb3K4INTchzisrP48kgpc2pb2RI15ETa4eU8BeETBr91ZyINPxrD5TmfZ/2nKG4Wa9kld2pbN5gtYZsn6Kf1DBwnK2E6pKCZp7e9n1wI7VNtZ07wIq3A+AxWMtLIprYupKXTTOu3CN0DoNBDAeKwRnJRbn5NLpFsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738193032; c=relaxed/simple;
	bh=7V2/4xR4xd3iiCg+7a6U3WGS/XW+gb5GEdujfPwyMsE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AWQ0Zsw+S6V0ENXToq0tGM19tQ0VthrQQnHPGy5BeKznKKIqNdRQQbE74zhBUHPIKYPpAI2nAKQW4BPqVQ+8sYNql3Jv41KfgxnH8yLU719/DtQtBFBTj+oz2GKGQVNlUjpqMFO887jksFevnUWGvtloJAH6D41BKyXzlzpMfn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHwWQvo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FAEC4CED1;
	Wed, 29 Jan 2025 23:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738193032;
	bh=7V2/4xR4xd3iiCg+7a6U3WGS/XW+gb5GEdujfPwyMsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OHwWQvo0L1AayY0hDP0TCxcnrhzQgoo4lUcakGOUtk7HSj8GcTReW/DXtmbtiyZ+x
	 g/LimFopBaPAJukTFOzKJ+S2RpGZQcCvhKzrqQyzP59grcJ0z/+LbpNslG4/aobG7w
	 nMSqbnZIlVb9Yv0VmiUKUYXhJZds3rXoku7vDqfmqNpHQYIko4IpdBdPKKd6ZSJH3i
	 Pu5G32ejaTjVWIYrx9A7yAQNhYVCKoyOYf8ovcjFfdfPsNZq68+YXw7RX9L/4UW0+s
	 eshqKZxfNutl6yIy+86UkbRw0GoHslBUoDhg8dOFs4EiOfawNvSZPs1zlo1WmPMEww
	 FS1fRYPlwQ5Pw==
Date: Wed, 29 Jan 2025 17:23:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v9 2/7] PCI: dwc: Rename cpu_addr to parent_bus_addr for
 ATU configuration
Message-ID: <20250129232350.GA527937@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-pci_fixup_addr-v9-2-3c4bb506f665@nxp.com>

On Tue, Jan 28, 2025 at 05:07:35PM -0500, Frank Li wrote:
> Rename `cpu_addr` to `parent_bus_addr` in the DesignWare ATU configuration.
> The ATU translates parent bus addresses to PCI addresses, which are often
> the same as CPU addresses but can differ in systems where the bus fabric
> translates addresses before passing them to the PCIe controller. This
> renaming clarifies the purpose and avoids confusion.

Based on dw_pcie_ep_inbound_atu() below, I guess the ATU can also
translate PCI addresses from incoming DMA to parent bus addresses?

It's worth noting here that this patch only renames the member, and
IIUC, parent_bus_addr still incorrectly contains CPU physical
addresses.

> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -128,7 +128,7 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  }
>  
>  static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> -				  dma_addr_t cpu_addr, enum pci_barno bar,
> +				  dma_addr_t parent_bus_addr, enum pci_barno bar,
>  				  size_t size)

