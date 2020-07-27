Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D48422E63B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 09:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgG0HHm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 03:07:42 -0400
Received: from mail.loongson.cn ([114.242.206.163]:36546 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbgG0HHm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 03:07:42 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxv98UfR5fIRkBAA--.653S2;
        Mon, 27 Jul 2020 15:07:01 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Move pci_info() after pci_fixup_device() in pci_setup_device()
Date:   Mon, 27 Jul 2020 15:06:55 +0800
Message-Id: <1595833615-8049-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxv98UfR5fIRkBAA--.653S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw45Jr47ZFW8ury5ArykAFb_yoWkCrXEv3
        yUuF4xWr4DAa10kFn8Jw43Z3sYk3Z09rWxWr48Ka4IvayIvrZ8XF4UXry7K3WUua15Cr90
        qFWDGr4rCr10kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbwkYjsxI4VWkCwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC2
        0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
        0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
        14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
        vaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
        xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8iL0UUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the current code, we can not see the PCI info after fixup which is
correct to reflect the reality, it is better to move pci_info() after
pci_fixup_device() in pci_setup_device().

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/pci/probe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2f66988..7c046aed 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1802,9 +1802,6 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->revision = class & 0xff;
 	dev->class = class >> 8;		    /* upper 3 bytes */
 
-	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
-		   dev->vendor, dev->device, dev->hdr_type, dev->class);
-
 	if (pci_early_dump)
 		early_dump_pci_device(dev);
 
@@ -1822,6 +1819,9 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
 
+	pci_info(dev, "[%04x:%04x] type %02x class %#08x\n",
+		 dev->vendor, dev->device, dev->hdr_type, dev->class);
+
 	/* Device class may be changed after fixup */
 	class = dev->class >> 8;
 
-- 
2.1.0

