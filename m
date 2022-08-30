Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FB95A6BAD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 20:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiH3SEH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 14:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiH3SDy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 14:03:54 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E74D11C2C;
        Tue, 30 Aug 2022 11:03:53 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3321c2a8d4cso286406447b3.5;
        Tue, 30 Aug 2022 11:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hV3AGddn06sxt4caikAmHiPA4bN2Ao0tbE5Dqa+wW0E=;
        b=irNhI4Te29UCVvYzgQ5fruwaeGqqJgjp9Sx83vjWmk5iirjwKBsLximmWHbUvbq7P3
         f/gSTdrOEMjhORKNTdy1fJFpAZSgs6X7jMhE3S2SAJmF/MZ9RFGwA9uAxe079i2+5BI/
         iJ+H2HtMhCNySJZxOwHeAzu4G+oIh+Q79IxVedAtmsLoprCMbbJD9TgYuFIUnSyj4pPf
         9Fj4u9+lHb3SyO/GDGeUoj6dwW0FHobaVBLexK9j5Q7/+ODpdnICCiqoyUsPOJsJZuqp
         VsFbCoDx1s4D3zGbnLPfzMAbQUbSUQmNXogD3syO8eHZPgX6KaIFA2PIE0h4U3jVFAu8
         AKZQ==
X-Gm-Message-State: ACgBeo1v3RcbispnmvBTUeY+ZnKL63sZhMXvCMn/+F7Jr/2H5zMPYJE4
        0wp6YxU4Bcp8/25+QcYhLth0Cn9pP1WA5ML/cks=
X-Google-Smtp-Source: AA6agR6JtWnMBLuVBL0N1uHwD/zxtbziKQ4N71wZSDieIyyjzEOuAm64yeA00ZhyZtn/7wAClG7NECKHO7qYEPDAb8A=
X-Received: by 2002:a0d:df92:0:b0:340:b90d:fb75 with SMTP id
 i140-20020a0ddf92000000b00340b90dfb75mr13844627ywe.149.1661882632474; Tue, 30
 Aug 2022 11:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0jL812FKOJsmijE7gx5GEYp0hQ9+3UtQ_WUr-Uf5pgxAg@mail.gmail.com>
 <20220830173723.GA109210@bhelgaas>
In-Reply-To: <20220830173723.GA109210@bhelgaas>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Aug 2022 20:03:41 +0200
Message-ID: <CAJZ5v0iHckqia4OywKzSNWFCaq7eOkJcm5yXJdT2_sNdd36gDw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/2] PCI/PTM: fix to maintain pci_dev->ptm_enabled
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
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

On Tue, Aug 30, 2022 at 7:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Aug 30, 2022 at 06:58:20PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Aug 30, 2022 at 6:25 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Aug 30, 2022 at 03:49:13AM -0700, Rajvi Jingar wrote:
> > > > pci_dev->ptm_enabled needs to be maintained to reflect the current PTM
> > > > state of the device. In pci_ptm_disable(), clear ptm_enabled from
> > > > 'struct pci_dev' on disabling PTM state for the device.
> > > > In pci_restore_ptm_state(), set dev->ptm_enabled based on the restored
> > > > PTM state of the device.
> > > >
> > > > In pci_ptm_disable(), perform ptm_enabled check to avoid config space
> > > > access in case if PTM is already disabled for the device. ptm_enabled
> > > > won't be set for non-PCIe devices so pci_is_pcie(dev) check is not
> > > > needed anymore.
> > >
> > > This one sounds like it's supposed to fix something, but I'm not clear
> > > exactly what.
> > >
> > > I have a vague memory of config accesses messing up a low power state.
> > > But this is still completely magical and unmaintainable since AFAIK
> > > there is nothing in the PCIe spec about avoiding config accesses when
> > > PTM is disabled.
>
> I'm remembering this, which seemed like an ancestor of this patch:
> https://lore.kernel.org/r/CAJZ5v0gNy6YJA+RNTEyHBdoJK-jqKN60oU_k_LX4=cTuyoO2mg@mail.gmail.com
>
> This patch is queued up and does something similar (disabling PTM on
> all devices before suspend):
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=d878400c7d98
>
> Is d878400c7d98 enough to solve the functional issue, and this patch
> is basically a cleanup?  I think it's a nice cleanup and worth doing.

This patch is independent of d878400c7d98.  We've been working on a
d878400c7d98 counterpart on top of this patch.

There is a problem with d878400c7d98 that disabling PTM from
pci_prepare_to_sleep() is not enough, because that function is not
called for some endpoints where we also want to disable PTM on system
suspend.

IMV the most suitable place to disable PTM (temporarily) on
system-wide suspend is in pci_pm_suspend_noirq(, because it is the
last piece of generic PCI code running for all PCI devices regardless
of what their drivers do.

> I'm just trying to figure out the "avoid config space access" in the
> commit log.  If avoiding config space access is necessary, it needs
> more explanation.
>
> > Because ptm_enabled is expected to always reflect the hardware state,
> > pci_disable_ptm() needs to be amended to clear it.  Also it is prudent
> > to explicitly make it reflect the new hardware state in
> > pci_restore_ptm_state().
> >
> > Then, pci_disable_ptm() can be made bail out if ptm_enabled is clear,
> > because it has nothing to do then and the pci_is_pcie() check in there
> > is not necessary, because ptm_enabled will never be set for devices
> > that are not PCIe.
> >
> > > At the very least, we would need more details in the commit log and
> > > a hint in the code about this.
> > >
> > > > Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> > > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  v1->v2:
> > > >    - add ptm_enabled check in pci_ptm_disable().
> > > >    - set the dev->ptm_enabled value in pci_restore_ptm_state().
> > > >  v2->v3:
> > > >    - remove pci_is_pcie(dev) check in pci_ptm_disable().
> > > >    - add Reviewed-by tag in commit message
> > > > ---
> > > >  drivers/pci/pcie/ptm.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > > > index 368a254e3124..1ce241d4538f 100644
> > > > --- a/drivers/pci/pcie/ptm.c
> > > > +++ b/drivers/pci/pcie/ptm.c
> > > > @@ -34,7 +34,7 @@ void pci_disable_ptm(struct pci_dev *dev)
> > > >       int ptm;
> > > >       u16 ctrl;
> > > >
> > > > -     if (!pci_is_pcie(dev))
> > > > +     if (!dev->ptm_enabled)
> > > >               return;
> > >
> > > This will conflict with a change Kai-Heng Feng and I have been working
> > > on, but I can resolve it when applying.
> > >
> > > >       ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> > > > @@ -44,6 +44,7 @@ void pci_disable_ptm(struct pci_dev *dev)
> > > >       pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
> > > >       ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
> > > >       pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
> > > > +     dev->ptm_enabled = 0;
> > > >  }
> > > >
> > > >  void pci_save_ptm_state(struct pci_dev *dev)
> > > > @@ -83,6 +84,7 @@ void pci_restore_ptm_state(struct pci_dev *dev)
> > > >
> > > >       cap = (u16 *)&save_state->cap.data[0];
> > > >       pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
> > > > +     dev->ptm_enabled = !!(*cap & PCI_PTM_CTRL_ENABLE);
> > > >  }
> > > >
> > > >  void pci_ptm_init(struct pci_dev *dev)
> > > > --
> > > > 2.25.1
> > > >
