Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304774106CF
	for <lists+linux-pci@lfdr.de>; Sat, 18 Sep 2021 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbhIRNcI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Sep 2021 09:32:08 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41242 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238371AbhIRNcH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 18 Sep 2021 09:32:07 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id fa5dd84b8c8e57fd; Sat, 18 Sep 2021 15:30:42 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 2308C66A51F;
        Sat, 18 Sep 2021 15:30:40 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        x86 Maintainers <x86@kernel.org>
Subject: [PATCH v1 2/5] PCI: ACPI: PM: Do not use pci_platform_pm_ops for ACPI
Date:   Sat, 18 Sep 2021 15:23:10 +0200
Message-ID: <2479850.Lt9SDvczpP@kreacher>
In-Reply-To: <8003272.NyiUUSuA9g@kreacher>
References: <8003272.NyiUUSuA9g@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdejjedrhedurdekgeenucfuphgrmhfkphepkeelrdejjedrhedurdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrjeejrdehuddrkeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghr
 nhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=28 Fuz1=28 Fuz2=28
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Using struct pci_platform_pm_ops for ACPI adds unnecessary
indirection to the interactions between the PCI core and ACPI PM,
which is also subject to retpolines.

Moreover, it is not particularly clear from the current code that,
as far as PCI PM is concerned, "platform" really means just ACPI as
long as CONFIG_ACPI is set and the ACPI support is not disabled
(either via the kernel command line or because there are no usable
ACPI tables on the system).

To address the above, rework the PCI PM code to invoke ACPI PM
functions directly as needed and drop acpi_pci_platform_pm that
is not necessary any more.  Accordingly, update some of the ACPI PM
functions in question to do extra checks in case the ACPI support
is disabled (which previously was taken care of by avoiding to set
the pci_platform_ops pointer by PCI in those cases).

Having done that, also drop struct pci_platform_pm_ops that has no
more users.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-acpi.c |   42 +++++++++-----------
 drivers/pci/pci.c      |   99 ++++++++++---------------------------------------
 drivers/pci/pci.h      |   77 ++++++++++++++++++--------------------
 3 files changed, 79 insertions(+), 139 deletions(-)

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
 
Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -972,63 +972,6 @@ static void pci_restore_bars(struct pci_
 		pci_update_resource(dev, i);
 }
 
