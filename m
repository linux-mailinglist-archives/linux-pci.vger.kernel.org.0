Return-Path: <linux-pci+bounces-13446-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B83E98485F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 17:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B3C1C228BA
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE6E5473E;
	Tue, 24 Sep 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLE2yZvc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965D17579;
	Tue, 24 Sep 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190930; cv=none; b=CWmgszj+WvMirYwXO4+PtuwbdIH6DGrxJE8yTITXm5y21mSsFCDDqq2povRINUYn/KzfurDmKnWPHUTCnIQYgvowetNqc11DWpZLEhBLPT0GVt0KNshaPLA+glhT36FHULMWLZK8JU8+VcL7ppgkTe7SepaQzRgfx0LdMWlg7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190930; c=relaxed/simple;
	bh=zua3115y7pyjRHGR0V8lJBC3jKIcSuH/Ui+QDs+z1Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgV9/CtZBRfFx4QSilRmpK2aQzlSufNl5coS6C1f9FRLL0S+/Q/Dbxjhm3o3lxOENykXvZtn9+7Foa7HL2Sa570vtN+t3BGYKAbPg2nIpIr45O6/v81Eygs0GPAwRsH5y6kBJKxzycbHDylx1/J2RqxCnI9IVXNKnaIwp7844EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLE2yZvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF84C4CEC4;
	Tue, 24 Sep 2024 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727190929;
	bh=zua3115y7pyjRHGR0V8lJBC3jKIcSuH/Ui+QDs+z1Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLE2yZvcxco7DlAVE0tAajIu/yBQjgrEMN/2GdK6xd3eqx56YPDtGkyroSb1hVrBA
	 fxxJhxsVpxUrEyPfZoKKTtAI0AtYO2numyIlO5445D6v9OZsn8BVvuLtLBK5O4Qe6g
	 BhySFKMJ60VEFB4Bjuz5A3b24+NETz5LFzyAgR/NMjbinrXneEhIJ7dT8v+RAqadPd
	 vhL+HqJUJDRWhoWg3ytmBzS0dHYDmFbB0cjwEnXTorvsgpa24J84oXuA4yPD8KrmTx
	 cRA/Zx6cjfh9xrFEol8xEac/0RpWVSNS6bZt3eBP8mNBS1SBiRmkbkDPnWwxWWt+hr
	 1aUiZuPq2EQeA==
Received: from johan by theta with local (Exim 4.98)
	(envelope-from <johan@kernel.org>)
	id 1st7G9-0000000025Y-1TD9;
	Tue, 24 Sep 2024 17:15:25 +0200
Date: Tue, 24 Sep 2024 17:15:25 +0200
From: Johan Hovold <johan@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 3/6] phy: qcom: qmp: Add phy register and clk setting
 for x1e80100 PCIe3
Message-ID: <ZvLXjdpBpUS3lLn-@hovoldconsulting.com>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-4-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924101444.3933828-4-quic_qianyu@quicinc.com>

On Tue, Sep 24, 2024 at 03:14:41AM -0700, Qiang Yu wrote:
> Currently driver supports only x4 lane based functionality using tx/rx and
> tx2/rx2 pair of register sets. To support 8 lane functionality with PCIe3,
> PCIe3 related QMP PHY provides additional programming which are available
> as txz and rxz based register set. Hence adds txz and rxz based registers
> usage and programming sequences.

> Phy register setting for txz and rxz will
> be applied to all 8 lanes. Some lanes may have different settings on
> several registers than txz/rxz, these registers should be programmed after
> txz/rxz programming sequences completing.

Please expand and clarify what you mean by this.
 
> Besides, x1e80100 SoC uses QMP phy with version v6.30 for PCIe Gen4 x8.
> Add the new register offsets in a dedicated header file.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 211 ++++++++++++++++++
>  .../qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h    |  25 +++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h |  19 ++
>  3 files changed, 255 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_30.h
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_30.h
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index f71787fb4d7e..d7bbd9df11d7 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c

> @@ -1344,6 +1346,155 @@ static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
>  	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_20_PCS_G4_FOM_EQ_CONFIG5, 0x8a),
>  };
>  
> +static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x8_pcie_txz_tbl[] = {

Please try to follow the sort order used for the other platforms for
these tables (e.g.  serdes, tx, rx, pcr, pcr_misc).

> +static const struct qmp_phy_init_tbl x1e80100_qmp_gen4x8_pcie_pcs_misc_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_ENDPOINT_REFCLK_DRIVE, 0xc1),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_OSC_DTCT_ACTIONS, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_EQ_CONFIG1, 0x16),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G4_EQ_CONFIG5, 0x02),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G4_PRE_GAIN, 0x2e),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG1, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG3, 0x28),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_RX_MARGINING_CONFIG5, 0x18),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G3_FOM_EQ_CONFIG5, 0x7a),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G4_FOM_EQ_CONFIG5, 0x8a),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G3_RXEQEVAL_TIME, 0x27),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_G4_RXEQEVAL_TIME, 0x27),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_TX_RX_CONFIG, 0xc0),
> +	QMP_PHY_INIT_CFG(QPHY_PCIE_V6_30_PCS_POWER_STATE_CONFIG2, 0x1d),
> +

Stray newline.

> +};
> +

> +static const struct qmp_phy_cfg x1e80100_qmp_gen4x8_pciephy_cfg = {
> +	.lanes = 8,
> +
> +	.offsets		= &qmp_pcie_offsets_v6_30,
> +	.tbls = {
> +		.serdes			= x1e80100_qmp_gen4x8_pcie_serdes_tbl,
> +		.serdes_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_serdes_tbl),
> +		.rx			= x1e80100_qmp_gen4x8_pcie_rx_tbl,
> +		.rx_num			= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_rx_tbl),
> +		.pcs			= x1e80100_qmp_gen4x8_pcie_pcs_tbl,
> +		.pcs_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_pcs_tbl),
> +		.pcs_misc		= x1e80100_qmp_gen4x8_pcie_pcs_misc_tbl,
> +		.pcs_misc_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_pcs_misc_tbl),
> +		.ln_shrd		= x1e80100_qmp_gen4x8_pcie_ln_shrd_tbl,
> +		.ln_shrd_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_ln_shrd_tbl),
> +		.txz			= x1e80100_qmp_gen4x8_pcie_txz_tbl,
> +		.txz_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_txz_tbl),
> +		.rxz			= x1e80100_qmp_gen4x8_pcie_rxz_tbl,
> +		.rxz_num		= ARRAY_SIZE(x1e80100_qmp_gen4x8_pcie_rxz_tbl),

Try follow the order of the other SoCs here as well (e.g. use the order
defined in struct qmp_phy_cfg_tbls).

> +	},

>  static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
>  {
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> @@ -3751,6 +3953,9 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
>  
>  	qmp_configure(qmp->dev, serdes, tbls->serdes, tbls->serdes_num);

If your comment in the commit message implies that txz/rxz must be
programmed before tx/rx then you need to add a comment here as well.

> +	qmp_configure(qmp->dev, qmp->txz, tbls->txz, tbls->txz_num);
> +	qmp_configure(qmp->dev, qmp->rxz, tbls->rxz, tbls->rxz_num);
> +
>  	qmp_configure_lane(qmp->dev, tx, tbls->tx, tbls->tx_num, 1);
>  	qmp_configure_lane(qmp->dev, rx, tbls->rx, tbls->rx_num, 1);

Johan

