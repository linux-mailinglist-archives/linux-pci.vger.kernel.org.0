Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B392F419F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 03:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbhAMCRa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 21:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbhAMCR3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 21:17:29 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600F9C061575
        for <linux-pci@vger.kernel.org>; Tue, 12 Jan 2021 18:16:43 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u25so492420lfc.2
        for <linux-pci@vger.kernel.org>; Tue, 12 Jan 2021 18:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rv4WHoorKcMMwhd//npkAorfZIWJ3XEBWCkV0kYCKfA=;
        b=puh0Nzdk9rfZREUiPzO88kJc1hVOSWKhpMsUC23cZUr+aExaQDnjkRWzBjNPAoGBHv
         Na8UBNkdm2DDupak7xiWYeu4s+qzInjUK70uVkKUqWdoG8INjz5VGOz95ZORY4939Z2a
         Q8PBa1M+qkGETbeY3MU70Q/9uBxVL0yafW+DunaU+vIgjjWzKo6RCS/ZmUmxhaTP0PrQ
         s7wbb9tcv6i5/+foQt28fzq0MAOuEEHh4AAjMyZpXnKYodSIydc3DsUTQkh3wAnM6994
         VatKLIbn0Cdq213f0RJTOZcQYLf152zT0tbcsf27ueXqNs5NiBi+8DdVAAtDHHlSyGFx
         NFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rv4WHoorKcMMwhd//npkAorfZIWJ3XEBWCkV0kYCKfA=;
        b=HY1eE7dX43MaoOV4ikVdWGodmIOoLd03ewmB02yl2nR3DXYg5MfFk1kjA3j6/rz2/c
         WNRyl0YdRJFiKh6yxkAJeTz6qrN/Gzyznv3XL18OMCMSDiJhftyxpRgDl1rjJP1iLe8l
         4rqJ3jZ+yVAYH0rjRFQVXVs6qFtRZ9ScqFjG0YqAv8ac8NyMqm+51uSgc9Ol9JftIrnS
         qoGEqJJBz3ZDdluz5C6IVvDCwrIEFRGy4c2dPJp9fAcx0ORuif0suhe0wOQgFbYW1++N
         LLLR4kqK4QGwk2KG3r8I5Mv20HTjlhuYAVNPhTGbGp/fWpsJkfEkCnpaymj4STaVIUvY
         v4nA==
X-Gm-Message-State: AOAM533CNKajyLWrrRAAMzt6rNEkXEvPW0PdujA1z/VMKvnxx14dEk3x
        d8zEXVGS470LFNLL+Nz9TF+SQpnGLz1c2aThTMvWiQ==
X-Google-Smtp-Source: ABdhPJzcZTCOKqEWiKtOr3cqY8dpySVBaWHsu2PluaCbkbwShxS7CdHAVkVEzJfg0NN2gxF+S8ns1gn3jF3wShPu/RE=
X-Received: by 2002:ac2:5472:: with SMTP id e18mr761103lfn.489.1610504201634;
 Tue, 12 Jan 2021 18:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20210112040146.1.I9aa2b9dd39a6ac9235ec55a8c56020538aa212fb@changeid>
 <20210112223228.GA1857596@bjorn-Precision-5520>
