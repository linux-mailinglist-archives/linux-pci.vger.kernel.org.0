Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67D1760D05
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 10:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjGYIap (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjGYIal (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 04:30:41 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D9F10F6
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 01:30:39 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bb14015560so3054344a34.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 01:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690273838; x=1690878638;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Hj2YLFYM/S07VoSoGgF04djEYIMz11EHw/3X1OVZ1Q=;
        b=qhj20O2SmADCSOlJf4DHy+EzkLiJQAjJvMsB7yotZRelouCgLm46+gdXcdSNm3JeVa
         JhvJfa+WMnuURpFiyDJBhkBbDXiJnZQ26AuR9xLqx+zhnsGw4lSeVTkV1VbBYbpz6bmV
         oUD44OA9+CigPm9Ro3DAcZFJWDCHqrcr+jQwSf1Y/8jTXefUc6TCcJz8bIK7agbsg75f
         LF0b+lNuaEGYHo+b/AsfTAIAl+MuX7SOo3Imteka1BP65Np0ifzXQ39/LoDltPOR12l9
         bhxY20FK7J9AdUxXhzTRqncfEbe8KKpqzIp3JI5xiniNupFRpWf1W3uKnxtbGQO3h6ZU
         /A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690273838; x=1690878638;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hj2YLFYM/S07VoSoGgF04djEYIMz11EHw/3X1OVZ1Q=;
        b=l4ObewVw1PMfy5vsevLBKoNiYYwbKVd7vWuDJ2qQFVNU3iaTMn746M/5oxaR195f7f
         wt0ITgoNWlrJp9rRWwy1POyh6delBcaj8gjvnO8fufdZQvI8kIuilayYwFgV7i3kON5R
         SzMFbA6l3oMq8lDBPAwmhXejKbNpj0I91dS0u6D9Zz5Ewv7cuJyJYvNnsWFR1waTk3dI
         RHHeck9KpB/cmS/x4QnsNs/hzrloLcUY9+glzZbPMwpRr1SftDoAu63XOiGP4ayQv810
         LEEq4HsItLIo3PocP6AB0yX2QrvY8JDqUml40Z73HGmAQwnf8iwoNF64jX545cizUu8A
         cG2w==
X-Gm-Message-State: ABy/qLZ4iY7FtBdIa984pN9R65twBfillHpYAQf5NXM2N88byeUx9E9M
        /QztUvOMxm0xNcfgiCeQonJP
X-Google-Smtp-Source: APBJJlHgHt4Mr03Ju5QwMxd+Xmd/+ZsTxES9nD1+vmr+Omyd0hHVHVoNXc9cgNaAhnak+vVD+sSfbg==
X-Received: by 2002:a9d:5c17:0:b0:6b7:493d:69ae with SMTP id o23-20020a9d5c17000000b006b7493d69aemr7462297otk.31.1690273838654;
        Tue, 25 Jul 2023 01:30:38 -0700 (PDT)
Received: from thinkpad ([117.206.117.206])
        by smtp.gmail.com with ESMTPSA id p9-20020a639509000000b005633941a547sm9895186pgd.27.2023.07.25.01.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 01:30:38 -0700 (PDT)
Date:   Tue, 25 Jul 2023 14:00:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, Sergey.Semin@baikalelectronics.ru,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
Message-ID: <20230725083030.GC22139@thinkpad>
References: <20230608093652.1409485-1-vidyas@nvidia.com>
 <20230725075159.GB22139@thinkpad>
 <815d102d-be0c-8e5d-ac12-1500d90628da@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <815d102d-be0c-8e5d-ac12-1500d90628da@nvidia.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 25, 2023 at 01:49:35PM +0530, Vidya Sagar wrote:
> 
> 
> On 7/25/2023 1:21 PM, Manivannan Sadhasivam wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Thu, Jun 08, 2023 at 03:06:52PM +0530, Vidya Sagar wrote:
> > > This reverts commit 4fb8e46c1bc4 ("PCI: tegra194: Enable
> > > support for 256 Byte payload")
> > > 
> > > Consider a PCIe hierarchy with a PCIe switch and a device connected
> > > downstream of the switch that has support for MPS which is the minimum
> > > in the hierarchy, and root port programmed with an MPS in its DevCtl
> > > register that is greater than the minimum. In this scenario, the default
> > > bus configuration of the kernel i.e. "PCIE_BUS_DEFAULT" doesn't
> > > configure the MPS settings in the hierarchy correctly resulting in the
> > > device with support for minimum MPS in the hierarchy receiving the TLPs
> > > of size more than that. Although this can be addresed by appending
> > > "pci=pcie_bus_safe" to the kernel command line, it doesn't seem to be a
> > > good idea to always have this commandline argument even for the basic
> > > functionality to work.
> > > Reverting commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256
> > > Byte payload") avoids this requirement and ensures that the basic
> > > functionality of the devices irrespective of the hierarchy and the MPS of
> > > the devices in the hierarchy.
> > > To reap the benefits of having support for higher MPS, optionally, one can
> > > always append the kernel command line with "pci=pcie_bus_perf".
> > > 
> > > Fixes: 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte payload")
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > 
> > I know that this patch is merged. But I happen to test a similar change on Qcom
> > platform during a patch review and found that the PCI core changes MPS to 128
> > when a 128byte supported device is found:
> > 
> > [    3.174290] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 128)
> > [    3.186538] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
> > 
> > This was just randomly tested on a platform whose Root port DEVCAP was 128, but
> > it shouldn't matter. And I didn't change the default bus configuration.
> > 
> > Wondering how you ended up facing issues with it.
> 
> If the endpiont device that has support only for 128byte MPS is connected
> directly to the root port, then, I agree that the PCIe sub-system takes care
> of changing the MPS to the common lowest MPS, but if the endpoint device is
> connected behind a PCIe switch, then the PCIe subsystem doesn't configure
> the MPS properly.
> 

Ah, I missed the fact that your issue only happens with a PCIe switch. But
shouldn't this be fixed in the PCI core instead?

I mean, PCI core should use 128byte in your case for Root port unless it is not
allowed in the spec (which I doubt).

- Mani

> -Vidya Sagar
> 
> > 
> > - Mani
> > 
> > > ---
> > >   drivers/pci/controller/dwc/pcie-tegra194.c | 13 -------------
> > >   1 file changed, 13 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > index 4fdadc7b045f..877d81b13334 100644
> > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > @@ -892,7 +892,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
> > >        struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > >        struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> > >        u32 val;
> > > -     u16 val_16;
> > > 
> > >        pp->bridge->ops = &tegra_pci_ops;
> > > 
> > > @@ -900,11 +899,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
> > >                pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
> > >                                                              PCI_CAP_ID_EXP);
> > > 
> > > -     val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
> > > -     val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
> > > -     val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
> > > -     dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
> > > -
> > >        val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
> > >        val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
> > >        dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
> > > @@ -1756,7 +1750,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
> > >        struct device *dev = pcie->dev;
> > >        u32 val;
> > >        int ret;
> > > -     u16 val_16;
> > > 
> > >        if (pcie->ep_state == EP_STATE_ENABLED)
> > >                return;
> > > @@ -1887,11 +1880,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
> > >        pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
> > >                                                      PCI_CAP_ID_EXP);
> > > 
> > > -     val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
> > > -     val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
> > > -     val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
> > > -     dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
> > > -
> > >        /* Clear Slot Clock Configuration bit if SRNS configuration */
> > >        if (pcie->enable_srns) {
> > >                val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
> > > @@ -1900,7 +1888,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
> > >                dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
> > >                                   val_16);
> > >        }
> > > -
> > >        clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
> > > 
> > >        val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
> > > --
> > > 2.25.1
> > > 
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
