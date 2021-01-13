Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA32F41A1
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 03:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbhAMCRm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 21:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbhAMCRm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 21:17:42 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CADC06179F
        for <linux-pci@vger.kernel.org>; Tue, 12 Jan 2021 18:17:01 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id e7so780896ljg.10
        for <linux-pci@vger.kernel.org>; Tue, 12 Jan 2021 18:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QF0LMsSrVnu1WRqxh2aVOIkN8CA5lClgVWJhJvLqoY=;
        b=EABsV1DIwxaytHiaDExy2EF2hnI5gqsFa5Gx9qnN7O0MeR830iZ/gR3Ye5gLxa3L1K
         2UtGBxtD7mrYx3ULibQ1T5dWKujRXcbpnOCOqdfsrDYJU2Xub47VrPKeJWX9xALjvGYh
         yLNuXwzQv5vPyyRg9c7+tecSHU/3XlMoMtH9ETdVjnSqHuG6CpdudkhAOnybUE0wQApV
         kq/OuOoBHNUXyrQJGyLse5R2ljD4i9PpMz+xJorPTnKt6nl9kJI8G8zSIONv2Jah8TWj
         jiI0D1VhcMeiGMTgUehzSW8dgcpNfBplClZbhaKtUcp7OxpVxhi66dDdPIGSYJAQD8fx
         V6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QF0LMsSrVnu1WRqxh2aVOIkN8CA5lClgVWJhJvLqoY=;
        b=bgBbmPcmXWHwD9FYf3YCZ5lfzo4d/cPr2wmTCLehTduGVteu0Y2RC7isoF53LSciEp
         HrH/BpBJBiAmmrKkbX5JxaBmZwMVi6wtwO62GenVOwX4p+0NEQCQ5CXnQLFvKkrDtTch
         XcepAJ4DP63fk+9iHXufNkSbo51Qt4bkTRRuLTAOwfvfHd606R81djFP3c6rhF3cZOWl
         8PmplIIKORgHwwzmb/2cWYoP+pcecDN6fho931f2v2xBwtGBF/GYsS6r8VnXI2DsCWue
         leOzNB6t6OBqFa+1xbrQbV/JJvXW/5LzlY7PMRjINShYwwFaUHAUAAFBgjN9mrbKBoch
         8hkg==
X-Gm-Message-State: AOAM531HCitssOTAYfb2tg0hDge6sqgasO6PYNdoUw36W1dSYfi/rfam
        F+jXN7f9RNsAsgqGg9M4mgV1SIXTqjJwp52L3Og81w==
X-Google-Smtp-Source: ABdhPJzogB55M//GtTTPJSuBzmoYOuI3VIr2FIqX2l1NrAlObgnQa9huObiQPGYNZRbyh2BNl2tHUw603ib6Ox2DSyw=
X-Received: by 2002:a05:651c:301:: with SMTP id a1mr871465ljp.275.1610504219806;
 Tue, 12 Jan 2021 18:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20210112040146.2.Ic902bbd9f04e2d82ac578411e7fafc77b6c750e2@changeid>
 <20210112223830.GA1858627@bjorn-Precision-5520>
In-Reply-To: <20210112223830.GA1858627@bjorn-Precision-5520>
From:   Victor Ding <victording@google.com>
Date:   Wed, 13 Jan 2021 13:16:23 +1100
Message-ID: <CANqTbdYYSAvpzN2oaPSb2PUCE=rssj19GueTZmkvmukQWj9vUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci-gli: Disable ASPM during a suspension
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 13, 2021 at 9:38 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jan 12, 2021 at 04:02:05AM +0000, Victor Ding wrote:
> > GL9750 has a 3100us PortTPowerOnTime; however, it enters L1.2 after
> > only ~4us inactivity per PCIe trace. During a suspend/resume process,
> > PCI access operations are frequently longer than 4us apart.
> > Therefore, the device frequently enters and leaves L1.2 during this
> > process, causing longer than desirable suspend/resume time. The total
> > time cost due to this L1.2 exit latency could add up to ~200ms.
> >
> > Considering that PCI access operations are fairly close to each other
> > (though sometimes > 4us), the actual time the device could stay in
> > L1.2 is negligible. Therefore, the little power-saving benefit from
> > ASPM during suspend/resume does not overweight the performance
> > degradation caused by long L1.2 exit latency.
> >
> > Therefore, this patch proposes to disable ASPM during a suspend/resume
> > process.
>
> This sounds like an interesting idea, but it doesn't seem like
> anything that's really device-dependent.  Drivers should not need to
> be involved in PCI configuration at this level, and they shouldn't
> read/write registers like PCI_EXP_LNKCTL directly.
>
> If we need to disable ASPM during suspend, I'd rather do it in the PCI
> core so all devices can benefit and drivers don't need to worry about
> it.
>
Good point. In theory all devices could encounter this issue, and it
more-likely occurs on those with low entry timer but high exit latency.
GL9750 is the only one I have access to that has such characteristics.

