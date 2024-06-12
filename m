Return-Path: <linux-pci+bounces-8665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8426D905177
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 13:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716F21C21968
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 11:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E121916F267;
	Wed, 12 Jun 2024 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dY9wi534"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE0316F0E4
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192300; cv=none; b=fUdxqrbPQEUVyCLH0UIPqhZoN82UdA/c05HHwuDhaaDDpG1hFx9XPf5oi0h4jiWk5ji74CjMoIpgZnlbDDmy+DkJQTBxpNQiTbCETC3a+x/i+1J3PUCY+krkss157LRAaJ5UCBt+5jKXROC9Sfuum6+wDTYVb1SHFLb5fNXxNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192300; c=relaxed/simple;
	bh=X54q7kR8w3bKR+vq5N8iBw0Uvz13RJrNjwFG6VpQnJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZNMqsYMofFF4wGToSV/v1M3jZKt2y6X/YH43/7x3OtTa2UJNwQ+wBIgjZKWXWr0GLbbwlnyDj7uTUUFHWMchvshjm1KV0ZzeuRZFspEOkXEekmwjJ1GytQk/EQZriNM/dtEaUiZUfK815JKs7Re7U6gv6hANUobZM+kC1M1zMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dY9wi534; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7041bc85bafso164423b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 04:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718192297; x=1718797097; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ChSMHdsPo/JReLzotR/ZbJrp1jk8VNcpdppg6DO1uU=;
        b=dY9wi534J1QSlKEeTigzqW4kaBKyCH6MVOnxtyQwuB91ZyruyP0+WRLdnqb0DtogsA
         ovWjkN/9GxJdljj0RJKoPGQDNOdY+7J97np+cFdoRiH9FyEV/p/tt3ZsEDtNoerJ5fO8
         ViIAlclD/neeQc+4IbO5Q1xbLODNPRZsa8Qig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718192297; x=1718797097;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ChSMHdsPo/JReLzotR/ZbJrp1jk8VNcpdppg6DO1uU=;
        b=lcXQ/ss6hxUQ0gjoOzVAS9h1lE777LIuuAQ+F1EKF4TffEdIHIKnp8RF8sgplRjwHZ
         Me9C4ofX/uRYJ0StlGnk101IPAxnXUYxEFv1eSQT1ZjWPmMgVFbjBwIKHc64GUEhWj4T
         f6sTmVa0VCTfR6SSpyVFnkHALCI+XXblHHTupwygZW1JN/6DCRP47otAE6r1wCQb93+p
         IZ7uPelf91AmGyPAhdQmbhDhNIgLyUoczwNR+pBtQLbWB0H2lLlzfgxOg3L9m4vDmWCh
         6yjZdpRQavWoh61Pr7gA6K75ILPVK1xY3yv5Jb+VOHERKxq1Dr/4uGZmKl8k0n7fj/Gc
         D7eA==
X-Gm-Message-State: AOJu0Ywfw5QynUwPhh2ax8Ff/Wsk0kgot4K+/Ubn/2LXOAY2Gayiw7t5
	A570DdzaAxvN0O4qalvDdhGi7CRNt7tj6MlL+c2GjhFBRmlOBwakpXaXTuMkzh6uE67EQK7wrZR
	Cy28ZzMSDDIwNIOq9hi+mv37XYULIyOaUjseV9W/1faVNa8iaVr2DJ39znkJGqizP7VPVoDGDNJ
	LWsyg7J7KO1u3jQpz2DjTDeWVZZiV+qdqqzXNHtj2tmR71AxLKA1hhjz0b8+EuzeQ=
X-Google-Smtp-Source: AGHT+IF/B9hr3Dxj7LXzRM0rIWoZpQJ7g/qv4LpYG525zAhkCaJ01DaFEKMi96VciAfKZVkI9GJVzg==
X-Received: by 2002:a05:6a20:96da:b0:1af:aeb7:7a10 with SMTP id adf61e73a8af0-1b8a9b48604mr1494010637.1.1718192297319;
        Wed, 12 Jun 2024 04:38:17 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6fc06a5d2sm74392305ad.306.2024.06.12.04.38.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2024 04:38:16 -0700 (PDT)
