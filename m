Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8995D7661D3
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 04:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjG1Ce7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 22:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjG1Ce5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 22:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD9E30FA;
        Thu, 27 Jul 2023 19:34:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50BC861FA0;
        Fri, 28 Jul 2023 02:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4018C433CA;
        Fri, 28 Jul 2023 02:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690511694;
        bh=VKwfnqtxpdQg1s0HfEXDoPQ6/LKADwOgnygbsE5ll7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pGsVzYGNUIqNMH/7+adYOGzvdDxkHSp6KqKQ10m14lyRl+bqv7SfroNUWSK10aJDK
         sLAWnmasDzmWh6F81Y8A7MsypZz2FQDPasIyb5Lkt5islxUJ0a1RvOl/BG2a8SlJMO
         WAh1EGkA1D4XeJFHj8AXUiYP8WroDnbMQRoI/VDoakMbqjgBNZkwZNpaQAvILDR7ne
         rDlH5UJkCZfBSwuep+y+BIickzM7KqSPWzNynQH/6YcI1X2LK6nr2Em8TbPqhGyZ+x
         FJ16fhKkRsQsCdtdiO2LFP749C+moIghLQ1SycRNhVMJuGQe9E6TybEGG6zmfh0oky
         g6J8nSg5pGU+A==
Date:   Fri, 28 Jul 2023 08:04:44 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v18 07/20] PCI: dwc: endpoint: Add multiple PFs support
 for dbi2
Message-ID: <20230728023444.GA4433@thinkpad>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-8-yoshihiro.shimoda.uh@renesas.com>
 <20230724092454.GF6291@thinkpad>
 <TYBPR01MB53412DCDBC766DB3322F7517D803A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYBPR01MB53412DCDBC766DB3322F7517D803A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 25, 2023 at 11:57:34AM +0000, Yoshihiro Shimoda wrote:
> Hi Manivannan,
> 
> > From: Manivannan Sadhasivam, Sent: Monday, July 24, 2023 6:25 PM
> > 
> > On Fri, Jul 21, 2023 at 04:44:39PM +0900, Yoshihiro Shimoda wrote:
> > > The commit 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support
> > > for DWC") added .func_conf_select() to get the configuration space of
> > > different PFs and assumed that the offsets between dbi and dbi2 would
> > > be the same. However, Renesas R-Car Gen4 PCIe controllers have different
> > > offsets of function 1: dbi (+0x1000) and dbi2 (+0x800). To get
> > > the offset for dbi2, add .func_conf_select2() and
> > > dw_pcie_ep_func_select2().
> > >
> > 
> > How about,
> > 
> > .get_dbi2_offset() and dw_pcie_ep_get_dbi2_offset()?
> 
> Thank you for your suggestion. I should have shared the following information
> in the commit log, but dbi2_offset is not depended on the DBI on my environment:
> 
>  +0x0000 : dbi Function 0
>  +0x1000 : dbi Function 1
>  +0x2000 : dbi2 Function 0
>  +0x2800 : dbi2 Function 1
> 
> So, on my environment:
>  - the dbi_base is set to +0x0000..
>  -- And func_offset of func_no = 1 was 0x1000.
>  - the dbi_base2 is set to +0x2000.
>  -- And func_offset2 of function = 1 was 0x0800, not 0x1800.
> 
> Perhaps, the name of new API should be .func_conf_select_dbi2 instead?
>                                                         ~~~~~

"func_conf_select" doesn't look intuitive to me atleast. The idea behind this
callback is to get the funcion offset based on the supplied function no. So this
should've been something like, "get_func_offset" and the API should've been
dw_pcie_ep_get_func_offset().

Since I do not want you to change the existing naming in this series, I
suggested to get the next API naming right.

> 
> > This would've been much simpler if dw_pcie_writeX_{dbi/dbi2} APIs accepted the
> > func_no argument, so that these offset calculations are contained in the API
> > definitions itself as it should. Then the APIs could just do "func_offset *
> > func_no" to get DBI base and "(func_offset * func_no) + dbi2_offset" to get DBI2
> > base, provided these offsets are passed by the vendor drivers.
> 
> Serge suggested such implementation before [1]
> 
> [1]
> https://lore.kernel.org/linux-pci/j4g4ijnxd7qyacszlwyi3tdztkw2nmnjwyhdqf2l2yj3h2mvje@iqsrqiodqbhq/
> 

Thanks for the link. I missed Serge's suggestion before. But I completely agree
with him as you can see from my above suggestion. In addition, I also want to
fix the "func_conf_select" naming as well.

However, I do not want you to implement the suggestion in this series itself.
It should be done as a separate cleanup series later. (I think you both agree to
that as well).

- Mani

