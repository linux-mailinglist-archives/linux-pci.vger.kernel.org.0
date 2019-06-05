Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B61E35FBD
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2019 16:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfFEO60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jun 2019 10:58:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:27458 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbfFEO60 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jun 2019 10:58:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 07:58:25 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 05 Jun 2019 07:58:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 61E854E1; Wed,  5 Jun 2019 17:58:21 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 3/3] PCI / ACPI: Handle sibling devices sharing power resources
Date:   Wed,  5 Jun 2019 17:58:20 +0300
Message-Id: <20190605145820.37169-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605145820.37169-1-mika.westerberg@linux.intel.com>
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel Ice Lake has an interated Thunderbolt controller which means that
the PCIe topology is extended directly from the two root ports (RP0 and
RP1). Power management is handled by ACPI power resources that are
shared between the root ports, Thunderbolt controller (NHI) and xHCI
controller.

The topology with the power resources (marked with []) looks like:

  Host bridge
      |
      +- RP0 ---\
      +- RP1 ---|--+--> [TBT]
      +- NHI --/   |
      |            |
      |            v
      +- xHCI --> [D3C]

Here TBT and D3C are the shared ACPI power resources. ACPI _PR3() method
returns either TBT or D3C or both.

Say we runtime suspend first the root ports RP0 and RP1, then NHI. Now
since the TBT power resource is still on when the root ports are runtime
suspended their dev->current_state is set to D3hot. When NHI is runtime
suspended TBT is finally turned off but state of the root ports remain
to be D3hot.

If the user now runs lspci for instance, the result is all 1's like in
the below output (07.0 is the first root port, RP0):

  # lspci -vv -s 07.0
  00:07.0 PCI bridge: Intel Corporation Device 8a1d (rev ff) (prog-if ff)
  	!!! Unknown header type 7f
  	Kernel driver in use: pcieport

I short the hardware state is not in sync with the software state
anymore. The exact same thing happens with the PME polling thread which
ends up bringing the root ports back into D0 after they are runtime
suspended.

There is another issue that happens when the power resource(s) are
turned on. Assume the Thunderbolt controller is runtime resumed and the
power resources are turned on which means that the other devices sharing
them (RP0, RP1 and xHCI) are transitioned into D0uninitialized state. If
they were configured to trigger wake (PME) on certain event that
configuration gets lost after reset so we would need to re-initialize
them to get the wakeup working as expected again. This means that we
would need to runtime resume all of them to make sure their registers
get restored properly before we can runtime suspend them again.

Prevent this from happening by asking from the platform (ACPI) if there
are other devices sharing the same power source when device power is
turned on/off through platform. If we find such devices we update their
dev->current_state (in case of D3hot -> D3cold transition) or runtime
resume them (in case of D3cold -> D0uninitialized).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/power.c    |  32 ++++++++++++
 drivers/pci/pci-acpi.c  |  32 ++++++++++--
 drivers/pci/pci.c       | 106 ++++++++++++++++++++++++++++++----------
 drivers/pci/pci.h       |   5 ++
 include/acpi/acpi_bus.h |   3 ++
 5 files changed, 146 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index a916417b9e70..9d244fde05a4 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -739,6 +739,38 @@ int acpi_power_transition(struct acpi_device *device, int state)
 	return result;
 }
 
+/**
+ * acpi_shared_power_resource - Do given devices share power resource
+ * @adev1: First device to check
+ * @adev2: Second device to check
+ * @state: State which power resources are looked
+ *
+ * Checks if given devices share one or more power resources and in that
+ * case returns true.
+ */
+bool acpi_shared_power_resource(struct acpi_device *adev1, struct acpi_device *adev2,
+				int state)
+{
+	struct acpi_power_resource_entry *e1, *e2;
+	struct list_head *l1, *l2;
+
+	/* Both need to have power resources */
+	if (!adev1->power.flags.power_resources ||
+	    !adev2->power.flags.power_resources)
+		return false;
+
+	l1 = &adev1->power.states[state].resources;
+	l2 = &adev2->power.states[state].resources;
+
+	list_for_each_entry(e1, l1, node)
+		list_for_each_entry(e2, l2, node) {
+			if (e1->resource == e2->resource)
+				return true;
+		}
+
+	return false;
+}
+
 static void acpi_release_power_resource(struct device *dev)
 {
 	struct acpi_device *device = to_acpi_device(dev);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1897847ceb0c..39112e684403 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -632,16 +632,23 @@ static bool acpi_pci_power_manageable(struct pci_dev *dev)
 	return adev ? acpi_device_power_manageable(adev) : false;
 }
 
