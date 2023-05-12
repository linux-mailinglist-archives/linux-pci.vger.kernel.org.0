Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E8A700D85
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 19:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbjELRAj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 May 2023 13:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjELRAi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 13:00:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DC09EE6
        for <linux-pci@vger.kernel.org>; Fri, 12 May 2023 10:00:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ac65ab7432so529355ad.0
        for <linux-pci@vger.kernel.org>; Fri, 12 May 2023 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683910836; x=1686502836;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hZ1+7EbVf1QE+O4BKyWenr/HeQYsusqDcW+MZj0maDE=;
        b=6QZZvAO4rpV40tlIVIVrCxYRO2ECeipHVSckXlhFTrjxJpHZJJ6pxgJn1X4Gy0HJma
         HdF6f4fcwVWQOv/ijY/elO91KjYz97QTw5tRmZKWjmAXN3V55vjn121FCXl1LDye4+rg
         6wMMSqHAhLwodTgsexUHsv+WHRV1RT3SgeUGih6lgXIy2UczHtQ68gbpz+HLID81BzwL
         wdVTjtXAgCLJTSdjDVWEC1xWia1OdnvipoVdfZ4i9kTE69nHIhcUogNLu8IsnVscPxuI
         vTlVeGALMDxeCCSO4xIAXkLY5jFx1h9NFzggrMn4lU0nVQfO0CtxBwp4oNyuniWbKJ68
         13WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683910836; x=1686502836;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ1+7EbVf1QE+O4BKyWenr/HeQYsusqDcW+MZj0maDE=;
        b=QZ6PAaToT7YeNFyXQckr866mGRAmo7n5jfwDtxNlzcfraPJUIUKmvlRowXfORoGn1o
         nk2zQcaTSDUvYkwtkBTwQTu2n2mqHU8B0gFL5WU/MPOK26e+Bmlgj35yPRD8sCA+Yx0g
         IJAkgO/yje0c50p+KrM9bcVXupTZ6mrInrZUop5XODsuDBSe4q5gTt2pnKDkleczrVi8
         ZdCcaeZjfPjcmbkyFIs8S+OmaHVj4cQWFDAUTL8tcWAJpySMuQRP4oWlDvUShVYEydz5
         t2OAXTSOUZGqqx9FqXLzvrqUBuF4AVcGz5Il/D6pEVquya26tOiU3HNAvgLRdRSE9p1g
         Tfzw==
X-Gm-Message-State: AC+VfDwDPZ2nfS7pgnozUKHIfJWaH+9MTl4cajyv7NH/hVhWu60hPuOu
        uUmfGEmSL64vaJWfSB4NGn6Fxrk1O7GiXMvrEz/hQ1/wLEOMuyuZf84H4AgaBSOGvXYPEGvz200
        5dIb4AbN3sho=
X-Google-Smtp-Source: ACHHUZ6RRUGYG+1pZTg2lcaXGTNSN1Y2jPJ23dZyhdKk2r5f/BPYrx79YCYyFkFdj4arSYLzv1/Bpw==
X-Received: by 2002:a17:902:fb83:b0:1a8:96c:738 with SMTP id lg3-20020a170902fb8300b001a8096c0738mr312104plb.2.1683910834972;
        Fri, 12 May 2023 10:00:34 -0700 (PDT)
Received: from google.com (13.65.82.34.bc.googleusercontent.com. [34.82.65.13])
        by smtp.gmail.com with ESMTPSA id g15-20020a63f40f000000b0053031f7a367sm7019460pgi.85.2023.05.12.10.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 10:00:34 -0700 (PDT)
Date:   Fri, 12 May 2023 10:00:30 -0700
From:   William McVicker <willmcvicker@google.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sajid Dalvi <sdalvi@google.com>, linux-pci@vger.kernel.org,
        Ajay Agarwal <ajayagarwal@google.com>
Subject: Re: [PATCH v4] PCI: dwc: Wait for link up only if link is started
Message-ID: <ZF5wrpjqpekZu4s5@google.com>
References: <CAHMEbQ_8KNWwWxaY-7JxEu=wQ58WXQQ5XBaHOxFUE7NRKSNiUA@mail.gmail.com>
 <20230425190724.GA59133@bhelgaas>
 <CAHMEbQ-wuX1ky3v6JnAcPq752zbvoiZJ6AjXG863d7J3ATfqig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHMEbQ-wuX1ky3v6JnAcPq752zbvoiZJ6AjXG863d7J3ATfqig@mail.gmail.com>
