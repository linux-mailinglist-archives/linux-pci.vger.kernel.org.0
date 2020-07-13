Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D936221D70D
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgGMNZi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgGMNWl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:22:41 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA28C061755;
        Mon, 13 Jul 2020 06:22:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l12so17127960ejn.10;
        Mon, 13 Jul 2020 06:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kVHWYWvPcZhbbCSVf176+HxbB/imYoYR0qAJmfiByxM=;
        b=QFjmoNKLVNjf3U2P646R/7d2KQk03W7jh/TBjE8hGf6d/jlTCNbiJYpksALoO1lpbB
         c6jGZAv25Va9Vv/meTYwQnEFX+I6e4TriXoajmfjzFcQSGKGoE+apHWx+tgRorVGcYQF
         SFFr7QltezJy570u5Rz+xX65t01O5FRzMr+Q7ApZgfWoQcSBlD5Poi0oizwBwLff2/M9
         4CSVY6TAhIj17xfVDFNCpNgApblJEBWUYePn62g9j5cmua23mA+L0W3MhA0LBFHCbnfm
         WpHPPKG6P6zKvD/p4Uftc8vQwXREU0foxzYAoSBJlS60kzuARgryaULGAdN3pGaa4pRD
         FjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kVHWYWvPcZhbbCSVf176+HxbB/imYoYR0qAJmfiByxM=;
        b=lkjKRqzL1psaYgkfP8tmvYDpIvNcWplpv0iEp37Y9L3gHVJPf/r1A/CltEdwi75O83
         h/ZZ6+4ZgHAH51o8ku41hzTrFMHRszZYSGkckP0VYSkJjRExgNVjnKzF5SsJqyzMUHuL
         0huUo35erfDYxWZIh6DYZa8arhyQ8et3lEPIcpKK1VdnG/1liX7/IEZL0h/4Gob7tGAq
         zfA9ZHhvNuFtqEcyCBlhJ7uG87CDkPYy9c9E78k1v7dhUWqIYdUqR0ldN/iDX7gvUboP
         qMFmUqwla31Fb9mvb7u2P9SwYgcFLwDoxotCG/lmJAVDt5dR+52ggWhMBdEwmcIBulfa
         hKAQ==
X-Gm-Message-State: AOAM530nB7AU4hCCRUfr/fkj1hyYC0IbYxu3dWxYJAn3I2gKIwCjQlI/
        5pms1rZmYDiZlXq8CmXBbr4=
X-Google-Smtp-Source: ABdhPJzejmxGBjJ0fiS9zehGy/8XQ4P0gWhbmgIO8mnaoPpL56MEc2+mI7hVAr8MrmwimXgYioGUVA==
X-Received: by 2002:a17:906:7f90:: with SMTP id f16mr72707884ejr.507.1594646560025;
        Mon, 13 Jul 2020 06:22:40 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:22:39 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC PATCH 03/35] scsi: ipr: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:15 +0200
Message-Id: <20200713122247.10985-4-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
Their scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 drivers/scsi/ipr.c     | 16 ++++++++--------
 drivers/scsi/pmcraid.c |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 7d86f4ca266c..b6c52a04cf52 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -775,7 +775,7 @@ static int ipr_save_pcix_cmd_reg(struct ipr_ioa_cfg *ioa_cfg)
 		return 0;
 
 	if (pci_read_config_word(ioa_cfg->pdev, pcix_cmd_reg + PCI_X_CMD,
-				 &ioa_cfg->saved_pcix_cmd_reg) != PCIBIOS_SUCCESSFUL) {
+				 &ioa_cfg->saved_pcix_cmd_reg) != 0) {
 		dev_err(&ioa_cfg->pdev->dev, "Failed to save PCI-X command register\n");
 		return -EIO;
 	}
@@ -797,7 +797,7 @@ static int ipr_set_pcix_cmd_reg(struct ipr_ioa_cfg *ioa_cfg)
 
 	if (pcix_cmd_reg) {
 		if (pci_write_config_word(ioa_cfg->pdev, pcix_cmd_reg + PCI_X_CMD,
-					  ioa_cfg->saved_pcix_cmd_reg) != PCIBIOS_SUCCESSFUL) {
+					  ioa_cfg->saved_pcix_cmd_reg) != 0) {
 			dev_err(&ioa_cfg->pdev->dev, "Failed to setup PCI-X command register\n");
 			return -EIO;
 		}
