Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E442C5A5D1E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 09:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiH3HiV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 03:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiH3HiR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 03:38:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9A5BB680;
        Tue, 30 Aug 2022 00:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F6A4614DB;
        Tue, 30 Aug 2022 07:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFD8C433D6;
        Tue, 30 Aug 2022 07:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661845095;
        bh=KQ0cN3fGWMuIh7l3tRunaZd7UYa74HXpLliy5jjUJ24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjzTAyxQ3ZjhrCnl1rxUXIjchwFKQzEHBL9EFIkSsdLREbBjys/MTG9W69hKkURlo
         Yz507fc+1uHLMWqyZZbJn86jPyLYGVGIX5y7Rr3aCAc3pYrisUddRE3/oCHETkjmC/
         /AGNrTNMlH2tzki0BS79VmTiv5fypNx1nNV5QTMKDsl2UF2JhKeyAT8A+g76pcG6cd
         DIS6KWY666w5u+81RMVJK2kwQgGPkjYcaJgvw+34mM2y6nmNBoL3go4ShJV6XxucFP
         goeEqiYSlmaboqkEoZFnItVK4FYXvxRkCz5skPJCGofJqZlgoTf9AOaEv3VHwz49rG
         t2u20PkVPut/g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oSvpB-0002rl-F9; Tue, 30 Aug 2022 09:38:18 +0200
Date:   Tue, 30 Aug 2022 09:38:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn@kryo.se>,
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
Subject: Re: [PATCH v2 2/6] phy: qcom-qmp-pcie: split register tables into
 primary and secondary part
Message-ID: <Yw2+aVbqBfMSUcWq@hovoldconsulting.com>
References: <20220825105044.636209-1-dmitry.baryshkov@linaro.org>
 <20220825105044.636209-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825105044.636209-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 25, 2022 at 01:50:40PM +0300, Dmitry Baryshkov wrote:
> SM8250 configuration tables are split into two parts: the common one and
> the PHY-specific tables. Make this split more formal. Rather than having
> a blind renamed copy of all QMP table fields, add separate struct
> qmp_phy_cfg_tables and add two instances of this structure to the struct
> qmp_phy_cfg. Later on this will be used to support different PHY modes
> (RC vs EP).
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 141 +++++++++++++----------
>  1 file changed, 83 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index c84846020272..60cbd2eae346 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1346,34 +1346,33 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
>  
>  struct qmp_phy;
>  
> -/* struct qmp_phy_cfg - per-PHY initialization config */
> -struct qmp_phy_cfg {
> -	/* phy-type - PCIE/UFS/USB */
> -	unsigned int type;
> -	/* number of lanes provided by phy */
> -	int nlanes;
> -
> -	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
> +struct qmp_phy_cfg_tables {
>  	const struct qmp_phy_init_tbl *serdes_tbl;
>  	int serdes_tbl_num;
> -	const struct qmp_phy_init_tbl *serdes_tbl_sec;
> -	int serdes_tbl_num_sec;
>  	const struct qmp_phy_init_tbl *tx_tbl;
>  	int tx_tbl_num;
> -	const struct qmp_phy_init_tbl *tx_tbl_sec;
> -	int tx_tbl_num_sec;
>  	const struct qmp_phy_init_tbl *rx_tbl;
>  	int rx_tbl_num;
> -	const struct qmp_phy_init_tbl *rx_tbl_sec;
> -	int rx_tbl_num_sec;
>  	const struct qmp_phy_init_tbl *pcs_tbl;
>  	int pcs_tbl_num;
> -	const struct qmp_phy_init_tbl *pcs_tbl_sec;
> -	int pcs_tbl_num_sec;
>  	const struct qmp_phy_init_tbl *pcs_misc_tbl;
>  	int pcs_misc_tbl_num;
> -	const struct qmp_phy_init_tbl *pcs_misc_tbl_sec;
> -	int pcs_misc_tbl_num_sec;
> +};
> +
> +/* struct qmp_phy_cfg - per-PHY initialization config */
> +struct qmp_phy_cfg {
> +	/* phy-type - PCIE/UFS/USB */
> +	unsigned int type;
> +	/* number of lanes provided by phy */
> +	int nlanes;
> +
> +	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
> +	struct qmp_phy_cfg_tables primary;
> +	/*
> +	 * Init sequence for PHY blocks, providing additional register
> +	 * programming. Unless required it can be left omitted.
> +	 */
> +	struct qmp_phy_cfg_tables secondary;

I haven't really had time to look at this series yet, but it seems the
way these structures are named and organised could be improved.

First, "primary" and "secondary" says nothing about what these
structures are and the names are also unnecessarily long. 

Second, once you add a containing structure, the "_tbl" suffixes could
be removed (e.g. in "pcs_misc_tbl").

Doing something like below should make the code cleaner:

	struct qmp_phy_cfg_tables {
		const struct qmp_phy_init_tbl *serdes;
		const struct qmp_phy_init_tbl *tx;
		...
	};

	struct qmp_phy_cfg {
		struct qmp_phy_cfg_tables tbls1;
		struct qmp_phy_cfg_tables tbls2;
		...
	};
	
as the tables can be referred to as

	cfg.tbls2.serdes

instead of
	
	cfg.secondary.serdes_tbl;

Johan
