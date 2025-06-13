Return-Path: <linux-pci+bounces-29768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5AEAD9572
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 21:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E381E23C1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 19:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA47248894;
	Fri, 13 Jun 2025 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8odkKdl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A4823E356;
	Fri, 13 Jun 2025 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842486; cv=none; b=DOIS+sFSebNRdV/fb/+mZd22sbalQ4HoyelZAjQj57ncaY85Y94/o4UanXW9S3YOJ+ohiKIyTBmVIFZYtqbjChMwFJi2svD2U4Gmxkjs+itysUUedLyOoNks8QrMVjSmj2V8lBmPsY61d07TlETpzh/uQF4qckfer/ws3eaiLlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842486; c=relaxed/simple;
	bh=Gpe+Xbaqg839eoHxEGGg3ncn8LwqWk899z282q/Ecfo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tGfTav46C6nX2CLajcnWsL9bvW1Gsl8XtdhU6daQ6+Nz9wT8ZY4mml06eUfQJg3yoHQCNp/xmkqsTZgKnb/MhV2iTQ+K4aWBjtNKaBU+50P69yJFs3AHSdPbc3ycYSd4k1Ava3drWm5jmpZgzlOGZ66qml44yjJN3uPhAiAtrXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8odkKdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4399DC4CEE3;
	Fri, 13 Jun 2025 19:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749842485;
	bh=Gpe+Xbaqg839eoHxEGGg3ncn8LwqWk899z282q/Ecfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N8odkKdlYSl4cN22e5vZqUj6R+UMjpqE4NdHCBDHaho4VaSwQS3lsfEEa0T4SVBU0
	 Tce66UH+sQiDvZl+zfL+yBF2suQIHwWyLdbMJNcC41VgUCX87JLDfdQtKUHiAdOIk9
	 RMHHkCyyC1umn/UwNNz7Yl7IpKjKC4rwSpNZd1tQtPp6ToCfFOJYxG4/zKSUSUTYqq
	 FRWyEE/NjOn50qCbIasBn4C54bpT51DEm8mESUQxvJk7LIQJbdmb6GSowMaIMlAgxc
	 OmtTku36FPRwM/67sNu1tH/K+Y9zA0JzY644gDJmF7pZq58vjUonybnlCGVRMTaLdd
	 dtF/6Csw2b8rg==
Date: Fri, 13 Jun 2025 14:21:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, dmitry.baryshkov@linaro.org,
	manivannan.sadhasivam@linaro.org, neil.armstrong@linaro.org,
	abel.vesa@linaro.org, kw@linux.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v2 1/2] PCI: qcom: Add equalization settings for 8.0 GT/s
Message-ID: <20250613192124.GA970861@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611100319.464803-2-quic_ziyuzhan@quicinc.com>

On Wed, Jun 11, 2025 at 06:03:18PM +0800, Ziyue Zhang wrote:
> Adding lane equalization setting for 8.0 GT/s to enhance link stability
> and fix AER correctable errors reported on some platforms (eg. SA8775P).

s/Adding/Add/

s/fix AER correctable errors/avoid AER Correctable Errors/
so we know that (a) this avoids the errors (it's not some kind of
recovery), and (b) readers know that "Correctable Error" is something
that can be looked up in a spec.

> 8.0 GT/s and 16.0GT/s require the same equalization setting. This setting
> is programmed into a group of shadow registers, which can be switched to
> configure equalization for different GEN speeds by writing 00b, 01b
> to `RATE_SHADOW_SEL`.

s|16.0GT/s|16.0 GT/s| to match "8.0 GT/s"

s/different GEN speeds/different speeds/ (PCIe spec rev ("GEN") is not
a one-to-one mapping to speeds)

> @@ -18,33 +20,43 @@ void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
>  	 * GEN3_EQ_*. The RATE_SHADOW_SEL bit field of GEN3_RELATED_OFF
>  	 * determines the data rate for which these equalization settings are
>  	 * applied.
> +	 *
> +	 * TODO:
> +	 * EQ settings need to be added for 32.0 T/s in future

Drop this comment since it's not an indication of a problem in this
patch.  The list of possible future work is infinite, and you can keep
track of a TODO list internally.

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

Drop period at end of message.

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

Is "CUSROR" a typo for "CURSOR", or is "CUSROR" a real thing?  (Either
way, it's not something you added, so not a problem with this patch.)

Bjorn

