Return-Path: <linux-pci+bounces-8076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A2F8D4DB8
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 16:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E695286765
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 14:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3844617C230;
	Thu, 30 May 2024 14:16:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471317623B;
	Thu, 30 May 2024 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078588; cv=none; b=uFgwtoZWrf5mb7xCiGC0nyP5XfFo1XtCuPJaVYalzqye3p8fUcGreojjETLEvNg398fBBvcKgYWd7DRkT7CVEEKSmePymN4Bp4Df9MJG0tFM+hxBHw8y1ikaQJs7X5pKsVOZmzXdGJhF2Eb2W09BKcGVtGVfjvCHKa41uvNjazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078588; c=relaxed/simple;
	bh=XL8MGduAVbwn1gpxi4V0hN5u03u0LCLTzNM+RF9zS3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgBVfpwzMDh4rZz81MYFXj5+B0xVsPXD8KbAsg/VEsIp1NUSRzY0zc8eUeJTeyoaCqCsZG2TSQdVhetcMVX/STbkI5z7D8HmFmRR7djjfOhKFPFgySYBvyrPpzerPAKSU0xOtwrk0CSaKu4BTw6j3VTJEYh8byERYZtTUimiy5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBFDC2BBFC;
	Thu, 30 May 2024 14:16:22 +0000 (UTC)
Date: Thu, 30 May 2024 19:46:18 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
	mani@kernel.org, quic_msarkar@quicinc.com,
	quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/3] PCI: qcom: Refactor common code
Message-ID: <20240530141618.GB2770@thinkpad>
References: <20240501163610.8900-1-quic_schintav@quicinc.com>
 <20240501163610.8900-2-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501163610.8900-2-quic_schintav@quicinc.com>

On Wed, May 01, 2024 at 09:35:32AM -0700, Shashank Babu Chinta Venkata wrote:
> Refactor common code from RC(Root Complex) and EP(End Point)
> drivers and move them to a common driver. This acts as placeholder
> for common source code for both drivers, thus avoiding duplication.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |  5 ++
>  drivers/pci/controller/dwc/Makefile           |  1 +
>  drivers/pci/controller/dwc/pcie-qcom-common.c | 76 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.h | 12 +++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     | 39 +---------
>  drivers/pci/controller/dwc/pcie-qcom.c        | 69 +++--------------
>  6 files changed, 108 insertions(+), 94 deletions(-)
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
> index 000000000000..228d9eec0222
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
> @@ -0,0 +1,76 @@
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
> +
> +#include "../../pci.h"
> +#include "pcie-designware.h"
> +#include "pcie-qcom-common.h"
> +
> +#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
> +		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
> +
> +struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path)
> +{
> +	struct icc_path *icc_mem_p;
> +
> +	icc_mem_p = devm_of_icc_get(pci->dev, path);

Just 'icc_path' since we will be voting for 'cpu-pcie' path as well.

Also just return directly since there are error checks performed by the callers.

> +	if (IS_ERR_OR_NULL(icc_mem_p))
> +		return PTR_ERR(icc_mem_p);
> +	return icc_mem_p;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pcie_common_icc_get_resource);
> +
> +int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem)

You need to take the bandwidth as an argument since the bandwidth varies between
'cpu-pcie' and 'pcie-mem'.

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

s/icc_mem/icc_path

- Mani

-- 
மணிவண்ணன் சதாசிவம்