X-ccpol: medium
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/08/2023, Ajay Agarwal wrote:
> Sure, understood. Thanks Bjorn for the explanation.
> If v6.4-rc1 is tagged by now, please consider applying this patch to the
> main branch.
> 
> -Ajay
> 
> On Wed, Apr 26, 2023 at 12:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Tue, Apr 25, 2023 at 11:44:59PM +0530, Ajay Agarwal wrote:
> > > Thanks for the review and testing the patch William!
> > >
> > > Hi Lorenzo
> > > Can you please include this patch in the next release if it looks good?
> >
> > Just to set expectations, the v6.4 merge window is open now, so we'll
> > be asking Linus to pull everything that has already been merged.
> > v6.4-rc1 should be tagged May 7, and then we'll start applying patches
> > (like this one) that are destined for v6.5.
> >
> > Bjorn
> >
> > > On Thu, Apr 20, 2023 at 12:59 AM William McVicker
> > > <willmcvicker@google.com> wrote:
> > > >
> > > > On 04/12/2023, Ajay Agarwal wrote:
> > > > > In dw_pcie_host_init() regardless of whether the link has been
> > > > > started or not, the code waits for the link to come up. Even in
> > > > > cases where start_link() is not defined the code ends up spinning
> > > > > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > > > > gets called during probe, this one second loop for each pcie
> > > > > interface instance ends up extending the boot time.
> > > > >
> > > > > Wait for the link up in only if the start_link() is defined.
> > > > >
> > > > > Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> > > > > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > > > > ---
> > > > > Changelog since v3:
> > > > > - Run dw_pcie_start_link() only if link is not already up
> > > > >
> > > > > Changelog since v2:
> > > > > - Wait for the link up if start_link() is really defined.
> > > > > - Print the link status if the link is up on init.
> > > > >
> > > > >  .../pci/controller/dwc/pcie-designware-host.c | 13 ++++++++----
> > > > >  drivers/pci/controller/dwc/pcie-designware.c  | 20
> > ++++++++++++-------
> > > > >  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
> > > > >  3 files changed, 23 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > index 9952057c8819..cf61733bf78d 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > @@ -485,14 +485,19 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > > >       if (ret)
> > > > >               goto err_remove_edma;
> > > > >
> > > > > -     if (!dw_pcie_link_up(pci)) {
> > > > > +     if (dw_pcie_link_up(pci)) {
> > > > > +             dw_pcie_print_link_status(pci);
> > > > > +     } else {
> > > > >               ret = dw_pcie_start_link(pci);
> > > > >               if (ret)
> > > > >                       goto err_remove_edma;
> > > > > -     }
> > > > >
> > > > > -     /* Ignore errors, the link may come up later */
> > > > > -     dw_pcie_wait_for_link(pci);
> > > > > +             if (pci->ops && pci->ops->start_link) {
> > > > > +                     ret = dw_pcie_wait_for_link(pci);
> > > > > +                     if (ret)
> > > > > +                             goto err_stop_link;
> > > > > +             }
> > > > > +     }
> > > > >
> > > > >       bridge->sysdata = pp;
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > index 53a16b8b6ac2..03748a8dffd3 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > @@ -644,9 +644,20 @@ void dw_pcie_disable_atu(struct dw_pcie *pci,
> > u32 dir, int index)
> > > > >       dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
> > > > >  }
> > > > >
> > > > > -int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > > > +void dw_pcie_print_link_status(struct dw_pcie *pci)
> > > > >  {
> > > > >       u32 offset, val;
> > > > > +
> > > > > +     offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > > > +     val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > > > > +
> > > > > +     dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > > > > +              FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > > > > +              FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> > > > > +}
> > > > > +
> > > > > +int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > > > +{
> > > > >       int retries;
> > > > >
> > > > >       /* Check if the link is up or not */
> > > > > @@ -662,12 +673,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > > >               return -ETIMEDOUT;
> > > > >       }
> > > > >
> > > > > -     offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > > > -     val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > > > > -
> > > > > -     dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > > > > -              FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > > > > -              FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> > > > > +     dw_pcie_print_link_status(pci);
> > > > >
> > > > >       return 0;
> > > > >  }
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > b/drivers/pci/controller/dwc/pcie-designware.h
> > > > > index 79713ce075cc..615660640801 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > > @@ -429,6 +429,7 @@ void dw_pcie_setup(struct dw_pcie *pci);
> > > > >  void dw_pcie_iatu_detect(struct dw_pcie *pci);
> > > > >  int dw_pcie_edma_detect(struct dw_pcie *pci);
> > > > >  void dw_pcie_edma_remove(struct dw_pcie *pci);
> > > > > +void dw_pcie_print_link_status(struct dw_pcie *pci);
> > > > >
> > > > >  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg,
> > u32 val)
> > > > >  {
> > > > > --
> > > > > 2.40.0.577.gac1e443424-goog
> > > > >
> > > >
> > > > Thanks for sending this patch Ajay! I tested this on my Pixel 6 with
> > 6.3-rc1.
> > > > I verified the PCIe RC probes without the 1s delay in
> > dw_pcie_wait_for_link().
> > > > Feel free to include
> > > >
> > > > Tested-by: Will McVicker <willmcvicker@google.com>
> >

Hi Lorenzo,

Could you confirm that you'll be taking this patch for the v6.5 main PCI branch
please?

Thanks,
Will
