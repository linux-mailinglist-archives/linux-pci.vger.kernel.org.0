Return-Path: <linux-pci+bounces-12201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D90B395F104
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 14:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670311F22AA8
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE80F18D65B;
	Mon, 26 Aug 2024 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYPHoJVh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C12172798;
	Mon, 26 Aug 2024 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674257; cv=none; b=B1GSpu4en7Vw4eNHQQ9GzmfGn+HwCYV79rgxDskhbDAP/x/tvkPPdeIz+P+yRRaGVumb+dI1YadUYLD7YnYBj3bPqlHsFb26M7dMNeOQvxWQh3Kjoc/XRxbbhXWBu5lYeyh1DkcC9jH+iT7sCuGZGJGWaJ0Ua9K3Ce7gzJnxdNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674257; c=relaxed/simple;
	bh=XoNvGZEd0jn83AcWVePGvHhp0KOl9p5SiFsphjRpmvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msSiAX9NiI0yOM4HqgTEp0qun8cjK9iUHVjX6syTcFSHhnzxpWXeaW3AouNNa+llErLwDGexkesrnobznFycZV3Em3cM0+8klJLBc7XijK8GuwUR5/A1diQD+UC4UIVyJ4MQDgJOngRua+VetwSMI+zW/CGVUQE3HxTDbI2n2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYPHoJVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F30C4DE1A;
	Mon, 26 Aug 2024 12:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724674257;
	bh=XoNvGZEd0jn83AcWVePGvHhp0KOl9p5SiFsphjRpmvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYPHoJVhVrTUQVg624ssVlJGmQJD/+H8HzNNE9dKy7zrKQjG3Gxarcg37xJf+jA1/
	 P9MkH+KVzhMNWFDHOw1MTPvGwZgV0LWc69OZsNOTEC0sR9yXM2oYk3a8s9Y4+y6g+E
	 T6hh5FJicCaukVpFSoNdRoeaWLbq/OcWXtFaKkhnev4zsTGQv38nr5ibwRsPtRvpRV
	 dkGV6iuaIH3rr307QJSOMHt16Z0lociUZZoIzFp8qR/IAN4fZ57NAgEvKT1p1DLLPP
	 cnT4rLLVbS/xuQSGdOep35JXh7p1meEkz97rSTuU7u61Xu1Ys6VTVJLuetQXrKMZR3
	 9rOf/IXrRwDag==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1siYYr-000000002Pq-3ak2;
	Mon, 26 Aug 2024 14:11:06 +0200
Date: Mon, 26 Aug 2024 14:11:05 +0200
From: Johan Hovold <johan@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mani@kernel.org, quic_msarkar@quicinc.com,
	quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PCI: qcom: Refactor common code
Message-ID: <Zsxw2RIfLxEfgYN8@hovoldconsulting.com>
References: <20240821170917.21018-1-quic_schintav@quicinc.com>
 <20240821170917.21018-2-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821170917.21018-2-quic_schintav@quicinc.com>

On Wed, Aug 21, 2024 at 10:08:42AM -0700, Shashank Babu Chinta Venkata wrote:
> Refactor common code from RC(Root Complex) and EP(End Point)

Space before open parentheses, please (again).

> drivers and move them to a common driver. This acts as placeholder
> for common source code for both drivers, thus avoiding duplication.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>

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

Again, you can't claim copyright for just moving code around.

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

As I already pointed out, these helpers seems to be of very little worth
and just hides what is really going on (e.g. that the resources are
device managed). Please consider dropping them.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
> new file mode 100644
> index 000000000000..897fa18e618a
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2015, 2021 Linaro Limited.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.

Same copyright issue here.

> + */
> +
> +#include "pcie-designware.h"
> +
> +#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
> +		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
> +
> +struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path);
> +int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem, u32 bandwidth);
> +void qcom_pcie_common_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);

Compile guards still missing, despite me pointing that out before.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 236229f66c80..e1860026e134 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
  
