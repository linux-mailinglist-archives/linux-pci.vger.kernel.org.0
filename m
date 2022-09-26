Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C33D5E9B41
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 09:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiIZHzB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 03:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbiIZHxU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 03:53:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A473DBD7;
        Mon, 26 Sep 2022 00:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0FE56184D;
        Mon, 26 Sep 2022 07:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EF0C433D6;
        Mon, 26 Sep 2022 07:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664178475;
        bh=oMh3mRdeUJx5z+IufCR39aeOPCWTzVwWRyG9Z13I90Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvdJ6RkhF97tN5I5vj+NPXFnuOBY4JuqUmRkesoIqyV5anN51wmXsKiJDeSAuDvrR
         es5y/rjj3avpnhbGMA2LxiaVqFbFeDeMyWqsONONr+GqhnckDI2LI0b0uPv/mSuhQd
         J+8P/HaeRX+fj5PhZ0Ki4ZTGNaAdKGwUvnmeOEbIQnNui1kevYcW1DeW82cTWCIuzY
         aJPxm3T7bMz4XgMDWfBgdHFBf4CenJUlPIkv9IfEEI0DVehPBC8YbybbbmFQ/QpIG0
         0bEJ5Am845aj1uZlQ4nVHwRkqgdI+eFxP+p3QE3tDm90siFvgqlwsM2t0a333yZeW9
         Q289TwF24qHVA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ociqO-0003qD-Jm; Mon, 26 Sep 2022 09:48:00 +0200
Date:   Mon, 26 Sep 2022 09:48:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 3/6] phy: qcom-qmp-pcie: support separate tables for
 EP mode
Message-ID: <YzFZMGezfg26T9r5@hovoldconsulting.com>
References: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
 <20220924160302.285875-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924160302.285875-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 24, 2022 at 07:02:59PM +0300, Dmitry Baryshkov wrote:
