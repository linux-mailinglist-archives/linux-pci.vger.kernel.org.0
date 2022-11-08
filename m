Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E606209A6
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 07:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiKHGmu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 01:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbiKHGmt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 01:42:49 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E9991EAD2;
        Mon,  7 Nov 2022 22:42:47 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8Dx_Nhl+mljRj0FAA--.16952S3;
        Tue, 08 Nov 2022 14:42:45 +0800 (CST)
Received: from loongson-PC.loongson.cn (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxZ1dg+mljwdAOAA--.23277S2;
        Tue, 08 Nov 2022 14:42:45 +0800 (CST)
From:   Liu Peibao <liupeibao@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4] PCI: loongson: Skip scanning unavailable child devices
Date:   Tue,  8 Nov 2022 14:42:40 +0800
Message-Id: <20221108064240.8030-1-liupeibao@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxZ1dg+mljwdAOAA--.23277S2
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQAECmNo9WQJ3wACsB
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kr4fWw48GFWkKw1fGr4DJwb_yoW8WrykpF
        W3AFWakr48tF1Ikan0q348u3Wa9F4DGas8JFZ7CwnF93ZxC345Wry8CFyFv343tr48AF1Y
        v3WvgF18GF4UJF7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxUxYiiDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI Controller of 2k1000 could not mask devices by setting vender ID or
device ID in configuration space header as invalid values. When there are
pins shareable between the platform device and PCI device, if the platform
device is preferred, we should not scan this PCI device. In the above
scene, add `status = "disabled"` property in DT node of this PCI device.

Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
---
V3 -> V4: 1. get rid of the masklist and search the status property
	  directly.
          2. check the status property only when accessing the vendor ID.
V2 -> V3: 1. use list_for_each_entry() for more clearly.
          2. fix wrong use of sizeof().
V1 -> V2: use existing property "status" instead of adding new property.

 drivers/pci/controller/pci-loongson.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 05c50408f13b..efca0b3b5a29 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -194,6 +194,17 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus,
 			return NULL;
 	}
 
+#ifdef CONFIG_OF
+	/* Don't access disabled devices. */
+	if (pci_is_root_bus(bus) && where == PCI_VENDOR_ID) {
+		struct device_node *dn;
+
+		dn = of_pci_find_child_device(bus->dev.of_node, devfn);
+		if (dn && !of_device_is_available(dn))
+			return NULL;
+	}
+#endif
+
 	/* CFG0 can only access standard space */
 	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
 		return cfg0_map(priv, bus, devfn, where);
-- 
2.20.1

