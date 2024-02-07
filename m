Return-Path: <linux-pci+bounces-3219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5670C84D206
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 20:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90081F254FC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 19:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D1385286;
	Wed,  7 Feb 2024 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3ymfeSd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663EE82D73;
	Wed,  7 Feb 2024 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333052; cv=none; b=R6rsRnmeCD0TDQlZoEB5WhoQiyYDaKEKi79IsxXz5qj0r6UGVXlI6+FSheh7zetyyQz7ZTo0MlBinVOYwHNMDw9xwWO7EQ6oI7qjs3t4q9zCgvDa286x6+Z1uo8JPQyz4bNfXHoiu6UP6xP8EbXOGxZQTXiXFP9/9+b7mrY2Jag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333052; c=relaxed/simple;
	bh=OCnvHMbEgGstPQ+6RSJ1FJWLuiwrN1X56YrscIQU1ps=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=I61fqL9beUI2jb1iYEN4fBfq3v7fnCuvY243JejRFfl/1lObttI/67Un0Nl7OvDsOuVLkiPTe/uAL5xM+mihMKA62H99tD0QRAIeexWvvKq+iNAPZGriED+vKqkgORvFmX45IIfZx7QFTyHAulbhr2arc3wl7sYBhzBeWCVTFC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3ymfeSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD0FC433F1;
	Wed,  7 Feb 2024 19:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707333051;
	bh=OCnvHMbEgGstPQ+6RSJ1FJWLuiwrN1X56YrscIQU1ps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k3ymfeSdbhT2bqIwZJS9xY+5EqNd0Bcsp4td7PM/2zlnSyoEqO6cpotVx0zrxuUNC
	 0BaCBHHx/vV9Z/gbSlX5ZtlEZ01yzL0GgyHimwHldvTzywMRpsS1g+rCVyEeGVPjGi
	 V6XxpTqHO+dZk803Wb91hawO+t7PUEyoly+kALzl79DrE+Az5fB9+/pYT3rLkUfjYV
	 H8i0oRKW4YDLZhRDdhr/xv/PiY29kdcqa3+4fA5VlBNtMwc5awStF+Wtn9kpQBMeju
	 nDiCUc+f2pf8zB/+Ce1IaU/9XnzAWhmpKFiO+MuCIuxYTvCgSWVe2yFKtoaSF/uN9E
	 Re7Junm/vc3WA==
Date: Wed, 7 Feb 2024 13:10:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v5 1/2] PCI: dwc: Fix a 64bit bug in
 dw_pcie_ep_raise_msix_irq()
Message-ID: <20240207191050.GA912556@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af59c7ad-ab93-40f7-ad4a-7ac0b14d37f5@moroto.mountain>

On Fri, Jan 26, 2024 at 11:40:37AM +0300, Dan Carpenter wrote:
> The "msg_addr" variable is u64.  However, the "aligned_offset" is an
> unsigned int.  This means that when the code does:
> 
>         msg_addr &= ~aligned_offset;
> 
> it will unintentionally zero out the high 32 bits.  Use ALIGN_DOWN()
> to do the alignment instead.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2217fffcd63f ("PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I applied both of these to for-linus for v6.8, thanks!

> ---
> v5: Add the #include.
> v4: Add stable and r-b from Niklas
> v3: Use ALIGN_DOWN()
> v2: fix typo in commit message
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 5befed2dc02b..d6b66597101e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -6,6 +6,7 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>  
> +#include <linux/align.h>
>  #include <linux/bitfield.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -551,7 +552,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	}
>  
>  	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> -	msg_addr &= ~aligned_offset;
> +	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->window.page_size);
>  	if (ret)
> -- 
> 2.43.0
> 