-static const struct pci_platform_pm_ops *pci_platform_pm;
-
-int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
-{
-	if (!ops->is_manageable || !ops->set_state  || !ops->get_state ||
-	    !ops->choose_state  || !ops->set_wakeup || !ops->need_resume)
-		return -EINVAL;
-	pci_platform_pm = ops;
-	return 0;
-}
-
-static inline bool platform_pci_power_manageable(struct pci_dev *dev)
-{
-	return pci_platform_pm ? pci_platform_pm->is_manageable(dev) : false;
-}
-
-static inline int platform_pci_set_power_state(struct pci_dev *dev,
-					       pci_power_t t)
-{
-	return pci_platform_pm ? pci_platform_pm->set_state(dev, t) : -ENOSYS;
-}
-
-static inline pci_power_t platform_pci_get_power_state(struct pci_dev *dev)
-{
-	return pci_platform_pm ? pci_platform_pm->get_state(dev) : PCI_UNKNOWN;
-}
-
-static inline void platform_pci_refresh_power_state(struct pci_dev *dev)
-{
-	if (pci_platform_pm && pci_platform_pm->refresh_state)
-		pci_platform_pm->refresh_state(dev);
-}
-
-static inline pci_power_t platform_pci_choose_state(struct pci_dev *dev)
-{
-	return pci_platform_pm ?
-			pci_platform_pm->choose_state(dev) : PCI_POWER_ERROR;
-}
-
-static inline int platform_pci_set_wakeup(struct pci_dev *dev, bool enable)
-{
-	return pci_platform_pm ?
-			pci_platform_pm->set_wakeup(dev, enable) : -ENODEV;
-}
-
-static inline bool platform_pci_need_resume(struct pci_dev *dev)
-{
-	return pci_platform_pm ? pci_platform_pm->need_resume(dev) : false;
-}
-
-static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
-{
-	if (pci_platform_pm && pci_platform_pm->bridge_d3)
-		return pci_platform_pm->bridge_d3(dev);
-	return false;
-}
-
 /**
  * pci_raw_set_power_state - Use PCI PM registers to set the power state of
  *			     given PCI device
@@ -1163,7 +1106,7 @@ static int pci_raw_set_power_state(struc
  */
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
 {
-	if (platform_pci_get_power_state(dev) == PCI_D3cold ||
+	if (acpi_pci_get_power_state(dev) == PCI_D3cold ||
 	    !pci_device_is_present(dev)) {
 		dev->current_state = PCI_D3cold;
 	} else if (dev->pm_cap) {
@@ -1180,19 +1123,19 @@ void pci_update_current_state(struct pci
  * pci_refresh_power_state - Refresh the given device's power state data
  * @dev: Target PCI device.
  *
- * Ask the platform to refresh the devices power state information and invoke
- * pci_update_current_state() to update its current PCI power state.
+ * Use ACPI (if available) to refresh the devices power state information and
+ * invoke pci_update_current_state() to update its current PCI power state.
  */
 void pci_refresh_power_state(struct pci_dev *dev)
 {
-	if (platform_pci_power_manageable(dev))
-		platform_pci_refresh_power_state(dev);
+	if (acpi_pci_power_manageable(dev))
+		acpi_pci_refresh_power_state(dev);
 
 	pci_update_current_state(dev, dev->current_state);
 }
 
 /**
- * pci_platform_power_transition - Use platform to change device power state
+ * pci_platform_power_transition - Use ACPI to change device power state
  * @dev: PCI device to handle.
  * @state: State to put the device into.
  */
@@ -1200,8 +1143,8 @@ int pci_platform_power_transition(struct
 {
 	int error;
 
-	if (platform_pci_power_manageable(dev)) {
-		error = platform_pci_set_power_state(dev, state);
+	if (acpi_pci_power_manageable(dev)) {
+		error = acpi_pci_set_power_state(dev, state);
 		if (!error)
 			pci_update_current_state(dev, state);
 	} else
@@ -1404,7 +1347,7 @@ pci_power_t pci_choose_state(struct pci_
 	if (!dev->pm_cap)
 		return PCI_D0;
 
-	ret = platform_pci_choose_state(dev);
+	ret = acpi_pci_choose_state(dev);
 	if (ret != PCI_POWER_ERROR)
 		return ret;
 
@@ -2512,13 +2455,13 @@ static int __pci_enable_wake(struct pci_
 			pci_pme_active(dev, true);
 		else
 			ret = 1;
-		error = platform_pci_set_wakeup(dev, true);
+		error = acpi_pci_wakeup(dev, true);
 		if (ret)
 			ret = error;
 		if (!ret)
 			dev->wakeup_prepared = true;
 	} else {
-		platform_pci_set_wakeup(dev, false);
+		acpi_pci_wakeup(dev, false);
 		pci_pme_active(dev, false);
 		dev->wakeup_prepared = false;
 	}
@@ -2571,19 +2514,21 @@ EXPORT_SYMBOL(pci_wake_from_d3);
  * @dev: PCI device
  * @wakeup: Whether or not wakeup functionality will be enabled for the device.
  *
- * Use underlying platform code to find a supported low power state for @dev.
- * If the platform can't manage @dev, return the deepest state from which it
- * can generate wake events, based on any available PME info.
+ * Use ACPI (if available) to find a supported low power state for @dev.  If
+ * ACPI cannot manage PM for @dev, return the deepest state from which it can
+ * generate wake events, based on any available PME info.
  */
 static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 {
 	pci_power_t target_state = PCI_D3hot;
 
-	if (platform_pci_power_manageable(dev)) {
+	if (acpi_pci_power_manageable(dev)) {
 		/*
-		 * Call the platform to find the target state for the device.
+		 * Use ACPI to find the target state for the device.  If it
+		 * cannot do that or the power state returned by it cannot be
+		 * used, return D3hot.
 		 */
-		pci_power_t state = platform_pci_choose_state(dev);
+		pci_power_t state = acpi_pci_choose_state(dev);
 
 		switch (state) {
 		case PCI_POWER_ERROR:
@@ -2780,13 +2725,13 @@ bool pci_dev_need_resume(struct pci_dev
 	struct device *dev = &pci_dev->dev;
 	pci_power_t target_state;
 
-	if (!pm_runtime_suspended(dev) || platform_pci_need_resume(pci_dev))
+	if (!pm_runtime_suspended(dev) || acpi_pci_need_resume(pci_dev))
 		return true;
 
 	target_state = pci_target_state(pci_dev, device_may_wakeup(dev));
 
 	/*
-	 * If the earlier platform check has not triggered, D3cold is just power
+	 * If the earlier ACPI check has not triggered, D3cold is just power
 	 * removal on top of D3hot, so no need to resume the device in that
 	 * case.
 	 */
@@ -2927,7 +2872,7 @@ bool pci_bridge_d3_possible(struct pci_d
 			return true;
 
 		/* Platform might know better if the bridge supports D3 */
-		if (platform_pci_bridge_d3(bridge))
+		if (acpi_pci_bridge_d3(bridge))
 			return true;
 
 		/*
Index: linux-pm/drivers/pci/pci.h
===================================================================
--- linux-pm.orig/drivers/pci/pci.h
+++ linux-pm/drivers/pci/pci.h
@@ -63,45 +63,6 @@ struct pci_cap_saved_state *pci_find_sav
 #define PCI_PM_D3HOT_WAIT       10	/* msec */
 #define PCI_PM_D3COLD_WAIT      100	/* msec */
 
-/**
- * struct pci_platform_pm_ops - Firmware PM callbacks
- *
- * @bridge_d3: Does the bridge allow entering into D3
- *
- * @is_manageable: returns 'true' if given device is power manageable by the
- *		   platform firmware
- *
- * @set_state: invokes the platform firmware to set the device's power state
- *
- * @get_state: queries the platform firmware for a device's current power state
- *
- * @refresh_state: asks the platform to refresh the device's power state data
- *
- * @choose_state: returns PCI power state of given device preferred by the
- *		  platform; to be used during system-wide transitions from a
- *		  sleeping state to the working state and vice versa
- *
- * @set_wakeup: enables/disables wakeup capability for the device
- *
- * @need_resume: returns 'true' if the given device (which is currently
- *		 suspended) needs to be resumed to be configured for system
- *		 wakeup.
- *
- * If given platform is generally capable of power managing PCI devices, all of
- * these callbacks are mandatory.
- */
-struct pci_platform_pm_ops {
-	bool (*bridge_d3)(struct pci_dev *dev);
-	bool (*is_manageable)(struct pci_dev *dev);
-	int (*set_state)(struct pci_dev *dev, pci_power_t state);
-	pci_power_t (*get_state)(struct pci_dev *dev);
-	void (*refresh_state)(struct pci_dev *dev);
-	pci_power_t (*choose_state)(struct pci_dev *dev);
-	int (*set_wakeup)(struct pci_dev *dev, bool enable);
-	bool (*need_resume)(struct pci_dev *dev);
-};
-
-int pci_set_platform_pm(const struct pci_platform_pm_ops *ops);
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
 void pci_refresh_power_state(struct pci_dev *dev);
 int pci_power_up(struct pci_dev *dev);
@@ -725,17 +686,53 @@ int pci_acpi_program_hp_params(struct pc
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



