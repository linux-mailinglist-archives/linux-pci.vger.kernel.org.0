Return-Path: <linux-pci+bounces-44159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C862FCFD1A6
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 11:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 415D530B2398
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 10:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF7128B4FE;
	Wed,  7 Jan 2026 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOu4RDFH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9513C2139C9;
	Wed,  7 Jan 2026 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778744; cv=none; b=JrxG3X1j/FZvYLQ4UTMi5pA3T6demUX8MFgL3h8I8+sTGeKUgyvRag0dmY4iQ7RMYf6wxGFwEI6/NmTEBaMHpPTqE+A8z9yfztK+KoerifZAGojHtNMV/UpyTBLh/TWNgjj/YWtLvXMHHSrBhmYuOG/ey/YdC10Axc3xz06498Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778744; c=relaxed/simple;
	bh=PsRf4pbDc1e82R0yxHCIvKZeRq20Nnsceo97LxRmP58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0KE4/6QGL4vQ5UUWzX6EdR4kWd/eZUgZdOcRrrSb3G8UJAWnYV25U8u4JNfvbDvMKSnpLfkAmMuEM70T4oaO5OmxCGj2uFrTJeXHagx7rzY6RTwP1PtolEEWK7hmyOUIZXpl4Z66H6HOsdylANg4t//glmj7xDhhDmn9Bh20I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOu4RDFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC1AC16AAE;
	Wed,  7 Jan 2026 09:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767778744;
	bh=PsRf4pbDc1e82R0yxHCIvKZeRq20Nnsceo97LxRmP58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YOu4RDFHf4wy5wSuEt+UhwBF5CwWPIHrRgshqFqBIKGVzkEMooQ1yg1R+tMajri1V
	 j1J5Lhlkv1u5qEl/0qQ06I228mrRrKIKvnlLuDOLwg/+uY/9d3cqKdEWWkemNUG1pG
	 X/SVbM/M+CGZQzoiW4vjqf+5yqwFBXZj29+L3tL6Ct222wvVVi9H+GBPL062XkDtr+
	 lz+l6laIzipwYJGdL5X6ytgLWNiLRERvLfA+EwnrSS/ScTqr42/CCaij6fIjjKMD1P
	 4B6GuTMTyVxEzKfGPfEyv8HYLeay6PPH63K/U3Q9lWoVN7oncd8eUioN7oRM2uIwcg
	 pdEpqXaPj0izA==
Date: Wed, 7 Jan 2026 15:08:55 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v4 5/5] power: sequencing: Add the Power Sequencing
 driver for the PCIe M.2 connectors
Message-ID: <z33axfsiox73f2lklhiaulekjnqxnqtkycfylybwqnqxtx2fck@3qtas4u6mfnz>
References: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
 <20251228-pci-m2-v4-5-5684868b0d5f@oss.qualcomm.com>
 <CAMRc=MfPq7+ZbWTp7+H388hqHoX27qbbHsLHO+xeLaceTwZLVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfPq7+ZbWTp7+H388hqHoX27qbbHsLHO+xeLaceTwZLVA@mail.gmail.com>

