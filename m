Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583F151C80F
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 20:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383455AbiEESc3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 14:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385290AbiEESaU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 14:30:20 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BDD5F266;
        Thu,  5 May 2022 11:20:55 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id c5f090cacb785d8c; Thu, 5 May 2022 20:19:42 +0200
Received: from kreacher.localnet (unknown [213.134.161.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 63EBB66C2F2;
        Thu,  5 May 2022 20:19:41 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v1 02/11] PCI/PM: Relocate pci_set_low_power_state()
Date:   Thu, 05 May 2022 20:02:52 +0200
Message-ID: <3202976.44csPzL39Z@kreacher>
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

Because pci_set_power_state() is the only caller of
pci_set_low_power_state(), put the latter next to the former.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |  158 +++++++++++++++++++++++++++---------------------------
 1 file changed, 79 insertions(+), 79 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1068,85 +1068,6 @@ static inline bool platform_pci_bridge_d
 }
 
 /**
- * pci_set_low_power_state - Put a PCI device into a low-power state.
- * @dev: PCI device to handle.
- * @state: PCI power state (D1, D2, D3hot) to put the device into.
- *
- * Use the device's PCI_PM_CTRL register to put it into a low-power state.
- *
- * RETURN VALUE:
- * -EINVAL if the requested state is invalid.
- * -EIO if device does not support PCI PM or its PM capabilities register has a
- * wrong version, or device doesn't support the requested state.
- * 0 if device already is in the requested state.
- * 0 if device's power state has been successfully changed.
- */
-static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
-{
-	u16 pmcsr;
-
-	/* Check if we're already there */
-	if (dev->current_state == state)
-		return 0;
-
-	if (!dev->pm_cap)
-		return -EIO;
-
-	if (state < PCI_D1 || state > PCI_D3hot)
-		return -EINVAL;
-
-	/*
-	 * Validate transition: We can enter D0 from any state, but if
-	 * we're already in a low-power state, we can only go deeper.  E.g.,
-	 * we can go from D1 to D3, but we can't go directly from D3 to D1;
-	 * we'd have to go from D3 to D0, then to D1.
-	 */
-	if (dev->current_state <= PCI_D3cold && dev->current_state > state) {
-		pci_err(dev, "invalid power transition (from %s to %s)\n",
-			pci_power_name(dev->current_state),
-			pci_power_name(state));
-		return -EINVAL;
-	}
-
-	/* Check if this device supports the desired state */
-	if ((state == PCI_D1 && !dev->d1_support)
-	   || (state == PCI_D2 && !dev->d2_support))
-		return -EIO;
-
-	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-	if (PCI_POSSIBLE_ERROR(pmcsr)) {
-		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
-			pci_power_name(dev->current_state),
-			pci_power_name(state));
-		return -EIO;
-	}
-
-	pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
-	pmcsr |= state;
-
-	/* Enter specified state */
-	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
-
-	/* Mandatory power management transition delays; see PCI PM 1.2. */
-	if (state == PCI_D3hot)
-		pci_dev_d3_sleep(dev);
-	else if (state == PCI_D2)
-		udelay(PCI_PM_D2_DELAY);
-
-	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-	dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
-	if (dev->current_state != state)
-		pci_info_ratelimited(dev, "Refused to change power state from %s to %s\n",
-				     pci_power_name(dev->current_state),
-				     pci_power_name(state));
-
-	if (dev->bus->self)
-		pcie_aspm_pm_state_change(dev->bus->self);
-
-	return 0;
-}
-
-/**
  * pci_update_current_state - Read power state of given device and cache it
  * @dev: PCI device to handle.
  * @state: State to cache in case the device doesn't have the PM capability
@@ -1364,6 +1285,85 @@ void pci_bus_set_current_state(struct pc
 }
 
 /**
+ * pci_set_low_power_state - Put a PCI device into a low-power state.
+ * @dev: PCI device to handle.
+ * @state: PCI power state (D1, D2, D3hot) to put the device into.
+ *
+ * Use the device's PCI_PM_CTRL register to put it into a low-power state.
+ *
+ * RETURN VALUE:
+ * -EINVAL if the requested state is invalid.
+ * -EIO if device does not support PCI PM or its PM capabilities register has a
+ * wrong version, or device doesn't support the requested state.
+ * 0 if device already is in the requested state.
+ * 0 if device's power state has been successfully changed.
+ */
+static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
+{
+	u16 pmcsr;
+
+	/* Check if we're already there */
+	if (dev->current_state == state)
+		return 0;
+
+	if (!dev->pm_cap)
+		return -EIO;
+
+	if (state < PCI_D1 || state > PCI_D3hot)
+		return -EINVAL;
+
+	/*
+	 * Validate transition: We can enter D0 from any state, but if
+	 * we're already in a low-power state, we can only go deeper.  E.g.,
+	 * we can go from D1 to D3, but we can't go directly from D3 to D1;
+	 * we'd have to go from D3 to D0, then to D1.
+	 */
+	if (dev->current_state <= PCI_D3cold && dev->current_state > state) {
+		pci_err(dev, "invalid power transition (from %s to %s)\n",
+			pci_power_name(dev->current_state),
+			pci_power_name(state));
+		return -EINVAL;
+	}
+
+	/* Check if this device supports the desired state */
+	if ((state == PCI_D1 && !dev->d1_support)
+	   || (state == PCI_D2 && !dev->d2_support))
+		return -EIO;
+
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	if (PCI_POSSIBLE_ERROR(pmcsr)) {
+		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
+			pci_power_name(dev->current_state),
+			pci_power_name(state));
+		return -EIO;
+	}
+
+	pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
+	pmcsr |= state;
+
+	/* Enter specified state */
+	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr);
+
+	/* Mandatory power management transition delays; see PCI PM 1.2. */
+	if (state == PCI_D3hot)
+		pci_dev_d3_sleep(dev);
+	else if (state == PCI_D2)
+		udelay(PCI_PM_D2_DELAY);
+
+	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
+	if (dev->current_state != state)
+		pci_info_ratelimited(dev, "Refused to change power state from %s to %s\n",
+				     pci_power_name(dev->current_state),
+				     pci_power_name(state));
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



