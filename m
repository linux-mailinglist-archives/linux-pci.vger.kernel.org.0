Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09652BC467
	for <lists+linux-pci@lfdr.de>; Sun, 22 Nov 2020 08:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgKVHfl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Nov 2020 02:35:41 -0500
Received: from fralinode-sdnproxy-1.icoremail.net ([172.104.134.221]:39090
        "HELO fralinode-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1725978AbgKVHfl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Nov 2020 02:35:41 -0500
Received: from localhost (unknown [113.247.217.134])
        by c1app7 (Coremail) with SMTP id BwINCgDX3+OhFLpfN5PqAA--.13475S3;
        Sun, 22 Nov 2020 15:34:58 +0800 (CST)
From:   Chen Baozi <chenbaozi@phytium.com.cn>
To:     Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [RFC PATCH v3 1/2] PCI/ACPI: Add stacked IRQ domain support to PCI Interrupt Link
Date:   Sun, 22 Nov 2020 15:34:52 +0800
Message-Id: <20201122073453.5758-1-chenbaozi@phytium.com.cn>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BwINCgDX3+OhFLpfN5PqAA--.13475S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WFyrXr1kAFy3WFyftrWrZrb_yoWfWr1xpF
        WfK3W7Ar48Xr4UWrs0ya1rAF1aq3W0yrW2krW5CwnaganI9ryrtF17CFy8JryYy395GF42
        vr1qyFy8GFyDZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUg7KsDUUUU
X-CM-SenderInfo: hfkh0updr2xqxsk13x1xpou0fpof0/1tbiDALkP17uHyEOYAAAs1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ResourceSource field of an Extended Interrupt Descriptor was ignored
when the driver is parsing _PRS method of PNP0C0F PCI Interrupt Link
devices, which means PCI INTx would be always registered under the GSI
domain. This patch introduces stacked IRQ domain support to PCI Interrupt
Link devices for ACPI.

With this support, we can populate the ResourceSource field in _PRS method
of PCI Interrupt Link devices to refer to a device object that describes
an interrupt controller as the following examples:

  Device (IXIU) {
    ...
  }

  Device(LINKA) {
    Name(_HID, EISAID("PNP0C0F"))
    Name(_PRS, ResourceTemplate(){
      Interrupt(ResourceProducer, Level, ActiveHigh, Exclusive,
                0, "\\SB.IXIU") { 60 }
    })
    ...
  }

Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
---
 drivers/acpi/internal.h     | 12 ++++++++++++
 drivers/acpi/irq.c          | 34 ++++++++++++++++++++--------------
 drivers/acpi/pci_irq.c      |  8 ++++++--
 drivers/acpi/pci_link.c     | 17 +++++++++++++++--
 include/acpi/acpi_drivers.h |  2 +-
 include/linux/acpi.h        | 10 ++++++++++
 6 files changed, 64 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index e3638bafb941..38ebe24bce3b 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -88,6 +88,18 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent);
 acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context);
 void acpi_scan_table_handler(u32 event, void *table, void *context);
 
+#ifdef CONFIG_ACPI_GENERIC_GSI
+int acpi_register_irq(struct device *dev, u32 hwirq, int trigger,
+		      int polarity, struct fwnode_handle *fwnode);
+#else
+static inline
+int acpi_register_irq(struct device *dev, u32 hwirq, int trigger,
+		      int polarity, struct fwnode_handle *fwnode)
+{
+	return acpi_register_gsi(dev, hwirq, trigger, polarity);
+}
+#endif
+
 /* --------------------------------------------------------------------------
                      Device Node Initialization / Removal
    -------------------------------------------------------------------------- */
diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index e209081d644b..2fff5401c3f3 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -38,6 +38,24 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 }
 EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 
+int acpi_register_irq(struct device *dev, u32 hwirq, int trigger,
+		      int polarity, struct fwnode_handle *fwnode)
+{
+	struct irq_fwspec fwspec;
+
+	if (!fwnode) {
+		dev_warn(dev, "No registered irqchip for hwirq %d\n", hwirq);
+		return -EINVAL;
+	}
+
+	fwspec.fwnode = fwnode;
+	fwspec.param[0] = hwirq;
+	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
+	fwspec.param_count = 2;
+
+	return irq_create_fwspec_mapping(&fwspec);
+}
+
 /**
  * acpi_register_gsi() - Map a GSI to a linux IRQ number
  * @dev: device for which IRQ has to be mapped
@@ -51,19 +69,7 @@ EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
-	struct irq_fwspec fwspec;
-
-	if (WARN_ON(!acpi_gsi_domain_id)) {
-		pr_warn("GSI: No registered irqchip, giving up\n");
-		return -EINVAL;
-	}
-
-	fwspec.fwnode = acpi_gsi_domain_id;
-	fwspec.param[0] = gsi;
-	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
-	fwspec.param_count = 2;
-
-	return irq_create_fwspec_mapping(&fwspec);
+	return acpi_register_irq(dev, gsi, trigger, polarity, acpi_gsi_domain_id);
 }
 EXPORT_SYMBOL_GPL(acpi_register_gsi);
 
@@ -92,7 +98,7 @@ EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
  * Return:
  * The referenced device fwhandle or NULL on failure
  */
