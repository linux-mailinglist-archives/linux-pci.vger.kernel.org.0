Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A2F565EDA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 23:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiGDVUy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 17:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiGDVUy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 17:20:54 -0400
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Jul 2022 14:20:53 PDT
Received: from mx2.absolutedigital.net (mx2.absolutedigital.net [50.242.207.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C78360DC
        for <linux-pci@vger.kernel.org>; Mon,  4 Jul 2022 14:20:53 -0700 (PDT)
Received: from lancer.cnet.absolutedigital.net (lancer.cnet.absolutedigital.net [10.7.5.10])
        by luxor.inet.absolutedigital.net (8.14.4/8.14.4) with ESMTP id 264LCUeD020275
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 4 Jul 2022 17:12:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by lancer.cnet.absolutedigital.net (8.17.1/8.17.1) with ESMTPS id 264LCi1X021531
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Jul 2022 17:12:44 -0400
Date:   Mon, 4 Jul 2022 17:12:44 -0400 (EDT)
From:   Cal Peake <cp@absolutedigital.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Huacai Chen <chenhuacai@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCHv2] vgaarb: Add module param to allow for choosing the boot
 VGA device
Message-ID: <8498ea9f-2ba9-b5da-7dc4-1588363f1b62@absolutedigital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add module parameter 'bootdev' to the VGA arbiter to allow the user
to choose which PCI device should be selected over any others as the
boot VGA device.

When using a multi-GPU system with one or more GPUs being used in
conjunction with VFIO for passthrough to a virtual machine, if the
VGA arbiter settles on a passthrough GPU as the boot VGA device,
once the VFIO PCI driver claims that GPU, all display output is lost
and the result is blank screens and no VT access.

Signed-off-by: Cal Peake <cp@absolutedigital.net>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++++
 drivers/pci/vgaarb.c                          | 40 +++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2522b11e593f..21ac87f4a8a9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6518,6 +6518,13 @@
 			This is actually a boot loader parameter; the value is
 			passed to the kernel using a special protocol.
 
+	vgaarb.bootdev=	[PCI] Specify the PCI ID (e.g. 0e:00.0) of the
+			device to use as the boot VGA device, overriding
+			the heuristic used to normally determine which
+			of the eligible VGA devices to use. If the device
+			specified is not valid or not eligible, then we
+			fallback to the heuristic.
+
 	vm_debug[=options]	[KNL] Available with CONFIG_DEBUG_VM=y.
 			May slow down system boot speed, especially when
 			enabled on systems with a large amount of memory.
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index f80b6ec88dc3..d3689b7dc63d 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -35,6 +35,34 @@
 
 #include <linux/vgaarb.h>
 
+static char *bootdev __initdata;
+module_param(bootdev, charp, 0);
+MODULE_PARM_DESC(bootdev, "Force boot device to the specified PCI ID");
+
+/*
+ * Initialize to the last possible ID to have things work as normal
+ * when no 'bootdev' option is supplied. We especially do not want
+ * this to be zero (0) since that is a valid PCI ID (00:00.0).
+ */
+static u16 bootdev_id = 0xffff;
+
+static void __init parse_bootdev(char *input)
+{
+	unsigned int bus, dev, func;
+	int ret;
+
+	if (input == NULL)
+		return;
+
+	ret = sscanf(input, "%x:%x.%x", &bus, &dev, &func);
+	if (ret != 3) {
+		pr_warn("Improperly formatted PCI ID: %s\n", input);
+		return;
+	}
+
+	bootdev_id = PCI_DEVID(bus, PCI_DEVFN(dev, func));
+}
+
 static void vga_arbiter_notify_clients(void);
 /*
  * We keep a list of all vga devices in the system to speed
@@ -53,6 +81,7 @@ struct vga_device {
 	bool bridge_has_one_vga;
 	bool is_firmware_default;	/* device selected by firmware */
 	unsigned int (*set_decode)(struct pci_dev *pdev, bool decode);
+	bool is_chosen_one;		/* device specified on command line */
 };
 
 static LIST_HEAD(vga_list);
@@ -605,6 +634,7 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
 
 	/*
 	 * We select the default VGA device in this order:
+	 *   User specified device (see module param bootdev=)
 	 *   Firmware framebuffer (see vga_arb_select_default_device())
 	 *   Legacy VGA device (owns VGA_RSRC_LEGACY_MASK)
 	 *   Non-legacy integrated device (see vga_arb_select_default_device())
@@ -612,6 +642,14 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
 	 *   Other device (see vga_arb_select_default_device())
 	 */
 
+	if (boot_vga && boot_vga->is_chosen_one)
+		return false;
+
+	if (bootdev_id == PCI_DEVID(pdev->bus->number, pdev->devfn)) {
+		vgadev->is_chosen_one = true;
+		return true;
+	}
+
 	/*
 	 * We always prefer a firmware default device, so if we've already
 	 * found one, there's no need to consider vgadev.
@@ -1544,6 +1582,8 @@ static int __init vga_arb_device_init(void)
 	int rc;
 	struct pci_dev *pdev;
 
+	parse_bootdev(bootdev);
+
 	rc = misc_register(&vga_arb_device);
 	if (rc < 0)
 		pr_err("error %d registering device\n", rc);
-- 
2.35.3

