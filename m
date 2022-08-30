Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F775A6DB9
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 21:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiH3Tqo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 15:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiH3Tqn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 15:46:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3660412A88;
        Tue, 30 Aug 2022 12:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6F53B81D94;
        Tue, 30 Aug 2022 19:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC87C433D6;
        Tue, 30 Aug 2022 19:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661888799;
        bh=2iej/NrvEH9C0b/djxI7NXpFu8DvkbovX2F/5tUXV/E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UdoGBJL1xdtyQmWjK09RxQs0YM9aFlNj5xiPEnavVS8y0Y+QhmaE2owrDDV8vtMNY
         iuZVWOINhB830oL/UUuY7GFOjh8oR52dJZTqIkev66k2X86MLRaGX0V1tjH6mmwl9n
         QXKG9reyDqahPjaAWj8Wrye3khFqDP4gqg86tKBZeU35L/bH6H9lOFcYB1dZZok08/
         jSJWDapOvFuWTWqGYg6oTi+yU9fZdGDX5DGk6QUOtLBKal4IZUuqDh8Q5Nj8A16UIu
         BSGvZtpm2CAnejdOGBdMYKuQn4NoWC4vvmm7o5IfVGkTbPVXNs24Rs29stlCTOvW7j
         XRi2xHmEdXDdQ==
Date:   Tue, 30 Aug 2022 14:46:37 -0500
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
Message-ID: <20220830194637.GA118760@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iHckqia4OywKzSNWFCaq7eOkJcm5yXJdT2_sNdd36gDw@mail.gmail.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 30, 2022 at 08:03:41PM +0200, Rafael J. Wysocki wrote:
> On Tue, Aug 30, 2022 at 7:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Aug 30, 2022 at 06:58:20PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Aug 30, 2022 at 6:25 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Tue, Aug 30, 2022 at 03:49:13AM -0700, Rajvi Jingar wrote:
> > > > > pci_dev->ptm_enabled needs to be maintained to reflect the current PTM
> > > > > state of the device. In pci_ptm_disable(), clear ptm_enabled from
> > > > > 'struct pci_dev' on disabling PTM state for the device.
> > > > > In pci_restore_ptm_state(), set dev->ptm_enabled based on the restored
> > > > > PTM state of the device.
> > > > >
> > > > > In pci_ptm_disable(), perform ptm_enabled check to avoid config space
> > > > > access in case if PTM is already disabled for the device. ptm_enabled
> > > > > won't be set for non-PCIe devices so pci_is_pcie(dev) check is not
> > > > > needed anymore.
> > > >
> > > > This one sounds like it's supposed to fix something, but I'm not clear
> > > > exactly what.
> > > >
> > > > I have a vague memory of config accesses messing up a low power state.
> > > > But this is still completely magical and unmaintainable since AFAIK
> > > > there is nothing in the PCIe spec about avoiding config accesses when
> > > > PTM is disabled.
> >
> > I'm remembering this, which seemed like an ancestor of this patch:
> > https://lore.kernel.org/r/CAJZ5v0gNy6YJA+RNTEyHBdoJK-jqKN60oU_k_LX4=cTuyoO2mg@mail.gmail.com
> >
> > This patch is queued up and does something similar (disabling PTM on
> > all devices before suspend):
> > https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=d878400c7d98
> >
> > Is d878400c7d98 enough to solve the functional issue, and this patch
> > is basically a cleanup?  I think it's a nice cleanup and worth doing.
> 
> This patch is independent of d878400c7d98.  We've been working on a
> d878400c7d98 counterpart on top of this patch.
> 
> There is a problem with d878400c7d98 that disabling PTM from
> pci_prepare_to_sleep() is not enough, because that function is not
> called for some endpoints where we also want to disable PTM on system
> suspend.
> 
> IMV the most suitable place to disable PTM (temporarily) on
> system-wide suspend is in pci_pm_suspend_noirq(, because it is the
> last piece of generic PCI code running for all PCI devices regardless
> of what their drivers do.
>
> > I'm just trying to figure out the "avoid config space access" in the
> > commit log.  If avoiding config space access is necessary, it needs
> > more explanation.

AFAICT, these are great cleanups but neither of these patches is
really a functional change.  If that's true, the "avoid config space
access" should be removed from the commit log.

I dropped d878400c7d98 for now and updated my pci/pm branch with just
these two patches with updates as attached below.

Then we can rework d878400c7d98 so it disables PTM unconditionally in
pci_pm_suspend_noirq() instead of in pci_prepare_to_sleep().

Currently, or with d878400c7d98, we only call pci_prepare_to_sleep()
when (!skip_bus_pm && !state_saved && pci_power_manageable()), so if a
driver saves its own state, we won't disable PTM, which seems like a
problem.

I assume we also want to move the pci_disable_ptm() from
pci_finish_runtime_suspend() to pci_pm_runtime_suspend() to keep it
parallel with pci_pm_suspend_noirq().

Is this making sense?

> > > Because ptm_enabled is expected to always reflect the hardware state,
> > > pci_disable_ptm() needs to be amended to clear it.  Also it is prudent
> > > to explicitly make it reflect the new hardware state in
> > > pci_restore_ptm_state().
> > >
> > > Then, pci_disable_ptm() can be made bail out if ptm_enabled is clear,
> > > because it has nothing to do then and the pci_is_pcie() check in there
> > > is not necessary, because ptm_enabled will never be set for devices
> > > that are not PCIe.
> > >
> > > > At the very least, we would need more details in the commit log and
> > > > a hint in the code about this.

commit 22b07d9ddd02 ("PCI/PTM: Update pdev->ptm_enabled to track hardware state")
Author: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Date:   Tue Aug 30 03:49:13 2022 -0700

    PCI/PTM: Update pdev->ptm_enabled to track hardware state
    
    Update pdev->ptm_enabled to track hardware state when we disable or restore
    PTM state.
    
    No functional change intended, since 'ptm_enabled' was previously only
    tested during enumeration and pci_disable_ptm() is only used during
    suspend.
    
    [bhelgaas: commit log]
    Link: https://lore.kernel.org/r/20220830104913.1620539-2-rajvi.jingar@linux.intel.com
    Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 368a254e3124..1ce241d4538f 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -34,7 +34,7 @@ void pci_disable_ptm(struct pci_dev *dev)
 	int ptm;
 	u16 ctrl;
 
-	if (!pci_is_pcie(dev))
+	if (!dev->ptm_enabled)
 		return;
 
 	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
@@ -44,6 +44,7 @@ void pci_disable_ptm(struct pci_dev *dev)
 	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
 	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
 	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
+	dev->ptm_enabled = 0;
 }
 
 void pci_save_ptm_state(struct pci_dev *dev)