From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org,
	sumanesh.samanta@broadcom.com,
	sathya.prakash@broadcom.com,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH 1/2] switch_discovery: Add new module to discover inter switch links between PCI-to-PCI bridges
Date: Wed, 12 Jun 2024 04:27:35 -0700
Message-Id: <1718191656-32714-2-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1718191656-32714-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1718191656-32714-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000937eb4061aafd1bd"

--000000000000937eb4061aafd1bd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This kernel module discovers the virtual inter-switch P2P links present
between two PCI-to-PCI bridges that allows an optimal data path for data
movement. The module creates sysfs entries for upstream PCI-to-PCI
bridges which supports the inter switch P2P links as below:

                             Host root bridge
                ---------------------------------------
                |                                     |
  NIC1 --- PCI Switch1 --- Inter-switch link --- PCI Switch2 --- NIC2
(af:00.0)   (ad:00.0)                             (8b:00.0)   (8d:00.0)
                |                                     |
               GPU1                                  GPU2
            (b0:00.0)                             (8e:00.0)
                               SERVER 1

/sys/kernel/pci_switch_link/virtual_switch_links
├── 0000:8b:00.0
│   └── 0000:ad:00.0 -> ../0000:ad:00.0
└── 0000:ad:00.0
    └── 0000:8b:00.0 -> ../0000:8b:00.0

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
---
 .../driver-api/pci/switch_discovery.rst       |  52 +++
 MAINTAINERS                                   |  13 +
 drivers/pci/switch/Kconfig                    |   9 +
 drivers/pci/switch/Makefile                   |   1 +
 drivers/pci/switch/switch_discovery.c         | 375 ++++++++++++++++++
 drivers/pci/switch/switch_discovery.h         |  44 ++
 6 files changed, 494 insertions(+)
 create mode 100644 Documentation/driver-api/pci/switch_discovery.rst
 create mode 100644 drivers/pci/switch/switch_discovery.c
 create mode 100644 drivers/pci/switch/switch_discovery.h

diff --git a/Documentation/driver-api/pci/switch_discovery.rst b/Documentation/driver-api/pci/switch_discovery.rst
new file mode 100644
index 000000000000..7c1476260e5e
--- /dev/null
+++ b/Documentation/driver-api/pci/switch_discovery.rst
@@ -0,0 +1,52 @@
+=================================
+Linux PCI Switch discovery module
+=================================
+
+Modern PCI switches support inter switch Peer-to-Peer(P2P) data transfer
+without using host resources. For example, Broadcom(PLX) PCIe Switches have a
+capability where a single physical switch can be divided up into multiple
+virtual switches at SOD. PCIe switch discovery module detects the virtual links
+between the switches that belong to the same physical switch.
+This allows user space applications to discover these virtual links that belong
+to the same physical switch and configure optimized data paths.
+
+Userspace Interface
+===================
+
+The module exposes sysfs entries for user space applications like MPI, NCCL,
+UCC, RCCL, HCCL, etc to discover the virtual switch links.
+
+Consider the below topology
+
+                             Host root bridge
+                ---------------------------------------
+                |                                     |
+  NIC1 --- PCI Switch1 --- Inter-switch link --- PCI Switch2 --- NIC2
+(af:00.0)   (ad:00.0)                             (8b:00.0)   (8d:00.0)
+                |                                     |
+               GPU1                                  GPU2
+            (b0:00.0)                             (8e:00.0)
+                               SERVER 1
+
+The simple topology above shows SERVER1, has Switch1 and Switch2 which are
+virtual switches that belong to the same physical switch that support
+Inter switch P2P.
+Switch1 and Switch2 have a GPU and NIC each connected.
+The module will detect the virtual P2P link existing between the two switches
+and create the sysfs entries as below.
+
+/sys/kernel/pci_switch_link/virtual_switch_links
+├── 0000:8b:00.0
+│   └── 0000:ad:00.0 -> ../0000:ad:00.0
+└── 0000:ad:00.0
+    └── 0000:8b:00.0 -> ../0000:8b:00.0
+
+The HPC/AI libraries that analyze the topology can decide the optimal data
+path like: NIC1->GPU1->GPU2->NIC1 which would have otherwise take a
+non-optimal path like NIC1->GPU1->GPU2->GPU1->NIC1.
+
+Enable P2P DMA to discover virtual links
+----------------------------------------
+The module also enhances :c:func:`pci_p2pdma_distance()` to determine a virtual
+link between the upstream PCI-to-PCI bridges of the devices and detect optimal
+path for applications using P2P DMA API.
diff --git a/MAINTAINERS b/MAINTAINERS
index 823387766a0c..b1bf3533ea6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17359,6 +17359,19 @@ F:	Documentation/driver-api/pci/p2pdma.rst
 F:	drivers/pci/p2pdma.c
 F:	include/linux/pci-p2pdma.h
 