> -	ret = icc_set_bw(pcie_ep->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
> +	ret = qcom_pcie_common_icc_init(pci, pcie_ep->icc_mem);

Does not even compile, as reported by the build bots.

> -static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
> -{
> -	struct dw_pcie *pci = pcie->pci;
> -	int ret;
> -
> -	pcie->icc_mem = devm_of_icc_get(pci->dev, "pcie-mem");
> -	if (IS_ERR(pcie->icc_mem))
> -		return PTR_ERR(pcie->icc_mem);
> -
> -	pcie->icc_cpu = devm_of_icc_get(pci->dev, "cpu-pcie");
> -	if (IS_ERR(pcie->icc_cpu))
> -		return PTR_ERR(pcie->icc_cpu);
> -	/*
> -	 * Some Qualcomm platforms require interconnect bandwidth constraints
> -	 * to be set before enabling interconnect clocks.
> -	 *
> -	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> -	 * for the pcie-mem path.
> -	 */
> -	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
> -	if (ret) {
> -		dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
> -			ret);
> -		return ret;
> -	}
> -
> -	/*
> -	 * Since the CPU-PCIe path is only used for activities like register
> -	 * access of the host controller and endpoint Config/BAR space access,
> -	 * HW team has recommended to use a minimal bandwidth of 1KBps just to
> -	 * keep the path active.
> -	 */
> -	ret = icc_set_bw(pcie->icc_cpu, 0, kBps_to_icc(1));
> -	if (ret) {
> -		dev_err(pci->dev, "Failed to set bandwidth for CPU-PCIe interconnect path: %d\n",
> -			ret);
> -		icc_set_bw(pcie->icc_mem, 0, 0);
> -		return ret;
> -	}
> -
> -	return 0;
> -}

Just keep this function as is.

> -static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
> -{
> -	u32 offset, status, width, speed;
> -	struct dw_pcie *pci = pcie->pci;
> -	unsigned long freq_kbps;
> -	struct dev_pm_opp *opp;
> -	int ret, freq_mbps;
> -
> -	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> -
> -	/* Only update constraints if link is up. */
> -	if (!(status & PCI_EXP_LNKSTA_DLLLA))
> -		return;
> -
> -	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> -	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> -
> -	if (pcie->icc_mem) {
> -		ret = icc_set_bw(pcie->icc_mem, 0,
> -				 width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> -		if (ret) {
> -			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
> -				ret);
> -		}
> -	} else {
> -		freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
> -		if (freq_mbps < 0)
> -			return;
> -
> -		freq_kbps = freq_mbps * KILO;
> -		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
> -						 true);
> -		if (!IS_ERR(opp)) {
> -			ret = dev_pm_opp_set_opp(pci->dev, opp);
> -			if (ret)
> -				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
> -					freq_kbps * width, ret);
> -			dev_pm_opp_put(opp);
> -		}
> -	}
> -}

Maybe it's worth trying to generalise this, but probably not. Either
way, I don't think the gen4 stability *fixes* should depend on this (the
gen4 nvme link on x1e80100 is currently broken and depends on the later
changes in this series).

Please consider dropping all this, mostly bogus, refactoring and just
get the gen4 fixes in first.

> -
>  static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
>  {
>  	struct qcom_pcie *pcie = (struct qcom_pcie *)dev_get_drvdata(s->private);
> @@ -1561,6 +1472,18 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> +	pcie->icc_mem = qcom_pcie_common_icc_get_resource(pcie->pci, "pcie-mem");
> +	if (IS_ERR_OR_NULL(pcie->icc_mem)) {

This will break machines which don't have this path. NULL is valid here.

> +		ret = PTR_ERR(pcie->icc_mem);
> +		goto err_pm_runtime_put;
> +	}
> +
> +	pcie->icc_cpu = qcom_pcie_common_icc_get_resource(pcie->pci, "cpu-pcie");
> +	if (IS_ERR_OR_NULL(pcie->icc_cpu)) {

Same here.

> +		ret = PTR_ERR(pcie->icc_cpu);
> +		goto err_pm_runtime_put;
> +	}
> +
>  	/* OPP table is optional */
>  	ret = devm_pm_opp_of_add_table(dev);
>  	if (ret && ret != -ENODEV) {

> @@ -1681,7 +1629,8 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>  	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
>  		ret = icc_disable(pcie->icc_cpu);
>  		if (ret)
> -			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
> +			dev_err(dev,
> +			"Failed to disable CPU-PCIe interconnect path: %d\n", ret);

Unrelated, bogus change.

Johan

