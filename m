Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163E27CEEF4
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 07:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjJSFTl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 01:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjJSFTk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 01:19:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF789A4;
        Wed, 18 Oct 2023 22:19:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C73C433C7;
        Thu, 19 Oct 2023 05:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697692778;
        bh=EXzdeQ1GH3kZueYinwHXXHlHvuq/2uaQmEbSlzU2iCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fCXZEnCec4VeWFh/83MUZgZEXqbWLOlUWk3EjITy+HikX/NBvQ6tYzWOsmvVeSBiV
         JfS7fk89KLJ8QKyYACpy2qUwWBO78z6RtxHFnT73DrHHu+XUAZ2QuDMRN2Ybw/OAN7
         I9MkEfBtuU2dYzTp798818keOP7brjVVrxbywAdBbXeWBXipCl326czoVvE7ehuq3h
         raU7+ogSGVk4J2m/wvXJ4H2AzQ2vqjrQAZytMfMmH36V49nT9u8JLTInW5QD7qVlJr
         Zze+rra77OfjsPm2XQgnOWSwvqK2V9Qi8CUpvORh9A9Obi4lcEORGQOgyXYtN1BhjA
         eYtuYr62ZEiUw==
Date:   Thu, 19 Oct 2023 10:49:30 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: qcom-ep: Implement dbi_cs2_access() function
 callback for DBI CS2 access
Message-ID: <20231019051930.GB5142@thinkpad>
References: <20231017-pcie-qcom-bar-v1-0-3e26de07bec0@linaro.org>
 <20231017-pcie-qcom-bar-v1-2-3e26de07bec0@linaro.org>
 <20231017142431.GR3553829@hu-bjorande-lv.qualcomm.com>
 <20231017162129.GF5274@thinkpad>
 <20231017165609.GT3553829@hu-bjorande-lv.qualcomm.com>
 <20231017174100.GA137137@thinkpad>
 <20231017221811.GV3553829@hu-bjorande-lv.qualcomm.com>
 <20231018132758.GD47321@thinkpad>
 <20231019031820.GX3553829@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019031820.GX3553829@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 18, 2023 at 08:18:20PM -0700, Bjorn Andersson wrote:
> On Wed, Oct 18, 2023 at 06:57:58PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Oct 17, 2023 at 03:18:11PM -0700, Bjorn Andersson wrote:
> > > On Tue, Oct 17, 2023 at 11:11:00PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Oct 17, 2023 at 09:56:09AM -0700, Bjorn Andersson wrote:
> > > > > On Tue, Oct 17, 2023 at 09:51:29PM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Tue, Oct 17, 2023 at 07:24:31AM -0700, Bjorn Andersson wrote:
> > > > > > > On Tue, Oct 17, 2023 at 11:47:55AM +0530, Manivannan Sadhasivam wrote:
> > > > > > > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > > > > > 
> > > > > > > Your S-o-b should match this.
> > > > > > > 
> > > > > > 
> > > > > > I gave b4 a shot for sending the patches and missed this. Will fix it in next
> > > > > > version.
> > > > > > 
> > > > > > > > 
> > > > > > > > Qcom EP platforms require enabling/disabling the DBI CS2 access while
> > > > > > > > programming some read only and shadow registers through DBI. So let's
> > > > > > > > implement the dbi_cs2_access() callback that will be called by the DWC core
> > > > > > > > while programming such registers like BAR mask register.
> > > > > > > > 
> > > > > > > > Without DBI CS2 access, writes to those registers will not be reflected.
> > > > > > > > 
> > > > > > > > Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> > > > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > > > ---
> > > > > > > >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 14 ++++++++++++++
> > > > > > > >  1 file changed, 14 insertions(+)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > > > > > index 32c8d9e37876..4653cbf7f9ed 100644
> > > > > > > > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > > > > > @@ -124,6 +124,7 @@
> > > > > > > >  
> > > > > > > >  /* ELBI registers */
> > > > > > > >  #define ELBI_SYS_STTS				0x08
> > > > > > > > +#define ELBI_CS2_ENABLE				0xa4
> > > > > > > >  
> > > > > > > >  /* DBI registers */
> > > > > > > >  #define DBI_CON_STATUS				0x44
> > > > > > > > @@ -262,6 +263,18 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
> > > > > > > >  	disable_irq(pcie_ep->perst_irq);
> > > > > > > >  }
> > > > > > > >  
> > > > > > > > +static void qcom_pcie_dbi_cs2_access(struct dw_pcie *pci, bool enable)
> > > > > > > > +{
> > > > > > > > +	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> > > > > > > > +
> > > > > > > > +	writel_relaxed(enable, pcie_ep->elbi + ELBI_CS2_ENABLE);
> > > > > > > 
> > > > > > > Don't you want to maintain the ordering of whatever write came before
> > > > > > > this?
> > > > > > > 
> > > > > > 
> > > > > > Since this in a dedicated function, I did not care about the ordering w.r.t
> > > > > > previous writes. Even if it gets inlined, the order should not matter since it
> > > > > > only enables/disables the CS2 access for the forthcoming writes.
> > > > > > 
> > > > > 
> > > > > The wmb() - in a non-relaxed writel -  would ensure that no earlier
> > > > > writes are reordered and end up in your expected set of "forthcoming
> > > > > writes".
> > > > > 
> > > > 
> > > > I was under the impression that the readl_relaxed() here serves as an implicit
> > > > barrier. But reading the holy memory-barriers documentation doesn't explicitly
> > > > say so. So I'm going to add wmb() to be on the safe side as you suggested.
> > > > 
> > > 
> > > I'm talking about writes prior to this function is being called.
> > > 
> > > In other words, if you write:
> > > 
> > > writel_relaxed(A, ptr); (or writel, it doesn't matter)
> > > writel_relaxed(X, ELBI_CS2_ENABLE);
> > > readl_relaxed(ELBI_CS2_ENABLE);
> > > 
> > > Then there are circumstances where the write to ptr might be performed
> > > after ELBI_CS2_ENABLE.
> > > 
> > 
> > That shouldn't cause any issues as CS2_ENABLE just opens up the write access to
> > read only registers. It will cause issues if CPU/compiler reorders this write
> > with the following writes where we actually write to the read only registers.
> > 
> 
> Wouldn't that cause issues if previous writes are reordered past a
> disable?
> 

That should be fixed by wmb() after CS_ENABLE.

> > For that I initially thought the readl_relaxed() would be sufficient. But
> > looking more, it may not be enough since CS2_ENABLE register lies in ELBI space
> > and the read only registers are in DBI space. So the CPU may reorder writes if
> > this function gets inlined by the compiler since both are in different hardware
> > space (not sure if CPU considers both regions as one since they are in PCI
> > domain, in that case the barrier is not required, but I'm not sure).
> 
> That is a very good question (if the regions are considered the same or
> different), I don't know.
> 
> > 
> > So to be on the safe side, I should add wmb() after the CS2_ENABLE write.
> > 
> 
> Sounds reasonable, in absence of the answer to above question.
> 

Thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
