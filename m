Return-Path: <linux-pci+bounces-10359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCD1932253
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 10:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5BB1C20A40
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A2C1448ED;
	Tue, 16 Jul 2024 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYaCedXe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E0841A8E;
	Tue, 16 Jul 2024 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120300; cv=none; b=Abz0S/fv8MCscoZexT+fGo1d9x22CLEG4SLqiEsWeodv1eenqYvqM2zdFi7aFtFnrjYkXAzWZ1/pfQO4c2wBI3K7mUyKTuq7RL7f7QAmaZz263DJILC7aIsSEqujxUWwF5DON+9qryjSfZYq5MX7hz8Ki4+v+SxSQ5y3kNXqFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120300; c=relaxed/simple;
	bh=j0EqPXGuG0quxNlrfhnIBzFiLmPDYm3mbVK7absS/vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na1hpIlMhSOXbeMRaZuAhOMRHdPpJxfCnFiHdWZuc+7G6xgpNsZCeHQJ8lnjnvlx84b7P4RujxOanopGKGtAveRQNORVHBJRevBO6KfkvF0jFRa5oWhotuGYbVOlFNtmeAr4kiaDnw0gOpfjqZgoOpNhMheuim2xGTh0orBqU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYaCedXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8136CC116B1;
	Tue, 16 Jul 2024 08:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721120300;
	bh=j0EqPXGuG0quxNlrfhnIBzFiLmPDYm3mbVK7absS/vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sYaCedXe89NSHfvs6/uFxg5inoi6tDWSof8byXQ44WD/VT+Un5E7E2Z2ga0jyKEBR
	 HV5e+u4qTmk+xrrsxE1iaG3/4fRV5htwO0slIPXP4TFobSMJAvMsOm8jEa9cjH4ZoG
	 ICZKqOZRZBvtZue0h1ANxQG8RojmiIFUaJ0Ppn6Is097DHtavZtU4U2fmPnpvNMQEw
	 0KZb6OjvH4/6a9C1v6hxJ6e+L5ahVblxqElAv/fgarRH09Nw28Z4KVbRZz8XMXZe4l
	 V37ADzPSgfdKIvo7Ouy/1ChP3plGbRoow5HNJCS2tOJnfoJEgtykR1gGHZgj61xCNS
	 33/A1aoT1L40g==
Date: Tue, 16 Jul 2024 09:58:12 +0100
From: Will Deacon <will@kernel.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
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
Subject: Re: [PATCH V2 7/7] PCI: host-generic: Add dwc PCIe controller based
 MSI controller usage
Message-ID: <20240716085811.GA19348@willie-the-truck>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <1721067215-5832-8-git-send-email-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721067215-5832-8-git-send-email-quic_mrana@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jul 15, 2024 at 11:13:35AM -0700, Mayank Rana wrote:
> Add usage of Synopsys Designware PCIe controller based MSI controller to
> support MSI functionality with ECAM compliant Synopsys Designware PCIe
> controller. To use this functionality add device compatible string as
> "snps,dw-pcie-ecam-msi".
> 
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> ---
>  drivers/pci/controller/pci-host-generic.c | 92 ++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
> index c2c027f..457ae44 100644
> --- a/drivers/pci/controller/pci-host-generic.c
> +++ b/drivers/pci/controller/pci-host-generic.c
> @@ -8,13 +8,73 @@
>   * Author: Will Deacon <will.deacon@arm.com>
>   */
>  
> -#include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_address.h>
>  #include <linux/pci-ecam.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  
> +#include "dwc/pcie-designware-msi.h"
> +
> +struct dw_ecam_pcie {
> +	void __iomem *cfg;
> +	struct dw_msi *msi;
> +	struct pci_host_bridge *bridge;
> +};
> +
> +static u32 dw_ecam_pcie_readl(void *p_data, u32 reg)
> +{
> +	struct dw_ecam_pcie *ecam_pcie = (struct dw_ecam_pcie *)p_data;
> +
> +	return readl(ecam_pcie->cfg + reg);
> +}
> +
> +static void dw_ecam_pcie_writel(void *p_data, u32 reg, u32 val)
> +{
> +	struct dw_ecam_pcie *ecam_pcie = (struct dw_ecam_pcie *)p_data;
> +
> +	writel(val, ecam_pcie->cfg + reg);
> +}
> +
> +static struct dw_ecam_pcie *dw_pcie_ecam_msi(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dw_ecam_pcie *ecam_pcie;
> +	struct dw_msi_ops *msi_ops;
> +	u64 addr;
> +
> +	ecam_pcie = devm_kzalloc(dev, sizeof(*ecam_pcie), GFP_KERNEL);
> +	if (!ecam_pcie)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (of_property_read_reg(dev->of_node, 0, &addr, NULL) < 0) {
> +		dev_err(dev, "Failed to get reg address\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	ecam_pcie->cfg = devm_ioremap(dev, addr, PAGE_SIZE);
> +	if (ecam_pcie->cfg == NULL)
> +		return ERR_PTR(-ENOMEM);
> +
> +	msi_ops = devm_kzalloc(dev, sizeof(*msi_ops), GFP_KERNEL);
> +	if (!msi_ops)
> +		return ERR_PTR(-ENOMEM);
> +
> +	msi_ops->readl_msi = dw_ecam_pcie_readl;
> +	msi_ops->writel_msi = dw_ecam_pcie_writel;
> +	msi_ops->pp = ecam_pcie;
> +	ecam_pcie->msi = dw_pcie_msi_host_init(pdev, msi_ops, 0);
> +	if (IS_ERR(ecam_pcie->msi)) {
> +		dev_err(dev, "dw_pcie_msi_host_init() failed\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	dw_pcie_msi_init(ecam_pcie->msi);
> +	return ecam_pcie;
> +}

Hmm. This looks like quite a lot of not-very-generic code to be adding
to pci-host-generic.c. The file is now, what, 50% designware logic?

Will

