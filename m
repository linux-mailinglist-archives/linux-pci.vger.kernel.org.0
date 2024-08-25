Return-Path: <linux-pci+bounces-12168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084FD95E231
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 08:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213AD1C20BE6
	for <lists+linux-pci@lfdr.de>; Sun, 25 Aug 2024 06:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9302A1D6;
	Sun, 25 Aug 2024 06:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu97N3MD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C42207A;
	Sun, 25 Aug 2024 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724566176; cv=none; b=Wh/Uiic3GBqKNB3mnokuwvdyBa8naNNNWz5x3vaOMtYnfyYiiHeTA5G4vm9sLRJLAG5besRZD19/dp0NL6zgYkTqCjCrBX2HSeC21Csq3p9FU3DEE6PpY0K/2vt+WmmNtKTDP9F9Bg/xlOn41X+zzHQnTQcSx24dVCQsAmI1WRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724566176; c=relaxed/simple;
	bh=yMvpINQILHrBMgqZhN+ev45oSXl4Mu+d6EKpsnzamo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEKhvM0LqidY6aGMdogsnPRjS+fCV8OyibU8B0wskF/j5DswD5Ud+cHYT7UG28Hqpw3gt7jGzm9xMfYe1b0+OvNGlv9CfawAjfMWbY+sgLPkscQ1Bvbkg1gk2c4kgkrGMZGc7Jq0P1Ah8aLVnPVl7c+53BfwOpMnJyIJKK8/wgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu97N3MD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A494BC32782;
	Sun, 25 Aug 2024 06:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724566175;
	bh=yMvpINQILHrBMgqZhN+ev45oSXl4Mu+d6EKpsnzamo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hu97N3MDrNd8BStUsqpDNcq0X/iSZ+9GHNXJsmGtSKUFq2zk8ku22GdHXGPskN887
	 +ZT5cIzQiQBd1xwcR2+rNHlJsPgaYJHlAVGelIwqYi+qCy50maD2+FSnb9deUbujGU
	 YvxvXw7xcbOLQ8fy3j6pFqtOnrMV6hAU2zWauTqBML/Zzjei3XtFNdlTvPJm2/G94/
	 VxJ5zdGpr+8XDc5/xksOdDiMh8/LinNHtd8T6va7L/7T5kp6H2E1t4bRgwNDT9bCIO
	 KUIivTn52YDm/6ohyypPAw5nS/vVgY0tm4zDeSi42CD1fxMTQFFlih9gCJtBYdavW5
	 qW84xmd74Pl/g==
Date: Sun, 25 Aug 2024 11:39:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	quic_msarkar@quicinc.com, quic_kraravin@quicinc.com,
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
Message-ID: <20240825060926.jup7l47uo76gdvff@thinkpad>
References: <20240821170917.21018-2-quic_schintav@quicinc.com>
 <20240821173318.GA260075@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821173318.GA260075@bhelgaas>

On Wed, Aug 21, 2024 at 12:33:18PM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 21, 2024 at 10:08:42AM -0700, Shashank Babu Chinta Venkata wrote:
> > Refactor common code from RC(Root Complex) and EP(End Point)
> > drivers and move them to a common driver. This acts as placeholder
> > for common source code for both drivers, thus avoiding duplication.
> 
> Much of this seems to be replacing qcom_pcie_icc_opp_update() and
> qcom_pcie_ep_icc_update() with qcom_pcie_common_icc_update().
> 
> That seems worthwhile and it would be helpful if the commit log called
> that out so we'd know what to look for in the patch.
> 
> I think the qcom_pcie_common_icc_init() rework would be more
> understandable if it were in its own patch and not mixed in here.
> 
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
> > @@ -0,0 +1,88 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2015, 2021 Linaro Limited.
> > + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> > + *
> 
> Spurious blank line.
> 
> > + */
> 
> > +struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path)
> > +{
> > +	struct icc_path *icc_p;
> > +
> > +	icc_p = devm_of_icc_get(pci->dev, path);
> > +	return icc_p;
> 
>   return devm_of_icc_get(pci->dev, path);
> 
> > +}
> > +EXPORT_SYMBOL_GPL(qcom_pcie_common_icc_get_resource);
> > +
> > +int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc, u32 bandwidth)
> > +{
> > +	int ret;
> > +
> > +	ret = icc_set_bw(icc, 0, bandwidth);
> > +	if (ret) {
> > +		dev_err(pci->dev, "Failed to set interconnect bandwidth: %d\n",
> > +			ret);
> > +		return ret;
> > +	}
> 
> The callers also check and log similar messages.  I don't see the
> point.
> 
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(qcom_pcie_common_icc_init);
> 
> These both seem of dubious value.
> 
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
> 
> Do we need "-common" in the filename?  Seems like "pcie-qcom.h" would
> be enough.  I *hope* we don't someday need both a "pcie-qcom.h and a
> "pcie-qcom-common.h"; that seems like it would really be overkill.
> 

I suggested the -common suffix since pcie-qcom is historically meant for RC
driver. So creating a common header with that name will create confusion since
we have a separate EP driver.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

