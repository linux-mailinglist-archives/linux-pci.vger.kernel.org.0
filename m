Return-Path: <linux-pci+bounces-30630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67634AE88F3
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 17:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1FC3B7629
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 15:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482DE2BDC11;
	Wed, 25 Jun 2025 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3hQVCh/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB726A0A7;
	Wed, 25 Jun 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867125; cv=none; b=AQJLL/t7he0QJSDjaXxQoeooh/58jSLmLUfVOSCsQPguHsOx84DwRJ0tx+Fxiw2x64O02ikx7wSJihcIFTqpf29tSFZkajxTGtui/r+eFvSeGp5PnxXqB7UWTofOzGXtxdQy9KxqtyOoQq6rmx3hCypU6m+8TDKhzkrSQQ5SeTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867125; c=relaxed/simple;
	bh=D86EJE+46L/7mawYbJNG86v24Im/NiRYBeI4AnD8EQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A57nZbpzEgRAviM7GLy8qzzYX0Tqc9QENscogwE37QLtONLoCXjnN8DhpRj5YIw3VC1Tdrk5FyY2X8EssP1ZEkrl2/6uHY/n0rxecrd/1570GJ8IPYTj2akRTtM1I1Ao1bmXRACSKZ6LT5h+OUEUWiaHD9sAI+sGlCNatbMrN7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3hQVCh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65706C4CEEB;
	Wed, 25 Jun 2025 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750867124;
	bh=D86EJE+46L/7mawYbJNG86v24Im/NiRYBeI4AnD8EQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N3hQVCh/66qpNUimTd+Mb047vi7Jnu+csvc1JVj2vp7Y4ikcMTp0K1OSn5ZiZXIkE
	 klCM+NZ366LMrcRDTdvQZKpWXIUp48xXEmHJfFYe1Q+heVjiQwYcUrHJvQ73kWJ3e1
	 qfB0/tQ7/aIh/DrGfqNxk9hDlu4B1+BjUqBVX6H1EYtBy8gNeXRTfseac7SHCZqEPx
	 998A5zBhEbslHVUBCKqZkr40PFQoCl2KEvPCmgsOOOoMs695mWRsiZkhcqbO3iqNu6
	 SLvVZgmJ61kQ/wRlgQr8PRBXF+M1jzLukXT5gawCBVx+ufi2NUWjaGSHAH3wGhcmLz
	 V8HdTMxSiwyUA==
Date: Wed, 25 Jun 2025 09:58:40 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 1/3] PCI: qcom: Add equalization settings for 8.0 GT/s
Message-ID: <uakd5br4e5l24xmb6rxqs2drlt3fcmemfjilxo7ozph6vysjzs@ag3wjtic3qfm>
References: <20250625085801.526669-1-quic_ziyuzhan@quicinc.com>
 <20250625085801.526669-2-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625085801.526669-2-quic_ziyuzhan@quicinc.com>

