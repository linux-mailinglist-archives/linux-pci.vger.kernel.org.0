Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE47E5AA17C
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 23:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiIAV0h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 17:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiIAV0g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 17:26:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4DD6068C;
        Thu,  1 Sep 2022 14:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0029061F1A;
        Thu,  1 Sep 2022 21:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D05EC433D6;
        Thu,  1 Sep 2022 21:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662067593;
        bh=E2mJKyW8PqO/nC2/X3VJQ+jisG6dFyoOhEUWfH1bmYQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Rxf9MmKc3dWdLppkuTa+MdAPcc9+pVVoezXUhwahmInjDGMOqdSY2qY/5yjTlwNGk
         hIKZ2e7mb6HDxJdCE9OaeSPfHTXwGgtkTuz6KmZv+euVG59EOm9jmgXvjSp7/hSPqL
         KticgHs+JAmwPSasoU4iI8ysN9+OMNG/nRbDOyuZmK6smMgz1usr0Flm2U4B6J6dj0
         TkW6iVrcR1J9PhcBtQGD8Yo9gbrJCxgf2VU8ICcqlZD3sRXbUsVa9vl1sDfaUKHN6R
         OqggPlFR6LsW//nXRauyzRF/14aFFJo0O840RDYnKIkCPgg3GMngiZqNXeSWLnbXfB
         BuRS45s0QCbMg==
Date:   Thu, 1 Sep 2022 16:26:31 -0500
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
Message-ID: <20220901212631.GA250789@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jdFPauNKurpXFdCJBtsXavvLzV9fu02divz61hE_STbQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 31, 2022 at 07:53:05PM +0200, Rafael J. Wysocki wrote:
> ...

> In the meantime, I recalled that nvme wanted to leave the device in D0
> and program it into an internal low-power state in some cases which
> would be disturbed by disabling PTM later on (a config space write
> would kick the device out of the internal low-power state).
> 
> So it looks like it would be better to disable PTM as the first thing
> in pci_pm_suspend() before calling the driver's suspend callback
> (which may be nvme suspend), 

Yes, I was thinking the same thing.  There's no reason we need to wait
until interrupts are disabled to disable PTM.

> but then we'd need to save the original PTM status and restore it
> during the subsequent resume.  That could be done as early as in
> pci_pm_resume_noirq(), but I think the cleanest way would be to add
> a new bit to struct pci_device for that.

> Alternatively, we can drop the $subject patch, so ptm_enabled still
> only means that it has been enabled during enumeration and it can be
> used to restore the original PTM status during resume.

I like this second idea of dropping this "PCI/PTM: fix to maintain
pci_dev->ptm_enabled" patch and using "dev->ptm_enabled" to set the
PTM Enable bit on restore, as in the patches below.  Then we don't
need to do anything explicit to re-enable PTM.

If this makes sense, I'll add a few cleanups on top and post as a
formal series.

Bjorn


