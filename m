Return-Path: <linux-pci+bounces-9372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D89D91A3A8
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 12:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1827B20DA8
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 10:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3462513D2A0;
	Thu, 27 Jun 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HlqFPfXw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F813D8AE
	for <linux-pci@vger.kernel.org>; Thu, 27 Jun 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483659; cv=none; b=OiMAFTb8pRPTLpcQlVS2aQXmf/wQZ3qtUGTJwP+gFpj1GbzIMm6Fe9WCxTSA/6Ig1ddOFsQ5yyoa9ZAVwGTp34aaNJ6ZI5GX7nnuLrqI1s+d8CB2iRJoZ1TzC0oQ0PrnFT2jdpP+QOKRRaDQzVc8TmGlk1ogGJ5pFq/58nkA2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483659; c=relaxed/simple;
	bh=y48p446RVqvEWEiM6yWN5XEmM9CNB3uTjdEyQUlQcSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUtdWEsIxPk5TZDpABYr7mN+3WzpwIfnjZak/adUrIl107zn72ezpYAjGWSz9t51Fgo11+gnnJRWblm7CfZEGcIlwdV1k9TD+CVsJNRxyHtNc0SCTQd21N6JjLzaFWG/9fKN9FuqqHMWPAzlQnhdKY8GrXKp0dqSQH27DifVPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HlqFPfXw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fa9f540f45so9543385ad.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Jun 2024 03:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1719483657; x=1720088457; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QZU3Nwz8ba69kOxRpo5Mkgz+00ut7nQ6umV+XwMCSvk=;
        b=HlqFPfXwI73UFNDOvsUmQ8Pq/fpY9wIMMMtoZag2/beXdJAZtNjilMKGqjj3oKIuew
         HiWMJI/XpLNpYJVUP76KeEvUn3LEYQtMHPEmLFHR98qJTrANkxZrugIlo6dLeUDpc4QK
         OnE1tygAO+fcsBg4+c7QUys3tc6LPaKDsK3ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719483657; x=1720088457;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZU3Nwz8ba69kOxRpo5Mkgz+00ut7nQ6umV+XwMCSvk=;
        b=YWzsiqvsQ8nfAYJD31RXVT1BawPXnjSudAcxHChUkZF3Nc9A/41z3kS0hDslJo4pXA
         M00eb21H0mXuH4qEWJv9sckCh7D7ODAwwvBA0QgJTkHQCZCiogCoO1uW5n8b8wJ0MH2Z
         E01IYkqPj5tmhU6yYVmwKtaXjW4AvXZAIYnR1/BSM9qFTGl2VA2R7cXYUq24QAa51RLq
         0njY/Lu82EgaF2sdm8ILcr8rwnkCIvypSscCKBZkya5vuyzglz9BGpFg1T1uOq5ZDnuf
         O6xa9Gz8L3pcQWeuUCWGmcy1ONxaosF+/NhaKY0G+AjLI+D9QotCsIflYSPiygFg1JfN
         ha0w==
X-Forwarded-Encrypted: i=1; AJvYcCW7VWayIDJSSIx9uMuirXp9Jxa/VgMTXCRgKkXq4I5z2ioNNQ/GQ4vK2h0EORqNrGnX5OrbieiZ6WfONMM2mwQOUxjZamXlHj7y
X-Gm-Message-State: AOJu0Yz1RXGI59XdqQqt14Z6LbYBkOsR6Ma99EmbGcYLeAmYK8o/mFgM
	LaAjAYj4YS99tWqbgfw8b5qOFoXbguoIZeZ4RPrnBnwLD1LWDve75a8TJakSBg==
X-Google-Smtp-Source: AGHT+IF+eDV9qER+RB3on91Ra1/gz6JB6AY3+hCqcEjh3hyoBePN70kitv0kqzSG7ga6EbSj5xUfRw==
X-Received: by 2002:a17:903:234c:b0:1f9:ba4b:57f2 with SMTP id d9443c01a7336-1fa6909e7abmr77823265ad.21.1719483656572;
        Thu, 27 Jun 2024 03:20:56 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac979478sm9858495ad.180.2024.06.27.03.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:20:55 -0700 (PDT)
