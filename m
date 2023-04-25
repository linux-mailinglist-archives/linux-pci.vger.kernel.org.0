Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D746EE804
	for <lists+linux-pci@lfdr.de>; Tue, 25 Apr 2023 21:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjDYTH3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Apr 2023 15:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjDYTH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2023 15:07:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5FC4EC5
        for <linux-pci@vger.kernel.org>; Tue, 25 Apr 2023 12:07:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 722D063117
        for <linux-pci@vger.kernel.org>; Tue, 25 Apr 2023 19:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F71C433D2;
        Tue, 25 Apr 2023 19:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682449645;
        bh=tp02+TY0dnVnNm0UQWdQWiIP/qFl578qXNVMrXKmS+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rTkhbElvG0jZR2nEqn/Ev3DZ0jf/HziasZIA3Oh9nmJcIkrF8eE8TxQFPLMQwRzNP
         iDLnN4AVr5blu5c0btBamwmEwa5D+dFDQ9uztC0GHefaQywwH3C26jV4ZD+xG4IVCQ
         3MPowLjYjMHn7ecqQC3l7WPIgPRUTZnMdnuASrdr81at5nSoOC01v+3Vm0ganLW5f/
         2S6UjZRqsRD64p+d64LDlH5RV4VGVpclCKPNY/Dx5prqdy/s/cbvj15CD3heY4W2rZ
         woddNeMjqjECkPbPE4DStTXWCOUj+CWHWY7CnJM+WzY6MEGhSObzaK/5GLVdISkoCC
         K5so0GDReWykw==
Date:   Tue, 25 Apr 2023 14:07:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ajay Agarwal <ajayagarwal@google.com>
Cc:     William McVicker <willmcvicker@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sajid Dalvi <sdalvi@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: dwc: Wait for link up only if link is started
Message-ID: <20230425190724.GA59133@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHMEbQ_8KNWwWxaY-7JxEu=wQ58WXQQ5XBaHOxFUE7NRKSNiUA@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 25, 2023 at 11:44:59PM +0530, Ajay Agarwal wrote:
> Thanks for the review and testing the patch William!
> 
> Hi Lorenzo
> Can you please include this patch in the next release if it looks good?

Just to set expectations, the v6.4 merge window is open now, so we'll
be asking Linus to pull everything that has already been merged.
v6.4-rc1 should be tagged May 7, and then we'll start applying patches
(like this one) that are destined for v6.5.

Bjorn

> On Thu, Apr 20, 2023 at 12:59 AM William McVicker
> <willmcvicker@google.com> wrote:
> >
> > On 04/12/2023, Ajay Agarwal wrote:
> > > In dw_pcie_host_init() regardless of whether the link has been
> > > started or not, the code waits for the link to come up. Even in
> > > cases where start_link() is not defined the code ends up spinning
> > > in a loop for 1 second. Since in some systems dw_pcie_host_init()
> > > gets called during probe, this one second loop for each pcie
> > > interface instance ends up extending the boot time.
> > >
> > > Wait for the link up in only if the start_link() is defined.
> > >
> > > Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> > > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > > ---
> > > Changelog since v3:
> > > - Run dw_pcie_start_link() only if link is not already up
> > >
> > > Changelog since v2:
> > > - Wait for the link up if start_link() is really defined.
> > > - Print the link status if the link is up on init.
> > >
> > >  .../pci/controller/dwc/pcie-designware-host.c | 13 ++++++++----
> > >  drivers/pci/controller/dwc/pcie-designware.c  | 20 ++++++++++++-------
> > >  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
> > >  3 files changed, 23 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 9952057c8819..cf61733bf78d 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -485,14 +485,19 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >       if (ret)
> > >               goto err_remove_edma;
> > >
> > > -     if (!dw_pcie_link_up(pci)) {
> > > +     if (dw_pcie_link_up(pci)) {
> > > +             dw_pcie_print_link_status(pci);
> > > +     } else {
> > >               ret = dw_pcie_start_link(pci);
> > >               if (ret)
> > >                       goto err_remove_edma;
> > > -     }
> > >
> > > -     /* Ignore errors, the link may come up later */
> > > -     dw_pcie_wait_for_link(pci);
> > > +             if (pci->ops && pci->ops->start_link) {
> > > +                     ret = dw_pcie_wait_for_link(pci);
> > > +                     if (ret)
> > > +                             goto err_stop_link;
> > > +             }
> > > +     }
> > >
> > >       bridge->sysdata = pp;
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 53a16b8b6ac2..03748a8dffd3 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -644,9 +644,20 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
> > >       dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
> > >  }
> > >
> > > -int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > +void dw_pcie_print_link_status(struct dw_pcie *pci)
> > >  {
> > >       u32 offset, val;
> > > +
> > > +     offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > +     val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > > +
> > > +     dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > > +              FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > > +              FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> > > +}
> > > +
> > > +int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > +{
> > >       int retries;
> > >
> > >       /* Check if the link is up or not */
> > > @@ -662,12 +673,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > >               return -ETIMEDOUT;
> > >       }
> > >
> > > -     offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > -     val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > > -
> > > -     dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> > > -              FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> > > -              FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> > > +     dw_pcie_print_link_status(pci);
> > >
> > >       return 0;
> > >  }
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > index 79713ce075cc..615660640801 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -429,6 +429,7 @@ void dw_pcie_setup(struct dw_pcie *pci);
> > >  void dw_pcie_iatu_detect(struct dw_pcie *pci);
> > >  int dw_pcie_edma_detect(struct dw_pcie *pci);
> > >  void dw_pcie_edma_remove(struct dw_pcie *pci);
> > > +void dw_pcie_print_link_status(struct dw_pcie *pci);
> > >
> > >  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
> > >  {
> > > --
> > > 2.40.0.577.gac1e443424-goog
> > >
> >
> > Thanks for sending this patch Ajay! I tested this on my Pixel 6 with 6.3-rc1.
> > I verified the PCIe RC probes without the 1s delay in dw_pcie_wait_for_link().
> > Feel free to include
> >
> > Tested-by: Will McVicker <willmcvicker@google.com>
