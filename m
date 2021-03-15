Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B453D33AC62
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 08:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhCOHkG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 03:40:06 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:49073 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229644AbhCOHkF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Mar 2021 03:40:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0URx640M_1615794001;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0URx640M_1615794001)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Mar 2021 15:40:02 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     bhelgaas@google.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] x86/pci: use true and false for bool variable
Date:   Mon, 15 Mar 2021 15:40:00 +0800
Message-Id: <1615794000-102771-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

fixed the following coccicheck:
./arch/x86/pci/mmconfig-shared.c:464:9-10: WARNING: return of 0/1 in
function 'is_mmconf_reserved' with return type bool
./arch/x86/pci/mmconfig-shared.c:493:5-6: WARNING: return of 0/1 in
function 'is_mmconf_reserved' with return type bool
./arch/x86/pci/mmconfig-shared.c:501:9-10: WARNING: return of 0/1 in
function 'is_mmconf_reserved' with return type bool
./arch/x86/pci/mmconfig-shared.c:522:5-6: WARNING: return of 0/1 in
function 'is_mmconf_reserved' with return type bool

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/x86/pci/mmconfig-shared.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index de6bf0e..758cbfe 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -461,7 +461,7 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 	}
 
 	if (size < (16UL<<20) && size != old_size)
-		return 0;
+		return false;
 
 	if (dev)
 		dev_info(dev, "MMCONFIG at %pR reserved in %s\n",
@@ -493,7 +493,7 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 				&cfg->res, (unsigned long) cfg->address);
 	}
 
-	return 1;
+	return true;
 }
 
 static bool __ref
@@ -501,7 +501,7 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 {
 	if (!early && !acpi_disabled) {
 		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev, 0))
-			return 1;
+			return true;
 
 		if (dev)
 			dev_info(dev, FW_INFO
@@ -522,14 +522,14 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 	 * _CBA method, just assume it's reserved.
 	 */
 	if (pci_mmcfg_running_state)
-		return 1;
+		return true;
 
 	/* Don't try to do this check unless configuration
 	   type 1 is available. how about type 2 ?*/
 	if (raw_pci_ops)
 		return is_mmconf_reserved(e820__mapped_all, cfg, dev, 1);
 
-	return 0;
+	return false;
 }
 
 static void __init pci_mmcfg_reject_broken(int early)
-- 
1.8.3.1

