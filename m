Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91F355A349
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 23:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiFXVHA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 17:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiFXVG5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 17:06:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7076985D1F;
        Fri, 24 Jun 2022 14:06:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E2DDB82C3A;
        Fri, 24 Jun 2022 21:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C542AC34114;
        Fri, 24 Jun 2022 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656104802;
        bh=T7qFMP9F8OdEyOzO8L7hDgPUIHk20/SjsuNA7mm3H3E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E8B7zaWej1LCg91sVtYDKamZbZDXTEnlN720Dpd6TyUxeBPHAlH1wA7hyBairLfQG
         qvRwC1x/bxNgGThZllbdTgybsz5oEIxjUF+XdNknAn/elRzrhIRaHGU9HqU0vPbH7f
         0CcAu55atHrf5Gr3iUeNb5E2NzP//Zt8VYmHueCXig6RkSWSOxNl3nXlS+YahpeFTQ
         rDrLWMvI1HKOdlDiRhYZ/EWk/Jd2vpzHB5CYtWebM6MUYogZIzf3YsASsY1bsN0Oa4
         AzfCg+Ofatftv2M1qbx83buLIc4b1QJjiAx3Y9364MfcC10xKOv+n1M9eP6peGkQf1
         f/z30lW78Bzrw==
Date:   Fri, 24 Jun 2022 16:06:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <pmaliset@qti.qualcomm.com>
Subject: Re: [PATCH v1 1/3] PCI: qcom: Add missing sc7280 clocks in PCIe
 driver
Message-ID: <20220624210640.GA1558213@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624170501.GA1541553@bhelgaas>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[update Prasad's email address since pmaliset@codeaurora.org bounced]

On Fri, Jun 24, 2022 at 12:05:03PM -0500, Bjorn Helgaas wrote:
> [+cc Prasad, who added sc7280]
> 
> On Fri, Jun 24, 2022 at 02:49:49PM +0530, Krishna chaitanya chundru wrote:
> > Add missing clocks in the pcie driver.
> 
> s/pcie/PCIe/ as in subject.  Also, please mention the names of the
> clocks here, too.
> 
> Does this add new functionality, or did sc7280 just never work in the
> first place?
> 
> If this fixes a problem, it's nice to mention the user-visible symptom
> in the commit log to make it easier to connect this fix with the
> problem.
> 
> Looks like sc7280 was added by Prasad with b89ff410253d ("PCI: qcom:
> Replace ops with struct pcie_cfg in pcie match data"), and I assume it
> was tested at that time.
> 
> If I had noticed, I would have asked that b89ff410253d be a strict
> conversion to struct qcom_pcie_cfg with no functional changes, with
> sc7280 support being added in a separate patch by itself.
> 
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 2ea1375..a7202f0 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1548,7 +1548,10 @@ static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
> >  static const struct qcom_pcie_cfg sc7280_cfg = {
> >  	.ops = &ops_1_9_0,
> >  	.has_tbu_clk = true,
> > +	.has_ddrss_sf_tbu_clk = true,
> >  	.pipe_clk_need_muxing = true,
> > +	.has_aggre0_clk = true,
> > +	.has_aggre1_clk = true,
> >  };
> >  
> >  static const struct qcom_pcie_cfg sc8180x_cfg = {
> > -- 
> > 2.7.4
> > 
