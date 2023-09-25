Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551967AD075
	for <lists+linux-pci@lfdr.de>; Mon, 25 Sep 2023 08:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjIYGrM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Sep 2023 02:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjIYGrG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Sep 2023 02:47:06 -0400
X-Greylist: delayed 720 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Sep 2023 23:46:59 PDT
Received: from aliyun-sdnproxy-2.icoremail.net (aliyun-cloud.icoremail.net [47.90.88.91])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4D801A3
        for <linux-pci@vger.kernel.org>; Sun, 24 Sep 2023 23:46:59 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.190.70.223])
        by mail-app4 (Coremail) with SMTP id cS_KCgB3H832JhFl9IXbAA--.20158S4;
        Mon, 25 Sep 2023 14:21:48 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn
Cc:     Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Duc Dang <dhdang@apm.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: xgene-msi: Fix a potential UAF in xgene_msi_probe
Date:   Mon, 25 Sep 2023 14:21:32 +0800
Message-Id: <20230925062133.14170-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgB3H832JhFl9IXbAA--.20158S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JF13Cr4xXr15WF13Gr18uFg_yoWDArb_uF
        yxXF1ruFyDGr13KF48tr4FvF9093WkWw1kKa4FyF1fAa4Iqw1fXry3CrW2qF97Crs8CrnF
        yr4jyryfC34UZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbsxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl6s0DM28EF7xvwVC2z280
        aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07
        x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18
        McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
        1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
        C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
        wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
        v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0HBmUNoyAhBwAJsK
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

xgene_allocate_domains() will call irq_domain_remove() to free
msi->inner_domain on failure. However, its caller, xgene_msi_probe(),
will also call irq_domain_remove() through xgene_msi_remove() on the
same failure, which may lead to a use-after-free. Set the freed pointer
to NULL to fix this issue.

Fixes: dcd19de36775 ("PCI: xgene: Add APM X-Gene v1 PCIe MSI/MSIX termination driver")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/pci/controller/pci-xgene-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 3ce38dfd0d29..c0192c5ff0f3 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -253,6 +253,7 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
 
 	if (!msi->msi_domain) {
 		irq_domain_remove(msi->inner_domain);
+		msi->inner_domain = NULL;
 		return -ENOMEM;
 	}
 
-- 
2.17.1