@@ -8739,7 +8739,7 @@ static int ipr_reset_bist_done(struct ipr_cmnd *ipr_cmd)
 static int ipr_reset_start_bist(struct ipr_cmnd *ipr_cmd)
 {
 	struct ipr_ioa_cfg *ioa_cfg = ipr_cmd->ioa_cfg;
-	int rc = PCIBIOS_SUCCESSFUL;
+	int rc = 0;
 
 	ENTER;
 	if (ioa_cfg->ipr_chip->bist_method == IPR_MMIO)
@@ -8748,7 +8748,7 @@ static int ipr_reset_start_bist(struct ipr_cmnd *ipr_cmd)
 	else
 		rc = pci_write_config_byte(ioa_cfg->pdev, PCI_BIST, PCI_BIST_START);
 
-	if (rc == PCIBIOS_SUCCESSFUL) {
+	if (rc == 0) {
 		ipr_cmd->job_step = ipr_reset_bist_done;
 		ipr_reset_start_timer(ipr_cmd, IPR_WAIT_FOR_BIST_TIMEOUT);
 		rc = IPR_RC_JOB_RETURN;
@@ -8946,7 +8946,7 @@ static int ipr_reset_alert(struct ipr_cmnd *ipr_cmd)
 	ENTER;
 	rc = pci_read_config_word(ioa_cfg->pdev, PCI_COMMAND, &cmd_reg);
 
-	if ((rc == PCIBIOS_SUCCESSFUL) && (cmd_reg & PCI_COMMAND_MEMORY)) {
+	if ((rc == 0) && (cmd_reg & PCI_COMMAND_MEMORY)) {
 		ipr_mask_and_clear_interrupts(ioa_cfg, ~0);
 		writel(IPR_UPROCI_RESET_ALERT, ioa_cfg->regs.set_uproc_interrupt_reg32);
 		ipr_cmd->job_step = ipr_reset_wait_to_start_bist;
@@ -10154,7 +10154,7 @@ static int ipr_probe_ioa(struct pci_dev *pdev,
 	struct Scsi_Host *host;
 	unsigned long ipr_regs_pci;
 	void __iomem *ipr_regs;
-	int rc = PCIBIOS_SUCCESSFUL;
+	int rc = 0;
 	volatile u32 mask, uproc, interrupts;
 	unsigned long lock_flags, driver_lock_flags;
 	unsigned int irq_flag;
@@ -10256,7 +10256,7 @@ static int ipr_probe_ioa(struct pci_dev *pdev,
 	rc = pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE,
 				   ioa_cfg->chip_cfg->cache_line_size);
 
-	if (rc != PCIBIOS_SUCCESSFUL) {
+	if (rc != 0) {
 		dev_err(&pdev->dev, "Write of cache line size failed\n");
 		ipr_wait_for_pci_err_recovery(ioa_cfg);
 		rc = -EIO;
@@ -10337,7 +10337,7 @@ static int ipr_probe_ioa(struct pci_dev *pdev,
 	/* Save away PCI config space for use following IOA reset */
 	rc = pci_save_state(pdev);
 
-	if (rc != PCIBIOS_SUCCESSFUL) {
+	if (rc != 0) {
 		dev_err(&pdev->dev, "Failed to save PCI config space\n");
 		rc = -EIO;
 		goto cleanup_nolog;
diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index aa9ae2ae8579..5f6e440f0dcd 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -553,7 +553,7 @@ static void pmcraid_bist_done(struct timer_list *t)
 	rc = pci_read_config_word(pinstance->pdev, PCI_COMMAND, &pci_reg);
 
 	/* If PCI config space can't be accessed wait for another two secs */
-	if ((rc != PCIBIOS_SUCCESSFUL || (!(pci_reg & PCI_COMMAND_MEMORY))) &&
+	if ((rc != 0 || (!(pci_reg & PCI_COMMAND_MEMORY))) &&
 	    cmd->time_left > 0) {
 		pmcraid_info("BIST not complete, waiting another 2 secs\n");
 		cmd->timer.expires = jiffies + cmd->time_left;
@@ -649,7 +649,7 @@ static void pmcraid_reset_alert(struct pmcraid_cmd *cmd)
 	 * BIST or slot_reset
 	 */
 	rc = pci_read_config_word(pinstance->pdev, PCI_COMMAND, &pci_reg);
-	if ((rc == PCIBIOS_SUCCESSFUL) && (pci_reg & PCI_COMMAND_MEMORY)) {
+	if ((rc == 0) && (pci_reg & PCI_COMMAND_MEMORY)) {
 
 		/* wait for IOA permission i.e until CRITICAL_OPERATION bit is
 		 * reset IOA doesn't generate any interrupts when CRITICAL
@@ -5651,7 +5651,7 @@ static int pmcraid_probe(struct pci_dev *pdev,
 	struct pmcraid_instance *pinstance;
 	struct Scsi_Host *host;
 	void __iomem *mapped_pci_addr;
-	int rc = PCIBIOS_SUCCESSFUL;
+	int rc = 0;
 
 	if (atomic_read(&pmcraid_adapter_count) >= PMCRAID_MAX_ADAPTERS) {
 		pmcraid_err
-- 
2.18.2

