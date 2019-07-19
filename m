Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3342B6E079
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2019 07:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfGSFMV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jul 2019 01:12:21 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:39976 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbfGSFMV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jul 2019 01:12:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=shannon.zhao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TXG4GTe_1563513118;
Received: from localhost(mailfrom:shannon.zhao@linux.alibaba.com fp:SMTPD_---0TXG4GTe_1563513118)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Jul 2019 13:12:17 +0800
From:   Shannon Zhao <shenglong.zsl@alibaba-inc.com>
To:     linux-kernel@vger.kernel.org, jnair@marvell.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org, gduan@marvell.com
Subject: [PATCH] PCI: Add ACS quirk for Cavium ThunderX 2 root port devices
Date:   Fri, 19 Jul 2019 21:10:35 +0800
Message-Id: <1563541835-141011-1-git-send-email-shenglong.zsl@alibaba-inc.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shannon Zhao <shannon.zhao@linux.alibaba.com>

Like commit f2ddaf8(PCI: Apply Cavium ThunderX ACS quirk to more Root
Ports), it should apply ACS quirk to ThunderX 2 root port devices.

Signed-off-by: Shannon Zhao <shannon.zhao@linux.alibaba.com>
---
 drivers/pci/quirks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 28c64f8..ea7848b 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4224,10 +4224,12 @@ static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
 	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
 	 * bits of device ID are used to indicate which subdevice is used
 	 * within the SoC.
+	 * Effectively selects the ThunderX 2 root ports whose device ID
+	 * is 0xaf84.
 	 */
 	return (pci_is_pcie(dev) &&
 		(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) &&
-		((dev->device & 0xf800) == 0xa000));
+		((dev->device & 0xf800) == 0xa000 || dev->device == 0xaf84));
 }
 
 static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
-- 
1.8.3.1

