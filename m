Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8ED62D100
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 03:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiKQCJ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 21:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKQCJ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 21:09:56 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6FAE1133;
        Wed, 16 Nov 2022 18:09:54 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.77])
        by gateway (Coremail) with SMTP id _____8CxLdnxl3VjOiIIAA--.23261S3;
        Thu, 17 Nov 2022 10:09:53 +0800 (CST)
Received: from loongson-PC.loongson.cn (unknown [10.20.42.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXuDfl3VjbJEVAA--.56306S2;
        Thu, 17 Nov 2022 10:09:53 +0800 (CST)
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
        wanghongliang <wanghongliang@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6] PCI: loongson: Skip scanning disabled child devices
Date:   Thu, 17 Nov 2022 10:09:35 +0800
Message-Id: <20221117020935.32086-1-liupeibao@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxXuDfl3VjbJEVAA--.56306S2
X-CM-SenderInfo: xolx1vpled0qxorr0wxvrqhubq/1tbiAQANCmN00uUg2AABsf
X-Coremail-Antispam: 1Uk129KBjvJXoW7uF4DJFWUur4UtFWkuw1fCrg_yoW8CrW5pF
        ZxJFW3trW8KF4vkFs0v348u3Wa9a1kG393JFs7Cr1a93ZxG34YgryxCFyFq3sIqrW8Zaya
        va4kKr18CF4UJr7anT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a mechanism to disable on chip PCI devices by DT. Typically, when there
are pins shareable between the platform device and the on chip PCI device,
if the PCI device is not preferred, add `status = "disabled"` property to
this PCI device DT node.

For example, on LS2K1000, GMAC1 (on chip PCI device) and GPIO (platform
device, not PCI device) 14 share the same pin. If GMAC1 is not preferred,
add `status = "disabled"` property in GMAC1 DT node.

Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
---
V5 -> V6: 1. rewrite the commit log to make things clear.
	  2. replace "unavailable" as "disabled" in patch subject.
V4 -> V5: clear the issue we are facing in commit log.
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

