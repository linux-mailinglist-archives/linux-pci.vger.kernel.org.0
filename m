Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00847112C2
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 19:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjEYRpq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 13:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241328AbjEYRpo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 13:45:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391CDE50
        for <linux-pci@vger.kernel.org>; Thu, 25 May 2023 10:45:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae615d5018so13445635ad.1
        for <linux-pci@vger.kernel.org>; Thu, 25 May 2023 10:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685036721; x=1687628721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7rYn8nquTP0jtT1l1xeKsxnKijEsGvcqzg0FZXKPEjw=;
        b=k1Kx8y1xiyMzuQhMJV2e3Jo9rDKjhDdtkEesX51i7iLHi0p/Cx/CDB4gkCeRRiIhkS
         KaXNipWhM/u7+ogl8JJPutExdcANJlQFuyfiCDPHlAjpSDfKCl7ebJ4ywU5/+4clZjP8
         FIidGkW0fquyh/3P6+MPhzSulmo6SvLFoJ4O/ibWyOmRm/f6rHhlmY9kdNlJVMAZuyjs
         DX+W1ZXR0FuF3VnOgWlqLx3sV4t7VaE7T2BHBb1HqkhoKpYNJbG6bMNFRWJpZ6mANQMv
         uoxgC9uoIBtaFDXcyX+Z+hUs5yvSLcVnbE50bct9RPB33OVUg88EDZGY/OG1pfhxCIgD
         P8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685036721; x=1687628721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rYn8nquTP0jtT1l1xeKsxnKijEsGvcqzg0FZXKPEjw=;
        b=IqzlznTkGxgEEa29ZGpkjdGDyWoPr6ZB4loDKo50AsWZjt9Bh2YTGWuDVhT2qeeWn+
         XggK4vZobVg49JzP3lb5Bu9FImE9QaclWRaZ3pOeRIWfPjQZ0/xYvKrj41+mgEuM+BBE
         8dEcU3cfsmBU8jK3bXPy+zhSgxfhFMecjdlLevlZbm0MFtXIk2yz2Gp3YzN8rN56fPM+
         LXBrD1tqzIBrcDxJeRKpmy9AguOVBGzePMr1azqOLtb3JotAhvqwa3kfj0+9CG1muc45
         z9OdCwonVNFgZyYNf6/dD/7U5ux3/USDyH74Vfmu8kr9mdng0c86JoUGJhl8EiT8nxYT
         jo3g==
X-Gm-Message-State: AC+VfDzpU33AxOYZ8OPXayUkwi2uxubP0Si7VjNTQlgIbjGPY6ueDNlt
        k+qTcPTtReup/KnyJSirpfKH702YOQjN8+vzI/oUiKRzFiXDE6ULP4rjCpUn5WsVncHrY/FBSnh
        KyCFeXm6CbB4=
X-Google-Smtp-Source: ACHHUZ7nwJznQ0PtnkVdlAKhVagL/CU9/axKQ62gbqCwX4DD/n0nvOmWL3PF5e5vHYNbLE+T9qb7VA==
X-Received: by 2002:a17:903:2309:b0:1ae:610a:4a46 with SMTP id d9-20020a170903230900b001ae610a4a46mr3363222plh.47.1685036721071;
        Thu, 25 May 2023 10:45:21 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id r5-20020a170902be0500b001aaea39043dsm1692925pls.41.2023.05.25.10.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 10:45:20 -0700 (PDT)
Date:   Thu, 25 May 2023 23:15:09 +0530
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     William McVicker <willmcvicker@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sajid Dalvi <sdalvi@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: dwc: Wait for link up only if link is started
Message-ID: <ZG+epY65JpPqY4Rx@google.com>
References: <CAHMEbQ_8KNWwWxaY-7JxEu=wQ58WXQQ5XBaHOxFUE7NRKSNiUA@mail.gmail.com>
 <20230425190724.GA59133@bhelgaas>
 <CAHMEbQ-wuX1ky3v6JnAcPq752zbvoiZJ6AjXG863d7J3ATfqig@mail.gmail.com>
 <ZF5wrpjqpekZu4s5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZF5wrpjqpekZu4s5@google.com>
