Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8343A42869A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 08:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhJKGHy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 02:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbhJKGHy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 02:07:54 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8005C061570;
        Sun, 10 Oct 2021 23:05:54 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so20321575otb.10;
        Sun, 10 Oct 2021 23:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTIHUEqXg0ktBodoRxwr+G0+AFSSNgvE2tJ/mjBW9uk=;
        b=ANq9OiyrANgs7ew8IchI1McMjeg+adshr5yG6ZkFrO2aUgfqgbNLzXD1fC+Il0qp1p
         KFcUOZ7Dcb12wcPSepbNM4JpQ+xSR11lO9Y1RgoeZJIyCpIP38wX5D6zBGcWU7HziMWF
         djUyYHbXo4osU8NRUlAhT4+9ELzv76dwz8xJCUa5eLPqTb/+m5PhkTy8jlaz6qbZXy8t
         XFNX/2TwGohbZRA4i53+CUQLHB0xzQEI3ymaXyyW3l2wMrQV/8J23nM/D5wtFGZgGb6y
         072sh2i9KBaibsQ+qfb/Cbrr9pxiVL+VGJblRPbmOVJFiPmYnQFksGWUhqUOuNf7chYB
         /6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTIHUEqXg0ktBodoRxwr+G0+AFSSNgvE2tJ/mjBW9uk=;
        b=gHzC4LxEPFa9g5TicIrWLFLDUwbPoEcUqTwCXy1AT+u5fFaKdloqVG7Xvdu3BLZm1r
         rukuBGYnVM5GZjoC1ghuVH68402X7cJcMrb20pRSwucGBZvaI9fIzXJlOja4oX7+XrQG
         2pl1C7qcc+tuoUDmfUOjdZl5YRKL9tJtxFVCnj851vELrzTC1KXt3R1ROYGn2zzqLCCN
         Md6foqOc6FKR1YCEt+gWl27aqafxB9gjvHan5Seo8B20mICKk1+nE+T3KtZOocCeqCVT
         DWgXlIlx9XB38cRZfhObUxzJkcOOPLLVfLRGS2eFfk5JalaybeQgXK+71Wm75Og9sarQ
         s5LQ==
X-Gm-Message-State: AOAM5306eG4eoE0LUlJzy5I7m3858HXfXp+edC2mffCzQUt4EtDPAHO0
        RDNIte9KU0lVexw+K21HXmRy78MAEKyFLtfI1hBOR95x
X-Google-Smtp-Source: ABdhPJwanKKtvGiW2SqA7SLXruEcwLP7+pNDS8X0xvdAxfxRco3TlRtC0AyFPYcZxYIG4nLszcPk1NMNUIlHzcvEqWU=
X-Received: by 2002:a9d:4616:: with SMTP id y22mr3028425ote.165.1633932354022;
 Sun, 10 Oct 2021 23:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210929004400.25717-2-refactormyself@gmail.com> <20210930155400.GA886716@bhelgaas>
