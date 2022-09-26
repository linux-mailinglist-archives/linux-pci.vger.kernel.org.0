Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78365E99A6
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 08:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiIZGhy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 02:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbiIZGhw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 02:37:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896C99598;
        Sun, 25 Sep 2022 23:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8B5E6176B;
        Mon, 26 Sep 2022 06:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564C8C433D6;
        Mon, 26 Sep 2022 06:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664174270;
        bh=Qe9q43PNCvVX/HcS4sbwQ1ON37dLP7rnsPqYAzCOw98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gc6nfD/V68hkz9Z3H1WM1nrJAPtEa4F4Wcd5aTgdylEcHco7/aWLKRcBQhs5c5W9N
         iQ/NooakfuESR2QmqW0vGZFL94DxKWKJuCPdIs6QvA+VCb3tHVeJZaIP+kxDwGVjks
         d59WZfdFsUEARpauS0l/NtIRvsolv6h21KDgW/QLscS4uCklAop1G+2i2agIOjX5f6
         SrqZj5m0Gx1+hPUU7jUzPeearWcNzY+1dY0ZVwiIKgeYGViBWG9oMZMtoJCQoO8gjF
         +TCHQ0c2fZXRInWSVvdVxsn1/6EzOA5fps7WL01kivYq+S1T6ZVhIHmXMYDD26qWkN
         /oP6WsfqFS6Mw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ochkZ-0002Ba-M2; Mon, 26 Sep 2022 08:37:55 +0200
Date:   Mon, 26 Sep 2022 08:37:55 +0200
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
Message-ID: <YzFIw2TUGu/H0fSk@hovoldconsulting.com>
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
  
> @@ -2278,7 +2325,9 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
>  		qphy->pcs_misc = qphy->pcs + 0x400;
>  
>  	if (IS_ERR(qphy->pcs_misc)) {
> -		if (cfg->common.pcs_misc_tbl || cfg->extra->pcs_misc_tbl)
> +		if (cfg->common.pcs_misc_tbl ||
> +		    cfg->extra_rc->pcs_misc_tbl ||
> +		    cfg->extra_ep->pcs_misc_tbl)

More NULL derefs.

>  			return PTR_ERR(qphy->pcs_misc);
>  	}

Johan
