Return-Path: <linux-pci+bounces-8078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF818D4E01
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 16:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EBE1F24088
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 14:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3192017623E;
	Thu, 30 May 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jky/1389"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ADB1E4AD;
	Thu, 30 May 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079547; cv=none; b=fdbCf1scnH39uyJL2HjXkordYTlFEZuXsjQH249uRWjh3Yb6hKLX8RlLwGc3OwUTdnfYoXCCh20uUp3Cp9KopaTDYJmsARSxHT6/xrE3wyR0sn7dtG2dYIacTJQh/C2fU8w/4bXzrgZNjuWjwQDiflSGOA9BHinBngSrsfFfiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079547; c=relaxed/simple;
	bh=nVfWp0HTLD9YENOnXegaAeepK/FEFy8Sl+NJ4O9Z7TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUi3+Z39sZRB42j9JJqNuzy3l+94DTZSon0I73EqwrOx/VFpyeeRM5JjDqs13f9tq0Ff79jTgzrPSHcZ0Av916PjO7mv0su8G36bwoDpa8BYINiP4MqvfCeAMV6vHcWqOBqc+7RL4+I2rhtVgS8B1uuHIell6E/fTr9Z6If/Tk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jky/1389; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F46BC2BBFC;
	Thu, 30 May 2024 14:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717079546;
	bh=nVfWp0HTLD9YENOnXegaAeepK/FEFy8Sl+NJ4O9Z7TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jky/1389DT6u8WjsQqXGwvJGHEaUSatLhHfxkRgofoNIFNUc/7j+iILhaQ/MG6Y2R
	 sEpmTEhZhtWkawjXbEgTXcxrge0UD/opQctE3ZbMb5zQuqK6uP6M+RAfFwebj3sEgo
	 Un/iAc+E8/FC+9LMGuWUUqpiPRUaV+Emtf1YJ4w3KZmpsX7zYqXWvsBRqvxusRTxnF
	 Gvnwvl2wrwiZN3vA3GuvECYu+8oaHZukSGSDPg1s5H9ZbJwWB2Gg0evYBTGsBJ9Wcb
	 8qNKdqt/++mX8q8bJREGG+PGVSRW0TVnqlKdTaupg/nrEBWgaBRCBFBVUwr6UbNbqq
	 UdojqIPkyyHBg==
Date: Thu, 30 May 2024 20:02:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	manivannan.sadhasivam@linaro.org, andersson@kernel.org,
	agross@kernel.org, konrad.dybcio@linaro.org,
	quic_msarkar@quicinc.com, quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 3/3] PCI: qcom: Add RX margining settings for 16 GT/s
Message-ID: <20240530143217.GD2770@thinkpad>
References: <20240501163610.8900-1-quic_schintav@quicinc.com>
 <20240501163610.8900-4-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501163610.8900-4-quic_schintav@quicinc.com>

On Wed, May 01, 2024 at 09:35:34AM -0700, Shashank Babu Chinta Venkata wrote:
> Add RX lane margining settings for 16 GT/s(GEN 4) data rate. These
> settings improve link stability while operating at high date rates
> and helps to improve signal quality.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware.h  | 18 +++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.c | 31 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  4 ++-
>  drivers/pci/controller/dwc/pcie-qcom.c        |  4 ++-
>  5 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ed0045043847..343450c04e05 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -203,6 +203,24 @@
>  
>  #define PCIE_PL_CHK_REG_ERR_ADDR			0xB28
>  
> +/*
> + * 16 GT/s (GEN4) lane margining register definitions
> + */
> +#define GEN4_LANE_MARGINING_1_OFF		0xb80
> +#define MARGINING_MAX_VOLTAGE_OFFSET		GENMASK(29, 24)
> +#define MARGINING_NUM_VOLTAGE_STEPS		GENMASK(22, 16)
> +#define MARGINING_MAX_TIMING_OFFSET		GENMASK(13, 8)
> +#define MARGINING_NUM_TIMING_STEPS		GENMASK(5, 0)
> +
> +#define GEN4_LANE_MARGINING_2_OFF		0xb84
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
> index 16c277b2e9d4..fe6f7dde5d8c 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-common.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
> @@ -53,6 +53,37 @@ void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
>  }
>  EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_eq_settings);
>  
> +void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci)
> +{
> +	u32 reg;
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_1_OFF);
> +	reg &= ~(MARGINING_MAX_VOLTAGE_OFFSET |
> +		MARGINING_NUM_VOLTAGE_STEPS |
> +		MARGINING_MAX_TIMING_OFFSET |
> +		MARGINING_NUM_TIMING_STEPS);
> +	reg |= FIELD_PREP(MARGINING_MAX_VOLTAGE_OFFSET, 0x24) |
> +		FIELD_PREP(MARGINING_NUM_VOLTAGE_STEPS, 0x78) |
> +		FIELD_PREP(MARGINING_MAX_TIMING_OFFSET, 0x32) |
> +		FIELD_PREP(MARGINING_NUM_TIMING_STEPS, 0x10);
> +	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_1_OFF, reg);
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_2_OFF);
> +	reg |= MARGINING_IND_ERROR_SAMPLER |
> +		MARGINING_SAMPLE_REPORTING_METHOD |
> +		MARGINING_IND_LEFT_RIGHT_TIMING |
> +		MARGINING_VOLTAGE_SUPPORTED;
> +	reg &= ~(MARGINING_IND_UP_DOWN_VOLTAGE |
> +		MARGINING_MAXLANES |
> +		MARGINING_SAMPLE_RATE_TIMING |
> +		MARGINING_SAMPLE_RATE_VOLTAGE);
> +	reg |= FIELD_PREP(MARGINING_MAXLANES, pci->num_lanes) |
> +		FIELD_PREP(MARGINING_SAMPLE_RATE_TIMING, 0x3f) |
> +		FIELD_PREP(MARGINING_SAMPLE_RATE_VOLTAGE, 0x3f);
> +	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_2_OFF, reg);
> +}
> +EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_rx_margining_settings);
> +
>  struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path)
>  {
>  	struct icc_path *icc_mem_p;
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
> index 5c01f6c18b3b..c7eb87aa0677 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-common.h
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
> @@ -11,3 +11,4 @@ struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const ch
>  int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem);
>  void qcom_pcie_common_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
>  void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
> +void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci);
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 7940222d35f6..2aea78da9c5b 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -438,8 +438,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  		goto err_disable_resources;
>  	}
>  
> -	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
> +	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT) {
>  		qcom_pcie_common_set_16gt_eq_settings(pci);
> +		qcom_pcie_common_set_16gt_rx_margining_settings(pci);
> +	}
>  
>  	/*
>  	 * The physical address of the MMIO region which is exposed as the BAR
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 525942f2cf98..9b3d7729b34b 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -263,8 +263,10 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>  
> -	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
> +	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT) {
>  		qcom_pcie_common_set_16gt_eq_settings(pci);
> +		qcom_pcie_common_set_16gt_rx_margining_settings(pci);
> +	}
>  
>  	/* Enable Link Training state machine */
>  	if (pcie->cfg->ops->ltssm_enable)
> -- 
> 2.43.2
> 

-- 
மணிவண்ணன் சதாசிவம்

