Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69C1217FDC4
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 14:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgCJMu2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Mar 2020 08:50:28 -0400
Received: from mail.loongson.cn ([114.242.206.163]:36166 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728595AbgCJMu2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Mar 2020 08:50:28 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn9kBjWdeay0ZAA--.25S3;
        Tue, 10 Mar 2020 20:50:11 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 2/2] AHCI: Add support for Loongson 7A1000 SATA controller
Date:   Tue, 10 Mar 2020 20:50:08 +0800
Message-Id: <1583844608-30029-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1583844608-30029-1-git-send-email-yangtiezhu@loongson.cn>
References: <1583844608-30029-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxn9kBjWdeay0ZAA--.25S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW8Wr48CFW8GFyDtr4kXrb_yoW8JFyxpF
        43XayDKr40grWFga1DA3ykGa43JFs8Wa4xKa90k3yvqr4qyryrWryUZa47JrW7K34kW3W7
        XFnFkw12gF4UXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW5JwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUrpnLUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Loongson 7A1000 SATA controller uses BAR0 as the base address register.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/ata/ahci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 11ea1af..33d051a 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -40,6 +40,7 @@
 enum {
 	AHCI_PCI_BAR_STA2X11	= 0,
 	AHCI_PCI_BAR_CAVIUM	= 0,
+	AHCI_PCI_BAR_LOONGSON	= 0,
 	AHCI_PCI_BAR_ENMOTUS	= 2,
 	AHCI_PCI_BAR_CAVIUM_GEN5	= 4,
 	AHCI_PCI_BAR_STANDARD	= 5,
@@ -589,6 +590,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	/* Enmotus */
 	{ PCI_DEVICE(0x1c44, 0x8000), board_ahci },
 
+	/* Loongson */
+	{ PCI_VDEVICE(LOONGSON, 0x7a08), board_ahci },
+
 	/* Generic, PCI class code for AHCI */
 	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
@@ -1680,6 +1684,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			ahci_pci_bar = AHCI_PCI_BAR_CAVIUM;
 		if (pdev->device == 0xa084)
 			ahci_pci_bar = AHCI_PCI_BAR_CAVIUM_GEN5;
+	} else if (pdev->vendor == PCI_VENDOR_ID_LOONGSON) {
+		if (pdev->device == 0x7a08)
+			ahci_pci_bar = AHCI_PCI_BAR_LOONGSON;
 	}
 
 	/* acquire resources */
-- 
2.1.0

