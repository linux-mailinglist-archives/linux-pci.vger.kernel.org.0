Return-Path: <linux-pci+bounces-43051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0085CBE222
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 14:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A712A3058FA7
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 13:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19805330324;
	Mon, 15 Dec 2025 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVJYpaRO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5DF33030A;
	Mon, 15 Dec 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765805831; cv=none; b=CU34+jkT4ZdTxLJgCvR0wwVtIJjwLkzpPdbkHzN+aunjvw529SRdR4Pb7ipeROKxeROf5OEAYK+yUZfyFq8VlLvx6e3+ZDAgvxZPoYN8+77pJ3sXJYhhfHU1aqU11Evu+zQny6hOqrKWc2X8YamHuh0qf0jkbwA+RDWx1jJBFgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765805831; c=relaxed/simple;
	bh=3znqhMr60mZ3V3eqEJ7XBPRsZ5jjaU3N8c17HG26W70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/Bjvs5fGMHNy7Kb8kzJcye9umyq+jobXCrKq3NWohtLoMkpnOZCDcnlwd1kUu7We9L9T0sjuM6/Lnpe69ohSIh76ziRbrDxnqzgbANMcwbu0AWLWZsLu5OVHnNkf/0SRUjDK5qtC8klEMCz5sw9/Pdzfy5r4Dn/Etfr1vOzQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVJYpaRO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B68C4CEFB;
	Mon, 15 Dec 2025 13:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765805830;
	bh=3znqhMr60mZ3V3eqEJ7XBPRsZ5jjaU3N8c17HG26W70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KVJYpaROx2Vxulhp23iHGE/QJZIbZPC8s94W09ByI42s0y5jq7pO9SP0XNdiSECXw
	 ODYg8CIdaWCWguJiU/7lwKzhH775fe9kSylmtePCa9reFKxTmVQxIbC+/Y/9siBu2t
	 EzSxlP6VAkjCkfCjdE2YdqArAuIJwDhLK0H3dnC/uDIbvj/5utajU67OfRaQGFDL1d
	 s2GWd5IqM1FE8ynJOMkdcwZqNJzzDClvJZgcVBRdp33nd0VeGFGtKCd+6eoFZ08zva
	 782LMz+zEX2TepYZ+uxY8AwuG8oiaJIITBNMfPJen9y/ASWirjmo62EO9C5f/4ToWk
	 fOsjzIN4p7Plg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Alex Hung <alexhung@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>
Subject:
 [PATCH v1 1/4] ACPI: PNP: Drop PNP0C01 and PNP0C02 from acpi_pnp_device_ids[]
Date: Mon, 15 Dec 2025 14:34:06 +0100
Message-ID: <9550709.CDJkKcVGEf@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <7888874.EvYhyI6sBW@rafael.j.wysocki>
References: <7888874.EvYhyI6sBW@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a long-standing problem with ACPI device enumeration that
if the given device has a compatible ID which is one of the generic
system resource device IDs (PNP0C01 and PNP0C02), it will be claimed
by the PNP scan handler and it will not be represented as a platform
device, so it cannot be handled by a platform driver.

Drivers have been working around this issue by "manually" creating
platform devices that they can bind to (see the Intel HID driver for
one example) or adding their device IDs to acpi_nonpnp_device_ids[].
None of the above is particularly clean though and the only reason why
the PNP0C01 and PNP0C02 device IDs are present in acpi_pnp_device_ids[]
is to allow the legacy PNP system driver to bind to those devices and
reserve their resources so they are not used going forward.

Obviously, to address this problem PNP0C01 and PNP0C02 need to be
dropped from acpi_pnp_device_ids[], but doing so without making any
other changes would be problematic because the ACPI core would then
create platform devices for the generic system resource device objects
and that would not work on all systems for two reasons.  First, the
PNP system driver explicitly avoids reserving I/O resources below the
"standard PC hardware" boundary, 0x100, to avoid conflicts in that range
(one possible case when this may happen is when the CMOS RTC driver is
involved), but the platform device creation code does not do that.
Second, there may be resource conflicts between the "system" devices and
the other devices in the system, possibly including conflicts with PCI
BARs.  Registering the PNP system driver via fs_initcall() helps to
manage those conflicts, even though it does not make them go away.
Resource conflicts during the registration of "motherboard resources"
that occur after PCI has claimed BARs are harmless as a rule and do
not need to be addressed in any specific way.

To overcome the issues mentioned above, use the observation that it
is not actually necessary to create any device objects in addition
to struct acpi_device ones in order to reserve the "system" device
resources because that can be done directly in the ACPI device
enumeration code.

Namely, modify acpi_default_enumeration() to add the given ACPI device
object to a special "system devices" list if its _HID is either PNP0C01
or PNP0C02 without creating a platform device for it.  Next, add a new
special acpi_scan_claim_resources() function that will be run via
fs_initcall() and will walk that list and reserve resources for each
device in it along the lines of what the PNP system driver does.

Having made the above changes, drop PNP0C01 and PNP0C02 from
acpi_pnp_device_ids[] which will allow platform devices to be created
for ACPI device objects whose _CID lists contain PNP0C01 or PNP0C02,
but the _HID is not in acpi_pnp_device_ids[].

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_pnp.c |    2 
 drivers/acpi/scan.c     |  115 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 111 insertions(+), 6 deletions(-)

--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -126,8 +126,6 @@ static const struct acpi_device_id acpi_
 	/* apple-gmux */
 	{"APP000B"},
 	/* system */
