Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A2121D70B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgGMNWq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbgGMNWm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:22:42 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DA9C061755;
        Mon, 13 Jul 2020 06:22:42 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so13694902edy.1;
        Mon, 13 Jul 2020 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cLqez7BSyfcefFRd7dwUFrtJ0GHfAxGAdp04dPgWsLE=;
        b=sio14PR2ZhNVYW5pRGQc2jglAo7nTdWWKSefc4gMs+wgVmGhec2a2fyBTfLZ6J14Qp
         coLl1eOLB8d5tKO9spI1RYxQiMgfsiKvvYaimdqIph4H23i9wUbc9MG280qJENvlajSw
         /VN2T/7nNcVFpitKVUM+s06FscbXZj7WUQDOgljFVatIS/RQoOWA14lTYbW+495xaTJy
         TaLylSHSuZwnAHDVc8I1k3YTYCGjgxetjP360T/El0/SU1JdisRR1pj7aP6wJUpLOce6
         00lgSzAedeQA2Yqg4ZoShFqwzsBOfMVh/JcesPq/SiBokPUANb05LCj7qdrsjvlUOqbi
         FybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cLqez7BSyfcefFRd7dwUFrtJ0GHfAxGAdp04dPgWsLE=;
        b=P6qEHBzZMZ88yAJjieoWRwL004ydfYd9SUREaE0hv7ZNArOSWYsSMd4B8dHhUFU39I
         8j21Gob9JCIU+HuG/be1WY9q0oSBtzd+CNACHuQgI6crATgnhZ1s4Zsy3vExoCJnHfxT
         FXuBnGvaaIR0lZDJ46QZz5Jp1210Pd0Q3NZeWch2mq/aVfa72E0trEGjGSJ5a/Xx+q1C
         2v9lKW4F5UEABTdnMQiwerBupsJPxFwm7PuLee82+3L1X0tqPEIoYYH+45vc3H5AXPkP
         B2769iYERimurF+73vQZJwN7Rg/rX22eUrX3fzRtvPkKaHgd5uTReRbIAbNzhSrMAY9w
         5dKA==
X-Gm-Message-State: AOAM531B/tvdErf8zerNxlCRtEd9YAYMGPXnquWb/9B6bQ4sN9nHkbDg
        4Zccmkk2XXBPyup//hLITU5qXwk1NIU0dg==
X-Google-Smtp-Source: ABdhPJw851ydCCL6n3xPVW+bl+icaHvx7ShHFlSz4LStRGij1QNNCQ6hE4bN7pmrcD8LYtZRUcTX8g==
X-Received: by 2002:a05:6402:359:: with SMTP id r25mr66126290edw.177.1594646561310;
        Mon, 13 Jul 2020 06:22:41 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:22:40 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [RFC PATCH 04/35] scsi: ipr: Tidy Success/Failure checks
Date:   Mon, 13 Jul 2020 14:22:16 +0200
Message-Id: <20200713122247.10985-5-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary check for 0.

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
This patch depends on PATCH 03/35

 drivers/scsi/ipr.c     | 12 ++++++------
 drivers/scsi/pmcraid.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index b6c52a04cf52..e714f82769bc 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -775,7 +775,7 @@ static int ipr_save_pcix_cmd_reg(struct ipr_ioa_cfg *ioa_cfg)
 		return 0;
 
 	if (pci_read_config_word(ioa_cfg->pdev, pcix_cmd_reg + PCI_X_CMD,
-				 &ioa_cfg->saved_pcix_cmd_reg) != 0) {
+				 &ioa_cfg->saved_pcix_cmd_reg)) {
 		dev_err(&ioa_cfg->pdev->dev, "Failed to save PCI-X command register\n");
 		return -EIO;
 	}