+PCI SWITCH DISCOVERY
+M:	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
+M:	Sumanesh Samanta <sumanesh.samanta@broadcom.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+Q:	https://patchwork.kernel.org/project/linux-pci/list/
+B:	https://bugzilla.kernel.org
+C:	irc://irc.oftc.net/linux-pci
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
+F:	Documentation/driver-api/pci/switch_discovery.rst
+F:	drivers/pci/switch/switch_discovery.c
+F:	drivers/pci/switch/switch_discovery.h
+
 PCI SUBSYSTEM
 M:	Bjorn Helgaas <bhelgaas@google.com>
 L:	linux-pci@vger.kernel.org
diff --git a/drivers/pci/switch/Kconfig b/drivers/pci/switch/Kconfig
index d370f4ce0492..fb4410153950 100644
--- a/drivers/pci/switch/Kconfig
+++ b/drivers/pci/switch/Kconfig
@@ -12,4 +12,13 @@ config PCI_SW_SWITCHTEC
 	 devices. See <file:Documentation/driver-api/switchtec.rst> for more
 	 information.
 
+config PCI_SW_DISCOVERY
+	depends on PCI
+	tristate "PCI Switch discovery module"
+	help
+	 This kernel module discovers the PCI-to-PCI bridges of PCIe switches
+	 and forms the virtual switch links if the bridges belong to the same
+	 Physical switch. The switch links help to identify shorter distances
+	 for P2P configurations.
+
 endmenu