I think we should have ASPM disabled during suspend, or at least part
of the suspend process*, mainly for two reasons:
1. Power saving is expected to be little. During suspend/resume, we
    frequently access PCI registers, making it unlikely to stay in low
    power states;
2. It could cause performance degradation. Unfortunate timing could
    put the device into low power states and wake it up very soon after;
    resulting noticeable delays.
* By "part if the suspend process", I refer [suspend/resume]_noirq, where
there are frequent PCI register accesses and suffers most from this issue.

Ideally, the entry time could be tune so that it is long enough that the
device would not go into low power states during suspend; however, it
may not be feasible mainly because:
1. Hardware limitations;
2. The best timing for suspend/resume may not be the best timing for other
    tasks. Considering suspend/resume is a rare task, we probably do not
    want to sacrifice other tasks;
3. If the goal is to avoid entering low power states during suspend, it might
    be better just to disable it.

What do you think?
>
> > Signed-off-by: Victor Ding <victording@google.com>
> > ---
> >
> >  drivers/mmc/host/sdhci-pci-core.c |  2 +-
> >  drivers/mmc/host/sdhci-pci-gli.c  | 46 +++++++++++++++++++++++++++++--
> >  drivers/mmc/host/sdhci-pci.h      |  1 +
> >  3 files changed, 46 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > index 9552708846ca..fd7544a498c0 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -67,7 +67,7 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
> >       return 0;
> >  }
> >
> > -static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
> > +int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
> >  {
> >       int i, ret;
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > index 9887485a4134..c7b788b0e22e 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -109,6 +109,12 @@
> >
> >  #define GLI_MAX_TUNING_LOOP 40
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +struct gli_host {
> > +     u16 linkctl_saved;
> > +};
> > +#endif
> > +
> >  /* Genesys Logic chipset */
> >  static inline void gl9750_wt_on(struct sdhci_host *host)
> >  {
> > @@ -577,14 +583,48 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
> >  }
> >
> >  #ifdef CONFIG_PM_SLEEP
> > +static int sdhci_pci_gli_suspend(struct sdhci_pci_chip *chip)
> > +{
> > +     int ret;
> > +     struct sdhci_pci_slot *slot = chip->slots[0];
> > +     struct pci_dev *pdev = slot->chip->pdev;
> > +     struct gli_host *gli_host = sdhci_pci_priv(slot);
> > +
> > +     ret = pcie_capability_read_word(pdev, PCI_EXP_LNKCTL,
> > +                     &gli_host->linkctl_saved);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     ret = pcie_capability_write_word(pdev, PCI_EXP_LNKCTL,
> > +                     gli_host->linkctl_saved & ~PCI_EXP_LNKCTL_ASPMC);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     ret = sdhci_pci_suspend_host(chip);
> > +
> > +exit:
> > +     return ret;
> > +}
> > +
> >  static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> >  {
> > +     int ret;
> >       struct sdhci_pci_slot *slot = chip->slots[0];
> > +     struct pci_dev *pdev = slot->chip->pdev;
> > +     struct gli_host *gli_host = sdhci_pci_priv(slot);
> >
> > -     pci_free_irq_vectors(slot->chip->pdev);
> > +     pci_free_irq_vectors(pdev);
> >       gli_pcie_enable_msi(slot);
> >
> > -     return sdhci_pci_resume_host(chip);
> > +     ret = sdhci_pci_resume_host(chip);
> > +     if (ret)
> > +             goto exit;
> > +
> > +     ret = pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> > +                     PCI_EXP_LNKCTL_ASPMC, gli_host->linkctl_saved);
> > +
> > +exit:
> > +     return ret;
> >  }
> >
> >  static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
> > @@ -834,7 +874,9 @@ const struct sdhci_pci_fixes sdhci_gl9750 = {
> >       .probe_slot     = gli_probe_slot_gl9750,
> >       .ops            = &sdhci_gl9750_ops,
> >  #ifdef CONFIG_PM_SLEEP
> > +     .suspend        = sdhci_pci_gli_suspend,
> >       .resume         = sdhci_pci_gli_resume,
> > +     .priv_size      = sizeof(struct gli_host),
> >  #endif
> >  };
> >
> > diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> > index d0ed232af0eb..16187a265e63 100644
> > --- a/drivers/mmc/host/sdhci-pci.h
> > +++ b/drivers/mmc/host/sdhci-pci.h
> > @@ -187,6 +187,7 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
> >  }
> >
> >  #ifdef CONFIG_PM_SLEEP
> > +int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip);
> >  int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
> >  #endif
> >  int sdhci_pci_enable_dma(struct sdhci_host *host);
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
> >