On Wed, Jun 25, 2025 at 04:57:59PM +0800, Ziyue Zhang wrote:
> Add lane equalization setting for 8.0 GT/s to enhance link stability and
> aviod AER Correctable Errors reported on some platforms (eg. SA8775P).
> 
> 8.0 GT/s and 16.0 GT/s require the same equalization setting. This
> setting is programmed into a group of shadow registers, which can be
> switched to configure equalization for different speeds by writing 00b,
> 01b to `RATE_SHADOW_SEL`.
> 
> Hence program equalization registers in a loop using link speed as index,
> so that equalization setting can be programmed for both 8.0 GT/s and
> 16.0 GT/s.
> 
> Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 -
>  drivers/pci/controller/dwc/pcie-qcom-common.c | 55 +++++++++++--------
>  drivers/pci/controller/dwc/pcie-qcom-common.h |  2 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +-
>  drivers/pci/controller/dwc/pcie-qcom.c        |  6 +-
>  5 files changed, 38 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ce9e18554e42..388306991467 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -127,7 +127,6 @@
>  #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
> -#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT	0x1
>  
>  #define GEN3_EQ_CONTROL_OFF			0x8A8
>  #define GEN3_EQ_CONTROL_OFF_FB_MODE		GENMASK(3, 0)
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
> index 3aad19b56da8..ed466496f077 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-common.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
> @@ -8,9 +8,11 @@
>  #include "pcie-designware.h"
>  #include "pcie-qcom-common.h"
>  
> -void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
> +void qcom_pcie_common_set_equalization(struct dw_pcie *pci)
>  {
>  	u32 reg;
> +	u16 speed, max_speed = PCIE_SPEED_16_0GT;
> +	struct device *dev = pci->dev;
>  
>  	/*
>  	 * GEN3_RELATED_OFF register is repurposed to apply equalization
> @@ -19,32 +21,37 @@ void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
>  	 * determines the data rate for which these equalization settings are
>  	 * applied.
>  	 */
> -	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> -	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> -	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> -	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
> -			  GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT);
> -	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
> +	if (pcie_link_speed[pci->max_link_speed] < PCIE_SPEED_32_0GT)
> +		max_speed = pcie_link_speed[pci->max_link_speed];

So the logic here is that you want to limit the max_speed to < 32 GT/s because
you are not sure if 32 GT/s or more would require the same settings?

If so, why can't you just simply bail out early if the link speed > 16 GT/s and
just use pci->max_link_speed directly? Right now, 32 GT/s or more would be
skipped implicitly because you have initialized max_speed to PCIE_SPEED_16_0GT.

- Mani

>  
> -	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
> -	reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
> -		GEN3_EQ_FMDC_N_EVALS |
> -		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
> -		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
> -	reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
> -		FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
> -		FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
> -		FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
> -	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
> +	for (speed = PCIE_SPEED_8_0GT; speed <= max_speed; ++speed) {
> +		reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +		reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +		reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> +		reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
> +			  speed - PCIE_SPEED_8_0GT);
> +		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
>  
> -	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> -	reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
> -		GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
> -		GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
> -		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> -	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
> +		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
> +		reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
> +			GEN3_EQ_FMDC_N_EVALS |
> +			GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
> +			GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
> +		reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
> +			FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
> +			FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
> +			FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
> +		dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
> +
> +		reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +		reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
> +			GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
> +			GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
> +			GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> +		dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
> +	}
>  }
> -EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_equalization);
> +EXPORT_SYMBOL_GPL(qcom_pcie_common_set_equalization);
>  
>  void qcom_pcie_common_set_16gt_lane_margining(struct dw_pcie *pci)
>  {
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
> index 7d88d29e4766..7f5ca2fd9a72 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-common.h
> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
> @@ -8,7 +8,7 @@
>  
>  struct dw_pcie;
>  
> -void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci);
> +void qcom_pcie_common_set_equalization(struct dw_pcie *pci);
>  void qcom_pcie_common_set_16gt_lane_margining(struct dw_pcie *pci);
>  
>  #endif
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index bf7c6ac0f3e3..aaf060bf39d4 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -511,10 +511,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  		goto err_disable_resources;
>  	}
>  
> -	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT) {
> -		qcom_pcie_common_set_16gt_equalization(pci);
> +	qcom_pcie_common_set_equalization(pci);
> +
> +	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT)
>  		qcom_pcie_common_set_16gt_lane_margining(pci);
> -	}
>  
>  	/*
>  	 * The physical address of the MMIO region which is exposed as the BAR
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c789e3f85655..0fcb17ffd2e9 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -298,10 +298,10 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>  
> -	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT) {
> -		qcom_pcie_common_set_16gt_equalization(pci);
> +	qcom_pcie_common_set_equalization(pci);
> +
> +	if (pcie_link_speed[pci->max_link_speed] == PCIE_SPEED_16_0GT)
>  		qcom_pcie_common_set_16gt_lane_margining(pci);
> -	}
>  
>  	/* Enable Link Training state machine */
>  	if (pcie->cfg->ops->ltssm_enable)
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

