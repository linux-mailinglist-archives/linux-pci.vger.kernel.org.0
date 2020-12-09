Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9BA2D43D0
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 15:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgLIOCh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 09:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgLIOCd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2020 09:02:33 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D983BC0611CF
        for <linux-pci@vger.kernel.org>; Wed,  9 Dec 2020 06:00:56 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id a12so1851914wrv.8
        for <linux-pci@vger.kernel.org>; Wed, 09 Dec 2020 06:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=sGhimhMqrQ7R43THBxHuUMH6X8fnCKf4vrbT8z9d9rc=;
        b=Qubz8pAKVdW9i2hZvICGPhOs5+HBL8+YdVy/FaJPj19Pr5YGiUEU0Hkt+AL71QcXVZ
         bi6NFaylZ7IaheNMl1GWp305xgE6Q+CPWKQl79K0YxvCJmlicw/5zO1w5x2bpCqAc74D
         9KLI9m5ki593R/IzVeBds7qZ9+HEqkBm7RdpJ99Iwsx6f0PpIEJ+il11PZYW1aRrVAI8
         CZJGi8om83OPwdBVODFZJO0xOxYc/Ng6n7CY6su2M9U+P8tpc/RyDBhXkZQ46Eq2eJDq
         IgTc3jLzEB5AS9CKiUo+RWxE3WFDrXu4+Bd1DC9tRhCrbDKJUL5/ecc6+NiE7dKxVFs4
         WT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=sGhimhMqrQ7R43THBxHuUMH6X8fnCKf4vrbT8z9d9rc=;
        b=Se9aMVuirche51pmpCLg+FAAknG5mq6W4/Dhio+4LwbyL5nKLbLxElrwUh8UN2WbDe
         6Pkh0m0DVLVsLH4/aTOL0ZmqkQRqyBUU6ihHRKWdtqLbts3Y4iwmjI6B2QAiAiSLnfk8
         AWtVAStuYJVhFe7AIfl6oboOvYCVW5IzcJ0IaSqaPhRORPQOtVn2v/bDMbRljyYhT8H5
         0k9VGYmO+Q2qvGTbfE0CI97gDSY588uDt+/dVpXtx/2+IskbWtfDuNzHzQTtsxOEliAv
         JhULgbU8Da2YCd7cHd3b+TuMiIqIV+DUCRJ4oKSv/e4DsUkMB94oSLl+ykNOx5YO8nuN
         fsKQ==
X-Gm-Message-State: AOAM5322/i7piRQu7j3Jhj94idiL6JD/GF2DedgIx97IlWsbXqIHEcsl
        qVE+WELcq/c3DU4RElc966S6wB9zH2A=
X-Google-Smtp-Source: ABdhPJwJeguTleNrFwWpe+NDKboZHgwYiIJGzs4KzpP6L0P4Xxu+oCReUwkL0drdArDabCaKke3R5w==
X-Received: by 2002:adf:92a4:: with SMTP id 33mr2829592wrn.347.1607522455372;
        Wed, 09 Dec 2020 06:00:55 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:dc43:c735:4625:9787? (p200300ea8f065500dc43c73546259787.dip0.t-ipconnect.de. [2003:ea:8f06:5500:dc43:c735:4625:9787])
        by smtp.googlemail.com with ESMTPSA id r13sm3730243wrt.10.2020.12.09.06.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 06:00:54 -0800 (PST)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PCI: Change CLS info in pci_apply_final_quirks to debug level
Message-ID: <785a8518-cdcb-a3e1-add6-6c8964b46bf7@gmail.com>
Date:   Wed, 9 Dec 2020 15:00:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CLS is relevant only for devices using MWI, in addition
not really helpful messages like the following are printed:
PCI: CLS 0 bytes, default 64
Therefore change CLS info to debug level.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/quirks.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d9cbe69b8..af8d8ddfe 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -157,9 +157,6 @@ static int __init pci_apply_final_quirks(void)
 	u8 cls = 0;
 	u8 tmp;
 
-	if (pci_cache_line_size)
-		pr_info("PCI: CLS %u bytes\n", pci_cache_line_size << 2);
-
 	pci_apply_fixup_final_quirks = true;
 	for_each_pci_dev(dev) {
 		pci_fixup_device(pci_fixup_final, dev);
@@ -182,11 +179,11 @@ static int __init pci_apply_final_quirks(void)
 		}
 	}
 
-	if (!pci_cache_line_size) {
-		pr_info("PCI: CLS %u bytes, default %u\n", cls << 2,
-			pci_dfl_cache_line_size << 2);
-		pci_cache_line_size = cls ? cls : pci_dfl_cache_line_size;
-	}
+	if (!pci_cache_line_size)
+		pci_cache_line_size = cls ?: pci_dfl_cache_line_size;
+
+	pr_debug("PCI: CLS %u bytes, default %u\n", pci_cache_line_size << 2,
+		 pci_dfl_cache_line_size << 2);
 
 	return 0;
 }
-- 
2.29.2

