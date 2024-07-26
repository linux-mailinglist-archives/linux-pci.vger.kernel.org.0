Return-Path: <linux-pci+bounces-10845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D11C893D7A8
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 19:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCBC285DC1
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0898178CFA;
	Fri, 26 Jul 2024 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM2FGtY+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4785748A;
	Fri, 26 Jul 2024 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015128; cv=none; b=glWr78EWoXHVBsRBWp0wP/IaP75PIPNn8xOf401nsmWjyMoATJb3VrgqRDx1d9Iljr4ACJzcVVu7QlExG17ow92J4K/XV4eVKWCjiGf9Ae5S257hOGNo0UWm0LwsYc7NfYwr4/ShOx5+mkByDnSEsqrr6Q5OpcpnbUsDWHp3Np8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015128; c=relaxed/simple;
	bh=/QA47YX8xEoHDU1QVSDaV+xHl2uVY/6gh46P92cajMM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rNRwQU3WWX2YemwDkyqVE4KyMTdYBtF0cm0X9NPOCNzzxFZi1EJQSJeEbBN08tfWCLWqvZ12n1zjvvwAZ6YsptZILPmHtZO4M82joPUo2Mj7oszp4uwv7yR9BxnhkdeHWw7J4A78ab54jGTWNu7biCetrqWiZ69CklaDsOQynNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM2FGtY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2D9C32782;
	Fri, 26 Jul 2024 17:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722015128;
	bh=/QA47YX8xEoHDU1QVSDaV+xHl2uVY/6gh46P92cajMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PM2FGtY+lwyxvu1sp+Aglc24MtL4kT3kHiF2KQgKCZQ1ZBIDdp5zIrPVpqiYXZWVy
	 qIgLIKTMn8canyARr/3oa4On6n/hzcxHxIpw9qi7SpCeOyMleEc0ANOSFCo10rg+bv
	 kOa1BG+4xp2zQXI7RGHRAo/8KfOquL3kZyZGBUHuA9GKPMl3DptQmuotaV1nykAqGF
	 PxAnM4OzjbZSJTZ4N6LKACEn6Q2oCT+FfwlJpD29DyxtypcumlwoZi31uNuyvJePYV
	 Tt9FSiPGR8R9xY46xxbc+DarOIhe9GQ9txx77Ua1BT/js9X6uSK/qWVIu1kWch09Tx
	 TPMU7butIYbPg==
Date: Fri, 26 Jul 2024 12:32:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, fancer.lancer@gmail.com,
	yoshihiro.shimoda.uh@renesas.com, conor.dooley@microchip.com,
	pankaj.dubey@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH 1/3] PCI: dwc: Add support for vendor specific capability
 search
Message-ID: <20240726173206.GA911626@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625093813.112555-2-shradha.t@samsung.com>

On Tue, Jun 25, 2024 at 03:08:11PM +0530, Shradha Todi wrote:
> Add vendor specific extended configuration space capability search API
> using struct dw_pcie pointer for DW controllers.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 250cf7f40b85..b74e4a97558e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -275,6 +275,22 @@ static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
>  	return 0;
>  }
>  
> +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)
> +{
> +	u16 vsec = 0;
> +	u32 header;

IIUC, any use of PCI_EXT_CAP_ID_VNDR should check dev->vendor, as
pci_find_vsec_capability() does.

You only know how "vsec" works if you also know the vendor who defined
vsec.

Do you expect DW_PCIE_RAS_DES_CAP to be present only in devices with
Vendor ID of PCI_VENDOR_ID_SYNOPSYS?

I was hoping that this was generic DesignWare functionality that might
be present in devices from other vendors that incorporated the DWC IP.
Those devices would likely have other Vendor IDs.  In that case, a
DVSEC (not VSEC) capability might be more appropriate.

> +	while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
> +					PCI_EXT_CAP_ID_VNDR))) {
> +		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
> +		if (PCI_VNDR_HEADER_ID(header) == vsec_cap)
> +			return vsec;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_find_vsec_capability);