In-Reply-To: <20210112223228.GA1857596@bjorn-Precision-5520>
From:   Victor Ding <victording@google.com>
Date:   Wed, 13 Jan 2021 13:16:05 +1100
Message-ID: <CANqTbdb4gZYQUAZzatwymy-S9Ajb=PhfP53_D2TYLJp0zw4HxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI/ASPM: Disable ASPM until its LTR and L1ss state
 is restored
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        linux-mmc@vger.kernel.org, Alex Levin <levinale@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sukumar Ghorai <sukumar.ghorai@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, Jan 13, 2021 at 9:32 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Hi Victor,
>
> Thanks for the patch.  Improving suspend/resume performance is always
> a good thing!
>
> On Tue, Jan 12, 2021 at 04:02:04AM +0000, Victor Ding wrote:
> > Right after powering up, the device may have ASPM enabled; however,
> > its LTR and/or L1ss controls may not be in the desired states; hence,
> > the device may enter L1.2 undesirably and cause resume performance
> > penalty. This is especially problematic if ASPM related control
> > registers are modified before a suspension.
>
> s/L1ss/L1SS/ (several occurrences) to match existing usage.
>
I'll update it in the next version.
>
> > Therefore, ASPM should disabled until its LTR and L1ss states are
> > fully restored.
> >
> > Signed-off-by: Victor Ding <victording@google.com>
> > ---
> >
> >  drivers/pci/pci.c       | 11 +++++++++++
> >  drivers/pci/pci.h       |  2 ++
> >  drivers/pci/pcie/aspm.c |  2 +-
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index eb323af34f1e..428de433f2e6 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1660,6 +1660,17 @@ void pci_restore_state(struct pci_dev *dev)
> >       if (!dev->state_saved)
> >               return;
> >
> > +     /*
> > +      * Right after powering up, the device may have ASPM enabled;
>
> I think this could be stated more precisely.  "Right after powering
> up," ASPM should be *disabled* because ASPM Control in the Link
> Control register powers up as zero (disabled).
>
Good suggestion; I'll reword in the next version.
However, ASPM should be *disabled* for the opposite reason - ASPM Control
in the Link Control register *may* power as non-zero (enabled).
(More answered in the next section)
>
> > +      * however, its LTR and/or L1ss controls may not be in the desired
> > +      * states; as a result, the device may enter L1.2 undesirably and
> > +      * cause resume performance penalty.
> > +      * Therefore, ASPM is disabled until its LTR and L1ss states are
> > +      * fully restored.
> > +      * (enabling ASPM is part of pci_restore_pcie_state)
>
> If we're enabling L1.2 before LTR has been configured, that's
> definitely a bug.  But I don't see how that happens.  The current code
> looks like:
>
>   pci_restore_state
>     pci_restore_ltr_state
>       pci_write_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap++)
>       pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, *cap++)
>     pci_restore_aspm_l1ss_state
>       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++)
>     pci_restore_pcie_state
>       pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++])
>
> We *do* restore PCI_L1SS_CTL1, which contains "ASPM L1.2 Enable",
> before we restore PCI_EXP_LNKCTL, which contains "ASPM Control", but I
> don't think "ASPM L1.2 Enable" by itself should be enough to allow
> hardware to enter L1.2.
>
> Reading PCIe r5.0, sec 5.5.1, it seems like hardware should ignore the
> PCI_L1SS_CTL1 bits unless ASPM L1 entry is enabled in PCI_EXP_LNKCTL.
>
> What am I missing?
>
Correct; however, PCI_EXP_LNKCTL may power up as non-zero, i.e. has ASPM
Control enabled. BIOS may set PCI_EXP_LNKCTL (and PCI_L1SS_CTL1) before
Kernel takes control. When BIOS does so, there is a brief period
between powering
up and Kernel restoring LTR state that L1.2 is enabled but LTR isn't configured.
>
> > +      */
> > +     pcie_config_aspm_dev(dev, 0);
> > +
> >       /*
> >        * Restore max latencies (in the LTR capability) before enabling
> >        * LTR itself (in the PCIe capability).
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index e9ea5dfaa3e0..f774bd6d2555 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -564,6 +564,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
> >  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> >  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
> >  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> > +void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val);
> >  void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> >  void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> >  #else
> > @@ -571,6 +572,7 @@ static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
> >  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> >  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
> >  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> > +static inline void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val) { }
> >  static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
> >  static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
> >  #endif
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index a08e7d6dc248..45535b4e1595 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -778,7 +778,7 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
> >       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
> >  }
> >
> > -static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
> > +void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
> >  {
> >       pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> >                                          PCI_EXP_LNKCTL_ASPMC, val);
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
> >
