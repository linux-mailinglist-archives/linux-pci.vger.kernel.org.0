Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7EF753A3A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 13:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjGNLyt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 07:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjGNLys (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 07:54:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3740C136;
        Fri, 14 Jul 2023 04:54:46 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fba86f069bso3083686e87.3;
        Fri, 14 Jul 2023 04:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689335684; x=1691927684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YS++m7UJb7+5nezOKfUuKjyikzvghZKtWIWx8R+b8V8=;
        b=hVohwqaHvGRQL13bKGa7BtX2j/4uH+tVGvMjkkPbI+63UJeLrB9ZlZSv2wQyt86eUu
         Th68VDET0kSm71m+HB399T57oDDGz1Mi/rPoF1nMMA1OctmbBYxHWZ0fXbMBpSjHHza+
         mE2BOdafKZ+jMhNru81TzK1LwUTO1FHNDEQjfsnVvOiqBUgvD65KKtQ7nh9DodBS69ps
         C1XJuWeie/UsCuw3/TfiIYSE+xG/kIJxIxL4mY+7tREcBQGhW9VhTVdik+ZkJR6qFg47
         ubYgOrNm2eDEAgqioP09z1CuABprKsiARHc1PZpIcg5ABBlw0KKWwySWduWHOi0LRQEj
         W80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689335684; x=1691927684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YS++m7UJb7+5nezOKfUuKjyikzvghZKtWIWx8R+b8V8=;
        b=lICZKQb/PBL7o+q4m3QcRKYzuKZNKDAEDsDFbsw7LITjhbH9l2+EtnxMm8/Vna4JUz
         20MinFBiTKo7OYW2rrxc5AzjeVwOehezE2yC4Nqki3xAOfVVhGPld+aC+B8v9ZEqtLMK
         MgiGPXVKbophyn5dgNRT3kA3gvzUbc9B0qbif2vUQlsfxIJRgjslvAP2Xrfjg8sZfy5m
         uEiaMnk2ZDQVaU6FM5EeKM6XMjDEzn5R1Niy3b8VQG/nCaAnnhfOITl0lB1STuOB3DcS
         oBfnXr8FBlfrK0B5pHVGfbmpCeOjhuKcQoHt2qcFq8bq6t/IYYl5rQzIk6yY/e3wjrIO
         FcZw==
X-Gm-Message-State: ABy/qLZN+DDqFGvgArbXObMtsCWR1cxId5RtXsq1DGxIeu5ZUMTijaad
        CP2CLsafi2B9rEOap9YCcBc=
X-Google-Smtp-Source: APBJJlFrsDMDG0HVPs/2KInOvrMK1PLd9Nqb96IaXRxMtBckmpBzPcpViKf/eBI028IRom4/wYsPJg==
X-Received: by 2002:ac2:520e:0:b0:4fb:7be5:7404 with SMTP id a14-20020ac2520e000000b004fb7be57404mr3043152lfl.63.1689335684219;
        Fri, 14 Jul 2023 04:54:44 -0700 (PDT)
Received: from mobilestation ([85.249.20.77])
        by smtp.gmail.com with ESMTPSA id e10-20020ac2546a000000b004fba808ab76sm1461227lfn.181.2023.07.14.04.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 04:54:43 -0700 (PDT)
Date:   Fri, 14 Jul 2023 14:54:40 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v17 07/20] PCI: dwc: endpoint: Add multiple PFs support
 for dbi2
Message-ID: <sagt5fyru3qbahrfzw63ijw2wx5vppxotxeeczja6x4qpszkmp@szh5acihoydg>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-8-yoshihiro.shimoda.uh@renesas.com>
 <j4g4ijnxd7qyacszlwyi3tdztkw2nmnjwyhdqf2l2yj3h2mvje@iqsrqiodqbhq>
 <TYBPR01MB5341E825A7FFE163CE2364D4D834A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341E825A7FFE163CE2364D4D834A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 14, 2023 at 02:01:16AM +0000, Yoshihiro Shimoda wrote:
