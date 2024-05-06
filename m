Return-Path: <linux-pci+bounces-7104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE078BC8B7
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 09:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFE41F224BB
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 07:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47497140389;
	Mon,  6 May 2024 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOxpkOQJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1575F2942A;
	Mon,  6 May 2024 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714982194; cv=none; b=FZ72MH5sKwnYm9TV+xLiiC8GAaMB0agT/S2VvbQxYm/e5SX6XMf6ZcDahnHBeqzSkks2rwgHZ9C4OE1Q/Q7mVRrNl+qI2wyeGHHENgayU103N6BqUCxEq++3w0evWwOHuCW/5y1uk9ssDcXzAIZGENa6Qq41Gg5GrJp4PWjKpaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714982194; c=relaxed/simple;
	bh=PJq3zkTLcKGI5Yyb/qJMmtMjLyWmVB+1m2g2IYOZFok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giZaYQoAdgVrrSmA/0Cg92KWq57S5Vou3G43KQKuB1GiWPdRSNoe7MXzDJqw6KdBT+gUqwSxjVbGzyb40ev4h6zG4C81KALN5GZSsgdooZtmJHe/vGEtdVs6XKYJikopFjaOkIcJ+GSFW35xuRcQP7epaCnbjkWnDkZU7YGdlOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOxpkOQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892E7C116B1;
	Mon,  6 May 2024 07:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714982193;
	bh=PJq3zkTLcKGI5Yyb/qJMmtMjLyWmVB+1m2g2IYOZFok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOxpkOQJmrB/gA/J/WnV7gH6h0pUDWcf/tdh90HqRX8+rpS2g9OsovhNZwSChv3D/
	 1ERnsui4rslZ2xMQcrUBylK1qf0SLYS0v6UgpFEtXc8fZ69EHNiwS1zX42w51r0swU
	 hjmg0+9wTkXERxo+f+IZxAe0yuLInzm0MWNx+ozg9ADzibw2LmOb2AgFBImuaNYtSx
	 glZGjAnpZvwyxUg75PHJ2kXH+aGd8o5PivCCPPgm9ws/NPCKEdPnK5elGRI7+wtZFM
	 WUOB7VP27BGJSwXJ+wTrn2NfHYSxKbFmx29IH3iR1dOwzS4SnGlXQbV8oEUzgANFAj
	 3QBZdO/7sr9AA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s3tD7-000000007vO-3orH;
	Mon, 06 May 2024 09:56:33 +0200
Date: Mon, 6 May 2024 09:56:33 +0200
From: Johan Hovold <johan@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	manivannan.sadhasivam@linaro.org, andersson@kernel.org,
	agross@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org,
	quic_msarkar@quicinc.com, quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/3] PCI: qcom: Refactor common code
Message-ID: <ZjiNMQcC7OG5Pd5p@hovoldconsulting.com>
References: <20240501163610.8900-1-quic_schintav@quicinc.com>
 <20240501163610.8900-2-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

You can't claim copyright for just moving old code around. So drop this.

> + *
> + */

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
> new file mode 100644
> index 000000000000..da1760c7e164
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2015, 2021 Linaro Limited.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.

Same here.

> + */

Johan