@@ -83,6 +84,7 @@ void pci_restore_ptm_state(struct pci_dev *dev)
 
 	cap = (u16 *)&save_state->cap.data[0];
 	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
+	dev->ptm_enabled = !!(*cap & PCI_PTM_CTRL_ENABLE);
 }
 
 void pci_ptm_init(struct pci_dev *dev)

commit 6e594f65471b ("PCI/PM: Simplify pci_pm_suspend_noirq()")
Author: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Date:   Tue Aug 30 03:49:12 2022 -0700

    PCI/PM: Simplify pci_pm_suspend_noirq()
    
    We always want to save the device state unless the driver has already done
    it.  Rearrange the checking in pci_pm_suspend_noirq() to make this more
    clear.  No functional change intended.
    
    [bhelgaas: commit log, rewrap comment]
    Link: https://lore.kernel.org/r/20220830104913.1620539-1-rajvi.jingar@linux.intel.com
    Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 49238ddd39ee..2815922ac525 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -867,20 +867,15 @@ static int pci_pm_suspend_noirq(struct device *dev)
 		}
 	}
 
-	if (pci_dev->skip_bus_pm) {
+	if (!pci_dev->state_saved) {
+		pci_save_state(pci_dev);
+
 		/*
-		 * Either the device is a bridge with a child in D0 below it, or
-		 * the function is running for the second time in a row without
-		 * going through full resume, which is possible only during
-		 * suspend-to-idle in a spurious wakeup case.  The device should
-		 * be in D0 at this point, but if it is a bridge, it may be
-		 * necessary to save its state.
+		 * If the device is a bridge with a child in D0 below it,
+		 * it needs to stay in D0, so check skip_bus_pm to avoid
+		 * putting it into a low-power state in that case.
 		 */
-		if (!pci_dev->state_saved)
-			pci_save_state(pci_dev);
-	} else if (!pci_dev->state_saved) {
-		pci_save_state(pci_dev);
-		if (pci_power_manageable(pci_dev))
+		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
 			pci_prepare_to_sleep(pci_dev);
 	}
 
