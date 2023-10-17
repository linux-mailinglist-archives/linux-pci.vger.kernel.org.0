Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871367CCA02
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 19:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjJQRlL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 13:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjJQRlK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 13:41:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9CF90;
        Tue, 17 Oct 2023 10:41:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CFCC433C7;
        Tue, 17 Oct 2023 17:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697564469;
        bh=CKtahp9lZame+MBMu3Ap4/3ql/d/3MJzImxyjKqupI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bs+pa9vphgySRe2g7P6+VZKhcOdLSVV04/fsM5WMqsb3cCmIgPptRi50dsrzs0K0b
         ofISsaMSPvgfNlFQKbt5pfDi/8gMn/gmn3rSCizn7uU+s8+rECyYaW0K3m3DKVISQX
         51WxR0duO6sKq2piZwBwUFxucunP1nUx3aXe+XYFQ1xykKiB+C6QaZpVbLE9WAiqne
         eBMskLBH1ciewVZqRHMupvADF5+/iHqpsdWNkihmOMI+MrzMjfI3xRyR20wXFlBSN2
         s5m7cXottrLKQQkrTu6/mIAHZfhrZAoxrXDDKX1bWtzw17sksnhhokELhcK63Vr2SP
         xq3ZormSFlHNA==
Date:   Tue, 17 Oct 2023 23:11:00 +0530
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
Message-ID: <20231017174100.GA137137@thinkpad>
References: <20231017-pcie-qcom-bar-v1-0-3e26de07bec0@linaro.org>
 <20231017-pcie-qcom-bar-v1-2-3e26de07bec0@linaro.org>
 <20231017142431.GR3553829@hu-bjorande-lv.qualcomm.com>
 <20231017162129.GF5274@thinkpad>
 <20231017165609.GT3553829@hu-bjorande-lv.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017165609.GT3553829@hu-bjorande-lv.qualcomm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 09:56:09AM -0700, Bjorn Andersson wrote:
> On Tue, Oct 17, 2023 at 09:51:29PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Oct 17, 2023 at 07:24:31AM -0700, Bjorn Andersson wrote:
> > > On Tue, Oct 17, 2023 at 11:47:55AM +0530, Manivannan Sadhasivam wrote:
> > > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > 
> > > Your S-o-b should match this.
> > > 
> > 
> > I gave b4 a shot for sending the patches and missed this. Will fix it in next
> > version.
> > 
> > > > 
> > > > Qcom EP platforms require enabling/disabling the DBI CS2 access while
> > > > programming some read only and shadow registers through DBI. So let's
> > > > implement the dbi_cs2_access() callback that will be called by the DWC core
> > > > while programming such registers like BAR mask register.
> > > > 
> > > > Without DBI CS2 access, writes to those registers will not be reflected.
> > > > 
> > > > Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > index 32c8d9e37876..4653cbf7f9ed 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > > > @@ -124,6 +124,7 @@
> > > >  
> > > >  /* ELBI registers */
> > > >  #define ELBI_SYS_STTS				0x08
> > > > +#define ELBI_CS2_ENABLE				0xa4
> > > >  
> > > >  /* DBI registers */
> > > >  #define DBI_CON_STATUS				0x44
> > > > @@ -262,6 +263,18 @@ static void qcom_pcie_dw_stop_link(struct dw_pcie *pci)
> > > >  	disable_irq(pcie_ep->perst_irq);
> > > >  }
> > > >  
> > > > +static void qcom_pcie_dbi_cs2_access(struct dw_pcie *pci, bool enable)
> > > > +{
> > > > +	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> > > > +
> > > > +	writel_relaxed(enable, pcie_ep->elbi + ELBI_CS2_ENABLE);
> > > 
> > > Don't you want to maintain the ordering of whatever write came before
> > > this?
> > > 
> > 
> > Since this in a dedicated function, I did not care about the ordering w.r.t
> > previous writes. Even if it gets inlined, the order should not matter since it
> > only enables/disables the CS2 access for the forthcoming writes.
> > 
> 
> The wmb() - in a non-relaxed writel -  would ensure that no earlier
> writes are reordered and end up in your expected set of "forthcoming
> writes".
> 

I was under the impression that the readl_relaxed() here serves as an implicit
barrier. But reading the holy memory-barriers documentation doesn't explicitly
say so. So I'm going to add wmb() to be on the safe side as you suggested.

Thanks for pointing it out.

- Mani

> Not sure that the code is wrong, I just want you to be certain that this
> isn't a problem.
> 
> Thanks,
> Bjorn

-- 
மணிவண்ணன் சதாசிவம்
