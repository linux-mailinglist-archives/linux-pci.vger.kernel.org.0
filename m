Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB7E4FA877
	for <lists+linux-pci@lfdr.de>; Sat,  9 Apr 2022 15:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242113AbiDINbN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Apr 2022 09:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242150AbiDINbM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Apr 2022 09:31:12 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E89CBB914;
        Sat,  9 Apr 2022 06:29:03 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 07983d4bf8017218; Sat, 9 Apr 2022 15:29:02 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B023D66BCE9;
        Sat,  9 Apr 2022 15:29:01 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 1/7] PCI/PM: Resume subordinate bus in bus type callbacks
Date:   Sat, 09 Apr 2022 15:05:28 +0200
Message-ID: <1842667.tdWV9SEqCh@kreacher>
In-Reply-To: <4419002.LvFx2qVVIh@kreacher>
References: <4419002.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudekvddgfeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdejjedrhedurdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrjeejrdehuddrkeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhkrgdrfigvshht
 vghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
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
 



