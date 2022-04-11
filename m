Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB204FBF4C
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 16:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347380AbiDKOhI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 10:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347384AbiDKOgs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 10:36:48 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F2FAE5A;
        Mon, 11 Apr 2022 07:34:14 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 954161c5054c236a; Mon, 11 Apr 2022 16:34:12 +0200
Received: from kreacher.localnet (unknown [213.134.175.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E28D866BDD4;
        Mon, 11 Apr 2022 16:34:11 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 1/9] PCI/PM: Resume subordinate bus in bus type callbacks
Date:   Mon, 11 Apr 2022 16:19:00 +0200
Message-ID: <5830409.lOV4Wx5bFT@kreacher>
In-Reply-To: <11975904.O9o76ZdvQC@kreacher>
References: <4419002.LvFx2qVVIh@kreacher> <11975904.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.113
X-CLIENT-HOSTNAME: 213.134.175.113
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekiedgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepvddufedrudefgedrudejhedruddufeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddujeehrdduudefpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
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

Calling pci_resume_bus() on the secondary bus from pci_power_up() as
it is done now is questionable, because it depends on the mandatory
bridge power-up delays that are only covered by the PCI bus type PM
callbacks.

For this reason, move the subordinate bus resume to those callbacks
too and use the observation that if a bridge is being powered-up
during resume from system-wide suspend, it may be still desirable
to runtime-resume its subordinate bus after completing the system-
wide transition (in case the resume of the devices on that bus is
skipped during it).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes.

---
 drivers/pci/pci-driver.c |   15 +++++++++++++--
 drivers/pci/pci.c        |   15 ---------------
 2 files changed, 13 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -559,6 +559,17 @@ static void pci_pm_default_resume_early(
 	pci_pme_restore(pci_dev);
 }
 
+static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
+{
+	pci_bridge_wait_for_secondary_bus(pci_dev);
+	/*
+	 * When powering on a bridge from D3cold, the whole hierarchy may be
+	 * powered on into D0uninitialized state, resume them to give them a
+	 * chance to suspend again
+	 */
+	pci_resume_bus(pci_dev->subordinate);
+}
+
 #endif
 
 #ifdef CONFIG_PM_SLEEP
@@ -934,7 +945,7 @@ static int pci_pm_resume_noirq(struct de
 	pcie_pme_root_status_cleanup(pci_dev);
 
 	if (!skip_bus_pm && prev_state == PCI_D3cold)
-		pci_bridge_wait_for_secondary_bus(pci_dev);
+		pci_pm_bridge_power_up_actions(pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return 0;
@@ -1321,7 +1332,7 @@ static int pci_pm_runtime_resume(struct
 	pci_pm_default_resume(pci_dev);
 
 	if (prev_state == PCI_D3cold)
-		pci_bridge_wait_for_secondary_bus(pci_dev);
+		pci_pm_bridge_power_up_actions(pci_dev);
 
 	if (pm && pm->runtime_resume)
 		error = pm->runtime_resume(dev);
Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1310,21 +1310,6 @@ static int pci_dev_wait(struct pci_dev *
 int pci_power_up(struct pci_dev *dev)
 {
 	pci_platform_power_transition(dev, PCI_D0);
-
-	/*
-	 * Mandatory power management transition delays are handled in
-	 * pci_pm_resume_noirq() and pci_pm_runtime_resume() of the
-	 * corresponding bridge.
-	 */
-	if (dev->runtime_d3cold) {
-		/*
-		 * When powering on a bridge from D3cold, the whole hierarchy
-		 * may be powered on into D0uninitialized state, resume them to
-		 * give them a chance to suspend again
-		 */
-		pci_resume_bus(dev->subordinate);
-	}
-
 	return pci_raw_set_power_state(dev, PCI_D0);
 }
 



