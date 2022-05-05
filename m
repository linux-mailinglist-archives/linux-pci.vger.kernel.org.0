Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA92951C7AB
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 20:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbiEESds (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 14:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385385AbiEESaY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 14:30:24 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9955DBC7;
        Thu,  5 May 2022 11:21:08 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id af71f734f8f99855; Thu, 5 May 2022 20:19:34 +0200
Received: from kreacher.localnet (unknown [213.134.161.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8B3F666C2F2;
        Thu,  5 May 2022 20:19:33 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v1 07/11] PCI/PM: Split pci_power_up()
Date:   Thu, 05 May 2022 20:13:00 +0200
Message-ID: <1942150.usQuhbGJ8B@kreacher>
In-Reply-To: <4738492.GXAFRqVoOG@kreacher>
References: <4738492.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.161.219
X-CLIENT-HOSTNAME: 213.134.161.219
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfedugdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudefrddufeegrdduiedurddvudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeiuddrvdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgv
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

One of the two callers of pci_power_up() invokes
pci_update_current_state() and pci_restore_state() right after calling
it, in which case running the part of it happening after the mandatory
transition delays is redundant, so move that part out of it into a new
function called pci_set_full_power_state() that will be invoked from
pci_set_power_state() which is the other caller of pci_power_up().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |   41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1189,6 +1189,9 @@ static int pci_dev_wait(struct pci_dev *
 /**
  * pci_power_up - Put the given device into D0
  * @dev: PCI device to power up
+ *
+ * On success, return 0 or 1, depending on whether or not it is necessary to
+ * restore the device's BARs subsequently (1 is returned in that case).
  */
 int pci_power_up(struct pci_dev *dev)
 {
@@ -1224,10 +1227,8 @@ int pci_power_up(struct pci_dev *dev)
 	need_restore = (state == PCI_D3hot || dev->current_state >= PCI_D3hot) &&
 			!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET);
 
-	if (state == PCI_D0) {
-		dev->current_state = PCI_D0;
+	if (state == PCI_D0)
 		goto end;
-	}
 
 	/*
 	 * Force the entire word to 0. This doesn't affect PME_Status, disables
@@ -1241,13 +1242,41 @@ int pci_power_up(struct pci_dev *dev)
 	else if (state == PCI_D2)
 		udelay(PCI_PM_D2_DELAY);
 
+end:
+	dev->current_state = PCI_D0;
+	if (need_restore)
+		return 1;
+
+	return 0;
+}
+
+/**
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
+	u16 pmcsr;
+	int ret;
+
+	ret = pci_power_up(dev);
+	if (ret < 0)
+		return ret;
+
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	dev->current_state = pmcsr & PCI_PM_CTRL_STATE_MASK;
 	if (dev->current_state != PCI_D0)
 		pci_info_ratelimited(dev, "Refused to change power state from %s to D0\n",
 				     pci_power_name(dev->current_state));
 
-end:
 	/*
 	 * According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
 	 * INTERFACE SPECIFICATION, REV. 1.2", a device transitioning
@@ -1261,7 +1290,7 @@ end:
 	 * restore at least the BARs so that the device will be
 	 * accessible to its driver.
 	 */
-	if (need_restore)
+	if (ret > 0)
 		pci_restore_bars(dev);
 
 	if (dev->bus->self)
@@ -1415,7 +1444,7 @@ int pci_set_power_state(struct pci_dev *
 		return 0;
 
 	if (state == PCI_D0)
-		return pci_power_up(dev);
+		return pci_set_full_power_state(dev);
 
 	/*
 	 * This device is quirked not to be put into D3, so don't put it in



