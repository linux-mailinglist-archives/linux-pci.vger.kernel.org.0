Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F88669D23
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 17:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjAMQFO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 11:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjAMQEo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 11:04:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F64182BA1;
        Fri, 13 Jan 2023 07:54:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC4C0B82179;
        Fri, 13 Jan 2023 15:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1693C433D2;
        Fri, 13 Jan 2023 15:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673625272;
        bh=wrkNULpggDpVchIAZVx8OsQzCUww8BQdFsgmm/7AllM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rHia8pyeOSgI7LD235Kazl+TYrhVw41CU29QEFkyRMauLzU2ERMyaNBeUWAlM8iux
         o1MzT0EGC4m/o8n510e+hi4sqIQ+6/WBr/6+fRxOsnJfSfo2tNtgL5GbZN7PK1seve
         Q1s3zwD1NdUmWKLFKnt4gVERdIEG3Fjh8i24Pix/IofkG6gGA65gautrYEMpa/azuw
         vEc7XTD5bwFGMvBtg5R8xX5L5WRLeTmZn36oU1see3n41kO7wEHA2qhiYhwhlF6r9r
         gLNql7/9fixX7mLLhryDgH69a39R9dtoksgnXXyWto3VQ0vCioHHmW05nuTmYPiGER
         spbcdIx7QRdyg==
Date:   Fri, 13 Jan 2023 16:54:25 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: qcom: Use clk_bulk_ API for 1.0.0 clocks
 handling
Message-ID: <Y8F+sSf3yG1mLhJo@lpieralisi>
References: <20221020103120.1541862-1-dmitry.baryshkov@linaro.org>
 <20221020103120.1541862-3-dmitry.baryshkov@linaro.org>
 <Y1EsOGhEqNe9Cxo6@hovoldconsulting.com>
 <30850757-0e39-bd3d-0d4f-cdb4627b097c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30850757-0e39-bd3d-0d4f-cdb4627b097c@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 20, 2022 at 02:22:47PM +0300, Dmitry Baryshkov wrote:
> On 20/10/2022 14:08, Johan Hovold wrote:
> > On Thu, Oct 20, 2022 at 01:31:18PM +0300, Dmitry Baryshkov wrote:
> > > Change hand-coded implementation of bulk clocks to use the existing
> > 
> > Let's hope everything is "hand-coded" at least for a few years still
> > (job security). ;)
> > 
> > Perhaps rephrase using "open-coded"?
> 
> Yes, thank you.

If that's the only change required I can fix it up when merging the
series.

Please let me know.

Thanks,
Lorenzo

> > 
> > > clk_bulk_* API.
> > > 
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 67 ++++++--------------------
> > >   1 file changed, 16 insertions(+), 51 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 939f19241356..74588438db07 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -133,10 +133,7 @@ struct qcom_pcie_resources_2_1_0 {
> > >   };
> > >   struct qcom_pcie_resources_1_0_0 {
> > > -	struct clk *iface;
> > > -	struct clk *aux;
> > > -	struct clk *master_bus;
> > > -	struct clk *slave_bus;
> > > +	struct clk_bulk_data clks[4];
> > >   	struct reset_control *core;
> > >   	struct regulator *vdda;
> > >   };
> > > @@ -472,26 +469,20 @@ static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
> > >   	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
> > >   	struct dw_pcie *pci = pcie->pci;
> > >   	struct device *dev = pci->dev;
> > > +	int ret;
> > >   	res->vdda = devm_regulator_get(dev, "vdda");
> > >   	if (IS_ERR(res->vdda))
> > >   		return PTR_ERR(res->vdda);
> > > -	res->iface = devm_clk_get(dev, "iface");
> > > -	if (IS_ERR(res->iface))
> > > -		return PTR_ERR(res->iface);
> > > -
> > > -	res->aux = devm_clk_get(dev, "aux");
> > > -	if (IS_ERR(res->aux))
> > > -		return PTR_ERR(res->aux);
> > > -
> > > -	res->master_bus = devm_clk_get(dev, "master_bus");
> > > -	if (IS_ERR(res->master_bus))
> > > -		return PTR_ERR(res->master_bus);
> > > +	res->clks[0].id = "aux";
> > > +	res->clks[1].id = "iface";
> > > +	res->clks[2].id = "master_bus";
> > > +	res->clks[3].id = "slave_bus";
> > > -	res->slave_bus = devm_clk_get(dev, "slave_bus");
> > > -	if (IS_ERR(res->slave_bus))
> > > -		return PTR_ERR(res->slave_bus);
> > > +	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> > > +	if (ret < 0)
> > > +		return ret;
> > 
> > Are you sure there are no dependencies between these clocks and that
> > they can be enabled and disabled in any order?
> 
> The order is enforced by the bulk API. Forward to enable, backward to
> disable.
> 
> > 
> > Are you also convinced that they will always be enabled and disabled
> > together (e.g. not controlled individually during suspend)?
> 
> From what I see downstream, yes. They separate host and pipe clocks, but for
> each of these groups all clocks are disabled and enabled in sequence.
> 
> For the newer platforms the only exceptions are refgen (handled by the PHY
> in our kernels) and ddrss_sf_tbu (only on some platforms), which is not
> touched by these patches.
> 
> > 
> > > -	ret = clk_prepare_enable(res->aux);
> > > +	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> > >   	if (ret) {
> > > -		dev_err(dev, "cannot prepare/enable aux clock\n");
> > > +		dev_err(dev, "cannot prepare/enable clocks\n");
> > 
> > The bulk API already logs an error so you can drop the dev_err().
> 
> Ack.
> 
> > 
> > These comments apply also to the other patches.
> > 
> > Johan
> 
> -- 
> With best wishes
> Dmitry
> 
