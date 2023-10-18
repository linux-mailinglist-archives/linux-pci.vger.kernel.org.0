Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F00B7CDD3C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 15:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjJRN2M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 09:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjJRN2K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 09:28:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B27115;
        Wed, 18 Oct 2023 06:28:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF23C433C9;
        Wed, 18 Oct 2023 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697635686;
        bh=iLmiQsrFLaoTQBSf63WblBjFMj7qtawoLyyCTo0IaaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZobnOmL8WENcMI6dMg0IuPhAas+ySO5bqbZpQP2XvCXd+u3MRzwxPYQdNHcGjd8tO
         eP/A5jnXYfQ0tVhPCyHbmy1V1j349j87eMwhWxzQfnO4x3PIcbqrJHdMnzkN3Cce1e
         cnK4qVmE8L/YUQypxniYUOjvtD6+ryZYCElTJ9HzxE+meGIcFspAfZsKZ9WuWn1jlG
         TdTOy9HlVouc6lF5KwsmZOk0v2dlzyB69+NYN5cCMnEwdaV1fzGI/QxfZhxljbStyq
         rxlpQVz8fv2LlQ7+7XpVHMWHQY+kruzpjPo9pXpvABB+icrPUC6VsjEfwjBQFZ4UYl
         Wx4dqw943zNYw==
Date:   Wed, 18 Oct 2023 18:57:58 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: qcom-ep: Implement dbi_cs2_access() function
 callback for DBI CS2 access
Message-ID: <20231018132758.GD47321@thinkpad>
References: <20231017-pcie-qcom-bar-v1-0-3e26de07bec0@linaro.org>
 <20231017-pcie-qcom-bar-v1-2-3e26de07bec0@linaro.org>
 <20231017142431.GR3553829@hu-bjorande-lv.qualcomm.com>
 <20231017162129.GF5274@thinkpad>
 <20231017165609.GT3553829@hu-bjorande-lv.qualcomm.com>
 <20231017174100.GA137137@thinkpad>
 <20231017221811.GV3553829@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017221811.GV3553829@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 03:18:11PM -0700, Bjorn Andersson wrote:
> On Tue, Oct 17, 2023 at 11:11:00PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Oct 17, 2023 at 09:56:09AM -0700, Bjorn Andersson wrote:
> > > On Tue, Oct 17, 2023 at 09:51:29PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Oct 17, 2023 at 07:24:31AM -0700, Bjorn Andersson wrote:
> > > > > On Tue, Oct 17, 2023 at 11:47:55AM +0530, Manivannan Sadhasivam wrote:
> > > > > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > > > 
> > > > > Your S-o-b should match this.
> > > > > 
> > > > 
> > > > I gave b4 a shot for sending the patches and missed this. Will fix it in next
> > > > version.
> > > > 
> > > > > > 
> > > > > > Qcom EP platforms require enabling/disabling the DBI CS2 access while
> > > > > > programming some read only and shadow registers through DBI. So let's
> > > > > > implement the dbi_cs2_access() callback that will be called by the DWC core
> > > > > > while programming such registers like BAR mask register.
> > > > > > 
> > > > > > Without DBI CS2 access, writes to those registers will not be reflected.
> > > > > > 
> > > > > > Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> > > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > > ---
> > > > > >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 14 ++++++++++++++
> > > > > >  1 file changed, 14 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > > > index 32c8d9e37876..4653cbf7f9ed 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > > > @@ -124,6 +124,7 @@
> > > > > >  
> > > > > >  /* ELBI registers */
> > > > > >  #define ELBI_SYS_STTS				0x08
> > > > > > +#define ELBI_CS2_ENABLE				0xa4
> > > > > >  
> > > > > >  /* DBI registers */
> > > > > >  #define DBI_CON_STATUS				0x44
> > > > > > @@ -262,6 +263,18 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
> > > > > >  	disable_irq(pcie_ep->perst_irq);
> > > > > >  }
> > > > > >  
> > > > > > +static void qcom_pcie_dbi_cs2_access(struct dw_pcie *pci, bool enable)
> > > > > > +{
> > > > > > +	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> > > > > > +
> > > > > > +	writel_relaxed(enable, pcie_ep->elbi + ELBI_CS2_ENABLE);
> > > > > 
> > > > > Don't you want to maintain the ordering of whatever write came before
> > > > > this?
> > > > > 
> > > > 
> > > > Since this in a dedicated function, I did not care about the ordering w.r.t
> > > > previous writes. Even if it gets inlined, the order should not matter since it
> > > > only enables/disables the CS2 access for the forthcoming writes.
> > > > 
> > > 
> > > The wmb() - in a non-relaxed writel -  would ensure that no earlier
> > > writes are reordered and end up in your expected set of "forthcoming
> > > writes".
> > > 
> > 
> > I was under the impression that the readl_relaxed() here serves as an implicit
> > barrier. But reading the holy memory-barriers documentation doesn't explicitly
> > say so. So I'm going to add wmb() to be on the safe side as you suggested.
> > 
> 
> I'm talking about writes prior to this function is being called.
> 
> In other words, if you write:
> 
> writel_relaxed(A, ptr); (or writel, it doesn't matter)
> writel_relaxed(X, ELBI_CS2_ENABLE);
> readl_relaxed(ELBI_CS2_ENABLE);
> 
> Then there are circumstances where the write to ptr might be performed
> after ELBI_CS2_ENABLE.
> 

That shouldn't cause any issues as CS2_ENABLE just opens up the write access to
read only registers. It will cause issues if CPU/compiler reorders this write
with the following writes where we actually write to the read only registers.

For that I initially thought the readl_relaxed() would be sufficient. But
looking more, it may not be enough since CS2_ENABLE register lies in ELBI space
and the read only registers are in DBI space. So the CPU may reorder writes if
this function gets inlined by the compiler since both are in different hardware
space (not sure if CPU considers both regions as one since they are in PCI
domain, in that case the barrier is not required, but I'm not sure).

So to be on the safe side, I should add wmb() after the CS2_ENABLE write.

- Mani

> Iiuc, the way to avoid that is to either be certain that none of those
> circumstances applies, or to add a wmb(), like:
> 
> writel_relaxed(A, ptr); (or writel, it doesn't matter)
> wmb();
> writel_relaxed(X, ELBI_CS2_ENABLE);
> readl_relaxed(ELBI_CS2_ENABLE);
> 
> or short hand:
> 
> writel_relaxed(A, ptr); (or writel, it doesn't matter)
> writel(X, ELBI_CS2_ENABLE);
> readl_relaxed(ELBI_CS2_ENABLE);
> 
> Where the wmb() will ensure the two writes happen in order.
> 
> The read in your code will ensure that execution won't proceed until the
> write has hit the hardware, so that's good. But writing this makes me
> uncertain if there's sufficient guarantees for the CPU not reordering
> later operations.
> 
> Regards,
> Bjorn

-- 
மணிவண்ணன் சதாசிவம்
