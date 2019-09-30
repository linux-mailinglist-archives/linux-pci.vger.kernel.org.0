Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA2DC1AD2
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 07:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfI3FCn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 01:02:43 -0400
Received: from mail.loongson.cn ([114.242.206.163]:53882 "EHLO
        mail.loongson.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfI3FCn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 01:02:43 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Sep 2019 01:02:41 EDT
Received: from [10.20.41.27] (unknown [10.20.41.27])
        by mail (Coremail) with SMTP id QMiowPDx_8e3ipFdQRcFAA--.36S3;
        Mon, 30 Sep 2019 12:55:19 +0800 (CST)
To:     bhelgaas@google.com
Cc:     zenglu@loongson.cn, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH] PCI: Add Loongson vendor ID and device IDs
Message-ID: <279cbe32-a44b-3190-aaf7-a277a1220720@loongson.cn>
Date:   Mon, 30 Sep 2019 12:55:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: QMiowPDx_8e3ipFdQRcFAA--.36S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW3KFWDAw4kXw1rAw1kXwb_yoW8WF43pr
        1rZrZ3tF4xtFW7Zwn7trn8GrW3Aan0kry7ZFyagFWjqF17Xw48Jr1qvFs8ArW2qFs3X3yx
        ZF4DC3yFk3ZrJwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9jb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r1j6r4UMcIj6xIIjxv20xvE14v26r
        1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vI
        r41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7IU0cVy7UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the Loongson vendor ID and device IDs to pci_ids.h
to be used in the future.

The Loongson IDs can be found at the following link:
https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/pci.ids

Co-developed-by: Lu Zeng <zenglu@loongson.cn>
Signed-off-by: Lu Zeng <zenglu@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
  include/linux/pci_ids.h | 19 +++++++++++++++++++
  1 file changed, 19 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 21a5724..119639d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3111,4 +3111,23 @@

  #define PCI_VENDOR_ID_NCUBE            0x10ff

+#define PCI_VENDOR_ID_LOONGSON                 0x0014
+#define PCI_DEVICE_ID_LOONGSON_HT              0x7a00
+#define PCI_DEVICE_ID_LOONGSON_APB             0x7a02
+#define PCI_DEVICE_ID_LOONGSON_GMAC            0x7a03
+#define PCI_DEVICE_ID_LOONGSON_OTG             0x7a04
+#define PCI_DEVICE_ID_LOONGSON_GPU_2K1000      0x7a05
+#define PCI_DEVICE_ID_LOONGSON_DC              0x7a06
+#define PCI_DEVICE_ID_LOONGSON_HDA             0x7a07
+#define PCI_DEVICE_ID_LOONGSON_SATA            0x7a08
+#define PCI_DEVICE_ID_LOONGSON_PCIE_X1         0x7a09
+#define PCI_DEVICE_ID_LOONGSON_SPI             0x7a0b
+#define PCI_DEVICE_ID_LOONGSON_LPC             0x7a0c
+#define PCI_DEVICE_ID_LOONGSON_DMA             0x7a0f
+#define PCI_DEVICE_ID_LOONGSON_EHCI            0x7a14
+#define PCI_DEVICE_ID_LOONGSON_GPU_7A1000      0x7a15
+#define PCI_DEVICE_ID_LOONGSON_PCIE_X4         0x7a19
+#define PCI_DEVICE_ID_LOONGSON_OHCI            0x7a24
+#define PCI_DEVICE_ID_LOONGSON_PCIE_X8         0x7a29
+
  #endif /* _LINUX_PCI_IDS_H */
-- 
2.1.0