> Hi,
> 
> > From: Serge Semin, Sent: Wednesday, July 12, 2023 5:32 AM
> > 
> > On Wed, Jul 05, 2023 at 08:41:53PM +0900, Yoshihiro Shimoda wrote:
> > > The commit 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support
> > > for DWC") added .func_conf_select() to get the configuration space of

> > > different PFs and assumed that the offsets between dbi and dbi would
                                                                  ^
                                                                  |
s/dbi/dbi2 -------------------------------------------------------+

> > > be the same. However, Renesas R-Car Gen4 PCIe controllers have different
> > > offsets of function 1: dbi (+0x1000) and dbi2 (+0x800). To get
> > > the offset for dbi2, add .func_conf_select2() and
> > > dw_pcie_ep_func_select2().
> > >
> > > Notes that dw_pcie_ep_func_select2() will call .func_conf_select()
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
> > >  	struct dw_pcie_ep *ep = &pci->ep;
> > >
> > >  	func_offset = dw_pcie_ep_func_select(ep, func_no);
> > > +	func_offset_dbi2 = dw_pcie_ep_func_select2(ep, func_no);
> > 
> > IMO this will make the code even more complicated than it's already
> > with the offsets calculated and added here and there. What about
> > implementing a set of methods like this:
> > 
> > +static void dw_pcie_ep_writeX_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg, uYZ val)
> > +{
> > +	unsigned int ofs = dw_pcie_ep_func_select(ep, func_no);
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +
> > +	dw_pcie_writeX_dbi(pci, reg + ofs, val);
> > +}
> > +
> > +static uYZ dw_pcie_ep_readX_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 reg)
> > +{
> > +	unsigned int ofs = dw_pcie_ep_func_select(ep, func_no);
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +
> > +	return dw_pcie_readX_dbi(pci, reg + ofs);
> > +}
> > 
> > and converting the entire DW PCIe EP core driver to using them instead
> > of always separately calculating the func_offset? Then in a subsequent
> > patch you can add a new method like this:
> > 
> > +static void dw_pcie_ep_writel_dbi2(struct dw_pcie_ep *ep, u8 func_no, u32 reg, u32 val)
> > +{
> > +	unsigned int ofs = dw_pcie_ep_func_select2(ep, func_no);
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +
> > +	dw_pcie_writel_dbi2(pci, reg + ofs, val);
> > +}
> > 
> > and have it utilized in the shadow registers update parts as you
> > originally intended. This will make the code much better readable with
> > no much harm to the performance since the most of setups are performed
> > once during the initial end-point configuration.
> > 
> > Note my suggestion is quite heavy to implement and implies the code
> > cleanup. So I'd wait for the maintainers comment about this (Mani is
> > now responsible for the driver maintaining).
> > Mani, Krzysztof, Lorenzo, Rob, what do you think about that?
> 
> To be honest, if possible, I would like to implement such clean up code
> after this patch series are applied (because this patch set had been
> developed for a year and more...).

I would be glad to review it then. Without the suggested modification
you have no other choice but to implement the change as is. No
objections against this patch from my side then.

Regarding the review timing. I fully understand your feelings. From my
experience the bigger series and the more various changes it implies,
the longer it takes to review especially if the corresponding driver
has no active maintainership. The later has been relevant to the DW
PCIe/eDMA core drivers up to recent Mani' assignment. Some of my even
smaller patchsets were even longer time in the review limbo. My very
first series was under review for about one year. I had to fully
rewrite it several times. It was very much irritating indeed. So the
kernel contributors must have a great deal of patience sometime in
order to finally have their patches taken. That gets to be even more
actual seeing the requirements may differ from subsystem to subsystem,
sometimes from maintainer to maintainer.

-Serge(y)

> 
> Best regards,
> Yoshihiro Shimoda
> 
> > -Serge(y)
> > 
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
