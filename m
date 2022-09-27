Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685055EBEDF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiI0Jpo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 05:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiI0Jpn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 05:45:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A843511161;
        Tue, 27 Sep 2022 02:45:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16738B81A9A;
        Tue, 27 Sep 2022 09:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82C5C433D7;
        Tue, 27 Sep 2022 09:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664271934;
        bh=WQQflwImlllyVgjzTHWOpEtOO7mSqNuRbHDttqbWQsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F6YWgpNnhWNznblv+kd7GZ0nFcyo344bPP5Kp1ud4+9cBEJ7XGh4jbSKqVw7F59lk
         yXFbL5HGdRSgKyjw/ojfk2ZlTEURh/ukMG1CZqi9+A04YiigCq0YuFEhNKHg//39uF
         1WCeGLZgF+uPrUamBmU5J8GQC3Mzt5vT2+0aYoERyeI/NGA4rUBNfYDwADUi5yfIIp
         /4hFM0viZPDw5yB9w690fiy9WLoRIcJ0p9TxbjqX8+VPSKASZZ1v5jjspTYFat5zfh
         9py9C/GSPF3dnWj3oRpqL4iSiWiWauqV80cK5P3964PX1WGvgCUClkbchoGYGrNHTy
         hdnBbE7rcACYw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1od79o-0002OK-Tp; Tue, 27 Sep 2022 11:45:40 +0200
Date:   Tue, 27 Sep 2022 11:45:40 +0200
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
        linux-phy@lists.infradead.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v6 1/5] phy: qcom-qmp-pcie: split register tables into
 common and extra parts
Message-ID: <YzLGRJTQv1/7zPLJ@hovoldconsulting.com>
References: <20220927092207.161501-1-dmitry.baryshkov@linaro.org>
 <20220927092207.161501-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927092207.161501-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 27, 2022 at 12:22:02PM +0300, Dmitry Baryshkov wrote:
> SM8250 configuration tables are split into two parts: the common one and
> the PHY-specific tables. Make this split more formal. Rather than having
> a blind renamed copy of all QMP table fields, add separate struct
> qmp_phy_cfg_tables and add two instances of this structure to the struct
> qmp_phy_cfg. Later on this will be used to support different PHY modes
> (RC vs EP).
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

> +static void qmp_pcie_pcs_init(struct qmp_phy *qphy, const struct qmp_phy_cfg_tables *tables)
> +{
> +	const struct qmp_phy_cfg *cfg = qphy->cfg;
> +	void __iomem *pcs = qphy->pcs;
> +	void __iomem *pcs_misc = qphy->pcs_misc;
> +
> +	if (!tables)
> +		return;
> +
> +	qmp_pcie_configure(pcs, cfg->regs,
> +			   tables->pcs, tables->pcs_num);
> +	qmp_pcie_configure(pcs_misc, cfg->regs,
> +			   tables->pcs_misc, tables->pcs_misc_num);

nit: You missed the above unnecessary line breaks.

Johan
