Return-Path: <linux-pci+bounces-12730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB3B96B773
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 11:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAEA2848E7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F881CEEBC;
	Wed,  4 Sep 2024 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsSlsSsk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C70F1CEEBB;
	Wed,  4 Sep 2024 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443606; cv=none; b=umGoIkAXSv7dRxK4P/lDLgvzDKMbvAdNLpspdOf6DnrFf8pmjBeuTQU7KZ5vS+Jmtu0y945FM54tXzoP8KpYB/CHvsRERDZ2uyN7E/obFVp3XmDzwVWz/ezqLuMEm7BWtZd6aurWBoOTZXSHHDuAMuEHM1R1qM+cBXpcz7WIkPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443606; c=relaxed/simple;
	bh=Rs/7CNs57mYMKC518TOwDxf97qBOBf04kquglQP1lwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKXyY4t8vP1MX1WPY/BEF8amMSV8+I0bXT/fu6GtClcyDkUdF0GJ6akO6lJG1dB9pgdRJP7Y2hD52jwuHEyqGcnk+hYzboQgQEP7VESChP7N0X4CKOiiStIFTeBrM3IttDJJBTYkgI+JLr8OYcmDtY2mWKSu3LLSY+rznQ0xATU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsSlsSsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E849DC4CEC2;
	Wed,  4 Sep 2024 09:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725443606;
	bh=Rs/7CNs57mYMKC518TOwDxf97qBOBf04kquglQP1lwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsSlsSskbJHuC+h8APdYWUHWE27EWWoS5s+VzmxiB2D3IPWTRipWpIKtn5zyni497
	 hVP+Ox7LqqiXOGEFtPsrAJZdEExcCBqzCxaqqgOE3kpzKjfJRZsoFGT29mYI8m5Iqw
	 rZ0zCfCTVztes5x+XnObG6NHo9bJwDiCtpeflbGcddmKgwqEpCu6SF/qpHVPh9ni1W
	 ppDs8jvB+vds1Aih5gTRYLgyGZ/opjK/46+emlH4fin2rM9HKedQuMGGy+q3a8UKng
	 bPzCsVAgywe3ywpnlWsmkHQ8qY0/f+totvXZS/nscbccko+yJ9Z0oBge2FV1+Fh4PX
	 GGhZptjpW3lFg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1slmhq-000000002Dc-0ROQ;
	Wed, 04 Sep 2024 11:53:42 +0200
Date: Wed, 4 Sep 2024 11:53:42 +0200
From: Johan Hovold <johan@kernel.org>
To: manivannan.sadhasivam@linaro.org
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	abel.vesa@linaro.org, johan+linaro@kernel.org,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Subject: Re: [PATCH v6 4/4] PCI: qcom: Add RX margining settings for 16.0 GT/s
Message-ID: <ZtguJs128O-N07Eg@hovoldconsulting.com>
References: <20240904-pci-qcom-gen4-stability-v6-0-ec39f7ae3f62@linaro.org>
 <20240904-pci-qcom-gen4-stability-v6-4-ec39f7ae3f62@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-pci-qcom-gen4-stability-v6-4-ec39f7ae3f62@linaro.org>

On Wed, Sep 04, 2024 at 12:42:00PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> 
> Add RX lane margining settings for 16.0 GT/s (GEN 4) data rate. These
> settings improve link stability while operating at high date rates and
> helps to improve signal quality.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> [mani: dropped the code refactoring and minor changes]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h  | 18 ++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.c | 31 +++++++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  4 +++-
>  drivers/pci/controller/dwc/pcie-qcom.c        |  4 +++-
>  5 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 51744ad25575..f5be99731f7e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -209,6 +209,24 @@
>  
>  #define PCIE_PL_CHK_REG_ERR_ADDR			0xB28
>  
> +/*
> + * 16.0 GT/s (GEN4) lane margining register definitions

nit: Gen 4?

> + */
> +#define GEN4_LANE_MARGINING_1_OFF		0xb80

nit: upper case hex

> +#define MARGINING_MAX_VOLTAGE_OFFSET		GENMASK(29, 24)
> +#define MARGINING_NUM_VOLTAGE_STEPS		GENMASK(22, 16)
> +#define MARGINING_MAX_TIMING_OFFSET		GENMASK(13, 8)
> +#define MARGINING_NUM_TIMING_STEPS		GENMASK(5, 0)
> +
> +#define GEN4_LANE_MARGINING_2_OFF		0xb84

Same here

> +#define MARGINING_IND_ERROR_SAMPLER		BIT(28)
> +#define MARGINING_SAMPLE_REPORTING_METHOD	BIT(27)
> +#define MARGINING_IND_LEFT_RIGHT_TIMING		BIT(26)
> +#define MARGINING_IND_UP_DOWN_VOLTAGE		BIT(25)
> +#define MARGINING_VOLTAGE_SUPPORTED		BIT(24)
> +#define MARGINING_MAXLANES			GENMASK(20, 16)
> +#define MARGINING_SAMPLE_RATE_TIMING		GENMASK(13, 8)
> +#define MARGINING_SAMPLE_RATE_VOLTAGE		GENMASK(5, 0)
>  /*
>   * iATU Unroll-specific register definitions
>   * From 4.80 core version the address translation will be made by unroll
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
> index dc7d93db9dc5..99b75e7f085d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-common.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
> @@ -43,3 +43,34 @@ void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
>  	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
>  }
>  EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_eq_settings);
> +
> +void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci)

I'd try to find a shorter symbol name here, "settings" seems redundant
after "set". Perhaps just

	qcom_pcie_common_enable_lane_margining()

or

	qcom_pcie_common_enable_16gt_lane_margining()?

if these settings are indeed specific to 16 GT/s. But perhaps it's
better to let the helper honour pci->max_link_speed if different
settings will later be needed for higher speeds:

	if (pcie_link_speed[pci->max_link_speed] >= PCIE_SPEED_16_0GT)
		qcom_pcie_common_enable_lane_margining(pci)

>  void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
> +void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci);

And maybe something similar for the eq settings for symmetry.

Johan

