Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC237CC8A2
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 18:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjJQQVk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 12:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQQVj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 12:21:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751949E;
        Tue, 17 Oct 2023 09:21:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0F6C433C8;
        Tue, 17 Oct 2023 16:21:34 +0000 (UTC)
Date:   Tue, 17 Oct 2023 21:51:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: qcom-ep: Implement dbi_cs2_access() function
 callback for DBI CS2 access
Message-ID: <20231017162129.GF5274@thinkpad>
References: <20231017-pcie-qcom-bar-v1-0-3e26de07bec0@linaro.org>
 <20231017-pcie-qcom-bar-v1-2-3e26de07bec0@linaro.org>
 <20231017142431.GR3553829@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017142431.GR3553829@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 07:24:31AM -0700, Bjorn Andersson wrote:
> On Tue, Oct 17, 2023 at 11:47:55AM +0530, Manivannan Sadhasivam wrote:
> > From: Manivannan Sadhasivam <mani@kernel.org>
> 
> Your S-o-b should match this.
> 

I gave b4 a shot for sending the patches and missed this. Will fix it in next
version.

> > 
> > Qcom EP platforms require enabling/disabling the DBI CS2 access while
> > programming some read only and shadow registers through DBI. So let's
> > implement the dbi_cs2_access() callback that will be called by the DWC core
> > while programming such registers like BAR mask register.
> > 
> > Without DBI CS2 access, writes to those registers will not be reflected.
> > 
> > Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > index 32c8d9e37876..4653cbf7f9ed 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > @@ -124,6 +124,7 @@
> >  
> >  /* ELBI registers */
> >  #define ELBI_SYS_STTS				0x08
> > +#define ELBI_CS2_ENABLE				0xa4
> >  
> >  /* DBI registers */
> >  #define DBI_CON_STATUS				0x44
> > @@ -262,6 +263,18 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
> >  	disable_irq(pcie_ep->perst_irq);
> >  }
> >  
> > +static void qcom_pcie_dbi_cs2_access(struct dw_pcie *pci, bool enable)
> > +{
> > +	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> > +
> > +	writel_relaxed(enable, pcie_ep->elbi + ELBI_CS2_ENABLE);
> 
> Don't you want to maintain the ordering of whatever write came before
> this?
> 

Since this in a dedicated function, I did not care about the ordering w.r.t
previous writes. Even if it gets inlined, the order should not matter since it
only enables/disables the CS2 access for the forthcoming writes.

- Mani

> Regards,
> Bjorn
> 
> > +	/*
> > +	 * Do a dummy read to make sure that the previous write has reached the
> > +	 * memory before returning.
> > +	 */
> > +	readl_relaxed(pcie_ep->elbi + ELBI_CS2_ENABLE);
> > +}
> > +
> >  static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
> >  {
> >  	struct dw_pcie *pci = &pcie_ep->pci;
> > @@ -500,6 +513,7 @@ static const struct dw_pcie_ops pci_ops = {
> >  	.link_up = qcom_pcie_dw_link_up,
> >  	.start_link = qcom_pcie_dw_start_link,
> >  	.stop_link = qcom_pcie_dw_stop_link,
> > +	.dbi_cs2_access = qcom_pcie_dbi_cs2_access,
> >  };
> >  
> >  static int qcom_pcie_ep_get_io_resources(struct platform_device *pdev,
> > 
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
