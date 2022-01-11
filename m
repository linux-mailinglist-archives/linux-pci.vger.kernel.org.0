Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE98748BA80
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 23:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345484AbiAKWJC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 17:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345466AbiAKWJA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jan 2022 17:09:00 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B30C06173F;
        Tue, 11 Jan 2022 14:09:00 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id k15so1813030edk.13;
        Tue, 11 Jan 2022 14:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=AkrcGrVzJVeMi9QZ0GgFqv58rNqhQAkifpl96t3BMvs=;
        b=pV+XY/w89E+g8m7FO1TZnIYkp/3uwM/PZXmKtlXP+fl4YSAZTOi0G8mP1VngeboXui
         0oOgvwPrIU1m4FwnlRixybLpslH5fiqoXLXLFpW5dvyyvUELctHZTdn8mWn6ZnA8fays
         4ATIg6oHiQlPNnt9wB+MYds97o+VGVcxd7scPIxFKjCZg6/yw3O763RfNjDG4tKBKAJ3
         SAkPFUAfFBDCVsT5btspwfHjp9anVVNtQWIdyFSH/Wc6QOuTfsHtQpvC3ZUwnmcfADub
         sT55l/DfFoT7l7Cn4y3WdKWa2SwOhYfaQ24lYuSEhYC1DjauYXdU8/M1/wVdNuYkyp+3
         PiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=AkrcGrVzJVeMi9QZ0GgFqv58rNqhQAkifpl96t3BMvs=;
        b=2bz4ihqryfIDBrGWujvvuxhxJjd7pJWEkTTq4R62pYN8jsDkHJyE1RsW/xgH+vAKyu
         rO+2CGtDpu+aDjrvd2njF5fEwJYmS4I5Vhkg562W0dCFaOXJf3hkLlrxxU1AZqkixF7k
         C8XJn5XuDP8o7a32pI1s7TEIK+ai6/5golwW6jL1kR0uSGzB1LVuyZxUt8GKPQ5xCQXm
         J/E4u5qAh5o1UelBFYH24xzJkPbCWNgHrAbUwJ40Bj/L2kV/in2HRHYm4UJUJ5hBcf/o
         NWLFsU5UaR0n227etX7zPx4pb5l6mnoL8G7QyBdOwbC0gc6Pr0TD9XEO1O5tuzG3qrNz
         l0Pw==
X-Gm-Message-State: AOAM533mDVvIfnsc/cSc7pZMqf/oKGA4JqyuwsxN5mt8WCSDe8g9gsek
        eklr7QgyG/u4te4wTqYCrnpEhpi+UxUL3EZqnbU=
X-Google-Smtp-Source: ABdhPJw96nWtta56U5jXF0Jj5CzV+hWqwrSBw/zMsuEp4TY7D1Ufd4JRyPY3EwFhZ0w62p2FoCE/wf0xZJInqicSap4=
X-Received: by 2002:a05:6402:3496:: with SMTP id v22mr6356889edc.347.1641938938837;
 Tue, 11 Jan 2022 14:08:58 -0800 (PST)
MIME-Version: 1.0
References: <20211222012105.3438916-1-rajatja@google.com> <20220111163916.GA148556@bhelgaas>
In-Reply-To: <20220111163916.GA148556@bhelgaas>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Tue, 11 Jan 2022 14:08:47 -0800
Message-ID: <CAA93t1pkyQdZfWAQardP6bzw7Exsvd6nKqR2UPY4WPKKHVytaQ@mail.gmail.com>
Subject: Re: [PATCH] pci: Make DWORD accesses while saving / restoring LTR state
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

On Tue, Jan 11, 2022 at 8:39 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Dec 21, 2021 at 05:21:05PM -0800, Rajat Jain wrote:
> > Some devices have an errata such that they only support DWORD accesses
> > to some registers.
> >
> > For e.g. this Bayhub O2 device ([VID:DID] = [0x1217:0x8621]) only
> > supports DWORD accesses to LTR latency registers and L1 PM substates
> > control registers:
> > https://github.com/rajatxjain/public_shared/blob/main/OZ711LV2_appnote.pdf
> >
> > Since L1 PM substate control registers are DWORD sized, and hence their
> > access in the kernel is already DWORD sized, so we don't need to do
> > anything for them.
> >
> > However, the LTR registers being WORD sized, are in need of a solution.
> > This patch converts the WORD sized accesses to these registers, into
> > DWORD sized accesses, while saving and restoring them.
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
>
> Applied to pci/enumeration for v5.17, thanks, Rajat!

Thank you.

>
> The app note suggests that this erratum only affects the registers at
> 0x234, 0x248, and 0x24c, i.e., the LTR snoop registers and the L1 SS
> control registers.
>
> Can you confirm that is true?  Byte and word accesses to other parts
> of config space work correctly?
>
> I *assume* the other parts work correctly, because if byte and word
> accesses were broken, all sorts of things would not work, like
> PCI_COMMAND, PCI_STATUS, searching the capability list, etc.


Yes, that is correct. The Bayhub SD controller works fine otherwise,
so only these registers needed the quirk.

Thanks & Best Regards,

Rajat


>
> Bjorn
>
> > ---
> >  drivers/pci/pci.c       | 24 ++++++++++++++++--------
> >  drivers/pci/pcie/aspm.c |  1 +
> >  2 files changed, 17 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 3d2fb394986a..efa8cd16827f 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1556,7 +1556,7 @@ static void pci_save_ltr_state(struct pci_dev *dev)
> >  {
> >       int ltr;
> >       struct pci_cap_saved_state *save_state;
> > -     u16 *cap;
> > +     u32 *cap;
> >
> >       if (!pci_is_pcie(dev))
> >               return;
> > @@ -1571,25 +1571,33 @@ static void pci_save_ltr_state(struct pci_dev *dev)
> >               return;
> >       }
> >
> > -     cap = (u16 *)&save_state->cap.data[0];
> > -     pci_read_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap++);
> > -     pci_read_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, cap++);
> > +     /*
> > +      * We deliberately do a dword access to save both PCI_LTR_MAX_SNOOP_LAT
> > +      * and PCI_LTR_MAX_NOSNOOP_LAT together since some devices only support
> > +      * dword accesses to these registers.
> > +      */
> > +     cap = &save_state->cap.data[0];
> > +     pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
> >  }
> >
> >  static void pci_restore_ltr_state(struct pci_dev *dev)
> >  {
> >       struct pci_cap_saved_state *save_state;
> >       int ltr;
> > -     u16 *cap;
> > +     u32 *cap;
> >
> >       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> >       ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
> >       if (!save_state || !ltr)
> >               return;
> >
> > -     cap = (u16 *)&save_state->cap.data[0];
> > -     pci_write_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap++);
> > -     pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, *cap++);
> > +     /*
> > +      * We deliberately do a dword access to restore both
> > +      * PCI_LTR_MAX_SNOOP_LAT and PCI_LTR_MAX_NOSNOOP_LAT together since
> > +      * some devices only support dword accesses to these registers.
> > +      */
> > +     cap = &save_state->cap.data[0];
> > +     pci_write_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap);
> >  }
> >
> >  /**
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 52c74682601a..083f47a7b69b 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -496,6 +496,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> >       encode_l12_threshold(l1_2_threshold, &scale, &value);
> >       ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
> >
> > +     /* Always make DWORD sized accesses to these registers */
> >       pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
> >       pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, &pctl2);
> >       pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1, &cctl1);
> > --
> > 2.34.1.307.g9b7440fafd-goog
> >
