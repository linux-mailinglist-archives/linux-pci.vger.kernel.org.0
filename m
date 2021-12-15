Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF10147607A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 19:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244405AbhLOSPX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 13:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbhLOSPW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 13:15:22 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CBBC06173F;
        Wed, 15 Dec 2021 10:15:22 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id u68so15144033vke.11;
        Wed, 15 Dec 2021 10:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8W2UHSgyaQqFRjauGt8EERxuZx77NqQIXtATvxyGB4s=;
        b=lFA6ZU/J2TJzbPI0cBflc4JqEypHvUC7d6KcSQM3BCTbgfSeHTYMSyS14AsFFCbFo9
         WB2WEUtK5cjsjqgLrJTnwO7PN0WEfzsVomQC3hLo40I2qjQiCCuT0yD2QmAMgTrhnoEJ
         mwNcB8ngqta/mB2HLDhqakp4Dq3zLtF3obCaiW56xbUNxHbjdk9cHrAxxwprATRHOMCF
         OeAZWH2ct/rNOK5PL9+B+j5GTKaj8daQtM4EuVbiWclf3bnXeDFCmcFgg/P/RjAxJEs3
         1HUl/LJeo9+KBSyq/LUdVCOqadSHlU5LkFcXp6WT/YuK8gnCrtdTDo+shLcdHf8572hA
         83mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8W2UHSgyaQqFRjauGt8EERxuZx77NqQIXtATvxyGB4s=;
        b=bJbmTnpxsQAXhboeevpKqQLUl/8WyGa9GSiju7hT1xkQubr7JE6B1E0zyErtVPAiGr
         iTUiCkVtoAcvEPX1k1RcYDGAjP1wrR6j04Siw8gzXQfwp7ZC37pTQG7RmU4SZ1qiCjw6
         b/VMmhU80YtyDp0IYuG/Opn7R793mAxXKKBKHK/MHfwv0mqal19DNbS1LQ4QC5tckOEk
         FiAFVbXlPusryo0NMnzRbl0w4JdpcMwJEHL/VHdKvJmS9XRURh2Qg1yxf/vzbIqzOPS8
         0jue+MzMWzhbTz9xhLZx8ZDcUcwdo1FpcO/jCoLG0k1Q+9j2ej9Q/GkdVqsae0QNcJfB
         TGWQ==
X-Gm-Message-State: AOAM533e3YC3G5G39Ag5BIiC645gKhEe/Hqg+gCi8DSFUvWiZiwG3JVP
        b/0JtrmluYszpbZRK/kHYwNxUgOSFXHPxPbgELs=
X-Google-Smtp-Source: ABdhPJy6+ZYj/czS+N6xQJJVPwbFkSClmjGyoVDwrPO8FgNgKs5g9wvBbt4I+QxOrjRIXtKEMJ/Xl/j05IdFnbkFMdM=
X-Received: by 2002:a05:6122:732:: with SMTP id 50mr4516866vki.28.1639592121248;
 Wed, 15 Dec 2021 10:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20211208000948.487820-1-rajatja@google.com> <20211215180426.GA702736@bhelgaas>
In-Reply-To: <20211215180426.GA702736@bhelgaas>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Wed, 15 Dec 2021 10:15:02 -0800
Message-ID: <CAA93t1rQgfUP7jDKK+Gu80EyxQJpUDGz+=4LgjSfJUi77s_AeQ@mail.gmail.com>
Subject: Re: [PATCH] pci/quirks: Add quirk for Bayhub O2 SD controller
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>, gwendal@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for taking a look.

On Wed, Dec 15, 2021 at 10:04 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Dec 07, 2021 at 04:09:48PM -0800, Rajat Jain wrote:
> > This particular SD controller from O2 / Bayhub only allows dword
> > accesses to its LTR max latency registers:
> > https://github.com/rajatxjain/public_shared/blob/main/OZ711LV2_appnote.pdf
>
> What happens if we use a non-dword access?  Unsupported Request?
> Invalid data returned?  Writes ignored?

Invalid data values are read / written.

>
> I guess word accesses must not cause PCIe errors, since we still do
> them in pci_save_ltr_state() and pci_restore_ltr_state() even with
> this patch.

Yes, that is correct.

>
> The app note says 0x234 (Max Latency registers), 0x248 (L1 PM
> Substates Control 1), and 0x24c (L1 PM Substates Control 2) are all
> broken, but the patch only mentions 0x234.
>
> I guess for 0x248 and 0x24c (the L1 PM Substates Control registers),
> we're just lucky because those are dword registers, and all current
> users already do dword accesses.

Yes, that is right.

