Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06DB7146B5
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 10:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjE2I41 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 04:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjE2I4Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 04:56:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4361199;
        Mon, 29 May 2023 01:56:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C80F5612FB;
        Mon, 29 May 2023 08:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA784C433D2;
        Mon, 29 May 2023 08:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685350581;
        bh=0cLtWu67FXIhxvYRUFzDzmVUVv/hQM6Kyg5IDS4Dw2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gQ/1oiwKWZCSV5blbjwIC6h4tswcVf4vfo+Zm1tEwx3Zyu5bhCxUlKnKOYDDv9jFx
         VHivQ5EIacPWBk3vvHbkLq9gDiN9jlAYkUQIk47R/OAQ8ixkEn+uEq0tGo0iWLyeh6
         Uit2RC7qols2pvaiG4OQzm8KvSipDo+iii2lvWTvPssiadVx+5Q4SDdFbaJR6LLDDq
         mC7SESOHviEf1QX7HTONmOlVKv4xGMphywjZitb4HDGHFa7hD6lFBAB0w+UpR0Tcgz
         HDNk95yvoaRAvgVXEClBNhPxtE4YI48M021r5g6awoWsUBx4ryn9wWYeXIly0nCC6s
         qn5ikVRJHuRAg==
Date:   Mon, 29 May 2023 14:26:07 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        robh@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        quic_srichara@quicinc.com,
        Dmitry Baryshkov <dmitry.baryshkov@gmail.com>
Subject: Re: [PATCH v2 2/8] PCI: qcom: Disable write access to read only
 registers for IP v2.9.0
Message-ID: <20230529085607.GC5633@thinkpad>
References: <20230519143117.23875-1-manivannan.sadhasivam@linaro.org>
 <20230519143117.23875-3-manivannan.sadhasivam@linaro.org>
 <CAA8EJpoEPN9rAefZWxUSG50qsz-GZxtUsYS4xoVX4VUh2ig-og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJpoEPN9rAefZWxUSG50qsz-GZxtUsYS4xoVX4VUh2ig-og@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 22, 2023 at 04:00:51PM +0300, Dmitry Baryshkov wrote:
> On Fri, 19 May 2023 at 17:31, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > In the post init sequence of v2.9.0, write access to read only registers
> > are not disabled after updating the registers. Fix it by disabling the
> > access after register update.
> >
> > Fixes: 0cf7c2efe8ac ("PCI: qcom: Add IPQ60xx support")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@gmail.com>
> 
> Could you please drop the @gmail R-B tags? I was mistaken when sending
> them (I'm not even sure that this email exists).
> 

b4 picked them up. Will drop this tag from all patches.

- Mani

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
> >         writel(0, pcie->parf + PARF_Q2A_FLUSH);
> >
> >         dw_pcie_dbi_ro_wr_en(pci);
> > +
> >         writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
> >
> >         val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> > @@ -1145,6 +1146,8 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> >         writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
> >                         PCI_EXP_DEVCTL2);
> >
> > +       dw_pcie_dbi_ro_wr_dis(pci);
> > +
> >         for (i = 0; i < 256; i++)
> >                 writel(0, pcie->parf + PARF_BDF_TO_SID_TABLE_N + (4 * i));
> >
> > --
> > 2.25.1
> >
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்