-static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+static const u8 pci_power_to_acpi(pci_power_t state)
 {
-	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
-	static const u8 state_conv[] = {
+	static const int state_conv[] = {
 		[PCI_D0] = ACPI_STATE_D0,
 		[PCI_D1] = ACPI_STATE_D1,
 		[PCI_D2] = ACPI_STATE_D2,
 		[PCI_D3hot] = ACPI_STATE_D3_HOT,
 		[PCI_D3cold] = ACPI_STATE_D3_COLD,
 	};
+
+	return state_conv[state];
+}
+
+static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
+	int acpi_state = pci_power_to_acpi(state);
 	int error = -EINVAL;
 
 	/* If the ACPI device has _EJ0, ignore the device */
@@ -660,12 +667,12 @@ static int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 	case PCI_D1:
 	case PCI_D2:
 	case PCI_D3hot:
-		error = acpi_device_set_power(adev, state_conv[state]);
+		error = acpi_device_set_power(adev, acpi_state);
 	}
 
 	if (!error)
 		pci_dbg(dev, "power state changed by ACPI to %s\n",
-			 acpi_power_state_string(state_conv[state]));
+			 acpi_power_state_string(acpi_state));
 
 	return error;
 }
@@ -743,6 +750,20 @@ static bool acpi_pci_need_resume(struct pci_dev *dev)
 	return !!adev->power.flags.dsw_present;
 }
 
+static bool acpi_pci_shared_power(struct pci_dev *dev1, struct pci_dev *dev2,
+				  pci_power_t state)
+{
+	struct acpi_device *adev1 = ACPI_COMPANION(&dev1->dev);
+	struct acpi_device *adev2 = ACPI_COMPANION(&dev2->dev);
+
+	if (!adev1 || !acpi_device_power_manageable(adev1))
+		return false;
+	if (!adev2 || !acpi_device_power_manageable(adev2))
+		return false;
+
+	return acpi_shared_power_resource(adev1, adev2, pci_power_to_acpi(state));
+}
+
 static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
 	.bridge_d3 = acpi_pci_bridge_d3,
 	.is_manageable = acpi_pci_power_manageable,
@@ -751,6 +772,7 @@ static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
 	.choose_state = acpi_pci_choose_state,
 	.set_wakeup = acpi_pci_wakeup,
 	.need_resume = acpi_pci_need_resume,
+	.shared_power = acpi_pci_shared_power,
 };
 
 void acpi_pci_add_bus(struct pci_bus *bus)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 720da09d4d73..224689116df3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -755,7 +755,8 @@ static const struct pci_platform_pm_ops *pci_platform_pm;
 int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
 {
 	if (!ops->is_manageable || !ops->set_state  || !ops->get_state ||
-	    !ops->choose_state  || !ops->set_wakeup || !ops->need_resume)
+	    !ops->choose_state  || !ops->set_wakeup || !ops->need_resume ||
+	    !ops->bridge_d3 || !ops->shared_power)
 		return -EINVAL;
 	pci_platform_pm = ops;
 	return 0;
@@ -799,6 +800,12 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
 }
 
