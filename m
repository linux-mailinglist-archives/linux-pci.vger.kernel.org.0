Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908AD2198CA
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 08:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgGIGo3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 02:44:29 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:63878 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbgGIGo2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 02:44:28 -0400
Received: from localhost.localdomain (unknown [210.32.144.65])
        by mail-app2 (Coremail) with SMTP id by_KCgDn7+esvAZfYMwOAA--.34107S4;
        Thu, 09 Jul 2020 14:44:00 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hien Dang <hien.dang.eb@renesas.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] PCI: rcar: Fix runtime PM imbalance on error
Date:   Thu,  9 Jul 2020 14:43:56 +0800
Message-Id: <20200709064356.8800-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgDn7+esvAZfYMwOAA--.34107S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyDGryUXF4UurW3ArWUJwb_yoW8GrWxpr
        W2qFWayF4kW3yYqa17JF1kuFya93ZIy3srGws7Kw17Z3ZxAFyjqryrCFyrtF12grW8Z3WY
        y3WYqryxCFZ5ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
        JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK
        67AK6r47MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
        6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
        WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
        6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUkhLnUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgwNBlZdtO+R4gAIsu
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pm_runtime_get_sync() increments the runtime PM usage counter even
the call returns an error code. Thus a corresponding decrement is
needed on the error handling path to keep the counter balanced.

Fixes: 0df6150e7ceb ("PCI: rcar: Use runtime PM to control controller
clock")

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: - Remove unnecessary 'err_pm_put' label.
      Refine commit message.

v3: - Add Fixes tag.
      Rebase the patch on top of the latest kernel.
---
 drivers/pci/controller/pcie-rcar-host.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index d210a36561be..060c24f5221e 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -986,7 +986,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	err = pm_runtime_get_sync(pcie->dev);
 	if (err < 0) {
 		dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
-		goto err_pm_disable;
+		goto err_pm_put;
 	}
 
 	err = rcar_pcie_get_resources(host);
@@ -1057,8 +1057,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 err_pm_put:
 	pm_runtime_put(dev);
-
-err_pm_disable:
 	pm_runtime_disable(dev);
 	pci_free_resource_list(&host->resources);
 
-- 
2.17.1