-	{"PNP0c02"},		/* General ID for reserving resources */
-	{"PNP0c01"},		/* memory controller */
 	/* rtc_cmos */
 	{"PNP0b00"},
 	{"PNP0b01"},
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -42,6 +42,7 @@ static LIST_HEAD(acpi_scan_handlers_list
 DEFINE_MUTEX(acpi_device_lock);
 LIST_HEAD(acpi_wakeup_device_list);
 static DEFINE_MUTEX(acpi_hp_context_lock);
+static LIST_HEAD(acpi_scan_system_dev_list);
 
 /*
  * The UART device described by the SPCR table is the only object which needs
@@ -2203,19 +2204,48 @@ static acpi_status acpi_bus_check_add_2(
 	return acpi_bus_check_add(handle, false, (struct acpi_device **)ret_p);
 }
 
+struct acpi_scan_system_dev {
+	struct list_head node;
+	struct acpi_device *adev;
+};
+
+static const char * const acpi_system_dev_ids[] = {
+	"PNP0C01", /* Memory controller */
+	"PNP0C02", /* Motherboard resource */
+	NULL
+};
+
 static void acpi_default_enumeration(struct acpi_device *device)
 {
 	/*
 	 * Do not enumerate devices with enumeration_by_parent flag set as
 	 * they will be enumerated by their respective parents.
 	 */
-	if (!device->flags.enumeration_by_parent) {
-		acpi_create_platform_device(device, NULL);
-		acpi_device_set_enumerated(device);
-	} else {
+	if (device->flags.enumeration_by_parent) {
 		blocking_notifier_call_chain(&acpi_reconfig_chain,
 					     ACPI_RECONFIG_DEVICE_ADD, device);
+		return;
 	}
+	if (match_string(acpi_system_dev_ids, -1, acpi_device_hid(device)) >= 0) {
+		struct acpi_scan_system_dev *sd;
+
+		/*
+		 * This is a generic system device, so there is no need to
+		 * create a platform device for it, but its resources need to be
+		 * reserved.  However, that needs to be done after all of the
+		 * other device objects have been processed and PCI has claimed
+		 * BARs in case there are resource conflicts.
+		 */
+		sd = kmalloc(sizeof(*sd), GFP_KERNEL);
+		if (sd) {
+			sd->adev = device;
+			list_add_tail(&sd->node, &acpi_scan_system_dev_list);
+		}
+	} else {
+		/* For a regular device object, create a platform device. */
+		acpi_create_platform_device(device, NULL);
+	}
+	acpi_device_set_enumerated(device);
 }
 
 static const struct acpi_device_id generic_device_ids[] = {
@@ -2571,6 +2601,83 @@ static void acpi_scan_postponed(void)
 	mutex_unlock(&acpi_dep_list_lock);
 }
 
+static void acpi_scan_claim_resources(struct acpi_device *adev)
+{
+	struct list_head resource_list = LIST_HEAD_INIT(resource_list);
+	struct resource_entry *rentry;
+	unsigned int count = 0;
+	const char *regionid;
+
+	if (acpi_dev_get_resources(adev, &resource_list, NULL, NULL) <= 0)
+		return;
+
+	regionid = kstrdup(dev_name(&adev->dev), GFP_KERNEL);
+	if (!regionid)
+		goto exit;
+
+	list_for_each_entry(rentry, &resource_list, node) {
+		struct resource *res = rentry->res;
+		struct resource *r;
+
+		/* Skip disabled and invalid resources. */
+		if ((res->flags & IORESOURCE_DISABLED) || res->end < res->start)
+			continue;
+
+		if (res->flags & IORESOURCE_IO) {
+			/*
+			 * Follow the PNP system driver and on x86 skip I/O
+			 * resources that start below 0x100 (the "standard PC
+			 * hardware" boundary).
+			 */
+			if (IS_ENABLED(CONFIG_X86) && res->start < 0x100) {
+				dev_info(&adev->dev, "Skipped %pR\n", res);
+				continue;
+			}
+			r = request_region(res->start, resource_size(res), regionid);
+		} else if (res->flags & IORESOURCE_MEM) {
+			r = request_mem_region(res->start, resource_size(res), regionid);
+		} else {
+			continue;
+		}
+
+		if (r) {
+			r->flags &= ~IORESOURCE_BUSY;
+			dev_info(&adev->dev, "Reserved %pR\n", r);
+			count++;
+		} else {
+			dev_info(&adev->dev, "Could not reserve %pR\n", res);
+		}
+	}
+
+	if (!count)
+		kfree(regionid);
+
+exit:
+	acpi_dev_free_resource_list(&resource_list);
+}
+
+
+static int __init acpi_reserve_motherboard_resources(void)
+{
+	struct acpi_scan_system_dev *sd, *tmp;
+
+	guard(mutex)(&acpi_scan_lock);
+
+	list_for_each_entry_safe(sd, tmp, &acpi_scan_system_dev_list, node) {
+		acpi_scan_claim_resources(sd->adev);
+		list_del(&sd->node);
+		kfree(sd);
+	}
+
+	return 0;
+}
+
+/*
+ * Reserve motherboard resources after PCI claims BARs, but before PCI assigns
+ * resources for uninitialized PCI devices.
+ */
+fs_initcall(acpi_reserve_motherboard_resources);
+
 /**
  * acpi_bus_scan - Add ACPI device node objects in a given namespace scope.
  * @handle: Root of the namespace scope to scan.




