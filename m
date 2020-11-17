Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A0B2B5DB1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 12:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgKQK7m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 05:59:42 -0500
Received: from fralinode-sdnproxy-1.icoremail.net ([172.104.134.221]:23356
        "HELO fralinode-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1725774AbgKQK7m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 05:59:42 -0500
X-Greylist: delayed 763 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2020 05:59:38 EST
Received: from localhost (unknown [218.77.105.7])
        by c1app9 (Coremail) with SMTP id CQINCgAHHZ8UqrNf2GxnAA--.1812S3;
        Tue, 17 Nov 2020 18:46:44 +0800 (CST)
From:   Chen Baozi <chenbaozi@phytium.com.cn>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RFC PATCH] acpi/irq: Add stacked IRQ domain support to PCI interrupt link
Date:   Tue, 17 Nov 2020 18:46:40 +0800
Message-Id: <20201117104640.25227-1-chenbaozi@phytium.com.cn>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: CQINCgAHHZ8UqrNf2GxnAA--.1812S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuw13uFyxXF47Wry8WF1kGrg_yoW3uFyUpF
        Wxt3WUArW8Xr4UWrs8Aa1rAF9xXa4jkrWUK3y3C3sIqanIgryrtF17CFyUAw1Ykws8Way2
        vr1UAF18GF9rZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8twCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bOlk3UUUUU=
X-CM-SenderInfo: hfkh0updr2xqxsk13x1xpou0fpof0/1tbiDADfP17uHvQfYQAAsI
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some PCIe designs require software to do extra acknowledgements for
legacy INTx interrupts. If the driver is written only for device tree,
things are simple. In that case, a new driver can be written under
driver/pci/controller/ with a DT node of PCIe host written like:

  pcie {
    ...
    interrupt-map = <0 0 0  1  &pcie_intc 0>,
                    <0 0 0  2  &pcie_intc 1>,
                    <0 0 0  3  &pcie_intc 2>,
                    <0 0 0  4  &pcie_intc 3>;

    pcie_intc: legacy-interrupt-controller {
      interrupt-controller;
      #interrupt-cells = <1>;
      interrupt-parent = <&gic>;
      interrupts = <0 226 4>;
    };
  };

Similar designs can be found on Aardvark, MediaTek Gen2 and Socionext
UniPhier PCIe controller at the moment. Essentially, those designs are
supported by inserting an extra interrupt controller between PCIe host
and GIC and parse the topology in a DT-based PCI controller driver.
As we turn to ACPI, All the PCIe hosts are described the same ID of
"PNP0A03" and share driver/acpi/pci_root.c. It comes to be a problem
to make this kind of PCI INTx work under ACPI.

Therefore, we introduce an stacked IRQ domain support to PCI interrupt
link for ACPI. With this support, we can populate the ResourceSource
to refer to a device object that describes an interrupt controller.
That would allow us to refer to a dedicated driver which implements
the logic needed to manage the interrupt state.

Signed-off-by: Chen Baozi <chenbaozi@phytium.com.cn>
---
 drivers/acpi/irq.c          | 22 +++++++++++++++++++++-
 drivers/acpi/pci_irq.c      |  6 ++++--
 drivers/acpi/pci_link.c     | 17 +++++++++++++++--
 include/acpi/acpi_drivers.h |  2 +-
 include/linux/acpi.h        |  4 ++++
 5 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index e209081d644b..e78a44815c44 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -81,6 +81,25 @@ void acpi_unregister_gsi(u32 gsi)
 }
 EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
 
+int acpi_register_irq(struct device *dev, u32 irq, int trigger,
+		      int polarity, struct fwnode_handle *domain_id)
+{
+	struct irq_fwspec fwspec;
+
+	if (WARN_ON(!domain_id)) {
+		pr_warn("GSI: No registered irqchip, giving up\n");
+		return -EINVAL;
+	}
+
+	fwspec.fwnode = domain_id;
+	fwspec.param[0] = irq;
+	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
+	fwspec.param_count = 2;
+
+	return irq_create_fwspec_mapping(&fwspec);
+}
+EXPORT_SYMBOL_GPL(acpi_register_irq);
+
 /**
  * acpi_get_irq_source_fwhandle() - Retrieve fwhandle from IRQ resource source.
  * @source: acpi_resource_source to use for the lookup.
@@ -92,7 +111,7 @@ EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
  * Return:
  * The referenced device fwhandle or NULL on failure
  */
-static struct fwnode_handle *
+struct fwnode_handle *
 acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source)
 {
 	struct fwnode_handle *result;
@@ -115,6 +134,7 @@ acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source)
 	acpi_bus_put_acpi_device(device);
 	return result;
 }
+EXPORT_SYMBOL_GPL(acpi_get_irq_source_fwhandle);
 
 /*
  * Context for the resource walk used to lookup IRQ resources.
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index 14ee631cb7cf..19296d70c95c 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -410,6 +410,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 	char *link = NULL;
 	char link_desc[16];
 	int rc;
+	struct fwnode_handle *irq_domain;
 
 	pin = dev->pin;
 	if (!pin) {
@@ -438,7 +439,8 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 			gsi = acpi_pci_link_allocate_irq(entry->link,
 							 entry->index,
 							 &triggering, &polarity,
-							 &link);
+							 &link,
+							 &irq_domain);
 		else
 			gsi = entry->index;
 	} else
@@ -462,7 +464,7 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
 		return 0;
 	}
 
-	rc = acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
+	rc = acpi_register_irq(&dev->dev, gsi, triggering, polarity, irq_domain);
 	if (rc < 0) {
 		dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
 			 pin_name(pin));
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index fb4c5632a232..219a644d739a 100644
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
+				rs->string_ptr = kmalloc(rs->string_length, GFP_KERNEL);
+				strcpy(rs->string_ptr, p->resource_source.string_ptr);
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
+			       int *polarity, char **name, struct fwnode_handle **irq_domain)
 {
 	int result;
 	struct acpi_device *device;
@@ -656,6 +666,9 @@ int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
 		*polarity = link->irq.polarity;
 	if (name)
 		*name = acpi_device_bid(link->device);
+	if (irq_domain)
+		*irq_domain = acpi_get_irq_source_fwhandle(&link->irq.resource_source);
+
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "Link %s is referenced\n",
 			  acpi_device_bid(link->device)));
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 5eb175933a5b..6ff1ea76d476 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -68,7 +68,7 @@
 
 int acpi_irq_penalty_init(void);
 int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
-			       int *polarity, char **name);
+			       int *polarity, char **name, struct fwnode_handle **irq_domain);
 int acpi_pci_link_free_irq(acpi_handle handle);
 
 /* ACPI PCI Device Binding (pci_bind.c) */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 39263c6b52e1..5f1d7d3192fb 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -324,6 +324,8 @@ extern int sbf_port;
 extern unsigned long acpi_realmode_flags;
 
 int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity);
+int acpi_register_irq(struct device *dev, u32 gsi, int trigger,
+		      int polarity, struct fwnode_handle *domain_id);
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
 
@@ -336,6 +338,8 @@ struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
 					     const struct irq_domain_ops *ops,
 					     void *host_data);
 
+struct fwnode_handle *acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source);
+
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
 #else
-- 
2.28.0

