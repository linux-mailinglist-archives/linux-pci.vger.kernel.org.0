Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B624076A55D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 02:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjHAAQB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 20:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjHAAQA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 20:16:00 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF971981;
        Mon, 31 Jul 2023 17:15:46 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so5455315e87.3;
        Mon, 31 Jul 2023 17:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690848944; x=1691453744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aqu3ym52hyP8qm4FCeLw+Y27m2KnMkmmlTYkujuRIMI=;
        b=f4OKLWB7ni9ba2XGgr3zBI/HP7TJ/lRwzHYFyYa7AuKeLrGZaOz66WTGANvlsdiqCI
         D/Pz+TvDB2104uaI74F4+m0VnwJzXn+RQoeofN0RwPivfp6pFadkY2igi7O5ppNPf3QL
         D/T8EC5Gh82jdHV7eG1j0OKLxC4cQjMiqDA1PAims9qxH8y6l4OAVt3UGrQK0WaYgEP8
         t5SvCEl3Xt9gTe0GzAjR8b/H/NpH6Rpt8NJfz4nymQQGP6XdWIChBWD1m7FTM5gIfaHP
         5/xyodnQDOlQDOuDvrHSc4SzPTEZJJ7er42K+fiG/BKHhc/48SL0iLLBimWWIcRRxcFO
         0tsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690848944; x=1691453744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqu3ym52hyP8qm4FCeLw+Y27m2KnMkmmlTYkujuRIMI=;
        b=TOxZuXwdt0AAIqgL11mprYLA36DDztMuW8PGyd2O0gcRCv6Rsia19iogBHtUma0pJP
         DihL3wLojWYEXzcDOu0jZBCyDJydJFZlFT2a3bUsDfIvlnwLgPx6zMDPCrvoARIm3DyD
         gHJB45nlEPe5pbaIBfXG8zGkfCUo8eqXN9ELF9KGrOBNQXotBp1TvO+7bN/hRweVp/j2
         wmJbw36HY5w2u4dH2AhF0PxznZ3w7Ofq+tYVneq1yioEafXxvvK5Xz3uyGGiKW0Kufze
         IG3BoSY/i6ElDHAY/I+Ykno7FU1Ktho6ushSaAPxWxP0WhZ6GdnDnZchyTRAg6S+bN5/
         eKPA==
X-Gm-Message-State: ABy/qLYt+wDW7YtGKFDGW9OPYPwg/wO2PPHxUlY1yPT4eWo2siGs/vg0
        pew6/cz7ikVqGCt2dotqtdM=
X-Google-Smtp-Source: APBJJlEeLgDf8c9LnXBfDRF1p7s4hkPLQH3pWqr12VdtprPTAXC00F3ySeeF9puhSb5pbFiv/WSNEw==
X-Received: by 2002:a05:6512:2351:b0:4fe:a5c:efa3 with SMTP id p17-20020a056512235100b004fe0a5cefa3mr1067823lfu.62.1690848944111;
        Mon, 31 Jul 2023 17:15:44 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id l14-20020ac2430e000000b004fdfd79e732sm2293761lfh.289.2023.07.31.17.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 17:15:43 -0700 (PDT)
Date:   Tue, 1 Aug 2023 03:15:41 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
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
Subject: Re: [PATCH v18 13/20] PCI: dwc: Introduce .ep_pre_init() and
 .ep_deinit()
Message-ID: <mjda4qpbqbavvdi26sfdp62kduz3wpsjehaftreja37gssvyqy@n5z3o23rcc7g>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-14-yoshihiro.shimoda.uh@renesas.com>
 <20230724114005.GL6291@thinkpad>
 <TYBPR01MB5341F4EF6F814E72ABD8FE5ED800A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYBPR01MB5341F4EF6F814E72ABD8FE5ED800A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 26, 2023 at 03:02:13AM +0000, Yoshihiro Shimoda wrote:
> Hi Manivannan,
> 
> > From: Manivannan Sadhasivam, Sent: Monday, July 24, 2023 8:40 PM
> > 
> > On Fri, Jul 21, 2023 at 04:44:45PM +0900, Yoshihiro Shimoda wrote:
> > > Renesas R-Car Gen4 PCIe controllers require vender-specific
> > > initialization before .ep_init(). To use dw->dbi and dw->num-lanes
> > > in the initialization code, introduce .ep_pre_init() into struct
> > > dw_pcie_ep_ops. Also introduce .ep_deinit() to disable the controller
> > > by using vender-specific de-initialization.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-ep.c | 6 ++++++
> > >  drivers/pci/controller/dwc/pcie-designware.h    | 2 ++
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > index 14c641395c3b..52b3e7f67513 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > @@ -684,6 +684,9 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > >  	struct pci_epc *epc = ep->epc;
> > >
> > > +	if (ep->ops->ep_deinit)
> > > +		ep->ops->ep_deinit(ep);
> > > +
> > >  	dw_pcie_edma_remove(pci);
> > >
> > >  	if (ep->intx_mem)
> > > @@ -797,6 +800,9 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > >  	ep->phys_base = res->start;
> > >  	ep->addr_size = resource_size(res);
> > >
> > > +	if (ep->ops->ep_pre_init)
> > > +		ep->ops->ep_pre_init(ep);
> > > +
> > >  	dw_pcie_version_detect(pci);
> > >
> > >  	dw_pcie_iatu_detect(pci);
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 6821446d7c66..c3aeafd0f4c9 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -332,7 +332,9 @@ struct dw_pcie_rp {
> > >  };
> > >
> > >  struct dw_pcie_ep_ops {
> > > +	void	(*ep_pre_init)(struct dw_pcie_ep *ep);
> > >  	void	(*ep_init)(struct dw_pcie_ep *ep);
> > > +	void	(*ep_deinit)(struct dw_pcie_ep *ep);
> > 
> > Since the struct name itself has "ep", there is no need to add the "ep" suffix
> > to callbacks. You should fix the existing ep_init callback too in a separate
> > patch.
> 

> I got it. I'll make such a separate patch before this patch.
> 
> Best regards,
> Yoshihiro Shimoda
> 
> > (this series is just GROWING!!!)

The series indeed gets to be too bulky. What about moving that cleanup
patch to a separate patchset which Yoshihiro promised to create
afterwards? Mani?

Anyway should you provide the init()/deinit() callbacks prefix
dropping patch it should fix the dw_pcie_host_ops fields too. It also
has a redundant prefix/suffix. Though it's up to Mani to decide
whether it should be really done.

-Serge(y)

> > 
> > - Mani
> > 
> > >  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
> > >  			     enum pci_epc_irq_type type, u16 interrupt_num);
> > >  	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
> > > --
> > > 2.25.1
> > >
> > 
> > --
> > மணிவண்ணன் சதாசிவம்