+static inline bool platform_pci_shared_power(struct pci_dev *dev1, struct pci_dev *dev2,
+					     pci_power_t t)
+{
+	return pci_platform_pm ? pci_platform_pm->shared_power(dev1, dev2, t) : false;
+}
+
 /**
  * pci_raw_set_power_state - Use PCI PM registers to set the power state of
  *			     given PCI device
@@ -994,31 +1001,6 @@ void pci_wakeup_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_wakeup, NULL);
 }
 
-/**
- * __pci_start_power_transition - Start power transition of a PCI device
- * @dev: PCI device to handle.
- * @state: State to put the device into.
- */
-static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
-{
-	if (state == PCI_D0) {
-		pci_platform_power_transition(dev, PCI_D0);
-		/*
-		 * Mandatory power management transition delays are
-		 * handled in the PCIe portdrv resume hooks.
-		 */
-		if (dev->runtime_d3cold) {
-			/*
-			 * When powering on a bridge from D3cold, the
-			 * whole hierarchy may be powered on into
-			 * D0uninitialized state, resume them to give
-			 * them a chance to suspend again
-			 */
-			pci_wakeup_bus(dev->subordinate);
-		}
-	}
-}
-
 /**
  * __pci_dev_set_current_state - Set current state of a PCI device
  * @dev: Device to handle
@@ -1043,6 +1025,76 @@ void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state)
 		pci_walk_bus(bus, __pci_dev_set_current_state, &state);
 }
 
+
+static void pci_update_topology_power_state(struct pci_dev *dev, pci_power_t state)
+{
+	struct pci_dev *p = NULL;
+
+	if (!platform_pci_power_manageable(dev))
+		return;
+
+	if (state == PCI_D3cold) {
+		/* The topology below is in D3cold as well */
+		pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
+		/*
+		 * Find other devices that were in PCI_D3hot and now are in
+		 * D3cold that share the power resource.
+		 */
+		for_each_pci_dev(p) {
+			if (p == dev || !platform_pci_power_manageable(p))
+				continue;
+
+			if (platform_pci_shared_power(dev, p, PCI_D3hot) &&
+			    p->current_state == PCI_D3hot &&
+			    platform_pci_get_power_state(p) == PCI_D3cold) {
+				dev_dbg(&p->dev,
+					"transition into D3cold because power turned off\n");
+				p->current_state = PCI_D3cold;
+				pci_bus_set_current_state(p->subordinate, PCI_D3cold);
+			}
+		}
+	} else if (state == PCI_D0) {
+		/*
+		 * When powering on a bridge from D3cold, the whole
+		 * hierarchy may be powered on into D0uninitialized state,
+		 * resume them to give them a chance to suspend again.
+		 */
+		pci_wakeup_bus(dev->subordinate);
+		/*
+		 * Find other devices that were in PCI_D3cold and now are
+		 * in D0uninitialized because of the shared power resource
+		 * and resume them now so that they get properly
+		 * re-initialized.
+		 */
+		for_each_pci_dev(p) {
+			if (p == dev || !platform_pci_power_manageable(p))
+				continue;
+
+			if (platform_pci_shared_power(dev, p, PCI_D0) &&
+			    p->current_state == PCI_D3cold &&
+			    platform_pci_get_power_state(p) == PCI_D0) {
+				dev_dbg(&p->dev, "waking up because power turned on\n");
+				pci_wakeup(p, NULL);
+				pci_wakeup_bus(p->subordinate);
+			}
+		}
+	}
+}
+
+/**
+ * __pci_start_power_transition - Start power transition of a PCI device
+ * @dev: PCI device to handle.
+ * @state: State to put the device into.
+ */
+static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
+{
+	if (state == PCI_D0) {
+		pci_platform_power_transition(dev, PCI_D0);
+		if (dev->runtime_d3cold)
+			pci_update_topology_power_state(dev, PCI_D0);
+	}
+}
+
 /**
  * __pci_complete_power_transition - Complete power transition of a PCI device
  * @dev: PCI device to handle.
@@ -1059,7 +1111,7 @@ int __pci_complete_power_transition(struct pci_dev *dev, pci_power_t state)
 	ret = pci_platform_power_transition(dev, state);
 	/* Power off the bridge may power off the whole hierarchy */
 	if (!ret && state == PCI_D3cold)
-		pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
+		pci_update_topology_power_state(dev, PCI_D3cold);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__pci_complete_power_transition);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 59802b3def4b..855c9a2f3079 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -61,6 +61,9 @@ int pci_bus_error_reset(struct pci_dev *dev);
  *		 suspended) needs to be resumed to be configured for system
  *		 wakeup.
  *
+ * @shared_power: Returns 'true' if the two PCI devices share power source
+ *		  such as ACPI power resource.
+ *
  * If given platform is generally capable of power managing PCI devices, all of
  * these callbacks are mandatory.
  */
@@ -72,6 +75,8 @@ struct pci_platform_pm_ops {
 	pci_power_t (*choose_state)(struct pci_dev *dev);
 	int (*set_wakeup)(struct pci_dev *dev, bool enable);
 	bool (*need_resume)(struct pci_dev *dev);
+	bool (*shared_power)(struct pci_dev *dev1, struct pci_dev *dev2,
+			     pci_power_t state);
 };
 
 int pci_set_platform_pm(const struct pci_platform_pm_ops *ops);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 31b6c87d6240..d70dbbdb5164 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -597,6 +597,9 @@ struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle);
 int acpi_enable_wakeup_device_power(struct acpi_device *dev, int state);
 int acpi_disable_wakeup_device_power(struct acpi_device *dev);
 
+bool acpi_shared_power_resource(struct acpi_device *adev1,
+				struct acpi_device *adev2, int state);
+
 #ifdef CONFIG_X86
 bool acpi_device_always_present(struct acpi_device *adev);
 #else
-- 
2.20.1

