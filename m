Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC1E46E5E3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 10:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhLIJuR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 04:50:17 -0500
Received: from smtp23.cstnet.cn ([159.226.251.23]:56800 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231932AbhLIJuK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Dec 2021 04:50:10 -0500
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-03 (Coremail) with SMTP id rQCowAAXMJJY0LFhwyzAAQ--.33737S2;
        Thu, 09 Dec 2021 17:46:04 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     ruscur@russell.cc, oohall@gmail.com, bhelgaas@google.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] PCI/AER: potential dereference of null pointer
Date:   Thu,  9 Dec 2021 17:45:56 +0800
Message-Id: <20211209094556.2085357-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXMJJY0LFhwyzAAQ--.33737S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4xtrW8CFykXry5uF1rJFb_yoW3XFg_u3
        yxWrnrGrWUKFs3WFn0yr4rZryjva4DXrWIqanaqa93Cas7uF97XFyUXr13JF47WFZ3CryD
        C3sFkr13Cw17KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8uwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhNVgUUUUU=
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

he return value of kzalloc() needs to be checked.
To avoid use of null pointer in case of the failure of alloc.

Fixes: db89ccbe52c7 ("PCI/AER: Define aer_stats structure for AER capable devices")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/pci/pcie/aer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ec943cee5ecc..d04303edf468 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -376,6 +376,8 @@ void pci_aer_init(struct pci_dev *dev)
 		return;
 
 	dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
+	if (!dev->aer_stats)
+		return;
 
 	/*
 	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
-- 
2.25.1