X-ccpol: medium
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 12, 2023 at 10:00:30AM -0700, William McVicker wrote:
> On 05/08/2023, Ajay Agarwal wrote:
> > Sure, understood. Thanks Bjorn for the explanation.
> > If v6.4-rc1 is tagged by now, please consider applying this patch to the
> > main branch.
> > 
> > -Ajay
> > 
> > On Wed, Apr 26, 2023 at 12:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > > On Tue, Apr 25, 2023 at 11:44:59PM +0530, Ajay Agarwal wrote:
> > > > Thanks for the review and testing the patch William!
> > > >
> > > > Hi Lorenzo
> > > > Can you please include this patch in the next release if it looks good?
> > >
> > > Just to set expectations, the v6.4 merge window is open now, so we'll
> > > be asking Linus to pull everything that has already been merged.
> > > v6.4-rc1 should be tagged May 7, and then we'll start applying patches
> > > (like this one) that are destined for v6.5.
> > >
> > > Bjorn
> > >
> > > > On Thu, Apr 20, 2023 at 12:59 AM William McVicker
> > > > <willmcvicker@google.com> wrote:
> > > > >
> > > > > On 04/12/2023, Ajay Agarwal wrote:
> > > > > > In dw_pcie_host_init() regardless of whether the link has been
> > > > > > started or not, the code waits for the link to come up. Even in
> > > > > > cases where start_link() is not defined the code ends up spinning
> > > > > > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > > > > > gets called during probe, this one second loop for each pcie
> > > > > > interface instance ends up extending the boot time.
> > > > > >
> > > > > > Wait for the link up in only if the start_link() is defined.
> > > > > >
> > > > > > Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> > > > > > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > > > > > ---
> > > > > > Changelog since v3:
> > > > > > - Run dw_pcie_start_link() only if link is not already up
> > > > > >
> > > > > > Changelog since v2:
> > > > > > - Wait for the link up if start_link() is really defined.
> > > > > > - Print the link status if the link is up on init.
> > > > > >
> > > > > >  .../pci/controller/dwc/pcie-designware-host.c | 13 ++++++++----
> > > > > >  drivers/pci/controller/dwc/pcie-designware.c  | 20
> > > ++++++++++++-------
> > > > > >  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
> > > > > >  3 files changed, 23 insertions(+), 11 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > index 9952057c8819..cf61733bf78d 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > @@ -485,14 +485,19 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > > > >       if (ret)
> > > > > >               goto err_remove_edma;
> > > > > >
> > > > > > -     if (!dw_pcie_link_up(pci)) {
> > > > > > +     if (dw_pcie_link_up(pci)) {
> > > > > > +             dw_pcie_print_link_status(pci);
> > > > > > +     } else {
> > > > > >               ret = dw_pcie_start_link(pci);
> > > > > >               if (ret)
> > > > > >                       goto err_remove_edma;
> > > > > > -     }
> > > > > >
> > > > > > -     /* Ignore errors, the link may come up later */
> > > > > > -     dw_pcie_wait_for_link(pci);
> > > > > > +             if (pci->ops && pci->ops->start_link) {
> > > > > > +                     ret = dw_pcie_wait_for_link(pci);
> > > > > > +                     if (ret)
> > > > > > +                             goto err_stop_link;
> > > > > > +             }
> > > > > > +     }
> > > > > >
> > > > > >       bridge->sysdata = pp;
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > index 53a16b8b6ac2..03748a8dffd3 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > @@ -644,9 +644,20 @@ void dw_pcie_disable_atu(struct dw_pcie *pci,
> > > u32 dir, int index)
> > > > > >       dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
> > > > > >  }
> > > > > >
> > > > > > -int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > > > > +void dw_pcie_print_link_status(struct dw_pcie *pci)
> > > > > >  {
> > > > > >       u32 offset, val;
> > > > > > +
> > > > > > +     offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > > > > +     val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > > > > > +
> > > > > > +     dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > > > > > +              FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > > > > > +              FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> > > > > > +}
> > > > > > +
> > > > > > +int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > > > > +{
> > > > > >       int retries;
> > > > > >
> > > > > >       /* Check if the link is up or not */
> > > > > > @@ -662,12 +673,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > > > >               return -ETIMEDOUT;
> > > > > >       }
> > > > > >
> > > > > > -     offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > > > > -     val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > > > > > -
> > > > > > -     dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > > > > > -              FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > > > > > -              FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> > > > > > +     dw_pcie_print_link_status(pci);
> > > > > >
> > > > > >       return 0;
> > > > > >  }
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > > b/drivers/pci/controller/dwc/pcie-designware.h
> > > > > > index 79713ce075cc..615660640801 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > > > @@ -429,6 +429,7 @@ void dw_pcie_setup(struct dw_pcie *pci);
> > > > > >  void dw_pcie_iatu_detect(struct dw_pcie *pci);
> > > > > >  int dw_pcie_edma_detect(struct dw_pcie *pci);
> > > > > >  void dw_pcie_edma_remove(struct dw_pcie *pci);
> > > > > > +void dw_pcie_print_link_status(struct dw_pcie *pci);
> > > > > >
> > > > > >  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg,
> > > u32 val)
> > > > > >  {
> > > > > > --
> > > > > > 2.40.0.577.gac1e443424-goog
> > > > > >
> > > > >
> > > > > Thanks for sending this patch Ajay! I tested this on my Pixel 6 with
> > > 6.3-rc1.
> > > > > I verified the PCIe RC probes without the 1s delay in
> > > dw_pcie_wait_for_link().
> > > > > Feel free to include
> > > > >
> > > > > Tested-by: Will McVicker <willmcvicker@google.com>
> > >
> 
> Hi Lorenzo,
> 
> Could you confirm that you'll be taking this patch for the v6.5 main PCI branch
> please?
> 
> Thanks,
> Will

Hi Lorenzo,
Can you please provide your comment here?

Thanks
Ajay
