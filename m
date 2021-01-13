Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DB12F580C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 04:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbhANCNL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 21:13:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbhAMVtK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Jan 2021 16:49:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A018E22B37;
        Wed, 13 Jan 2021 21:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610574504;
        bh=AoAdoj3dhenJpoTSS8I+rn2vHApxce6VRzZdAFQW6Ig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=arwcqJkVdMSnlMHpeSZTgD6Dpr64G//8Yhz9ThDmwNespzgCt+1h+lf+4dczNb6Qj
         iF+L8jVjOZXK9mfTtcTDBipxdMWZs6E93Fn+0mlMAoVkCz08eDDugicd3KuRTzEIGo
         kPoceFbmSfb3btrKL3I2y14Q+tVkA9XDaEyN3zu+JBf+OGn5pt46GcJC6yVJJZ2tgQ
         3D30SraIoJp0tFXZFpTyb3kPF2+ioNNCMIzgJxkGwg0ghfMjqjbmTdZqS4PO9gIx8H
         3lBZ1rwCItkBAgGEx6ZYjfTH4i0CMQoSJ9GQwOBj/RkpOeykeurlun8L9xnDkftJnb
         pnAHn73lYeTdw==
Date:   Wed, 13 Jan 2021 15:48:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Victor Ding <victording@google.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci-gli: Disable ASPM during a suspension
Message-ID: <20210113214822.GA1923207@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANqTbdYYSAvpzN2oaPSb2PUCE=rssj19GueTZmkvmukQWj9vUw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, suspend/resume expert]

On Wed, Jan 13, 2021 at 01:16:23PM +1100, Victor Ding wrote:
> On Wed, Jan 13, 2021 at 9:38 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jan 12, 2021 at 04:02:05AM +0000, Victor Ding wrote:
> > > GL9750 has a 3100us PortTPowerOnTime; however, it enters L1.2 after
> > > only ~4us inactivity per PCIe trace. During a suspend/resume process,
> > > PCI access operations are frequently longer than 4us apart.
> > > Therefore, the device frequently enters and leaves L1.2 during this
> > > process, causing longer than desirable suspend/resume time. The total
> > > time cost due to this L1.2 exit latency could add up to ~200ms.
> > >
> > > Considering that PCI access operations are fairly close to each other
> > > (though sometimes > 4us), the actual time the device could stay in
> > > L1.2 is negligible. Therefore, the little power-saving benefit from
> > > ASPM during suspend/resume does not overweight the performance
> > > degradation caused by long L1.2 exit latency.
> > >
> > > Therefore, this patch proposes to disable ASPM during a suspend/resume
> > > process.
> >
> > This sounds like an interesting idea, but it doesn't seem like
> > anything that's really device-dependent.  Drivers should not need to
> > be involved in PCI configuration at this level, and they shouldn't
> > read/write registers like PCI_EXP_LNKCTL directly.
> >
> > If we need to disable ASPM during suspend, I'd rather do it in the PCI
> > core so all devices can benefit and drivers don't need to worry about
> > it.
> >
> Good point. In theory all devices could encounter this issue, and it
> more-likely occurs on those with low entry timer but high exit latency.
> GL9750 is the only one I have access to that has such characteristics.
> 
> I think we should have ASPM disabled during suspend, or at least part
> of the suspend process*, mainly for two reasons:
> 1. Power saving is expected to be little. During suspend/resume, we
>     frequently access PCI registers, making it unlikely to stay in low
>     power states;
> 2. It could cause performance degradation. Unfortunate timing could
>     put the device into low power states and wake it up very soon after;
>     resulting noticeable delays.
> * By "part if the suspend process", I refer [suspend/resume]_noirq, where
> there are frequent PCI register accesses and suffers most from this issue.
> 
> Ideally, the entry time could be tune so that it is long enough that the
> device would not go into low power states during suspend; however, it
> may not be feasible mainly because:
> 1. Hardware limitations;
> 2. The best timing for suspend/resume may not be the best timing for other
>     tasks. Considering suspend/resume is a rare task, we probably do not
>     want to sacrifice other tasks;
> 3. If the goal is to avoid entering low power states during suspend, it might
>     be better just to disable it.
> 
> What do you think?

I think we should look at disabling ASPM for all devices during
suspend.  I really don't want to put this kind of gunk in individual
drivers.  If we *have* to put something in drivers, it should be using
interfaces like pci_disable_link_state() instead of writing
PCI_EXP_LNKCTL directly.

I *would* be interested in more details about this issue you're seeing
with GS9750, though.  It will help the case for a core change if we
can open a bugzilla.kernel.org issue with some of the details like the
L1 exit latency (from "lspci -vv") and details of the activities that
lead to these delays.  Typical L1 exit latencies are <100us, so to see
200ms of delay would mean ~2000 L1.2 exits, which is higher than I
would expect.

