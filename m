Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7345A5CA6
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 09:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiH3HOF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 03:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiH3HOD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 03:14:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F11DC2764;
        Tue, 30 Aug 2022 00:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C326AB816AA;
        Tue, 30 Aug 2022 07:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAB7C433C1;
        Tue, 30 Aug 2022 07:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661843639;
        bh=N85wQvT76zz3IeyCl0LFoWyoONSRnwCg16u5Giob5IM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ljuu/lqVPmhIsQODLZgymO4xqsRnujIozpGfe+s6+cV+brJoAdMKZRymPpsOGWZ8+
         mH0/vmiD4szFDaMsDqO4cPQqu9YxHJM5aZ9CoggjWln8ZB90w+LO1iYxzrkaJqjQDB
         tvkU5iPUdiJyJyniax6oury3naT5kv4uJByTHNLVKp3hDgrcom5DOxNwA6Hd9BieJa
         ewUG4ValKx27i0hYI/8dLhLneKnXJ8mJngM8nKB0vLzk8d2J2kydUSQKbBd9j8O7nv
         jmEEOFJ0wD32AXH3Bv1mDSenEQ9PC41fHOCxR8WJ2VJ7XdTiYffciMVHvQNYnsjf8V
         EDn3H0kYVlycw==
Date:   Tue, 30 Aug 2022 12:43:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn@kryo.se>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v2 2/6] phy: qcom-qmp-pcie: split register tables into
 primary and secondary part
Message-ID: <Yw24sgVksGzvgr8Q@matsya>
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

On 25-08-22, 13:50, Dmitry Baryshkov wrote:
> SM8250 configuration tables are split into two parts: the common one and
> the PHY-specific tables. Make this split more formal. Rather than having
> a blind renamed copy of all QMP table fields, add separate struct
> qmp_phy_cfg_tables and add two instances of this structure to the struct
> qmp_phy_cfg. Later on this will be used to support different PHY modes
> (RC vs EP).

This lgtm with once nit

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

since this is optional but always defined, we would waste memory here,
can we make this a pointer and initialize to null when secondary is not
present

-- 
~Vinod
