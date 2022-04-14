Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EAE500F70
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 15:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbiDNN1U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 09:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244418AbiDNN0d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 09:26:33 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D8F9F3AB;
        Thu, 14 Apr 2022 06:19:59 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id fbd3e7ae4794ba45; Thu, 14 Apr 2022 15:19:58 +0200
Received: from kreacher.localnet (unknown [213.134.181.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 5E16366BE86;
        Thu, 14 Apr 2022 15:19:57 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 4/9] PCI/PM: Rework changing power states of PCI devices
Date:   Thu, 14 Apr 2022 15:11:21 +0200
Message-ID: <3687697.kQq0lBPeGt@kreacher>
In-Reply-To: <5838942.lOV4Wx5bFT@kreacher>
References: <4419002.LvFx2qVVIh@kreacher> <11975904.O9o76ZdvQC@kreacher> <5838942.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.181.101
X-CLIENT-HOSTNAME: 213.134.181.101
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudelfedgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudekuddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukedurddutddupdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
 ihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are some issues related to changing power states of PCI
devices, mostly related to carrying out unnecessary actions in some
places, and the code is generally hard to follow.

 1. pci_power_up() has two callers, pci_set_power_state() and
    pci_pm_default_resume_early().  The latter updates the current
    power state of the device right after calling pci_power_up()
    and it restores the entire config space of the device right
    after that, so pci_power_up() itself need not read the
    PCI_PM_CTRL register or restore the BARs after programming the
    device into D0 in that case.
 
 2. It is generally hard to get a clear view of the pci_power_up()
    code flow, especially in some corner cases, due to all of the
    involved PCI_PM_CTRL register reads and writes occurring in
    pci_platform_power_transition() and in pci_raw_set_power_state(),
    some of which are redundant.

 3. The transitions from low-power states to D0 and the other way
    around are unnecessarily tangled in pci_raw_set_power_state()
    which causes it to use a redundant local variable and makes it
    rather hard to follow.

To address the above shortcomings, make the following changes:

 a. Remove the code handling transitions into D0
    from pci_raw_set_power_state() and rename it as
    pci_set_low_power_state().

 b. Add the code handling transitions into D0 directly
    to pci_power_up() and to a new wrapper function
    pci_set_full_power_state() calling it internally that is
    only used in pci_set_power_state().

 c. Make pci_power_up() avoid redundant PCI_PM_CTRL register reads
    and make it work in the same way for transitions from any
    low-power states (transitions from D1 and D2 are handled
    slightly differently before the change).

 d. Put the restoration of the BARs and the PCI_PM_CTRL
    register read confirming the power state change into
    pci_set_full_power_state() to avoid doing that in
    pci_pm_default_resume_early() unnecessarily.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---

v2 -> v3:
   * Make pci_power_up() check dev->pm_cap.
   * Rephrase a comment in pci_power_up() (Mika).
   * Add kerneldoc comment to pci_set_full_power_state() (Mika).
   * Add R-by from Mika.

v1 -> v2:
   * Do not add a redundant check to pci_set_low_power_state().

---
 drivers/pci/pci.c |  175 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 122 insertions(+), 53 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1068,10 +1068,9 @@ static inline bool platform_pci_bridge_d
 }
 
 /**
- * pci_raw_set_power_state - Use PCI PM registers to set the power state of
- *			     given PCI device
+ * pci_set_low_power_state - Program the given device into a low-power state
  * @dev: PCI device to handle.
- * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
+ * @state: PCI power state (D1, D2, D3hot) to put the device into.
  *
  * RETURN VALUE:
  * -EINVAL if the requested state is invalid.
@@ -1080,10 +1079,9 @@ static inline bool platform_pci_bridge_d
  * 0 if device already is in the requested state.
  * 0 if device's power state has been successfully changed.
  */
-static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
+static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	u16 pmcsr;
-	bool need_restore = false;
 
 	/* Check if we're already there */
 	if (dev->current_state == state)
