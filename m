Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007114210F7
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 16:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhJDOKi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 10:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhJDOKi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 10:10:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A70C061745;
        Mon,  4 Oct 2021 07:08:49 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 66so16231292pgc.9;
        Mon, 04 Oct 2021 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0szOl/Q5keJYQjPtxy9YApfb7ftHWXnTXQ4eoRdC7oM=;
        b=UODKNW+w6JqcRGrC4Q+SVrXJIBvZuiGgsC1CnbvFZLuTfE39R4UJV67JbABZzdikL7
         mbf/YH18xaYDC4DEhaBL1l/7kL+PPmddU6e0mLCjiEMNJLlla87mWMrFKFtf1VIdJP6Z
         8hTr95oy6ZMBtFcP4npA9+nhSNHkORukwWwwBs7KBd7OPB4jOGCxIp2nsrdw4iuknFxi
         79MjUOuX1W7exN3NFv48g+qpKefAvdzMKoJzeXyoND565RYILsbPR1kQ7btVh5BhRhJk
         SUehVB3Hk6HGg7A04lxfaLvQgr2Z7qDgcyQm7lGvJqIbabUTKuW6S2MOwUsWadLc2rgD
         CORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0szOl/Q5keJYQjPtxy9YApfb7ftHWXnTXQ4eoRdC7oM=;
        b=mpseafZKeCalV/AHdOKuMOvmh16fBFJz3llODRQZJNvfbz+t5Y9gmvEglhggNM6fC4
         1HRFr5znqUlxqATmyerXGl3ZYBp6G/GPWl8vSZG7HXaKSHc9f4Bi4IMFGh5GfjQhyslM
         ckv1Hku3BdyUC69dxG4C8Xl0TObsxA99MHh7GfxJ0JXg1EiWvbM7l7bC9WYODCeKjdQX
         9w5d2lshNFdpiN4MWROaTdz2IlkmUGoa2+5tHbFY6JJPrKCOea7NvqPgsWOArwJw5S/u
         3sNd9QBtt19p10dUtKRccCqOm6TvRJFQ9eX+E77VVt8QDHaZEPCsoFWAqPzRoqSBwFis
         a5IA==
X-Gm-Message-State: AOAM533cNfNMLrECpy0ppzL2b3Dhi15kMw4dKAPw06TEMvufuIUV1B+Q
        oun2w+exNoU6UJ+f0SSeDAL6C9ShSjxw0S+c
X-Google-Smtp-Source: ABdhPJxV2DJd3rBZSk13rzcbJOxYwFHvBZ/bK3s81EUKzlHhfCA8nMN5Z1RjiYiLyETYzXzaMnN0DQ==
X-Received: by 2002:a63:ed03:: with SMTP id d3mr11116397pgi.24.1633356529107;
        Mon, 04 Oct 2021 07:08:49 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:e8f0:c2a7:3579:5fe8:31d9])
        by smtp.gmail.com with ESMTPSA id p2sm15274135pgd.84.2021.10.04.07.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:08:48 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 3/8] PCI/DPC: Initialize info->id in dpc_process_error()
Date:   Mon,  4 Oct 2021 19:36:29 +0530
Message-Id: <d6e7eabf4fcf80b454dbcec507b3553448fcc95a.1633353468.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633353468.git.naveennaidu479@gmail.com>
References: <cover.1633353468.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the dpc_process_error() path, info->id isn't initialized before being
passed to aer_print_error(). In the corresponding AER path, it is
initialized in aer_isr_one_error().

The error message shown during Coverity Scan is:

  Coverity #1461602
  CID 1461602 (#1 of 1): Uninitialized scalar variable (UNINIT)
  8. uninit_use_in_call: Using uninitialized value info.id when calling aer_print_error.

Initialize the "info->id" before passing it to aer_print_error()

Fixes: 8aefa9b0d910 ("PCI/DPC: Print AER status in DPC event handling")
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/pcie/dpc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index c556e7beafe3..df3f3a10f8bc 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -262,14 +262,14 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 
 void dpc_process_error(struct pci_dev *pdev)
 {
-	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
+	u16 cap = pdev->dpc_cap, status, reason, ext_reason;
 	struct aer_err_info info;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &info.id);
 
 	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
-		 status, source);
+		 status, info.id);
 
 	reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN) >> 1;
 	ext_reason = (status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT) >> 5;
-- 
2.25.1

