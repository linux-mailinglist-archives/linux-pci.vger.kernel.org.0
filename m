Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285FD68F358
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 17:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjBHQjq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 11:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjBHQjn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 11:39:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D487A9B;
        Wed,  8 Feb 2023 08:39:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FFE061730;
        Wed,  8 Feb 2023 16:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0DAC433EF;
        Wed,  8 Feb 2023 16:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675874366;
        bh=AE/Drqhshv5oligE9Xn4bS2r0Y6nRHoieKEegHprzdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pv1Mtg2OkcqSUvj5ilX8YYy4SLI/ufRD19IpuOftclLsONK4bLjh2Cyj18Ov3+I92
         i0oBIjpT8xxgT5IUKSuJPkn1FYOjoE7iPpqjaSB4UnCAaiFvOcQr+5v06dGMvcGrNg
         E3yPxbXWTNFatCmuxAmUTVgi03jlq0Xttb7arRPSr0ZKl+rbp/jWA+/cqFmnTNuH5M
         f9nHyf3uVufBRQrh+Ts3ME6rgcOiXwX0DpD7L4s1vGlg79nb6+rwEui6YGDkDjoUwl
         qYN924LTcuDAnVcPf1gGeXERowY4YlIrMpkXJE2s8IqWAdSpTWDVQZNvKgrGsIOO6P
         Ns3Lyx+xT8+rw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pPnUJ-0005v3-5o; Wed, 08 Feb 2023 17:40:03 +0100
Date:   Wed, 8 Feb 2023 17:40:03 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 10/12] PCI: qcom: Add SM8550 PCIe support
Message-ID: <Y+PQYxh4t/ytOe3+@hovoldconsulting.com>
References: <20230203081807.2248625-1-abel.vesa@linaro.org>
 <20230203081807.2248625-11-abel.vesa@linaro.org>
 <Y9zYpE/GnxUqnIyq@hovoldconsulting.com>
 <Y+EYhe/xYSFpI1Yn@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+EYhe/xYSFpI1Yn@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 06, 2023 at 05:11:01PM +0200, Abel Vesa wrote:
> On 23-02-03 10:49:24, Johan Hovold wrote:
> > On Fri, Feb 03, 2023 at 10:18:05AM +0200, Abel Vesa wrote:
> > > Add compatible for both PCIe found on SM8550.
> > > Also add the cnoc_pcie_sf_axi clock needed by the SM8550.
> > 
> > nit: You're now also adding 'noc_aggr'
> > 
> > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > > ---

> > > @@ -182,10 +182,10 @@ struct qcom_pcie_resources_2_3_3 {
> > >  
> > >  /* 6 clocks typically, 7 for sm8250 */
> > >  struct qcom_pcie_resources_2_7_0 {
> > > -	struct clk_bulk_data clks[12];
> > > +	struct clk_bulk_data clks[14];
> > >  	int num_clks;
> > >  	struct regulator_bulk_data supplies[2];
> > > -	struct reset_control *pci_reset;
> > > +	struct reset_control *rst;
> > 
> > Please name this one 'reset' or 'resets' (e.g. to avoid hard to parse
> > things like res->rst below).
> 
> Well, it would then be inconsitent with 2_3_3 and 2_9_0, which both use
> rst.

Yeah, I saw that. Fortunately these resources are completely
independent, but whatever.
 
> > >  };
> > >  
> > >  struct qcom_pcie_resources_2_9_0 {
> > > @@ -1177,9 +1177,9 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> > >  	unsigned int idx;
> > >  	int ret;
> > >  
> > > -	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
> > > -	if (IS_ERR(res->pci_reset))
> > > -		return PTR_ERR(res->pci_reset);
> > > +	res->rst = devm_reset_control_array_get_exclusive(dev);
> > > +	if (IS_ERR(res->rst))
> > > +		return PTR_ERR(res->rst);
> > 
> > So the reset array implementation apparently both asserts and deasserts
> > the resets in the order specified in DT (i.e. does not deassert in
> > reverse order).
> > 
> > Is that ok also for the new "pci" and "link_down" resets?
> 
> According to the HPG, yes, this is perfectly fine. It specifically says
> to assert the pcie reset and then continues saying to assert the
> link_down reset.

Ok, but that doesn't really say anything about whether it's ok to
*deassert* them in the same order, which was what I asked about.

Johan
