Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E10D632086
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2019 20:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfFASmU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Jun 2019 14:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfFASmU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 1 Jun 2019 14:42:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE0572778F;
        Sat,  1 Jun 2019 18:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559414539;
        bh=ylnKia+EXLW9UtRpuoBndbxg1FaaVmOOmXi44ieoevU=;
        h=From:To:Cc:Subject:Date:From;
        b=vnqPgUaDzPJBjIlMCH529iITpLub312OLe1uqC160m3zYVgOwFPiQkuczuxPoBzh2
         th081fLvjEZn2+u3zzngf5tycTi3Pzf5Tdl+QNPRQF328ekR7/z/LGwvdvnihc0Rvp
         DVuHYF6TpXx22H7d4zv7fccAke6dAjJmlFFEFQXQ=
From:   Sasha Levin <sashal@kernel.org>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>, stable@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH] PCI: hv: Detect and fix Hyper-V PCI domain number collision
Date:   Sat,  1 Jun 2019 14:42:11 -0400
Message-Id: <20190601184211.8733-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>

Due to Azure host agent settings, the device instance ID's bytes 8 and 9
are no longer unique. This causes some of the PCI devices not showing up
in VMs with multiple passthrough devices, such as GPUs. So, as recommended
by Azure host team, we now use the bytes 4 and 5 which usually provide
unique numbers.

In the rare cases of collision, we will detect and find another number
that is not in use.
Thanks to Michael Kelley <mikelley@microsoft.com> for proposing this idea.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Cc: stable@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-hyperv.c | 91 ++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 82acd6155adf3..6b9cc6e60a040 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -37,6 +37,8 @@
  * the PCI back-end driver in Hyper-V.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -2507,6 +2509,47 @@ static void put_hvpcibus(struct hv_pcibus_device *hbus)
 		complete(&hbus->remove_event);
 }
 
+#define HVPCI_DOM_MAP_SIZE (64 * 1024)
+static DECLARE_BITMAP(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
+
+/* PCI domain number 0 is used by emulated devices on Gen1 VMs, so define 0
+ * as invalid for passthrough PCI devices of this driver.
+ */
+#define HVPCI_DOM_INVALID 0
+
+/**
+ * hv_get_dom_num() - Get a valid PCI domain number
+ * Check if the PCI domain number is in use, and return another number if
+ * it is in use.
+ *
+ * @dom: Requested domain number
+ *
+ * return: domain number on success, HVPCI_DOM_INVALID on failure
+ */
+static u16 hv_get_dom_num(u16 dom)
+{
+	unsigned int i;
+
+	if (test_and_set_bit(dom, hvpci_dom_map) == 0)
+		return dom;
+
+	for_each_clear_bit(i, hvpci_dom_map, HVPCI_DOM_MAP_SIZE) {
+		if (test_and_set_bit(i, hvpci_dom_map) == 0)
+			return i;
+	}
+
+	return HVPCI_DOM_INVALID;
+}
+
+/**
+ * hv_put_dom_num() - Mark the PCI domain number as free
+ * @dom: Domain number to be freed
+ */
+static void hv_put_dom_num(u16 dom)
+{
+	clear_bit(dom, hvpci_dom_map);
+}
+
 /**
  * hv_pci_probe() - New VMBus channel probe, for a root PCI bus
  * @hdev:	VMBus's tracking struct for this root PCI bus
@@ -2518,6 +2561,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 			const struct hv_vmbus_device_id *dev_id)
 {
 	struct hv_pcibus_device *hbus;
+	u16 dom_req, dom;
 	int ret;
 
 	/*
@@ -2532,19 +2576,32 @@ static int hv_pci_probe(struct hv_device *hdev,
 	hbus->state = hv_pcibus_init;
 
 	/*
-	 * The PCI bus "domain" is what is called "segment" in ACPI and
-	 * other specs.  Pull it from the instance ID, to get something
-	 * unique.  Bytes 8 and 9 are what is used in Windows guests, so
-	 * do the same thing for consistency.  Note that, since this code
-	 * only runs in a Hyper-V VM, Hyper-V can (and does) guarantee
-	 * that (1) the only domain in use for something that looks like
-	 * a physical PCI bus (which is actually emulated by the
-	 * hypervisor) is domain 0 and (2) there will be no overlap
-	 * between domains derived from these instance IDs in the same
-	 * VM.
+	 * The PCI bus "domain" is what is called "segment" in ACPI and other
+	 * specs. Pull it from the instance ID, to get something usually
+	 * unique. In rare cases of collision, we will find out another number
+	 * not in use.
+	 * Note that, since this code only runs in a Hyper-V VM, Hyper-V
+	 * together with this guest driver can guarantee that (1) The only
+	 * domain used by Gen1 VMs for something that looks like a physical
+	 * PCI bus (which is actually emulated by the hypervisor) is domain 0.
+	 * (2) There will be no overlap between domains (after fixing possible
+	 * collisions) in the same VM.
 	 */
-	hbus->sysdata.domain = hdev->dev_instance.b[9] |
-			       hdev->dev_instance.b[8] << 8;
+	dom_req = hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
+	dom = hv_get_dom_num(dom_req);
+
+	if (dom == HVPCI_DOM_INVALID) {
+		pr_err("Unable to use dom# 0x%hx or other numbers",
+		       dom_req);
+		ret = -EINVAL;
+		goto free_bus;
+	}
+
+	if (dom != dom_req)
+		pr_info("PCI dom# 0x%hx has collision, using 0x%hx",
+			dom_req, dom);
+
+	hbus->sysdata.domain = dom;
 
 	hbus->hdev = hdev;
 	refcount_set(&hbus->remove_lock, 1);
@@ -2559,7 +2616,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 					   hbus->sysdata.domain);
 	if (!hbus->wq) {
 		ret = -ENOMEM;
-		goto free_bus;
+		goto free_dom;
 	}
 
 	ret = vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0,
@@ -2636,6 +2693,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 	vmbus_close(hdev->channel);
 destroy_wq:
 	destroy_workqueue(hbus->wq);
+free_dom:
+	hv_put_dom_num(hbus->sysdata.domain);
 free_bus:
 	free_page((unsigned long)hbus);
 	return ret;
@@ -2717,6 +2776,9 @@ static int hv_pci_remove(struct hv_device *hdev)
 	put_hvpcibus(hbus);
 	wait_for_completion(&hbus->remove_event);
 	destroy_workqueue(hbus->wq);
+
+	hv_put_dom_num(hbus->sysdata.domain);
+
 	free_page((unsigned long)hbus);
 	return 0;
 }
@@ -2744,6 +2806,9 @@ static void __exit exit_hv_pci_drv(void)
 
 static int __init init_hv_pci_drv(void)
 {
+	/* Set the invalid domain number's bit, so it will not be used */
+	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
+
 	return vmbus_driver_register(&hv_pci_drv);
 }
 
-- 
2.20.1

