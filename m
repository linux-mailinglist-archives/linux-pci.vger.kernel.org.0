Return-Path: <linux-pci+bounces-10301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098C3931A70
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5961C2126E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E97B6E611;
	Mon, 15 Jul 2024 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EtMGzslX"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708918B1A;
	Mon, 15 Jul 2024 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721068817; cv=none; b=BHJ4Jd9ELAQPDT6jz5qzvbKDLhU+uymDyC6tIz90UjomJkuBoTPnC+WctTjTmpOeT4Ei2LHmZBUvPclzYdpDSHSjbezNXt06Y1FooxppEH7UP6z0y0fWoYSk8NMhkT8fhK0c726FEp8OQvXX2zOAJkBUHdfGQHkmfjSDuSWUOOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721068817; c=relaxed/simple;
	bh=kBr8jqrEzBED1CY+1Rm9Y5bQSHF8qw9SY4LIEgKS1cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMf0x0GOkVtjNHorgBi0JBsULadjl7sYpHcl4fcMwWIzm0SN25TeYUiDgW1QUfp+0aygGWgEGsbfAF25I7PVHtknnUMqSjej9GDEk5s4LP812BGR2E7R0RfFq4pxSxsV1KRUPRAgCc1MEOfISfVSaiySVkR13RrAmczwvRMgfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EtMGzslX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=69bjE+3+DB3QIHy12aUSn9wePdmYfjaG31ISmFwALIE=; b=EtMGzslXmq6z182xeF+y8XNQUp
	GXtwyNrN99cyrmfhCz9j6JRX42cPEiAU7YikohYuTNhQU6AL8zHgcAQMyaAEWyYhYwHgxwNd49YJn
	tWqgJKnYX+G3/bBjn7oOOag9lz00loUATH082VgCPEwXuOGnIWP81UggJC7o0+6ux7kE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sTQby-002aid-Rq; Mon, 15 Jul 2024 20:39:46 +0200
Date: Mon, 15 Jul 2024 20:39:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: will@kernel.org, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org, cassel@kernel.org,
	yoshihiro.shimoda.uh@renesas.com, s-vadapalli@ti.com,
	u.kleine-koenig@pengutronix.de, dlemoal@kernel.org,
	amishin@t-argos.ru, thierry.reding@gmail.com, jonathanh@nvidia.com,
	Frank.Li@nxp.com, ilpo.jarvinen@linux.intel.com, vidyas@nvidia.com,
	marek.vasut+renesas@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	quic_ramkri@quicinc.com, quic_nkela@quicinc.com,
	quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
	quic_nitegupt@quicinc.com
Subject: Re: [PATCH V2 3/7] PCI: dwc: Add pcie-designware-msi driver related
 Kconfig option
Message-ID: <c6e0a6db-588b-4838-a134-5ce51b1cebea@lunn.ch>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <1721067215-5832-4-git-send-email-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721067215-5832-4-git-send-email-quic_mrana@quicinc.com>

On Mon, Jul 15, 2024 at 11:13:31AM -0700, Mayank Rana wrote:
> PCIe designware MSI driver (pcie-designware-msi.c) shall be used without
> enabling pcie-designware core drivers (e.g. usage with ECAM driver). Hence
> add Kconfig option to enable pcie-designware-msi driver as separate module.
> 
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>  drivers/pci/controller/dwc/Kconfig               |  8 ++++++++
>  drivers/pci/controller/dwc/Makefile              |  3 ++-
>  drivers/pci/controller/dwc/pcie-designware-msi.h | 14 ++++++++++++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 8afacc9..a4c8920 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -6,8 +6,16 @@ menu "DesignWare-based PCIe controllers"
>  config PCIE_DW
>  	bool
>  
> +config PCIE_DW_MSI
> +	bool "DWC PCIe based MSI controller"
> +	depends on PCI_MSI
> +	help
> +	  Say Y here to enable DWC PCIe based MSI controller to support
> +	  MSI functionality.
> +

Nit picking, but in the commit message you say separate module. But it
is a bool, not a tristate, so it cannot be built as a module.

	Andrew

