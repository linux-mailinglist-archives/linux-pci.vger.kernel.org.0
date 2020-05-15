Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6874C1D4AD0
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 12:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEOKYX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 06:24:23 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:47828 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgEOKYX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2020 06:24:23 -0400
X-Greylist: delayed 920 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 May 2020 06:24:21 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Tqawr
        mDPq3bBcSlye5lx1tCeB2nEFRoYFenapfXH87A=; b=L7ckxl/rxr8dXhvoe31zB
        HFCSWouIkW+rOTgUeE9O5ibFFPzKYRoTF32kp7fBVrx7t0sso3jyCCt3Z8tJfVxe
        S81S7oK//nOKd5oQrMhMunnYW7avHRZB17SpucX80Wrnp7v1OyW1JYONXVTJezW5
        JcfMaDIMwMay+g8CdUkQV0=
Received: from localhost.localdomain.localdomain (unknown [103.244.59.3])
        by smtp1 (Coremail) with SMTP id GdxpCgDH55sFar5ebFPaAA--.1521S2;
        Fri, 15 May 2020 18:08:06 +0800 (CST)
From:   Xiaochun Lee <lixiaochun.2888@163.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        Xiaochun Lee <lixc17@lenovo.com>
Subject: [PATCH v2] x86/PCI: Mark Power Control Unit as having non-compliant BARs
Date:   Fri, 15 May 2020 06:07:51 -0400
Message-Id: <1589537271-46459-1-git-send-email-lixiaochun.2888@163.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgDH55sFar5ebFPaAA--.1521S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw18Ww1DXFW7XF1DJw1kZrb_yoW5GFWfpF
        45tay09rWkKas3KFs7uan7WF1DCanxXa1rC39xuw1jg3Z8AasIqFySka45ZFW5Jr1kWF47
        ZrnIq348XayrXFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jov38UUUUU=
X-Originating-IP: [103.244.59.3]
X-CM-SenderInfo: 5ol0xtprfk30aosymmi6rwjhhfrp/1tbiQAclQFSIfGDw1QAAsH
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xiaochun Lee <lixc17@lenovo.com>

The device [8086:a26c] is a Power Control Unit of
Intel Ice Lake Server Processor and devices [8086:a1ec,a1ed]
are the Power Control Unit of Intel Xeon Scalable Processor,
kernel treats their pci BARs as a base address register that
leading to a boot failure like:
"pci 0000:00:11.0: [Firmware Bug]: reg 0x30: invalid BAR (can't size)".

The symptoms in Ice Lake processor is:
"QU99 ICE LAKE ES1 HCC 24C 185W 3200 L-0"

The information of the device [8086:a26c] list as below:
00:11.0 Unassigned class [ff00]: Intel Corporation Device a26c (rev 03)
        Subsystem: Lenovo Device 7811
        Flags: fast devsel, NUMA node 0
        Expansion ROM at <ignored> [disabled]
        Capabilities: [80] Power Management version 3

The symptoms in Xeon Scalable Processor is:
"Intel(R) Xeon(R) Gold 5117 CPU @ 2.00GHz"
"Intel(R) Xeon(R) Gold 6252 CPU @ 2.00GHz"

The information of the Device [8086:a1ec] list as below:
00:11.0 Unassigned class [ff00]: Intel Corporation C620 Series Chipset Family MROM 0 [8086:a1ec] (rev 09)
        Subsystem: Lenovo Device [17aa:7805]
        Latency: 0, Cache Line Size: 64 bytes
        NUMA node: 0
        Expansion ROM at <ignored> [disabled]
        Capabilities: [80] Power Management version 3

There are no other BARs on this devices, so mark the PCU as having
non-compliant BARs, therefore we don't try to probe any of them.

Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
---
 arch/x86/pci/fixup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e723559..d9abc67 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -563,6 +563,9 @@ static void twinhead_reserve_killing_zone(struct pci_dev *dev)
  * Erratum BDF2
  * PCI BARs in the Home Agent Will Return Non-Zero Values During Enumeration
  * http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html
+ *
+ * Device [8086:a26c]
+ * Devices [8086:a1ec,a1ed]
  */
 static void pci_invalid_bar(struct pci_dev *dev)
 {
@@ -572,6 +575,9 @@ static void pci_invalid_bar(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_invalid_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_invalid_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0xa1ec, pci_invalid_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0xa1ed, pci_invalid_bar);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0xa26c, pci_invalid_bar);
 
 /*
  * Device [1022:7808]
-- 
1.8.3.1

