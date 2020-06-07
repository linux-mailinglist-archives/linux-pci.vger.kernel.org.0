Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8651F0AA4
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jun 2020 11:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgFGJcA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Jun 2020 05:32:00 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:8716 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbgFGJcA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 7 Jun 2020 05:32:00 -0400
Received: from localhost.localdomain (unknown [10.192.85.18])
        by mail-app2 (Coremail) with SMTP id by_KCgB375b2s9xeoZiZAA--.56237S4;
        Sun, 07 Jun 2020 17:31:38 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] PCI: rcar: Fix runtime PM imbalance on error
Date:   Sun,  7 Jun 2020 17:31:33 +0800
Message-Id: <20200607093134.6393-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgB375b2s9xeoZiZAA--.56237S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyDGryUXFyDAryfXw4fXwb_yoW8Jw4rpF
        W7Way2yF4kX3y5Zr45JF1kZFyav3ZYy347J397Ww17Zwnxua4ktryFkFyFqFyUKFW8X3WU
        t3W5tay8CFW5JrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgsEBlZdtOgTHAAAsT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pm_runtime_get_sync() increments the runtime PM usage counter even
the call returns an error code. Thus a corresponding decrement is
needed on the error handling path to keep the counter balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: - Remove unnecessary 'err_pm_put' label.
      Refine commit message.
---
 drivers/pci/controller/pcie-rcar.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 759c6542c5c8..f9595ab54bc4 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -1143,7 +1143,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	err = rcar_pcie_get_resources(pcie);
 	if (err < 0) {
 		dev_err(dev, "failed to request resources: %d\n", err);
-		goto err_pm_put;
+		goto err_pm_disable;
 	}
 
 	err = clk_prepare_enable(pcie->bus_clk);
@@ -1206,10 +1206,8 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	irq_dispose_mapping(pcie->msi.irq2);
 	irq_dispose_mapping(pcie->msi.irq1);
 
-err_pm_put:
-	pm_runtime_put(dev);
-
 err_pm_disable:
+	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	pci_free_resource_list(&pcie->resources);
 
-- 
2.17.1

