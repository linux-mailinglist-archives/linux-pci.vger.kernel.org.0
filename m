Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726F442967E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 20:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbhJKSKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 14:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJKSKB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 14:10:01 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE2FC061570;
        Mon, 11 Oct 2021 11:08:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 187so15491709pfc.10;
        Mon, 11 Oct 2021 11:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0K780od6SkXxyzgD37FaMrqeQX5N/LnzRZ9Hnpevh0=;
        b=TJ1M8P/6r5Fqqe/25bGrg4b9hoDDWhuY/YdRN8PjBDpPkIOtyW0PIHA5JFWJ4vIDtY
         SJlieLuEGnChLE5RIhSNwgZJyqnLgGz+O+wLiyek4Sff4bPaRLkgX/rPMD/sCZNEabAS
         csI5WdTYhJQQg5JcTltQhTNO9+fG1CWz9uAy+7lkugFhKTdE0dkcYbRXkjDKPkim9pfO
         pjj7qZfodYKgUlivGJQ0lVvXewhjRwe5Z0+PwJ9Wu4QyMOm1Acx6Vh4uoJza5DD7dNw1
         9+lg+pg/BUbruhm0SpR2lYEDIrmvJp9Zt0Z6Ans7jRQUOvMgiayyRLShirMFHSxBajwA
         9PDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0K780od6SkXxyzgD37FaMrqeQX5N/LnzRZ9Hnpevh0=;
        b=nX9emTM7Xb7wsdsO4kQiJ2y4h/ZJmY0gWbP1u28uhcfDzc0Kpp+8GsEH+J1AJrRoFj
         nFxzFadTubIuwr0SkZs5RDTLyboGTUkwsW4XNaJ8b4cF/fjfBMFILMkDekx6jn7fMHwK
         1nnok0CTFN3XdG2X9UzrBoFztj7ZuEdMEmGJ0E48DuWjYA5JHuEASJTBl5ZWBXzYG4Vf
         1+PhtLamfQgJj3zTP942KSBdZIjL2AAJ9HnwbLwGA1IhcDbTzXAv+daZFtSNyykVwcAD
         1yUBCYaHED04Sq0piFbiFk61PpAq+OUZCe/5CXXmfd2zt1kTuuhcbA5CwwOm5X7Q58Kr
         Tufw==
X-Gm-Message-State: AOAM532odQfvMylTlrTOrSkLBhMpqC1TOIMYR2Di2G5mz+JUPFa2sVlf
        dwb5CMIYhUcqACMpD96HsQ8wEtRqKP5QBeMa
X-Google-Smtp-Source: ABdhPJxN4B0rj03PV6wsTbUoJkrosvN/e2CX7DANFVkINHLQWIOlBYz7a8SZyu1rHhASv5ybm28aHw==
X-Received: by 2002:a63:84c3:: with SMTP id k186mr83113pgd.462.1633975681030;
        Mon, 11 Oct 2021 11:08:01 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:9f95:848b:7cc8:d852:ad42])
        by smtp.gmail.com with ESMTPSA id 4sm135643pjb.21.2021.10.11.11.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:08:00 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 16/22] PCI: pciehp: Use RESPONSE_IS_PCI_ERROR() to check read from hardware
Date:   Mon, 11 Oct 2021 23:37:33 +0530
Message-Id: <36c7c3005c4d86a6884b270807d84433a86c0953.1633972263.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1633972263.git.naveennaidu479@gmail.com>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
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

