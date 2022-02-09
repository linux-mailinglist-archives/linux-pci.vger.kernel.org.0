Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C7B4AEBC7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 09:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240582AbiBIIEP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 03:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240316AbiBIIEO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 03:04:14 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8A7C0613CA
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 00:04:17 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id t7so2223184ljc.10
        for <linux-pci@vger.kernel.org>; Wed, 09 Feb 2022 00:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K1MsuIgrrAg3LNE0V6fbiqjs3bV9NWGwzY5Aonrg81U=;
        b=IwaHCGd/V8Mjbnk72/2SkHE8ar8dCfRhS0xgxIiJ8QrHoPToadi26WDLoejq0wh/o/
         8SrC/SZVuxqz6g5jIdaK2WXHO9h1+wLbETIj6i2HPutEllmCOdyCti7jLEVbZocLqEN/
         ZpBkVOl5Fgz4TGImzz2vIADaBfwcB15ER6XK18EikBiO+fdw+i/kONB5C5TD3tX4IrWw
         wmz+FoNBCE8MeOii5o5XvIApDtbLH4YicbnsZBNPGvgyvpGyxi4TM74XbQHS8nO24Vp0
         ONXnh0CEoCTd/7810TGMA4anK1PZxMvmb6Y/2qsOvx3B9es6S7YWTntC79NJQnxqebnR
         gapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1MsuIgrrAg3LNE0V6fbiqjs3bV9NWGwzY5Aonrg81U=;
        b=ODoAMdOamtlT2buzF5Oiw/Uwj//3QVO9TyPZmagAM7nKvqxJCYN5MnNKHOwUaXm5pW
         UsM0HUyT0rtBy8uRjVzU9xNS/SpEDCrZXzYTTjJxc1rPPhELM0lIMYklzpkfDbVkP9wd
         LZ7QZFXH8HpWF1IDM80t+72H+umcy6VxxwSiHWwcnzZxvhuOVKSwip2fAFCH5IZx7aRc
         ZBVYY5A+0a9XAkOPHKt7+Iq3333lzAtZsPdfIzNxmz02VXqvP3/lWkiIa4v350kDg6Dv
         8MPecJ+HwBvODM6sKvQbPSfcKXcOBlgydkFxvuC52BY+WNNGUs8J/YPo+gPDdM2G6WWZ
         FYSw==
X-Gm-Message-State: AOAM532nVG8/E+bpGOK8AmZIoF/Nzo4w1Kn30CCSzz6eol4BNyyJ2h8l
        Q5931cOk9bOJO5vmU1gsNUOVTEAP6Ox6n/X6ZFNHJg==
X-Google-Smtp-Source: ABdhPJwwmzKlhIT5IWwD+nLmxoK4wJ2DVK1wzanfirYrk7MlcyjRdDesAESEZ2zF8F1Z9yKHHqKSKbrrtkIhIFXOLjs=
X-Received: by 2002:a2e:b74c:: with SMTP id k12mr786392ljo.312.1644393855093;
 Wed, 09 Feb 2022 00:04:15 -0800 (PST)
MIME-Version: 1.0
References: <20210311173433.GA2071075@bjorn-Precision-5520> <20210726220307.GA647936@bjorn-Precision-5520>
In-Reply-To: <20210726220307.GA647936@bjorn-Precision-5520>
From:   Victor Ding <victording@google.com>
Date:   Wed, 9 Feb 2022 19:03:37 +1100
Message-ID: <CANqTbdb_h_W+8kmh6s56deA8VKn6tO1KDJaS5Yasq5RFLtGUbQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/ASPM: Disable ASPM when save/restore PCI state
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I sincerely apologize that I missed your two emails last year. Please find my
comments embedded below.

