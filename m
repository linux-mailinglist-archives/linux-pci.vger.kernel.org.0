Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE665A6B00
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 19:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiH3RmB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 13:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiH3Rln (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 13:41:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B20F43A2;
        Tue, 30 Aug 2022 10:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AFAA6117D;
        Tue, 30 Aug 2022 17:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EAEC433C1;
        Tue, 30 Aug 2022 17:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661881045;
        bh=hZvLlOnL6yvpi8MoLMu1NOUQlpnm115KJD6h3xz3kYQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K9lvo23yx93EcY9vHb7bwHgIC1VWsQ1EfJtvY2xWks3CAQDqBrhAEi+UOtHb3xn5i
         0/hNGs2TzLP0LldhEpmvmtp+k74bfSWG0oaAgBdWac4jgeLeZdARcZyG+WMu/EVMG4
         Nw5a1KGDnV4w8cQVp+MJGCSsNbS1UaSPbBcd5R84a6ieI7FYOIqOxoKUDj5aiR29nw
         2/aVMtftL5wE1I9Ku3C23J893RZABS6LQb9Cn4aX28M62Rb3Da4R1zr8hiQjm26BpL
         ajOzoClqNa/bIMKBLPVzGpcHiQbEYVhe1J7EMD16G4NsQi1/aCv2AxoCPV6gndEcqk
         2ZavPaEXNINmA==
Date:   Tue, 30 Aug 2022 12:37:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [RESEND PATCH v3 2/2] PCI/PTM: fix to maintain
 pci_dev->ptm_enabled
Message-ID: <20220830173723.GA109210@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jL812FKOJsmijE7gx5GEYp0hQ9+3UtQ_WUr-Uf5pgxAg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 30, 2022 at 06:58:20PM +0200, Rafael J. Wysocki wrote:
> On Tue, Aug 30, 2022 at 6:25 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Aug 30, 2022 at 03:49:13AM -0700, Rajvi Jingar wrote:
> > > pci_dev->ptm_enabled needs to be maintained to reflect the current PTM
> > > state of the device. In pci_ptm_disable(), clear ptm_enabled from
> > > 'struct pci_dev' on disabling PTM state for the device.
> > > In pci_restore_ptm_state(), set dev->ptm_enabled based on the restored
> > > PTM state of the device.
> > >
> > > In pci_ptm_disable(), perform ptm_enabled check to avoid config space
> > > access in case if PTM is already disabled for the device. ptm_enabled
> > > won't be set for non-PCIe devices so pci_is_pcie(dev) check is not
> > > needed anymore.
> >
> > This one sounds like it's supposed to fix something, but I'm not clear
> > exactly what.
> >
> > I have a vague memory of config accesses messing up a low power state.
> > But this is still completely magical and unmaintainable since AFAIK
> > there is nothing in the PCIe spec about avoiding config accesses when
> > PTM is disabled.

I'm remembering this, which seemed like an ancestor of this patch:
https://lore.kernel.org/r/CAJZ5v0gNy6YJA+RNTEyHBdoJK-jqKN60oU_k_LX4=cTuyoO2mg@mail.gmail.com

This patch is queued up and does something similar (disabling PTM on
all devices before suspend):
https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=d878400c7d98

Is d878400c7d98 enough to solve the functional issue, and this patch
is basically a cleanup?  I think it's a nice cleanup and worth doing.

I'm just trying to figure out the "avoid config space access" in the
commit log.  If avoiding config space access is necessary, it needs
more explanation.

> Because ptm_enabled is expected to always reflect the hardware state,
> pci_disable_ptm() needs to be amended to clear it.  Also it is prudent
> to explicitly make it reflect the new hardware state in
> pci_restore_ptm_state().
>
> Then, pci_disable_ptm() can be made bail out if ptm_enabled is clear,
> because it has nothing to do then and the pci_is_pcie() check in there
> is not necessary, because ptm_enabled will never be set for devices
> that are not PCIe.
>
> > At the very least, we would need more details in the commit log and
> > a hint in the code about this.
> >
> > > Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  v1->v2:
> > >    - add ptm_enabled check in pci_ptm_disable().
> > >    - set the dev->ptm_enabled value in pci_restore_ptm_state().
> > >  v2->v3:
> > >    - remove pci_is_pcie(dev) check in pci_ptm_disable().
> > >    - add Reviewed-by tag in commit message
> > > ---
> > >  drivers/pci/pcie/ptm.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> > > index 368a254e3124..1ce241d4538f 100644
> > > --- a/drivers/pci/pcie/ptm.c
> > > +++ b/drivers/pci/pcie/ptm.c
> > > @@ -34,7 +34,7 @@ void pci_disable_ptm(struct pci_dev *dev)
> > >       int ptm;
> > >       u16 ctrl;
> > >
> > > -     if (!pci_is_pcie(dev))
> > > +     if (!dev->ptm_enabled)
> > >               return;
> >
> > This will conflict with a change Kai-Heng Feng and I have been working
> > on, but I can resolve it when applying.
> >
> > >       ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> > > @@ -44,6 +44,7 @@ void pci_disable_ptm(struct pci_dev *dev)
> > >       pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
> > >       ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
> > >       pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
> > > +     dev->ptm_enabled = 0;
> > >  }
> > >
> > >  void pci_save_ptm_state(struct pci_dev *dev)
> > > @@ -83,6 +84,7 @@ void pci_restore_ptm_state(struct pci_dev *dev)
> > >
> > >       cap = (u16 *)&save_state->cap.data[0];
> > >       pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
> > > +     dev->ptm_enabled = !!(*cap & PCI_PTM_CTRL_ENABLE);
> > >  }
> > >
> > >  void pci_ptm_init(struct pci_dev *dev)
> > > --
> > > 2.25.1
> > >
