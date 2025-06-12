Return-Path: <linux-pci+bounces-29555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86F0AD7464
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 16:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67AF13AFB7E
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B31772616;
	Thu, 12 Jun 2025 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUqjF7ON"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F71B808;
	Thu, 12 Jun 2025 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739578; cv=none; b=IT3US6dIYhYiWRyofrh8LJHIgrCL2QMaLfN//+QrQYmexAA+nHnhQ1aodsQCI0WDCfXzEpotnmyva1s2xTVR5Ebrc0MZwgWiujtccrGUjYE9wlqtGUO1X2livLyFNr0uDQGzCaB7IhoMuvkehPdhFqra+vg5XziZnRwtcUBh02Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739578; c=relaxed/simple;
	bh=ktOIi/BfUKsUMRQMoHe23J8/rEqdQAIOh2BtMJa3q38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVF3MrnkjG3UB5aTYc048TREoE/Bqitc+BFe9r7dsdO2R9Xvf//5oRycnjYB/y0y9l1VI4sIvzxcMaSlcYUTCLZjKia38j0F3ATxKesWAHAIeS76RqJ4bbYnqSe014lZ3xl6OYdo14yYygjbrxVpNCuAeAb6bupTx+7k+LEmjwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUqjF7ON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE90C4CEEA;
	Thu, 12 Jun 2025 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749739574;
	bh=ktOIi/BfUKsUMRQMoHe23J8/rEqdQAIOh2BtMJa3q38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FUqjF7ONFa/8MEpHuAC0lNeK4nPttPf0Hz1juF4yxJk6qw8h112kn2pLn1gxQU2GR
	 xCfBIrIgpwpX6PMUvf1+rkx53ho53XJD7FhpIpSg6XY583benADFDIXPTpvBIeCOx/
	 sMkLO/n4wtblZxvr0nsVsALTLT9VlmquhajDWK4k4cCeuh5oK7ZMeTxTEk/TQn2kGV
	 3urV9802dpwb86AfhMelys5oT6bfUdNxba0TbtaJ//L1qsgnPseh7br0VCwoVkk6NU
	 fI3ekhZupD9ExVKASnX2ixaxELjUVMbNqc5VPV1WfHXySfMmM735xE4LOD2duATKcy
	 pQg6+NcnmoIbg==
Date: Thu, 12 Jun 2025 20:16:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v11 10/11] PCI: dwc: Print warning message when
 cpu_addr_fixup() exists
Message-ID: <v77jy5tldwuasjzqirlwx45zigt6bpnaiz67e4w7r2lxqrdsek@5qzzobothf5r>
References: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
 <20250313-pci_fixup_addr-v11-10-01d2313502ab@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313-pci_fixup_addr-v11-10-01d2313502ab@nxp.com>

On Thu, Mar 13, 2025 at 11:38:46AM -0400, Frank Li wrote:
> If the parent 'ranges' property in DT correctly describes the address
> translation, the cpu_addr_fixup() callback is not needed. Print a warning
> message to inform users to correct their DTB files and prepare to remove
> cpu_addr_fixup().
> 

This patch seem to have dropped, but I do see a value in printing the warning to
encourage developers/users to fix the DTB in some way. Since we fixed the driver
to parse the DT 'ranges' properly, the presence of cpu_addr_fixup() callback
indicates that the translation is not properly described in DT. So DT has to be
fixed.

Bjorn, thoughts?

- Mani

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v10 to v11
> - change to dev_warn()
> - Bjorn: this is opitional patches to encourage user fix their dtb file.
> 
> change from v9 to v10
> - new patch
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 8b546131b97f6..d4dc8bf06d4c1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1125,6 +1125,8 @@ int dw_pcie_init_parent_bus_offset(struct dw_pcie *pci, const char *reg_name,
>  
>  	fixup = pci->ops->cpu_addr_fixup;
>  	if (fixup) {
> +		dev_warn(pci->dev, "cpu_addr_fixup() usage detected. Please fix your DTB!\n");
> +
>  		fixup_addr = fixup(pci, cpu_phy_addr);
>  		if (reg_addr == fixup_addr) {
>  			dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

