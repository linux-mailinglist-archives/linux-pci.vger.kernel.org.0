Return-Path: <linux-pci+bounces-41777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 33509C73AA9
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 12:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CE87F354AD6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 11:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966363016F7;
	Thu, 20 Nov 2025 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bjrml37l"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B02882D7;
	Thu, 20 Nov 2025 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637519; cv=none; b=lyiX3uJjjUM22EUgcbPrKvQAc9MUm9tya5eQg5z53Mq9fN0zFdOrN0THB2Fd+8+hhYwxPnLobJOu/HTMZR3miDa8+QvJyJ2z8DRy25WVvPIJBdw6Rl7dEAsyP+RJ1WtaHZ0ugfHR9kyjcCqfRXnvJaGmgRQRMm4VegFObZQird0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637519; c=relaxed/simple;
	bh=HtMXzWFr8LSOo0001K25f1Gm9vTL2hQrkNqeAmBB0sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXD5johVZqHcxdhVJvImacfrCacI7zicXFLxlQARoOS1fP/RzGyvFbkhJ+uP+xeu4R5tiUKykR0i5SkvVR41vwvKHht1BB+hTv4DkLlsfyQxlDec6C5YN+MEDEAMbL7FvL7Iupzr2x0knTw25xJJaEYUVIaSC2waDiJwg1MIBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bjrml37l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D41FC4CEF1;
	Thu, 20 Nov 2025 11:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763637519;
	bh=HtMXzWFr8LSOo0001K25f1Gm9vTL2hQrkNqeAmBB0sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bjrml37lsRfKcxkkJp6165MgzZYDvZ5lZmqL8TxWrTHblou0tcmPk4odx8u1dJmMl
	 ex8Xw4JNpXX6meZy4sFA0U663rD2EBNoxivHuXWQQHDXSZ5nO8AFp2haCR/zKU8C+/
	 iesBIzJT+baHAxLMdscbFs/GaHwly3RwXp9QE1NntPV8X1AXTqWzTGxWwGfPCMVwSR
	 b9WLQkEgC1yH7GMIH/leKk4i3lbNUFyRtuRVkHb5p+KQqO6eqpCFvLRoXWMUQ0xBU+
	 OzLhYaXbZLiI3C5MajqoJbgweizU9Lr/IDoc8bAjbZTPu2TRKmwHzViM+br6m2bfBV
	 jT6CaZmZwAlxw==
Date: Thu, 20 Nov 2025 16:48:18 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Brian Norris <briannorris@chromium.org>, Frank Li <Frank.li@nxp.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Hans Zhang <hans.zhang@cixtech.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: dwc: Remove MSI/MSIX capability if iMSI-RX is
 used as MSI controller
Message-ID: <mtwcrrfrwfa2wklaqatvl2tpldfrnsxk4ywmsnalvbyqz2ss2t@3cisnif2z3dp>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
 <20251109-remove_cap-v1-3-2208f46f4dc2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251109-remove_cap-v1-3-2208f46f4dc2@oss.qualcomm.com>

+ Folks who were part of the previous discussions on this topic.

On Sun, Nov 09, 2025 at 10:59:42PM -0800, Qiang Yu wrote:
> Some platforms may not support ITS (Interrupt Translation Service) and
> MBI (Message Based Interrupt), or there are not enough available empty SPI
> lines for MBI, in which case the msi-map and msi-parent property will not
> be provided in device tree node. For those cases, the DWC PCIe driver
> defaults to using the iMSI-RX module as MSI controller. However, due to
> DWC IP design, iMSI-RX cannot generate MSI interrupts for Root Ports even
> when MSI is properly configured and supported as iMSI-RX will only monitor
> and intercept incoming MSI TLPs from PCIe link, but the memory write
> generated by Root Port are internal system bus transactions instead of
> PCIe TLPs, so they are ignored.
> 
> This leads to interrupts such as PME, AER from the Root Port not received
> on the host and the users have to resort to workarounds such as passing
> "pcie_pme=nomsi" cmdline parameter.
> 
> To ensure reliable interrupt handling, remove MSI and MSI-X capabilities
> from Root Ports when using iMSI-RX as MSI controller, which is indicated
> by has_msi_ctrl == true. This forces a fallback to INTx interrupts,
> eliminating the need for manual kernel command line workarounds.
> 
> With this behavior:
> - Platforms with ITS/MBI support use ITS/MBI MSI for interrupts from all
>   components.
> - Platforms without ITS/MBI support fall back to INTx for Root Ports and
>   use iMSI-RX for other PCI devices.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c4812e2fd96047a49944574df1e6f..3724aa7f9b356bfba33a6515e2c62a3170aef1e9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1083,6 +1083,16 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
> +	/*
> +	 * If iMSI-RX module is used as the MSI controller, remove MSI and
> +	 * MSI-X capabilities from PCIe Root Ports to ensure fallback to INTx
> +	 * interrupt handling.
> +	 */
> +	if (pp->has_msi_ctrl) {
> +		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSI);
> +		dw_pcie_remove_capability(pci, PCI_CAP_ID_MSIX);
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

