Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9144C47DDBF
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 03:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345806AbhLWC3C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 21:29:02 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:36312 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238478AbhLWC3C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 21:29:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V.TJc1e_1640226539;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V.TJc1e_1640226539)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Dec 2021 10:28:59 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     bhelgaas@google.com, rafael@kernel.org
Cc:     lenb@kernel.org, jroedel@suse.de, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] PCI/ACPI: Fix acpi_pci_osc_control_set() kernel-doc comment
Date:   Thu, 23 Dec 2021 10:28:56 +0800
Message-Id: <20211223022856.27822-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the description of @support and remove @req in 
acpi_pci_osc_control_set() kernel-doc comment to remove warnings found 
by running scripts/kernel-doc, which is caused by using 'make W=1'.

drivers/acpi/pci_root.c:337: warning: Excess function parameter 'req'
description in 'acpi_pci_osc_control_set'
drivers/acpi/pci_root.c:337: warning: Function parameter or member
'support' not described in 'acpi_pci_osc_control_set'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 6bc779ee05d4 ("PCI/ACPI: Check for _OSC support in acpi_pci_osc_control_set()")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/acpi/pci_root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 41a8fef06534..084916604f3c 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -322,7 +322,7 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
  * acpi_pci_osc_control_set - Request control of PCI root _OSC features.
  * @handle: ACPI handle of a PCI root bridge (or PCIe Root Complex).
  * @mask: Mask of _OSC bits to request control of, place to store control mask.
- * @req: Mask of _OSC bits the control of is essential to the caller.
+ * @support: _OSC supported capability.
  *
  * Run _OSC query for @mask and if that is successful, compare the returned
  * mask of control bits with @req.  If all of the @req bits are set in the
-- 
2.20.1.7.g153144c