@@ -797,7 +797,7 @@ static int ipr_set_pcix_cmd_reg(struct ipr_ioa_cfg *ioa_cfg)
 
 	if (pcix_cmd_reg) {
 		if (pci_write_config_word(ioa_cfg->pdev, pcix_cmd_reg + PCI_X_CMD,
-					  ioa_cfg->saved_pcix_cmd_reg) != 0) {
+					  ioa_cfg->saved_pcix_cmd_reg)) {
 			dev_err(&ioa_cfg->pdev->dev, "Failed to setup PCI-X command register\n");
 			return -EIO;
 		}
@@ -8748,7 +8748,7 @@ static int ipr_reset_start_bist(struct ipr_cmnd *ipr_cmd)
 	else
 		rc = pci_write_config_byte(ioa_cfg->pdev, PCI_BIST, PCI_BIST_START);
 
-	if (rc == 0) {
+	if (!rc) {
 		ipr_cmd->job_step = ipr_reset_bist_done;
 		ipr_reset_start_timer(ipr_cmd, IPR_WAIT_FOR_BIST_TIMEOUT);
 		rc = IPR_RC_JOB_RETURN;
@@ -8946,7 +8946,7 @@ static int ipr_reset_alert(struct ipr_cmnd *ipr_cmd)
 	ENTER;
 	rc = pci_read_config_word(ioa_cfg->pdev, PCI_COMMAND, &cmd_reg);
 
-	if ((rc == 0) && (cmd_reg & PCI_COMMAND_MEMORY)) {
+	if ((!rc) && (cmd_reg & PCI_COMMAND_MEMORY)) {
 		ipr_mask_and_clear_interrupts(ioa_cfg, ~0);
 		writel(IPR_UPROCI_RESET_ALERT, ioa_cfg->regs.set_uproc_interrupt_reg32);
 		ipr_cmd->job_step = ipr_reset_wait_to_start_bist;
@@ -10256,7 +10256,7 @@ static int ipr_probe_ioa(struct pci_dev *pdev,
 	rc = pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE,
 				   ioa_cfg->chip_cfg->cache_line_size);
 
-	if (rc != 0) {
+	if (rc) {
 		dev_err(&pdev->dev, "Write of cache line size failed\n");
 		ipr_wait_for_pci_err_recovery(ioa_cfg);
 		rc = -EIO;
@@ -10337,7 +10337,7 @@ static int ipr_probe_ioa(struct pci_dev *pdev,
 	/* Save away PCI config space for use following IOA reset */
 	rc = pci_save_state(pdev);
 
-	if (rc != 0) {
+	if (rc) {
 		dev_err(&pdev->dev, "Failed to save PCI config space\n");
 		rc = -EIO;
 		goto cleanup_nolog;
diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 5f6e440f0dcd..151aa61b674b 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -553,7 +553,7 @@ static void pmcraid_bist_done(struct timer_list *t)
 	rc = pci_read_config_word(pinstance->pdev, PCI_COMMAND, &pci_reg);
 
 	/* If PCI config space can't be accessed wait for another two secs */
-	if ((rc != 0 || (!(pci_reg & PCI_COMMAND_MEMORY))) &&
+	if ((rc || (!(pci_reg & PCI_COMMAND_MEMORY))) &&
 	    cmd->time_left > 0) {
 		pmcraid_info("BIST not complete, waiting another 2 secs\n");
 		cmd->timer.expires = jiffies + cmd->time_left;
@@ -649,7 +649,7 @@ static void pmcraid_reset_alert(struct pmcraid_cmd *cmd)
 	 * BIST or slot_reset
 	 */
 	rc = pci_read_config_word(pinstance->pdev, PCI_COMMAND, &pci_reg);
-	if ((rc == 0) && (pci_reg & PCI_COMMAND_MEMORY)) {
+	if ((!rc) && (pci_reg & PCI_COMMAND_MEMORY)) {
 
 		/* wait for IOA permission i.e until CRITICAL_OPERATION bit is
 		 * reset IOA doesn't generate any interrupts when CRITICAL
-- 
2.18.2

