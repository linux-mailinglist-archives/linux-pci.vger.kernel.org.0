Return-Path: <linux-pci+bounces-43398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34076CCFFB8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 14:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9655E3016C57
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BD61C84DC;
	Fri, 19 Dec 2025 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC2TW5iS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3260F13A3ED
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766149851; cv=none; b=NkrZGONuhOvtMHgyD3B1O4aUx4ilRP6gR9e4DPfqfNGBd27lJlK0pG5ChcTJBLb55Z+XXkhg24inyI8BvJG42EwvlPG6MiwhV2lZYy6IoIUVbNPwaiuhcjghvGa9JTEA8sTN4A0+eBm5luJMLtBVxRg427L0oDZpkogz8IbATe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766149851; c=relaxed/simple;
	bh=lad8VIzcRzCJb0dcRUvtJfvKhPFefkLb0FheHK7uk/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lt8CXRcXcHj7DN+6E5n83z2uRzaeOMaNCeHzZ2eoZCFVYjKFO91e4p92k4za5JNP4Itb1oxAdAGCiybWQB/q5G2O5UnO5m/73NwML0W6OXDqMoXwsnLOOvljvS30Q8p6SmmsygIoS7UtNoVbdnRL3kLV75o6oOucm00K+oasCTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GC2TW5iS; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-594270ec7f9so2012962e87.3
        for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 05:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766149847; x=1766754647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NGjGh8u2MXDmgXgPVZ1F6bA2pO0k9VqioeI+44e/nQo=;
        b=GC2TW5iShMCK2bdt9Gcvu5ya6zHBUnfyHAIMqYoPXRxwXDBqXbZtwvn8UAmez0fNO5
         OorAqz++ZKiqkhaNsKgWwQk14ShHMN8ha0+l4V+Q9uNktFno95SbpAWZl9QidUWJMbjP
         YzVWgJVmmScshgzJy6sf6CYgjgl/F2yMRhE0pPXTx9x8GMgg588Zz9iB3wtPdAu0Cpaa
         Jt/8VfJElJHYFyginnIdv8oWMHmQFOOqPhb7EuU9zgYLq6baclmMcXLXgXToQRwXHrs7
         Lx4GrZahf8MZhrZrdC+5R63+2R6DsRoewH1rVqioeubvLZj9sFzDmAwinvg134N/ut3n
         +Xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766149847; x=1766754647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGjGh8u2MXDmgXgPVZ1F6bA2pO0k9VqioeI+44e/nQo=;
        b=jH6rBxypurpBFXzL6PtyRQgWpH2L6yO+2VEEFEey3LDdOTG4bAWzyk02vNJyEKs9Xl
         BZ5oCQhe5ClHFhF29TRH706ET8g9E1Qs80wlcKo1aQbCy59qPCHwCFnWsc4n9j316ub1
         R+ueDzR6HtqWCMEs6FGNM0TLXT4dzkgVHpMnDKUoW8c15o8xqUUxpqlmg7Gsos4x1EqS
         MP1rDTttTIgk4gpofojHqeQ24i9xZiuWI/OF5M80Piiwzv8qM45zfua392EFd9OhLwB0
         5qELBbgA8Uy6i8SxUOP6IUlay1Lb5eb4XjMOqZPakQexoChNReXkvkmcCZjn7tCtSLps
         812Q==
X-Gm-Message-State: AOJu0YwkKAXOTc1Dlhsk4MC+3Ki1+MdSdwwz9LaCp17hpQ3Clnn3SK32
	8o2W3o9+vRl4HeZKRND5PVcDk3shIFvgLCqg4lmi6UTo+Y6hoKBcrCDfWKkMDA==
X-Gm-Gg: AY/fxX4XTM+4CkHUuqLXv5bvN7piGKlBa9sxZ+povfm56qMOAh+39Wce6Hgg1Hr0+cX
	KI6qfeOv5I2vI8I2b/RwE0f8881O1Oq17N2n0Jal6X1OjH8BU9AoNjkBkpGy7eHnXs6gmpaulX9
	IbXWlv12SBHmPo19Uu95cA4oKgAepj+6vWVOUQ/sUGCvVLzlPLEUUfwACq+BjAZzf5ylONlR4qD
	FYMwfuptbEQcjp0VxOwc//m4BUBD64ITA7SI1vAEXYqhu4noNa/wwr375nLNPcdhmiHh0R7xD8I
	e/s3/QPZIz462G4n7pIpSvOz9E/d7R1/OSV3asL+qJnyc5JMHfv2IpOt0Ai6pv21YgpsO133qnG
	i2gxwxbM9f5u0a9cQHHIgP9Ul9RgfX/fNGXK9llsEYRECz4I7ArkL7eaeTwl5wPlCEyNw++Kd96
	n5QcGSsW3KfU9wYndNCO0=
