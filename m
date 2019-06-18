Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C114A6A3
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 18:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfFRQTF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 12:19:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:30536 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbfFRQTE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Jun 2019 12:19:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 09:19:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,389,1557212400"; 
   d="scan'208";a="357908920"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2019 09:18:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8A7D6179; Tue, 18 Jun 2019 19:18:58 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 2/3] ACPI / PM: Introduce concept of a _PR0 dependent device
Date:   Tue, 18 Jun 2019 19:18:57 +0300
Message-Id: <20190618161858.77834-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If there are shared power resources between otherwise unrelated devices
turning them on causes the other devices sharing them to be powered up
as well. In case of PCI devices go into D0uninitialized state meaning
that if they were configured to trigger wake that configuration is lost
at this point.

For this reason introduce a concept of "_PR0 dependent device" that can
be added to any ACPI device that has power resources. The dependent
device will be included in a list of dependent devices for all power
resources returned by the ACPI device's _PR0 (assuming it has one).
Whenever a power resource having dependent devices is turned physically
on (its _ON method is called) we runtime resume all of them to allow
their driver or in case of PCI the PCI core to re-initialize the device
and its wake configuration.

This adds two functions that can be used to add and remove these
dependent devices. Note the dependent device does not necessary need
share power resources so this functionality can be used to add "software
dependencies" as well if needed.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/power.c    | 139 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |   4 ++
 2 files changed, 143 insertions(+)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index a916417b9e70..76d298192940 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -42,6 +42,11 @@ ACPI_MODULE_NAME("power");
 #define ACPI_POWER_RESOURCE_STATE_ON	0x01
 #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
 
