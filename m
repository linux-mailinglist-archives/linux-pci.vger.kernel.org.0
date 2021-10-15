Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BC842F60E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbhJOOsf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240766AbhJOOsN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:48:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ED9C061764;
        Fri, 15 Oct 2021 07:46:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so7418609pjb.3;
        Fri, 15 Oct 2021 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXqQzO1oSewfqo9sAbFeLWFXnz/W3EVi0EQdPEI6sRE=;
        b=K53e7Oe+f9+7D7WpNDUco3qWePYRLXAYCersP6n2gPnyhNdVyIE3Wu1/0wXNvCeD4h
         GQwrZ1Ch9tnNznJLjY2BCfcuNx29Ntzjkp1QpG5TUU7MSzTzCmUOq1NHcaxBCGoxZxyy
         zIfAW+IH/LqvtfiGH23oImVF4unRFwnBN9vExy/ehbxrgFRX7YYyzxkVcc9KuA+iIEVN
         x8UujC0F/DA4KmjgsLX7BCsyrLN09joYUMjO/XpoZHl2nnyh0BtSo/Ujt9fhazeGrq2+
         bwvDDRhHpWmQtgwA4fSn8mw4uZYf066PvrVj1XtJxZlAJNneDe5bOTB1mzHAalmdDjLy
         q8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXqQzO1oSewfqo9sAbFeLWFXnz/W3EVi0EQdPEI6sRE=;
        b=01+P60Eow/pN6alrf/0o6wBS/SLdvZmCowG2rMCvcuh/cg8GwavzyR3/5k0R7buI2p
         1GIWbH/tJROgn/p08NbL9Bt6xiSXb4w4OZFdDPjv5JhlA1WrQxt9pbITnwITO46CYfbM
         5O9O3MsnYWP7tHiPYHmkifkNM4N0I4Xhs99tdS0UzrWq4h8EVugaI858ZAYeUnzuTMbR
         ZF3OYpyhdPvwSyGc+yUKsgqOUJuVUDQG46xfXUv5J8KeLyYx40LkW2DnrLnsKUceQD8n
         Z0u8SukGCjIfbGjLQAEFtEzqMocLnYqkIIkJ9oJuVTLPovHu2dPDtbznFtH+Vapw8q1x
         mtpg==
X-Gm-Message-State: AOAM530k0SJk6gxOi1MX4mmdsO9OTByqx8miQyZSd7X658foufacWI+1
        mDhnOXEulPM3xwnujNWKVRc=
X-Google-Smtp-Source: ABdhPJzsMZqm+frY+X1rHzGEJNsNKsVIy7dntkjRCaKaKKSNaCGslbffodRrOi1845tZSOiFoJhUTA==
X-Received: by 2002:a17:90a:bb82:: with SMTP id v2mr28357103pjr.57.1634309167032;
        Fri, 15 Oct 2021 07:46:07 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:46:06 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v2 18/24] PCI: pciehp: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Fri, 15 Oct 2021 20:08:59 +0530
Message-Id: <2bc987dc1dfb753c37a65b6c8c98c32e66a4d2a0.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use RESPONSE_IS_PCI_ERROR() to check the response we get when we read
data from hardware.

This helps unify PCI error response checking and make error checks
consistent and easier to find.

Compile tested only.

Acked-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 3024d7e85e6a..8a2f6bb643b5 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -89,7 +89,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 
 	do {
 		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-		if (slot_status == (u16) ~0) {
+		if (RESPONSE_IS_PCI_ERROR(&slot_status)) {
 			ctrl_info(ctrl, "%s: no response from device\n",
 				  __func__);
 			return 0;
@@ -165,7 +165,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	pcie_wait_cmd(ctrl);
 
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-	if (slot_ctrl == (u16) ~0) {
+	if (RESPONSE_IS_PCI_ERROR(&slot_ctrl)) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
 		goto out;
 	}
@@ -236,7 +236,7 @@ int pciehp_check_link_active(struct controller *ctrl)
 	int ret;
 
 	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || RESPONSE_IS_PCI_ERROR(&lnk_status))
 		return -ENODEV;
 
 	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
@@ -443,7 +443,7 @@ int pciehp_card_present(struct controller *ctrl)
 	int ret;
 
 	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-	if (ret == PCIBIOS_DEVICE_NOT_FOUND || slot_status == (u16)~0)
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || RESPONSE_IS_PCI_ERROR(&slot_status))
 		return -ENODEV;
 
 	return !!(slot_status & PCI_EXP_SLTSTA_PDS);
@@ -621,7 +621,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 
 read_status:
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
-	if (status == (u16) ~0) {
+	if (RESPONSE_IS_PCI_ERROR(&status)) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
 		if (parent)
 			pm_runtime_put(parent);
-- 
2.25.1

