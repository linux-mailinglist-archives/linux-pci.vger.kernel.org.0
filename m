Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C274301BD
	for <lists+linux-pci@lfdr.de>; Sat, 16 Oct 2021 12:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbhJPKNT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Oct 2021 06:13:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53658 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbhJPKNT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Oct 2021 06:13:19 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id 78e70f4d00fd6bb1; Sat, 16 Oct 2021 12:11:09 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 28C0766A73A;
        Sat, 16 Oct 2021 12:11:09 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH v2 2/3] ACPI: PM: Fix sharing of wakeup power resources
Date:   Sat, 16 Oct 2021 12:11:08 +0200
Message-ID: <11874779.O9o76ZdvQC@kreacher>
In-Reply-To: <2077987.irdbgypaU6@kreacher>
References: <4347933.LvFx2qVVIh@kreacher> <2077987.irdbgypaU6@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvdduiedgvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdejjedrhedurdekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrjeejrdehuddrkeegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhp
 tghisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If an ACPI wakeup power resource is shared between multiple devices,
it may not be managed correctly.

Suppose, for example, that two devices, A and B, share a wakeup power
resource P whose wakeup_enabled flag is 0 initially.  Next, suppose
that wakeup power is enabled for A and B, in this order, and disabled
for B.  When wakeup power is enabled for A, P will be turned on and
its wakeup_enabled flag will be set.  Next, when wakeup power is
enabled for B, P will not be touched, because its wakeup_enabled flag
is set.  Now, when wakeup power is disabled for B, P will be turned
off which is incorrect, because A will still need P in order to signal
wakeup.

Moreover, if wakeup power is enabled for A and then disabled for B,
the latter will cause P to be turned off incorrectly (it will be still
needed by A), because acpi_disable_wakeup_device_power() is allowed
to manipulate power resources when the wakeup.prepare_count counter
of the given device is 0.

While the first issue could be addressed by changing the
wakeup_enabled power resource flag into a counter, addressing the
second one requires modifying acpi_disable_wakeup_device_power() to
do nothing when the target device's wakeup.prepare_count reference
counter is zero and that would cause the new counter to be redundant.
Namely, if acpi_disable_wakeup_device_power() is modified as per the
above, every change of the new counter following a wakeup.prepare_count
change would be reflected by the analogous change of the main reference
counter of the given power resource.

Accordingly, modify acpi_disable_wakeup_device_power() to do nothing
when the target device's wakeup.prepare_count reference counter is
zero and drop the power resource wakeup_enabled flag altogether.

While at it, ensure that all of the power resources that can be
turned off will be turned off when disabling device wakeup due to
a power resource manipulation error, to prevent energy from being
wasted.

Fixes: b5d667eb392e ("ACPI / PM: Take unusual configurations of power resources into account")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Restore the initialization of err in two places removed by v1 by mistake.

---
 drivers/acpi/power.c |   69 +++++++++++++++++----------------------------------
 1 file changed, 24 insertions(+), 45 deletions(-)

Index: linux-pm/drivers/acpi/power.c
===================================================================
--- linux-pm.orig/drivers/acpi/power.c
+++ linux-pm/drivers/acpi/power.c
@@ -52,7 +52,6 @@ struct acpi_power_resource {
 	u32 order;
 	unsigned int ref_count;
 	u8 state;
-	bool wakeup_enabled;
 	struct mutex resource_lock;
 	struct list_head dependents;
 };
@@ -710,7 +709,6 @@ int acpi_device_sleep_wake(struct acpi_d
  */
 int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state)
 {
-	struct acpi_power_resource_entry *entry;
 	int err = 0;
 
 	if (!dev || !dev->wakeup.flags.valid)
@@ -721,26 +719,13 @@ int acpi_enable_wakeup_device_power(stru
 	if (dev->wakeup.prepare_count++)
 		goto out;
 
-	list_for_each_entry(entry, &dev->wakeup.resources, node) {
-		struct acpi_power_resource *resource = entry->resource;
-
-		mutex_lock(&resource->resource_lock);
-
-		if (!resource->wakeup_enabled) {
-			err = acpi_power_on_unlocked(resource);
-			if (!err)
-				resource->wakeup_enabled = true;
-		}
-
-		mutex_unlock(&resource->resource_lock);
-
-		if (err) {
-			dev_err(&dev->dev,
-				"Cannot turn wakeup power resources on\n");
-			dev->wakeup.flags.valid = 0;
-			goto out;
-		}
+	err = acpi_power_on_list(&dev->wakeup.resources);
+	if (err) {
+		dev_err(&dev->dev, "Cannot turn on wakeup power resources\n");
+		dev->wakeup.flags.valid = 0;
+		goto out;
 	}
+
 	/*
 	 * Passing 3 as the third argument below means the device may be
 	 * put into arbitrary power state afterward.
@@ -770,39 +755,33 @@ int acpi_disable_wakeup_device_power(str
 
 	mutex_lock(&acpi_device_lock);
 
-	if (--dev->wakeup.prepare_count > 0)
+	if (dev->wakeup.prepare_count > 1) {
+		dev->wakeup.prepare_count--;
 		goto out;
+	}
 
-	/*
-	 * Executing the code below even if prepare_count is already zero when
-	 * the function is called may be useful, for example for initialisation.
-	 */
-	if (dev->wakeup.prepare_count < 0)
-		dev->wakeup.prepare_count = 0;
+	/* Do nothing if wakeup power has not been enabled for this device. */
+	if (!dev->wakeup.prepare_count)
+		goto out;
 
 	err = acpi_device_sleep_wake(dev, 0, 0, 0);
 	if (err)
 		goto out;
 
+	/*
+	 * All of the power resources in the list need to be turned off even if
+	 * there are errors.
+	 */
 	list_for_each_entry(entry, &dev->wakeup.resources, node) {
-		struct acpi_power_resource *resource = entry->resource;
-
-		mutex_lock(&resource->resource_lock);
-
-		if (resource->wakeup_enabled) {
-			err = acpi_power_off_unlocked(resource);
-			if (!err)
-				resource->wakeup_enabled = false;
-		}
-
-		mutex_unlock(&resource->resource_lock);
+		int ret;
 
-		if (err) {
-			dev_err(&dev->dev,
-				"Cannot turn wakeup power resources off\n");
-			dev->wakeup.flags.valid = 0;
-			break;
-		}
+		ret = acpi_power_off(entry->resource);
+		if (ret && !err)
+			err = ret;
+	}
+	if (err) {
+		dev_err(&dev->dev, "Cannot turn off wakeup power resources\n");
+		dev->wakeup.flags.valid = 0;
 	}
 
  out:




