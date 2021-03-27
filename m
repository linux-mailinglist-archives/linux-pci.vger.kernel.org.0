Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9189334B4C9
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 07:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhC0GoY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 02:44:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15333 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhC0GoE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 02:44:04 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F6q4m0zjRz93nT;
        Sat, 27 Mar 2021 14:41:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 14:43:37 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <rui.zhang@intel.com>,
        <bhelgaas@google.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH 09/15] ACPI: battery: fix some coding style issues
Date:   Sat, 27 Mar 2021 14:40:50 +0800
Message-ID: <1616827256-51840-10-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616827256-51840-1-git-send-email-tanxiaofei@huawei.com>
References: <1616827256-51840-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix some coding style issues reported by checkpatch.pl, including
following types:

WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line
ERROR: code indent should use tabs where possible
WARNING: Missing a blank line after declarations
ERROR: spaces required around that '?' (ctx:WxV)
WARNING: Block comments should align the * on each line

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/battery.c | 64 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b822f77..a0d8ead 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -74,16 +74,17 @@ enum {
 	ACPI_BATTERY_XINFO_PRESENT,
 	ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY,
 	/* On Lenovo Thinkpad models from 2010 and 2011, the power unit
-	   switches between mWh and mAh depending on whether the system
-	   is running on battery or not.  When mAh is the unit, most
-	   reported values are incorrect and need to be adjusted by
-	   10000/design_voltage.  Verified on x201, t410, t410s, and x220.
-	   Pre-2010 and 2012 models appear to always report in mWh and
-	   are thus unaffected (tested with t42, t61, t500, x200, x300,
-	   and x230).  Also, in mid-2012 Lenovo issued a BIOS update for
-	   the 2011 models that fixes the issue (tested on x220 with a
-	   post-1.29 BIOS), but as of Nov. 2012, no such update is
-	   available for the 2010 models.  */
+	 * switches between mWh and mAh depending on whether the system
+	 * is running on battery or not.  When mAh is the unit, most
+	 * reported values are incorrect and need to be adjusted by
+	 * 10000/design_voltage.  Verified on x201, t410, t410s, and x220.
+	 * Pre-2010 and 2012 models appear to always report in mWh and
+	 * are thus unaffected (tested with t42, t61, t500, x200, x300,
+	 * and x230).  Also, in mid-2012 Lenovo issued a BIOS update for
+	 *  the 2011 models that fixes the issue (tested on x220 with a
+	 * post-1.29 BIOS), but as of Nov. 2012, no such update is
+	 * available for the 2010 models.
+	 */
 	ACPI_BATTERY_QUIRK_THINKPAD_MAH,
 	/* for batteries reporting current capacity with design capacity
 	 * on a full charge, but showing degradation in full charge cap.
@@ -372,8 +373,9 @@ static enum power_supply_property energy_battery_full_cap_broken_props[] = {
 };
 
 /* --------------------------------------------------------------------------
-                               Battery Management
-   -------------------------------------------------------------------------- */
+ *				Battery Management
+ * --------------------------------------------------------------------------
+ */
 struct acpi_offsets {
 	size_t offset;		/* offset inside struct acpi_sbs_battery */
 	u8 mode;		/* int or string? */
@@ -431,6 +433,7 @@ static int extract_package(struct acpi_battery *battery,
 {
 	int i;
 	union acpi_object *element;
+
 	if (package->type != ACPI_TYPE_PACKAGE)
 		return -EFAULT;
 	for (i = 0; i < num; ++i) {
@@ -439,6 +442,7 @@ static int extract_package(struct acpi_battery *battery,
 		element = &package->package.elements[i];
 		if (offsets[i].mode) {
 			u8 *ptr = (u8 *)battery + offsets[i].offset;
+
 			if (element->type == ACPI_TYPE_STRING ||
 			    element->type == ACPI_TYPE_BUFFER)
 				strncpy(ptr, element->string.pointer, 32);
@@ -497,10 +501,12 @@ static int extract_battery_info(const int use_bix,
 		    battery->design_capacity_warning *
 		    10000 / battery->design_voltage;
 		/* Curiously, design_capacity_low, unlike the rest of them,
-		   is correct.  */
+		 *  is correct.
+		 */
 		/* capacity_granularity_* equal 1 on the systems tested, so
-		   it's impossible to tell if they would need an adjustment
-		   or not if their values were higher.  */
+		 * it's impossible to tell if they would need an adjustment
+		 * or not if their values were higher.
+		 */
 	}
 	if (test_bit(ACPI_BATTERY_QUIRK_DEGRADED_FULL_CHARGE, &battery->flags) &&
 	    battery->capacity_now > battery->full_charge_capacity)
@@ -532,8 +538,8 @@ static int acpi_battery_get_info(struct acpi_battery *battery)
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_info(battery->device->handle,
 					 "%s evaluation failed: %s\n",
-					 use_bix ?"_BIX":"_BIF",
-				         acpi_format_exception(status));
+					 use_bix ? "_BIX":"_BIF",
+					 acpi_format_exception(status));
 		} else {
 			result = extract_battery_info(use_bix,
 						      battery,
@@ -648,6 +654,7 @@ static ssize_t acpi_battery_alarm_show(struct device *dev,
 					char *buf)
 {
 	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
+
 	return sprintf(buf, "%d\n", battery->alarm * 1000);
 }
 
@@ -657,6 +664,7 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
 {
 	unsigned long x;
 	struct acpi_battery *battery = to_acpi_battery(dev_get_drvdata(dev));
+
 	if (sscanf(buf, "%lu\n", &x) == 1)
 		battery->alarm = x/1000;
 	if (acpi_battery_present(battery))
@@ -743,7 +751,7 @@ EXPORT_SYMBOL_GPL(battery_hook_register);
  * This function gets called right after the battery sysfs
  * attributes have been added, so that the drivers that
  * define custom sysfs attributes can add their own.
-*/
+ */
 static void battery_hook_add_battery(struct acpi_battery *battery)
 {
 	struct acpi_battery_hook *hook_node, *tmp;
@@ -872,10 +880,12 @@ static void find_battery(const struct dmi_header *dm, void *private)
 {
 	struct acpi_battery *battery = (struct acpi_battery *)private;
 	/* Note: the hardcoded offsets below have been extracted from
-	   the source code of dmidecode.  */
+	 * the source code of dmidecode.
+	 */
 	if (dm->type == DMI_ENTRY_PORTABLE_BATTERY && dm->length >= 8) {
 		const u8 *dmi_data = (const u8 *)(dm + 1);
 		int dmi_capacity = get_unaligned((const u16 *)(dmi_data + 6));
+
 		if (dm->length >= 18)
 			dmi_capacity *= dmi_data[17];
 		if (battery->design_capacity * battery->design_voltage / 1000
@@ -917,6 +927,7 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
 
 	if (battery->power_unit && dmi_name_in_vendors("LENOVO")) {
 		const char *s;
+
 		s = dmi_get_system_info(DMI_PRODUCT_VERSION);
 		if (s && !strncasecmp(s, "ThinkPad", 8)) {
 			dmi_walk(find_battery, battery);
@@ -1014,8 +1025,9 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
 }
 
 /* --------------------------------------------------------------------------
-                                 Driver Interface
-   -------------------------------------------------------------------------- */
+ *				Driver Interface
+ * --------------------------------------------------------------------------
+ */
 
 static void acpi_battery_notify(struct acpi_device *device, u32 event)
 {
@@ -1026,11 +1038,11 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
 		return;
 	old = battery->bat;
 	/*
-	* On Acer Aspire V5-573G notifications are sometimes triggered too
-	* early. For example, when AC is unplugged and notification is
-	* triggered, battery state is still reported as "Full", and changes to
-	* "Discharging" only after short delay, without any notification.
-	*/
+	 * On Acer Aspire V5-573G notifications are sometimes triggered too
+	 * early. For example, when AC is unplugged and notification is
+	 * triggered, battery state is still reported as "Full", and changes to
+	 * "Discharging" only after short delay, without any notification.
+	 */
 	if (battery_notification_delay_ms > 0)
 		msleep(battery_notification_delay_ms);
 	if (event == ACPI_BATTERY_NOTIFY_INFO)
-- 
2.8.1