commit 73690aa361a7 ("PCI/PM: Always disable PTM for all devices during suspend")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Sep 1 16:14:45 2022 -0500

    PCI/PM: Always disable PTM for all devices during suspend
    
    We want to disable PTM on Root Ports because that allows some chips, e.g.,
    Intel mobile chips since Coffee Lake, to enter a lower-power PM state.
    
    That means we also have to disable PTM on downstream devices because PCIe
    r6.0, sec 2.2.8, strongly recommends that functions support generation of
    messages in non-D0 states, so we assume Switch Upstream Ports or Endpoints
    may send PTM Requests while in D1, D2, and D3hot.  A PTM message received
    by a Downstream Port (including a Root Port) with PTM disabled must be
    treated as an Unsupported Request (sec 6.21.3).
    
    PTM was previously disabled only for Root Ports, and it was disabled in
    pci_prepare_to_sleep(), which is not called at all if a driver supports
    legacy PM or does its own state saving.
    
    Instead, disable PTM early in pci_pm_suspend() and pci_pm_runtime_suspend()
    so we do it in all cases.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 2815922ac525..f07399a94807 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -772,6 +772,12 @@ static int pci_pm_suspend(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
+	/*
+	 * Disabling PTM allows some systems, e.g., Intel mobile chips
+	 * since Coffee Lake, to enter a lower-power PM state.
+	 */
+	pci_disable_ptm(pci_dev);
+
 	pci_dev->skip_bus_pm = false;
 
 	if (pci_has_legacy_pm_support(pci_dev))
@@ -1269,6 +1275,8 @@ static int pci_pm_runtime_suspend(struct device *dev)
 	pci_power_t prev = pci_dev->current_state;
 	int error;
 
+	pci_disable_ptm(pci_dev);
+
 	/*
 	 * If pci_dev->driver is not set (unbound), we leave the device in D0,
 	 * but it may go to D3cold when the bridge above it runtime suspends.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..b0e2968c8cca 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2706,16 +2706,6 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
 	if (target_state == PCI_POWER_ERROR)
 		return -EIO;
 
-	/*
-	 * There are systems (for example, Intel mobile chips since Coffee
-	 * Lake) where the power drawn while suspended can be significantly
-	 * reduced by disabling PTM on PCIe root ports as this allows the
-	 * port to enter a lower-power PM state and the SoC to reach a
-	 * lower-power idle state as a whole.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-		pci_disable_ptm(dev);
-
 	pci_enable_wake(dev, target_state, wakeup);
 
 	error = pci_set_power_state(dev, target_state);
@@ -2764,16 +2754,6 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
 	if (target_state == PCI_POWER_ERROR)
 		return -EIO;
 
-	/*
-	 * There are systems (for example, Intel mobile chips since Coffee
-	 * Lake) where the power drawn while suspended can be significantly
-	 * reduced by disabling PTM on PCIe root ports as this allows the
-	 * port to enter a lower-power PM state and the SoC to reach a
-	 * lower-power idle state as a whole.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-		pci_disable_ptm(dev);
-
 	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
 
 	error = pci_set_power_state(dev, target_state);

commit f84a7e954e37 ("PCI/PTM: Enable PTM when restoring state")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Sep 1 15:51:23 2022 -0500

    PCI/PTM: Enable PTM when restoring state
    
    The suspend path may disable PTM before saving config state, which means
    the PCI_PTM_CTRL_ENABLE bit in the saved state may be cleared even though
    we want PTM to be enabled when resuming.
    
    If "dev->ptm_enabled" is set, it means PTM should be enabled, so make sure
    PCI_PTM_CTRL_ENABLE is set when restoring the PTM state.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index b6a417247ce3..3115601a85ef 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -82,6 +82,14 @@ void pci_restore_ptm_state(struct pci_dev *dev)
 		return;
 
 	cap = (u16 *)&save_state->cap.data[0];
+
+	/*
+	 * The suspend path may disable PTM before saving config state.
+	 * Make sure PCI_PTM_CTRL_ENABLE is set if PTM should be enabled.
+	 */
+	if (dev->ptm_enabled)
+		*cap |= PCI_PTM_CTRL_ENABLE;
+
 	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
 }
 

commit 1d7d32a35df0 ("PCI/PTM: Preserve PTM Root Select")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu Sep 1 15:54:15 2022 -0500

    PCI/PTM: Preserve PTM Root Select
    
    When disabling PTM, there's no need to clear the Root Select bit.  We
    disable PTM during suspend, and we want to re-enable it during resume.
    Clearing Root Select here makes re-enabling more complicated.
    
    Per PCIe r6.0, sec 7.9.15.3, "When set, if the PTM Enable bit is also Set,
    this Time Source is the PTM Root," so if PTM Enable is cleared, the value
    of Root Select should be irrelevant.
    
    Preserve Root Select to simplify re-enabling PTM.
    
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: David E. Box <david.e.box@linux.intel.com>

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 368a254e3124..b6a417247ce3 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -42,7 +42,7 @@ void pci_disable_ptm(struct pci_dev *dev)
 		return;
 
 	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
-	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
+	ctrl &= ~PCI_PTM_CTRL_ENABLE;
 	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
 }
 