@@ -1092,7 +1090,7 @@ static int pci_raw_set_power_state(struc
 	if (!dev->pm_cap)
 		return -EIO;
 
-	if (state < PCI_D0 || state > PCI_D3hot)
+	if (state < PCI_D1 || state > PCI_D3hot)
 		return -EINVAL;
 
 	/*
@@ -1101,8 +1099,7 @@ static int pci_raw_set_power_state(struc
 	 * we can go from D1 to D3, but we can't go directly from D3 to D1;
 	 * we'd have to go from D3 to D0, then to D1.
 	 */
-	if (state != PCI_D0 && dev->current_state <= PCI_D3cold
-	    && dev->current_state > state) {
+	if (dev->current_state <= PCI_D3cold && dev->current_state > state) {
 		pci_err(dev, "invalid power transition (from %s to %s)\n",
 			pci_power_name(dev->current_state),
 			pci_power_name(state));
@@ -1122,29 +1119,8 @@ static int pci_raw_set_power_state(struc
 		return -EIO;
 	}
 
-	/*
-	 * If we're (effectively) in D3, force entire word to 0.
-	 * This doesn't affect PME_Status, disables PME_En, and
-	 * sets PowerState to 0.
-	 */
-	switch (dev->current_state) {
-	case PCI_D0:
-	case PCI_D1:
-	case PCI_D2:
-		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
-		pmcsr |= state;
-		break;
-	case PCI_D3hot:
-	case PCI_D3cold:
-	case PCI_UNKNOWN: /* Boot-up */
-		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
-		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
-			need_restore = true;
-		fallthrough;	/* force to D0 */
-	default:
-		pmcsr = 0;
-		break;
-	}
+	pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
+	pmcsr |= state;
 
 	/* Enter specified state */
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
@@ -1153,9 +1129,9 @@ static int pci_raw_set_power_state(struc
 	 * Mandatory power management transition delays; see PCI PM 1.1
 	 * 5.6.1 table 18
 	 */
-	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
+	if (state == PCI_D3hot)
 		pci_dev_d3_sleep(dev);
-	else if (state == PCI_D2 || dev->current_state == PCI_D2)
+	else if (state == PCI_D2)
 		udelay(PCI_PM_D2_DELAY);
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
@@ -1165,22 +1141,6 @@ static int pci_raw_set_power_state(struc
 			 pci_power_name(dev->current_state),
 			 pci_power_name(state));
 
-	/*
-	 * According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
-	 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
-	 * from D3hot to D0 _may_ perform an internal reset, thereby
-	 * going to "D0 Uninitialized" rather than "D0 Initialized".
-	 * For example, at least some versions of the 3c905B and the
-	 * 3c556B exhibit this behaviour.
-	 *
-	 * At least some laptop BIOSen (e.g. the Thinkpad T21) leave
-	 * devices in a D3hot state at boot.  Consequently, we need to
-	 * restore at least the BARs so that the device will be
-	 * accessible to its driver.
-	 */
-	if (need_restore)
-		pci_restore_bars(dev);
-
 	if (dev->bus->self)
 		pcie_aspm_pm_state_change(dev->bus->self);
 
@@ -1312,8 +1272,63 @@ static int pci_dev_wait(struct pci_dev *
  */
 int pci_power_up(struct pci_dev *dev)
 {
-	pci_platform_power_transition(dev, PCI_D0);
-	return pci_raw_set_power_state(dev, PCI_D0);
+	int ret;
+
+	ret = pci_platform_power_transition(dev, PCI_D0);
+	if (ret) {
+		u16 pmcsr;
+
+		/*
+		 * If native PM is not supported, pass the error returned by
+		 * pci_platform_power_transition() to the caller.
+		 */
+		if (!dev->pm_cap)
+			return ret;
+
+		/*
+		 * Since pci_platform_power_transition() has returned an error,
+		 * the PCI_PM_CTRL register has not been read by it and the
+		 * current power state of the device is unknown.  Read the
+		 * PCI_PM_CTRL register now and bail out if that fails.
+		 */
+		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+		if (PCI_POSSIBLE_ERROR(pmcsr)) {
+			dev->current_state = PCI_D3cold;
+			goto fail;
+		}
+		dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
+	} else if (dev->current_state == PCI_D3cold) {
+		/*
+		 * Since current_state is PCI_D3cold here, the power state seen
+		 * by the platform is still D3cold or the PCI_PM_CTRL register
+		 * read in pci_update_current_state() has failed, so assume the
+		 * device to be inaccessible.
+		 */
+		goto fail;
+	}
+
+	/* There's nothing more to do if current_state is D0 at this point. */
+	if (dev->current_state == PCI_D0)
+		return 0;
+
+	/*
+	 * Program the device into PCI_D0 by forcing the entire word to 0 (this
+	 * doesn't affect PME_Status, disables PME_En, and sets PowerState to 0)
+	 * and wait for the prescribed amount of time.  Assume success.
+	 */
+	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
+
+	if (dev->current_state == PCI_D3hot)
+		pci_dev_d3_sleep(dev);
+	else if (dev->current_state == PCI_D2)
+		udelay(PCI_PM_D2_DELAY);
+
+	dev->current_state = PCI_D0;
+	return 0;
+
+fail:
+	pci_err(dev, "Unable to change power state to D0, device inaccessible\n");
+	return -ENODEV;
 }
 
 /**
@@ -1341,6 +1356,60 @@ void pci_bus_set_current_state(struct pc
 }
 
 /**
+ * pci_set_full_power_state - Put a PCI device into D0 and update its state
+ * @dev: PCI device to power up
+ *
+ * Call pci_power_up() to put @dev into D0, read from its PCI_PM_CTRL register
+ * to confirm the state change, restore its BARs if they might be lost and
+ * reconfigure ASPM in acordance with the new power state.
+ *
+ * If pci_restore_state() is going to be called right after a power state change
+ * to D0, it is more efficient to use pci_power_up() directly instead of this
+ * function.
+ */
+static int pci_set_full_power_state(struct pci_dev *dev)
+{
+	pci_power_t old_state = dev->current_state;
+	u16 pmcsr;
+	int ret;
+
+	ret = pci_power_up(dev);
+	if (ret)
+		return ret;
+
+	if (!dev->pm_cap)
+		return 0;
+
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+
+	dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
+	if (dev->current_state != PCI_D0) {
+		pci_info_ratelimited(dev, "Refused to change power state from %s to D0\n",
+				     pci_power_name(dev->current_state));
+	} else if (old_state >= PCI_D3hot && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
+		/*
+		 * According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
+		 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
+		 * from D3hot to D0 _may_ perform an internal reset, thereby
+		 * going to "D0 Uninitialized" rather than "D0 Initialized". For
+		 * example, at least some versions of the 3c905B and the 3c556B
+		 * exhibit this behaviour.
+		 *
+		 * At least some laptop BIOSen (e.g. the Thinkpad T21) leave
+		 * devices in a D3hot state at boot. Consequently, we need to
+		 * restore at least the BARs so that the device will be
+		 * accessible to its driver.
+		 */
+		pci_restore_bars(dev);
+	}
+
+	if (dev->bus->self)
+		pcie_aspm_pm_state_change(dev->bus->self);
+
+	return 0;
+}
+
+/**
  * pci_set_power_state - Set the power state of a PCI device
  * @dev: PCI device to handle.
  * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
@@ -1381,7 +1450,7 @@ int pci_set_power_state(struct pci_dev *
 		return 0;
 
 	if (state == PCI_D0)
-		return pci_power_up(dev);
+		return pci_set_full_power_state(dev);
 
 	/*
 	 * This device is quirked not to be put into D3, so don't put it in
@@ -1394,7 +1463,7 @@ int pci_set_power_state(struct pci_dev *
 	 * To put device in D3cold, we put device into D3hot in native
 	 * way, then put device into D3cold with platform ops
 	 */
-	error = pci_raw_set_power_state(dev, state > PCI_D3hot ?
+	error = pci_set_low_power_state(dev, state > PCI_D3hot ?
 					PCI_D3hot : state);
 
 	if (pci_platform_power_transition(dev, state))



