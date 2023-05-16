Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1440704480
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 07:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjEPFSB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 01:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEPFSA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 01:18:00 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A878A2119;
        Mon, 15 May 2023 22:17:56 -0700 (PDT)
Received: from wings-Z3-Air-S-Series-GK5MR0O.. (unknown [113.200.174.9])
        by sr0414.icoremail.net (Coremail) with SMTP id AQAAfwB3YyCaEWNkWFlrAA--.3787S4;
        Tue, 16 May 2023 13:16:11 +0800 (CST)
From:   Xiangyi Zeng <xyzeng@stu.xidian.edu.cn>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Xiangyi Zeng <xyzeng@stu.xidian.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: dwc: keystone: Free IRQ in `ks_pcie_remove` and the error handling section of `ks_pcie_probe`
Date:   Tue, 16 May 2023 13:16:59 +0800
Message-Id: <20230516051659.22194-1-xyzeng@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB3YyCaEWNkWFlrAA--.3787S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4rtF18GFy5Zr47Zr4fZrb_yoW5JF4UpF
        Z3AFsFkFW8JF17u34fAas8ZF1Yv3Zaka47G3s29392vr9xArZ8tFyftry2qasayrWkJa43
        tFyDtFy7CFs5GwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
        628vn2kIc2xKxwCY02Avz4vE14v_GrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUP5rcUUUUU=
X-CM-SenderInfo: p012v0vj6v33wo0lvxldqovvfxof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Smatch complains that:
drivers/pci/controller/dwc/pci-keystone.c:1303 ks_pcie_probe() warn:
'irq' from request_irq() not released on lines: 1183,1187,1303.

"ks-pcie-error-irq" was requested in the `ks_pcie_probe` function, but
was not freed neither in the error handling part of `ks_pcie_probe`
nor in the `ks_pcie_remove` function.

Fix this by adding `free_irq` in `ks_pcie_remove` and in a new error
handling label `err_alloc` after `err_link` in `ks_pcie_probe`. In
`ks_pcie_probe`, if `phy` or `link` memory allocation fails, we will
fall to `err_alloc`. If any other error occurs that leads to
`err_get_sync` or `err_link`, we end up going to `err_alloc`.

Fixes: 0790eb175ee0 ("PCI: keystone: Cleanup error_irq configuration")
Signed-off-by: Xiangyi Zeng <xyzeng@stu.xidian.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
This patch is tested with compilation and passed Smatch.
---
 drivers/pci/controller/dwc/pci-keystone.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 78818853af9e..f321bc2e8026 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1179,12 +1179,16 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		num_lanes = 1;
 
 	phy = devm_kzalloc(dev, sizeof(*phy) * num_lanes, GFP_KERNEL);
-	if (!phy)
-		return -ENOMEM;
+	if (!phy) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
 
 	link = devm_kzalloc(dev, sizeof(*link) * num_lanes, GFP_KERNEL);
-	if (!link)
-		return -ENOMEM;
+	if (!link) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
 
 	for (i = 0; i < num_lanes; i++) {
 		snprintf(name, sizeof(name), "pcie-phy%d", i);
@@ -1300,6 +1304,9 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	while (--i >= 0 && link[i])
 		device_link_del(link[i]);
 
+err_alloc:
+	free_irq(irq, ks_pcie);
+
 	return ret;
 }
 
@@ -1309,12 +1316,14 @@ static int __exit ks_pcie_remove(struct platform_device *pdev)
 	struct device_link **link = ks_pcie->link;
 	int num_lanes = ks_pcie->num_lanes;
 	struct device *dev = &pdev->dev;
+	int irq = platform_get_irq(pdev, 0);
 
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
 	while (num_lanes--)
 		device_link_del(link[num_lanes]);
+	free_irq(irq, ks_pcie);
 
 	return 0;
 }
-- 
2.34.1