From: Sumit Saxena <sumit.saxena@broadcom.com>
To: martin.petersen@oracle.com,
	helgaas@kernel.org,
	sathya.prakash@broadcom.com,
	sumit.saxena@broadcom.com,
	chandrakanth.patil@broadcom.com,
	ranjan.kumar@broadcom.com,
	prayas.patel@broadcom.com
Cc: linux-scsi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 2/3] mpi3mr: Prevent PCI writes from driver during PCI  error recovery
Date: Thu, 27 Jun 2024 15:47:34 +0530
Message-Id: <20240627101735.18286-3-sumit.saxena@broadcom.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240627101735.18286-1-sumit.saxena@broadcom.com>
References: <20240627101735.18286-1-sumit.saxena@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000940075061bdc7cc3"

--000000000000940075061bdc7cc3
Content-Transfer-Encoding: 8bit

Prevent interaction with the hardware while the error recovery in progress.

Signed-off-by: Sathya Prakash <sathya.prakash@broadcom.com>
Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
---
 drivers/scsi/mpi3mr/mpi3mr.h           |  1 +
 drivers/scsi/mpi3mr/mpi3mr_app.c       | 10 ++++--
 drivers/scsi/mpi3mr/mpi3mr_fw.c        | 22 +++++++++---
 drivers/scsi/mpi3mr/mpi3mr_os.c        | 49 +++++++++++++++++++++++---
 drivers/scsi/mpi3mr/mpi3mr_transport.c | 39 +++++++++++++++++---
 5 files changed, 104 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 2b1d5645ba9b..e99bb8ec428c 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -519,6 +519,7 @@ struct mpi3mr_throttle_group_info {
 
 /* HBA port flags */
 #define MPI3MR_HBA_PORT_FLAG_DIRTY	0x01
+#define MPI3MR_HBA_PORT_FLAG_NEW       0x02
 
 /* IOCTL data transfer sge*/
 #define MPI3MR_NUM_IOCTL_SGE		256
diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index f73f265c7921..c369f58fc93a 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -846,7 +846,7 @@ static int mpi3mr_bsg_pel_abort(struct mpi3mr_ioc *mrioc)
 		dprint_bsg_err(mrioc, "%s: reset in progress\n", __func__);
 		return -1;
 	}
-	if (mrioc->stop_bsgs) {
+	if (mrioc->stop_bsgs || mrioc->block_on_pci_err) {
 		dprint_bsg_err(mrioc, "%s: bsgs are blocked\n", __func__);
 		return -1;
 	}
@@ -1492,6 +1492,9 @@ static long mpi3mr_bsg_adp_reset(struct mpi3mr_ioc *mrioc,
 		goto out;
 	}
 
+	if (mrioc->unrecoverable || mrioc->block_on_pci_err)
+		return -EINVAL;
+
 	sg_copy_to_buffer(job->request_payload.sg_list,
 			  job->request_payload.sg_cnt,
 			  &adpreset, sizeof(adpreset));
@@ -2575,7 +2578,7 @@ static long mpi3mr_bsg_process_mpt_cmds(struct bsg_job *job)
 		mutex_unlock(&mrioc->bsg_cmds.mutex);
 		goto out;
 	}
