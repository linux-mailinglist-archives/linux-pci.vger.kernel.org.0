Return-Path: <linux-pci+bounces-10196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B9E92F6BF
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 10:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3F4283F5D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 08:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C248142648;
	Fri, 12 Jul 2024 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDSkba7k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1174813D8B5;
	Fri, 12 Jul 2024 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720771970; cv=none; b=B7RkK0LTA0TEndQV8o0Ky0xCOWOBNnuu2eOACGxdQFd9in++4OaEGIzcb2J0U9KaARs9rW65eIBpfXziccJaf1S2cQNc5EbuyV+emNUSl68Ibi5Wd/EkJ2Ep67VtgB7QxA96vxxd7Ez2rS1Q0421ui4ITjZpfOZYb/bo+ppmT2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720771970; c=relaxed/simple;
	bh=pl962O07J84GPSr7I9l2kmg+t+2S4NQknB/JG5E9PTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrK4FSIOzb3MKE19250FW6n+9iZGATlHVjUNjVH46L/BCklsYd+uNu9tODKXkmByID8KpkJEThihwKu2OU0LM+4uzk4vffdvbed2cOlG9x4uydpW4et5S5AznKkmx42GEASGGu6KyWhkYtKZlxEQUdgO6dsI80e/hEBpp95cdtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDSkba7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACE1C3277B;
	Fri, 12 Jul 2024 08:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720771969;
	bh=pl962O07J84GPSr7I9l2kmg+t+2S4NQknB/JG5E9PTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDSkba7ksTL87OOSTOIqxY1FSlQGxS82D0mOLyaiwpO0QLMuzsnNiI9Kovc4xxGNo
	 wRayH1lMwMLWrXASRBb/O4RrgDDWIS5AylU7HGeDzMVDDKBwNpe6jw9tN+JN64ghC0
	 HMMeVQvjtWbZ2jj6ihV97TEoLqsYr4SvB3M0dTIm1NyLUBxidMzBHYg3UDUhGFoF10
	 3bvvfUJdTKsBY4Bruaw/C5tRr2mft2nWqWwkWJvZa98HLezNlL4Nerd5Y3ZKQpr/Ad
	 U61LKZvqnhl20A3K/bRp5PpJMGrgGn/ZicClGZc0udPTDrIt7u7iHR84135+/nTgYY
	 z7EDkhZjDCvrQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sSBOZ-000000006Eg-1fKg;
	Fri, 12 Jul 2024 10:12:48 +0200
Date: Fri, 12 Jul 2024 10:12:47 +0200
From: Johan Hovold <johan@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	mani@kernel.org, quic_msarkar@quicinc.com,
	quic_kraravin@quicinc.com,
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
Message-ID: <ZpDlf5xD035x2DqL@hovoldconsulting.com>
References: <20240320071527.13443-1-quic_schintav@quicinc.com>
 <20240320071527.13443-2-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320071527.13443-2-quic_schintav@quicinc.com>

On Wed, Mar 20, 2024 at 12:14:45AM -0700, Shashank Babu Chinta Venkata wrote:
> Refactor common code from RC(Root Complex) and EP(End Point)

Please add a space before the open parentheses above, these are not
function calls.

> drivers and move them to a common repository. This acts as placeholder
> for common source code for both drivers avoiding duplication.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>

> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
> + * Copyright 2015, 2021 Linaro Limited.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + */
> +
> +#include <linux/debugfs.h>

Not needed.

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
> +{
> +	if (IS_ERR(pci))
> +		return PTR_ERR(pci);

Not needed.

> +
> +	icc_mem = devm_of_icc_get(pci->dev, "pcie-mem");
> +	if (IS_ERR(icc_mem))
> +		return PTR_ERR(icc_mem);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pcie_cmn_icc_get_resource);

So this series was clearly never tested properly as the above function
will leave the driver's icc_mem path uninitialised. You're passing in a
NULL pointer by value and then update your local variable, which
obviously has no effect for the caller.

This means that all later icc operation become no-ops, which crashes
machine like the Lenovo ThinkPad X13s and the x1e80100 CRD that depends
on having a non-zero vote before enabling clocks at probe.

How did this go unnoticed? I can only assume you did not test this
series (in isolation) before posting?

> +int qcom_pcie_cmn_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem)
> +{
> +	int ret;
> +
> +	if (IS_ERR(pci))
> +		return PTR_ERR(pci);
> +
> +	if (IS_ERR(icc_mem))
> +		return PTR_ERR(icc_mem);

Neither is needed.

> +
> +	/*
> +	 * Some Qualcomm platforms require interconnect bandwidth constraints
> +	 * to be set before enabling interconnect clocks.
> +	 *
> +	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
> +	 * for the pcie-mem path.
> +	 */

I'm not sure about hiding this away in a separate compilation unit. The
above comments makes sense in the driver, where it's easy to see that
the icc is initialised and the vote added before enabling clocks.

Also these helpers are so small it may not even be worth trying to
refactor them (all).

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
> +

Compile guards missing.

> +int qcom_pcie_cmn_icc_get_resource(struct dw_pcie *pci, struct icc_path *icc_mem);
> +int qcom_pcie_cmn_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem);
> +void qcom_pcie_cmn_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);

Johan

