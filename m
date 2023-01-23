Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787A9677646
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 09:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjAWI1h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 03:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAWI1h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 03:27:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90335196A0;
        Mon, 23 Jan 2023 00:27:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2961460DDE;
        Mon, 23 Jan 2023 08:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7203AC4339B;
        Mon, 23 Jan 2023 08:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674462455;
        bh=OQxf5cHhznOPaRiG+Bzw+GhjQlu9qjJCNC3JaFSHGHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IFpORtBnIh5wdoRQ9JDTdL4sSP3RQvJNn/Qhr3ZvXV5trCyNGdDYGdydk5zKGcJP/
         IfaJrvLpnSqO0/WP39/CfEBAxBkOpx7HLvX4dsItPXB1HlsvfBTMwEgP9cLfvPVKDy
         vfkGufdy6L/1cOOskC2qOtJfUKo1am6kFWJKZvYJIkS+r+9TCi3FQutyZJJMz6rg2q
         l7WRarWb9MxNQSfkbd06xvLwIydylrRrHOoB4fWbreo51u2AS8x2zUft+lFY+0eXIv
         0jNupGoDBmp511xPObxLhKL1DEc822au9TlEfwC9U8Gps07y0ED3cy5FrS65SNeeTe
         /N1PZ1RNYmIow==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pJsAu-0007nw-88; Mon, 23 Jan 2023 09:27:32 +0100
Date:   Mon, 23 Jan 2023 09:27:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/12] PCI: qcom: Add SM8550 PCIe support
Message-ID: <Y85E9N2mLOEj9K49@hovoldconsulting.com>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
 <20230119140453.3942340-11-abel.vesa@linaro.org>
 <20230119142155.GA101896@thinkpad>
 <Y8ljLJ8vsqxdQtW8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8ljLJ8vsqxdQtW8@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 19, 2023 at 05:35:08PM +0200, Abel Vesa wrote:
> On 23-01-19 19:51:55, Manivannan Sadhasivam wrote:
> > On Thu, Jan 19, 2023 at 04:04:51PM +0200, Abel Vesa wrote:
> > > Add compatible for both PCIe found on SM8550.
> > > Also add the cnoc_pcie_sf_axi clock needed by the SM8550.
> > > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > 
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > 
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > ---

> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 77e5dc7b88ad..30f74bc51dbf 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -182,7 +182,7 @@ struct qcom_pcie_resources_2_3_3 {
> > >  
> > >  /* 6 clocks typically, 7 for sm8250 */
> > 
> > Now this comment is outdated ;)
> > 
> 
> Fair point. I'll wait for some more comments before
> I'll send a new version.

The comment is still correct, as several of these clocks are optional
and platform dependant. There's strictly no need to update it as part
of this patch.

> > >  struct qcom_pcie_resources_2_7_0 {
> > > -	struct clk_bulk_data clks[12];
> > > +	struct clk_bulk_data clks[13];
> > >  	int num_clks;
> > >  	struct regulator_bulk_data supplies[2];
> > >  	struct reset_control *pci_reset;
> > > @@ -1208,6 +1208,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> > >  	res->clks[idx++].id = "noc_aggr_4";
> > >  	res->clks[idx++].id = "noc_aggr_south_sf";
> > >  	res->clks[idx++].id = "cnoc_qx";
> > > +	res->clks[idx++].id = "cnoc_sf_axi";

Johan
