Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC6B61794A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 10:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiKCJAt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 05:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiKCJAs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 05:00:48 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FF1C5F66;
        Thu,  3 Nov 2022 02:00:46 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8Axjrc9g2Nj3zAEAA--.9608S3;
        Thu, 03 Nov 2022 17:00:45 +0800 (CST)
Received: from loongson-PC.loongson.cn (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxoOI4g2NjSJMLAA--.33260S2;
        Thu, 03 Nov 2022 17:00:44 +0800 (CST)
From:   Liu Peibao <liupeibao@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     chenhuacai@loongson.cn, lvjianmin@loongson.cn,
        zhuyinbo@loongson.cn, liupeibao@loongson.cn,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: loongson: add skip-scan property for child DT node
Date:   Thu,  3 Nov 2022 17:00:39 +0800
Message-Id: <20221103090040.836-1-liupeibao@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxoOI4g2NjSJMLAA--.33260S2
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQATCmNiXeMWTAADs+
X-Coremail-Antispam: 1Uk129KBjvJXoWxZF15JFW7Zr1xtw48tFyxZrb_yoW5ZryxpF
        W5Aay3Kr48Kr1IgwnYq3yUCr1a9an7Z3s3JFZ7C3sFgr9Iv340gry8JF1Yy3ySkrW8WF4a
        qryqgr48CF4UAF7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
        kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8HKZJUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI Controller of 2k1000 could not mask devices by
setting vender id & device id in configuration space header
as invalid values. When there are pins shareble between
the platform device and PCI device, if the platform device
is preferred, we should not scan this PCI device. In the
above scene, add "skip-scan" property in DT node of this
PCI device.

Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 62 +++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 05c50408f13b..4b97963977c7 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -40,11 +40,21 @@ struct loongson_pci_data {
 	struct pci_ops *ops;
 };
 
+#ifdef CONFIG_OF
+struct mask_entry {
+	struct list_head entry;
+	unsigned int devfn;
+};
+#endif
+
 struct loongson_pci {
 	void __iomem *cfg0_base;
 	void __iomem *cfg1_base;
 	struct platform_device *pdev;
 	const struct loongson_pci_data *data;
+#ifdef CONFIG_OF
+	struct list_head masklist;
+#endif
 };
 
 /* Fixup wrong class code in PCIe bridges */
@@ -194,6 +204,20 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
 			return NULL;
 	}
 
+#ifdef CONFIG_OF
+	/* Don't access devices in masklist */
+	if (pci_is_root_bus(bus)) {
+		struct list_head *list;
+		struct mask_entry *entry;
+
+		list_for_each(list, &priv->masklist) {
+			entry = list_entry(list, struct mask_entry, entry);
+			if (devfn == entry->devfn)
+				return NULL;
+		}
+	}
+#endif
+
 	/* CFG0 can only access standard space */
 	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
 		return cfg0_map(priv, bus, devfn, where);
@@ -206,6 +230,41 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
 }
 
 #ifdef CONFIG_OF
+/*
+ * The PCI Controller of 2k1000 could not mask devices by
+ * setting vender id & device id in configuration space
+ * header as invalid values. When there are pins shareble
+ * between the platform device and PCI device, if the
+ * platform device is preferred, we should not scan this
+ * PCI device. In the above scene, add "skip-scan" property
+ * in the device tree node of this PCI device.
+ */
+static int setup_masklist(struct loongson_pci *priv)
+{
+	struct device *dev = &priv->pdev->dev;
+	struct device_node *dn, *parent = dev->of_node;
+	struct mask_entry *entry;
+	int devfn;
+
+	INIT_LIST_HEAD(&priv->masklist);
+
+	for_each_child_of_node(parent, dn) {
+		if (of_property_read_bool(dn, "skip-scan")) {
+			devfn = of_pci_get_devfn(dn);
+			if (devfn < 0)
+				continue;
+
+			entry = devm_kzalloc(dev, sizeof(entry), GFP_KERNEL);
+			if (!entry)
+				return -ENOMEM;
+
+			entry->devfn = devfn;
+			list_add_tail(&entry->entry, &priv->masklist);
+		}
+	}
+
+	return 0;
+}
 
 static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
@@ -305,6 +364,9 @@ static int loongson_pci_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (setup_masklist(priv))
+		return -ENOMEM;
+
 	bridge->sysdata = priv;
 	bridge->ops = priv->data->ops;
 	bridge->map_irq = loongson_map_irq;
-- 
2.20.1

