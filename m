Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253532F5D0C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 10:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbhANJPR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 04:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbhANJPM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 04:15:12 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3B3C0617A3
        for <linux-pci@vger.kernel.org>; Thu, 14 Jan 2021 01:13:45 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id y22so5593302ljn.9
        for <linux-pci@vger.kernel.org>; Thu, 14 Jan 2021 01:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ObLDGp8DuMzPgMQv/qADlwdPf//cWJIYZWG0SUKU73w=;
        b=h0xSUEhzob2HnVedUD2Pf29GGbGo+859Z+ax6VWigVg/CxGbhsvOTC3VGVZ6kMAeMU
         55QySLwqdUsIwMrRQoJdPjL8iNXQIpFi/UwlbyRBMMR2eKOJsYvHPIVqtYKhD7SkKlU5
         mUcQPLyDueAl9kmUCnGaVVX/zLBdQLftm8fDl/KCzB/ofYqTfIsHn+V1OXg+e3K293LB
         e0AX27VB1pgJhpenSv+gg2/b5+ywAGtVl5NAcGXgAO3bLDjzpoZJ31DlzkeAv75J8muw
         3iRdWkADPoS+Ez42vG/xgap5l4TfCsxCl5aqPYxP5e6Ief3Me545z4fbdllcFMHFAp0r
         77hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ObLDGp8DuMzPgMQv/qADlwdPf//cWJIYZWG0SUKU73w=;
        b=s6ozb07d4IewO7VmxtZ6DopoRPCTz+EDIU9v/JRcg9jqFoskCcUtUzpCYepcjz6rvE
         uHjOyCjC18mhaAsG/1mkf5NBayFAWeHe7t4qG99klsCO/0Pi6cPdxTeNF7RVQ/IxxGkQ
         L6sDRzFw3Fcb481SvNYgkpzSSaLO6Ix/jQhO6jO3RGXm8bLOTU2xUWqD69nNKWmNqgxy
         t+HNdK1yO+s/V8V3XWcbP720vE4AvhaCBt5uIQi9zcPNsZAQ0+RSwVWy+vuIKrjsn98c
         ddc1ST63bCFz9kZEdnVit1FTeJ59Jvt4qcwtLHyopOAiAdgWXsgPhG6bbTzRNeoLBl7t
         KedQ==
X-Gm-Message-State: AOAM532BQ8nJOoaF9oZUG7l7HeHBbQtCEP0SVo1nxiWzpQr6Ody+WZxh
        o35yS8Hy4SgBvtVmukZsrOe43gwl5cEIE6l7j6UsGPs0srQ6IHhR
X-Google-Smtp-Source: ABdhPJwR0tFjm9efXu0cD7T8HbZgWV+gZtMHsKLnBlvraKnS2E8/FIF9DB4zt34uoyasy9c5iLX5LUjTk0D7aAcTAHU=
X-Received: by 2002:a2e:2a83:: with SMTP id q125mr2758210ljq.436.1610615624127;
 Thu, 14 Jan 2021 01:13:44 -0800 (PST)
MIME-Version: 1.0
References: <CANqTbdYYSAvpzN2oaPSb2PUCE=rssj19GueTZmkvmukQWj9vUw@mail.gmail.com>
 <20210113214822.GA1923207@bjorn-Precision-5520>
