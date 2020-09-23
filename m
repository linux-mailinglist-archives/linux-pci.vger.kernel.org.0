Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30EF275998
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgIWONe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 10:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWONd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Sep 2020 10:13:33 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F992311E;
        Wed, 23 Sep 2020 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600870413;
        bh=yv+RoZDYBssuphUZwP6qf0aKTRxXjqXk0/M68ze7WGo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tNVit1gbjFlSj+ASKcGIiY3iOGBKuBEKc2LsKPuurQW0pzU6ehFkfxQSJC3J4mk1r
         sJilohmEbSoLhVpoP7V/EubRByxBlPJDaLEGIgwsbAn9z+1WLXq0ONszHbS14didY7
         HyZufOMUpCXQ/OMEw5H8jCcq+lUUuaWUNbQ8p1n4=
Received: by mail-ot1-f47.google.com with SMTP id o8so19078935otl.4;
        Wed, 23 Sep 2020 07:13:33 -0700 (PDT)
X-Gm-Message-State: AOAM532jT5ZlhmH1Op2WSnue17sm59EtYqmfyvibU+0WWOPHCi509G9D
        6k3qgHZf92Xg74LIvDA6Jw6SlMV3IqVOxrR2VA==
X-Google-Smtp-Source: ABdhPJwjFwEPebE7Prpf3mCinszs7+RZb1xeI45n6g5EL9zoUG6r88MBFilHFclxhIzt64aOe7Sms8AYh12Fqz3sLQM=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr5858259otp.107.1600870412399;
 Wed, 23 Sep 2020 07:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200918103429.4769-1-nadeem@cadence.com> <CAL_JsqJhpPCpkfrENtbc7zfgiEqPB7ssEt1H5BpjiPPPWSPEwA@mail.gmail.com>
 <SN2PR07MB2557BD3FF1959A113303C741D8380@SN2PR07MB2557.namprd07.prod.outlook.com>
In-Reply-To: <SN2PR07MB2557BD3FF1959A113303C741D8380@SN2PR07MB2557.namprd07.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Sep 2020 08:13:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKjzuhLL1UipOVimVb7pt-0KTk3vZ2kX3PssCtRKqhoHw@mail.gmail.com>
Message-ID: <CAL_JsqKjzuhLL1UipOVimVb7pt-0KTk3vZ2kX3PssCtRKqhoHw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Cadence: Add quirk for Gen2 controller to do
 autonomous speed change.
To:     Athani Nadeem Ladkhan <nadeem@cadence.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 23, 2020 at 1:54 AM Athani Nadeem Ladkhan
<nadeem@cadence.com> wrote:
>
> Hi Rob,
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Tuesday, September 22, 2020 11:08 PM
> > To: Athani Nadeem Ladkhan <nadeem@cadence.com>
> > Cc: Tom Joseph <tjoseph@cadence.com>; Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>; PCI
> > <linux-pci@vger.kernel.org>; linux-kernel@vger.kernel.org; Milind Parab
> > <mparab@cadence.com>; Swapnil Kashinath Jakhade
> > <sjakhade@cadence.com>
> > Subject: Re: [PATCH] PCI: Cadence: Add quirk for Gen2 controller to do
> > autonomous speed change.
> >
> > EXTERNAL MAIL
> >
> >
> > On Fri, Sep 18, 2020 at 4:34 AM Nadeem Athani <nadeem@cadence.com>
> > wrote:
> > >
> > > Cadence controller will not initiate autonomous speed change if
> > > strapped as Gen2. The Retrain bit is set as a quirk to trigger this
> > > speed change.
> > >
> > > Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> > > ---
> > >  drivers/pci/controller/cadence/pcie-cadence-host.c |   13 +++++++++++++
> > >  drivers/pci/controller/cadence/pcie-cadence.h      |    6 ++++++
> > >  2 files changed, 19 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c
> > > b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > > index 4550e0d..4cb7f29 100644
> > > --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> > > +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> > > @@ -83,6 +83,8 @@ static int cdns_pcie_host_init_root_port(struct
> > cdns_pcie_rc *rc)
> > >         struct cdns_pcie *pcie = &rc->pcie;
> > >         u32 value, ctrl;
> > >         u32 id;
> > > +       u32 link_cap = CDNS_PCIE_LINK_CAP_OFFSET;
> > > +       u8 sls, lnk_ctl;
> > >
> > >         /*
> > >          * Set the root complex BAR configuration register:
> > > @@ -111,6 +113,17 @@ static int cdns_pcie_host_init_root_port(struct
> > cdns_pcie_rc *rc)
> > >         if (rc->device_id != 0xffff)
> > >                 cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID,
> > > rc->device_id);
> > >
> > > +       /* Quirk to enable autonomous speed change for GEN2 controller */
> > > +       /* Reading Supported Link Speed value */
> > > +       sls = PCI_EXP_LNKCAP_SLS &
> > > +               cdns_pcie_rp_readb(pcie, link_cap + PCI_EXP_LNKCAP);
> > > +       if (sls == PCI_EXP_LNKCAP_SLS_5_0GB) {
> > > +               /* Since this a Gen2 controller, set Retrain Link(RL) bit */
> > > +               lnk_ctl = cdns_pcie_rp_readb(pcie, link_cap + PCI_EXP_LNKCTL);
> > > +               lnk_ctl |= PCI_EXP_LNKCTL_RL;
> > > +               cdns_pcie_rp_writeb(pcie, link_cap + PCI_EXP_LNKCTL,
> > > + lnk_ctl);
> >
> > Why the byte accesses? This is a 16-bit register.
> This is a 32bit register. But the register field require is at first byte only. Hence the byte access.

No, it's a 16-bit register as Link Status is at the next half word:

#define PCI_EXP_LNKCTL 16 /* Link Control */
#define PCI_EXP_LNKSTA 18 /* Link Status */

Use accesses that match the register size.

Rob
