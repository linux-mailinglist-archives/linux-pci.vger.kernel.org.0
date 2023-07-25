Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C36761028
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 12:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjGYKEC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 06:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjGYKDa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 06:03:30 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B3C172A
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 03:03:10 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-66872d4a141so3035312b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 03:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690279390; x=1690884190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=omQl0KsY23ZTTqxsvNji4YWJ3tGKpnfvrjqf4UJUwos=;
        b=C9FzHzeclNQcNPiVPE4DGrEpTPSKSXfpAFB3Pts30shmPBvzBwDAyjjloLCwhPCM8k
         s6RraUiJTWUQQrvvj2+OB3PjaGqQn9cJDFbRn+u4CT8QtW8P/ZRpwgYLT2oRQoW+s9j9
         TRYPmtwaBaQInazcRPhfhUmXJ6qKvfBAkssM/aH99kfTz9d8YFcWOJeOZCT+2nDRTFpb
         S0dXfhlf+EbFs7rPlMW2xcHgJbMbwZhCypxghuKOSUxYgNKO58djPuoCyrncHEwbfK0L
         De86mVbDD5HacAugf1hQU2DnEN9Dex3Hd6bpDPbf0pmWU/PthUlJx6ejWgZSKOzQfpIr
         ZgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690279390; x=1690884190;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omQl0KsY23ZTTqxsvNji4YWJ3tGKpnfvrjqf4UJUwos=;
        b=eZZs1syCQWg5QWZMX5orvbQv09dD5rinbFOyXwDUmQIUuiB7MI7y8sktJvqhszb/xv
         lqzT9roXf/evMfHQkJ0KhT6JLitgAKgOmPCJOErgoS9y0k/e9o54YuIk3mVubiTug6wj
         OJq8sjZ1/uXsWcMP4Zi0Gvj5zC2jp/OhOGzXek/YP8RoAZX/1NyKeRLWQulc3ARDvkqg
         TcsnaR4px8u+ekGltlA2VTUVw6ZjCWu2PNfG1J0Amc4eM7q0764+jSIo6RycQS51mzhU
         j0tIlcF3uaBnW+MJ76Ix4P6KoFktTBSg5V6Qufe7ktLr+/GGeH/ZL1YBtHjJAlCfCHlq
         KUjg==
X-Gm-Message-State: ABy/qLYa5pFe5mEaK1Ss/E80xWyIk+1ECLrxM9cQ92CVyUwmyGsSxK+c
        olrtMr/S0U066dRhQd3655Xp
X-Google-Smtp-Source: APBJJlEQ/Tr6zv7e7sgeMAaofqM/o/IS22CuvDSLgWCsWUoOcXam0olW16i+FwLejoKb8plfrHxPYg==
X-Received: by 2002:a05:6a20:1d0:b0:137:7add:b7cc with SMTP id 16-20020a056a2001d000b001377addb7ccmr9589211pzz.22.1690279389725;
        Tue, 25 Jul 2023 03:03:09 -0700 (PDT)
Received: from thinkpad ([117.206.117.206])
        by smtp.gmail.com with ESMTPSA id jm24-20020a17090304d800b001b9cdf11764sm10622156plb.31.2023.07.25.03.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:03:09 -0700 (PDT)
Date:   Tue, 25 Jul 2023 15:33:02 +0530
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
Message-ID: <20230725100302.GD22139@thinkpad>
References: <20230608093652.1409485-1-vidyas@nvidia.com>
 <20230725075159.GB22139@thinkpad>
 <815d102d-be0c-8e5d-ac12-1500d90628da@nvidia.com>
 <20230725083030.GC22139@thinkpad>
 <770da5a3-ea02-ce87-8515-beb246082de8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <770da5a3-ea02-ce87-8515-beb246082de8@nvidia.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 25, 2023 at 02:51:10PM +0530, Vidya Sagar wrote:
