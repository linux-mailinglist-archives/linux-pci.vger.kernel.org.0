Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19AB317DAC2
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 09:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgCIIYI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 04:24:08 -0400
Received: from mail.loongson.cn ([114.242.206.163]:55944 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbgCIIXs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 04:23:48 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb9_+_GVesb4YAA--.12S4;
        Mon, 09 Mar 2020 16:23:30 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 2/6] AHCI: Add support for Loongson 7A1000 SATA controller
Date:   Mon,  9 Mar 2020 16:23:22 +0800
Message-Id: <1583742206-29163-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxb9_+_GVesb4YAA--.12S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW8XryrZr4UXrWDCw4fGrg_yoW8Gry7pF
        43XFWDKr40grWrK3WDJw4DGry3JF4DGa4Ikayak392qr4qyry5Wr97Aa47JrW7K34kXF17
        X34qkr47Wr4DZw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
        AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4
        A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU
        0xZFpf9x0pRXTmfUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Loongson 7A1000 SATA controller uses BAR0 as the base address register.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/ata/ahci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 11ea1af..28a336e 100644
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
@@ -589,6 +590,10 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	/* Enmotus */
 	{ PCI_DEVICE(0x1c44, 0x8000), board_ahci },
 
+	/* Loongson */
+	{ PCI_VDEVICE(LOONGSON, PCI_DEVICE_ID_LOONGSON_7A1000_SATA),
+	  board_ahci },
+
 	/* Generic, PCI class code for AHCI */
 	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
@@ -1680,6 +1685,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			ahci_pci_bar = AHCI_PCI_BAR_CAVIUM;
 		if (pdev->device == 0xa084)
 			ahci_pci_bar = AHCI_PCI_BAR_CAVIUM_GEN5;
+	} else if (pdev->vendor == PCI_VENDOR_ID_LOONGSON) {
+		if (pdev->device == PCI_DEVICE_ID_LOONGSON_7A1000_SATA)
+			ahci_pci_bar = AHCI_PCI_BAR_LOONGSON;
 	}
 
 	/* acquire resources */
-- 
2.1.0

