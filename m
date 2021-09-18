Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341E74106C9
	for <lists+linux-pci@lfdr.de>; Sat, 18 Sep 2021 15:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbhIRNa7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Sep 2021 09:30:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57356 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbhIRNa6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Sep 2021 09:30:58 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 58508a8780607b0b; Sat, 18 Sep 2021 15:29:33 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 60AD466A51F;
        Sat, 18 Sep 2021 15:29:32 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        x86 Maintainers <x86@kernel.org>
Subject: [PATCH v1 4/5] PCI: PM: Make pci_choose_state() call pci_target_state()
Date:   Sat, 18 Sep 2021 15:26:08 +0200
Message-ID: <3566670.MHq7AAxBmi@kreacher>
In-Reply-To: <8003272.NyiUUSuA9g@kreacher>
References: <8003272.NyiUUSuA9g@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdejjedrhedurdekgeenucfuphgrmhfkphepkeelrdejjedrhedurdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrjeejrdehuddrkeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghr
 nhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The pci_choose_state() and pci_target_state() implementations are
somewhat divergent without a good reason, because they are used
for similar purposes.

Change the pci_choose_state() implementation to use pci_target_state()
internally except for transitions to the working state of the system
in which case it is expected to return D0.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-acpi.c |    3 --
 drivers/pci/pci.c      |   54 ++++++++++++++-----------------------------------
 2 files changed, 16 insertions(+), 41 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1331,44 +1331,6 @@ int pci_set_power_state(struct pci_dev *
 }
 EXPORT_SYMBOL(pci_set_power_state);
 
-/**
- * pci_choose_state - Choose the power state of a PCI device
- * @dev: PCI device to be suspended
- * @state: target sleep state for the whole system. This is the value
- *	   that is passed to suspend() function.
- *
- * Returns PCI power state suitable for given device and given system
- * message.
- */
-pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
-{
-	pci_power_t ret;
-
-	if (!dev->pm_cap)
-		return PCI_D0;
-
-	ret = acpi_pci_choose_state(dev);
-	if (ret != PCI_POWER_ERROR)
-		return ret;
-
-	switch (state.event) {
-	case PM_EVENT_ON:
-		return PCI_D0;
-	case PM_EVENT_FREEZE:
-	case PM_EVENT_PRETHAW:
-		/* REVISIT both freeze and pre-thaw "should" use D0 */
-	case PM_EVENT_SUSPEND:
-	case PM_EVENT_HIBERNATE:
-		return PCI_D3hot;
-	default:
-		pci_info(dev, "unrecognized suspend event %d\n",
-			 state.event);
-		BUG();
-	}
-	return PCI_D0;
-}
-EXPORT_SYMBOL(pci_choose_state);
-
 #define PCI_EXP_SAVE_REGS	7
 
 static struct pci_cap_saved_state *_pci_find_saved_cap(struct pci_dev *pci_dev,
@@ -2782,6 +2744,22 @@ void pci_dev_complete_resume(struct pci_
 	spin_unlock_irq(&dev->power.lock);
 }
 
+/**
+ * pci_choose_state - Choose the power state for a PCI device.
+ * @pci_dev: Target PCI device.
+ * @state: Target state for the whole system.
+ *
+ * Returns PCI power state suitable for @pci_dev and @state.
+ */
+pci_power_t pci_choose_state(struct pci_dev *pci_dev, pm_message_t state)
+{
+	if (state.event == PM_EVENT_ON)
+		return PCI_D0;
+
+	return pci_target_state(pci_dev, device_may_wakeup(&pci_dev->dev));
+}
+EXPORT_SYMBOL(pci_choose_state);
+
 void pci_config_pm_runtime_get(struct pci_dev *pdev)
 {
 	struct device *dev = &pdev->dev;
Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -910,9 +910,6 @@ pci_power_t acpi_pci_choose_state(struct
 {
 	int acpi_state, d_max;
 
-	if (acpi_pci_disabled)
-		return PCI_POWER_ERROR;
-
 	if (pdev->no_d3cold)
 		d_max = ACPI_STATE_D3_HOT;
 	else