> 
> 
> On 7/25/2023 2:00 PM, Manivannan Sadhasivam wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, Jul 25, 2023 at 01:49:35PM +0530, Vidya Sagar wrote:
> > > 
> > > 
> > > On 7/25/2023 1:21 PM, Manivannan Sadhasivam wrote:
> > > > External email: Use caution opening links or attachments
> > > > 
> > > > 
> > > > On Thu, Jun 08, 2023 at 03:06:52PM +0530, Vidya Sagar wrote:
> > > > > This reverts commit 4fb8e46c1bc4 ("PCI: tegra194: Enable
> > > > > support for 256 Byte payload")
> > > > > 
> > > > > Consider a PCIe hierarchy with a PCIe switch and a device connected
> > > > > downstream of the switch that has support for MPS which is the minimum
> > > > > in the hierarchy, and root port programmed with an MPS in its DevCtl
> > > > > register that is greater than the minimum. In this scenario, the default
> > > > > bus configuration of the kernel i.e. "PCIE_BUS_DEFAULT" doesn't
> > > > > configure the MPS settings in the hierarchy correctly resulting in the
> > > > > device with support for minimum MPS in the hierarchy receiving the TLPs
> > > > > of size more than that. Although this can be addresed by appending
> > > > > "pci=pcie_bus_safe" to the kernel command line, it doesn't seem to be a
> > > > > good idea to always have this commandline argument even for the basic
> > > > > functionality to work.
> > > > > Reverting commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256
> > > > > Byte payload") avoids this requirement and ensures that the basic
> > > > > functionality of the devices irrespective of the hierarchy and the MPS of
> > > > > the devices in the hierarchy.
> > > > > To reap the benefits of having support for higher MPS, optionally, one can
> > > > > always append the kernel command line with "pci=pcie_bus_perf".
> > > > > 
> > > > > Fixes: 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte payload")
> > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > 
> > > > I know that this patch is merged. But I happen to test a similar change on Qcom
> > > > platform during a patch review and found that the PCI core changes MPS to 128
> > > > when a 128byte supported device is found:
> > > > 
> > > > [    3.174290] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 128)
> > > > [    3.186538] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
> > > > 
> > > > This was just randomly tested on a platform whose Root port DEVCAP was 128, but
> > > > it shouldn't matter. And I didn't change the default bus configuration.
> > > > 
> > > > Wondering how you ended up facing issues with it.
> > > 
> > > If the endpiont device that has support only for 128byte MPS is connected
> > > directly to the root port, then, I agree that the PCIe sub-system takes care
> > > of changing the MPS to the common lowest MPS, but if the endpoint device is
> > > connected behind a PCIe switch, then the PCIe subsystem doesn't configure
> > > the MPS properly.
> > > 
> > 
> > Ah, I missed the fact that your issue only happens with a PCIe switch. But
> > shouldn't this be fixed in the PCI core instead?
> > 
> > I mean, PCI core should use 128byte in your case for Root port unless it is not
> > allowed in the spec (which I doubt).
> well, if the RP's DevCtl is set to 256MPS by default, then, the core
> wouldn't do it automatically unless either 'pcie_bus_safe' or
> 'pcie_bus_perf' is passed.
> 

That's what I'm referring to. The default configuration shouldn't cause Root
port to send TLPs with unsupported payload. Moreover, this is not the case for
immediate children. So definitely the PCI core should exhibit the same behavior
for all downstream devices. 

- Mani

> 
> > 
> > - Mani
> > 
> > > -Vidya Sagar
> > > 
> > > > 
> > > > - Mani
> > > > 
> > > > > ---
> > > > >    drivers/pci/controller/dwc/pcie-tegra194.c | 13 -------------
> > > > >    1 file changed, 13 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > > index 4fdadc7b045f..877d81b13334 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > > > > @@ -892,7 +892,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
> > > > >         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > >         struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> > > > >         u32 val;
> > > > > -     u16 val_16;
> > > > > 
> > > > >         pp->bridge->ops = &tegra_pci_ops;
> > > > > 
> > > > > @@ -900,11 +899,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
> > > > >                 pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
> > > > >                                                               PCI_CAP_ID_EXP);
> > > > > 
> > > > > -     val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
> > > > > -     val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
> > > > > -     val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
> > > > > -     dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
> > > > > -
> > > > >         val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
> > > > >         val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
> > > > >         dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
> > > > > @@ -1756,7 +1750,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
> > > > >         struct device *dev = pcie->dev;
> > > > >         u32 val;
> > > > >         int ret;
> > > > > -     u16 val_16;
> > > > > 
> > > > >         if (pcie->ep_state == EP_STATE_ENABLED)
> > > > >                 return;
> > > > > @@ -1887,11 +1880,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
> > > > >         pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
> > > > >                                                       PCI_CAP_ID_EXP);
> > > > > 
> > > > > -     val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
> > > > > -     val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
> > > > > -     val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
> > > > > -     dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
> > > > > -
> > > > >         /* Clear Slot Clock Configuration bit if SRNS configuration */
> > > > >         if (pcie->enable_srns) {
> > > > >                 val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
> > > > > @@ -1900,7 +1888,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
> > > > >                 dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
> > > > >                                    val_16);
> > > > >         }
> > > > > -
> > > > >         clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
> > > > > 
> > > > >         val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
> > > > > --
> > > > > 2.25.1
> > > > > 
> > > > 
> > > > --
> > > > மணிவண்ணன் சதாசிவம்
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
