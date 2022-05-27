Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9912E536722
	for <lists+linux-pci@lfdr.de>; Fri, 27 May 2022 20:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbiE0Swh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 May 2022 14:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354445AbiE0Swg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 May 2022 14:52:36 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D275F21251;
        Fri, 27 May 2022 11:52:29 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-306b5b452b1so24076257b3.1;
        Fri, 27 May 2022 11:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxtMQkxOsmxAx60o1Fx3MWQVX3yhClhlLKmqWp5oFv4=;
        b=ftt7e5sA+2IIRA4SY10Kz327SG3cyPm3SErGPPfwk25ZU5TzwYm1DXI6IxK1z1iqkV
         NEpaCCTqoRAtbkuK4p2ipwgSp4S5GAn+JdcNriaHt6wnVWhAd7+zu0GeFLcZJlmnhXyt
         vkogweCoue+ZVMjigU9geYjr07xplwxSb2XZ6cnv0OUPPtFiGFjptvt4uwdUrs+q1A5T
         voKec9YOsRgXdMqSDV4379AL+rOqTjjTKzRpPpdaBAbmxW0YivID5kMjn66O7RNJr1I8
         p+WkVvG7Mv9NE7kjRWKpBr7LziJn8h/svsPsuUkeHboDXp33tY39+CXJ8nM/9EDbGJIp
         8GFg==
X-Gm-Message-State: AOAM533/g+8qv5ZlsYWugF6oVpesMeB0UFqVvY8xVqaV1ZlmROCSycY+
        iGbQwjwFB39b+TCRI5xrPWOtQ4a//GPXjFSkrkY=
X-Google-Smtp-Source: ABdhPJwrGwEytu43boU8pDUt2wpBGnryMJ/qzpbF1oRyr58yMLSW+l3GZ3N9x9ZvYwLsXdCgdE9Ow33zhqfjep92Rv8=
X-Received: by 2002:a81:4ed6:0:b0:307:224f:eed3 with SMTP id
 c205-20020a814ed6000000b00307224feed3mr3811628ywb.301.1653677548809; Fri, 27
 May 2022 11:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220526165422.GA338382@bhelgaas> <20220526194601.GA344086@bhelgaas>
In-Reply-To: <20220526194601.GA344086@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 May 2022 20:52:17 +0200
Message-ID: <CAJZ5v0iteW2K0c7pS+ar1K_iL9L3ujQx=-ZRdrZFzxvkMVZorA@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] PCI/PM: Write 0 to PMCSR in pci_power_up() in
 all cases
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
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

On Thu, May 26, 2022 at 9:46 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, May 26, 2022 at 11:54:22AM -0500, Bjorn Helgaas wrote:
> > On Thu, May 05, 2022 at 08:10:43PM +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Make pci_power_up() write 0 to the device's PCI_PM_CTRL register in
> > > order to put it into D0 regardless of the power state returned by
> > > the previous read from that register which should not matter.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/pci/pci.c |   11 +++--------
> > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > >
> > > Index: linux-pm/drivers/pci/pci.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/pci/pci.c
> > > +++ linux-pm/drivers/pci/pci.c
> > > @@ -1230,15 +1230,10 @@ int pci_power_up(struct pci_dev *dev)
> > >     }
> > >
> > >     /*
> > > -    * If we're (effectively) in D3, force entire word to 0. This doesn't
> > > -    * affect PME_Status, disables PME_En, and sets PowerState to 0.
> > > +    * Force the entire word to 0. This doesn't affect PME_Status, disables
> > > +    * PME_En, and sets PowerState to 0.
> > >      */
> > > -   if (state == PCI_D3hot)
> > > -           pmcsr = 0;
> > > -   else
> > > -           pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
> > > -
> > > -   pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
> > > +   pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> >
> > Can you reassure me why this is safe and useful?
> >
> > This is a 16-bit write that includes (PCIe r6.0, sec 7.5.2.2):
> >
> >   0x0003 PowerState     RW
> >   0x0004                RsvdP
> >   0x0008 No_Soft_Reset  RO
> >   0x00f0                RsvdP
> >   0x0100 PME_En         RW/RWS
> >   0x1e00 Data_Select    RW, VF ROZ
> >   0x6000 Data_Scale     RO, VF ROZ
> >   0x8000 PME_Status     RW1CS
> >
> > We intend to set PowerState to 0 (D0), apparently intend to clear
> > PME_En, and PME_Status is "write 1 to clear" to writing 0 does
> > nothing, so those look OK.
> >
> > But the RsvdP fields are reserved for future RW bits and should be
> > preserved, and it looks like clearing Data_Select could potentially
> > break the Data Register power consumption reporting (which I don't
> > think we support today).
> >
> > It seems like maybe we should do this instead:
> >
> >   pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL,
> >                         pmcsr & ~PCI_PM_CTRL_STATE_MASK)
> >
> > to just unconditionally clear PowerState?
>
> Or I guess this, since we want to clear PME_En as well?
>
>   pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr &
>                         ~(PCI_PM_CTRL_STATE_MASK | PCI_PM_CTRL_PME_ENABLE));

Yes.

Also, this patch actually only makes a difference if the device is
going into D0 from D1 or D2, because we have always written 0 to the
PMCSR during transitions from D3hot.

It is inconsistent and confusing to do different things depending on
the initial power state here and the code is simpler when 0 is written
regardless.