X-Google-Smtp-Source: AGHT+IEPheM/xkvgbuQP5E6Tu2wTB47DB9Xfc/ocY2MOwJTRD3iydE+MyHvdBw5ippteYUdFSUsBew==
X-Received: by 2002:a05:6512:1594:b0:592:f8c0:c8de with SMTP id 2adb3069b0e04-59a17d15b58mr1108463e87.13.1766149846895;
        Fri, 19 Dec 2025 05:10:46 -0800 (PST)
Received: from localhost ([212.74.230.163])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-59a1861f85dsm685661e87.73.2025.12.19.05.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 05:10:46 -0800 (PST)
From: Roman Shlyakhov <roman.shlyakhov.rs@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] pci: extend pci-stub to support explicit binding by PCI BUSID
Date: Fri, 19 Dec 2025 16:10:30 +0300
Message-ID: <20251219131038.21052-1-roman.shlyakhov.rs@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The standard pci-stub driver relies on vendor/device ID matching,
which can unintentionally claim multiple devices sharing the same
VID:DID pair. This is problematic for device passthrough scenarios
where only specific physical devices should be reserved.

This patch adds support for explicit binding by PCI BUSID via the
'busid=' module parameter (and early 'pci_stub_busid=' kernel
parameter). When BUSIDs are specified, only the listed devices are
claimed by pci-stub, and ID-based matching is disabled entirely to
avoid accidental device capture.

Key features:
- Parses BUSID in formats: 'bus:dev.func' or 'domain:bus:dev.func'
- Supports multiple comma-separated BUSIDs
- Binds matching devices dynamically using pci_add_dynid()
- Forces driver attachment if needed
- Includes runtime verification and informative logging
- Maintains backward compatibility with existing 'ids=' usage

Example usage:
  modprobe pci-stub busid=0000:02:00.0,0000:02:00.1
Or via kernel cmdline:
  pci_stub_busid=02:00.0,03:00.0

Signed-off-by: Roman Shlyakhov <roman.shlyakhov.rs@gmail.com>
---
 drivers/pci/pci-stub.c | 372 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 337 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
index 9bc478df4e8f..3ca5e11c3939 100644
--- a/drivers/pci/pci-stub.c
+++ b/drivers/pci/pci-stub.c
@@ -14,71 +14,373 @@
  * # echo -n 0000:00:19.0 > /sys/bus/pci/drivers/pci-stub/bind
  * # ls -l /sys/bus/pci/devices/0000:00:19.0/driver
  * .../0000:00:19.0/driver -> ../../../bus/pci/drivers/pci-stub
+ *
+ * Enhanced BUSID support for kernel 6.12+
  */
 
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#define MAX_PCI_STUB_BUSIDS 32
 
 static char ids[1024] __initdata;
 
