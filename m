Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797835AC054
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiICRm3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Sep 2022 13:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiICRm1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Sep 2022 13:42:27 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3768250724;
        Sat,  3 Sep 2022 10:42:25 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id p204so7433473yba.3;
        Sat, 03 Sep 2022 10:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1Oh24JjJO3LtEF81yZui8vBF0ZiGpv8OhgBNhurKph4=;
        b=FH2CsYiXibomipFA4EYuCzEgkeC8HtYPMzi+tpdJTN3+blXrCuY3xVpafDm1vmAw3A
         nlXLrweTXemWU0HvINPyfnsIUiLq279t6NtBTjuD7M7+ybosHxhMGWDav3ifex+PjGV7
         P6cIGlp869ioSQsZoJqfKShtoPjb6iEIwd5m3A3PQ03I+pMwVxzZPKd5panfAeWL12zf
         +i8JDVmS2uNlh+wUBcX6r83LDeJf9HCUrV8e1IUr5PcmI9xkBxv9MX7BDDGFoGe7cHzp
         st2su0jJMboncDKzgdswVDkyNLxpTCliMyimdfrz/RoqF8hXDRDHZ378ZOPZKd7Kjeo5
         Xhhw==
X-Gm-Message-State: ACgBeo0thODns2nJ+fSCGZVohqL1F8mVPMvnFdCXlbQzUh3Q3iMZmoBq
        qgYeU7g7aiW0Sq83RHhKNq7dV83nVKDrq+1poW6k39N3
X-Google-Smtp-Source: AA6agR46PFNH5PVO52b54ICBiP8sdJu9Fwr3ruyelbqhf0wAwMFXBgO3dIHlw9wt0aKF0pKyWPUhWvLtRgQJbEFmHwk=
X-Received: by 2002:a25:2f0c:0:b0:6a8:f230:12ed with SMTP id
 v12-20020a252f0c000000b006a8f23012edmr288172ybv.633.1662226944425; Sat, 03
 Sep 2022 10:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220902233543.390890-1-helgaas@kernel.org> <20220902233543.390890-3-helgaas@kernel.org>
 <CAJZ5v0jV94TwifmoF2UfiDpXNP_Kgt6qNkQH7zwQjo=ZhyU-4A@mail.gmail.com>
In-Reply-To: <CAJZ5v0jV94TwifmoF2UfiDpXNP_Kgt6qNkQH7zwQjo=ZhyU-4A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 19:42:13 +0200
Message-ID: <CAJZ5v0jp2y=hKr0PG0qTtpVW5qOPLtKhMJDqsNFh2vV1=0Umtg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI/PTM: Implement pci_enable_ptm() for Root
 Ports, Switch Upstream Ports
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 3, 2022 at 7:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Sep 3, 2022 at 1:35 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pcie/ptm.c | 34 +++++++++++++++++++++++++++-------
> >  1 file changed, 27 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > index b6a417247ce3..ad283818f37b 100644
> > --- a/drivers/pci/pcie/ptm.c
> > +++ b/drivers/pci/pcie/ptm.c
> > @@ -167,11 +167,11 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
> >         if (!pos)
> >                 return -EINVAL;
> >
> > -       pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
> > -       if (!(cap & PCI_PTM_CAP_REQ))
> > -               return -EINVAL;
> > -
> >         /*
> > +        * Root Ports and Switch Upstream Ports have been configured
> > +        * by pci_ptm_init(), so preserve their PCI_PTM_CTRL_ROOT and
> > +        * granularity.
> > +        *
> >          * For a PCIe Endpoint, PTM is only useful if the endpoint can
> >          * issue PTM requests to upstream devices that have PTM enabled.
> >          *
> > @@ -179,19 +179,39 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
> >          * device, so there must be some implementation-specific way to
> >          * associate the endpoint with a time source.
> >          */
> > -       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
> > +       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> > +           pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) {
> > +               if (pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) {
> > +                       ups = pci_upstream_bridge(dev);
> > +                       if (!ups || !ups->ptm_enabled)
> > +                               return -EINVAL;
> > +               }
> > +
> > +               pci_read_config_dword(dev, pos + PCI_PTM_CTRL, &ctrl);
> > +               ctrl |= PCI_PTM_CTRL_ENABLE;
> > +       } else if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
> > +               pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
> > +               if (!(cap & PCI_PTM_CAP_REQ))
> > +                       return -EINVAL;
> > +
> >                 ups = pci_upstream_bridge(dev);
> >                 if (!ups || !ups->ptm_enabled)
> >                         return -EINVAL;
> >
> >                 dev->ptm_granularity = ups->ptm_granularity;
> > +               ctrl = PCI_PTM_CTRL_ENABLE;
> > +               ctrl |= dev->ptm_granularity << 8;
> >         } else if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> > +               pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
> > +               if (!(cap & PCI_PTM_CAP_REQ))
> > +                       return -EINVAL;
> > +
> >                 dev->ptm_granularity = 0;
> > +               ctrl = PCI_PTM_CTRL_ENABLE;
> > +               ctrl |= dev->ptm_granularity << 8;
> >         } else
> >                 return -EINVAL;
>
> I would do
>
> if ((pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM || pci_pcie_type(dev)
> == PCI_EXP_TYPE_ENDPOINT)) {
>         ups = pci_upstream_bridge(dev);
>         if (!ups || !ups->ptm_enabled)
>                 return -EINVAL;
>
>         dev->ptm_granularity = ups->ptm_granularity;
> }
>
> switch(pci_pcie_type(dev)) {
> case PCI_EXP_TYPE_ROOT_PORT:
> case PCI_EXP_TYPE_UPSTREAM:
>         pci_read_config_dword(dev, pos + PCI_PTM_CTRL, &ctrl);
>         ctrl |= PCI_PTM_CTRL_ENABLE;
>         break;
> case PCI_EXP_TYPE_ENDPOINT:
> case PCI_EXP_TYPE_RC_END:

I missed the cap check here, sorry.

>         ctrl = PCI_PTM_CTRL_ENABLE;
>         break;
> default:
>         return -EINVAL;
> }
>
> >
> > -       ctrl = PCI_PTM_CTRL_ENABLE;
> > -       ctrl |= dev->ptm_granularity << 8;
>
> And I wouldn't remove the line above.
>
> Note that for root ports dev->ptm_granularity must be set and reflect
> the register setting or else the code wouldn't have worked for
> downstream components.
>
> >         pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
> >         dev->ptm_enabled = 1;
> >
> > --
