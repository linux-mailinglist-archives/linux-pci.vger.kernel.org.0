Return-Path: <linux-pci+bounces-10718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727BC93AF6B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 11:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FE46B22E93
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 09:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C330152160;
	Wed, 24 Jul 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u2VW+aIM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26E218AED
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814860; cv=none; b=NDy3XeUI+wU0BQnlXHv+bDVqL8AnCA+aUmXKZQAjvfITNS/FlqtqKlu6PivVjfnQAE63T4fEaz4HjBLc7D3BacDDq59ED4JYto1GQhZPofMgTY9NutjCsefPfvcck61aoqBNnfbGBHFAihAt0AVyGYrpRAdZkv0HNzJ4JYx/tAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814860; c=relaxed/simple;
	bh=nuk1P1pLa69zSDDPW80adj0k5y6J8I/iOm9ZZQGa9uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4AXV4ZDzxB+RZUdi6E3VZKo7F35/cwlyRxGeB1PWWlOBT3UZRON9pfMG2ai6/1Oy8ku0wsSObKEtw1tUG/r0l0P/1a5hmQ5oxZgYHwlNBvyXvdk21r6530stsQa8L0qelDNWdBn6S6l+PDTrBQitq8Y5FnNA2HJsI5CxamaOks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u2VW+aIM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso2659042b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721814858; x=1722419658; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bDgEYlw9bJMyIkYG+I3RR+zw7mE/Wd3hBgx5OXzcfpk=;
        b=u2VW+aIMQSk+jQ9WmHc9Seyl1fk7uShQeHtDx/fGZb3Ai4cmdtn3DycCWPguv1HRxw
         VuDCtxoOYniTNzW4qc3J/UPkW9y7krRhKaCXC4n2ky0ghjelhUia7/zIG4AaXSivmzVS
         ghftsnWopKM9YOIDdiQ4H5ySrZmBvBlZIheR2zfQEnt1N5lU+hrD33708v0ON0ukORrf
         yL9Xlgj+kIyzIxsgpJKZBM4EmwGeA023lqXWpf+4f/M3mwWyEgwwEHwJHbm5dLJlz6Po
         5npoKchRVekRBmFkgJ1D3BDsLhu+e2Q3dRy3uvvFBN3zy03t5SfYoY4i1LEvgOz5szja
         9ZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721814858; x=1722419658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bDgEYlw9bJMyIkYG+I3RR+zw7mE/Wd3hBgx5OXzcfpk=;
        b=xEw4ZMVz0p/+17Vzph7TkqlJEPhKEXNaGv2/6s6G0sMisTV5jkaCcg4uclqFlOxw/J
         ETHMtBF+Ctc6lSEu2HuIiW+xswAiLSzYD3AkkkVYV3jvkRtqAtCfFyScmDKZGon9NL+T
         1F0sovv3of5irYhEtDagePZoTDQIfdDJI2QTu4KicNBfx7c9wFVjd9fpJZWxvuUOLUzC
         vSzfJnWQrPPaIbV2QbkU/OUOn4/kF6xDi9aSi4/3toyzSGPDb/XaIfp1WQzocHjqqS4A
         MUnaADHFXSgEMc/fPbWKZ1TIuTfdsaktTKKxdQ0X98/EMMV460I9gK7iva4kX72ZND/9
         4jkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuNxOrnSLQbsbeontsYQ1GdRYSFEue9FkVxi2Clhn9mYT+94mZG/gVMpqyF7IQ2hzCB+n6SypxPKhtU+R14cEYgkYHMUBgf4OD
X-Gm-Message-State: AOJu0YxsutMmkUF/saBBh4lMAGb5wnq5ESSogDPqwmOaY4AGWYlrPFT1
	0/u/AETxuB2yCP6mQxGKWXUgd1v87v5Ta7ucANsM39uQQc7CvZ8diDjKcDRKUg==
X-Google-Smtp-Source: AGHT+IFc+bmwgUZf2NfrEi7RhkKsd/8QICOyMXuwNBmgqrPle6nKABbl1IG3MSOd56s4eQUb8WgHpA==
X-Received: by 2002:a05:6a00:2e19:b0:70d:2796:bce8 with SMTP id d2e1a72fcca58-70e996ffa7amr2918567b3a.20.1721814858089;
        Wed, 24 Jul 2024 02:54:18 -0700 (PDT)