diff --git a/drivers/pci/switch/Makefile b/drivers/pci/switch/Makefile
index acd56d3b4a35..a3584b5146af 100644
--- a/drivers/pci/switch/Makefile
+++ b/drivers/pci/switch/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCI_SW_SWITCHTEC) += switchtec.o
+obj-$(CONFIG_PCI_SW_DISCOVERY) += switch_discovery.o
diff --git a/drivers/pci/switch/switch_discovery.c b/drivers/pci/switch/switch_discovery.c
new file mode 100644
index 000000000000..a427d3885b1f
--- /dev/null
+++ b/drivers/pci/switch/switch_discovery.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  PCI Switch Discovery module
+ *
+ *  Copyright (c) 2024  Broadcom Inc.
+ *
+ *  Authors: Broadcom Inc.
+ *           Sumanesh Samanta <sumanesh.samanta@broadcom.com>
+ *           Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sysfs.h>
+#include <linux/slab.h>
+#include <linux/rwsem.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+#include "switch_discovery.h"
+
+static DECLARE_RWSEM(sw_disc_rwlock);
+static struct kobject *sw_disc_kobj, *sw_link_kobj;
+static struct kobject *sw_kobj[SWD_MAX_VIRT_SWITCH];
+static DECLARE_BITMAP(swdata_valid, SWD_MAX_VIRT_SWITCH);
+
+static struct switch_data *swdata;
+
+static int sw_disc_probe(void);
+static int sw_disc_create_sysfs_files(void);
+static bool brcm_sw_is_p2p_supported(struct pci_dev *pdev, char *serial_num);
+
+static inline bool sw_disc_is_supported_pdev(struct pci_dev *pdev)
+{
+	if ((pdev->vendor == PCI_VENDOR_ID_LSI) &&
+	   ((pdev->device == PCI_DEVICE_ID_BRCM_PEX_89000_HLC) ||
+	    (pdev->device == PCI_DEVICE_ID_BRCM_PEX_89000_LLC)))
+		return true;
+
+	return false;
+}
+
+static ssize_t sw_disc_show(struct kobject *kobj,
+			struct kobj_attribute *attr,
+			char *buf)
+{
+	int retval;
+
+	down_write(&sw_disc_rwlock);
+	retval = sw_disc_probe();
+	if (!retval) {
+		pr_debug("No new switch found\n");
+		goto exit_success;
+	}
+
+	retval = sw_disc_create_sysfs_files();
+	if (retval < 0) {
+		pr_err("Failed to create the sysfs entries, retval %d\n",
+		       retval);
+	}
+
+exit_success:
+	up_write(&sw_disc_rwlock);
+	return sysfs_emit(buf, SWD_SCAN_DONE);
+}
+
+/* This function probes the PCIe devices for virtual links */
+static int sw_disc_probe(void)
+{
+	int i, bit;
+	struct pci_dev *pdev = NULL;
+	int topology_changed = 0;
+	DECLARE_BITMAP(sw_found_map, SWD_MAX_VIRT_SWITCH);
+
+	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
+		int sw_found;
+
+		/* Currently this function only traverses Broadcom
+		 * PEX switches and determines the virtual SW links.
+		 * Other Switch vendors can add their specific logic
+		 * determine the virtual links.
+		 */
+		if (!sw_disc_is_supported_pdev(pdev))
+			continue;
+
+		sw_found = -1;
+
+		for_each_set_bit(bit, swdata_valid, SWD_MAX_VIRT_SWITCH) {
+			if (swdata[bit].devfn == pdev->devfn &&
+			    swdata[bit].bus == pdev->bus) {
+				sw_found = bit;
+				set_bit(sw_found, sw_found_map);
+				break;
+			}
+		}
+
+		if (sw_found != -1)
+			continue;
+
+		for (i = 0; i < SWD_MAX_VIRT_SWITCH; i++)
+			if (!swdata[i].bus)
+				break;
+
+		if (i >= SWD_MAX_VIRT_SWITCH) {
+			pr_err("Max switch exceeded\n");
+			break;
+		}
+
+		sw_found = i;
+
+		if (!brcm_sw_is_p2p_supported(pdev, (char *)&swdata[sw_found].serial_num))
+			continue;
+
+		/* Found a new switch which supports P2P */
+		swdata[sw_found].devfn = pdev->devfn;
+		swdata[sw_found].bus = pdev->bus;
+
+		topology_changed = 1;
+		set_bit(sw_found, sw_found_map);
+		set_bit(sw_found, swdata_valid);
+	}
+
+	/* handle device removal */
+	for_each_clear_bit(bit, sw_found_map, SWD_MAX_VIRT_SWITCH) {
+		if (test_bit(bit, swdata_valid)) {
+			memset(&swdata[bit], 0, sizeof(swdata[i]));
+			clear_bit(bit, swdata_valid);
+			topology_changed = 1;
+		}
+	}
+
+	return topology_changed;
+}
+
+/* Check the various config space registers of the Broadcom PCI device and
+ * return true if the device supports inter switch P2P.
+ * If P2P is supported, return the device serial number back to
+ * caller.
+ */
+bool brcm_sw_is_p2p_supported(struct pci_dev *pdev, char *serial_num)
+{
+	int base;
+	u32 cap_data1, cap_data2;
+	u16 vsec;
+	u32 vsec_data;
+
+	base = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DSN);
+	if (!base) {
+		pr_debug("Failed to get extended capability bus %x devfn %x\n",
+			 pdev->bus->number, pdev->devfn);
+		return false;
+	}
+
+	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_LSI, 1);
+	if (!vsec) {
+		pr_debug("Failed to get VSEC bus %x devfn %x\n",
+			 pdev->bus->number, pdev->devfn);
+		return false;
+	}
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM)
+		return false;
+
+	pci_read_config_dword(pdev, base + 8, &cap_data1);
+	pci_read_config_dword(pdev, base + 4, &cap_data2);
+
+	pci_read_config_dword(pdev, vsec + 12, &vsec_data);
+
+	pr_debug("Found Broadcom device bus 0x%x devfn 0x%x "
+		 "Serial Number: 0x%x 0x%x, VSEC 0x%x\n",
+		 pdev->bus->number, pdev->devfn,
+		 cap_data1, cap_data2, vsec_data);
+
+	if (!SECURE_PART(cap_data1))
+		return false;
+
+	if (!(P2PMASK(vsec_data) & INTER_SWITCH_LINK))
+		return false;
+
+	if (serial_num)
+		snprintf(serial_num, SWD_MAX_CHAR, "%x%x", cap_data1, cap_data2);
+
+	return true;
+}
+
+static int sw_disc_create_sysfs_files(void)
+{
+	int i, j, retval;
+
+	for (i = 0; i < SWD_MAX_VIRT_SWITCH; i++) {
+		if (sw_kobj[i]) {
+			kobject_put(sw_kobj[i]);
+			sw_kobj[i] = NULL;
+		}
+	}
+
+	if (sw_link_kobj) {
+		kobject_put(sw_link_kobj);
+		sw_link_kobj = NULL;
+	}
+
+	sw_link_kobj = kobject_create_and_add(SWD_LINK_DIR_STRING, sw_disc_kobj);
+	if (!sw_link_kobj) {
+		pr_err("Failed to create pci link object\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < SWD_MAX_VIRT_SWITCH; i++) {
+		int segment, bus, device, function;
+		char bdf_i[SWD_MAX_CHAR];
+
+		if (!test_bit(i, swdata_valid))
+			continue;
+
+		segment = pci_domain_nr(swdata[i].bus);
+		bus = swdata[i].bus->number;
+		device = pci_ari_enabled(swdata[i].bus) ?
+				0 : PCI_SLOT(swdata[i].devfn);
+		function = pci_ari_enabled(swdata[i].bus) ?
+				swdata[i].devfn : PCI_FUNC(swdata[i].devfn);
+		sprintf(bdf_i, "%04x:%02x:%02x.%x",
+			segment, bus, device, function);
+
+		for (j = i + 1; j < SWD_MAX_VIRT_SWITCH; j++) {
+			char bdf_j[SWD_MAX_CHAR];
+
+			if (!test_bit(j, swdata_valid))
+				continue;
+			segment = pci_domain_nr(swdata[j].bus);
+			bus = swdata[j].bus->number;
+			device = pci_ari_enabled(swdata[j].bus) ?
+					0 : PCI_SLOT(swdata[j].devfn);
+			function = pci_ari_enabled(swdata[j].bus) ?
+					swdata[j].devfn : PCI_FUNC(swdata[j].devfn);
+			sprintf(bdf_j, "%04x:%02x:%02x.%x",
+				segment, bus, device, function);
+
+			if (strcmp(swdata[i].serial_num, swdata[j].serial_num) == 0) {
+				if (!sw_kobj[i]) {
+					sw_kobj[i] = kobject_create_and_add(bdf_i,
+									    sw_link_kobj);
+					if (!sw_kobj[i]) {
+						pr_err("Failed to create sysfs entry for switch %s\n",
+						       bdf_i);
+					}
+				}
+
+				if (!sw_kobj[j]) {
+					sw_kobj[j] = kobject_create_and_add(bdf_j,
+									    sw_link_kobj);
+					if (!sw_kobj[j]) {
+						pr_err("Failed to create sysfs entry for switch %s\n",
+						       bdf_j);
+					}
+				}
+
+				retval = sysfs_create_link(sw_kobj[i], sw_kobj[j], bdf_j);
+				if (retval)
+					pr_err("Error creating symlink %s and %s\n",
+					       bdf_i, bdf_j);
+
+				retval = sysfs_create_link(sw_kobj[j], sw_kobj[i], bdf_i);
+				if (retval)
+					pr_err("Error creating symlink %s and %s\n",
+					       bdf_j, bdf_i);
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Check if the two pci devices have virtual P2P link available.
+ * This function is used by the p2pdma to determine virtual
+ * links between the PCI-to-PCI bridges
+ */
+bool sw_disc_check_virtual_link(struct pci_dev *a,
+				 struct pci_dev *b)
+{
+	char serial_num_a[SWD_MAX_CHAR], serial_num_b[SWD_MAX_CHAR];
+
+	/*
+	 * Check if the PCIe devices support Virtual P2P links
+	 */
+	if (!sw_disc_is_supported_pdev(a))
+		return false;
+
+	if (!sw_disc_is_supported_pdev(b))
+		return false;
+
+	if (brcm_sw_is_p2p_supported(a, serial_num_a) &&
+	    brcm_sw_is_p2p_supported(b, serial_num_b))
+		if (!strcmp(serial_num_a, serial_num_b))
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(sw_disc_check_virtual_link);
+
+static struct kobj_attribute sw_disc_attribute =
+	__ATTR(SWD_FILE_NAME_STRING, 0444, sw_disc_show, NULL);
+
+// Create attribute group
+static struct attribute *attrs[] = {
+	&sw_disc_attribute.attr,
+	NULL,
+};
+
+static struct attribute_group attr_group = {
+	.attrs = attrs,
+};
+
+static int __init sw_discovery_init(void)
+{
+	int i, retval;
+
+	for (i = 0; i < SWD_MAX_VIRT_SWITCH; i++)
+		sw_kobj[i] = NULL;
+
+	// Create "sw_disc" kobject
+	sw_disc_kobj = kobject_create_and_add(SWD_DIR_STRING, kernel_kobj);
+	if (!sw_disc_kobj) {
+		pr_err("Failed to create sw_disc_kobj\n");
+		return -ENOMEM;
+	}
+
+	retval = sysfs_create_group(sw_disc_kobj, &attr_group);
+	if (retval) {
+		pr_err("Cannot register sysfs attribute group\n");
+		kobject_put(sw_disc_kobj);
+	}
+
+	swdata = kzalloc(sizeof(swdata) * SWD_MAX_VIRT_SWITCH, GFP_KERNEL);
+	if (!swdata) {
+		sysfs_remove_group(sw_disc_kobj, &attr_group);
+		kobject_put(sw_disc_kobj);
+		return 0;
+	}
+
+	pr_info("Loading PCIe switch discovery module, version %s\n",
+		SWITCH_DISC_VERSION);
+
+	return 0;
+}
+
+static void __exit sw_discovery_exit(void)
+{
+	int i;
+
+	if (!swdata)
+		kfree(swdata);
+
+	for (i = 0; i < SWD_MAX_VIRT_SWITCH; i++) {
+		if (sw_kobj[i])
+			kobject_put(sw_kobj[i]);
+	}
+
+	// Remove kobject
+	if (sw_link_kobj)
+		kobject_put(sw_link_kobj);
+
+	sysfs_remove_group(sw_disc_kobj, &attr_group);
+	kobject_put(sw_disc_kobj);
+}
+
+module_init(sw_discovery_init);
+module_exit(sw_discovery_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Broadcom Inc.");
+MODULE_VERSION(SWITCH_DISC_VERSION);
+MODULE_DESCRIPTION("PCIe Switch Discovery Module");
diff --git a/drivers/pci/switch/switch_discovery.h b/drivers/pci/switch/switch_discovery.h
new file mode 100644
index 000000000000..b84f5d2e29ac
--- /dev/null
+++ b/drivers/pci/switch/switch_discovery.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  PCI Switch Discovery module
+ *
+ *  Copyright (c) 2024  Broadcom Inc.
+ *
+ *  Authors: Broadcom Inc.
+ *           Sumanesh Samanta <sumanesh.samanta@broadcom.com>
+ *           Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
+ */
+
+#ifndef PCI_SWITCH_DISC_H
+#define PCI_SWITCH_DISC_H
+
+#define SWD_MAX_SWITCH		32
+#define SWD_MAX_VER_PER_SWITCH	8
+
+#define SWD_MAX_VIRT_SWITCH	(SWD_MAX_SWITCH * SWD_MAX_VER_PER_SWITCH)
+#define SWD_MAX_CHAR		16
+#define SWITCH_DISC_VERSION	"0.1.1"
+#define SWD_DIR_STRING		"pci_switch_link"
+#define SWD_LINK_DIR_STRING	"virtual_switch_links"
+#define SWD_SCAN_DONE		"done\n"
+
+#define SWD_FILE_NAME_STRING	refresh_switch_toplogy
+
+/* Broadcom Vendor Specific definitions */
+#define PCI_VENDOR_ID_LSI			0x1000
+#define PCI_DEVICE_ID_BRCM_PEX_89000_HLC	0xC030
+#define PCI_DEVICE_ID_BRCM_PEX_89000_LLC	0xC034
+
+#define P2PMASK(x)		(((x) & 0x300) >> 8)
+#define SECURE_PART(x)		((x) & 0x8)
+#define INTER_SWITCH_LINK	0x2
+
+struct switch_data {
+	int  devfn;
+	struct pci_bus *bus;
+	char serial_num[SWD_MAX_CHAR];
+};
+
+bool sw_disc_check_virtual_link(struct pci_dev *a, struct pci_dev *b);
+
+#endif /* PCI_SWITCH_DISC_H */
-- 
2.43.0


--000000000000937eb4061aafd1bd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBXYwggReoAMCAQICDFr9U6igf1QRzoaH1TANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwOTMyNDhaFw0yNTA5MTAwOTMyNDhaMIGq
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xIzAhBgNVBAMTGlNoaXZhc2hhcmFuIFNyaWthbnRlc2h3YXJh
MTYwNAYJKoZIhvcNAQkBFidzaGl2YXNoYXJhbi5zcmlrYW50ZXNod2FyYUBicm9hZGNvbS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDulAFNbtc+tsB1JubfhUwbq5745iWy0PqA
tUlf8OsSpnKZPtpZ/P9TJL8MrXyDJN5GdKeVAvh1YAvXb2S0i90gW5qWZtFQ4MRMQwXKHvwdVCTj
NBVuju4wvuIk8TWSSWryDIa/KUmQEFgRethHXcwAGKVM2LV19E+RJxjbqcqBXqT20XVYJ+86q3gC
pKeDdMqs49aS4NkFAulUXfKMvwayi1/al6l6H6NjkYI9V+VAhd2Pw5dVGT1UGNnGenU1ASxrICxB
p1may//a5w+WwgjNTKaKkyc6n0c4ds/TIbS/qi/G87n1VXSpcJHiebcJy8WZCbvo6g9j0Ipsx9mZ
ZyjVAgMBAAGjggHoMIIB5DAOBgNVHQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsG
AQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29t
L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIG
CCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRME
AjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3Bl
cnNvbmFsc2lnbjJjYTIwMjAuY3JsMDIGA1UdEQQrMCmBJ3NoaXZhc2hhcmFuLnNyaWthbnRlc2h3
YXJhQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdb
NHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUOXk95+zAtIGGWGU9q37iyIJKcYMwDQYJKoZIhvcNAQEL
BQADggEBABd5fRmxw/2mYuimst/fZaHYCHDoiYauRKIOm2YcV+s/4xhvXJx0fFit4LzpW8EgTXQv
GQCCaJeSArd/ad3NUOhuQtVB5xOO5cHcCYpdb9gvRPzSZss4mN5OrQsOD6iH0lyg9zIQfhReghMc
Y0C0m8ndFGSil396kqXLgxfPWJ8LChptV9z3iLmGoxJa/gqhi4xu+Ql3ZcQqcP6YItbGOmGjXF/p
uwxVuxQ2ZLaLPPZF5H6t1UPCJRYZXbcjPQHXqFTijI0/1PIUtJy3gUmAsxZe+1n/rCqqCHE4rM+q
Xm1kxB5u/2AMUovVed0IK1+1PFQLP47vY8PfDbSkU4UXH0YxggJtMIICaQIBATBrMFsxCzAJBgNV
BAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdD
QyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxa/VOooH9UEc6Gh9UwDQYJYIZIAWUDBAIBBQCg
gdQwLwYJKoZIhvcNAQkEMSIEIBITWPsCTtHFEOdDgQ/rEmDxDMecR+gMMR7IpbGGeoOyMBgGCSqG
SIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYxMjExMzgxN1owaQYJKoZI
hvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG
9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQBOZIR0vfqEYWY8YYf9GAAg729++4Ut4RLtR3DNmmyWYSK1zd461mhfMF6uO4vGlG37Pf8t
RJtv6dgA4PfE5b1WYqIRBYg7NGGMQdVWcGgoJtrQQo6ERPgiYwv3J8cy1fv4rIsSNgJl+Xl1bjfg
r8ayCzeKfFDotoivIVrnbhXCfceFXyoxnqX65txHrzu6mIDUUYSWqqBdiguk4HjfxIekH9tyBxIL
TrRdsyngypIxqRVPj63u/5wOEsMBRrv4VgTFAbuwcYS7184HZOskYOLJved2/oKSBoxld16w9AAx
9vLGIR8OxXBVcTSCOFtj71VWixsyG3Ehc18BsXRIicdI
--000000000000937eb4061aafd1bd--