-	if (mrioc->stop_bsgs) {
+	if (mrioc->stop_bsgs || mrioc->block_on_pci_err) {
 		dprint_bsg_err(mrioc, "%s: bsgs are blocked\n", __func__);
 		rval = -EAGAIN;
 		mutex_unlock(&mrioc->bsg_cmds.mutex);
@@ -3108,7 +3111,8 @@ adp_state_show(struct device *dev, struct device_attribute *attr,
 	ioc_state = mpi3mr_get_iocstate(mrioc);
 	if (ioc_state == MRIOC_STATE_UNRECOVERABLE)
 		adp_state = MPI3MR_BSG_ADPSTATE_UNRECOVERABLE;
-	else if ((mrioc->reset_in_progress) || (mrioc->stop_bsgs))
+	else if (mrioc->reset_in_progress || mrioc->stop_bsgs ||
+		 mrioc->block_on_pci_err)
 		adp_state = MPI3MR_BSG_ADPSTATE_IN_RESET;
 	else if (ioc_state == MRIOC_STATE_FAULT)
 		adp_state = MPI3MR_BSG_ADPSTATE_FAULT;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 458c856dda4b..c196dc14ad20 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -608,7 +608,7 @@ int mpi3mr_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	mrioc = (struct mpi3mr_ioc *)shost->hostdata;
 
 	if ((mrioc->reset_in_progress || mrioc->prepare_for_reset ||
-	    mrioc->unrecoverable))
+	    mrioc->unrecoverable || mrioc->pci_err_recovery))
 		return 0;
 
 	num_entries = mpi3mr_process_op_reply_q(mrioc,
@@ -1693,6 +1693,12 @@ int mpi3mr_admin_request_post(struct mpi3mr_ioc *mrioc, void *admin_req,
 		retval = -EAGAIN;
 		goto out;
 	}
+	if (mrioc->pci_err_recovery) {
+		ioc_err(mrioc, "admin request queue submission failed due to pci error recovery in progress\n");
+		retval = -EAGAIN;
+		goto out;
+	}
+
 	areq_entry = (u8 *)mrioc->admin_req_base +
 	    (areq_pi * MPI3MR_ADMIN_REQ_FRAME_SZ);
 	memset(areq_entry, 0, MPI3MR_ADMIN_REQ_FRAME_SZ);
@@ -2363,6 +2369,11 @@ int mpi3mr_op_request_post(struct mpi3mr_ioc *mrioc,
 		retval = -EAGAIN;
 		goto out;
 	}
+	if (mrioc->pci_err_recovery) {
+		ioc_err(mrioc, "operational request queue submission failed due to pci error recovery in progress\n");
+		retval = -EAGAIN;
+		goto out;
+	}
 
 	segment_base_addr = segments[pi / op_req_q->segment_qd].segment;
 	req_entry = (u8 *)segment_base_addr +
@@ -2627,7 +2638,7 @@ static void mpi3mr_watchdog_work(struct work_struct *work)
 	union mpi3mr_trigger_data trigger_data;
 	u16 reset_reason = MPI3MR_RESET_FROM_FAULT_WATCH;
 
-	if (mrioc->reset_in_progress)
+	if (mrioc->reset_in_progress || mrioc->pci_err_recovery)
 		return;
 
 	if (!mrioc->unrecoverable && !pci_device_is_present(mrioc->pdev)) {
@@ -4268,7 +4279,7 @@ int mpi3mr_reinit_ioc(struct mpi3mr_ioc *mrioc, u8 is_resume)
 		goto out_failed_noretry;
 	}
 
-	if (is_resume) {
+	if (is_resume || mrioc->block_on_pci_err) {
 		dprint_reset(mrioc, "setting up single ISR\n");
 		retval = mpi3mr_setup_isr(mrioc, 1);
 		if (retval) {
@@ -4319,7 +4330,7 @@ int mpi3mr_reinit_ioc(struct mpi3mr_ioc *mrioc, u8 is_resume)
 		goto out_failed;
 	}
 
-	if (is_resume) {
+	if (is_resume || mrioc->block_on_pci_err) {
 		dprint_reset(mrioc, "setting up multiple ISR\n");
 		retval = mpi3mr_setup_isr(mrioc, 0);
 		if (retval) {
@@ -4807,7 +4818,8 @@ void mpi3mr_cleanup_ioc(struct mpi3mr_ioc *mrioc)
 
 	ioc_state = mpi3mr_get_iocstate(mrioc);
 
-	if ((!mrioc->unrecoverable) && (!mrioc->reset_in_progress) &&
+	if (!mrioc->unrecoverable && !mrioc->reset_in_progress &&
+	    !mrioc->pci_err_recovery &&
 	    (ioc_state == MRIOC_STATE_READY)) {
 		if (mpi3mr_issue_and_process_mur(mrioc,
 		    MPI3MR_RESET_FROM_CTLR_CLEANUP))
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 0986b362e5f0..69b14918de59 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -956,7 +956,7 @@ static int mpi3mr_report_tgtdev_to_host(struct mpi3mr_ioc *mrioc,
 	int retval = 0;
 	struct mpi3mr_tgt_dev *tgtdev;
 
-	if (mrioc->reset_in_progress)
+	if (mrioc->reset_in_progress || mrioc->pci_err_recovery)
 		return -1;
 
 	tgtdev = mpi3mr_get_tgtdev_by_perst_id(mrioc, perst_id);
@@ -2007,6 +2007,7 @@ static void mpi3mr_fwevt_bh(struct mpi3mr_ioc *mrioc,
 	struct mpi3_device_page0 *dev_pg0 = NULL;
 	u16 perst_id, handle, dev_info;
 	struct mpi3_device0_sas_sata_format *sasinf = NULL;
+	unsigned int timeout;
 
 	mpi3mr_fwevt_del_from_list(mrioc, fwevt);
 	mrioc->current_event = fwevt;
@@ -2097,8 +2098,18 @@ static void mpi3mr_fwevt_bh(struct mpi3mr_ioc *mrioc,
 	}
 	case MPI3_EVENT_WAIT_FOR_DEVICES_TO_REFRESH:
 	{
-		while (mrioc->device_refresh_on)
+		timeout = MPI3MR_RESET_TIMEOUT * 2;
+		while ((mrioc->device_refresh_on || mrioc->block_on_pci_err) &&
+		    !mrioc->unrecoverable && !mrioc->pci_err_recovery) {
 			msleep(500);
+			if (!timeout--) {
+				mrioc->unrecoverable = 1;
+				break;
+			}
+		}
+
+		if (mrioc->unrecoverable || mrioc->pci_err_recovery)
+			break;
 
 		dprint_event_bh(mrioc,
 		    "scan for non responding and newly added devices after soft reset started\n");
@@ -3796,6 +3807,13 @@ int mpi3mr_issue_tm(struct mpi3mr_ioc *mrioc, u8 tm_type,
 		mutex_unlock(&drv_cmd->mutex);
 		goto out;
 	}
+	if (mrioc->block_on_pci_err) {
+		retval = -1;
+		dprint_tm(mrioc, "sending task management failed due to\n"
+				"pci error recovery in progress\n");
+		mutex_unlock(&drv_cmd->mutex);
+		goto out;
+	}
 
 	drv_cmd->state = MPI3MR_CMD_PENDING;
 	drv_cmd->is_waiting = 1;
@@ -4181,6 +4199,7 @@ static int mpi3mr_eh_bus_reset(struct scsi_cmnd *scmd)
 	struct mpi3mr_sdev_priv_data *sdev_priv_data;
 	u8 dev_type = MPI3_DEVICE_DEVFORM_VD;
 	int retval = FAILED;
+	unsigned int timeout = MPI3MR_RESET_TIMEOUT;
 
 	sdev_priv_data = scmd->device->hostdata;
 	if (sdev_priv_data && sdev_priv_data->tgt_priv_data) {
@@ -4191,12 +4210,24 @@ static int mpi3mr_eh_bus_reset(struct scsi_cmnd *scmd)
 	if (dev_type == MPI3_DEVICE_DEVFORM_VD) {
 		mpi3mr_wait_for_host_io(mrioc,
 			MPI3MR_RAID_ERRREC_RESET_TIMEOUT);
-		if (!mpi3mr_get_fw_pending_ios(mrioc))
+		if (!mpi3mr_get_fw_pending_ios(mrioc)) {
+			while (mrioc->reset_in_progress ||
+			       mrioc->prepare_for_reset ||
+			       mrioc->block_on_pci_err) {
+				ssleep(1);
+				if (!timeout--) {
+					retval = FAILED;
+					goto out;
+				}
+			}
 			retval = SUCCESS;
+			goto out;
+		}
 	}
 	if (retval == FAILED)
 		mpi3mr_print_pending_host_io(mrioc);
 
+out:
 	sdev_printk(KERN_INFO, scmd->device,
 		"Bus reset is %s for scmd(%p)\n",
 		((retval == SUCCESS) ? "SUCCESS" : "FAILED"), scmd);
@@ -4879,7 +4910,8 @@ static int mpi3mr_qcmd(struct Scsi_Host *shost,
 		goto out;
 	}
 
-	if (mrioc->reset_in_progress) {
+	if (mrioc->reset_in_progress || mrioc->prepare_for_reset
+	    || mrioc->block_on_pci_err) {
 		retval = SCSI_MLQUEUE_HOST_BUSY;
 		goto out;
 	}
@@ -5362,7 +5394,14 @@ static void mpi3mr_remove(struct pci_dev *pdev)
 	while (mrioc->reset_in_progress || mrioc->is_driver_loading)
 		ssleep(1);
 
-	if (!pci_device_is_present(mrioc->pdev)) {
+	if (mrioc->block_on_pci_err) {
+		mrioc->block_on_pci_err = false;
+		scsi_unblock_requests(shost);
+		mrioc->unrecoverable = 1;
+	}
+
+	if (!pci_device_is_present(mrioc->pdev) ||
+	    mrioc->pci_err_recovery) {
 		mrioc->unrecoverable = 1;
 		mpi3mr_flush_cmds_for_unrecovered_controller(mrioc);
 	}
diff --git a/drivers/scsi/mpi3mr/mpi3mr_transport.c b/drivers/scsi/mpi3mr/mpi3mr_transport.c
index 329cc6ec3b58..8612780f6e9e 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_transport.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_transport.c
@@ -151,6 +151,11 @@ static int mpi3mr_report_manufacture(struct mpi3mr_ioc *mrioc,
 		return -EFAULT;
 	}
 
+	if (mrioc->pci_err_recovery) {
+		ioc_err(mrioc, "%s: pci error recovery in progress!\n", __func__);
+		return -EFAULT;
+	}
+
 	data_out_sz = sizeof(struct rep_manu_request);
 	data_in_sz = sizeof(struct rep_manu_reply);
 	data_out = dma_alloc_coherent(&mrioc->pdev->dev,
@@ -790,6 +795,12 @@ static int mpi3mr_set_identify(struct mpi3mr_ioc *mrioc, u16 handle,
 		return -EFAULT;
 	}
 
+	if (mrioc->pci_err_recovery) {
+		ioc_err(mrioc, "%s: pci error recovery in progress!\n",
+		    __func__);
+		return -EFAULT;
+	}
+
 	if ((mpi3mr_cfg_get_dev_pg0(mrioc, &ioc_status, &device_pg0,
 	    sizeof(device_pg0), MPI3_DEVICE_PGAD_FORM_HANDLE, handle))) {
 		ioc_err(mrioc, "%s: device page0 read failed\n", __func__);
@@ -1007,6 +1018,9 @@ mpi3mr_alloc_hba_port(struct mpi3mr_ioc *mrioc, u16 port_id)
 	hba_port->port_id = port_id;
 	ioc_info(mrioc, "hba_port entry: %p, port: %d is added to hba_port list\n",
 	    hba_port, hba_port->port_id);
+	if (mrioc->reset_in_progress ||
+		mrioc->pci_err_recovery)
+		hba_port->flags = MPI3MR_HBA_PORT_FLAG_NEW;
 	list_add_tail(&hba_port->list, &mrioc->hba_port_table_list);
 	return hba_port;
 }
@@ -1055,7 +1069,7 @@ void mpi3mr_update_links(struct mpi3mr_ioc *mrioc,
 	struct mpi3mr_sas_node *mr_sas_node;
 	struct mpi3mr_sas_phy *mr_sas_phy;
 
-	if (mrioc->reset_in_progress)
+	if (mrioc->reset_in_progress || mrioc->pci_err_recovery)
 		return;
 
 	spin_lock_irqsave(&mrioc->sas_node_lock, flags);
@@ -1978,7 +1992,7 @@ int mpi3mr_expander_add(struct mpi3mr_ioc *mrioc, u16 handle)
 	if (!handle)
 		return -1;
 
-	if (mrioc->reset_in_progress)
+	if (mrioc->reset_in_progress || mrioc->pci_err_recovery)
 		return -1;
 
 	if ((mpi3mr_cfg_get_sas_exp_pg0(mrioc, &ioc_status, &expander_pg0,
@@ -2184,7 +2198,7 @@ void mpi3mr_expander_node_remove(struct mpi3mr_ioc *mrioc,
 	/* remove sibling ports attached to this expander */
 	list_for_each_entry_safe(mr_sas_port, next,
 	   &sas_expander->sas_port_list, port_list) {
-		if (mrioc->reset_in_progress)
+		if (mrioc->reset_in_progress || mrioc->pci_err_recovery)
 			return;
 		if (mr_sas_port->remote_identify.device_type ==
 		    SAS_END_DEVICE)
@@ -2234,7 +2248,7 @@ void mpi3mr_expander_remove(struct mpi3mr_ioc *mrioc, u64 sas_address,
 	struct mpi3mr_sas_node *sas_expander;
 	unsigned long flags;
 
-	if (mrioc->reset_in_progress)
+	if (mrioc->reset_in_progress || mrioc->pci_err_recovery)
 		return;
 
 	if (!hba_port)
@@ -2545,6 +2559,11 @@ static int mpi3mr_get_expander_phy_error_log(struct mpi3mr_ioc *mrioc,
 		return -EFAULT;
 	}
 
+	if (mrioc->pci_err_recovery) {
+		ioc_err(mrioc, "%s: pci error recovery in progress!\n", __func__);
+		return -EFAULT;
+	}
+
 	data_out_sz = sizeof(struct phy_error_log_request);
 	data_in_sz = sizeof(struct phy_error_log_reply);
 	sz = data_out_sz + data_in_sz;
@@ -2804,6 +2823,12 @@ mpi3mr_expander_phy_control(struct mpi3mr_ioc *mrioc,
 		return -EFAULT;
 	}
 
+	if (mrioc->pci_err_recovery) {
+		ioc_err(mrioc, "%s: pci error recovery in progress!\n",
+		    __func__);
+		return -EFAULT;
+	}
+
 	data_out_sz = sizeof(struct phy_control_request);
 	data_in_sz = sizeof(struct phy_control_reply);
 	sz = data_out_sz + data_in_sz;
@@ -3227,6 +3252,12 @@ mpi3mr_transport_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 		goto out;
 	}
 
+	if (mrioc->pci_err_recovery) {
+		ioc_err(mrioc, "%s: pci error recovery in progress!\n", __func__);
+		rc = -EFAULT;
+		goto out;
+	}
+
 	rc = mpi3mr_map_smp_buffer(&mrioc->pdev->dev, &job->request_payload,
 	    &dma_addr_out, &dma_len_out, &addr_out);
 	if (rc)
-- 
2.31.1


--000000000000940075061bdc7cc3
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
1J8x62/iEVbCstJaE1Nt3oXnL5yBlqX1Ihp8cZLe1weS7Wp/v5Jg2Ks13jeYOKW45xXExpqPPd1f
3meFjTf9K+rGZHb63htWaJtf0NYbE+5yIbXFv21cBxECAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZc3VtaXQuc2F4ZW5hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUTIFIrhFDaoMEbXuV9O+Y+XgS
kVwwDQYJKoZIhvcNAQELBQADggEBAFyioHqB2PHWcQ5cU8nprPRk37uSWK2x0w7W50jjc0cooz6G
G6pltJ+DvbG7XIzCU8cKHmuyAxoe1+/vhB8yJH78MVdfKDDND7zL/IqfhZedxHcHG5jVqbVH/ufu
H19y4fHxo5bLkybX3UxkN9b3bMsBZ4FFCLSCFgFfjI0BmTx6IoGyi0R89rzD0H1rURy7WTn0ijl1
nERsqENeyGfUTJLcDSURb49qpFqqWweJ7ifC64Iak8wCK2CxCe8lHfTyEgC9MuEa586NMQJDguvw
jlC7kxrgwf4sZ/9Wj/GS2HLzZPkxWCcQIrgNJm2wceHQwPBpM0ZoqL1D2tsFgOA8BvYxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwdgevXLIdo6fbCNI8w
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIA25Kaa5lI8acIf8l4EiF1MCaL42SGdU
4ecpAXTqzsu/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYy
NzEwMjA1N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQC5As1hdQA78EB9xSwrbMk/rsXFA0Me/COsZlhtl2P8ZQnH7Ti9
IyfTcghj2MVN52zjTUoUptH1hN7aTUKCaSl3VAm2VryS7MtsW5FArZmkRgQp2yj3BhBT4vjESB0t
0a6D1Y22a5DOQ/BM14aCaaqoQCOueqq3HAyIWboTzuujzOazqziXSq9Ae2l2WKtiomMyf+7mO4vD
2Odex0I12+sWaVf/EEOQgiightbkrNzZFdrAHPYAReHtz1ywqdabPJSWoM4ZwYlOiYTmtBWWVbL/
8tmC4COGZRLbIPOu6xGKw4Pb6d78XBqb5hSglzfwVQIlfYfrbpGEfA/yoXk1hGel
--000000000000940075061bdc7cc3--