In-Reply-To: <20210113214822.GA1923207@bjorn-Precision-5520>
From:   Victor Ding <victording@google.com>
Date:   Thu, 14 Jan 2021 20:13:08 +1100
Message-ID: <CANqTbdY9PGMu7EzMcG0GG3SdoPDNhV0aUfOoRDKfGmo=BS+UPA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci-gli: Disable ASPM during a suspension
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 14, 2021 at 8:48 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rafael, suspend/resume expert]
>
> On Wed, Jan 13, 2021 at 01:16:23PM +1100, Victor Ding wrote:
> > On Wed, Jan 13, 2021 at 9:38 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Jan 12, 2021 at 04:02:05AM +0000, Victor Ding wrote:
> > > > GL9750 has a 3100us PortTPowerOnTime; however, it enters L1.2 after
> > > > only ~4us inactivity per PCIe trace. During a suspend/resume process,
> > > > PCI access operations are frequently longer than 4us apart.
> > > > Therefore, the device frequently enters and leaves L1.2 during this
> > > > process, causing longer than desirable suspend/resume time. The total
> > > > time cost due to this L1.2 exit latency could add up to ~200ms.
> > > >
> > > > Considering that PCI access operations are fairly close to each other
> > > > (though sometimes > 4us), the actual time the device could stay in
> > > > L1.2 is negligible. Therefore, the little power-saving benefit from
> > > > ASPM during suspend/resume does not overweight the performance
> > > > degradation caused by long L1.2 exit latency.
> > > >
> > > > Therefore, this patch proposes to disable ASPM during a suspend/resume
> > > > process.
> > >
> > > This sounds like an interesting idea, but it doesn't seem like
> > > anything that's really device-dependent.  Drivers should not need to
> > > be involved in PCI configuration at this level, and they shouldn't
> > > read/write registers like PCI_EXP_LNKCTL directly.
> > >
> > > If we need to disable ASPM during suspend, I'd rather do it in the PCI
> > > core so all devices can benefit and drivers don't need to worry about
> > > it.
> > >
> > Good point. In theory all devices could encounter this issue, and it
> > more-likely occurs on those with low entry timer but high exit latency.
> > GL9750 is the only one I have access to that has such characteristics.
> >
> > I think we should have ASPM disabled during suspend, or at least part
> > of the suspend process*, mainly for two reasons:
> > 1. Power saving is expected to be little. During suspend/resume, we
> >     frequently access PCI registers, making it unlikely to stay in low
> >     power states;
> > 2. It could cause performance degradation. Unfortunate timing could
> >     put the device into low power states and wake it up very soon after;
> >     resulting noticeable delays.
> > * By "part if the suspend process", I refer [suspend/resume]_noirq, where
> > there are frequent PCI register accesses and suffers most from this issue.
> >
> > Ideally, the entry time could be tune so that it is long enough that the
> > device would not go into low power states during suspend; however, it
> > may not be feasible mainly because:
> > 1. Hardware limitations;
> > 2. The best timing for suspend/resume may not be the best timing for other
> >     tasks. Considering suspend/resume is a rare task, we probably do not
> >     want to sacrifice other tasks;
> > 3. If the goal is to avoid entering low power states during suspend, it might
> >     be better just to disable it.
> >
> > What do you think?
>
> I think we should look at disabling ASPM for all devices during
> suspend.  I really don't want to put this kind of gunk in individual
> drivers.  If we *have* to put something in drivers, it should be using
> interfaces like pci_disable_link_state() instead of writing
> PCI_EXP_LNKCTL directly.
>
Agreed.
>
> I *would* be interested in more details about this issue you're seeing
> with GS9750, though.  It will help the case for a core change if we
> can open a bugzilla.kernel.org issue with some of the details like the
> L1 exit latency (from "lspci -vv") and details of the activities that
> lead to these delays.  Typical L1 exit latencies are <100us, so to see
> 200ms of delay would mean ~2000 L1.2 exits, which is higher than I
> would expect.
>
Sorry that I misread the PCIe specs and the trace results. It was
PortTPowerOnTime (Port T_POWER_ON) which added up to ~200ms.
GL9750's PortTPowerOnTime is 3100us or 3.1ms, and I saw up to 60
occurrences during resume.
I've created https://bugzilla.kernel.org/show_bug.cgi?id=211187
We can continue the discussion there.
>
> > > > Signed-off-by: Victor Ding <victording@google.com>
> > > > ---
> > > >
> > > >  drivers/mmc/host/sdhci-pci-core.c |  2 +-
> > > >  drivers/mmc/host/sdhci-pci-gli.c  | 46 +++++++++++++++++++++++++++++--
> > > >  drivers/mmc/host/sdhci-pci.h      |  1 +
> > > >  3 files changed, 46 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > > > index 9552708846ca..fd7544a498c0 100644
> > > > --- a/drivers/mmc/host/sdhci-pci-core.c
> > > > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > > > @@ -67,7 +67,7 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
> > > >       return 0;
> > > >  }
> > > >
> > > > -static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
> > > > +int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
> > > >  {
> > > >       int i, ret;
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > > > index 9887485a4134..c7b788b0e22e 100644
> > > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > > @@ -109,6 +109,12 @@
> > > >
> > > >  #define GLI_MAX_TUNING_LOOP 40
> > > >
> > > > +#ifdef CONFIG_PM_SLEEP
> > > > +struct gli_host {
> > > > +     u16 linkctl_saved;
> > > > +};
> > > > +#endif
> > > > +
> > > >  /* Genesys Logic chipset */
> > > >  static inline void gl9750_wt_on(struct sdhci_host *host)
> > > >  {
> > > > @@ -577,14 +583,48 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
> > > >  }
> > > >
> > > >  #ifdef CONFIG_PM_SLEEP
> > > > +static int sdhci_pci_gli_suspend(struct sdhci_pci_chip *chip)
> > > > +{
> > > > +     int ret;
> > > > +     struct sdhci_pci_slot *slot = chip->slots[0];
> > > > +     struct pci_dev *pdev = slot->chip->pdev;
> > > > +     struct gli_host *gli_host = sdhci_pci_priv(slot);
> > > > +
> > > > +     ret = pcie_capability_read_word(pdev, PCI_EXP_LNKCTL,
> > > > +                     &gli_host->linkctl_saved);
> > > > +     if (ret)
> > > > +             goto exit;
> > > > +
> > > > +     ret = pcie_capability_write_word(pdev, PCI_EXP_LNKCTL,
> > > > +                     gli_host->linkctl_saved & ~PCI_EXP_LNKCTL_ASPMC);
> > > > +     if (ret)
> > > > +             goto exit;
> > > > +
> > > > +     ret = sdhci_pci_suspend_host(chip);
> > > > +
> > > > +exit:
> > > > +     return ret;
> > > > +}
> > > > +
> > > >  static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> > > >  {
> > > > +     int ret;
> > > >       struct sdhci_pci_slot *slot = chip->slots[0];
> > > > +     struct pci_dev *pdev = slot->chip->pdev;
> > > > +     struct gli_host *gli_host = sdhci_pci_priv(slot);
> > > >
> > > > -     pci_free_irq_vectors(slot->chip->pdev);
> > > > +     pci_free_irq_vectors(pdev);
> > > >       gli_pcie_enable_msi(slot);
> > > >
> > > > -     return sdhci_pci_resume_host(chip);
> > > > +     ret = sdhci_pci_resume_host(chip);
> > > > +     if (ret)
> > > > +             goto exit;
> > > > +
> > > > +     ret = pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> > > > +                     PCI_EXP_LNKCTL_ASPMC, gli_host->linkctl_saved);
> > > > +
> > > > +exit:
> > > > +     return ret;
> > > >  }
> > > >
> > > >  static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
> > > > @@ -834,7 +874,9 @@ const struct sdhci_pci_fixes sdhci_gl9750 = {
> > > >       .probe_slot     = gli_probe_slot_gl9750,
> > > >       .ops            = &sdhci_gl9750_ops,
> > > >  #ifdef CONFIG_PM_SLEEP
> > > > +     .suspend        = sdhci_pci_gli_suspend,
> > > >       .resume         = sdhci_pci_gli_resume,
> > > > +     .priv_size      = sizeof(struct gli_host),
> > > >  #endif
> > > >  };
> > > >
> > > > diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> > > > index d0ed232af0eb..16187a265e63 100644
> > > > --- a/drivers/mmc/host/sdhci-pci.h
> > > > +++ b/drivers/mmc/host/sdhci-pci.h
> > > > @@ -187,6 +187,7 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
> > > >  }
> > > >
> > > >  #ifdef CONFIG_PM_SLEEP
> > > > +int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip);
> > > >  int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
> > > >  #endif
> > > >  int sdhci_pci_enable_dma(struct sdhci_host *host);
> > > > --
> > > > 2.30.0.284.gd98b1dd5eaa7-goog
> > > >
