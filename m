Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EED7146AE
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 10:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjE2Iza (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 04:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjE2Iz2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 04:55:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6D799;
        Mon, 29 May 2023 01:55:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11C5C612FB;
        Mon, 29 May 2023 08:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C24AC4339B;
        Mon, 29 May 2023 08:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685350526;
        bh=i9OWnfmGmJQVxNLboSBkfNDRCM4AooOMGIVwfZgR5iI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q92vEVrXzUJr0mlI8GSb7Qd940qzEgMw9HA68RlTkPMu9aPFQQSG8QXHk2O6/60gb
         TLj79uIJvG9CNkKPxtJyouG9FsORzuej0iS6qN85GE6RT0OEZBh/qSxTHLv9NmLMvw
         wTxgdHoQ9d5Y3hZMf4s97tchiwaaZooPevQ73zo/AYNNYKJs0vg3t/B+yLNL8grrjx
         LazyDJpX9zui//MZUOjEctHRVq3b7TxUtchfowuU/5HusSHjG3HXR4pNxBdipJGNeJ
         LG6c6C0lkXxmpv34I1yYKYyZc55lsAlZW8r0goh3b+p6H5d+r97KXwnLD4bpqTb2tO
         v/K3LifVnImCA==
Date:   Mon, 29 May 2023 14:25:12 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        kw@linux.com, bhelgaas@google.com, robh@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com, dmitry.baryshkov@linaro.org,
        Dmitry Baryshkov <dmitry.baryshkov@gmail.com>
Subject: Re: [PATCH v2 2/8] PCI: qcom: Disable write access to read only
 registers for IP v2.9.0
Message-ID: <20230529085512.GB5633@thinkpad>
References: <20230519143117.23875-1-manivannan.sadhasivam@linaro.org>
 <20230519143117.23875-3-manivannan.sadhasivam@linaro.org>
 <ZGsuM8CAv7AtluVx@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGsuM8CAv7AtluVx@lpieralisi>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 22, 2023 at 10:56:19AM +0200, Lorenzo Pieralisi wrote:
> On Fri, May 19, 2023 at 08:01:11PM +0530, Manivannan Sadhasivam wrote:
> > In the post init sequence of v2.9.0, write access to read only registers
> > are not disabled after updating the registers. Fix it by disabling the
> > access after register update.
> > 
> > Fixes: 0cf7c2efe8ac ("PCI: qcom: Add IPQ60xx support")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@gmail.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 01795ee7ce45..391a45d1e70a 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -1136,6 +1136,7 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> >  	writel(0, pcie->parf + PARF_Q2A_FLUSH);
> >  
> >  	dw_pcie_dbi_ro_wr_en(pci);
> > +
> 
> Nit: spurious change.
> 

Well that's intentional. It's good to have a newline between these guard
functions to differentiate them from the DBI accesses. We do it in other places
in the driver.

But I thought this change doesn't warrant a mention in commit message or a
separate patch.

Let me know otherwise.

- Mani

> Lorenzo
> 
> >  	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> >  
> >  	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> > @@ -1145,6 +1146,8 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> >  	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
> >  			PCI_EXP_DEVCTL2);
> >  
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> > +
> >  	for (i = 0; i < 256; i++)
> >  		writel(0, pcie->parf + PARF_BDF_TO_SID_TABLE_N + (4 * i));
> >  
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
