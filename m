Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC82C6191ED
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 08:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiKDH2D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 03:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiKDH1l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 03:27:41 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A3AC2A70D;
        Fri,  4 Nov 2022 00:27:37 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8BxfdrovmRjDW4EAA--.15553S3;
        Fri, 04 Nov 2022 15:27:36 +0800 (CST)
Received: from loongson-PC.loongson.cn (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxJlfivmRj5lANAA--.19331S2;
        Fri, 04 Nov 2022 15:27:35 +0800 (CST)
From:   Liu Peibao <liupeibao@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] PCI: loongson: skip scanning unavailable child device
Date:   Fri,  4 Nov 2022 15:27:30 +0800
Message-Id: <20221104072730.14631-1-liupeibao@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxJlfivmRj5lANAA--.19331S2
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQATCmNjr2MLBQAFsf
X-Coremail-Antispam: 1Uk129KBjvJXoWxJw4fJrWrGw17Jry5Ww45Wrg_yoW5AryDpF
        W3Aay3Kr4rtr1I9ws5t3yUCr1a9Fsa93s3JFs7Cwnagr9Fy3y0gFy8JF1jy3ySyrW8WF1a
        qFWvgr48CF4UJFUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
        vjxU466zUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI Controller of 2k1000 could not mask devices by
setting vender id or device id in configuration space header
as invalid values. When there are pins shareble between
the platform device and PCI device, if the platform device
is preferred, we should not scan this PCI device. In the
above scene, add `status = "disabled"` property in DT node
of this PCI device.

Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
---
V1 -> V2: use existing property "status" instead of adding new property.

 drivers/pci/controller/pci-loongson.c | 57 +++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 05c50408f13b..cde8a8691867 100644
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
@@ -206,6 +230,36 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
 }
 
 #ifdef CONFIG_OF
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
+		/*
+		 * if device is not available, add this to masklist
+		 * to avoid scanning it.
+		 */
+		if (!of_device_is_available(dn)) {
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
@@ -305,6 +359,9 @@ static int loongson_pci_probe(struct platform_device *pdev)
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

