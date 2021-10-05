Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBA2422F03
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 19:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbhJERWC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 13:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbhJERV5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 13:21:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA514C061749;
        Tue,  5 Oct 2021 10:20:06 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so150385pjb.1;
        Tue, 05 Oct 2021 10:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0szOl/Q5keJYQjPtxy9YApfb7ftHWXnTXQ4eoRdC7oM=;
        b=EqpIK1vTXdHM2T3qpKt7B5M72W9yNHp47Ooa5AzhsBqv/LSEr3GylhgEQKGtBbz8aF
         ISkGnHZ77zRoof4FGCAdApmHRV4hxmhkzizSs9NOl/xyHgjEVdTwam86QBgOsUuIcb+J
         MRHmgyoMWSbW56wDErgWeTtD9EB7ErJcD/LDcXR+l+fKPPqx6LUqgKtZ1BGRPPxEfttB
         kQrD7xtiMRRpIOJPGyXtAAcyb0Dvj+ucWvAf6Q9eOTvEiUobNqdLsz4r2NvwflOVZ198
         NleQppPNm4L6lTW5T4nON1Qwp7V7Q6OaU8CaF6s1ggbc5qjIvX2Jv1y2Vhsnc9PenK3Y
         6EYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0szOl/Q5keJYQjPtxy9YApfb7ftHWXnTXQ4eoRdC7oM=;
        b=jwLhFU1ctaJH/ZZeFIH+XUE2EpzES0z2H9urf/qE9wVXUscPPMAUnSYW6vu660TNDz
         TIVXilQ6zhIIBFtCArs1AF+xe6jBKQ75S8y/B7+9m2UJNULncEPY/dXLfxRjQUaf6F0R
         ++NK+9KvkCMMpOEPufOjRNp/ndOOSMZOVvLtZQfk5L9+X8JvaejrYgqH9yGb2X24lc+Q
         TaEOgvvqKwm5WWqd/2Vdcb9zxS7hQVHNyXBKL6crHtbgt3aMv2GOD9MiL7AkZJUv24in
         9KsumNANXHVyL/yGybqHDlU1hJWnqsoFTonLUmtiE2PLDsf4+vy5Wsv/t0cKqjEgH87H
         rMEA==
X-Gm-Message-State: AOAM531SzhfjKACb8XTg6UOOVy7Jg5u6xqgfJad9NzgPenvXNHD6UmfK
        +9lSeoTfkrPIkqypko/JF8U=
X-Google-Smtp-Source: ABdhPJzQlgbJ2vipxR8pOXATO00s5SdfAkVzILUymzDybhDIw7JfAUJP3lpRvmIhgSc/zwSufi+TBw==
X-Received: by 2002:a17:90a:19d2:: with SMTP id 18mr5145011pjj.27.1633454406293;
        Tue, 05 Oct 2021 10:20:06 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:f69:1127:b4ce:ef67:b718])
        by smtp.gmail.com with ESMTPSA id f25sm18476722pge.7.2021.10.05.10.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 10:20:05 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 3/8] PCI/DPC: Initialize info->id in dpc_process_error()
Date:   Tue,  5 Oct 2021 22:48:10 +0530
Message-Id: <5ebe87f18339d7567c1d91203e7c5d31f4e65c52.1633453452.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633453452.git.naveennaidu479@gmail.com>
References: <cover.1633453452.git.naveennaidu479@gmail.com>
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

