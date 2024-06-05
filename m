Return-Path: <linux-pci+bounces-8288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFC28FC4DC
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 09:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A19D2853C2
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 07:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7E718FDAD;
	Wed,  5 Jun 2024 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNFgGTcr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9A18FDA9;
	Wed,  5 Jun 2024 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573414; cv=none; b=FsoDX6NWEVMMdn2PmXv409x/vuhwbepkkHVdKdO8nDf1FvZ4bcfNLBXhhsYHds7R9aeHUdDrUGk4iugXf1+xVMz56e2/T8wWa9Dd1EKiKh1Bu5W9nCRzGTdLmRbR8wInx2D0d80ZGGf9YghESaYElA4IPkt18slmf3G1UOcle5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573414; c=relaxed/simple;
	bh=DAZjORhNTyDM4EnKUl4YaexhknoTngFwmMKXdQGWjUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pkb5ZogUa/akqv8LRnhJHIzw+ooMQZYYMB6gpge+PmTT7W4CEdQW0LkuZbZxlXlkB15Nq/kVpGOAOgfSeY5L5heVqpZDTJfxngxh+AzOwkldI0B2x7iAmJ+CEGk5kQ22tF6cs6ypvKwoyw04nbbcArcDpznrpA1C+LEgtDbPomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNFgGTcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC8EC3277B;
	Wed,  5 Jun 2024 07:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717573414;
	bh=DAZjORhNTyDM4EnKUl4YaexhknoTngFwmMKXdQGWjUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNFgGTcrCys6dYW/Mu0z8LFdpJ7YBiH21gh/nHYiWaLqHTED66BiHrIuML0NYxWwM
	 8pTBJWU4v2gDA2rr7waw9zFuQBcu7jNHnJK8cZuzEbmV4JSagxJyBl2aMqtTWsBRKT
	 Wg8Sygvh8kIem10p9xgTPbZb2qpLIRArNXJ/0mbDNoVDfVoZFNuq+dV+P2t4x68j+x
	 Y4GaP3pAupGsN+rGRfoor4LlxUpQxLPGvbFCCcufrtXS7BJMHGI9iuwskAtp/FOBQ3
	 x9oiOZkGDTCJx8Yp/4TwTgFgx+EYRsDHMYj3aYl0aRuptPjf30x9ajInTDAZPBCKD7
	 sV+ZMyR40nVxA==
Date: Wed, 5 Jun 2024 13:13:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 08/13] PCI: dw-rockchip: Add rockchip_pcie_get_ltssm()
 helper
Message-ID: <20240605074324.GI5085@thinkpad>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-8-3dc00fe21a78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529-rockchip-pcie-ep-v1-v4-8-3dc00fe21a78@kernel.org>

On Wed, May 29, 2024 at 10:29:02AM +0200, Niklas Cassel wrote:
> Add a rockchip_pcie_ltssm() helper function that reads the LTSSM status.
> This helper will be used in additional places in follow-up commits.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 3dfed08ef456..1380e3a5284b 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -143,6 +143,11 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
>  	return 0;
>  }
>  
> +static u32 rockchip_pcie_get_ltssm(struct rockchip_pcie *rockchip)
> +{
> +	return rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
> +}
> +
>  static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
>  {
>  	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
> @@ -152,7 +157,7 @@ static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
>  static int rockchip_pcie_link_up(struct dw_pcie *pci)
>  {
>  	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> -	u32 val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
> +	u32 val = rockchip_pcie_get_ltssm(rockchip);
>  
>  	if ((val & PCIE_LINKUP) == PCIE_LINKUP &&
>  	    (val & PCIE_LTSSM_STATUS_MASK) == PCIE_L0S_ENTRY)
> 
> -- 
> 2.45.1
> 

-- 
மணிவண்ணன் சதாசிவம்

