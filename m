Return-Path: <linux-pci+bounces-6520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759BE8AD008
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 16:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035BF1F226A5
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D9914F11C;
	Mon, 22 Apr 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on2WQfzX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297151E49F;
	Mon, 22 Apr 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797910; cv=none; b=OFFmMI65DuGw/LQotW3ITgIWXRAAJ4fWDds+d45B+IAc+bMnnSkmcZAoIpbhrr0eQlyqyXaNQ+YmGt+wPAcY/VqRJx4+lK0e0hiMivsnRoSE5oMFx9fjoaRT7cksoKmmv+Id9phdiLktWf6VOSq+3IPTMDcrTwUvZ1LR8cYlmn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797910; c=relaxed/simple;
	bh=Hnua4xCH7jRrOiIHSR0dvdKvoajbxDPeeOvhhIlqF+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba2b/TxRYSbg1e5koIGa7kmKRLpzOBE/3Jt2yO6iGmVWhPFGUCPbEQmGOgGFHAKuYmfWLyfIIHqK3LKSvCZ6rr9DGziTSyfCuxFoBS6cyszMr2aaJKWBSd5fETuWu1vSMkxnCXOu4Z01zgzF8+NCg/RmYKrqKM6AeFKlUqvQnTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on2WQfzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D660C113CC;
	Mon, 22 Apr 2024 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713797909;
	bh=Hnua4xCH7jRrOiIHSR0dvdKvoajbxDPeeOvhhIlqF+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=on2WQfzXFwtAj6/BDOEjM2NhOBlHQAc3BaXxJAkYrMsEivJpgt4vUHxi81fVlOiH/
	 M//TZlW6sBgOTPPh3crrotNtNC9lp+a8JrvZgd/lKtcifxR6WlAmiCbx9vwIIGCQnQ
	 tZveRR+5lW67TwLaYO9bQWUXKc+bnGuar/cI7+/bx1Pn5Ap0DkFi4D9kH2OhLambbV
	 ok939lrJqZPulpRY+2ppygMq1AvdcwKPrquZuCI8E/nUvVhTkgsb1NRtRCoNiMv3Qp
	 Tk0KcS8Q4ixV7KYkhWXMN5z3um30bkCSxRoVGeXSlGNwxO02jPSoVUmI/bhndcMnhf
	 yh7Gp3ByNR4nw==
Date: Mon, 22 Apr 2024 20:28:14 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	quic_msarkar@quicinc.com, quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: qcom: Refactor common code
Message-ID: <20240422145814.GF9775@thinkpad>
References: <20240419001013.28788-1-quic_schintav@quicinc.com>
 <20240419001013.28788-2-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240419001013.28788-2-quic_schintav@quicinc.com>

On Thu, Apr 18, 2024 at 05:09:34PM -0700, Shashank Babu Chinta Venkata wrote:
> Refactor common code from RC(Root Complex) and EP(End Point)
> drivers and move them to a common driver. This acts as placeholder
> for common source code for both drivers, thus avoiding duplication.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |  5 ++
>  drivers/pci/controller/dwc/Makefile           |  1 +
>  drivers/pci/controller/dwc/pcie-qcom-common.c | 75 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.h | 12 +++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     | 39 +---------
>  drivers/pci/controller/dwc/pcie-qcom.c        | 67 ++---------------
>  6 files changed, 105 insertions(+), 94 deletions(-)
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.h
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 8afacc90c63b..1599550cd628 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -265,12 +265,16 @@ config PCIE_DW_PLAT_EP
>  	  order to enable device-specific features PCI_DW_PLAT_EP must be
>  	  selected.
>  
> +config PCIE_QCOM_COMMON
> +	bool
> +
>  config PCIE_QCOM
>  	bool "Qualcomm PCIe controller (host mode)"
>  	depends on OF && (ARCH_QCOM || COMPILE_TEST)
>  	depends on PCI_MSI
>  	select PCIE_DW_HOST
>  	select CRC8
> +	select PCIE_QCOM_COMMON
>  	help
>  	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
>  	  PCIe controller uses the DesignWare core plus Qualcomm-specific
> @@ -281,6 +285,7 @@ config PCIE_QCOM_EP
>  	depends on OF && (ARCH_QCOM || COMPILE_TEST)
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
> +	select PCIE_QCOM_COMMON
>  	help
>  	  Say Y here to enable support for the PCIe controllers on Qualcomm SoCs
>  	  to work in endpoint mode. The PCIe controller uses the DesignWare core
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index bac103faa523..3f557dd60c38 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>  obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>  obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
> +obj-$(CONFIG_PCIE_QCOM_COMMON) += pcie-qcom-common.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>  obj-$(CONFIG_PCIE_ROCKCHIP_DW_HOST) += pcie-dw-rockchip.o
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
> new file mode 100644
> index 000000000000..dc2120ec5fef
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
> @@ -0,0 +1,75 @@
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

Sort these alphabetically.

> +
> +#include "../../pci.h"
> +#include "pcie-designware.h"
> +#include "pcie-qcom-common.h"
> +
> +#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
> +		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
> +
> +int qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, struct icc_path **icc_mem_p)

This API can be used for other paths also in the future (like CPU-PCIe). So it
should accept the path name and directly return the 'struct icc_path' pointer.

> +{
> +	*icc_mem_p = devm_of_icc_get(pci->dev, "pcie-mem");
> +	if (IS_ERR_OR_NULL(icc_mem_p))
> +		return PTR_ERR(icc_mem_p);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pcie_common_icc_get_resource);
> +
> +int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem)
> +{
> +	int ret;
> +
> +	/*
> +	 * Some Qualcomm platforms require interconnect bandwidth constraints
> +	 * to be set before enabling interconnect clocks.
> +	 *
> +	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> +	 * for the pcie-mem path.
> +	 */
> +	ret = icc_set_bw(icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
> +	if (ret) {
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
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
> +	u32 offset, status;
> +	int speed, width;
> +	int ret;
> +
> +	if (!icc_mem)
> +		return;
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
> +	ret = icc_set_bw(icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> +	if (ret)
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",

'Failed to set bandwidth for PCIe-MEM interconnect path: %d\n'

- Mani

-- 
மணிவண்ணன் சதாசிவம்

