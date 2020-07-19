Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392842250DB
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jul 2020 11:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgGSJVU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Jul 2020 05:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSJVU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Jul 2020 05:21:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BE1C0619D2
        for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2020 02:21:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a9so2975933pjd.3
        for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2020 02:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWbYFYIu0qmpjpMid4/cfRGsYGBLqRNDtWeBkoqnf5A=;
        b=IUVH9hYdYtKdmEr0iL7kFbFPAoYNKsQUo9o3D7vRj/LRtCEjaIiOK+/ZpYLkPsKCSw
         LNvC77PektZN0gD4G7hezWii5cmrwZpUuFjbqzGrljbQWw7o9DBtZdft9p79v/D1BdTr
         zoEro0gnT7J0JC5EUKFZjkCDKDDq3E19wODbX7nCgusPybXLQiAsruNLwlJ7bEOKUiPU
         25IrxNRjWJd8uJ4OGZf8cRUswu8FOHHZROuwxFsChSqDCPX8s36RPSUgF5kkyKKQHpDL
         No2pvA+TyuCIctP71IySo/55gyRG5bae2WH8maI0fVBotDRs+PFFra8R+JvyqCxJotOS
         t34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWbYFYIu0qmpjpMid4/cfRGsYGBLqRNDtWeBkoqnf5A=;
        b=irK77h5bipG7lD3RtrdCW+HuE76IJLloBVHXuFmYK6nNqkktAhWNtM3vrnkH416B50
         D6NtNQQw1MaHyL4iQW2HWo0Mrcbj5KoGrtjjU5d7Bpxf80g9/pVTg1tcFbJ2Me/l6thK
         JB9XkMHD9EhZQBiI1nTAuiFtlm2h6LegaLJRTXtXWiNLfgXi0g9P2TXQ7m+ZCKZ8qIDZ
         q5ktOfy8upnhvdYn9BKer6E2BpH5C6fuPHcCiGhFt9qPn2vxE79T5XyvzRvCZWSDOnX5
         Qdl2hqsvtY9T/V7MnpRf7ucP0ZDRNQUOiTrdrayFVTArmxBDucF+dytkxcjOjhhClaKD
         IWQQ==
X-Gm-Message-State: AOAM533qNPj8QMOFy85VGjTJDddqv5YzQc13P+NswVqC1WfMPBkT0BN7
        cdSiQan0QXJ+J7WuXcAgm64=
X-Google-Smtp-Source: ABdhPJz/cm9/Ert5FZhVfv5koR2QvbD+NIBbWfvRk7/Gkcle9QzzGZo+yDtuqUuMeBrFuIli+t/9mQ==
X-Received: by 2002:a17:90b:102:: with SMTP id p2mr18831244pjz.227.1595150479861;
        Sun, 19 Jul 2020 02:21:19 -0700 (PDT)
Received: from localhost.localdomain ([124.253.248.36])
        by smtp.googlemail.com with ESMTPSA id s10sm11145207pjf.3.2020.07.19.02.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 02:21:19 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] PCI: Add _DSM Function definiton for Latency Tolerance Reporting
Date:   Sun, 19 Jul 2020 14:51:09 +0530
Message-Id: <20200719092109.21762-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI Firmware spec rev 3.2 defines function index 6 for LTR _DSM
Add a define for usage in LTR mechanism.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 include/linux/pci-acpi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 5ba475ca9078..2889bf7f2a39 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -110,6 +110,7 @@ extern const guid_t pci_acpi_dsm_guid;
 
 /* _DSM Definitions for PCI */
 #define DSM_PCI_PRESERVE_BOOT_CONFIG		0x05
+#define DSM_PCI_LTR				0x06
 #define DSM_PCI_DEVICE_NAME			0x07
 #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
 #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
-- 
2.27.0

