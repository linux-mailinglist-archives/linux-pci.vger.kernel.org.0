Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B3A44D1BD
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 06:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhKKFp6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 00:45:58 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:42878 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229379AbhKKFp6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 00:45:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uw-meSK_1636609380;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0Uw-meSK_1636609380)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Nov 2021 13:43:07 +0800
From:   Liguang Zhang <zhangliguang@linux.alibaba.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liguang Zhang <zhangliguang@linux.alibaba.com>
Subject: [PATCH] PCI: pciehp: clear cmd_busy bit when Command Completed in polling mode
Date:   Thu, 11 Nov 2021 13:42:58 +0800
Message-Id: <20211111054258.7309-1-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch fixes this problem that on driver probe from system startup,
pciehp checks the Presence Detect State bit in the Slot Status register
to bring up an occupied slot or bring down an unoccupied slot. If empty
slot's power status is on, turn power off. The Hot-Plug interrupt isn't
requested yet, so avoid triggering a notification by calling
pcie_disable_notification().

Both the CCIE and HPIE bits are masked in pcie_disable_notification(),
when we issue a hotplug command, pcie_wait_cmd() will polling the
Command Completed bit instead of waiting for an interrupt. But cmd_busy
bit was not cleared when Command Completed which results in timeouts
like this in pciehp_power_off_slot() and pcie_init_notification():

  pcieport 0000:00:03.0: pciehp: Timeout on hotplug command 0x01c0
(issued 2264 msec ago)
  pcieport 0000:00:03.0: pciehp: Timeout on hotplug command 0x05c0
(issued 2288 msec ago)

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 83a0fa119cae..8698aefc6041 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -98,6 +98,8 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 		if (slot_status & PCI_EXP_SLTSTA_CC) {
 			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
 						   PCI_EXP_SLTSTA_CC);
+			ctrl->cmd_busy = 0;
+			smp_mb();
 			return 1;
 		}
 		msleep(10);
-- 
2.19.1.6.gb485710b

