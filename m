Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A70F427AC8
	for <lists+linux-pci@lfdr.de>; Sat,  9 Oct 2021 16:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhJIOYO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Oct 2021 10:24:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55750 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhJIOYO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Oct 2021 10:24:14 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id d3d322a473f577f6; Sat, 9 Oct 2021 16:22:16 +0200
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 5020B66A6C1;
        Sat,  9 Oct 2021 16:22:15 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: scan: Release PM resources blocked by unused objects
Date:   Sat, 09 Oct 2021 16:22:09 +0200
Message-ID: <5507158.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvvefgteeuteehkeduuedvudetleevffdtffdtjeejueekffetieekgfeigfehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekledrjeejrdehuddrkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdejjedrhedurdekgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
 pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On some systems the ACPI namespace contains device objects that are
not used in certain configurations of the system.  If they start off
in the D0 power state configuration, they will stay in it until the
system reboots, because of the lack of any mechanism possibly causing
their configuration to change.  If that happens, they may prevent
some power resources from being turned off or generally they may
prevent the platform from getting into the deepest low-power states
thus causing some energy to be wasted.

Address this issue by changing the configuration of unused ACPI
device objects to the D3cold power state one after carrying out
the ACPI-based enumeration of devices.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214091
Link: https://lore.kernel.org/linux-acpi/20211007205126.11769-1-mario.limonciello@amd.com/
Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Mario,

I've changed acpi_dev_turn_off_if_unused() to check pnp.type.hardware_id
instead of pnp.type.bus_address, because on some systems there are objects
with both _ADR and _HID (which is against the spec) and the former is bogus.

Please test this one, even though for PCI devices there should be no difference.

Thanks!

---
 drivers/acpi/glue.c     |   25 +++++++++++++++++++++++++
 drivers/acpi/internal.h |    1 +
 drivers/acpi/scan.c     |    6 ++++++
 3 files changed, 32 insertions(+)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2559,6 +2559,12 @@ int __init acpi_scan_init(void)
 		}
 	}
 
+	/*
+	 * Make sure that power management resources are not blocked by ACPI
+	 * device objects with no users.
+	 */
+	bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);
+
 	acpi_turn_off_unused_power_resources();
 
 	acpi_scan_initialized = true;
Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -350,3 +350,28 @@ void acpi_device_notify_remove(struct de
 
 	acpi_unbind_one(dev);
 }
+
+int acpi_dev_turn_off_if_unused(struct device *dev, void *not_used)
+{
+	struct acpi_device *adev = to_acpi_device(dev);
+
+	/*
+	 * Skip device objects with device IDs, because they may be in use even
+	 * if they are not companions of any physical device objects.
+	 */
+	if (adev->pnp.type.hardware_id)
+		return 0;
+
+	mutex_lock(&adev->physical_node_lock);
+
+	/*
+	 * Device objects without device IDs are not in use if they have no
+	 * corresponding physical device objects.
+	 */
+	if (list_empty(&adev->physical_node_list))
+		acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
+
+	mutex_unlock(&adev->physical_node_lock);
+
+	return 0;
+}
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -117,6 +117,7 @@ bool acpi_device_is_battery(struct acpi_
 bool acpi_device_is_first_physical_node(struct acpi_device *adev,
 					const struct device *dev);
 int acpi_bus_register_early_device(int type);
+int acpi_dev_turn_off_if_unused(struct device *dev, void *not_used);
 
 /* --------------------------------------------------------------------------
                      Device Matching and Notification



