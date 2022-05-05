Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37A651C7F7
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 20:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383645AbiEEScg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 14:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385413AbiEESa0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 14:30:26 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349AC5DBE6;
        Thu,  5 May 2022 11:21:11 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 6b9b41d5d424d27d; Thu, 5 May 2022 20:19:44 +0200
Received: from kreacher.localnet (unknown [213.134.161.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id F2AB966C2F2;
        Thu,  5 May 2022 20:19:42 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v1 01/11] PCI/PM: Split pci_raw_set_power_state()
Date:   Thu, 05 May 2022 20:00:33 +0200
Message-ID: <13038676.uLZWGnKmhe@kreacher>
In-Reply-To: <4738492.GXAFRqVoOG@kreacher>
References: <4738492.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.161.219
X-CLIENT-HOSTNAME: 213.134.161.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfedugdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrdduiedurddvudelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiuddrvdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgv
 lhdrtghomhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnuggvrhhsrdhrohigvghllheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The transitions from low-power states to D0 and the other way around
are unnecessarily tangled in pci_raw_set_power_state() which makes it
rather hard to follow.

Moreover, the only caller of pci_raw_set_power_state() passing PCI_D0
as its state argument is pci_power_up(), so the code carrying out
transitions into D0 can be put directly into that function.

Accordingly, move the code handling transitions from low-power states
into D0 directly into pci_power_up() and rename the remaining part
of pci_raw_set_power_state() to pci_set_low_power_state(), because
it only handles transitions into low-power state now.

While at it, fix up some white space, update some comments and modify
messages printed by pci_power_up() and pci_set_low_power_state() to
be less confusing (which is the only expected functional impact of
this change).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |  143 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 83 insertions(+), 60 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1068,10 +1068,11 @@ static inline bool platform_pci_bridge_d
 }
 
 /**
- * pci_raw_set_power_state - Use PCI PM registers to set the power state of
- *			     given PCI device
+ * pci_set_low_power_state - Put a PCI device into a low-power state.
  * @dev: PCI device to handle.
- * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
+ * @state: PCI power state (D1, D2, D3hot) to put the device into.
+ *
+ * Use the device's PCI_PM_CTRL register to put it into a low-power state.
  *
  * RETURN VALUE:
  * -EINVAL if the requested state is invalid.
@@ -1080,10 +1081,9 @@ static inline bool platform_pci_bridge_d
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
@@ -1092,7 +1092,7 @@ static int pci_raw_set_power_state(struc
 	if (!dev->pm_cap)
 		return -EIO;
 
-	if (state < PCI_D0 || state > PCI_D3hot)
+	if (state < PCI_D1 || state > PCI_D3hot)
 		return -EINVAL;
 
 	/*
@@ -1101,8 +1101,7 @@ static int pci_raw_set_power_state(struc
 	 * we can go from D1 to D3, but we can't go directly from D3 to D1;
 	 * we'd have to go from D3 to D0, then to D1.
 	 */
-	if (state != PCI_D0 && dev->current_state <= PCI_D3cold
-	    && dev->current_state > state) {
+	if (dev->current_state <= PCI_D3cold && dev->current_state > state) {
 		pci_err(dev, "invalid power transition (from %s to %s)\n",
 			pci_power_name(dev->current_state),
 			pci_power_name(state));
@@ -1116,70 +1115,30 @@ static int pci_raw_set_power_state(struc
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (PCI_POSSIBLE_ERROR(pmcsr)) {
-		pci_err(dev, "can't change power state from %s to %s (config space inaccessible)\n",
+		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
 			pci_power_name(dev->current_state),
 			pci_power_name(state));
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
 
-	/*
-	 * Mandatory power management transition delays; see PCI PM 1.1
-	 * 5.6.1 table 18
-	 */
-	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
+	/* Mandatory power management transition delays; see PCI PM 1.2. */
+	if (state == PCI_D3hot)
 		pci_dev_d3_sleep(dev);
-	else if (state == PCI_D2 || dev->current_state == PCI_D2)
+	else if (state == PCI_D2)
 		udelay(PCI_PM_D2_DELAY);
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-	dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
+	dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
 	if (dev->current_state != state)
-		pci_info_ratelimited(dev, "refused to change power state from %s to %s\n",
-			 pci_power_name(dev->current_state),
-			 pci_power_name(state));
-
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
+		pci_info_ratelimited(dev, "Refused to change power state from %s to %s\n",
+				     pci_power_name(dev->current_state),
+				     pci_power_name(state));
 
 	if (dev->bus->self)
 		pcie_aspm_pm_state_change(dev->bus->self);
@@ -1312,8 +1271,72 @@ static int pci_dev_wait(struct pci_dev *
  */
 int pci_power_up(struct pci_dev *dev)
 {
+	bool need_restore = false;
+	u16 pmcsr;
+
 	pci_platform_power_transition(dev, PCI_D0);
-	return pci_raw_set_power_state(dev, PCI_D0);
+
+	if (dev->current_state == PCI_D0)
+		return 0;
+
+	if (!dev->pm_cap)
+		return -EIO;
+
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	if (PCI_POSSIBLE_ERROR(pmcsr)) {
+		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
+			pci_power_name(dev->current_state));
+		return -EIO;
+	}
+
+	/*
+	 * If we're (effectively) in D3, force entire word to 0. This doesn't
+	 * affect PME_Status, disables PME_En, and sets PowerState to 0.
+	 */
+	if (dev->current_state >= PCI_D3hot) {
+		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot &&
+		    !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
+			need_restore = true;
+
+		pmcsr = 0;
+	} else {
+		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
+	}
+
+	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
+
+	/* Mandatory transition delays; see PCI PM 1.2. */
+	if (dev->current_state == PCI_D3hot)
+		pci_dev_d3_sleep(dev);
+	else if (dev->current_state == PCI_D2)
+		udelay(PCI_PM_D2_DELAY);
+
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
+	if (dev->current_state != PCI_D0)
+		pci_info_ratelimited(dev, "Refused to change power state from %s to D0\n",
+				     pci_power_name(dev->current_state));
+
+	/*
+	 * According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
+	 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
+	 * from D3hot to D0 _may_ perform an internal reset, thereby
+	 * going to "D0 Uninitialized" rather than "D0 Initialized".
+	 * For example, at least some versions of the 3c905B and the
+	 * 3c556B exhibit this behaviour.
+	 *
+	 * At least some laptop BIOSen (e.g. the Thinkpad T21) leave
+	 * devices in a D3hot state at boot.  Consequently, we need to
+	 * restore at least the BARs so that the device will be
+	 * accessible to its driver.
+	 */
+	if (need_restore)
+		pci_restore_bars(dev);
+
+	if (dev->bus->self)
+		pcie_aspm_pm_state_change(dev->bus->self);
+
+	return 0;
 }
 
 /**
@@ -1394,7 +1417,7 @@ int pci_set_power_state(struct pci_dev *
 	 * To put device in D3cold, we put device into D3hot in native
 	 * way, then put device into D3cold with platform ops
 	 */
-	error = pci_raw_set_power_state(dev, state > PCI_D3hot ?
+	error = pci_set_low_power_state(dev, state > PCI_D3hot ?
 					PCI_D3hot : state);
 
 	if (pci_platform_power_transition(dev, state))