On Tue, Jul 27, 2021 at 8:03 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Mar 11, 2021 at 11:34:33AM -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 28, 2021 at 03:52:42PM +0000, Victor Ding wrote:
> > > Certain PCIe devices (e.g. GL9750) have high penalties (e.g. high Port
> > > T_POWER_ON) when exiting L1 but enter L1 aggressively. As a result,
> > > such devices enter and exit L1 frequently during pci_save_state and
> > > pci_restore_state; eventually causing poor suspend/resume performance.
> > >
> > > Based on the observation that PCI accesses dominance pci_save_state/
> > > pci_restore_state plus these accesses are fairly close to each other, the
> > > actual time the device could stay in low power states is negligible.
> > > Therefore, the little power-saving benefit from ASPM during suspend/resume
> > > does not overweight the performance degradation caused by high L1 exit
> > > penalties.
> > >
> > > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211187
> >
> > Thanks for this!
> >
> > This device can tolerate unlimited delay for L1 exit (DevCtl Endpoint
> > L1 Acceptable Latency is unlimited) and it makes no guarantees about
> > how fast it can exit L1 (LnkCap L1 Exit Latency is also unlimited), so
> > I think there's basically no restriction on when it can enter ASPM
> > L1.0.
> >
> > I have a hard time interpreting the L1.2 entry conditions in PCIe
> > r5.0, sec 5.5.1, but I can believe it enters L1.2 aggressively since
> > the device says it can tolerate any latencies.
> >
> > If L1.2 exit takes 3100us, it could do ~60 L1 exits in 200ms.  I guess
> > config accesses and code execution can account for some of that, but
> > still seems like a lot of L1 entries/exits during suspend.  I wouldn't
> > think we would touch the device that much and that intermittently.
> >
> > > Signed-off-by: Victor Ding <victording@google.com>
> > >
> > > ---
> > >
> > > Changes in v2:
> > > - Updated commit message to remove unnecessary information
> > > - Fixed a bug reading wrong register in pcie_save_aspm_control
> > > - Updated to reuse existing pcie_config_aspm_dev where possible
> > > - Fixed goto label style
> > >
> > >  drivers/pci/pci.c       | 18 +++++++++++++++---
> > >  drivers/pci/pci.h       |  6 ++++++
> > >  drivers/pci/pcie/aspm.c | 27 +++++++++++++++++++++++++++
> > >  include/linux/pci.h     |  1 +
> > >  4 files changed, 49 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 32011b7b4c04..9ea88953f90b 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -1542,6 +1542,10 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
> > >  int pci_save_state(struct pci_dev *dev)
> > >  {
> > >     int i;
> > > +
> > > +   pcie_save_aspm_control(dev);
> > > +   pcie_disable_aspm(dev);
> >
> > If I understand this patch correctly, it basically does this:
> >
> >     pci_save_state
> >   +   pcie_save_aspm_control
> >   +   pcie_disable_aspm
> >       <save state>
> >   +   pcie_restore_aspm_control
> >
> > The <save state> part is just a bunch of config reads with very little
> > other code execution.  I'm really surprised that there's enough time
> > between config reads for the link to go to L1.  I guess you've
> > verified that this does speed up suspend significantly, but this just
> > doesn't make sense to me.
> >
> > In the bugzilla you say the GL9750 can go to L1.2 after ~4us of
> > inactivity.  That's enough time for a lot of code execution.  We must
> > be missing something.  There's so much PCI traffic during save/restore
> > that it should be easy to match up the analyzer trace with the code.
> > Can you get any insight into what's going on that way?

Unfortunately I did not and still do not have access to the required analyzers.
However, I received an analyzer trace screenshot confirming GL9750 indeed
went idle for ~4.2us. (I've attached it to the bugzilla).

I agree that 4us is more than sufficient for a lot of code execution, especially
these PCI config space accesses for the same device appear to be fairly
close to each other. However, as device resumes occur in parallel and a
global mutex is required for each access, these PCI config space accesses
from multiple devices are serialized arbitrarily causing accesses from the
same device far apart from each other.

The hypothesis came from my observation that PCI config space accesses
from different devices in the slow runs were always interleaved, while they
were mostly grouped together in the fast runs. To further prove the hypothesis,
I added a global lock when save/restore PCI state, forcing the related PCI
config space accesses from the same device grouped together, I always got
fast runs.

>
> I'm dropping this for now, pending a better understanding of what's
> going on.
>
> > >     /* XXX: 100% dword access ok here? */
> > >     for (i = 0; i < 16; i++) {
> > >             pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
> > > @@ -1552,18 +1556,22 @@ int pci_save_state(struct pci_dev *dev)
> > >
> > >     i = pci_save_pcie_state(dev);
> > >     if (i != 0)
> > > -           return i;
> > > +           goto exit;
> > >
> > >     i = pci_save_pcix_state(dev);
> > >     if (i != 0)
> > > -           return i;
> > > +           goto exit;
> > >
> > >     pci_save_ltr_state(dev);
> > >     pci_save_aspm_l1ss_state(dev);
> > >     pci_save_dpc_state(dev);
> > >     pci_save_aer_state(dev);
> > >     pci_save_ptm_state(dev);
> > > -   return pci_save_vc_state(dev);
> > > +   i = pci_save_vc_state(dev);
> > > +
> > > +exit:
> > > +   pcie_restore_aspm_control(dev);
> > > +   return i;
> > >  }
> > >  EXPORT_SYMBOL(pci_save_state);
> > >
> > > @@ -1661,6 +1669,8 @@ void pci_restore_state(struct pci_dev *dev)
> > >     if (!dev->state_saved)
> > >             return;
> > >
> > > +   pcie_disable_aspm(dev);
> > > +
> > >     /*
> > >      * Restore max latencies (in the LTR capability) before enabling
> > >      * LTR itself (in the PCIe capability).
> > > @@ -1689,6 +1699,8 @@ void pci_restore_state(struct pci_dev *dev)
> > >     pci_enable_acs(dev);
> > >     pci_restore_iov_state(dev);
> > >
> > > +   pcie_restore_aspm_control(dev);
> > > +
> > >     dev->state_saved = false;
> > >  }
> > >  EXPORT_SYMBOL(pci_restore_state);
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index a81459159f6d..e074a0cbe73c 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -584,6 +584,9 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev);
> > >  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> > >  void pci_save_aspm_l1ss_state(struct pci_dev *dev);
> > >  void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
> > > +void pcie_save_aspm_control(struct pci_dev *dev);
> > > +void pcie_restore_aspm_control(struct pci_dev *dev);
> > > +void pcie_disable_aspm(struct pci_dev *pdev);
> > >  #else
> > >  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
> > >  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> > > @@ -591,6 +594,9 @@ static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
> > >  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> > >  static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
> > >  static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
> > > +static inline void pcie_save_aspm_control(struct pci_dev *dev) { }
> > > +static inline void pcie_restore_aspm_control(struct pci_dev *dev) { }
> > > +static inline void pcie_disable_aspm(struct pci_dev *pdev) { }
> > >  #endif
> > >
> > >  #ifdef CONFIG_PCIE_ECRC
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index a08e7d6dc248..e1e97db32e8b 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -784,6 +784,33 @@ static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
> > >                                        PCI_EXP_LNKCTL_ASPMC, val);
> > >  }
> > >
> > > +void pcie_disable_aspm(struct pci_dev *pdev)
> > > +{
> > > +   if (!pci_is_pcie(pdev))
> > > +           return;
> > > +
> > > +   pcie_config_aspm_dev(pdev, 0);
> > > +}
> > > +
> > > +void pcie_save_aspm_control(struct pci_dev *pdev)
> > > +{
> > > +   u16 lnkctl;
> > > +
> > > +   if (!pci_is_pcie(pdev))
> > > +           return;
> > > +
> > > +   pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnkctl);
> > > +   pdev->saved_aspm_ctl = lnkctl & PCI_EXP_LNKCTL_ASPMC;
> > > +}
> > > +
> > > +void pcie_restore_aspm_control(struct pci_dev *pdev)
> > > +{
> > > +   if (!pci_is_pcie(pdev))
> > > +           return;
> > > +
> > > +   pcie_config_aspm_dev(pdev, pdev->saved_aspm_ctl);
> > > +}
> > > +
> > >  static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
> > >  {
> > >     u32 upstream = 0, dwstream = 0;
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index b32126d26997..a21bfd6e3f89 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -387,6 +387,7 @@ struct pci_dev {
> > >     unsigned int    ltr_path:1;     /* Latency Tolerance Reporting
> > >                                        supported from root to here */
> > >     u16             l1ss;           /* L1SS Capability pointer */
> > > +   u16             saved_aspm_ctl; /* ASPM Control saved at suspend time */
> > >  #endif
> > >     unsigned int    eetlp_prefix_path:1;    /* End-to-End TLP Prefix */
> > >
> > > --
> > > 2.30.0.280.ga3ce27912f-goog
> > >
