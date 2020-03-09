Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B474A17DAAD
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 09:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCIIXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 04:23:46 -0400
Received: from mail.loongson.cn ([114.242.206.163]:55946 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726384AbgCIIXq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 04:23:46 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb9_+_GVesb4YAA--.12S3;
        Mon, 09 Mar 2020 16:23:29 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 1/6] PCI: Add Loongson vendor ID and 7A1000 device IDs
Date:   Mon,  9 Mar 2020 16:23:21 +0800
Message-Id: <1583742206-29163-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
References: <1583742206-29163-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxb9_+_GVesb4YAA--.12S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr48KrWrury8CF1DXr1UKFg_yoW8WF4Dpr
        10vrZ3KFs7trWxZwn7trn8GrWfJF4qy34DuFya9F45JFnxXw48JwnFvFs8CrW2qrs3X3y7
        Zr4qk3y7G3ZIywUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPC14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
        80aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
        43ZEXa7VUUgo7tUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the Loongson vendor ID and 7A1000 device IDs to pci_ids.h
to be used by the controller driver in the future.

The Loongson IDs can be found at the following link:
https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/pci.ids

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 include/linux/pci_ids.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 352c0d7..0125ab4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3113,4 +3113,22 @@
 
 #define PCI_VENDOR_ID_NCUBE		0x10ff
 
+#define PCI_VENDOR_ID_LOONGSON			0x0014
+#define PCI_DEVICE_ID_LOONGSON_7A1000_HT	0x7a00
+#define PCI_DEVICE_ID_LOONGSON_7A1000_APB	0x7a02
+#define PCI_DEVICE_ID_LOONGSON_7A1000_GMAC	0x7a03
+#define PCI_DEVICE_ID_LOONGSON_7A1000_OTG	0x7a04
+#define PCI_DEVICE_ID_LOONGSON_7A1000_DC	0x7a06
+#define PCI_DEVICE_ID_LOONGSON_7A1000_HDA	0x7a07
+#define PCI_DEVICE_ID_LOONGSON_7A1000_SATA	0x7a08
+#define PCI_DEVICE_ID_LOONGSON_7A1000_PCIE_X1	0x7a09
+#define PCI_DEVICE_ID_LOONGSON_7A1000_SPI	0x7a0b
+#define PCI_DEVICE_ID_LOONGSON_7A1000_LPC	0x7a0c
+#define PCI_DEVICE_ID_LOONGSON_7A1000_DMA	0x7a0f
+#define PCI_DEVICE_ID_LOONGSON_7A1000_EHCI	0x7a14
+#define PCI_DEVICE_ID_LOONGSON_7A1000_GPU	0x7a15
+#define PCI_DEVICE_ID_LOONGSON_7A1000_PCIE_X4	0x7a19
+#define PCI_DEVICE_ID_LOONGSON_7A1000_OHCI	0x7a24
+#define PCI_DEVICE_ID_LOONGSON_7A1000_PCIE_X8	0x7a29
+
 #endif /* _LINUX_PCI_IDS_H */
-- 
2.1.0

