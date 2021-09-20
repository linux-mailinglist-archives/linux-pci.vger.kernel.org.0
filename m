Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA354126BB
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 21:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347795AbhITTVt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 15:21:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58140 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347807AbhITTTp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Sep 2021 15:19:45 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id ead8fec41815f117; Mon, 20 Sep 2021 21:18:15 +0200
Received: from kreacher.localnet (unknown [213.134.187.25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id DE5CF66A65F;
        Mon, 20 Sep 2021 21:18:14 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v2 1/7] PCI: PM: Do not use pci_platform_pm_ops for Intel MID PM
Date:   Mon, 20 Sep 2021 21:16:59 +0200
Message-ID: <2555295.BddDVKsqQX@kreacher>
In-Reply-To: <1800633.tdWV9SEqCh@kreacher>
References: <1800633.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.25
X-CLIENT-HOSTNAME: 213.134.187.25
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudeivddgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddukeejrddvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrddvhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgt
 hhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepfhhnthhothhhsehgmhgrihhlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are only two users of struct pci_platform_pm_ops in the tree,
one of which is Intel MID PM and the other one is ACPI.  They are
mutually exclusive and the MID PM should take precedence when they
both are enabled, but whether or not this really is the case hinges
on the specific ordering of arch_initcall() calls made by them.

The struct pci_platform_pm_ops abstraction is not really necessary
for just these two users, but it adds complexity and overhead because
of retoplines involved in using all of the function pointers in there.
It also makes following the code a bit more difficult than it would
be otherwise.

Moreover, Intel MID PCI PM doesn't even implement the majority of the
function pointers in struct pci_platform_pm_ops in a meaningful way,
so switch over the PCI core to calling the relevant MID PM routines,
mid_pci_set_power_state() and mid_pci_set_power_state(), directly as
needed and drop mid_pci_platform_pm.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Instead of dropping the MID PCI PM completely, make the PCI core
     call a few functions from there directly instead of using struct
     pci_platform_pm_ops (Andy and Ferry).

---
 drivers/pci/pci-mid.c |   37 ++++++++-----------------------------
 drivers/pci/pci.c     |   23 ++++++++++++++++++++++-
 drivers/pci/pci.h     |   19 +++++++++++++++++++
 3 files changed, 49 insertions(+), 30 deletions(-)

Index: linux-pm/drivers/pci/pci-mid.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-mid.c
+++ linux-pm/drivers/pci/pci-mid.c
@@ -16,45 +16,23 @@
 
 #include "pci.h"
 
-static bool mid_pci_power_manageable(struct pci_dev *dev)
+static bool pci_mid_pm_enabled __read_mostly;
+
+bool pci_use_mid_pm(void)
 {
-	return true;
+	return pci_mid_pm_enabled;
 }
 
-static int mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state)
+int mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state)
 {
 	return intel_mid_pci_set_power_state(pdev, state);
 }
 
-static pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
+pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 {
 	return intel_mid_pci_get_power_state(pdev);
 }
 
-static pci_power_t mid_pci_choose_state(struct pci_dev *pdev)
-{
-	return PCI_D3hot;
-}
-
-static int mid_pci_wakeup(struct pci_dev *dev, bool enable)
-{
-	return 0;
-}
-
-static bool mid_pci_need_resume(struct pci_dev *dev)
-{
-	return false;
-}
-
-static const struct pci_platform_pm_ops mid_pci_platform_pm = {
-	.is_manageable	= mid_pci_power_manageable,
-	.set_state	= mid_pci_set_power_state,
-	.get_state	= mid_pci_get_power_state,
-	.choose_state	= mid_pci_choose_state,
-	.set_wakeup	= mid_pci_wakeup,
-	.need_resume	= mid_pci_need_resume,
-};
-
 /*
  * This table should be in sync with the one in
  * arch/x86/platform/intel-mid/pwr.c.
@@ -71,7 +49,8 @@ static int __init mid_pci_init(void)
 
 	id = x86_match_cpu(lpss_cpu_ids);
 	if (id)
-		pci_set_platform_pm(&mid_pci_platform_pm);
+		pci_mid_pm_enabled = true;
+
 	return 0;
 }
 arch_initcall(mid_pci_init);
Index: linux-pm/drivers/pci/pci.h
===================================================================
--- linux-pm.orig/drivers/pci/pci.h
+++ linux-pm/drivers/pci/pci.h
@@ -744,4 +744,23 @@ extern const struct attribute_group aspm
 
 extern const struct attribute_group pci_dev_reset_method_attr_group;
 
+#ifdef CONFIG_X86_INTEL_MID
+bool pci_use_mid_pm(void);
+int mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state);
+pci_power_t mid_pci_get_power_state(struct pci_dev *pdev);
+#else
+static inline bool pci_use_mid_pm(void)
+{
+	return false;
+}
+static inline int mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state)
+{
+	return -ENODEV;
+}
+static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
+{
+	return PCI_UNKNOWN;
+}
+#endif
+
 #endif /* DRIVERS_PCI_H */
Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -985,45 +985,66 @@ int pci_set_platform_pm(const struct pci
 
 static inline bool platform_pci_power_manageable(struct pci_dev *dev)
 {
+	if (pci_use_mid_pm())
+		return true;
+
 	return pci_platform_pm ? pci_platform_pm->is_manageable(dev) : false;
 }
 
 static inline int platform_pci_set_power_state(struct pci_dev *dev,
 					       pci_power_t t)
 {
+	if (pci_use_mid_pm())
+		return mid_pci_set_power_state(dev, t);
+
 	return pci_platform_pm ? pci_platform_pm->set_state(dev, t) : -ENOSYS;
 }
 
 static inline pci_power_t platform_pci_get_power_state(struct pci_dev *dev)
 {
+	if (pci_use_mid_pm())
+		return mid_pci_get_power_state(dev);
+
 	return pci_platform_pm ? pci_platform_pm->get_state(dev) : PCI_UNKNOWN;
 }
 
 static inline void platform_pci_refresh_power_state(struct pci_dev *dev)
 {
-	if (pci_platform_pm && pci_platform_pm->refresh_state)
+	if (!pci_use_mid_pm() && pci_platform_pm && pci_platform_pm->refresh_state)
 		pci_platform_pm->refresh_state(dev);
 }
 
 static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
 {
+	if (pci_use_mid_pm())
+		return PCI_POWER_ERROR;
+
 	return pci_platform_pm ?
 			pci_platform_pm->choose_state(dev) : PCI_POWER_ERROR;
 }
 
 static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
 {
+	if (pci_use_mid_pm())
+		return PCI_POWER_ERROR;
+
 	return pci_platform_pm ?
 			pci_platform_pm->set_wakeup(dev, enable) : -ENODEV;
 }
 
 static inline bool platform_pci_need_resume(struct pci_dev *dev)
 {
+	if (pci_use_mid_pm())
+		return false;
+
 	return pci_platform_pm ? pci_platform_pm->need_resume(dev) : false;
 }
 
 static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 {
+	if (pci_use_mid_pm())
+		return false;
+
 	if (pci_platform_pm && pci_platform_pm->bridge_d3)
 		return pci_platform_pm->bridge_d3(dev);
 	return false;



