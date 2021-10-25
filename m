Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B44439D00
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 19:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhJYRK4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 13:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbhJYRJc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Oct 2021 13:09:32 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A39DC043193;
        Mon, 25 Oct 2021 10:02:22 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f5so11525418pgc.12;
        Mon, 25 Oct 2021 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IP7bg1XxqK5dXg//yE9NcJiabkbw2qPuKs1z85ZWNME=;
        b=A406sfTrXh8GMkSFquNuEPUPbjXrxLZbOVCF4bYpKdMv8ShllAqdbJdQb04lVxhhHC
         NKkoeX83bwle+wOS3SOVstoXdO16KEasww9oDGJfCUsjGE+DjaeiNTYWvT74nieEka1N
         K9m4PrHtdH1pmfWFdizj9JYhifV5yhsxqg5B2nEfXZTlzb1FIiswefawc0O2iMM8q21n
         2VdIMqT36zQmkVdUYJLMaFyxVljy8JP/WNfT9KkTRKj1UPdytBECAF68jGLrlBj6FB57
         L5pp6txUxHnZJtWsBWKRJm57CWn0g/mevx9sY+YHInLJ4anBMRAhda4Zyo/IHjmIQ/dr
         23eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IP7bg1XxqK5dXg//yE9NcJiabkbw2qPuKs1z85ZWNME=;
        b=JJWs1DU+uYzZlCNxj1CZjg+wJitRlri9adYakJMffMqO/nS8DAg2vA25pjHvKm1jHZ
         WWyJk0NoYYv9ZhBm+Cky9rB+yGXcPuaZQbjXnIqH8WIk6UwkJLKOS9k3nPJ8dVP9DlmR
         rjMFYEChGoIJ4U6qlzsn56eyrHHjKUNr5+RN8qeti3KpYZCkHdxL9Gss+0QibVvI5FNz
         I0Z9vHc47eDDb/nS2b92tkZ29WBhmiLTnb5WgfCCdYzw3XQ9wvvEWJMLPYIb+oNBxrd1
         v65ZylI7OyeTcBMaouybdxTr/uQJH/qn1NP524kZCZUAoSGu6TDYetmIvLx1ujYsS3HT
         EOyw==
X-Gm-Message-State: AOAM532LNORAPrR+Ao0gjeuh1T3mLjnpV5THjDkEZUOLScNBzmjDIMkY
        NuaCNHqWR8i9Y6DFFigBgSY=
X-Google-Smtp-Source: ABdhPJwVXGCGM66S42ZGCsnkfum3D4CcEQwiQH5P2pomnEuWRSCqLNJFiZU0F8DC/4n6/2A7JXHjoA==
X-Received: by 2002:a63:2a88:: with SMTP id q130mr14468449pgq.169.1635181341692;
        Mon, 25 Oct 2021 10:02:21 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:df8b:7255:8580:2394:764c])
        by smtp.gmail.com with ESMTPSA id g18sm5100858pfj.67.2021.10.25.10.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 10:02:21 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Keith Busch <kbusch@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v5 3/5] PCI/DPC: Initialize info.id in dpc_process_error()
Date:   Mon, 25 Oct 2021 22:31:02 +0530
Message-Id: <b486768a365ccef665b52fd9a1a2132006ab0f92.1635179600.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1635179600.git.naveennaidu479@gmail.com>
References: <cover.1635179600.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the dpc_process_error() path, info.id isn't initialized before being
passed to aer_print_error(). In the corresponding AER path, it is
initialized in aer_isr_one_error().

The error message shown during Coverity Scan is:

  Coverity #1461602
  CID 1461602 (#1 of 1): Uninitialized scalar variable (UNINIT)
  8. uninit_use_in_call: Using uninitialized value info.id when calling aer_print_error.

Also Per PCIe r5.0, sec 7.9.15.5, the Source ID is defined only when the
Trigger Reason indicates ERR_NONFATAL or ERR_FATAL. Initialize the
"info.id" based on the trigger reason before passing it to
aer_print_error()

Fixes: 8aefa9b0d910 ("PCI/DPC: Print AER status in DPC event handling")
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/dpc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index c556e7beafe3..6fa1b1eb4671 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -262,16 +262,24 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 
 void dpc_process_error(struct pci_dev *pdev)
 {
-	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
+	u16 cap = pdev->dpc_cap, status, reason, ext_reason;
 	struct aer_err_info info;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
+	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
+
+	/*
+	 * Per PCIe r5.0, sec 7.9.15.5, the Source ID is defined only when the
+	 * Trigger Reason indicates ERR_NONFATAL or ERR_FATAL.
+	 */
+	if (reason == 1 || reason == 2)
+		pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &info.id);
+	else
+		info.id = 0;
 
 	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
-		 status, source);
+		 status, info.id);
 
-	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
 	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
 	pci_warn(pdev, "%s detected\n",
 		 (reason == 0) ? "unmasked uncorrectable error" :
-- 
2.25.1

