Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABBA23523E
	for <lists+linux-pci@lfdr.de>; Sat,  1 Aug 2020 14:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgHAMZn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 Aug 2020 08:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgHAMY0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Aug 2020 08:24:26 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71499C06174A;
        Sat,  1 Aug 2020 05:24:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o23so6562719ejr.1;
        Sat, 01 Aug 2020 05:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BywL0jlhvMnVFDfC0ze8h5LlMNFaT8aAv2rtyExEJSw=;
        b=QHi5Tbht062uQl2CgFExEPFUSOMEeggyKWMdFMaxe6+Ih4MGawd4RuVAGo9gayKr/D
         2yHM3GwaZiead9mkPgX6CmWqtJbVMVrs1ivY/NsgsQYDy259Sl3XZbv/YgzUgCEEqs/l
         1wsrUeMhNsz49YAxVBQhfhiIj9RG9ULztEQd4Q8H0R1duiNIIlpXMswb/m7QfOuNR+W7
         PzhiKRCjDzvqB1woNt4nMSfQ4i7ZYPwKrKGD1c4qVxpaPGDRJJa1GAWZwDRByPlEFt8o
         ZwW6DJ21TN+PbO9dKjKlAV0aNVKmWm6tq8l2jd4PPsh2rNZxPgV7qhiiUwBiy6U/4PQq
         iFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BywL0jlhvMnVFDfC0ze8h5LlMNFaT8aAv2rtyExEJSw=;
        b=WwMuk4MJhSn/Z5RPIZ57fVWY8yEB4a8yze6sf0DNdA+h1WurNiHWkzxpXodZrLxxAR
         yM3UkKhLkjW6kKkqN3ysA8Gi8h0CwZ+rTBUscqSuGsBqewK+tL89k6rf4T88ek+CaNIC
         HerMYnHx3/hFoMFExtWL0cDfGx8PEMjrSMc/jxra72kDuKNNoNdwUQYXngIGFtMfj8DE
         hUKW+vwyVHNfN/u9PeibbnYaOi7LkuvA5XO5TLpAiwpUwAcWb6AmANqLL9KIVOHT9JFb
         8wcHjuytOOjeIBkS7PnmetfIHwV47/yzNNTXvcKg/dpffrWKCfXG6WMRMCMUfvUvRxPc
         ihJQ==
X-Gm-Message-State: AOAM533cb3gYLjraMelXrRdK3j7o/WQZJoaO68aW2kJI3SRkWyNPxdRR
        ZGBAf0OJbjNr12dtWn3Sm+E=
X-Google-Smtp-Source: ABdhPJz7rYxC2q7EJUBMGW38zssfKtQqC5IyJS7xjTc/otiniFOliqfObCiKTOcL0cPPw/LW53NfQw==
X-Received: by 2002:a17:906:1756:: with SMTP id d22mr8343053eje.29.1596284665171;
        Sat, 01 Aug 2020 05:24:25 -0700 (PDT)
Received: from net.saheed (95C84E0A.dsl.pool.telekom.hu. [149.200.78.10])
        by smtp.gmail.com with ESMTPSA id a101sm12083131edf.76.2020.08.01.05.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 05:24:24 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: [RFC PATCH 01/17] ata: Drop uses of pci_read_config_*() return value
Date:   Sat,  1 Aug 2020 13:24:30 +0200
Message-Id: <20200801112446.149549-2-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200801112446.149549-1-refactormyself@gmail.com>
References: <20200801112446.149549-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The return value of pci_read_config_*() may not indicate a device error.
However, the value read by these functions is more likely to indicate
this kind of error. This presents two overlapping ways of reporting
errors and complicates error checking.

It is possible to move to one single way of checking for error if the
dependency on the return value of these functions is removed, then it
can later be made to return void.

Remove all uses of the return value of pci_read_config_*().
Check the actual value read for ~0. In this case, ~0 is an invalid value
thus it indicates some kind of error.

drivers/ata/pata_cs5536.c cs5536_read() :
None of the callers of cs5536_read() uses the return value. The obtained
value can be checked for validity to confirm success.

Change the return type of cs5536_read() to void.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
---
 drivers/ata/pata_cs5536.c | 6 +++---
 drivers/ata/pata_rz1000.c | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index 760ac6e65216..c204215e239f 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -83,16 +83,16 @@ static const struct dmi_system_id udma_quirk_dmi_table[] = {
 	{ }
 };
 
-static int cs5536_read(struct pci_dev *pdev, int reg, u32 *val)
+static void cs5536_read(struct pci_dev *pdev, int reg, u32 *val)
 {
 	if (unlikely(use_msr)) {
 		u32 dummy __maybe_unused;
 
 		rdmsr(MSR_IDE_CFG + reg, *val, dummy);
-		return 0;
+		return;
 	}
 
-	return pci_read_config_dword(pdev, PCI_IDE_CFG + reg * 4, val);
+	pci_read_config_dword(pdev, PCI_IDE_CFG + reg * 4, val);
 }
 
 static int cs5536_write(struct pci_dev *pdev, int reg, int val)
diff --git a/drivers/ata/pata_rz1000.c b/drivers/ata/pata_rz1000.c
index 3722a67083fd..e0b3de376357 100644
--- a/drivers/ata/pata_rz1000.c
+++ b/drivers/ata/pata_rz1000.c
@@ -64,7 +64,8 @@ static int rz1000_fifo_disable(struct pci_dev *pdev)
 {
 	u16 reg;
 	/* Be exceptionally paranoid as we must be sure to apply the fix */
-	if (pci_read_config_word(pdev, 0x40, &reg) != 0)
+	pci_read_config_word(pdev, 0x40, &reg);
+	if (reg == (u16)~0)
 		return -1;
 	reg &= 0xDFFF;
 	if (pci_write_config_word(pdev, 0x40, reg) != 0)
-- 
2.18.4

