Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4DF4126B9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 21:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347873AbhITTVo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 15:21:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45714 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347806AbhITTTm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Sep 2021 15:19:42 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 4d4f752364788fdc; Mon, 20 Sep 2021 21:18:14 +0200
Received: from kreacher.localnet (unknown [213.134.187.25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4F7FB66A65F;
        Mon, 20 Sep 2021 21:18:13 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 2/7] PCI: ACPI: PM: Do not use pci_platform_pm_ops for ACPI
Date:   Mon, 20 Sep 2021 21:17:08 +0200
Message-ID: <8879480.rMLUfLXkoz@kreacher>
In-Reply-To: <1800633.tdWV9SEqCh@kreacher>
References: <1800633.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.25
X-CLIENT-HOSTNAME: 213.134.187.25
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudeivddgudefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrddukeejrddvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrddvhedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgt
 hhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Using struct pci_platform_pm_ops for ACPI adds unnecessary
indirection to the interactions between the PCI core and ACPI PM,
which is also subject to retpolines.

Moreover, it is not particularly clear from the current code that,
as far as PCI PM is concerned, "platform" really means just ACPI
except for the special casess when Intel MID PCI PM is used or when
ACPI support is disabled (through the kernel config or command line,
or because there are no usable ACPI tables on the system).

To address the above, rework the PCI PM code to invoke ACPI PM
functions directly as needed and drop the acpi_pci_platform_pm
object that is not necessary any more.

Accordingly, update some of the ACPI PM functions in question to do
extra checks in case the ACPI support is disabled (which previously
was taken care of by avoiding to set the pci_platform_ops pointer
in those cases).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
    * Rebase on top of the new [1/7] and move dropping struct
      pci_platform_pm_ops to a separate patch.

---
 drivers/pci/pci-acpi.c |   42 ++++++++++++++++++++----------------------
 drivers/pci/pci.c      |   22 +++++++++-------------
 drivers/pci/pci.h      |   38 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 66 insertions(+), 36 deletions(-)

Index: linux-pm/drivers/pci/pci-acpi.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-acpi.c
+++ linux-pm/drivers/pci/pci-acpi.c
@@ -906,10 +906,13 @@ acpi_status pci_acpi_add_pm_notifier(str
  *	choose highest power _SxD or any lower power
  */
 
-static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
+pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 {
 	int acpi_state, d_max;
 
+	if (acpi_pci_disabled)
+		return PCI_POWER_ERROR;
+
 	if (pdev->no_d3cold)
 		d_max = ACPI_STATE_D3_HOT;
 	else
@@ -965,7 +968,7 @@ int pci_dev_acpi_reset(struct pci_dev *d
 	return 0;
 }
 
-static bool acpi_pci_power_manageable(struct pci_dev *dev)
+bool acpi_pci_power_manageable(struct pci_dev *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
 
@@ -974,13 +977,13 @@ static bool acpi_pci_power_manageable(st
 	return acpi_device_power_manageable(adev);
 }
 
-static bool acpi_pci_bridge_d3(struct pci_dev *dev)
+bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	const union acpi_object *obj;
 	struct acpi_device *adev;
 	struct pci_dev *rpdev;
 
-	if (!dev->is_hotplug_bridge)
+	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
 		return false;
 
 	/* Assume D3 support if the bridge is power-manageable by ACPI. */
@@ -1008,7 +1011,7 @@ static bool acpi_pci_bridge_d3(struct pc
 	return obj->integer.value == 1;
 }
 
-static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
 	static const u8 state_conv[] = {
@@ -1046,7 +1049,7 @@ static int acpi_pci_set_power_state(stru
 	return error;
 }
 
-static pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
+pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
 	static const pci_power_t state_conv[] = {
@@ -1068,7 +1071,7 @@ static pci_power_t acpi_pci_get_power_st
 	return state_conv[state];
 }
 
-static void acpi_pci_refresh_power_state(struct pci_dev *dev)
+void acpi_pci_refresh_power_state(struct pci_dev *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
 
@@ -1093,17 +1096,23 @@ static int acpi_pci_propagate_wakeup(str
 	return 0;
 }
 
-static int acpi_pci_wakeup(struct pci_dev *dev, bool enable)
+int acpi_pci_wakeup(struct pci_dev *dev, bool enable)
 {
+	if (acpi_pci_disabled)
+		return 0;
+
 	if (acpi_pm_device_can_wakeup(&dev->dev))
 		return acpi_pm_set_device_wakeup(&dev->dev, enable);
 
 	return acpi_pci_propagate_wakeup(dev->bus, enable);
 }
 
-static bool acpi_pci_need_resume(struct pci_dev *dev)
+bool acpi_pci_need_resume(struct pci_dev *dev)
 {
-	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
+	struct acpi_device *adev;
+
+	if (acpi_pci_disabled)
+		return false;
 
 	/*
 	 * In some cases (eg. Samsung 305V4A) leaving a bridge in suspend over
@@ -1118,6 +1127,7 @@ static bool acpi_pci_need_resume(struct
 	if (!adev || !acpi_device_power_manageable(adev))
 		return false;
 
+	adev = ACPI_COMPANION(&dev->dev);
 	if (adev->wakeup.flags.valid &&
 	    device_may_wakeup(&dev->dev) != !!adev->wakeup.prepare_count)
 		return true;
@@ -1128,17 +1138,6 @@ static bool acpi_pci_need_resume(struct
 	return !!adev->power.flags.dsw_present;
 }
 
-static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
-	.bridge_d3 = acpi_pci_bridge_d3,
-	.is_manageable = acpi_pci_power_manageable,
-	.set_state = acpi_pci_set_power_state,
-	.get_state = acpi_pci_get_power_state,
-	.refresh_state = acpi_pci_refresh_power_state,
-	.choose_state = acpi_pci_choose_state,
-	.set_wakeup = acpi_pci_wakeup,
-	.need_resume = acpi_pci_need_resume,
-};
-
 void acpi_pci_add_bus(struct pci_bus *bus)
 {
 	union acpi_object *obj;
@@ -1448,7 +1447,6 @@ static int __init acpi_pci_init(void)
 	if (acpi_pci_disabled)
 		return 0;
 
-	pci_set_platform_pm(&acpi_pci_platform_pm);
 	acpi_pci_slot_init();
 	acpiphp_init();
 
Index: linux-pm/drivers/pci/pci.h
===================================================================
--- linux-pm.orig/drivers/pci/pci.h
+++ linux-pm/drivers/pci/pci.h
@@ -725,17 +725,53 @@ int pci_acpi_program_hp_params(struct pc
 extern const struct attribute_group pci_dev_acpi_attr_group;
 void pci_set_acpi_fwnode(struct pci_dev *dev);
 int pci_dev_acpi_reset(struct pci_dev *dev, bool probe);
+bool acpi_pci_power_manageable(struct pci_dev *dev);
+bool acpi_pci_bridge_d3(struct pci_dev *dev);
+int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state);
+pci_power_t acpi_pci_get_power_state(struct pci_dev *dev);
+void acpi_pci_refresh_power_state(struct pci_dev *dev);
+int acpi_pci_wakeup(struct pci_dev *dev, bool enable);
+bool acpi_pci_need_resume(struct pci_dev *dev);
+pci_power_t acpi_pci_choose_state(struct pci_dev *pdev);
 #else
 static inline int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
 {
 	return -ENOTTY;
 }
-
 static inline void pci_set_acpi_fwnode(struct pci_dev *dev) {}
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
 	return -ENODEV;
 }
+static inline bool acpi_pci_power_manageable(struct pci_dev *dev)
+{
+	return false;
+}
+static inline bool acpi_pci_bridge_d3(struct pci_dev *dev)
+{
+	return false;
+}
+static inline int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+{
+	return -ENODEV;
+}
+static inline pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
+{
+	return PCI_UNKNOWN;
+}
+static inline void acpi_pci_refresh_power_state(struct pci_dev *dev) {}
+static inline int acpi_pci_wakeup(struct pci_dev *dev, bool enable)
+{
+	return -ENODEV;
+}
+static inline bool acpi_pci_need_resume(struct pci_dev *dev)
+{
+	return false;
+}
+static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
+{
+	return PCI_POWER_ERROR;
+}
 #endif
 
 #ifdef CONFIG_PCIEASPM
Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -988,7 +988,7 @@ static inline bool platform_pci_power_ma
 	if (pci_use_mid_pm())
 		return true;
 
-	return pci_platform_pm ? pci_platform_pm->is_manageable(dev) : false;
+	return acpi_pci_power_manageable(dev);
 }
 
 static inline int platform_pci_set_power_state(struct pci_dev *dev,
@@ -997,7 +997,7 @@ static inline int platform_pci_set_power
 	if (pci_use_mid_pm())
 		return mid_pci_set_power_state(dev, t);
 
-	return pci_platform_pm ? pci_platform_pm->set_state(dev, t) : -ENOSYS;
+	return acpi_pci_set_power_state(dev, t);
 }
 
 static inline pci_power_t platform_pci_get_power_state(struct pci_dev *dev)
@@ -1005,13 +1005,13 @@ static inline pci_power_t platform_pci_g
 	if (pci_use_mid_pm())
 		return mid_pci_get_power_state(dev);
 
-	return pci_platform_pm ? pci_platform_pm->get_state(dev) : PCI_UNKNOWN;
+	return acpi_pci_get_power_state(dev);
 }
 
 static inline void platform_pci_refresh_power_state(struct pci_dev *dev)
 {
-	if (!pci_use_mid_pm() && pci_platform_pm && pci_platform_pm->refresh_state)
-		pci_platform_pm->refresh_state(dev);
+	if (!pci_use_mid_pm())
+		acpi_pci_refresh_power_state(dev);
 }
 
 static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
@@ -1019,8 +1019,7 @@ static inline pci_power_t platform_pci_c
 	if (pci_use_mid_pm())
 		return PCI_POWER_ERROR;
 
-	return pci_platform_pm ?
-			pci_platform_pm->choose_state(dev) : PCI_POWER_ERROR;
+	return acpi_pci_choose_state(dev);
 }
 
 static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
@@ -1028,8 +1027,7 @@ static inline int platform_pci_set_wakeu
 	if (pci_use_mid_pm())
 		return PCI_POWER_ERROR;
 
-	return pci_platform_pm ?
-			pci_platform_pm->set_wakeup(dev, enable) : -ENODEV;
+	return acpi_pci_wakeup(dev, enable);
 }
 
 static inline bool platform_pci_need_resume(struct pci_dev *dev)
@@ -1037,7 +1035,7 @@ static inline bool platform_pci_need_res
 	if (pci_use_mid_pm())
 		return false;
 
-	return pci_platform_pm ? pci_platform_pm->need_resume(dev) : false;
+	return acpi_pci_need_resume(dev);
 }
 
 static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
@@ -1045,9 +1043,7 @@ static inline bool platform_pci_bridge_d
 	if (pci_use_mid_pm())
 		return false;
 
-	if (pci_platform_pm && pci_platform_pm->bridge_d3)
-		return pci_platform_pm->bridge_d3(dev);
-	return false;
+	return acpi_pci_bridge_d3(dev);
 }
 
 /**



