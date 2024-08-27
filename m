Return-Path: <linux-pci+bounces-12265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDF0960787
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 12:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73226B21984
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 10:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A0419CD07;
	Tue, 27 Aug 2024 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKvyi+Gh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF2182B2;
	Tue, 27 Aug 2024 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754791; cv=none; b=ACWvXlWtYnqNOhCnf4EaPpWk26TeE1q73jf9BXBk8t0r+tiQ7hSLqzUjTA94k3nNMkYyreR5UKzeGuDPo24o3Zjk9bz4dZ6YUqDna18GQVGU2ieQOgTMH5GjyncBZwOHGcbKqYsE0S4f4R10hJFkLLRSfNUwIgCC06pNPTUvKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754791; c=relaxed/simple;
	bh=cR7h+2R2D+Lq9NcV2CvzH83tJKg5LBeLkWoEq+6UNSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcM+qcub1RUvBT2FP4X20AqQlYtY9yVbGuMIWAXYQCX8DHFzqczvlsai3C39lTPtc5nnQlqen6dBHIQU5D2ywqUfzSoafbSwQfFUGBHTaiQ5nirmSAZVayph0S5uabR7SSrlXvLK1W86VZ4YYoHT9rLram52HVPnpwwBybFxd9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKvyi+Gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D693EC8B7A4;
	Tue, 27 Aug 2024 10:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724754791;
	bh=cR7h+2R2D+Lq9NcV2CvzH83tJKg5LBeLkWoEq+6UNSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aKvyi+Ghqx4bemzetoDEKzGX5EfXUIegPXeuzyAzG5HZtSvGqpul8p8ML276Jw3hM
	 FYzZjrEoHp51Qhmib+lF8rhtP6GVxreg1qCAOldPfVZiHGA4e+sYODDxkMUbr00TDd
	 9hJ/TZ//ufr3P06s47kYc7TB6nLetewf27CLaRIfinh/iLw0YqNO2UM/jxjMj7Wn5d
	 UKGb0RydTOFcMo6jdqmjWDTm29BdepBpKtQ4pvk9Aax5CeHvk8e2r3UEUKJLMs+VZw
	 RBRJ+dirqwBQIu7/0XgetatDFswfjdZtSqVZUbZY4nr6i3C01RWUni7fRizE7CrHwp
	 tg8P+t5jhNKrQ==
Message-ID: <2d3f3da1-713e-4378-b87d-11f10f0f9590@kernel.org>
Date: Tue, 27 Aug 2024 12:33:02 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] phy: qcom: qmp: Add phy register and clk setting for
 x1e80100 PCIe3
To: Qiang Yu <quic_qianyu@quicinc.com>, manivannan.sadhasivam@linaro.org,
 vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org,
 quic_msarkar@quicinc.com, quic_devipriy@quicinc.com
Cc: dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
 neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-4-quic_qianyu@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240827063631.3932971-4-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.08.2024 8:36 AM, Qiang Yu wrote:
> Currently driver supports only x4 lane based functionality using tx/rx and
> tx2/rx2 pair of register sets. To support 8 lane functionality with PCIe3,
> PCIe3 related QMP PHY provides additional programming which are available
> as txz and rxz based register set. Hence adds txz and rxz based registers
> usage and programming sequences. Phy register setting for txz and rxz will
> be applied to all 8 lanes. Some lanes may have different settings on
> several registers than txz/rxz, these registers should be programmed after
> txz/rxz programming sequences completing.
> 
> Besides, PCIe3 related QMP PHY also requires addtional clk, which is named
> as clkref_en. Hence, add this clk into qmp_pciephy_clk_l so that it can be
> easily parsed from devicetree during init.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---

[...]

> +static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x8_pcie_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG_LANE(QSERDES_V6_20_RX_DFE_CTLE_POST_CAL_OFFSET, 0x3a, 1),

1 -> BIT(0)

[...]

> +	/* Set to true for programming all 8 lanes using txz/rxz registers */
> +	bool lane_broadcasting;

This is unnecessary because you call qmp_configure_lane conditionally,
but that function has a nullcheck built in

> +
>  	/* resets to be requested */
>  	const char * const *reset_list;
>  	int num_resets;
> @@ -2655,6 +2815,8 @@ struct qmp_pcie {
>  	void __iomem *rx;
>  	void __iomem *tx2;
>  	void __iomem *rx2;
> +	void __iomem *txz;
> +	void __iomem *rxz;
>  	void __iomem *ln_shrd;
>  
>  	void __iomem *port_b;
> @@ -2700,7 +2862,7 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
>  
>  /* list of clocks required by phy */
>  static const char * const qmp_pciephy_clk_l[] = {
> -	"aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux",
> +	"aux", "cfg_ahb", "ref", "refgen", "rchng", "phy_aux", "clkref_en",

Why not just put in TCSR_PCIE_8L_CLKREF_EN as "ref"? It's downstream
of the XO anyway.

[...]

>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> @@ -3700,6 +3907,11 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
>  
>  	qmp_configure(qmp->dev, serdes, tbls->serdes, tbls->serdes_num);
>  
> +	if (cfg->lane_broadcasting) {

All these ifs can be unconditional

Konrad