-static struct fwnode_handle *
+struct fwnode_handle *
 acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source)
 {
 	struct fwnode_handle *result;
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 14ee631cb7cf..5cccc0f70781 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -22,6 +22,8 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 
+#include "internal.h"
+
 #define PREFIX "ACPI: "
 
 #define _COMPONENT		ACPI_PCI_COMPONENT
@@ -410,6 +412,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	char *link = NULL;
 	char link_desc[16];
 	int rc;
+	struct fwnode_handle *rs_fwnode;
 
 	pin = dev->pin;
 	if (!pin) {
@@ -438,7 +441,8 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 			gsi = acpi_pci_link_allocate_irq(entry->link,
 							 entry->index,
 							 &triggering, &polarity,
-							 &link);
+							 &link,
+							 &rs_fwnode);
 		else
 			gsi = entry->index;
 	} else
@@ -462,7 +466,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		return 0;
 	}
 
-	rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
+	rc = acpi_register_irq(&dev->dev, gsi, triggering, polarity, rs_fwnode);
 	if (rc < 0) {
 		dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
 			 pin_name(pin));
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index fb4c5632a232..2b6f6478bb30 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -59,6 +59,7 @@ struct acpi_pci_link_irq {
 	u8 resource_type;
 	u8 possible_count;
 	u32 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
+	struct acpi_resource_source resource_source;
 	u8 initialized:1;
 	u8 reserved:7;
 };
@@ -120,6 +121,8 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
 		{
 			struct acpi_resource_extended_irq *p =
 			    &resource->data.extended_irq;
+			struct acpi_resource_source *rs =
+			    &link->irq.resource_source;
 			if (!p || !p->interrupt_count) {
 				printk(KERN_WARNING PREFIX
 					      "Blank _PRS EXT IRQ resource\n");
@@ -140,6 +143,12 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
 			link->irq.triggering = p->triggering;
 			link->irq.polarity = p->polarity;
 			link->irq.resource_type = ACPI_RESOURCE_TYPE_EXTENDED_IRQ;
+			if (p->resource_source.string_length) {
+				rs->index = p->resource_source.index;
+				rs->string_length = p->resource_source.string_length;
+				rs->string_ptr = kstrdup(p->resource_source.string_ptr,
+							 GFP_KERNEL);
+			}
 			break;
 		}
 	default:
@@ -326,7 +335,8 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
 			resource->res.data.extended_irq.shareable = ACPI_SHARED;
 		resource->res.data.extended_irq.interrupt_count = 1;
 		resource->res.data.extended_irq.interrupts[0] = irq;
-		/* ignore resource_source, it's optional */
+		resource->res.data.extended_irq.resource_source =
+			link->irq.resource_source;
 		break;
 	default:
 		printk(KERN_ERR PREFIX "Invalid Resource_type %d\n", link->irq.resource_type);
@@ -612,7 +622,7 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
  * failure: return -1
  */
 int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
-			       int *polarity, char **name)
+			       int *polarity, char **name, struct fwnode_handle **rs_fwnode)
 {
 	int result;
 	struct acpi_device *device;
@@ -656,6 +666,9 @@ int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
 		*polarity = link->irq.polarity;
 	if (name)
 		*name = acpi_device_bid(link->device);
+	if (rs_fwnode)
+		*rs_fwnode = acpi_get_irq_source_fwhandle(&link->irq.resource_source);
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "Link %s is referenced\n",
 			  acpi_device_bid(link->device)));
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 5eb175933a5b..dbdcd2f51d4c 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -68,7 +68,7 @@
 
 int acpi_irq_penalty_init(void);
 int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
-			       int *polarity, char **name);
+			       int *polarity, char **name, struct fwnode_handle **rs_fwnode);
 int acpi_pci_link_free_irq(acpi_handle handle);
 
 /* ACPI PCI Device Binding (pci_bind.c) */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 39263c6b52e1..b182a267fe66 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -336,6 +336,16 @@ struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
 					     const struct irq_domain_ops *ops,
 					     void *host_data);
 
+#ifdef CONFIG_ACPI_GENERIC_GSI
+struct fwnode_handle *acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source);
+#else
+static inline
+struct fwnode_handle *acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source)
+{
+	return NULL;
+}
+#endif
+
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
 #else
-- 
2.28.0

