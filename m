Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E987B451D
	for <lists+linux-pci@lfdr.de>; Sun,  1 Oct 2023 05:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjJADzP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Sep 2023 23:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJADzO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Sep 2023 23:55:14 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED4CADD;
        Sat, 30 Sep 2023 20:55:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.192.195.11])
        by mail-app3 (Coremail) with SMTP id cC_KCgBXPcCC7RhlwbwsAQ--.29716S4;
        Sun, 01 Oct 2023 11:54:48 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn
Cc:     Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Marc Zyngier <maz@kernel.org>, Duc Dang <dhdang@apm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] PCI: xgene-msi: Fix a potential UAF in xgene_msi_probe
Date:   Sun,  1 Oct 2023 11:54:40 +0800
Message-Id: <20231001035441.30408-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgBXPcCC7RhlwbwsAQ--.29716S4
X-Coremail-Antispam: 1UD129KBjvJXoW7JF13Cr4xXr15WF13Gr18uFg_yoW8JrWDpF
        WxCw13WFWft3yUXa1Igw18Wa4aya9rt3yDtwsxWrnrZrnxC34DuryjqFy5C34akFWrXr4j
        y3WxJF15uFs5JFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgwPBmUYLyEI2AAAsk
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

xgene_allocate_domains() will call irq_domain_remove() to free
msi->inner_domain on failure. However, its caller, xgene_msi_probe(),
will also call irq_domain_remove() through xgene_msi_remove() on the
same failure, which may lead to a use-after-free. Remove the first
irq_domain_remove() and let xgene_free_domains() cleanup domains.

Fixes: dcd19de36775 ("PCI: xgene: Add APM X-Gene v1 PCIe MSI/MSIX termination driver")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: -Remove irq_domain_remove() instead of nulling msi_domain.

v3: -Add 'v3' tag in the title.
---
 drivers/pci/controller/pci-xgene-msi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 3ce38dfd0d29..0f9b9394399d 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -251,10 +251,8 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
 						    &xgene_msi_domain_info,
 						    msi->inner_domain);
 
-	if (!msi->msi_domain) {
-		irq_domain_remove(msi->inner_domain);
+	if (!msi->msi_domain)
 		return -ENOMEM;
-	}
 
 	return 0;
 }
-- 
2.17.1

