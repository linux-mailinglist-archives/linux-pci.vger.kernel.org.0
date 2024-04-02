Return-Path: <linux-pci+bounces-5514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AFD894ADE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 07:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2F21C20FAF
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 05:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB1F18050;
	Tue,  2 Apr 2024 05:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIFWoRW2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AB018035;
	Tue,  2 Apr 2024 05:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712036022; cv=none; b=BKpU/HYuSoXZFVHXiAjvr2QXvQkDhoWgEo807rmZsyTTlPdT3mNIyXSMcKTPPpeykKU9ajWJzvWNv2IrCbQXepdwzQuUQN95fYgEUIMKvOAQINj4dyY51gbnNi6ruJo7vejwAqyVxvwqMTto9wWWynpc/EwwCKXA+UH6dvfXdac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712036022; c=relaxed/simple;
	bh=U8GocIyJ8JL27TlL8K2vIcTd1SxG/GH4sOWgtewPVd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ipzmggo0AiCICckJ1OQOmUpCV9jr7knucPlx5JdMrCvkwyhTwP/I9jg7b301/fpylUEvYkDwPulejaJW/l5jynQ87oY1F1J1ghvgPg7pgd1cZMKF5huRgGW9QTsN9nRES/MgVFOR70kxUKzAvWRzx+kQTC5gxcXCADKFLQjTVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIFWoRW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2614DC433C7;
	Tue,  2 Apr 2024 05:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712036021;
	bh=U8GocIyJ8JL27TlL8K2vIcTd1SxG/GH4sOWgtewPVd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PIFWoRW2gXP7c8uLZukF6x8hnwwzTQ+OEWDy1ES+2mfPMHWCKGXdzIRmlH//DSWvT
	 TS0ccMARxy4ohUXryUYONPi49dNJXimJxZWiMaSjnokqhUsWfE1wiHlrt9cIIbeQg8
	 K68siudlso5GckQKuXk4wIztje8QTAgxg4Y6UXFRED4R7pf1vfMyQRH5WqDLLOIga4
	 EWoJY/3DFhDy/LM1hmoS6oTNvm/HvxTkqbHWcv5uunogeALOw6sQjXve2gYUNDVW5s
	 AIV+KLuh7cnBNZF3doduBTZdA0M5bBgYzuuTJPjVZegNOpyLX5YbsxX5/dCyjZygdU
	 +VgROHZKd8dTg==
Date: Tue, 2 Apr 2024 11:03:32 +0530
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
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: qcom: Refactor common code
Message-ID: <20240402053332.GI2933@thinkpad>
References: <20240320071527.13443-1-quic_schintav@quicinc.com>
 <20240320071527.13443-2-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320071527.13443-2-quic_schintav@quicinc.com>

On Wed, Mar 20, 2024 at 12:14:45AM -0700, Shashank Babu Chinta Venkata wrote:
> Refactor common code from RC(Root Complex) and EP(End Point)
> drivers and move them to a common repository. This acts as placeholder

s/repository/driver

> for common source code for both drivers avoiding duplication.

'thus avoiding'

> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---
>  drivers/pci/controller/dwc/Kconfig         |  5 ++
>  drivers/pci/controller/dwc/Makefile        |  1 +
>  drivers/pci/controller/dwc/pcie-qcom-cmn.c | 81 ++++++++++++++++++++++

I'd prefer, pcie-qcom-common.c

>  drivers/pci/controller/dwc/pcie-qcom-cmn.h | 14 ++++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c  | 39 ++---------
>  drivers/pci/controller/dwc/pcie-qcom.c     | 67 +++---------------
>  6 files changed, 113 insertions(+), 94 deletions(-)
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-cmn.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-cmn.h
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 8afacc90c63b..41d2746edc5f 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -265,12 +265,16 @@ config PCIE_DW_PLAT_EP
>  	  order to enable device-specific features PCI_DW_PLAT_EP must be
>  	  selected.
>  
> +config PCIE_QCOM_CMN

I'd prefer, 'PCIE_QCOM_COMMON'.

> +	bool
> +
>  config PCIE_QCOM
>  	bool "Qualcomm PCIe controller (host mode)"
>  	depends on OF && (ARCH_QCOM || COMPILE_TEST)
>  	depends on PCI_MSI
>  	select PCIE_DW_HOST
>  	select CRC8
> +	select PCIE_QCOM_CMN
>  	help
>  	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
>  	  PCIe controller uses the DesignWare core plus Qualcomm-specific
> @@ -281,6 +285,7 @@ config PCIE_QCOM_EP
>  	depends on OF && (ARCH_QCOM || COMPILE_TEST)
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
> +	select PCIE_QCOM_CMN
>  	help
>  	  Say Y here to enable support for the PCIe controllers on Qualcomm SoCs
>  	  to work in endpoint mode. The PCIe controller uses the DesignWare core
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index bac103faa523..521572093ebf 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>  obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>  obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
> +obj-$(CONFIG_PCIE_QCOM_CMN) += pcie-qcom-cmn.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>  obj-$(CONFIG_PCIE_ROCKCHIP_DW_HOST) += pcie-dw-rockchip.o
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-cmn.c b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
> new file mode 100644
> index 000000000000..64fa412ec293
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
> + * Copyright 2015, 2021 Linaro Limited.

Copyright (c)

> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + */
> +
> +#include <linux/debugfs.h>

Why do you need this header in this patch?

> +#include <linux/pci.h>
> +#include <linux/interconnect.h>
> +
> +#include "../../pci.h"
> +#include "pcie-designware.h"
> +#include "pcie-qcom-cmn.h"
> +
> +#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
> +		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
> +
> +int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem)

qcom_pcie_common_icc_get?

> +{
> +	if (IS_ERR(pci))
> +		return PTR_ERR(pci);

Why this check is needed?

> +
> +	icc_mem = devm_of_icc_get(pci->dev, "pcie-mem");
> +	if (IS_ERR(icc_mem))
> +		return PTR_ERR(icc_mem);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pcie_cmn_icc_get_resource);
> +
> +int qcom_pcie_cmn_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem)

qcom_pcie_common_icc_init?

> +{
> +	int ret;
> +
> +	if (IS_ERR(pci))
> +		return PTR_ERR(pci);
> +

Again, why this is needed?

> +	if (IS_ERR(icc_mem))
> +		return PTR_ERR(icc_mem);
> +

If 'devm_of_icc_get' has failed previously we wouldn't reach here. And also,
there is no need to check for NULL since the ICC core already does that.

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
> +EXPORT_SYMBOL_GPL(qcom_pcie_cmn_icc_init);
> +
> +void qcom_pcie_cmn_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem)

qcom_pcie_common_icc_update?

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

You can keep the link check here since that should work for both RC and EP.

> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> +
> +	ret = icc_set_bw(icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> +	if (ret)
> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
> +			ret);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pcie_cmn_icc_update);
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-cmn.h b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
> new file mode 100644
> index 000000000000..845eda23ae59
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
> + * Copyright 2015, 2021 Linaro Limited.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/pci.h>
> +#include "../../pci.h"
> +#include "pcie-designware.h"

Again, headers should be included only if it is used in the same file itself.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

