Return-Path: <linux-pci+bounces-4346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D543686E9E8
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 20:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F951C23277
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 19:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3931D3A8E3;
	Fri,  1 Mar 2024 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhADx1af"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD6420DCD;
	Fri,  1 Mar 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709322299; cv=none; b=ZEgcHIqd2+jM4oXnXEaOi5P/wVQno4kCnBpKVudOJbhJpUgLAD0cGz28+GMg6ROB0jlckLYa1mHFb87frA5yfDihAP7DYtbQ/VtXjK/j0HPeVE4+k3/GpPfcZ+koWS97enObSp/mhbAPAq6wvl9HWgkI5E4U29wrLkBEhx9j24o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709322299; c=relaxed/simple;
	bh=8lwYTHmcz1N3RNwv/Abs9wbTECfpsDj44DA5D9MMh9g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JnN6wkJKkHcxdkxgbGgWm+vQVvMj23jr6r77aDXueUbIJrO/qG9Fwl96nFAdtrPsGALLjij2JMbvCEpI2yXm2oAj1LOMTx0T3Y71kHGp0UdPSrQ/i2fVptWC6rNBQzXal5oBIZf0Rx0tse7+9DCIQPhrpMEFU8xorRYLjeBCEcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhADx1af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDEBC433F1;
	Fri,  1 Mar 2024 19:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709322298;
	bh=8lwYTHmcz1N3RNwv/Abs9wbTECfpsDj44DA5D9MMh9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QhADx1afMqH/uKdM+aDqalPjrFzmzQWyhj/ZacgFr/gMqeLhhU4OH/z3UhDO3V4Bq
	 y732d0Zc1y6/MAdHt4zE199vlFklIzicS1f3BxcVhuVMJ2/6y7BN99pMwqzaO50ID7
	 g8dCljTYocEx4eFOTSR9wRiIIRt9FPE5+HLbrd2OSY+JU9qlgn2cs61l18dYoZlOrT
	 lH4/CKDeTB1W0MAN+JyncS9g3XCI/tlKHTXnZXovWlKKWoCKt62hO8EFkQOabPAYtL
	 9MTQKQxkPBhyec4626FFP1b5avopg9+LTsJFe1IUHYGnwt/Mxf221oCPTtBtngortI
	 DMrhIQGWImpcw==
Date: Fri, 1 Mar 2024 13:44:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mani@kernel.org, quic_msarkar@quicinc.com,
	quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Josh Triplett <josh@joshtriplett.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 1/3] PCI: dwc: refactor common code
Message-ID: <20240301194456.GA405061@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301051220.20917-2-quic_schintav@quicinc.com>

On Thu, Feb 29, 2024 at 09:11:34PM -0800, Shashank Babu Chinta Venkata wrote:
> Refactor common code from RC(Root Complex) and EP(End Point)
> drivers and move them to a common repository. This acts as placeholder
> for common source code for both drivers avoiding duplication.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---
>  drivers/pci/controller/dwc/Kconfig         |  5 ++
>  drivers/pci/controller/dwc/Makefile        |  1 +
>  drivers/pci/controller/dwc/pcie-qcom-cmn.c | 85 ++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-cmn.h | 30 ++++++++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c  | 39 +---------
>  drivers/pci/controller/dwc/pcie-qcom.c     | 67 ++---------------
>  6 files changed, 133 insertions(+), 94 deletions(-)
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-cmn.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-cmn.h

Hmm.  I'm a little ambivalent about adding two new files.  Overall I
think I prefer the drivers that include both RC and EP mode in a
single source file because one file is easier to browse than four and
more things can be static.

A single file would also reduce quite a bit more duplication between
pcie-qcom.c and pcie-qcom-ep.c, e.g., register names and fields with
needlessly different names:

  #define AUX_PWR_DET                     BIT(4)  # pcie-qcom.c
  #define PARF_SYS_CTRL_AUX_PWR_DET       BIT(4)  # pcie-qcom-ep.c

I do see PCIE_QCOM is bool and PCIE_QCOM_EP is tristate, so that and
other considerations might make a single source file impractical.

> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
>  obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
> +obj-$(CONFIG_PCIE_QCOM_CMN) += pcie-qcom-cmn.o

If we have to have pcie-qcom-cmn.o, at least move this next to the
existing lines:

  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
  obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o

> +++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
> + * Copyright 2015, 2021 Linaro Limited.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + *

Spurious blank line.

> +int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem)

I don't see the value of adding "cmn" in the middle of the names.

> +{
> +	int ret = 0;
> +
> +	if (IS_ERR(pci))
> +		return PTR_ERR(pci);
> +
> +	icc_mem = devm_of_icc_get(pci->dev, "pcie-mem");
> +	if (IS_ERR(icc_mem))
> +		return PTR_ERR(icc_mem);
> +
> +	return ret;

No need for the "ret" variable since it's never assigned.  "return 0"
here would be easier to read.

> +int qcom_pcie_cmn_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem)
> +{
> +	int ret = 0;

Unnecessary initialization.

> +++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
> @@ -0,0 +1,30 @@
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
> +
> +#ifdef CONFIG_PCIE_QCOM_CMN

Why the #ifdef wrapper?  And why do we need the stubs when
CONFIG_PCIE_QCOM_CMN isn't defined?

> +#else
> +static inline int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem)
> +{
> +	return 0;
> +}