Received: from thinkpad ([2409:40f4:1015:1102:2847:8cd3:4e58:1c8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0b909876sm6583051a12.40.2024.07.24.02.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 02:54:17 -0700 (PDT)
Date: Wed, 24 Jul 2024 15:24:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
	lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	jingoohan1@gmail.com, cassel@kernel.org,
	yoshihiro.shimoda.uh@renesas.com, s-vadapalli@ti.com,
	u.kleine-koenig@pengutronix.de, dlemoal@kernel.org,
	amishin@t-argos.ru, thierry.reding@gmail.com, jonathanh@nvidia.com,
	Frank.Li@nxp.com, ilpo.jarvinen@linux.intel.com, vidyas@nvidia.com,
	marek.vasut+renesas@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	quic_ramkri@quicinc.com, quic_nkela@quicinc.com,
	quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
	quic_nitegupt@quicinc.com, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 7/7] PCI: host-generic: Add dwc PCIe controller based
 MSI controller usage
Message-ID: <20240724095407.GA2347@thinkpad>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <1721067215-5832-8-git-send-email-quic_mrana@quicinc.com>
 <20240716085811.GA19348@willie-the-truck>
 <20240716134210.GA3534018-robh@kernel.org>
 <9b6eac04-f377-4afa-8712-ab916f831bba@quicinc.com>
 <6038632d-92ec-4034-bc68-add9d47f2bad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6038632d-92ec-4034-bc68-add9d47f2bad@quicinc.com>

On Tue, Jul 23, 2024 at 03:56:35PM -0700, Mayank Rana wrote:
> Hi Rob
> 
> On 7/16/2024 3:32 PM, Mayank Rana wrote:
> > Hi Will and Rob
> > 
> > Thank you for your quick review comments.
> > 
> > On 7/16/2024 6:42 AM, Rob Herring wrote:
> > > On Tue, Jul 16, 2024 at 09:58:12AM +0100, Will Deacon wrote:
> > > > On Mon, Jul 15, 2024 at 11:13:35AM -0700, Mayank Rana wrote:
> > > > > Add usage of Synopsys Designware PCIe controller based MSI
> > > > > controller to
> > > > > support MSI functionality with ECAM compliant Synopsys Designware PCIe
> > > > > controller. To use this functionality add device compatible string as
> > > > > "snps,dw-pcie-ecam-msi".
> > > > > 
> > > > > Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> > > > > ---
> > > > >   drivers/pci/controller/pci-host-generic.c | 92
> > > > > ++++++++++++++++++++++++++++++-
> > > > >   1 file changed, 91 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/pci-host-generic.c
> > > > > b/drivers/pci/controller/pci-host-generic.c
> > > > > index c2c027f..457ae44 100644
> > > > > --- a/drivers/pci/controller/pci-host-generic.c
> > > > > +++ b/drivers/pci/controller/pci-host-generic.c
> > > > > @@ -8,13 +8,73 @@
> > > > >    * Author: Will Deacon <will.deacon@arm.com>
> > > > >    */
> > > > > -#include <linux/kernel.h>
> > > > >   #include <linux/init.h>
> > > > > +#include <linux/kernel.h>
> > > > >   #include <linux/module.h>
> > > > > +#include <linux/of_address.h>
> > > > >   #include <linux/pci-ecam.h>
> > > > >   #include <linux/platform_device.h>
> > > > >   #include <linux/pm_runtime.h>
> > > > > +#include "dwc/pcie-designware-msi.h"
> > > > > +
> > > > > +struct dw_ecam_pcie {
> > > > > +    void __iomem *cfg;
> > > > > +    struct dw_msi *msi;
> > > > > +    struct pci_host_bridge *bridge;
> > > > > +};
> > > > > +
> > > > > +static u32 dw_ecam_pcie_readl(void *p_data, u32 reg)
> > > > > +{
> > > > > +    struct dw_ecam_pcie *ecam_pcie = (struct dw_ecam_pcie *)p_data;
> > > > > +
> > > > > +    return readl(ecam_pcie->cfg + reg);
> > > > > +}
> > > > > +
> > > > > +static void dw_ecam_pcie_writel(void *p_data, u32 reg, u32 val)
> > > > > +{
> > > > > +    struct dw_ecam_pcie *ecam_pcie = (struct dw_ecam_pcie *)p_data;
> > > > > +
> > > > > +    writel(val, ecam_pcie->cfg + reg);
> > > > > +}
> > > > > +
> > > > > +static struct dw_ecam_pcie *dw_pcie_ecam_msi(struct
> > > > > platform_device *pdev)
> > > > > +{
> > > > > +    struct device *dev = &pdev->dev;
> > > > > +    struct dw_ecam_pcie *ecam_pcie;
> > > > > +    struct dw_msi_ops *msi_ops;
> > > > > +    u64 addr;
> > > > > +
> > > > > +    ecam_pcie = devm_kzalloc(dev, sizeof(*ecam_pcie), GFP_KERNEL);
> > > > > +    if (!ecam_pcie)
> > > > > +        return ERR_PTR(-ENOMEM);
> > > > > +
> > > > > +    if (of_property_read_reg(dev->of_node, 0, &addr, NULL) < 0) {
> > > 
> > > Using this function on MMIO addresses is wrong. It is an untranslated
> > > address.
> > ok. do you prefer me to use of_address_to_resource() instead here ?
> > 
> > > > > +        dev_err(dev, "Failed to get reg address\n");
> > > > > +        return ERR_PTR(-ENODEV);
> > > > > +    }
> > > > > +
> > > > > +    ecam_pcie->cfg = devm_ioremap(dev, addr, PAGE_SIZE);
> > > > > +    if (ecam_pcie->cfg == NULL)
> > > > > +        return ERR_PTR(-ENOMEM);
> > > > > +
> > > > > +    msi_ops = devm_kzalloc(dev, sizeof(*msi_ops), GFP_KERNEL);
> > > > > +    if (!msi_ops)
> > > > > +        return ERR_PTR(-ENOMEM);
> > > > > +
> > > > > +    msi_ops->readl_msi = dw_ecam_pcie_readl;
> > > > > +    msi_ops->writel_msi = dw_ecam_pcie_writel;
> > > > > +    msi_ops->pp = ecam_pcie;
> > > > > +    ecam_pcie->msi = dw_pcie_msi_host_init(pdev, msi_ops, 0);
> > > > > +    if (IS_ERR(ecam_pcie->msi)) {
> > > > > +        dev_err(dev, "dw_pcie_msi_host_init() failed\n");
> > > > > +        return ERR_PTR(-EINVAL);
> > > > > +    }
> > > > > +
> > > > > +    dw_pcie_msi_init(ecam_pcie->msi);
> > > > > +    return ecam_pcie;
> > > > > +}
> > > > 
> > > > Hmm. This looks like quite a lot of not-very-generic code to be adding
> > > > to pci-host-generic.c. The file is now, what, 50% designware logic?
> > > 
> > > Agreed.
> > > 
> > > I would suggest you add ECAM support to the DW/QCom driver reusing some
> > > of the common ECAM support code.
> > I can try although there is very limited reusage of code with
> > pcie-qcom.c and pcie-designware-host.c except reusing MSI functionality.
> > That would make more new OPs within pcie-designware-host.c and
> > pcie-qcom.c just to perform few operation. As now MSI functionality is
> > available outside pcie core designware driver (although those changes
> > are under review), will you be ok to allow separate Qualcomm PCIe ECAM
> > driver as previously submitted RFC as https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@quicinc.com/T/
> > 
> > I can modify above ECAM driver to call into PCIe designware module based
> > MSI ops as doing here and that would allow reusing of MSI functionality
> > at same time allowing separate driver for handling firmware VM based
> > implementation.
> Can you consider above request to have separate driver here ?
> Please suggest on this.
> 

Generic ECAM driver is already supporting some DWC based ECAM implementations
like the ones added in commit 58fb207fb100 ("PCI: generic: Add support for
Synopsys DesignWare RC in ECAM mode").

From that perspective, I think it makes sense to add Qcom ECAM driver as a part
of this. But at the same time, you can also add the ECAM mode to the existing
DWC Qcom driver and reuse existing codes like MSI. Considering the amount of
Qcom specific features you are going to add (like safety interrupts etc...), it
won't look like a generic ECAM driver anyway.

So I guess there is no *ideal* location for this driver. IMO as long as you
avoid code duplication, I'm fine with whatever location.

From a quick look, I think it you go with Rob's suggestion, you can reuse
existing MSI and future RASDES functionalities, isn't it?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