>
> What if we instead changed pci_save_ltr_state() and
> pci_restore_ltr_state() to do a single dword access instead of two
> word accesses?  That kind of sweeps it under the rug, but we're
> already doing that for 0x248 and 0x24c.

Yes, that is what I had in mind originally, and actually I'd prefer
that too. I was afraid you might disagree :-). It sounds like we're on
the same page though, so should I send a patch with that approach?

>
> If we did that, we shouldn't need a quirk at all, but the hardware bug
> is still lurking, and we should add a comment about it somewhere.

I can add a comment in pci_save_ltr_state() / pci_restore_ltr_state().

>
> I guess setpci (and maybe lspci) could still do smaller accesses and
> see whatever the bad behavior is.  Hmmm.  Maybe we just have to live
> with that.
>
> The app note doesn't actually say how to identify the part -- no
> "affected Device ID", for instance.  Are we confident that the other
> O2_* devices are unaffected?

Yes, I noticed that. I confirmed with them that no other parts are
affected (in an internal bug unfortunately). I can ask them to update
their appnote also.

Thanks & Best Regards,

Rajat

>
> > Thus add a quirk that saves and restores these registers
> > manually using dword acesses:
> > LTR Max Snoop Latency Register
> > LTR Max No-Snoop Latency Register
> >
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> >  drivers/mmc/host/sdhci-pci.h |  1 -
> >  drivers/pci/quirks.c         | 39 ++++++++++++++++++++++++++++++++++++
> >  include/linux/pci_ids.h      |  1 +
> >  3 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> > index 5e3193278ff9..d47cc0ba7ca4 100644
> > --- a/drivers/mmc/host/sdhci-pci.h
> > +++ b/drivers/mmc/host/sdhci-pci.h
> > @@ -10,7 +10,6 @@
> >  #define PCI_DEVICE_ID_O2_SDS1                0x8421
> >  #define PCI_DEVICE_ID_O2_FUJIN2              0x8520
> >  #define PCI_DEVICE_ID_O2_SEABIRD0    0x8620
> > -#define PCI_DEVICE_ID_O2_SEABIRD1    0x8621
> >
> >  #define PCI_DEVICE_ID_INTEL_PCH_SDIO0        0x8809
> >  #define PCI_DEVICE_ID_INTEL_PCH_SDIO1        0x880a
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 003950c738d2..b7bd19802744 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5857,3 +5857,42 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
> >       pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;
> >  }
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
> > +
> > +/*
> > + * Bayhub OZ711LV2 SD controller has an errata that only allows DWORD accesses
> > + * to the LTR max latency registers. Thus need to save and restore these
> > + * registers manually.
> > + */
> > +static void o2_seabird1_save_ltr(struct pci_dev *dev)
> > +{
> > +     struct pci_cap_saved_state *save_state;
> > +     u32 *reg32;
> > +
> > +     save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> > +     if (save_state) {
> > +             reg32 = &save_state->cap.data[0];
> > +             /* Preserve PCI_LTR_MAX_SNOOP_LAT & PCI_LTR_MAX_NOSNOOP_LAT */
> > +             pci_read_config_dword(dev, 0x234, reg32);
> > +     } else {
> > +             pci_err(dev, "quirk can't save LTR snoop latency\n");
> > +     }
> > +}
> > +
> > +static void o2_seabird1_restore_ltr(struct pci_dev *dev)
> > +{
> > +     struct pci_cap_saved_state *save_state;
> > +     u32 *reg32;
> > +
> > +     save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> > +     if (save_state) {
> > +             reg32 = &save_state->cap.data[0];
> > +             /* Restore PCI_LTR_MAX_SNOOP_LAT & PCI_LTR_MAX_NOSNOOP_LAT */
> > +             pci_write_config_dword(dev, 0x234, *reg32);
> > +     } else {
> > +             pci_err(dev, "quirk can't restore LTR snoop latency\n");
> > +     }
> > +}
> > +DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_SEABIRD1,
> > +                            o2_seabird1_save_ltr);
> > +DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_SEABIRD1,
> > +                            o2_seabird1_restore_ltr);
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 011f2f1ea5bb..6ed16aa38196 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -1717,6 +1717,7 @@
> >  #define PCI_DEVICE_ID_O2_8221                0x8221
> >  #define PCI_DEVICE_ID_O2_8320                0x8320
> >  #define PCI_DEVICE_ID_O2_8321                0x8321
> > +#define PCI_DEVICE_ID_O2_SEABIRD1    0x8621
> >
> >  #define PCI_VENDOR_ID_3DFX           0x121a
> >  #define PCI_DEVICE_ID_3DFX_VOODOO    0x0001
> > --
> > 2.34.1.400.ga245620fadb-goog
> >
