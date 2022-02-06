Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E05D4AAFEC
	for <lists+linux-pci@lfdr.de>; Sun,  6 Feb 2022 15:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbiBFOXp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Feb 2022 09:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiBFOXn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Feb 2022 09:23:43 -0500
X-Greylist: delayed 933 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 06:23:40 PST
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD7E6C06173B;
        Sun,  6 Feb 2022 06:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ixsSJ
        ukxUwP/PsI5HX/FmH5LSUIkMEyDP7g8GscpELM=; b=G9ECOcLnWfDDrgWyxHYBq
        DpKIwL9iiIhpcuYxufb10y48sOylwX59cjHVy+AD3nW23OhORj+QIVMjbS2oQ63n
        7f1zf+NnrmErjWvlflRdV56ia1nvbzhiJQ/n8cNx+3oZGN2bIHX7AFU9HUp/W5cV
        KU6etUcybuVk9BeiiWDaVs=
Received: from localhost.localdomain (unknown [36.161.194.210])
        by smtp12 (Coremail) with SMTP id EMCowACn8vQN1v9h4UA8Bg--.11512S4;
        Sun, 06 Feb 2022 22:07:35 +0800 (CST)
From:   lizhe <sensor1010@163.com>
To:     bhelgaas@google.com, lukas@wunner.de, ameynarkhede03@gmail.com,
        hdegoede@redhat.com, sensor1010@163.com, naveennaidu479@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI:pciehp: Replace request_threaded_irq with devm_request_threaded_irq
Date:   Sun,  6 Feb 2022 06:07:05 -0800
Message-Id: <20220206140705.10705-1-sensor1010@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowACn8vQN1v9h4UA8Bg--.11512S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw17XF13ur4rCr1rWr4rKrg_yoWkJFg_ur
        4UGr1xAr4jkryrGF1Fvw4rJFWIyay3X3Z7X3W0qFyIya9FqrsrArZ5WFZ0qF97ur43Jrn3
        WryxXrWUKr1UCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR5rcDUUUUU==
X-Originating-IP: [36.161.194.210]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBogifq1aECK5BbwAAsE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Memory allocated with this function is automatically
freed on driver detach

Signed-off-by: lizhe <sensor1010@163.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 1c1ebf3dad43..aca59c6fdcbc 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -66,7 +66,7 @@ static inline int pciehp_request_irq(struct controller *ctrl)
 	}
 
 	/* Installs the interrupt handler */
-	retval = request_threaded_irq(irq, pciehp_isr, pciehp_ist,
+	retval = devm_request_threaded_irq(irq, pciehp_isr, pciehp_ist,
 				      IRQF_SHARED, "pciehp", ctrl);
 	if (retval)
 		ctrl_err(ctrl, "Cannot get irq %d for the hotplug controller\n",
@@ -78,8 +78,6 @@ static inline void pciehp_free_irq(struct controller *ctrl)
 {
 	if (pciehp_poll_mode)
 		kthread_stop(ctrl->poll_thread);
-	else
-		free_irq(ctrl->pcie->irq, ctrl);
 }
 
 static int pcie_poll_cmd(struct controller *ctrl, int timeout)
-- 
2.25.1

