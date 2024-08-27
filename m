Return-Path: <linux-pci+bounces-12269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F299608DE
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 13:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904DBB23199
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC371A00EE;
	Tue, 27 Aug 2024 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZWU14K+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8351A00C9;
	Tue, 27 Aug 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758633; cv=none; b=LyOoW0yLzSsko8Es0Sr0PmX4lg/KzIEtgzQpXMndw/tARFQa9uHoSe2CCstG0xbBQSRrvbANkTDc9pRr9qDxMOoZmysX9QCsy6B/rpXeQ7rjDugczNLKGT0W+8ABTNe2u2Mzfr/I7gqZobrj/y6k7IoAk4PX7sbMGQIxyTRpMuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758633; c=relaxed/simple;
	bh=pqaE6MBhVqZ3MnXvihv9QZJKz2GO/zc7qXNrlb1bhlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tygqVZL87HRgR9zvEciZod+s4wpvDI39YZq4KyqSVhPXl6FNrXhZwDzqWAgLuUc+jyQv+6hw67vbpBtI0IDzX1jLwDNQm1U2SdAiIRs8KcNCT2eSEnefHtWMe2ul/ibedo/g+MoKxrn63Jvv+jqn8ww3SgRmS11ZP28VqvOcVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZWU14K+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F891C567DC;
	Tue, 27 Aug 2024 11:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724758632;
	bh=pqaE6MBhVqZ3MnXvihv9QZJKz2GO/zc7qXNrlb1bhlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZWU14K+PAj6TLtV2SsINSwgSrjjuNOe8bvFXR17KR/IHlsyxOjzJw7FcrOhgivzh
	 G/Ed3KWIn9RjuLFZnQK6EkgKXmcfU65uXzaxkKaAGj2T86/ekhSVR5MJe0WHIfvW2U
	 YGup/38jbLJVdxT/3tyPXqb4vIDfJfPpQCXH53ww2/gzMtEWQSaBVrLRveKATf93vQ
	 ZjXTGs0/xj38HQ58xACYINxWRf7zlDngVVJPCuBYdn/SwjskFuza+RR5DVrE0ca3DP
	 fBxzFCQWTcSTOFbfRukgvbAwAZ4/NNzCROBLcSJ16uL51MrtvQ54UcOzdVghKQ/M/r
	 0gzd4sXB+ohAA==
Date: Tue, 27 Aug 2024 13:37:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org, 
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org, 
	quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org, 
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/8] phy: qcom-qmp: pcs-pcie: Add v6.30 register offsets
Message-ID: <2ojutgxk4kplxwrxxcq5zorejuohbow7dr6lhl4cwndkwzvxf6@lxg4um6krdnh>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-2-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827063631.3932971-2-quic_qianyu@quicinc.com>

On Mon, Aug 26, 2024 at 11:36:24PM -0700, Qiang Yu wrote:
> x1e80100 SoC uses QMP phy with version v6.30 for PCIe Gen4 x8. Add the new
> PCS PCIE specific offsets in a dedicated header file.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h    | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
> new file mode 100644
> index 000000000000..5a58ff197e6e
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2024 Qualcomm Innovation Center. All rights reserved.
> + */
> +
> +#ifndef QCOM_PHY_QMP_PCS_PCIE_V6_30_H_
> +#define QCOM_PHY_QMP_PCS_PCIE_V6_30_H_
> +
> +/* Only for QMP V6_30 PHY - PCIE have different offsets than V6 */
> +#define QPHY_PCIE_V6_30_PCS_POWER_STATE_CONFIG2		0x014
> +#define QPHY_PCIE_V6_30_PCS_TX_RX_CONFIG		0x020
> +#define QPHY_PCIE_V6_30_PCS_ENDPOINT_REFCLK_DRIVE	0x024
> +#define QPHY_PCIE_V6_30_PCS_OSC_DTCT_ACTIONS		0x098
> +#define QPHY_PCIE_V6_30_PCS_EQ_CONFIG1			0x0a8
> +#define QPHY_PCIE_V6_30_PCS_G3_RXEQEVAL_TIME		0x0f8
> +#define QPHY_PCIE_V6_30_PCS_G4_RXEQEVAL_TIME		0x0fc
> +#define QPHY_PCIE_V6_30_PCS_G4_EQ_CONFIG5		0x110
> +#define QPHY_PCIE_V6_30_PCS_G4_PRE_GAIN			0x164
> +#define QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG1	0x184
> +#define QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG3	0x18c
> +#define QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG5	0x194
> +#define QPHY_PCIE_V6_30_PCS_G3_FOM_EQ_CONFIG5		0x1b4
> +#define QPHY_PCIE_V6_30_PCS_G4_FOM_EQ_CONFIG5		0x1c8

There is no user of these. Squash it with the user, because there is
little point in adding dead code.

Best regards,
Krzysztof