+struct pci_stub_busid {
+	unsigned int domain;
+	unsigned int bus;
+	unsigned int device;
+	unsigned int function;
+	bool domain_specified;
+};
+
+static struct pci_stub_busid stub_busids[MAX_PCI_STUB_BUSIDS];
+static unsigned int num_stub_busids;
+static char busid_param[1024] = "";
+
+static int pci_stub_probe(struct pci_dev *dev, const struct pci_device_id *id);
+static struct pci_stub_busid *pci_stub_find_busid(struct pci_dev *dev);
+
+module_param_string(busid, busid_param, sizeof(busid_param), 0444);
+MODULE_PARM_DESC(busid, "PCI BUSID list to bind to pci-stub, "
+		"format: [domain:]bus:dev.func[,domain:]bus:dev.func]* "
+		"(e.g. 02:00.0,02:00.1 or 0000:02:00.0)");
+
 module_param_string(ids, ids, sizeof(ids), 0);
 MODULE_PARM_DESC(ids, "Initial PCI IDs to add to the stub driver, format is "
-		 "\"vendor:device[:subvendor[:subdevice[:class[:class_mask]]]]\""
-		 " and multiple comma separated entries can be specified");
+		"\"vendor:device[:subvendor[:subdevice[:class[:class_mask]]]]\""
+		" and multiple comma separated entries can be specified");
+
+/**
+ * Checking if the PCI device matches the BUSID list.
+ */
+static struct pci_stub_busid *pci_stub_find_busid(struct pci_dev *dev)
+{
+	unsigned int i;
+	unsigned int dev_domain = pci_domain_nr(dev->bus);
+	unsigned int dev_bus = dev->bus->number;
+	unsigned int dev_slot = PCI_SLOT(dev->devfn);
+	unsigned int dev_func = PCI_FUNC(dev->devfn);
+
+	for (i = 0; i < num_stub_busids; i++) {
+		if (stub_busids[i].domain_specified) {
+			if (dev_domain == stub_busids[i].domain &&
+			    dev_bus == stub_busids[i].bus &&
+			    dev_slot == stub_busids[i].device &&
+			    dev_func == stub_busids[i].function)
+				return &stub_busids[i];
+		} else {
+			if (dev_bus == stub_busids[i].bus &&
+			    dev_slot == stub_busids[i].device &&
+			    dev_func == stub_busids[i].function)
+				return &stub_busids[i];
+		}
+	}
+
+	return NULL;
+}
 
 static int pci_stub_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	pci_info(dev, "claimed by stub\n");
-	return 0;
+	struct pci_stub_busid *busid = pci_stub_find_busid(dev);
+
+	if (busid) {
+		pci_info(dev, "claimed by stub (BUSID match: %s)\n", pci_name(dev));
+		return 0;
+	}
+
+	/*
+	 * If BUSIDs are specified, id_table probing is not used.
+	 * This prevents grabbing foreign devices with the same VID:DID.
+	 */
+	if (num_stub_busids > 0) {
+		pci_info(dev, "rejected: not in BUSID list (VID:DID=%04x:%04x)\n",
+			 dev->vendor, dev->device);
+		return -ENODEV;
+	}
+
+	/*
+	 * Standard operation mode if no BUSID is specified.
+	 */
+	if (id) {
+		pci_info(dev, "claimed by stub (ID table match: %04x:%04x)\n",
+			 id->vendor, id->device);
+		return 0;
+	}
+
+	return -ENODEV;
 }
 
 static struct pci_driver stub_driver = {
-	.name		= "pci-stub",
-	.id_table	= NULL,	/* only dynamic id's */
-	.probe		= pci_stub_probe,
-	.driver_managed_dma = true,
+	.name			= "pci-stub",
+	.id_table		= NULL,	/* only dynamic id's */
+	.probe			= pci_stub_probe,
+	.driver_managed_dma	= true,
 };
 