> The PCIe QMP PHY requires different programming sequences when being
> used for the RC (Root Complex) or for the EP (End Point) modes. Allow
> selecting the submode and thus selecting a set of PHY programming
> tables.
> 
> Since the RC and EP modes share common some common init sequence, the
> common sequence is kept in the main table and the sequence differences
> are pushed to the extra tables.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 67 ++++++++++++++++++++----
>  1 file changed, 58 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 6e8c74585670..1fc23df59454 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1320,10 +1320,14 @@ struct qmp_phy_cfg {
>  	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
>  	struct qmp_phy_cfg_tables common;
>  	/*
> -	 * Additional init sequence for PHY blocks, providing additional
> -	 * register programming. Unless required it can be left omitted.
> +	 * Additional init sequences for PHY blocks, providing additional
> +	 * register programming. They are used for providing separate sequences
> +	 * for the Root Complex and for the End Point usecases.
> +	 *
> +	 * If EP mode is not supported, both tables can be left empty.
>  	 */
> -	struct qmp_phy_cfg_tables *extra;
> +	struct qmp_phy_cfg_tables *extra_rc; /* for the RC only */
> +	struct qmp_phy_cfg_tables *extra_ep; /* for the EP only */

So with the additional "_rc" and "_ep" suffixes this would be more
obvious as for example:

	struct qmp_phy_cfg_tables tbls_common;
	struct qmp_phy_cfg_tables tbls_rc;
	struct qmp_phy_cfg_tables tbls_ep;

The "for the RC only" comments doesn't really add anything.

>  
>  	/* clock ids to be requested */
>  	const char * const *clk_list;
> @@ -1367,6 +1371,7 @@ struct qmp_phy_cfg {
>   * @pcs_misc: iomapped memory space for lane's pcs_misc
>   * @pipe_clk: pipe clock
>   * @qmp: QMP phy to which this lane belongs
> + * @extra: currently selected PHY extra init table set

"extra" is not a descriptive name here either.

>   */
>  struct qmp_phy {
>  	struct phy *phy;
> @@ -1379,6 +1384,7 @@ struct qmp_phy {
>  	void __iomem *rx2;
>  	void __iomem *pcs_misc;
>  	struct clk *pipe_clk;
> +	const struct qmp_phy_cfg_tables *extra;
>  	struct qcom_qmp *qmp;
>  };
>  
> @@ -1624,7 +1630,15 @@ static const struct qmp_phy_cfg sm8250_qmp_gen3x1_pciephy_cfg = {
>  	.pcs_misc_tbl		= sm8250_qmp_pcie_pcs_misc_tbl,
>  	.pcs_misc_tbl_num	= ARRAY_SIZE(sm8250_qmp_pcie_pcs_misc_tbl),
>  	},
> -	.extra = &(struct qmp_phy_cfg_tables) {
> +	/*
> +	 * For sm8250 the split between the primary and extra_rc tables is
> +	 * historical, it reflects the programming sequence common to all PCIe
> +	 * PHYs on this platform and a sequence required for this particular
> +	 * PHY type. If EP support for sm8250 is required, the
> +	 * primary/extra_rc split is to be reconsidered and adjusted
> +	 * according to EP programming sequence.
> +	 */

Not sure this is needed either. I'm currently using the "_sec" tables
(future "extra") for sc8280xp as well to handle minor variations in init
sequences between the different PHY types.

> +	.extra_rc = &(struct qmp_phy_cfg_tables) {
>  	.serdes_tbl		= sm8250_qmp_gen3x1_pcie_serdes_tbl,
>  	.serdes_tbl_num		= ARRAY_SIZE(sm8250_qmp_gen3x1_pcie_serdes_tbl),
>  	.rx_tbl			= sm8250_qmp_gen3x1_pcie_rx_tbl,

> @@ -2000,8 +2022,12 @@ static int qmp_pcie_power_on(struct phy *phy)
>  	unsigned int mask, val, ready;
>  	int ret;
>  
> +	/* Default to RC mode if the mode was not selected using phy_set_mode_ext() */
> +	if (!qphy->extra)
> +		qphy->extra = cfg->extra_rc;

It would probably be better to just store the submode in
phy_set_mode_ext() and pick the right table here.

That way you don't need to describe what's really going on in a comment
as it would be apparent from the code.

> +
>  	qmp_pcie_serdes_init(qphy, &cfg->common);
> -	qmp_pcie_serdes_init(qphy, cfg->extra);
> +	qmp_pcie_serdes_init(qphy, qphy->extra);
>  
>  	ret = clk_prepare_enable(qphy->pipe_clk);
>  	if (ret) {
 
> +static int qmp_pcie_set_mode(struct phy *phy,

Do you really need a line break?

> +				 enum phy_mode mode, int submode)
> +{
> +	struct qmp_phy *qphy = phy_get_drvdata(phy);
> +
> +	switch (submode) {
> +	case PHY_MODE_PCIE_RC:
> +		qphy->extra = qphy->cfg->extra_rc;
> +		break;
> +	case PHY_MODE_PCIE_EP:
> +		qphy->extra = qphy->cfg->extra_ep;
> +		break;
> +	default:
> +		dev_err(&phy->dev, "Unuspported submode %d\n", submode);

Typo: unsupported

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int qmp_pcie_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
>  {
>  	struct qcom_qmp *qmp = dev_get_drvdata(dev);
> @@ -2224,6 +2270,7 @@ static int phy_pipe_clk_register(struct qcom_qmp *qmp, struct device_node *np)
>  static const struct phy_ops qmp_pcie_ops = {
>  	.power_on	= qmp_pcie_enable,
>  	.power_off	= qmp_pcie_disable,
> +	.set_mode	= qmp_pcie_set_mode,
>  	.owner		= THIS_MODULE,
>  };
>  
> @@ -2278,7 +2325,9 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
>  		qphy->pcs_misc = qphy->pcs + 0x400;
>  
>  	if (IS_ERR(qphy->pcs_misc)) {
> -		if (cfg->common.pcs_misc_tbl || cfg->extra->pcs_misc_tbl)
> +		if (cfg->common.pcs_misc_tbl ||
> +		    cfg->extra_rc->pcs_misc_tbl ||
> +		    cfg->extra_ep->pcs_misc_tbl)

I already pointed out the NULL deref here.

>  			return PTR_ERR(qphy->pcs_misc);
>  	}

Johan
