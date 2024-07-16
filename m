Return-Path: <linux-pci+bounces-10371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CEB9327B5
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 15:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B022853D3
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 13:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2D919ADB1;
	Tue, 16 Jul 2024 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utfsRQKU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1355B197A72;
	Tue, 16 Jul 2024 13:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137333; cv=none; b=RaZbkq0VPgBePI8rC8KTqP/i0ggsgaRJJA9eOpvYrpbQHeJTWgTLcIBjyrtlxNDK1Ggn6RMYgTcFGjnMulLojcKdOS6o9QVJvll+b5S6M9MvHOcQRJYsP64G/3ER9GO0mpoTta7wW0Vg0nCzNXK2VDZwRoQxMe0mkEUajECsWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137333; c=relaxed/simple;
	bh=eOH48dunNLTsABrLCx37z6olk5dF9XDyjImDI5wsews=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zkf/QAoPwPgpo1ynqqEc+brXqfU9IwV8pXF7ukt7S0IG70X0SCgle/G/h9/uWXlGj96+xY+J2aPaVL0hhwRkTeHwwEecp5Zo4t5qpAX0CBk2x0NwAalkfTEIZp2R59EUUUGUIUBh5lyzE7NX+w3LkCvjGC5IMzrCJF1KQrf+/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utfsRQKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D944C116B1;
	Tue, 16 Jul 2024 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721137332;
	bh=eOH48dunNLTsABrLCx37z6olk5dF9XDyjImDI5wsews=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=utfsRQKUyppf+MLIJiQNb9329FA+IDvzRZijmX6zElfA+9+MuTbJA4R3NFfj+uSqm
	 6HKw4cF8rGJFPVMkHfBeKScFCoh67hvHKs7WLIhpT+B4vjm8+e2XymYQz3Yxk/qu5s
	 e+wtShgILbTmSc5evNSy5BGcwzanUiEh2MdCQRO6vXpj3PSy84eOuvQeDTC3aS1OXJ
	 aSYE1LXEcc64ihSnKRkzN0vkN8/qPEgKuOmrX9CDtwts8YY97ouKtwW/ZW3S7mPQzY
	 Y/femgch1Z1Dv5U+5G6AK58mvBIUcN7e7Kn3LtprdUUHA41bkrMmjcWa/xLpAT2Vfj
	 6yu2jjFD/0qzg==
Date: Tue, 16 Jul 2024 07:42:10 -0600
From: Rob Herring <robh@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Mayank Rana <quic_mrana@quicinc.com>, lpieralisi@kernel.org,
	kw@linux.com, bhelgaas@google.com, jingoohan1@gmail.com,
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
Message-ID: <20240716134210.GA3534018-robh@kernel.org>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <1721067215-5832-8-git-send-email-quic_mrana@quicinc.com>
 <20240716085811.GA19348@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716085811.GA19348@willie-the-truck>

On Tue, Jul 16, 2024 at 09:58:12AM +0100, Will Deacon wrote:
> On Mon, Jul 15, 2024 at 11:13:35AM -0700, Mayank Rana wrote:
> > Add usage of Synopsys Designware PCIe controller based MSI controller to
> > support MSI functionality with ECAM compliant Synopsys Designware PCIe
> > controller. To use this functionality add device compatible string as
> > "snps,dw-pcie-ecam-msi".
> > 
> > Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> > ---
> >  drivers/pci/controller/pci-host-generic.c | 92 ++++++++++++++++++++++++++++++-
> >  1 file changed, 91 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
> > index c2c027f..457ae44 100644
> > --- a/drivers/pci/controller/pci-host-generic.c
> > +++ b/drivers/pci/controller/pci-host-generic.c
> > @@ -8,13 +8,73 @@
> >   * Author: Will Deacon <will.deacon@arm.com>
> >   */
> >  
> > -#include <linux/kernel.h>
> >  #include <linux/init.h>
> > +#include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/of_address.h>
> >  #include <linux/pci-ecam.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> >  
> > +#include "dwc/pcie-designware-msi.h"
> > +
> > +struct dw_ecam_pcie {
> > +	void __iomem *cfg;
> > +	struct dw_msi *msi;
> > +	struct pci_host_bridge *bridge;
> > +};
> > +
> > +static u32 dw_ecam_pcie_readl(void *p_data, u32 reg)
> > +{
> > +	struct dw_ecam_pcie *ecam_pcie = (struct dw_ecam_pcie *)p_data;
> > +
> > +	return readl(ecam_pcie->cfg + reg);
> > +}
> > +
> > +static void dw_ecam_pcie_writel(void *p_data, u32 reg, u32 val)
> > +{
> > +	struct dw_ecam_pcie *ecam_pcie = (struct dw_ecam_pcie *)p_data;
> > +
> > +	writel(val, ecam_pcie->cfg + reg);
> > +}
> > +
> > +static struct dw_ecam_pcie *dw_pcie_ecam_msi(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct dw_ecam_pcie *ecam_pcie;
> > +	struct dw_msi_ops *msi_ops;
> > +	u64 addr;
> > +
> > +	ecam_pcie = devm_kzalloc(dev, sizeof(*ecam_pcie), GFP_KERNEL);
> > +	if (!ecam_pcie)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	if (of_property_read_reg(dev->of_node, 0, &addr, NULL) < 0) {

Using this function on MMIO addresses is wrong. It is an untranslated 
address.

> > +		dev_err(dev, "Failed to get reg address\n");
> > +		return ERR_PTR(-ENODEV);
> > +	}
> > +
> > +	ecam_pcie->cfg = devm_ioremap(dev, addr, PAGE_SIZE);
> > +	if (ecam_pcie->cfg == NULL)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	msi_ops = devm_kzalloc(dev, sizeof(*msi_ops), GFP_KERNEL);
> > +	if (!msi_ops)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	msi_ops->readl_msi = dw_ecam_pcie_readl;
> > +	msi_ops->writel_msi = dw_ecam_pcie_writel;
> > +	msi_ops->pp = ecam_pcie;
> > +	ecam_pcie->msi = dw_pcie_msi_host_init(pdev, msi_ops, 0);
> > +	if (IS_ERR(ecam_pcie->msi)) {
> > +		dev_err(dev, "dw_pcie_msi_host_init() failed\n");
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	dw_pcie_msi_init(ecam_pcie->msi);
> > +	return ecam_pcie;
> > +}
> 
> Hmm. This looks like quite a lot of not-very-generic code to be adding
> to pci-host-generic.c. The file is now, what, 50% designware logic?

Agreed.

I would suggest you add ECAM support to the DW/QCom driver reusing some 
of the common ECAM support code.

I suppose another option would be to define a node and driver which is 
just the DW MSI controller. That might not work given the power domain 
being added (which is not very generic either).

Rob

