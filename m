Return-Path: <linux-pci+bounces-30549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC57AE710B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 22:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBA0178DFB
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 20:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08CD2E3B14;
	Tue, 24 Jun 2025 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb1fbCg0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9E12580E1;
	Tue, 24 Jun 2025 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798228; cv=none; b=Cl92uN4ASk12NRcqBH07sJuoW68/WLPX/wF1pm+uAQ5WV6GaDphni8c5xg8aU3ks+/ejlejt/xfCg7w7joHLKA+lqRtpbAJ7BD+r/q+xw8MsOYgmihw94IU/tfeFyWFbgdi4hlLvoUoV27lsRlQc+/ZAqFc23WZEPnyeqxg8WOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798228; c=relaxed/simple;
	bh=4BbpK2ulCaYimA5b+KGO/XRkOZjvvYa7eQftvR8Ibk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUcKmtpkRGLaMQwbbqm90bzgo253mP+IQlM/saspI75I95+N2wOzIHx0VCp0H7I0+t9FeNRr3b2q7MB+RbBv7hUnUXGuO643I96gqpqtOwkP70G87PjdK9eWeq8Lm+uDT5CskxydXlvl2LLo4gWwP/hFe8jfWuuG2sb48cZfhxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb1fbCg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB455C4CEE3;
	Tue, 24 Jun 2025 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750798228;
	bh=4BbpK2ulCaYimA5b+KGO/XRkOZjvvYa7eQftvR8Ibk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zb1fbCg0rrTjVKS2EhGPpcPYr2V+j2CoaRQl/xT5DSYn6s+AT+hktlzh0XcLEZaEx
	 g7m6x8pQLA7eVjg0o7SWpmna/vWsnKP3zdR+DmqE1ZhNlVAv4wA4Fnyk5AYmTHKkBF
	 H5WbS+WHWq1pI9H9Ue90bmuS6X+Olxn0UYq2P21n45bm5qCJFfYzXgzFkVeEuRXgRr
	 91IP/EzsIKx3XkUlzx8ajdJY3+GBc4IPOdTfP4GepvgqRygHnapzQNyuwRyDBkVUNV
	 YOpivXztV+VdMmeW30bKljsZA9bVSJGoEunj2TSHsNrDBic5oMxdr+xCcUNJMNutwC
	 vcypOXSlF5yXA==
Date: Tue, 24 Jun 2025 14:50:24 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, dmitry.baryshkov@linaro.org, manivannan.sadhasivam@linaro.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v2 1/2] PCI: qcom: Add equalization settings for 8.0 GT/s
Message-ID: <t4dwk5buo5yuuz3au5lnt4ol4ow343qjj2jxa3ktxmxoxrkm3x@c4pena57zsn3>
References: <20250611100319.464803-1-quic_ziyuzhan@quicinc.com>
 <20250611100319.464803-2-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611100319.464803-2-quic_ziyuzhan@quicinc.com>

On Wed, Jun 11, 2025 at 06:03:18PM +0800, Ziyue Zhang wrote:
> Adding lane equalization setting for 8.0 GT/s to enhance link stability
> and fix AER correctable errors reported on some platforms (eg. SA8775P).
> 
> 8.0 GT/s and 16.0GT/s require the same equalization setting. This setting
> is programmed into a group of shadow registers, which can be switched to
> configure equalization for different GEN speeds by writing 00b, 01b
> to `RATE_SHADOW_SEL`.
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
>  drivers/pci/controller/dwc/pcie-qcom-common.c | 60 +++++++++++--------
>  drivers/pci/controller/dwc/pcie-qcom-common.h |  2 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +-
>  drivers/pci/controller/dwc/pcie-qcom.c        |  6 +-
>  5 files changed, 43 insertions(+), 32 deletions(-)
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
> index 3aad19b56da8..4ff97ec13818 100644
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
> @@ -18,33 +20,43 @@ void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
>  	 * GEN3_EQ_*. The RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF
>  	 * determines the data rate for which these equalization settings are
>  	 * applied.
> +	 *
> +	 * TODO:
> +	 * EQ settings need to be added for 32.0 T/s in future
>  	 */
> -	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> -	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> -	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> -	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
> -			  GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT);
> -	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
> +	if (pcie_link_speed[pci->max_link_speed] < PCIE_SPEED_32_0GT)
> +		max_speed = pcie_link_speed[pci->max_link_speed];
> +	else
> +		dev_warn(dev, "The target supports 32.0 GT/s, but the EQ setting for 32.0 GT/s is not configured.\n");

I believe the warning is enough to inform the users/developers that the driver
update is needed. So the TODO above looks redundant.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

