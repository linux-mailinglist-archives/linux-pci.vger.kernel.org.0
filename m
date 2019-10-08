Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF758CF169
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 05:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbfJHDqn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 23:46:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42829 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbfJHDqn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2019 23:46:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id z12so9476036pgp.9
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2019 20:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qFl2JG96ct4qaQdNKzWCXwE4r0sb40nsc6Szq0amLLM=;
        b=caK2KVt/69FIetO/j+F/mQvB1T1lmIkD4M/Ym3pzovmMBDwSyGKyFWJgv0NbF28UBD
         fjOEKcKBuqESKXMKm5WPWzttX89uf3jwRekaqAlpN5UOGJqsu+9hjEjmr6fzj2r2UVFy
         0URF798o3LPYju7YYzyGV3xlkl3XWOTNHF1tfUNP8JjRiD344Tdpi4IuTDDPYqlMR3CV
         hsP3qnje76JOL/7K484k2kPmPOpfNHkE8OdRxnlb6QdpZqsw2TtlzOAp0NYtJsNte1G0
         yLfERjeFXHqRzqcQtpgCIN3tR09DD8OWw/ro89CYo2Frnd6PswVGQ9/JZw3KVFc2gXfY
         zAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qFl2JG96ct4qaQdNKzWCXwE4r0sb40nsc6Szq0amLLM=;
        b=oqQ/aNjJxgzWXNsfykJsMkf+MAgICXhjhNumWDHn/uemOSI1mP8+SbFEjCwIxeovUy
         NYPSm8plSSJT8Y6Ui0651CUfm9od+iO+jafLBRM/kfsZHLCO22GMSZhAynRFCgPLEL/M
         uNwZHphS+5TDOmtgaLYN5+yIPbX45Meh0+JU74S8N3dOxlhBHAkQhzZ1CCj1gC/kUkeW
         fECVB3658cHw6u4l3euYhSZhyD8A9aqcDsDyOAyWhyNI9fbx0FnS1PFDeh6WrCsexad/
         BXIDXHK3QM/JDYcYjRsi7/R+TvPkmpTMWu0ujG+w+WzWluhfavo35E+wFKp6UMAzQLVz
         olew==
X-Gm-Message-State: APjAAAV6Zw7U7i9Dny5R+PCpO8R64uujEiQat5DuLlkNFE/IYE039Q9x
        ssP4WKGquzRRTZITDsQLpHFodA==
X-Google-Smtp-Source: APXvYqz3+mfqHvMdhEbzTG1UT8a/Xp17PYp3x6VIfOSFrMyUdGVDRaOyTkraf7LX98u/PBz7QlCBKg==
X-Received: by 2002:a63:1401:: with SMTP id u1mr1888823pgl.73.1570506400944;
        Mon, 07 Oct 2019 20:46:40 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id r24sm15671364pfh.69.2019.10.07.20.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 20:46:40 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Matthew Wilcox <willy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux@endlesssm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] PCI/MSI: Fix restoring of MSI-X vector control's mask bit
Date:   Tue,  8 Oct 2019 11:42:39 +0800
Message-Id: <20191008034238.2503-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MSI-X vector control's bit 0 is the mask bit, which masks the
corresponding interrupt request, or not. Other reserved bits might be
used for other purpose by device vendors. For example, the values of
Kingston NVMe SSD's MSI-X vector control are neither 0, nor 1, but other
values [1].

The original restoring logic in system resuming uses the whole MSI-X
vector control value as the flag to set/clear the mask bit. However,
this logic conflicts the idea mentioned above. It may mislead system to
disable the MSI-X vector entries. That makes system get no interrupt
from Kingston NVMe SSD after resume and usually get NVMe I/O timeout
error.

[  174.715534] nvme nvme0: I/O 978 QID 3 timeout, completion polled

This patch takes only the mask bit of original MSI-X vector control
value as the flag to fix this issue.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=204887#c8

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=204887
Fixed: f2440d9acbe8 ("PCI MSI: Refactor interrupt masking code")
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 drivers/pci/msi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0884bedcfc7a..deae3d5acaf6 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -433,6 +433,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 static void __pci_restore_msix_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
+	u32 flag;
 
 	if (!dev->msix_enabled)
 		return;
@@ -444,8 +445,10 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
 
 	arch_restore_msi_irqs(dev);
-	for_each_pci_msi_entry(entry, dev)
-		msix_mask_irq(entry, entry->masked);
+	for_each_pci_msi_entry(entry, dev) {
+		flag = entry->masked & PCI_MSIX_ENTRY_CTRL_MASKBIT;
+		msix_mask_irq(entry, flag);
+	}
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
-- 
2.23.0

