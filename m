Return-Path: <linux-pci+bounces-3133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1870084AFEA
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 09:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4175E1C22511
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6271412B144;
	Tue,  6 Feb 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TM+8ouuk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CDD12AAD9;
	Tue,  6 Feb 2024 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208098; cv=none; b=cV5A/sMIkEogKw6MeLQ3oYW+JrBz4ZagqdwV3E8ydpnDdNtIUoVjHXrSYMB4uzFax9GeZYz+SiBMDiAiJ2XoVjqybVeN+pNJIPY79PN895O2Rw3919UYHxT89vH0HRMVgtcwXB/WN8W58isrsF7eYYclX7PkcESkWEPMdBdI16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208098; c=relaxed/simple;
	bh=koRftp4MHR3PWopvdU9KfvvbZmwaKfHJJheC6bS279o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2GUc2ZGol5uUYEYT7W8iYVzZHv9oPceqdPDObOJuWgP8Nua9FmQ7BMQrPWlCH5DB1mcZPhvDLXYd4HnITdJFxsMMoMIliGG35RK0gSw5k7NC81LfBIG34KbfOsIOvFdHF+N2Q7vzXShIMPg46KgLyrj4ZbAve3u6+GZcF6FX/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TM+8ouuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B87C433C7;
	Tue,  6 Feb 2024 08:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707208097;
	bh=koRftp4MHR3PWopvdU9KfvvbZmwaKfHJJheC6bS279o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TM+8ouukUsUZLm3TN5OzwtVC43etkDvx/XBzBl8myT81EbZpPx3AMCEv+HP0mxN7X
	 kWwSb6Ut7d4c+M2y2bTzFo8o762ullHauFEXiEXgXm0r1+ab+NeOeVyMFWUJ+VcnBc
	 YnsPEQJqjr7bu04kV14y/askf0G9GypboFKDT+2qBOZyNPVm99WOK5W+a6wMlromea
	 B5YGgVY2mAp5S/slHe3Th4sCt/aA4CgmEySVkPPxzo7FUeZl76Y1XD/pJbabnTtQZE
	 64W4Hz5DXlQDs9Y71M9tYVOH6EG6e6n5EnKdTzB7Fc5QcxFngz+jdrB2LPEg1j23vf
	 K3dCkA5JDa/6Q==
Date: Tue, 6 Feb 2024 09:28:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v5 1/2] PCI: dwc: Fix a 64bit bug in
 dw_pcie_ep_raise_msix_irq()
Message-ID: <ZcHtmkOkvutz/DvR@x1-carbon>
References: <af59c7ad-ab93-40f7-ad4a-7ac0b14d37f5@moroto.mountain>
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

Ping on these two patches.

Patch 1/2 is a strict fix and should go in v6.8 IMO.


Kind regards,
Niklas