> > > Signed-off-by: Victor Ding <victording@google.com>
> > > ---
> > >
> > >  drivers/mmc/host/sdhci-pci-core.c |  2 +-
> > >  drivers/mmc/host/sdhci-pci-gli.c  | 46 +++++++++++++++++++++++++++++--
> > >  drivers/mmc/host/sdhci-pci.h      |  1 +
> > >  3 files changed, 46 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > > index 9552708846ca..fd7544a498c0 100644
> > > --- a/drivers/mmc/host/sdhci-pci-core.c
> > > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > > @@ -67,7 +67,7 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
> > >       return 0;
> > >  }
> > >
> > > -static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
> > > +int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
> > >  {
> > >       int i, ret;
> > >
> > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> > > index 9887485a4134..c7b788b0e22e 100644
> > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > @@ -109,6 +109,12 @@
> > >
> > >  #define GLI_MAX_TUNING_LOOP 40
> > >
> > > +#ifdef CONFIG_PM_SLEEP
> > > +struct gli_host {
> > > +     u16 linkctl_saved;
> > > +};
> > > +#endif
> > > +
> > >  /* Genesys Logic chipset */
> > >  static inline void gl9750_wt_on(struct sdhci_host *host)
> > >  {
> > > @@ -577,14 +583,48 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
> > >  }
> > >
> > >  #ifdef CONFIG_PM_SLEEP
> > > +static int sdhci_pci_gli_suspend(struct sdhci_pci_chip *chip)
> > > +{
> > > +     int ret;
> > > +     struct sdhci_pci_slot *slot = chip->slots[0];
> > > +     struct pci_dev *pdev = slot->chip->pdev;
> > > +     struct gli_host *gli_host = sdhci_pci_priv(slot);
> > > +
> > > +     ret = pcie_capability_read_word(pdev, PCI_EXP_LNKCTL,
> > > +                     &gli_host->linkctl_saved);
> > > +     if (ret)
> > > +             goto exit;
> > > +
> > > +     ret = pcie_capability_write_word(pdev, PCI_EXP_LNKCTL,
> > > +                     gli_host->linkctl_saved & ~PCI_EXP_LNKCTL_ASPMC);
> > > +     if (ret)
> > > +             goto exit;
> > > +
> > > +     ret = sdhci_pci_suspend_host(chip);
> > > +
> > > +exit:
> > > +     return ret;
> > > +}
> > > +
> > >  static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> > >  {
> > > +     int ret;
> > >       struct sdhci_pci_slot *slot = chip->slots[0];
> > > +     struct pci_dev *pdev = slot->chip->pdev;
> > > +     struct gli_host *gli_host = sdhci_pci_priv(slot);
> > >
> > > -     pci_free_irq_vectors(slot->chip->pdev);
> > > +     pci_free_irq_vectors(pdev);
> > >       gli_pcie_enable_msi(slot);
> > >
> > > -     return sdhci_pci_resume_host(chip);
> > > +     ret = sdhci_pci_resume_host(chip);
> > > +     if (ret)
> > > +             goto exit;
> > > +
> > > +     ret = pcie_capability_clear_and_set_word(pdev, PCI_EXP_LNKCTL,
> > > +                     PCI_EXP_LNKCTL_ASPMC, gli_host->linkctl_saved);
> > > +
> > > +exit:
> > > +     return ret;
> > >  }
> > >
> > >  static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
> > > @@ -834,7 +874,9 @@ const struct sdhci_pci_fixes sdhci_gl9750 = {
> > >       .probe_slot     = gli_probe_slot_gl9750,
> > >       .ops            = &sdhci_gl9750_ops,
> > >  #ifdef CONFIG_PM_SLEEP
> > > +     .suspend        = sdhci_pci_gli_suspend,
> > >       .resume         = sdhci_pci_gli_resume,
> > > +     .priv_size      = sizeof(struct gli_host),
> > >  #endif
> > >  };
> > >
> > > diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> > > index d0ed232af0eb..16187a265e63 100644
> > > --- a/drivers/mmc/host/sdhci-pci.h
> > > +++ b/drivers/mmc/host/sdhci-pci.h
> > > @@ -187,6 +187,7 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
> > >  }
> > >
> > >  #ifdef CONFIG_PM_SLEEP
> > > +int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip);
> > >  int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
> > >  #endif
> > >  int sdhci_pci_enable_dma(struct sdhci_host *host);
> > > --
> > > 2.30.0.284.gd98b1dd5eaa7-goog
> > >
