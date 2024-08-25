Return-Path: <linux-pci+bounces-12167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D284895E22F
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 08:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E361C20B0F
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 06:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189112AD02;
	Sun, 25 Aug 2024 06:06:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D882207A;
	Sun, 25 Aug 2024 06:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724565987; cv=none; b=LEHDgJZfhDFz3DV80FPUI2bCtyJtL/eFqCyIKQWz2i6a8nY3lD6dtn2ouJQetqHVddQ+EUOmub0J9i991QHQEZALzNMoS3V3mpHBNotM+ND4mfita27kMoGGeX3vaGu98MWlScaE8e/N2UTOdkZ+KogoLEFieEeeqmDe1NBCIu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724565987; c=relaxed/simple;
	bh=M/RBB0tbBYwBAXjv05o2DOzaHPkqo5dzkYP6Eo7eOxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hsn2iolb39mbocAaZILWI+bxjIV3Il0YagYwwl8Ro4ZBUxalnbWwVb8rfQvo2VHIa+sbsC9iwsf2Wx0/j5xSmpWKCf8UYzawYqrn+WspJ2b+NZEdDj8OWL8CUXJ9osM2v4GuR/9hmbor5q59jxZIcVfIpjLjeBOLs5HNAQ31lgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BE2C32782;
	Sun, 25 Aug 2024 06:06:18 +0000 (UTC)
Date: Sun, 25 Aug 2024 11:36:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mani@kernel.org, quic_msarkar@quicinc.com,
	quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PCI: qcom: Refactor common code
Message-ID: <20240825060614.yakowf5tmwlp66v4@thinkpad>
References: <20240821170917.21018-1-quic_schintav@quicinc.com>
 <20240821170917.21018-2-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821170917.21018-2-quic_schintav@quicinc.com>

On Wed, Aug 21, 2024 at 10:08:42AM -0700, Shashank Babu Chinta Venkata wrote:
> Refactor common code from RC(Root Complex) and EP(End Point)
> drivers and move them to a common driver. This acts as placeholder
> for common source code for both drivers, thus avoiding duplication.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---
>  MAINTAINERS                                   |   3 +
>  drivers/pci/controller/dwc/Kconfig            |   5 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  drivers/pci/controller/dwc/pcie-qcom-common.c |  88 +++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.h |  15 ++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  39 +----
>  drivers/pci/controller/dwc/pcie-qcom.c        | 141 ++++++------------
>  7 files changed, 161 insertions(+), 131 deletions(-)
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.h
> 

[...]

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
> new file mode 100644
> index 000000000000..1d8992147bba
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2015, 2021 Linaro Limited.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/interconnect.h>
> +#include <linux/pm_opp.h>
> +#include <linux/units.h>
> +
> +#include "../../pci.h"
> +#include "pcie-designware.h"
> +#include "pcie-qcom-common.h"
> +
> +struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path)

On top of Bjorn's review:

I think you can just use qcom_pcie_common_icc_get() as _resource suffix is not
really needed.

> +{
> +	struct icc_path *icc_p;
> +
> +	icc_p = devm_of_icc_get(pci->dev, path);
> +	return icc_p;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pcie_common_icc_get_resource);
> +
> +int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc, u32 bandwidth)
> +{
> +	int ret;
> +
> +	ret = icc_set_bw(icc, 0, bandwidth);
> +	if (ret) {
> +		dev_err(pci->dev, "Failed to set interconnect bandwidth: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pcie_common_icc_init);
> +
> +void qcom_pcie_common_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem)
> +{
> +	u32 offset, status, width, speed;
> +	unsigned long freq_kbps;
> +	struct dev_pm_opp *opp;
> +	int ret, freq_mbps;
> +
> +	if (!icc_mem)
> +		return;

With this check in place, below OPP code will never get executed.

> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +
> +	/* Only update constraints if link is up. */
> +	if (!(status & PCI_EXP_LNKSTA_DLLLA))
> +		return;
> +
> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> +
> +	if (icc_mem) {
> +		ret = icc_set_bw(icc_mem, 0,
> +				 width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> +		if (ret) {
> +			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
> +				ret);
> +		}
> +	} else {
> +		freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
> +		if (freq_mbps < 0)
> +			return;
> +
> +		freq_kbps = freq_mbps * KILO;
> +		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
> +						 true);
> +		if (!IS_ERR(opp)) {
> +			ret = dev_pm_opp_set_opp(pci->dev, opp);
> +			if (ret)
> +				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
> +					freq_kbps * width, ret);
> +			dev_pm_opp_put(opp);
> +		}
> +
> +	}
> +
> +}
> +EXPORT_SYMBOL_GPL(qcom_pcie_common_icc_update);

[...]

>  static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
>  {
>  	struct qcom_pcie *pcie = (struct qcom_pcie *)dev_get_drvdata(s->private);
> @@ -1561,6 +1472,18 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> +	pcie->icc_mem = qcom_pcie_common_icc_get_resource(pcie->pci, "pcie-mem");
> +	if (IS_ERR_OR_NULL(pcie->icc_mem)) {

Why are you checking for NULL here and below? ICC core will return NULL if the
path is not found in DT or ICC is disabled and it is important to not treat it
as an error to maintain DT backwards compatibility.

> +		ret = PTR_ERR(pcie->icc_mem);
> +		goto err_pm_runtime_put;
> +	}
> +
> +	pcie->icc_cpu = qcom_pcie_common_icc_get_resource(pcie->pci, "cpu-pcie");
> +	if (IS_ERR_OR_NULL(pcie->icc_cpu)) {
> +		ret = PTR_ERR(pcie->icc_cpu);
> +		goto err_pm_runtime_put;
> +	}
> +
>  	/* OPP table is optional */
>  	ret = devm_pm_opp_of_add_table(dev);
>  	if (ret && ret != -ENODEV) {
> @@ -1593,10 +1516,35 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  			goto err_pm_runtime_put;
>  		}
>  	} else {
> -		/* Skip ICC init if OPP is supported as it is handled by OPP */
> -		ret = qcom_pcie_icc_init(pcie);
> -		if (ret)
> +		/*
> +		 * Some Qualcomm platforms require interconnect bandwidth
> +		 * constraints to be set before enabling interconnect clocks
> +		 * Set an initial peak bandwidth corresponding to single-lane
> +		 * Gen 1 for the pcie-mem path.
> +		 */
> +		ret = qcom_pcie_common_icc_init(pcie->pci, pcie->icc_mem,
> +					QCOM_PCIE_LINK_SPEED_TO_BW(1));
> +		if (ret) {
> +			dev_err(pci->dev,
> +			"Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
> +			ret);
>  			goto err_pm_runtime_put;
> +		}
> +
> +		/*
> +		 * Since the CPU-PCIe path is only used for activities
> +		 * like register access of the host controller and
> +		 * endpoint Config/BAR space access, HW team has
> +		 * recommended to use a minimal bandwidth of 1KBps just to
> +		 * keep the path active.
> +		 */

Please wrap the comments to 80 columns. I don't know what column length you are
using here.

> +		ret = qcom_pcie_common_icc_init(pcie->pci, pcie->icc_cpu, kBps_to_icc(1));
> +		if (ret) {
> +			dev_err(pci->dev,
> +			"Failed to set bandwidth for CPU-PCIe interconnect path: %d\n",

You can make use of 100 column extension here and below.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

