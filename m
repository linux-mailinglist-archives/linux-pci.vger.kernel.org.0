Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CD665CF10
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 10:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjADJIY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 04:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjADJIX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 04:08:23 -0500
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFC17B1B;
        Wed,  4 Jan 2023 01:08:21 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-03 (Coremail) with SMTP id rQCowABnSab5QbVj8mZsCg--.32128S2;
        Wed, 04 Jan 2023 17:08:09 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
        kishon@kernel.org, bhelgaas@google.com
Cc:     ntb@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] PCI: endpoint: pci-epf-vntb: Add missing check for alloc_workqueue
Date:   Wed,  4 Jan 2023 17:08:08 +0800
Message-Id: <20230104090808.46085-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnSab5QbVj8mZsCg--.32128S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrW5Ar1fGF13GryfXrWkZwb_yoWfZFX_Wa
        97ZrsrWrZ8Gr18uryYkw4xZFyvkwnYqFn3ZFWrKFyakFyfC3yY93yDJryDGr1xWF15tryD
        u34qvr90yr12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfU09NVDUUUU
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add check for the return value of alloc_workqueue since it may return
NULL pointer.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 04698e7995a5..05c99185ba65 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1441,6 +1441,9 @@ static int __init epf_ntb_init(void)
 
 	kpcintb_workqueue = alloc_workqueue("kpcintb", WQ_MEM_RECLAIM |
 					    WQ_HIGHPRI, 0);
+	if (!kpcintb_workqueue)
+		return -ENOMEM;
+
 	ret = pci_epf_register_driver(&epf_ntb_driver);
 	if (ret) {
 		destroy_workqueue(kpcintb_workqueue);
-- 
2.25.1

