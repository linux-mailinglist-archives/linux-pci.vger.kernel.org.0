Return-Path: <linux-pci+bounces-40376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3313BC372F1
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 18:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202FB1A21237
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 17:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FE132D0C8;
	Wed,  5 Nov 2025 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trhHGyuK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C63009DD;
	Wed,  5 Nov 2025 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364862; cv=none; b=Ewdrhd+qutHrRqC4deS0WO5+gbfpBcRrTMbiqYElDXYLV3CQ9m+o29jHkjvRcUA6eY6m7gOuy6nUm3C7CdOPEYFfL+6agekRPCOsohXu8kFK/VwjZGZ04S7mUT6oafF+0oj+pNa96UMMz/tvE0JcXn/6yAVl2AvhnIys0kticfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364862; c=relaxed/simple;
	bh=ouB+TdvoLahOuTnAF2oMvy07alxSGxli529k84Vs5SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnQ2HTZlTDkJexZA2CgkHIQYrxNTDcwDPhYIzKRY0WTCOZ9MH6eIR8mr3XIKgOQXt/y9nouHE/cA0wMkSrqsnN0Lppqn2MaPDO2cfALIsWmDL5QE5Fs9NZeRnrjeJ1JxXrtndHyUbBDhn8N46N276MoyGjvB1+vr6TML+EEhoOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trhHGyuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AC1C4CEF8;
	Wed,  5 Nov 2025 17:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762364861;
	bh=ouB+TdvoLahOuTnAF2oMvy07alxSGxli529k84Vs5SU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=trhHGyuKkdUtB8rp0WWVIuUqqW3uIy0jTZKZXb8FZ8ODeZlSnynBh8jbGd7+IEKuu
	 SNmIXH6eqGUrp/87sR+1txSsuFOSOaLlsaVx4BAIUqqhi6Axd4QqeLTVo3BQyWnPW4
	 u5du3hhGb6ocgYwe/xFFJVmowvAatjp9h9FtF1oc5c0ehmWSlpU02L38gDrEaaq8yF
	 eJAoClLW1wrsF//aiuqaIdpAi9RcQ1hPqgGuJMGHtvm1r+oJU0nKQlbWlppRZUK7O7
	 eHLzj6YSW/dcotkCVijQwUR50ouhvqcyt+IGdTmyff/5mV4866zmMzOYrAv4IM2QJx
	 YBkY9f5e0GjsA==
Date: Wed, 5 Nov 2025 23:17:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 4/4] power: sequencing: Add the Power Sequencing driver
 for the PCIe M.2 connectors
Message-ID: <m5nwjaqel4q7lsnsewe4dlw2khfjliatqg45ei5dzuemmfdiig@kdis3euzpbcv>
References: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
 <20251105-pci-m2-v1-4-84b5f1f1e5e8@oss.qualcomm.com>
 <aQuICrh4qP0wftIl@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQuICrh4qP0wftIl@lizhi-Precision-Tower-5810>

On Wed, Nov 05, 2025 at 12:23:22PM -0500, Frank Li wrote:
> On Wed, Nov 05, 2025 at 02:45:52PM +0530, Manivannan Sadhasivam wrote:
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
> >  drivers/power/sequencing/pwrseq-pcie-m2.c | 138 ++++++++++++++++++++++++++++++
> >  4 files changed, 154 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 46126ce2f968e4f9260263f1574ee29f5ff0de1c..9b3f689d1f50c62afa3772a0c6802f99a98ac2de 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20474,6 +20474,13 @@ F:	Documentation/driver-api/pwrseq.rst
> >  F:	drivers/power/sequencing/
> >  F:	include/linux/pwrseq/
> >
> > +PCIE M.2 POWER SEQUENCING
> > +M:	Manivannan Sadhasivam <mani@kernel.org>
> > +L:	linux-pci@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > +F:	drivers/power/sequencing/pwrseq-pcie-m2.c
> > +
> >  POWER STATE COORDINATION INTERFACE (PSCI)
> >  M:	Mark Rutland <mark.rutland@arm.com>
> >  M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
> > diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
> > index 280f92beb5d0ed524e67a28d1c5dd264bbd6c87e..f5fff84566ba463b55d3cd0c07db34c82f9f1e31 100644
> > --- a/drivers/power/sequencing/Kconfig
> > +++ b/drivers/power/sequencing/Kconfig
> > @@ -35,4 +35,12 @@ config POWER_SEQUENCING_TH1520_GPU
> >  	  GPU. This driver handles the complex clock and reset sequence
> >  	  required to power on the Imagination BXM GPU on this platform.
> >
> > +config POWER_SEQUENCING_PCIE_M2
> > +	tristate "PCIe M.2 connector power sequencing driver"
> > +	depends on OF || COMPILE_TEST
> > +	help
> > +	  Say Y here to enable the power sequencing driver for PCIe M.2
> > +	  connectors. This driver handles the power sequencing for the M.2
> > +	  connectors exposing multiple interfaces like PCIe, SATA, UART, etc...
> > +
> >  endif
> > diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing/Makefile
> > index 96c1cf0a98ac54c9c1d65a4bb4e34289a3550fa1..0911d461829897c5018e26dbe475b28f6fb6914c 100644
> > --- a/drivers/power/sequencing/Makefile
> > +++ b/drivers/power/sequencing/Makefile
> > @@ -5,3 +5,4 @@ pwrseq-core-y				:= core.o
> >
> >  obj-$(CONFIG_POWER_SEQUENCING_QCOM_WCN)	+= pwrseq-qcom-wcn.o
> >  obj-$(CONFIG_POWER_SEQUENCING_TH1520_GPU) += pwrseq-thead-gpu.o
> > +obj-$(CONFIG_POWER_SEQUENCING_PCIE_M2)	+= pwrseq-pcie-m2.o
> > diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..b9f68ee9c5a377ce900a88de86a3e269f9c99e51
> > --- /dev/null
> > +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> ...
> > +
> > +static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct pwrseq_pcie_m2_ctx *ctx;
> > +	struct pwrseq_config config;
> > +	int ret;
> > +
> > +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +	if (!ctx)
> > +		return -ENOMEM;
> > +
> > +	ctx->pdata = of_device_get_match_data(dev);
> > +	if (!ctx->pdata)
> > +		return dev_err_probe(dev, -ENODEV,
> > +				     "Failed to obtain platform data\n");
> > +
> > +	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev), &ctx->regs);
> > +	if (ret < 0)
> > +		return dev_err_probe(dev, ret,
> > +				     "Failed to get all regulators\n");
> > +
> > +	ctx->num_vregs = ret;
> > +
> > +	memset(&config, 0, sizeof(config));
> > +
> > +	config.parent = dev;
> > +	config.owner = THIS_MODULE;
> > +	config.drvdata = ctx;
> > +	config.match = pwrseq_pcie_m2_match;
> > +	config.targets = ctx->pdata->targets;
> > +
> > +	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
> > +	if (IS_ERR(ctx->pwrseq))
> > +		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
> > +				     "Failed to register the power sequencer\n");
> 
> Does need free resources allocated by of_regulator_bulk_get_all() here?
> 

Yes, missed it during cleanup. Will fix.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

