Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DE152A90A
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 19:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbiEQRTC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 13:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiEQRTB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 13:19:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417704B1D2;
        Tue, 17 May 2022 10:19:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1F7661418;
        Tue, 17 May 2022 17:18:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE36BC385B8;
        Tue, 17 May 2022 17:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652807939;
        bh=5sd8iGWC62FEKOeHZrDhRMiAlzsNY9Pwd8gS8qwqalQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=c6MM8CGTGJlNi5tjXShrV7/Lrncit6stio/NmoQdI4Dv/6um0qByKhB5T2V/Atg2M
         oRLWUorOL+fTojAclc8AlTvF9eOuHuO/ZzFgrU78flheudflDjJb/dJKcfaQ0JKDjl
         JiEeq/w0kOW+2HJEqhVzq6rE0pjktLWNeSDwIJ5iGARg8X2R+y2pDetu2bOLWDjkTH
         4s6REUO5aVZqB7y4NoGBNjnRb2KbyFf1jLl5Vw88K2bTynOTstD54PeBjNM8t0pi2G
         SdU49PctoiXjEvmVzkek4w6SfXpYw16p5i5D/SI/DqZwmRwsHcPzy4hAIUHU7UDKOP
         sjI6KQCsEfeBQ==
Date:   Tue, 17 May 2022 12:18:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jens Axboe <axboe@fb.com>,
        Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>,
        quic_krichai@quicinc.com, Nitin Rawat <quic_nitirawa@quicinc.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Andy Gross <agross@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Rama Krishna <quic_ramkri@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH 2/3] PCI: dwc: qcom: Set suspend_poweroff flag for SC7280
Message-ID: <20220517171857.GA1083896@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517151134.GB4528@thinkpad>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Prasad, Andy, Rob, Krzysztof, Rajat, Saheed, Rama, Stephen,
Dmitry, Kalle for connection to https://lore.kernel.org/lkml/CAE-0n53ho2DX2rqQMvvKAuDCfsWW62TceTaNPzv5Mn_NQ-U6dA@mail.gmail.com/T/]

Subject line convention for this file is "PCI: qcom:" (not "PCI: dwc:
qcom:").

Find this from "git log --oneline drivers/pci/controller/dwc/pcie-qcom.c".

On Tue, May 17, 2022 at 08:41:34PM +0530, Manivannan Sadhasivam wrote:
> On Mon, May 16, 2022 at 03:19:50PM -0500, Bjorn Helgaas wrote:
> > On Fri, May 13, 2022 at 04:30:26PM +0530, Manivannan Sadhasivam wrote:
> > > For aggressive power saving on SC7280 SoCs, the power for the
> > > PCI devices will be taken off during system suspend. Hence,
> > > notify the same to the PCI device drivers using
> > > "suspend_poweroff" flag so that the drivers can prepare the PCI
> > > devices to handle the poweroff and recover them during resume.
> > 
> > No doubt "power ... will be taken off during system suspend" is
> > true, but this isn't very informative.  Is this a property of
> > SC7280?  A choice made by the SC7280 driver?  Why is this not
> > applicable to other systems?
> 
> The SC7280's RPMh firmware is cutting off the PCIe power domain
> during system suspend. And as I explained in previous patch, the RC
> driver itself may put the devices in D3cold conditionally on this
> platform. The reason is to save power as this chipset is being used
> in Chromebooks.

It looks like this should be squashed into the patch you mentioned:
https://lore.kernel.org/lkml/CAE-0n53ho2DX2rqQMvvKAuDCfsWW62TceTaNPzv5Mn_NQ-U6dA@mail.gmail.com/T/

If Prasad's patch is applied without this, devices will be powered
off, but nvme will not be prepared for it.  Apparently something would
be broken in that case?

Also, I think this patch should be reordered so the nvme driver is
prepared for suspend_poweroff before the qcom driver starts setting
it.  Otherwise there's a window where qcom sets suspend_poweroff and
powers off devices, but nvme doesn't know about it, and I assume
something will be broken in that case?

Please mention RPMh in the commit log, along with the specific
connection with system suspend, i.e., what OS action enables RPMh to
cut power.

> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 6ab90891801d..4b0ad2827f8f 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -199,6 +199,7 @@ struct qcom_pcie_cfg {
> > >  	unsigned int has_ddrss_sf_tbu_clk:1;
> > >  	unsigned int has_aggre0_clk:1;
> > >  	unsigned int has_aggre1_clk:1;
> > > +	unsigned int suspend_poweroff:1;
> > >  };
> > >  
> > >  struct qcom_pcie {
> > > @@ -1220,6 +1221,10 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> > >  	if (pcie->cfg->pipe_clk_need_muxing)
> > >  		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
> > >  
> > > +	/* Indicate PCI device drivers that the power will be taken off during system suspend */
> > > +	if (pcie->cfg->suspend_poweroff)
> > > +		pci->pp.bridge->suspend_poweroff = true;
> > > +
> > >  	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> > >  	if (ret < 0)
> > >  		goto err_disable_regulators;
> > > @@ -1548,6 +1553,7 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
> > >  	.ops = &ops_1_9_0,
> > >  	.has_tbu_clk = true,
> > >  	.pipe_clk_need_muxing = true,
> > > +	.suspend_poweroff = true,
> > >  };
> > >  
> > >  static const struct dw_pcie_ops dw_pcie_ops = {
> > > -- 
> > > 2.25.1
> > > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