> > It can be done in a separate cleanup series later.
> > 
> > > Notes that dw_pcie_ep_func_select2() will call .func_conf_select()
> > 
> > s/Notes/Note
> 
> I'll fix it.
> 
> > > if .func_conf_select2() doesn't exist for backward compatibility.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > ---
> > >  .../pci/controller/dwc/pcie-designware-ep.c   | 32 ++++++++++++++-----
> > >  drivers/pci/controller/dwc/pcie-designware.h  |  3 +-
> > >  2 files changed, 26 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 1d24ebf9686f..bd57516d5313 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -54,21 +54,35 @@ static unsigned int dw_pcie_ep_func_select(struct dw_pcie_ep *ep, u8 func_no)
> > >  	return func_offset;
> > >  }
> > >
> > > +static unsigned int dw_pcie_ep_func_select2(struct dw_pcie_ep *ep, u8 func_no)
> > > +{
> > > +	unsigned int func_offset = 0;
> > > +
> > > +	if (ep->ops->func_conf_select2)
> > > +		func_offset = ep->ops->func_conf_select2(ep, func_no);
> > > +	else if (ep->ops->func_conf_select)	/* for backward compatibility */
> > > +		func_offset = ep->ops->func_conf_select(ep, func_no);
> > > +
> > > +	return func_offset;
> > > +}
> > > +
> > >  static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, u8 func_no,
> > >  				   enum pci_barno bar, int flags)
> > >  {
> > > -	u32 reg;
> > > -	unsigned int func_offset = 0;
> > > +	u32 reg, reg_dbi2;
> > > +	unsigned int func_offset, func_offset_dbi2;
> > 
> > Please maitain reverse Xmas tree order.
> 
> I got it.
> 
> Best regards,
> Yoshihiro Shimoda
> 
> > - Mani
> > 
> > >  	struct dw_pcie_ep *ep = &pci->ep;
> > >
> > >  	func_offset = dw_pcie_ep_func_select(ep, func_no);
> > > +	func_offset_dbi2 = dw_pcie_ep_func_select2(ep, func_no);
> > >
> > >  	reg = func_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
> > > +	reg_dbi2 = func_offset_dbi2 + PCI_BASE_ADDRESS_0 + (4 * bar);
> > >  	dw_pcie_dbi_ro_wr_en(pci);
> > > -	dw_pcie_writel_dbi2(pci, reg, 0x0);
> > > +	dw_pcie_writel_dbi2(pci, reg_dbi2, 0x0);
> > >  	dw_pcie_writel_dbi(pci, reg, 0x0);
> > >  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> > > -		dw_pcie_writel_dbi2(pci, reg + 4, 0x0);
> > > +		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, 0x0);
> > >  		dw_pcie_writel_dbi(pci, reg + 4, 0x0);
> > >  	}
> > >  	dw_pcie_dbi_ro_wr_dis(pci);
> > > @@ -232,13 +246,15 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > >  	enum pci_barno bar = epf_bar->barno;
> > >  	size_t size = epf_bar->size;
> > >  	int flags = epf_bar->flags;
> > > -	unsigned int func_offset = 0;
> > > +	unsigned int func_offset, func_offset_dbi2;
> > >  	int ret, type;
> > > -	u32 reg;
> > > +	u32 reg, reg_dbi2;
> > >
> > >  	func_offset = dw_pcie_ep_func_select(ep, func_no);
> > > +	func_offset_dbi2 = dw_pcie_ep_func_select2(ep, func_no);
> > >
> > >  	reg = PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset;
> > > +	reg_dbi2 = PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset_dbi2;
> > >
> > >  	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> > >  		type = PCIE_ATU_TYPE_MEM;
> > > @@ -254,11 +270,11 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > >
> > >  	dw_pcie_dbi_ro_wr_en(pci);
> > >
> > > -	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
> > > +	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
> > >  	dw_pcie_writel_dbi(pci, reg, flags);
> > >
> > >  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> > > -		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
> > > +		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, upper_32_bits(size - 1));
> > >  		dw_pcie_writel_dbi(pci, reg + 4, 0);
> > >  	}
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 812c221b3f7c..94bc20f5f600 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -340,9 +340,10 @@ struct dw_pcie_ep_ops {
> > >  	 * access for different platform, if different func have different
> > >  	 * offset, return the offset of func. if use write a register way
> > >  	 * return a 0, and implement code in callback function of platform
> > > -	 * driver.
> > > +	 * driver. The func_conf_select2 is for dbi2.
> > >  	 */
> > >  	unsigned int (*func_conf_select)(struct dw_pcie_ep *ep, u8 func_no);
> > > +	unsigned int (*func_conf_select2)(struct dw_pcie_ep *ep, u8 func_no);
> > >  };
> > >
> > >  struct dw_pcie_ep_func {
> > > --
> > > 2.25.1
> > >
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
