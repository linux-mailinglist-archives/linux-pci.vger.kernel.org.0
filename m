Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3596438CFE
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 03:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhJYB2X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 Oct 2021 21:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhJYB2W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Oct 2021 21:28:22 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C824C061745
        for <linux-pci@vger.kernel.org>; Sun, 24 Oct 2021 18:26:01 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id bp7so10239678qkb.12
        for <linux-pci@vger.kernel.org>; Sun, 24 Oct 2021 18:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VTEYBOVFC48ADDa8N43omwk7puK0joc4PFn0uiGMRcg=;
        b=jKwWtJj2+XorNlj49nPSke8a/Qft4zbyuljV+uV1cJ7UmjuQuKWRkIXvggCUofTGt2
         fVLAFa4nO7JOjDgshLvnReog5af2DO50+AKqbFHsLrCtSaIDbdw/d+yolCFh41KxOSfN
         JVrb5fOhJaDW0VdpOkD29CdgWJIRr413QXPcsaa21SPYZeWR1awOiKVnY5bYaAwYT63e
         bcdon+VyuSQ/O2n5n6MdhWxvzdZFckaSws/nc0JIcHPY8GX9nTah8n3p2z6eDL8M3BFF
         ZdhsE+C9QKoA/Bmsq03tfGHaljFw1Onk2KR26sai4r2EtPJtDmHiT1O6XklkU9XdFD90
         +Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTEYBOVFC48ADDa8N43omwk7puK0joc4PFn0uiGMRcg=;
        b=c6BklCf1EYRYyKDKy7MCrWgCH/MRMbe+w6IQsMu0YdROUsdWBVf/nv7pq9NerrhWUq
         LGxJ5pmKTBcfaewiefF4uFnhu4hSxf6tH9qLCM6m5++lxg8uovi3CRG93I+Xy6p0oXx4
         +UBNSTDOP7DXCJO973gfOF86Pnnb1U1QlU9/jf4rVJFS91cTTvLTp7pV5hOsXRS3rS+B
         0Df0l2iqhVt4qk1wTcyhMl3LDRQIJ8B0LfY+oM073gdg3VIT/gmQCY6LPsNfG8H1b1p7
         kLiBfUWAy9FOFVeFvQ3EfBsV3wjCws2WG1qrZpGWtz+CeB4yac6uQspoITFSzEK+kqNG
         Urhw==
X-Gm-Message-State: AOAM5308lVHkq5LX6AxiwRictiOSrT7a/RF/vTGccH/3SaF2B6McDCI4
        uD/dMAZYBfecIQ8ylzCf6kk=
X-Google-Smtp-Source: ABdhPJxdhx9YsyD2piku1kRFpYGiExJbAde47xpWYo9zrILaPmf8HpF05Y/EzU1HwylCgQrMbg2KWQ==
X-Received: by 2002:a05:620a:45a3:: with SMTP id bp35mr11126547qkb.262.1635125160419;
        Sun, 24 Oct 2021 18:26:00 -0700 (PDT)
Received: from shine.lan ([2001:470:8:67e:51e0:9342:22f6:f52e])
        by smtp.gmail.com with ESMTPSA id r186sm7786376qkf.128.2021.10.24.18.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 18:26:00 -0700 (PDT)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     josef@oderland.se
Cc:     boris.ostrovsky@oracle.com, helgaas@kernel.org, jandryuk@gmail.com,
        jgross@suse.com, linux-pci@vger.kernel.org, maz@kernel.org,
        tglx@linutronix.de, xen-devel@lists.xenproject.org
Subject: [PATCH] PCI/MSI: Fix masking MSI/MSI-X on Xen PV
Date:   Sun, 24 Oct 2021 21:25:03 -0400
Message-Id: <20211025012503.33172-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
References: <90277228-cf14-0cfa-c95e-d42e7d533353@oderland.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit fcacdfbef5a1 ("PCI/MSI: Provide a new set of mask and unmask
functions") introduce functions pci_msi_update_mask() and
pci_msix_write_vector_ctrl() that is missing checks for
pci_msi_ignore_mask that exists in commit 446a98b19fd6 ("PCI/MSI: Use
new mask/unmask functions").  The checks are in place at the high level
__pci_msi_mask_desc()/__pci_msi_unmask_desc(), but some functions call
directly to the helpers.

Push the pci_msi_ignore_mask check down to the functions that make
the actual writes.  This keeps the logic local to the writes that need
to be bypassed.

With Xen PV, the hypervisor is responsible for masking and unmasking the
interrupts, which pci_msi_ignore_mask is used to indicate.

This change avoids lockups in amdgpu drivers under Xen during boot.

Fixes: commit 446a98b19fd6 ("PCI/MSI: Use new mask/unmask functions")
Reported-by: Josef Johansson <josef@oderland.se>
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 drivers/pci/msi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4b4792940e86..478536bafc39 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -148,6 +148,9 @@ static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 s
 	raw_spinlock_t *lock = &desc->dev->msi_lock;
 	unsigned long flags;
 
+	if (pci_msi_ignore_mask)
+		return;
+
 	raw_spin_lock_irqsave(lock, flags);
 	desc->msi_mask &= ~clear;
 	desc->msi_mask |= set;
@@ -181,6 +184,9 @@ static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
 {
 	void __iomem *desc_addr = pci_msix_desc_addr(desc);
 
+	if (pci_msi_ignore_mask)
+		return;
+
 	writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
 
@@ -200,7 +206,7 @@ static inline void pci_msix_unmask(struct msi_desc *desc)
 
 static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
 {
-	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
+	if (desc->msi_attrib.is_virtual)
 		return;
 
 	if (desc->msi_attrib.is_msix)
@@ -211,7 +217,7 @@ static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
 
 static void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
 {
-	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
+	if (desc->msi_attrib.is_virtual)
 		return;
 
 	if (desc->msi_attrib.is_msix)
-- 
2.30.2

