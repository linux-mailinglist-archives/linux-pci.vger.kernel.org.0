Return-Path: <linux-pci+bounces-11974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC5C95A3EE
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 19:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2B51F230BE
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD94A1509B0;
	Wed, 21 Aug 2024 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkJ6e/Pe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69B13BAC2;
	Wed, 21 Aug 2024 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261600; cv=none; b=J6aRpQWJqLk4e4SibBBX5fxuQKgT8ixxta9m5UE7dnKfq7a3AKkU3Ch+XBpwtGZ256+LUiarzJz4nsg/+nSHRj88sEZgdFm2sMSvfaMgkEtayVf9lmzNiHdvI8qDsbf5ZQWPVTCEXREmqAbRLBWa67ZbIi71cpkHqghkJGwWBl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261600; c=relaxed/simple;
	bh=qmp6M+GC6HC1KEys7IlErpZQ/40MKJuWueQq7xQBifM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IgkIYggqyD8326LAB3geNnN0/w2egdCqplSPV3cZmgcdz8FaXvr5qScjMV+EiP6tLuQFfAT2ZHYXRIy9GKjym6WSkh1H1NsF2T3tcJTJUEj64Iwfo4ciq2w/Ew5Mcc/MdsB7kwCcAkS6Hg50fJE/L+2y/9XsyG9vuIUZYE/FOy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkJ6e/Pe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4DCC32781;
	Wed, 21 Aug 2024 17:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724261600;
	bh=qmp6M+GC6HC1KEys7IlErpZQ/40MKJuWueQq7xQBifM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MkJ6e/PeKtpSJSSRzfLkTyA5Ibc3waQHdfAlOOwseejeU7iIY8DVvt91KYE8JdFW+
	 ONnng2wt52kZL9Dth0ZN1kqoO33SkW0agSYntUuYI3RsiZbjTQynFh8byFv8yPA4CU
	 gToJDZjqCmNhjgl5pzPKd/564fkGsjYFB28F+UTLpM8Mw7kt0hE/pDqr9N3emggAGb
	 0qtUPMSqbk+q39dVxlGdAjz2Wga1gh9J1VhPhtsbP1BbR11O5IkOoWgxZ/AxSfsvKz
	 UMCDu8MFoKjgKfLVN3SgaKblL97UFdBC6YIJxhpDQTLdjsYigGvUZHN3CNTdCUFdEw
	 Yh4dTNh3223Vw==
Date: Wed, 21 Aug 2024 12:33:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20240821173318.GA260075@bhelgaas>
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
> drivers and move them to a common driver. This acts as placeholder
> for common source code for both drivers, thus avoiding duplication.

Much of this seems to be replacing qcom_pcie_icc_opp_update() and
qcom_pcie_ep_icc_update() with qcom_pcie_common_icc_update().

That seems worthwhile and it would be helpful if the commit log called
that out so we'd know what to look for in the patch.

I think the qcom_pcie_common_icc_init() rework would be more
understandable if it were in its own patch and not mixed in here.

> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2015, 2021 Linaro Limited.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + *

Spurious blank line.

> + */

> +struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path)
> +{
> +	struct icc_path *icc_p;
> +
> +	icc_p = devm_of_icc_get(pci->dev, path);
> +	return icc_p;

  return devm_of_icc_get(pci->dev, path);

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

The callers also check and log similar messages.  I don't see the
point.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pcie_common_icc_init);

These both seem of dubious value.

> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h

Do we need "-common" in the filename?  Seems like "pcie-qcom.h" would
be enough.  I *hope* we don't someday need both a "pcie-qcom.h and a
"pcie-qcom-common.h"; that seems like it would really be overkill.

Bjorn

