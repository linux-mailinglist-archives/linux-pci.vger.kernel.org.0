Return-Path: <linux-pci+bounces-40375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0A0C37375
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 18:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89916245A2
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 17:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DE223EABA;
	Wed,  5 Nov 2025 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWtZebVb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5839361FFE;
	Wed,  5 Nov 2025 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364773; cv=none; b=mfuXPVfLYAaIwurxFnL6bs0+NRwHqAikxstO2LyliSugrj5LWtWbttD10aLdF8gY02libahUfdB9z+82sW9irVGZIFc+3hcPe/b0uFjk2CBhtbEK72DI3zhk3kLFwmdxpd2Tfe6G4cFfqlGhbn9zfXPV/QQRgo0TA6Mn1fX3+ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364773; c=relaxed/simple;
	bh=sw7fLlwjYSgMMb0oFo0C0ODvBLjiCP98aYAsVuX5Urc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2clnopb2vMlo/yKFDscqBapiOXEfjLCtDN1yf0K03Bof6bJqnmYM6nEkQC6vFdMlYvQHl8OmQB3zsLNGs0uBx6nRBVX6DotiarX3VCbuNjCBNcjfOClbQXQzRIKr1IkNQ6CAbMvPvlL3pyhzu35vFrvas/Dv7aVBxpQ+sfqkx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWtZebVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43385C4CEF5;
	Wed,  5 Nov 2025 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762364773;
	bh=sw7fLlwjYSgMMb0oFo0C0ODvBLjiCP98aYAsVuX5Urc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qWtZebVbb8dV6bR2TqfpdwQfsVhTU12SVFZgoOKfcv4Pekr6VwzBxdk8+u1hS90Gl
	 cUU+klhozq++y/oGwMKvBBswBY132SmW6JMOsXj33T/BRVa9u1joeC3NrFrtks+AYg
	 MKlkurI2fCkypUb9GJKq2Kcbgtb9WIx3rcEbSk/oFMrTH5t2p5LM7QhDI6HQu8zvRz
	 Fi6jpsYSdn9/ITLlEKlF7pxYltgS+qBkfC7ce/t4tilCNBNTS5AT0OhDGn9qZCGGS0
	 lBBhL3+8oUdFJHetbmRI9wz3Lc7wYCJK1j91dhnA/r3MftoXcF1YZmUje1dob1HoVA
	 lMd7xXFElPJjw==
Date: Wed, 5 Nov 2025 23:16:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 4/4] power: sequencing: Add the Power Sequencing driver
 for the PCIe M.2 connectors
Message-ID: <tc2r2mme4wtre7vb7xj22vz55pks4fbdabyl62mgutyhcjxnlx@qn4jvx3jqhie>
References: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
 <20251105-pci-m2-v1-4-84b5f1f1e5e8@oss.qualcomm.com>
 <CAMRc=McB4Zk8WuSPL=7+7kX4RJbdFBNReWZyiFnH8vfVx3DxAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McB4Zk8WuSPL=7+7kX4RJbdFBNReWZyiFnH8vfVx3DxAg@mail.gmail.com>

On Wed, Nov 05, 2025 at 05:21:46PM +0100, Bartosz Golaszewski wrote:
> On Wed, Nov 5, 2025 at 10:17 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@oss.qualcomm.com> wrote:
> >
> > This driver is used to control the PCIe M.2 connectors of different
> > Mechanical Keys attached to the host machines and supporting different
> > interfaces like PCIe/SATA, USB/UART etc...
> >
> > Currently, this driver supports only the Mechanical Key M connectors with
> > PCIe interface. The driver also only supports driving the mandatory 3.3v
> > and optional 1.8v power supplies. The optional signals of the Key M
> > connectors are not currently supported.
> >
> 
> I'm assuming you followed some of the examples from the existing WCN
> power sequencing driver. Not all of them are good or matching this
> one, please see below.
> 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  MAINTAINERS                               |   7 ++
> >  drivers/power/sequencing/Kconfig          |   8 ++
> >  drivers/power/sequencing/Makefile         |   1 +
> >  drivers/power/sequencing/pwrseq-pcie-m2.c | 138 ++++++++++++++++++++++++++++++
> >  4 files changed, 154 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..9b3f689d1f50c62afa3772a0c6802f99a98ac2de 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20474,6 +20474,13 @@ F:     Documentation/driver-api/pwrseq.rst
> >  F:     drivers/power/sequencing/
> >  F:     include/linux/pwrseq/
> >
> > +PCIE M.2 POWER SEQUENCING
> > +M:     Manivannan Sadhasivam <mani@kernel.org>
> > +L:     linux-pci@vger.kernel.org
> > +S:     Maintained
> > +F:     Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > +F:     drivers/power/sequencing/pwrseq-pcie-m2.c
> > +
> >  POWER STATE COORDINATION INTERFACE (PSCI)
> >  M:     Mark Rutland <mark.rutland@arm.com>
> >  M:     Lorenzo Pieralisi <lpieralisi@kernel.org>
> > diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
> > index 280f92beb5d0ed524e67a28d1c5dd264bbd6c87e..f5fff84566ba463b55d3cd0c07db34c82f9f1e31 100644
> > --- a/drivers/power/sequencing/Kconfig
> > +++ b/drivers/power/sequencing/Kconfig
> > @@ -35,4 +35,12 @@ config POWER_SEQUENCING_TH1520_GPU
> >           GPU. This driver handles the complex clock and reset sequence
> >           required to power on the Imagination BXM GPU on this platform.
> >
> > +config POWER_SEQUENCING_PCIE_M2
> > +       tristate "PCIe M.2 connector power sequencing driver"
> > +       depends on OF || COMPILE_TEST
> 
> The OF dependency in the WCN driver is there because we're doing some
> phandle parsing and inspecting the parent-child relationships of the
> associated nodes. It doesn't look like you need it here. On the other
> hand, if you add more logic to the match() callback, this may come
> into play.
> 

