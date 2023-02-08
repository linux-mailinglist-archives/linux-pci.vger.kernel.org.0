Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3949768F414
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 18:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjBHROB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 12:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBHROA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 12:14:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ED913D52;
        Wed,  8 Feb 2023 09:13:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D889B81F02;
        Wed,  8 Feb 2023 17:13:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22341C433EF;
        Wed,  8 Feb 2023 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675876437;
        bh=uIn14lKQnE4MQMzWpMduYFj1ngI5uQm7hYWdO129A20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RN8YOLUV8gEKc+AyiCT/ftGUAoXNDT0DJ5CuGmHCjLmYz6q2zJx9NqcKNV+F9Q6//
         XYXRPH8Jf9yxUbCsJCrU0a570yg7EtEfoxiDm0ZwLcxEg4x+1J3Xz/P557zioileje
         EcSmxfxsZHFuzgVVy5RNrvZe00FE7rK9MHWWi+x461gN1RHEzoCg6QUIBfaOE02h2H
         ox4gMmAtd5YvB+9JxT6k9vd5Kmoaz7Obj9l4CoGZjF78CPFFwzSH265At2annbgD3u
         HvaG0ZdKKB1rOxTlagS/AU3vHagQoCDRiaWRYPVjQ4rRJUSe71LnQlTcWQINaSc/+8
         A/y+n8r+/cUJA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pPo1h-00068l-QX; Wed, 08 Feb 2023 18:14:33 +0100
Date:   Wed, 8 Feb 2023 18:14:33 +0100
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
Message-ID: <Y+PYeRo8X8ugXyoi@hovoldconsulting.com>
References: <20230203081807.2248625-1-abel.vesa@linaro.org>
 <20230203081807.2248625-11-abel.vesa@linaro.org>
 <Y9zYpE/GnxUqnIyq@hovoldconsulting.com>
 <Y+EYhe/xYSFpI1Yn@linaro.org>
 <Y+PQYxh4t/ytOe3+@hovoldconsulting.com>
 <Y+PXeYrBBL3QaznM@linaro.org>
 <Y+PXrFxobTf/+X+U@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+PXrFxobTf/+X+U@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 08, 2023 at 07:11:08PM +0200, Abel Vesa wrote:
> On 23-02-08 19:10:17, Abel Vesa wrote:
> > On 23-02-08 17:40:03, Johan Hovold wrote:
> > > On Mon, Feb 06, 2023 at 05:11:01PM +0200, Abel Vesa wrote:
> > > > On 23-02-03 10:49:24, Johan Hovold wrote:
> > > > > On Fri, Feb 03, 2023 at 10:18:05AM +0200, Abel Vesa wrote:
> > > > > > Add compatible for both PCIe found on SM8550.
> > > > > > Also add the cnoc_pcie_sf_axi clock needed by the SM8550.
> > > > > 
> > > > > nit: You're now also adding 'noc_aggr'
> > > > > 
> > > > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > > > > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > > > > > ---
> > > 
> > > > > > @@ -182,10 +182,10 @@ struct qcom_pcie_resources_2_3_3 {
> > > > > >  
> > > > > >  /* 6 clocks typically, 7 for sm8250 */
> > > > > >  struct qcom_pcie_resources_2_7_0 {
> > > > > > -	struct clk_bulk_data clks[12];
> > > > > > +	struct clk_bulk_data clks[14];
> > > > > >  	int num_clks;
> > > > > >  	struct regulator_bulk_data supplies[2];
> > > > > > -	struct reset_control *pci_reset;
> > > > > > +	struct reset_control *rst;
> > > > > 
> > > > > Please name this one 'reset' or 'resets' (e.g. to avoid hard to parse
> > > > > things like res->rst below).
> > > > 
> > > > Well, it would then be inconsitent with 2_3_3 and 2_9_0, which both use
> > > > rst.
> > > 
> > > Yeah, I saw that. Fortunately these resources are completely
> > > independent, but whatever.
> > 
> > Will do it in the next version then.

Or just leave it as is.

> > > > > >  };
> > > > > >  
> > > > > >  struct qcom_pcie_resources_2_9_0 {
> > > > > > @@ -1177,9 +1177,9 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> > > > > >  	unsigned int idx;
> > > > > >  	int ret;
> > > > > >  
> > > > > > -	res->pci_reset = devm_reset_control_get_exclusive(dev, "pci");
> > > > > > -	if (IS_ERR(res->pci_reset))
> > > > > > -		return PTR_ERR(res->pci_reset);
> > > > > > +	res->rst = devm_reset_control_array_get_exclusive(dev);
> > > > > > +	if (IS_ERR(res->rst))
> > > > > > +		return PTR_ERR(res->rst);
> > > > > 
> > > > > So the reset array implementation apparently both asserts and deasserts
> > > > > the resets in the order specified in DT (i.e. does not deassert in
> > > > > reverse order).
> > > > > 
> > > > > Is that ok also for the new "pci" and "link_down" resets?
> > > > 
> > > > According to the HPG, yes, this is perfectly fine. It specifically says
> > > > to assert the pcie reset and then continues saying to assert the
> > > > link_down reset.
> > > 
> > > Ok, but that doesn't really say anything about whether it's ok to
> > > *deassert* them in the same order, which was what I asked about.
> > 
> > Actually, what I wanted to say is that the HPG says something like this:
> > 
> > "assert pcie reset, then assert link_down"
> > 
> > and then at the end it literaly repeats the same phrase.
> 
> but uses deassert instead of assert ...

Ok, then it seems to match the implementation. Thanks for clarifying.

Johan
