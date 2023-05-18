Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116D9707CB2
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 11:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjERJWu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 05:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjERJWu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 05:22:50 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1378211B;
        Thu, 18 May 2023 02:22:47 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxRPBm7mVkM84JAA--.17280S3;
        Thu, 18 May 2023 17:22:46 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxWdJi7mVkSKFnAA--.45037S2;
        Thu, 18 May 2023 17:22:45 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v1] usb: dwc2: add pci_device_id driver_data parse support
Date:   Thu, 18 May 2023 17:22:40 +0800
Message-Id: <20230518092240.8023-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxWdJi7mVkSKFnAA--.45037S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxur4xWF13GFWrZry7Kr13XFb_yoW7Jr1DpF
        ZrZFW0yrWktFsxCw13CF4UAFy5Zan7J34UCa47Kw1S9FZ7Ar4rXF1jkr45Cr93t390ga12
        vF17tw48CF47J37anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bVAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1s
        IEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5
        HUDUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The dwc2 driver has everything we need to run in PCI mode except
for pci_device_id driver_data parse.  With that to set Loongson
dwc2 element and added identified as PCI_VENDOR_ID_LOONGSON
and PCI_DEVICE_ID_LOONGSON_DWC2 in dwc2_pci_ids, the Loongson
dwc2 controller will work.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 drivers/usb/dwc2/core.h   |  1 +
 drivers/usb/dwc2/params.c | 33 +++++++++++++++++++++++++++++++--
 drivers/usb/dwc2/pci.c    | 14 +-------------
 include/linux/pci_ids.h   |  2 ++
 4 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 0bb4c0c845bf..c92a1da46a01 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1330,6 +1330,7 @@ irqreturn_t dwc2_handle_common_intr(int irq, void *dev);
 /* The device ID match table */
 extern const struct of_device_id dwc2_of_match_table[];
 extern const struct acpi_device_id dwc2_acpi_match[];
+extern const struct pci_device_id dwc2_pci_ids[];
 
 int dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg);
 int dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg);
diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 21d16533bd2f..f7550d293c2d 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -7,6 +7,8 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/usb/of.h>
+#include <linux/pci_ids.h>
+#include <linux/pci.h>
 
 #include "core.h"
 
@@ -55,6 +57,14 @@ static void dwc2_set_jz4775_params(struct dwc2_hsotg *hsotg)
 		!device_property_read_bool(hsotg->dev, "disable-over-current");
 }
 
+static void dwc2_set_loongson_params(struct dwc2_hsotg *hsotg)
+{
+	struct dwc2_core_params *p = &hsotg->params;
+
+	p->phy_utmi_width = 8;
+	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
+}
+
 static void dwc2_set_x1600_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
@@ -281,6 +291,22 @@ const struct acpi_device_id dwc2_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, dwc2_acpi_match);
 
+const struct pci_device_id dwc2_pci_ids[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_PRODUCT_ID_HAPS_HSOTG),
+	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_STMICRO,
+			   PCI_DEVICE_ID_STMICRO_USB_OTG),
+	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_DWC2),
+		.driver_data = (unsigned long)dwc2_set_loongson_params,
+	},
+	{ /* end: all zeroes */ }
+};
+MODULE_DEVICE_TABLE(pci, dwc2_pci_ids);
+
 static void dwc2_set_param_otg_cap(struct dwc2_hsotg *hsotg)
 {
 	switch (hsotg->hw_params.op_mode) {
@@ -929,10 +955,13 @@ int dwc2_init_params(struct dwc2_hsotg *hsotg)
 		set_params(hsotg);
 	} else {
 		const struct acpi_device_id *amatch;
+		const struct pci_device_id *pmatch;
 
 		amatch = acpi_match_device(dwc2_acpi_match, hsotg->dev);
-		if (amatch && amatch->driver_data) {
-			set_params = (set_params_cb)amatch->driver_data;
+		pmatch = pci_match_id(dwc2_pci_ids, to_pci_dev(hsotg->dev->parent));
+
+		if ((amatch && amatch->driver_data) || (pmatch && pmatch->driver_data)) {
+			set_params = (set_params_cb)pmatch->driver_data;
 			set_params(hsotg);
 		}
 	}
diff --git a/drivers/usb/dwc2/pci.c b/drivers/usb/dwc2/pci.c
index b7306ed8be4c..f3a1e4232a31 100644
--- a/drivers/usb/dwc2/pci.c
+++ b/drivers/usb/dwc2/pci.c
@@ -24,7 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/usb/usb_phy_generic.h>
 
-#define PCI_PRODUCT_ID_HAPS_HSOTG	0xabc0
+#include "core.h"
 
 static const char dwc2_driver_name[] = "dwc2-pci";
 
@@ -122,18 +122,6 @@ static int dwc2_pci_probe(struct pci_dev *pci,
 	return ret;
 }
 
-static const struct pci_device_id dwc2_pci_ids[] = {
-	{
-		PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_PRODUCT_ID_HAPS_HSOTG),
-	},
-	{
-		PCI_DEVICE(PCI_VENDOR_ID_STMICRO,
-			   PCI_DEVICE_ID_STMICRO_USB_OTG),
-	},
-	{ /* end: all zeroes */ }
-};
-MODULE_DEVICE_TABLE(pci, dwc2_pci_ids);
-
 static struct pci_driver dwc2_pci_driver = {
 	.name = dwc2_driver_name,
 	.id_table = dwc2_pci_ids,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e43ab203054a..6481f648695a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -157,6 +157,7 @@
 #define PCI_VENDOR_ID_PCI_SIG		0x0001
 
 #define PCI_VENDOR_ID_LOONGSON		0x0014
+#define PCI_DEVICE_ID_LOONGSON_DWC2	0x7a04
 
 #define PCI_VENDOR_ID_SOLIDIGM		0x025e
 
@@ -2356,6 +2357,7 @@
 #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI	0xabce
 #define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31	0xabcf
 #define PCI_DEVICE_ID_SYNOPSYS_EDDA	0xedda
+#define PCI_PRODUCT_ID_HAPS_HSOTG       0xabc0
 
 #define PCI_VENDOR_ID_USR		0x16ec
 
-- 
2.20.1

