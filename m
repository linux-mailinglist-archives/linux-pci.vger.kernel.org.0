Return-Path: <linux-pci+bounces-4456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078F387083E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 18:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD851C2121F
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB72D612E3;
	Mon,  4 Mar 2024 17:28:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F2D1756D;
	Mon,  4 Mar 2024 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573300; cv=none; b=IytnhoQpWLYJh6cOzUlm9MK0+DnsqCsWblv+lKHO5/c1rYiIdjzfL0STnxP5NqJqq7/onKhlt2l/b4elFxoo/NMoJruUMzdPxO4yUNaMIHiq2bbKvHXkqvZsviz4J8sYirgDfzWr10AxwXxXTQbWYF5cxsTlFllMvjWfVaoZ534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573300; c=relaxed/simple;
	bh=bgaXc6UbtMvm6q7rNQwEibfcHRDpfZN+XPlFzPFE/74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YelKcOiIxk5wflJcTJKhzZC+4G2xOOkU3cskOczcoOcCQC7EgpJ8e1xnkFGECu6E0OxmkmRvEb8d6Ph/NEs6QoVPHw0Z6ueZhQsBHRjLALIxJOEyqgxIrh1JorD6qqyHkjUjTGKfJn9saxdCHvn/ySVVdKYa84TvTYK3JcKfg+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873C2C433F1;
	Mon,  4 Mar 2024 17:28:13 +0000 (UTC)
Date: Mon, 4 Mar 2024 22:58:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mani@kernel.org, quic_msarkar@quicinc.com,
	quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Josh Triplett <josh@joshtriplett.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 1/3] PCI: dwc: refactor common code
Message-ID: <20240304172809.GA31079@thinkpad>
References: <20240301051220.20917-2-quic_schintav@quicinc.com>
 <20240301194456.GA405061@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240301194456.GA405061@bhelgaas>

On Fri, Mar 01, 2024 at 01:44:56PM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 29, 2024 at 09:11:34PM -0800, Shashank Babu Chinta Venkata wrote:
> > Refactor common code from RC(Root Complex) and EP(End Point)
> > drivers and move them to a common repository. This acts as placeholder
> > for common source code for both drivers avoiding duplication.
> > 
> > Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig         |  5 ++
> >  drivers/pci/controller/dwc/Makefile        |  1 +
> >  drivers/pci/controller/dwc/pcie-qcom-cmn.c | 85 ++++++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-qcom-cmn.h | 30 ++++++++
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c  | 39 +---------
> >  drivers/pci/controller/dwc/pcie-qcom.c     | 67 ++---------------
> >  6 files changed, 133 insertions(+), 94 deletions(-)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-cmn.c
> >  create mode 100644 drivers/pci/controller/dwc/pcie-qcom-cmn.h
> 
> Hmm.  I'm a little ambivalent about adding two new files.  Overall I
> think I prefer the drivers that include both RC and EP mode in a
> single source file because one file is easier to browse than four and
> more things can be static.
> 
> A single file would also reduce quite a bit more duplication between
> pcie-qcom.c and pcie-qcom-ep.c, e.g., register names and fields with
> needlessly different names:
> 
>   #define AUX_PWR_DET                     BIT(4)  # pcie-qcom.c
>   #define PARF_SYS_CTRL_AUX_PWR_DET       BIT(4)  # pcie-qcom-ep.c
> 
> I do see PCIE_QCOM is bool and PCIE_QCOM_EP is tristate, so that and
> other considerations might make a single source file impractical.
> 

Yeah, we explored that option while adding the EP driver and it didn't look
feasible.

- Mani

> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -27,6 +27,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
> >  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
> >  obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
> >  obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
> > +obj-$(CONFIG_PCIE_QCOM_CMN) += pcie-qcom-cmn.o
> 
> If we have to have pcie-qcom-cmn.o, at least move this next to the
> existing lines:
> 
>   obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>   obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
> 
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
> > @@ -0,0 +1,85 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
> > + * Copyright 2015, 2021 Linaro Limited.
> > + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> > + *
> 
> Spurious blank line.
> 
> > +int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem)
> 
> I don't see the value of adding "cmn" in the middle of the names.
> 
> > +{
> > +	int ret = 0;
> > +
> > +	if (IS_ERR(pci))
> > +		return PTR_ERR(pci);
> > +
> > +	icc_mem = devm_of_icc_get(pci->dev, "pcie-mem");
> > +	if (IS_ERR(icc_mem))
> > +		return PTR_ERR(icc_mem);
> > +
> > +	return ret;
> 
> No need for the "ret" variable since it's never assigned.  "return 0"
> here would be easier to read.
> 
> > +int qcom_pcie_cmn_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem)
> > +{
> > +	int ret = 0;
> 
> Unnecessary initialization.
> 
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
> > + * Copyright 2015, 2021 Linaro Limited.
> > + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> > + */
> > +
> > +#include <linux/pci.h>
> > +#include "../../pci.h"
> > +#include "pcie-designware.h"
> > +
> > +#ifdef CONFIG_PCIE_QCOM_CMN
> 
> Why the #ifdef wrapper?  And why do we need the stubs when
> CONFIG_PCIE_QCOM_CMN isn't defined?
> 
> > +#else
> > +static inline int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem)
> > +{
> > +	return 0;
> > +}

-- 
மணிவண்ணன் சதாசிவம்

