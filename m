Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD41D4425
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 05:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgEODrz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 23:47:55 -0400
Received: from mail-m972.mail.163.com ([123.126.97.2]:56092 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgEODrz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 23:47:55 -0400
X-Greylist: delayed 927 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 May 2020 23:47:54 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=D4NKD
        6ouWnK1s4ua5cMuXFBSyxmNB0tglV7542wun20=; b=nJc5MWgo1SwxySwQuov+E
        S/EI0e5s+PurarwHtd7mOJd8pRBhzd0zO9NolH7HYRNT/AghlE55Ma1JDoAUN1vV
        gVLGhlH0IHZnVWsNsPzkCNmCbDkJeLwG5bevl2lqKdPCVj0jsRtZdSMmvacLcC2q
        7UB6stLOBLX67f4T5zfKoE=
Received: from localhost.localdomain.localdomain (unknown [103.244.59.3])
        by smtp2 (Coremail) with SMTP id GtxpCgDHy4gSDb5ecV+pBg--.79S2;
        Fri, 15 May 2020 11:31:32 +0800 (CST)
From:   Xiaochun Lee <lixiaochun.2888@163.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        Xiaochun Lee <lixc17@lenovo.com>
Subject: [PATCH] x86/PCI: Mark Ice Lake Power Control Unit as having non-compliant BARs
Date:   Thu, 14 May 2020 23:31:07 -0400
Message-Id: <1589513467-17070-1-git-send-email-lixiaochun.2888@163.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgDHy4gSDb5ecV+pBg--.79S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF15WFW8urWUuF4fXry7KFg_yoW8CF1Up3
        Z8tFW0vrWkKas3tF4Duan7XF1Du3ZxXFWrGrZ8Cw1jg3Z8AasYqFyFka4jyry5Jr1kuF47
        Zwnagw18X3WrGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYBT5UUUUU=
X-Originating-IP: [103.244.59.3]
X-CM-SenderInfo: 5ol0xtprfk30aosymmi6rwjhhfrp/xtbBURMlQFaD7HHPaQAAsJ
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xiaochun Lee <lixc17@lenovo.com>

The device [8086:a26c] have the same PCI BARs problem as
the device [8086:2fc0], it is a  Power Control Unit of
Intel Ice Lake Server Processor, kernel treats the
"Power Control Unit's CONFIG_TDP_NOMINAL CSR" as a base
address register leading to a boot failure like
"pci 0000:00:11.0: [Firmware Bug]: reg 0x30: invalid BAR (can't size)".

The information of the device list as below:
00:11.0 Unassigned class [ff00]: Intel Corporation Device a26c (rev 03)
        Subsystem: Lenovo Device 7811
        Flags: fast devsel, NUMA node 0
        Expansion ROM at <ignored> [disabled]
        Capabilities: [80] Power Management version 3

There are no other BARs on this device, so mark the PCU as having
non-compliant BARs, therefore we don't try to probe any of them.

Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
---
 arch/x86/pci/fixup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e723559..d1170c8 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -563,6 +563,8 @@ static void twinhead_reserve_killing_zone(struct pci_dev *dev)
  * Erratum BDF2
  * PCI BARs in the Home Agent Will Return Non-Zero Values During Enumeration
  * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html
+ *
+ * Device [8086:a26c]
  */
 static void pci_invalid_bar(struct pci_dev *dev)
 {
@@ -572,6 +574,7 @@ static void pci_invalid_bar(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0xa26c, pci_invalid_bar);
 
 /*
  * Device [1022:7808]
-- 
1.8.3.1

