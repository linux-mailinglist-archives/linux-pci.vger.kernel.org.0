Return-Path: <linux-pci+bounces-34529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE6B3114E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 10:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61303B16A4
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 08:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2777A2EAB8D;
	Fri, 22 Aug 2025 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUr9GDfD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FE125A640;
	Fri, 22 Aug 2025 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850001; cv=none; b=AegmDU7xDZED7/VuaOe4MMc4HdnXTb74r8szdQIf0tHkkxQuaL5rC2XPfcvrWNWWhNH0sDWmEbgy/X4QF4E8ZK20RXGlXeonxtak9/p37NBQZYzz7UzPCmMJ1LDl9IcG0KQrXzIFEfj+0g2iuK0PbQnWEY3CxkOw3KGd/usaVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850001; c=relaxed/simple;
	bh=h+QAsLHcHphnO5GHj6GjYLiZ/feVrj2o6O4fk/onQb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBj4klmyY6L3LpIgIzJoQdwNlVyKUZXWcEwpglEmJighw4zBiUrwnhqZueop/c97Sj+negZYv112VB+q98ywVF9sgNB0jTL+yqce201aDkWBWUYEWyH8opuGgaN0gj7L9TQN7dhBv0Lo95YHdCG9lcdZg5RxJsmbalj1IvVQ6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUr9GDfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C23C4CEF1;
	Fri, 22 Aug 2025 08:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755850000;
	bh=h+QAsLHcHphnO5GHj6GjYLiZ/feVrj2o6O4fk/onQb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EUr9GDfD8Z2950nOET7InqJEUXnuDGDPMhoubseAdozACiGlBK9WLmCcMw0riNAya
	 eJbMRl4Na+cluvsk6Qp4rq4LrLT/z4vNyMErnuxoTVVUv4pzP9pgnGSimpBWXLGc4D
	 1iHa3t0ihZVXmRNtyPBaXrt7opCcjmsKh6FIcDggpQ2oYAyJaRs+/A5EaKKmnEquRS
	 xKdwzcZjlspSypdDJlP4aUlD0F0eh4uccQ8oiZ/mQQ0K25BrhCCiUC1DOKc3XuH2jj
	 8uCxJcjFV1VzZflj0phVSvaRaP1lMICpLjU+5wigQuGrHQMYv6rFpj/yc5xZcMGC1m
	 HO/xN2j5kiaKA==
Date: Fri, 22 Aug 2025 13:36:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v5 1/3] PCI: qcom: Add equalization settings for 8.0 GT/s
 and 32.0 GT/s
Message-ID: <z54p5x5u56u7dprrlv3obzhxotjgimbufa2spajoqvnlrevgdd@4dejnkmiegrh>
References: <20250819071649.1531437-1-ziyue.zhang@oss.qualcomm.com>
 <20250819071649.1531437-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819071649.1531437-2-ziyue.zhang@oss.qualcomm.com>

On Tue, Aug 19, 2025 at 03:16:46PM GMT, Ziyue Zhang wrote:
> Add lane equalization setting for 8.0 GT/s and 32.0 GT/s to enhance link
> stability and avoid AER Correctable Errors reported on some platforms
> (eg. SA8775P).
> 

So this is fixing an issue, right? Then you should add relevant Fixes tag. I
guess the tag here would be the commit that added SA8775p.

> 8.0 GT/s, 16.0 GT/s and 32.0 GT/s require the same equalization setting.
> This setting is programmed into a group of shadow registers, which can be
> switched to configure equalization for different speeds by writing 00b,
> 01b and 10b to `RATE_SHADOW_SEL`.
> 
> Hence program equalization registers in a loop using link speed as index,
> so that equalization setting can be programmed for 8.0 GT/s, 16.0 GT/s
> and 32.0 GT/s.
> 
> Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 -
>  drivers/pci/controller/dwc/pcie-qcom-common.c | 58 +++++++++++--------
>  drivers/pci/controller/dwc/pcie-qcom-common.h |  2 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +-
>  drivers/pci/controller/dwc/pcie-qcom.c        |  6 +-
>  5 files changed, 41 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index b5e7e18138a6..11de844428e5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -123,7 +123,6 @@
>  #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
>  #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK	GENMASK(25, 24)
> -#define GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT	0x1
>  
>  #define GEN3_EQ_CONTROL_OFF			0x8A8
>  #define GEN3_EQ_CONTROL_OFF_FB_MODE		GENMASK(3, 0)
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
> index 3aad19b56da8..cb98e66d81d9 100644
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
> +	u16 speed;
> +	struct device *dev = pci->dev;

Reverse Xmas order please.

>  
>  	/*
>  	 * GEN3_RELATED_OFF register is repurposed to apply equalization
> @@ -19,32 +21,40 @@ void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
>  	 * determines the data rate for which these equalization settings are
>  	 * applied.
>  	 */
> -	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> -	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> -	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> -	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
> -			  GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT);
> -	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
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
> +	for (speed = PCIE_SPEED_8_0GT; speed <= pcie_link_speed[pci->max_link_speed]; ++speed) {
> +		if (speed > PCIE_SPEED_32_0GT) {
> +			dev_warn(dev, "Skipped equalization settings for speeds higher than 32.0 GT/s\n");
> +			break;
> +		}
>  
> -	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> -	reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
> -		GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
> -		GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
> -		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> -	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
> +		reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +		reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +		reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> +		reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
> +			  speed - PCIE_SPEED_8_0GT);
> +		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
> +
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
> index 60afb4d0134c..aeb166f68d55 100644
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

This condition has existed even before this patch, but just noticing this
possible issue. So if 'max_link_speed' is > 16 GT/s, we do not need to set lane
margining? We used the same logic to set equalization setting earlier also.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