On Fri, Jan 02, 2026 at 12:26:21PM +0100, Bartosz Golaszewski wrote:
> On Sun, Dec 28, 2025 at 6:01 PM Manivannan Sadhasivam
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
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  MAINTAINERS                               |   7 ++
> >  drivers/power/sequencing/Kconfig          |   8 ++
> >  drivers/power/sequencing/Makefile         |   1 +
> >  drivers/power/sequencing/pwrseq-pcie-m2.c | 160 ++++++++++++++++++++++++++++++
> >  4 files changed, 176 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5b11839cba9d..2eb7b6d26573 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20791,6 +20791,13 @@ F:     Documentation/driver-api/pwrseq.rst
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
> > index 280f92beb5d0..f5fff84566ba 100644
> > --- a/drivers/power/sequencing/Kconfig
> > +++ b/drivers/power/sequencing/Kconfig
> > @@ -35,4 +35,12 @@ config POWER_SEQUENCING_TH1520_GPU
> >           GPU. This driver handles the complex clock and reset sequence
> >           required to power on the Imagination BXM GPU on this platform.
> >
> > +config POWER_SEQUENCING_PCIE_M2
> > +       tristate "PCIe M.2 connector power sequencing driver"
> > +       depends on OF || COMPILE_TEST
> > +       help
> > +         Say Y here to enable the power sequencing driver for PCIe M.2
> > +         connectors. This driver handles the power sequencing for the M.2
> > +         connectors exposing multiple interfaces like PCIe, SATA, UART, etc...
> > +
> >  endif
> > diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
> > index 96c1cf0a98ac..0911d4618298 100644
> > --- a/drivers/power/sequencing/Makefile
> > +++ b/drivers/power/sequencing/Makefile
> > @@ -5,3 +5,4 @@ pwrseq-core-y                           := core.o
> >
> >  obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)        += pwrseq-qcom-wcn.o
> >  obj-$(CONFIG_POWER_SEQUENCING_TH1520_GPU) += pwrseq-thead-gpu.o
> > +obj-$(CONFIG_POWER_SEQUENCING_PCIE_M2) += pwrseq-pcie-m2.o
> > diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> > new file mode 100644
> > index 000000000000..4835d099d967
> > --- /dev/null
> > +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> > @@ -0,0 +1,160 @@
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
> > +#include <linux/of_graph.h>
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
> > +       struct device_node *of_node;
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
> > +       struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
> > +       struct device_node *endpoint __free(device_node) = NULL;
> > +
> > +       /*
> > +        * Traverse the 'remote-endpoint' nodes and check if the remote node's
> > +        * parent matches the OF node of 'dev'.
> > +        */
> > +       for_each_endpoint_of_node(ctx->of_node, endpoint) {
> > +               struct device_node *remote __free(device_node) =
> > +                               of_graph_get_remote_port_parent(endpoint);
> > +               if (remote && (remote == dev_of_node(dev)))
> > +                       return PWRSEQ_MATCH_OK;
> > +       }
> > +
> > +       return PWRSEQ_NO_MATCH;
> > +}
> > +
> > +static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct pwrseq_pcie_m2_ctx *ctx;
> > +       struct pwrseq_config config = {};
> > +       int ret;
> > +
> > +       ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +       if (!ctx)
> > +               return -ENOMEM;
> > +
> > +       ctx->of_node = dev_of_node(dev);
> 
> Since you're storing the node address for later, I'd suggest using
> of_node_get() to get a real reference.
> 

If CONFIG_OF_DYNAMIC is not enabled, then of_node_get() will just return the
passed pointer. I always prefer using dev_of_node() since it has the CONFIG_OF
and NULL check. Though, the checks won't apply here, I used it for consistency.

> > +       ctx->pdata = device_get_match_data(dev);
> > +       if (!ctx->pdata)
> > +               return dev_err_probe(dev, -ENODEV,
> > +                                    "Failed to obtain platform data\n");
> > +
> > +       /*
> > +        * Currently, of_regulator_bulk_get_all() is the only regulator API that
> > +        * allows to get all supplies in the devicetree node without manually
> > +        * specifying them.
> > +        */
> > +       ret = of_regulator_bulk_get_all(dev, dev_of_node(dev), &ctx->regs);
> > +       if (ret < 0)
> > +               return dev_err_probe(dev, ret,
> > +                                    "Failed to get all regulators\n");
> > +
> > +       ctx->num_vregs = ret;
> > +
> > +       config.parent = dev;
> > +       config.owner = THIS_MODULE;
> > +       config.drvdata = ctx;
> > +       config.match = pwrseq_pcie_m2_match;
> > +       config.targets = ctx->pdata->targets;
> > +
> > +       ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
> > +       if (IS_ERR(ctx->pwrseq)) {
> > +               regulator_bulk_free(ctx->num_vregs, ctx->regs);
> 
> You're freeing it on error but not on driver detach? Maybe schedule a
> devm action if there's no devres variant?
> 

Ok!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

