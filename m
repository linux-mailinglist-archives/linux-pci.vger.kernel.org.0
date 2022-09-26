Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55DF5E9A79
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 09:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiIZHdb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 03:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbiIZHda (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 03:33:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8D322530;
        Mon, 26 Sep 2022 00:33:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9E37B81901;
        Mon, 26 Sep 2022 07:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A372C433D6;
        Mon, 26 Sep 2022 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664177606;
        bh=GiOWWB7nawly0z2Qm4RUKkrXtT0fWmsQtvVUHw0aqnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IbJucAH2EGITulxvElZDPPARZ60G4CnYI5p5Md6xGg9IyaDPpnR+eJ5xZSeRIXD+Y
         1LQBTISU5KpR0h08c7TMx62bKK6rr2F9OnK4E89wuiia/CSg30xws5lPcDRfhlqLb2
         xTMvXg/bsH9S4H1sA1kdZfkn0LGCs0xUOmqVWFr9b3i72gX5tJ+5UP6k2P5OpcsbA+
         e1SLTsm7hYTDGiMNCFVsS2poGFwA+OFuHNyhDxHCOxmIj4l3Tkc06+ORzmGp0AQGuD
         tQyIiFi964SdnxwipMSC+q0Q0ztZmdg2u9BsGQmIjRujbUaKBXyoZvpfOcq8jEnhUK
         3pLk8DuYc94hQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ocicN-0003jO-SH; Mon, 26 Sep 2022 09:33:31 +0200
Date:   Mon, 26 Sep 2022 09:33:31 +0200
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
Subject: Re: [PATCH v4 2/6] phy: qcom-qmp-pcie: split PHY programming to
 separate functions
Message-ID: <YzFVyxhRidGKPR0p@hovoldconsulting.com>
References: <20220924160302.285875-1-dmitry.baryshkov@linaro.org>
 <20220924160302.285875-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924160302.285875-3-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 24, 2022 at 07:02:58PM +0300, Dmitry Baryshkov wrote:
> Split the code using PHY programming tables into separate functions,
> which take a single struct qmp_phy_cfg_tables instance.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 80 ++++++++++++++----------
>  1 file changed, 48 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 30806816c8b0..6e8c74585670 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1877,15 +1877,53 @@ static void qmp_pcie_configure(void __iomem *base,
>  	qmp_pcie_configure_lane(base, regs, tbl, num, 0xff);
>  }
>  
> -static int qmp_pcie_serdes_init(struct qmp_phy *qphy)
> +static void qmp_pcie_serdes_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
>  {
>  	const struct qmp_phy_cfg *cfg = qphy->cfg;
>  	void __iomem *serdes = qphy->serdes;
>  
> -	qmp_pcie_configure(serdes, cfg->regs, cfg->common.serdes_tbl, cfg->common.serdes_tbl_num);
> -	qmp_pcie_configure(serdes, cfg->regs, cfg->extra->serdes_tbl, cfg->extra->serdes_tbl_num);
> +	if (!tables)
> +		return;
>  
> -	return 0;
> +	qmp_pcie_configure(serdes, cfg->regs, tables->serdes_tbl, tables->serdes_tbl_num);

See what I mean about "_tbl" being redundant in "tables->serdes_tbl"?

> +}

>  static int qmp_pcie_init(struct phy *phy)
> @@ -1957,15 +1995,13 @@ static int qmp_pcie_power_on(struct phy *phy)
>  	struct qmp_phy *qphy = phy_get_drvdata(phy);
>  	struct qcom_qmp *qmp = qphy->qmp;
>  	const struct qmp_phy_cfg *cfg = qphy->cfg;
> -	void __iomem *tx = qphy->tx;
> -	void __iomem *rx = qphy->rx;
>  	void __iomem *pcs = qphy->pcs;
> -	void __iomem *pcs_misc = qphy->pcs_misc;
>  	void __iomem *status;
>  	unsigned int mask, val, ready;
>  	int ret;
>  
> -	qmp_pcie_serdes_init(qphy);
> +	qmp_pcie_serdes_init(qphy, &cfg->common);
> +	qmp_pcie_serdes_init(qphy, cfg->extra);

And "common" and "extra" doesn't really say what it is you're passing
here.

>  
>  	ret = clk_prepare_enable(qphy->pipe_clk);
>  	if (ret) {

Johan