In-Reply-To: <20210930155400.GA886716@bhelgaas>
From:   Saheed Bolarinwa <refactormyself@gmail.com>
Date:   Mon, 11 Oct 2021 08:05:42 +0200
Message-ID: <CABGxfO4QM-0=CRQ64NJMW9nC219m53NJJ3zGG+c_-E0ftZ+Eag@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/4] [PCI/ASPM:] Remove struct pcie_link_state.clkpm_default
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 5:54 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Sep 29, 2021 at 02:43:57AM +0200, Saheed O. Bolarinwa wrote:
> > From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>
> >
> > The clkpm_default member of the struct pcie_link_state stores the
> > value of the default clkpm state as it is in the BIOS.
> >
> > This patch:
> > - Removes clkpm_default from struct pcie_link_state
> > - Creates pcie_get_clkpm_state() which return the clkpm state
> >   obtained the BIOS
> > - Replaces references to clkpm_default with call to
> >   pcie_get_clkpm_state()
> >
> > Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 37 +++++++++++++++++++++++++++----------
> >  1 file changed, 27 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 013a47f587ce..c23da9a4e2fb 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -63,7 +63,6 @@ struct pcie_link_state {
> >       /* Clock PM state */
> >       u32 clkpm_capable:1;            /* Clock PM capable? */
> >       u32 clkpm_enabled:1;            /* Current Clock PM state */
> > -     u32 clkpm_default:1;            /* Default Clock PM state by BIOS */
> >       u32 clkpm_disable:1;            /* Clock PM disabled */
> >
> >       /* Exit latencies */
> > @@ -123,6 +122,30 @@ static int policy_to_aspm_state(struct pcie_link_state *link)
> >       return 0;
> >  }
> >
> > +static int pcie_get_clkpm_state(struct pci_dev *pdev)
> > +{
> > +     int enabled = 1;
> > +     u32 reg32;
> > +     u16 reg16;
> > +     struct pci_dev *child;
> > +     struct pci_bus *linkbus = pdev->subordinate;
> > +
> > +     /* All functions should have the same clkpm state, take the worst */
> > +     list_for_each_entry(child, &linkbus->devices, bus_list) {
> > +             pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
> > +             if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
> > +                     enabled = 0;
> > +                     break;
> > +             }
> > +
> > +             pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
> > +             if (!(reg16 & PCI_EXP_LNKCTL_CLKREQ_EN))
> > +                     enabled = 0;
> > +     }
> > +
> > +     return enabled;
> > +}
> > +
> >  static int policy_to_clkpm_state(struct pcie_link_state *link)
> >  {
> >       switch (aspm_policy) {
> > @@ -134,7 +157,7 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
> >               /* Enable Clock PM */
> >               return 1;
> >       case POLICY_DEFAULT:
> > -             return link->clkpm_default;
> > +             return pcie_get_clkpm_state(link->pdev);
> >       }
> >       return 0;
> >  }
> > @@ -168,9 +191,8 @@ static void pcie_set_clkpm(struct pcie_link_state *link, int enable)
> >
> >  static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
> >  {
> > -     int capable = 1, enabled = 1;
> > +     int capable = 1;
> >       u32 reg32;
> > -     u16 reg16;
> >       struct pci_dev *child;
> >       struct pci_bus *linkbus = link->pdev->subordinate;
> >
> > @@ -179,15 +201,10 @@ static void pcie_clkpm_cap_init(struct pcie_link_state *link, int blacklist)
> >               pcie_capability_read_dword(child, PCI_EXP_LNKCAP, &reg32);
> >               if (!(reg32 & PCI_EXP_LNKCAP_CLKPM)) {
> >                       capable = 0;
> > -                     enabled = 0;
> >                       break;
> >               }
> > -             pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
> > -             if (!(reg16 & PCI_EXP_LNKCTL_CLKREQ_EN))
> > -                     enabled = 0;
> >       }
> > -     link->clkpm_enabled = enabled;
> > -     link->clkpm_default = enabled;
> > +     link->clkpm_enabled = pcie_get_clkpm_state(link->pdev);
>
> I love the idea of removing clkpm_default, but I need a little more
> convincing.  Before this patch, this code computes clkpm_default from
> PCI_EXP_LNKCAP_CLKPM and PCI_EXP_LNKCTL_CLKREQ_EN of all the functions
> of the device.
>
> PCI_EXP_LNKCAP_CLKPM is a read-only value, so we can re-read that any
> time.  But PCI_EXP_LNKCTL_CLKREQ_EN is writable, so if we want to know
> the value that firmware put there, we need to read and save it before
> we modify it.
 >
> Why is it safe to remove this init-time read of
> PCI_EXP_LNKCTL_CLKREQ_EN and instead re-read it any time we need the
> "default" settings from firmware?
After another look, it "may" not be safe, but then clkpm_default
should be documented
as /* Clock PM state at last boot */ because I don't think it is the
*default* state. Please,
let me know what I missing, I list below my reasons: (pardon the repetitions)

- I agree that clkpm_default current stores the boot time value.
- currently, the value of clkpm_default reflect the value of
PCI_EXP_LNKCAP_CLKPM
   (read-only) and PCI_EXP_LNKCTL_CLKREQ_EN (writable)
- calling pcie_set_clkpm() can change the "default" state in the
firmware and it is stored
   in clkpm_enable until the next boot, when clkpm_enable = clkpm_default
- if the "default" state is changed after boot then its initial value
stored in clkpm_default is
  lost at reboot.
- IMO the intention of calling pcie_set_clkpm() is to set the default
value on the firmware.
  We may need another function to set clkpm to a *temporary state*
that may at any time
  be different from the value in the firmware.
- Currently, clkpm_enable always reflect the value in the firmware and
the may be different
  from the value of clkpm_default.
- If clkpm_default does not reflect the value in the firmware after
boot, it feels to me like it is
  not the *default* value
- I also think that clkpm_enabled is supposed to be a sort of
*temporary/current state* that
  may or may not be stored as the default. Although, I am not sure why
it will be needed!


>
> >       link->clkpm_capable = capable;
> >       link->clkpm_disable = blacklist ? 1 : 0;
> >  }
> > --
> > 2.20.1
> >