+struct acpi_power_dependent_device {
+	struct device *dev;
+	struct list_head node;
+};
+
 struct acpi_power_resource {
 	struct acpi_device device;
 	struct list_head list_node;
@@ -51,6 +56,7 @@ struct acpi_power_resource {
 	unsigned int ref_count;
 	bool wakeup_enabled;
 	struct mutex resource_lock;
+	struct list_head dependents;
 };
 
 struct acpi_power_resource_entry {
@@ -232,8 +238,125 @@ static int acpi_power_get_list_state(struct list_head *list, int *state)
 	return 0;
 }
 
+static int
+acpi_power_resource_add_dependent(struct acpi_power_resource *resource,
+				  struct device *dev)
+{
+	struct acpi_power_dependent_device *dep;
+	int ret = 0;
+
+	mutex_lock(&resource->resource_lock);
+	list_for_each_entry(dep, &resource->dependents, node) {
+		/* Only add it once */
+		if (dep->dev == dev)
+			goto unlock;
+	}
+
+	dep = kzalloc(sizeof(*dep), GFP_KERNEL);
+	if (!dep) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	dep->dev = dev;
+	list_add_tail(&dep->node, &resource->dependents);
+	dev_dbg(dev, "added power dependency to [%s]\n", resource->name);
+
+unlock:
+	mutex_unlock(&resource->resource_lock);
+	return ret;
+}
+
+static void
+acpi_power_resource_remove_dependent(struct acpi_power_resource *resource,
+				     struct device *dev)
+{
+	struct acpi_power_dependent_device *dep;
+
+	mutex_lock(&resource->resource_lock);
+	list_for_each_entry(dep, &resource->dependents, node) {
+		if (dep->dev == dev) {
+			list_del(&dep->node);
+			kfree(dep);
+			dev_dbg(dev, "removed power dependency to [%s]\n",
+				resource->name);
+			break;
+		}
+	}
+	mutex_unlock(&resource->resource_lock);
+}
+
+/**
+ * acpi_device_power_add_dependent - Add dependent device of this ACPI device
+ * @adev: ACPI device pointer
+ * @dev: Dependent device
+ *
+ * If @adev has non-empty _PR0 the @dev is added as dependent device to all
+ * power resources returned by it. This means that whenever these power
+ * resources are turned _ON the dependent devices get runtime resumed. This
+ * is needed for devices such as PCI to allow its driver to re-initialize
+ * it after it went to D0uninitialized.
+ *
+ * If @adev does not have _PR0 this does nothing.
+ *
+ * Returns %0 in case of success and negative errno otherwise.
+ */
+int acpi_device_power_add_dependent(struct acpi_device *adev,
+				    struct device *dev)
+{
+	struct acpi_power_resource_entry *entry;
+	struct list_head *resources;
+	int ret;
+
+	if (!adev->power.flags.power_resources)
+		return 0;
+	if (!adev->power.states[ACPI_STATE_D0].flags.valid)
+		return 0;
+
+	resources = &adev->power.states[ACPI_STATE_D0].resources;
+	list_for_each_entry(entry, resources, node) {
+		ret = acpi_power_resource_add_dependent(entry->resource, dev);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	list_for_each_entry(entry, resources, node)
+		acpi_power_resource_remove_dependent(entry->resource, dev);
+
+	return ret;
+}
+
+/**
+ * acpi_device_power_remove_dependent - Remove dependent device
+ * @adev: ACPI device pointer
+ * @dev: Dependent device
+ *
+ * Does the opposite of acpi_device_power_add_dependent() and removes the
+ * dependent device if it is found. Can be called to @adev that does not
+ * have _PR0 as well.
+ */
+void acpi_device_power_remove_dependent(struct acpi_device *adev,
+					struct device *dev)
+{
+	struct acpi_power_resource_entry *entry;
+	struct list_head *resources;
+
+	if (!adev->power.flags.power_resources)
+		return;
+	if (!adev->power.states[ACPI_STATE_D0].flags.valid)
+		return;
+
+	resources = &adev->power.states[ACPI_STATE_D0].resources;
+	list_for_each_entry_reverse(entry, resources, node)
+		acpi_power_resource_remove_dependent(entry->resource, dev);
+}
+
 static int __acpi_power_on(struct acpi_power_resource *resource)
 {
+	struct acpi_power_dependent_device *dep;
 	acpi_status status = AE_OK;
 
 	status = acpi_evaluate_object(resource->device.handle, "_ON", NULL, NULL);
@@ -243,6 +366,21 @@ static int __acpi_power_on(struct acpi_power_resource *resource)
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Power resource [%s] turned on\n",
 			  resource->name));
 
+	/*
+	 * If there are other dependents on this power resource we need to
+	 * resume them now so that their drivers can re-initialize the
+	 * hardware properly after it went back to D0.
+	 */
+	if (list_empty(&resource->dependents) ||
+	    list_is_singular(&resource->dependents))
+		return 0;
+
+	list_for_each_entry(dep, &resource->dependents, node) {
+		dev_dbg(dep->dev, "runtime resuming because [%s] turned on\n",
+			resource->name);
+		pm_request_resume(dep->dev);
+	}
+
 	return 0;
 }
 
@@ -810,6 +948,7 @@ int acpi_add_power_resource(acpi_handle handle)
 				ACPI_STA_DEFAULT);
 	mutex_init(&resource->resource_lock);
 	INIT_LIST_HEAD(&resource->list_node);
+	INIT_LIST_HEAD(&resource->dependents);
 	resource->name = device->pnp.bus_id;
 	strcpy(acpi_device_name(device), ACPI_POWER_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_POWER_CLASS);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 31b6c87d6240..4752ff0a9d9b 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -513,6 +513,10 @@ int acpi_device_fix_up_power(struct acpi_device *device);
 int acpi_bus_update_power(acpi_handle handle, int *state_p);
 int acpi_device_update_power(struct acpi_device *device, int *state_p);
 bool acpi_bus_power_manageable(acpi_handle handle);
+int acpi_device_power_add_dependent(struct acpi_device *adev,
+				    struct device *dev);
+void acpi_device_power_remove_dependent(struct acpi_device *adev,
+					struct device *dev);
 
 #ifdef CONFIG_PM
 bool acpi_bus_can_wakeup(acpi_handle handle);
-- 
2.20.1