For sure the driver will build fine for !CONFIG_OF, but it is not going to work.
And for the build coverage, COMPILE_TEST is already present. Maybe I was wrong
to enforce functional dependency in Kconfig.

> > +       help
> > +         Say Y here to enable the power sequencing driver for PCIe M.2
> > +         connectors. This driver handles the power sequencing for the M.2
> > +         connectors exposing multiple interfaces like PCIe, SATA, UART, etc...
> > +
> >  endif
> > diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
> > index 96c1cf0a98ac54c9c1d65a4bb4e34289a3550fa1..0911d461829897c5018e26dbe475b28f6fb6914c 100644
> > --- a/drivers/power/sequencing/Makefile
> > +++ b/drivers/power/sequencing/Makefile
> > @@ -5,3 +5,4 @@ pwrseq-core-y                           := core.o
> >
> >  obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)        += pwrseq-qcom-wcn.o
> >  obj-$(CONFIG_POWER_SEQUENCING_TH1520_GPU) += pwrseq-thead-gpu.o
> > +obj-$(CONFIG_POWER_SEQUENCING_PCIE_M2) += pwrseq-pcie-m2.o
> > diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..b9f68ee9c5a377ce900a88de86a3e269f9c99e51
> > --- /dev/null
> > +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> > @@ -0,0 +1,138 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwrseq/provider.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/slab.h>
> > +
> > +struct pwrseq_pcie_m2_pdata {
> > +       const struct pwrseq_target_data **targets;
> > +};
> > +
> > +struct pwrseq_pcie_m2_ctx {
> > +       struct pwrseq_device *pwrseq;
> > +       const struct pwrseq_pcie_m2_pdata *pdata;
> > +       struct regulator_bulk_data *regs;
> > +       size_t num_vregs;
> > +       struct notifier_block nb;
> > +};
> > +
> > +static int pwrseq_pcie_m2_m_vregs_enable(struct pwrseq_device *pwrseq)
> > +{
> > +       struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> > +
> > +       return regulator_bulk_enable(ctx->num_vregs, ctx->regs);
> > +}
> > +
> > +static int pwrseq_pcie_m2_m_vregs_disable(struct pwrseq_device *pwrseq)
> > +{
> > +       struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> > +
> > +       return regulator_bulk_disable(ctx->num_vregs, ctx->regs);
> > +}
> > +
> > +static const struct pwrseq_unit_data pwrseq_pcie_m2_vregs_unit_data = {
> > +       .name = "regulators-enable",
> > +       .enable = pwrseq_pcie_m2_m_vregs_enable,
> > +       .disable = pwrseq_pcie_m2_m_vregs_disable,
> > +};
> > +
> > +static const struct pwrseq_unit_data *pwrseq_pcie_m2_m_unit_deps[] = {
> > +       &pwrseq_pcie_m2_vregs_unit_data,
> > +       NULL
> > +};
> > +
> > +static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data = {
> > +       .name = "pcie-enable",
> > +       .deps = pwrseq_pcie_m2_m_unit_deps,
> > +};
> > +
> > +static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
> > +       .name = "pcie",
> > +       .unit = &pwrseq_pcie_m2_m_pcie_unit_data,
> > +};
> > +
> > +static const struct pwrseq_target_data *pwrseq_pcie_m2_m_targets[] = {
> > +       &pwrseq_pcie_m2_m_pcie_target_data,
> > +       NULL
> > +};
> > +
> > +static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_m_of_data = {
> > +       .targets = pwrseq_pcie_m2_m_targets,
> > +};
> > +
> > +static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
> > +                                struct device *dev)
> > +{
> > +       return PWRSEQ_MATCH_OK;
> 
> Eek! That will match any device we check. I'm not sure this is what
> you want. Looking at the binding example, I assume struct device *
> here will be the endpoint? If so, you should resolve it and confirm
> it's the one referenced from the connector node.
> 

I was expecting this question, so returned PWRSEQ_MATCH_OK on purpose. I feel it
is redundant to have match callback that just does link resolution and matches
the of_node of the caller. Can't we have a default match callback that does just
this?

> > +}
> > +
> > +static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct pwrseq_pcie_m2_ctx *ctx;
> > +       struct pwrseq_config config;
> > +       int ret;
> > +
> > +       ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +       if (!ctx)
> > +               return -ENOMEM;
> > +
> > +       ctx->pdata = of_device_get_match_data(dev);
> 
> I should probably address it in the WCN driver - you don't need to use
> the OF variant, use device_get_match_data().
> 

Ok.

> > +       if (!ctx->pdata)
> > +               return dev_err_probe(dev, -ENODEV,
> > +                                    "Failed to obtain platform data\n");
> > +
> > +       ret = of_regulator_bulk_get_all(dev, dev_of_node(dev), &ctx->regs);
> 
> Same here, you already have the device, no need to get the regulators
> through the OF node. Just use devm_regulator_bulk_get()
> 

I used it on purpose. This is the only regulator API that just gets all
regulators defined in the devicetree node without complaining. Here, 3.3v is
mandatory and 1.8v is optional. There could be other supplies in the future and
I do not want to hardcode the supply names in the driver. IMO, the driver should
trust devicetree to supply enough supplies and it should just consume them
instead of doing validation. I proposed to add a devm_ variant for this, but
Mark was against that idea.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