-static int __init pci_stub_init(void)
+/**
+ * Parsing a single BUSID.
+ */
+static int pci_stub_parse_one_busid(const char *str, struct pci_stub_busid *busid)
 {
-	char *p, *id;
-	int rc;
+	unsigned int domain = 0, bus, dev, func;
 
-	rc = pci_register_driver(&stub_driver);
-	if (rc)
-		return rc;
+	if (sscanf(str, "%x:%x:%x.%u", &domain, &bus, &dev, &func) == 4)
+		busid->domain_specified = true;
+	else if (sscanf(str, "%x:%x.%u", &bus, &dev, &func) == 3)
+		busid->domain_specified = false;
+	else
+		return -EINVAL;
+
+	if ((busid->domain_specified && domain > 0xffff)
+	    || bus > 255 || dev > 31 || func > 7) {
+		return -EINVAL;
+	}
+	busid->domain = domain;
+	busid->bus = bus;
+	busid->device = dev;
+	busid->function = func;
+
+	return 0;
+}
+
+/**
+ * Parsing the "busid" kernel parameter.
+ */
+static void __init pci_stub_parse_busid_param(void)
+{
+	char *str, *token;
+	int count = 0;
+
+	if (!busid_param[0])
+		return;
+
+	pr_info("pci-stub: parsing busid param: %s\n", busid_param);
+
+	str = kstrdup(busid_param, GFP_KERNEL);
+	if (!str)
+		return;
+
+	for (token = str; token && *token && count < MAX_PCI_STUB_BUSIDS; ) {
+		char *busid_str = token;
+		char *next = strchr(token, ',');
 
-	/* no ids passed actually */
-	if (ids[0] == '\0')
+		if (next) {
+			*next = '\0';
+			token = next + 1;
+		} else {
+			token = NULL;
+		}
+
+		while (*busid_str == ' ')
+			busid_str++;
+
+		if (!*busid_str)
+			continue;
+
+		if (pci_stub_parse_one_busid(busid_str,
+					     &stub_busids[num_stub_busids + count]) == 0) {
+			struct pci_stub_busid *busid = &stub_busids[num_stub_busids + count];
+
+			if (busid->domain_specified) {
+				pr_info("pci-stub: registered BUSID %04x:%02x:%02x.%u\n",
+					busid->domain, busid->bus, busid->device, busid->function);
+			} else {
+				pr_info("pci-stub: registered BUSID %02x:%02x.%u\n",
+					busid->bus, busid->device, busid->function);
+			}
+			count++;
+		} else {
+			pr_warn("pci-stub: invalid BUSID format: '%s'\n", busid_str);
+		}
+	}
+
+	kfree(str);
+
+	if (count > 0) {
+		num_stub_busids += count;
+		pr_info("pci-stub: registered %d BUSID(s)\n", count);
+	}
+}
+
+/**
+ * early_param "pci_stub_busid" handler for the built-in module.
+ */
+static int __init pci_stub_early_param(char *str)
+{
+	if (!str)
 		return 0;
 
-	/* add ids specified in the module parameter */
-	p = ids;
-	while ((id = strsep(&p, ","))) {
-		unsigned int vendor, device, subvendor = PCI_ANY_ID,
-			subdevice = PCI_ANY_ID, class = 0, class_mask = 0;
-		int fields;
+	pr_info("pci-stub: parsing early busid param: %s\n", str);
+	strscpy(busid_param, str, sizeof(busid_param));
+	return 0;
+}
+
+early_param("pci_stub_busid", pci_stub_early_param);
+
+/**
+ * Binding devices by BUSID via dynamic IDs.
+ */
+static void __init pci_stub_bind_free_devices(void)
+{
+	struct pci_dev *pdev = NULL;
+	int bound = 0;
+	int skipped = 0;
+
+	if (!num_stub_busids)
+		return;
 
-		if (!strlen(id))
+	pr_info("pci-stub: attempting to bind devices by BUSID using dynamic IDs\n");
+
+	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
+		struct pci_stub_busid *busid = pci_stub_find_busid(pdev);
+
+		if (!busid)
 			continue;
 
-		fields = sscanf(id, "%x:%x:%x:%x:%x:%x",
-				&vendor, &device, &subvendor, &subdevice,
-				&class, &class_mask);
+		if (pdev->dev.driver == &stub_driver.driver) {
+			pr_info("pci-stub: %s already bound to stub\n", pci_name(pdev));
+			bound++;
+			continue;
+		}
+
+		if (pdev->dev.driver) {
+			pr_info("pci-stub: %s already bound to %s (skipping)\n",
+				pci_name(pdev), pdev->dev.driver->name);
+			skipped++;
+			continue;
+		}
 
-		if (fields < 2) {
-			pr_warn("pci-stub: invalid ID string \"%s\"\n", id);
+		/* Adding a dynamic ID for this specific device */
+		int rc = pci_add_dynid(&stub_driver, pdev->vendor, pdev->device,
+				       PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0);
+		if (rc) {
+			pr_warn("pci-stub: failed to add dynamic ID for %s: %d\n",
+				pci_name(pdev), rc);
 			continue;
 		}
 
-		pr_info("pci-stub: add %04X:%04X sub=%04X:%04X cls=%08X/%08X\n",
-		       vendor, device, subvendor, subdevice, class, class_mask);
+		pr_info("pci-stub: added dynamic ID %04x:%04x for %s\n",
+			pdev->vendor, pdev->device, pci_name(pdev));
+
+		/* Check if device is now bound */
+		if (pdev->dev.driver == &stub_driver.driver) {
+			pr_info("pci-stub: successfully bound %s\n", pci_name(pdev));
+			bound++;
+			continue;
+		}
+
+		/* Force bind if not yet bound */
+		int ret = device_driver_attach(&stub_driver.driver, &pdev->dev);
+
+		if (ret < 0) {
+			pr_warn("pci-stub: error binding %s: %d\n", pci_name(pdev), ret);
+		} else {
+			pr_info("pci-stub: successfully bound %s\n", pci_name(pdev));
+			bound++;
+		}
+	}
+
+	pr_info("pci-stub: bound %d device(s), skipped %d\n", bound, skipped);
+}
+
+/**
+ * Checking the final binding state.
+ */
+static void __init pci_stub_verify_bindings(void)
+{
+	struct pci_dev *pdev = NULL;
+	int total_found = 0;
+	int bound_to_stub = 0;
+	int bound_to_other = 0;
+	int not_bound = 0;
+
+	if (!num_stub_busids)
+		return;
+
+	pr_info("pci-stub: verifying device bindings...\n");
+
+	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
+		struct pci_stub_busid *busid = pci_stub_find_busid(pdev);
+
+		if (!busid)
+			continue;
+
+		total_found++;
+
+		if (pdev->dev.driver == &stub_driver.driver) {
+			pr_info("pci-stub: ✓ %s is bound to stub\n", pci_name(pdev));
+			bound_to_stub++;
+		} else if (pdev->dev.driver) {
+			pr_info("pci-stub: ✗ %s is bound to %s (not stub)\n",
+				pci_name(pdev), pdev->dev.driver->name);
+			bound_to_other++;
+		} else {
+			pr_info("pci-stub: ? %s is not bound to any driver\n", pci_name(pdev));
+			not_bound++;
+		}
+	}
+
+	pr_info("pci-stub: summary:\n");
+	pr_info("  Total devices in BUSID list: %d\n", total_found);
+	pr_info("  Bound to pci-stub: %d\n", bound_to_stub);
+	pr_info("  Bound to other drivers: %d\n", bound_to_other);
+	pr_info("  Not bound to any driver: %d\n", not_bound);
+
+	if (bound_to_other > 0) {
+		pr_warn("pci-stub: warning: %d device(s) are bound to other drivers\n",
+			bound_to_other);
+		pr_warn("pci-stub: use 'modprobe.blacklist' in kernel cmdline to "
+			"prevent driver loading\n");
+		pr_warn("pci-stub: or ensure pci-stub loads before other drivers\n");
+	}
+}
+
+static int __init pci_stub_init(void)
+{
+	char *p, *id;
+	int rc;
+
+	pr_info("pci-stub: initializing\n");
+
+	pci_stub_parse_busid_param();
+
+	rc = pci_register_driver(&stub_driver);
+	if (rc) {
+		pr_err("pci-stub: failed to register driver: %d\n", rc);
+		return rc;
+	}
+
+	if (ids[0] != '\0') {
+		p = ids;
+		while ((id = strsep(&p, ","))) {
+			unsigned int vendor, device, subvendor = PCI_ANY_ID,
+				     subdevice = PCI_ANY_ID, class = 0, class_mask = 0;
+			int fields;
+
+			if (!strlen(id))
+				continue;
+
+			fields = sscanf(id, "%x:%x:%x:%x:%x:%x",
+					&vendor, &device, &subvendor, &subdevice,
+					&class, &class_mask);
+			if (fields < 2) {
+				pr_warn("pci-stub: invalid ID string \"%s\"\n", id);
+				continue;
+			}
+
+			rc = pci_add_dynid(&stub_driver, vendor, device,
+					   subvendor, subdevice, class, class_mask, 0);
+			if (rc)
+				pr_warn("pci-stub: failed to add dynamic ID (%d)\n", rc);
+		}
+	}
 
-		rc = pci_add_dynid(&stub_driver, vendor, device,
-				   subvendor, subdevice, class, class_mask, 0);
-		if (rc)
-			pr_warn("pci-stub: failed to add dynamic ID (%d)\n",
-				rc);
+	if (num_stub_busids > 0) {
+		pr_info("pci-stub: driver registered with %d BUSID(s)\n", num_stub_busids);
+		pci_stub_bind_free_devices();
+		pci_stub_verify_bindings();
 	}
 
 	return 0;
-- 
2.51.2


