Return-Path: <linux-pci+bounces-6523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4865D8AD07B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 17:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E5B7B250B2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B7B152E05;
	Mon, 22 Apr 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXb653V/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02469152180;
	Mon, 22 Apr 2024 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799229; cv=none; b=hs0i3u2wKPsaxhzuuSOhS68RQ38l7SNUq1hc0CY0AE+qUxPnR5rzYbocJUmzWMVRRdphqAkmLeil//qki3RwH4Dzarve3t/xSBWznzCBunN1ApaIw0r4LwXEvXdnv6DI5xkpreXYjRre9CJ/vuTct9Z9bs0kgQu6Dpt8EZRqgro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799229; c=relaxed/simple;
	bh=8HaVfJKvqWGHvcxPN33NHmNUUwHk6gqR8TII4nLb7v8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7NSAPuEFJCpKq8OPq5K0qSKOXfh0o3DdjehbsDiN/6xL9OBpdhU3HZYXs69cJVJ5EjsLL4aky789Qct3PUdd62qqKlO3kRIHj+W1GG9MKE1slBXHSr7POHozI4DA9rJ0vlOEWe0cdY6rlH8mmkCchSVQ6izmHYGCYZL8ziq7kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXb653V/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82542C4AF08;
	Mon, 22 Apr 2024 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713799228;
	bh=8HaVfJKvqWGHvcxPN33NHmNUUwHk6gqR8TII4nLb7v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WXb653V/XRhG2uNOnv4FLgEEk/VB5ngoTOHIa0sbTdzBUgRUGCOr1C62BmuHNSuk4
	 9DfEue4HChucR70C+bi+IAZPdYFOULCLTKitm+rq64gq56+MV1p5EiPL5FchNgceJG
	 Xrz766qunLT3UfhVmp0MiH7DcyNrH3ISIDO7a5wux2LvoPbuzOt9lCJTpa7DQ43cDd
	 sJLtpw82v9/zQjI79PqSdmUMxr6gxUp/9jRQLM11OcKZ4Lbp71QPmgj3W3DsMp1ZZ7
	 PghdGYHuw7z9+ahjGXNzGY36mNsLSb3Lwed8LUjh2ojVk7ZhhKOlMkxDcMGC1IMTTW
	 jFwPe2kAicn4g==
Date: Mon, 22 Apr 2024 20:50:10 +0530
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
Subject: Re: [PATCH v3 3/3] PCI: qcom: Add rx margining settings for 16GT/s
Message-ID: <20240422152010.GH9775@thinkpad>
References: <20240419001013.28788-1-quic_schintav@quicinc.com>
 <20240419001013.28788-4-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240419001013.28788-4-quic_schintav@quicinc.com>

On Thu, Apr 18, 2024 at 05:09:36PM -0700, Shashank Babu Chinta Venkata wrote:

PCI: qcom: Add RX lane margining settings for 16 GT/s data rate

> Add rx lane margining settings for 16GT/s(GEN 4) data rate. These

RX

16 GT/s

> settings improve link stability while operating at high date rates
> and helps to improve signal quality.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h  | 18 ++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.c | 24 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  4 +++-
>  drivers/pci/controller/dwc/pcie-qcom.c        |  4 +++-
>  5 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ad771bb52d29..e8c48855143f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -203,6 +203,24 @@
>  
>  #define PCIE_PL_CHK_REG_ERR_ADDR			0xB28
>  
> +/*
> + * GEN4 lane margining register definitions

16 GT/s (GEN 4)

> + */
> +#define GEN4_LANE_MARGINING_1_OFF		0xb80
> +#define MARGINING_MAX_VOLTAGE_OFFSET(n)		FIELD_PREP(GENMASK(29, 24), n)
> +#define MARGINING_NUM_VOLTAGE_STEPS(n)		FIELD_PREP(GENMASK(22, 16), n)
> +#define MARGINING_MAX_TIMING_OFFSET(n)		FIELD_PREP(GENMASK(13, 8), n)
> +#define MARGINING_NUM_TIMING_STEPS(n)		FIELD_PREP(GENMASK(5, 0), n)
> +
> +#define GEN4_LANE_MARGINING_2_OFF		0xb84
> +#define MARGINING_IND_ERROR_SAMPLER(n)		FIELD_PREP(BIT(28), n)
> +#define MARGINING_SAMPLE_REPORTING_METHOD(n)	FIELD_PREP(BIT(27), n)
> +#define MARGINING_IND_LEFT_RIGHT_TIMING(n)	FIELD_PREP(BIT(26), n)
> +#define MARGINING_IND_UP_DOWN_VOLTAGE(n)	FIELD_PREP(BIT(25), n)
> +#define MARGINING_VOLTAGE_SUPPORTED(n)		FIELD_PREP(BIT(24), n)
> +#define MARGINING_MAXLANES(n)			FIELD_PREP(GENMASK(20, 16), n)
> +#define MARGINING_SAMPLE_RATE_TIMING(n)		FIELD_PREP(GENMASK(13, 8), n)
> +#define MARGINING_SAMPLE_RATE_VOLTAGE(n)	FIELD_PREP(GENMASK(5, 0), n)
>  /*
>   * iATU Unroll-specific register definitions
>   * From 4.80 core version the address translation will be made by unroll
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
> index a6f3eb4c3ee6..3279314ae78c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-common.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
> @@ -46,6 +46,30 @@ void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
>  }
>  EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_eq_settings);
>  
> +void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci)
> +{
> +	u32 reg;
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_1_OFF);
> +	reg = MARGINING_MAX_VOLTAGE_OFFSET(0x24) |

Same comment as previous patch. Are you doing it intentionally for some reason?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

