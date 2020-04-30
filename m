Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A106B1BFED7
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 16:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgD3Okv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 10:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727953AbgD3Okv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 10:40:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01034C035494
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x17so7232594wrt.5
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iLRyY0a8elTKqVn+6zYBFs4gHEImTKmYEjI2FHLc1YE=;
        b=PvDc74TQFaUzR6CqAMw2TcNK3rydOycm3XcGqCaP4iHuIcMLn0YZnHkWdk8ZYUra9h
         NqsNfG+lQ0ukSKJ5B+KqPTCRZmAZQ9n+MENwGTYmcEac7FL5EZthbOBR/lJ5r9h5wsI9
         /A8vryBwSopwjwm0n7DFT6S2/8KW9UZdfjBa29TAqqBcqwtlTrVob0F8JXfcREwMeppc
         2b01De7iGD6XCZZBs7rc2XM52NoI1kN3HZc8IDjAYCRhEz0mnZhqxs2E9s8z7GTV9hhh
         7zMf2w+w8oYtyrBWG/f+VdC+nTb8n6HlCLJv9ivkJr6AsRTV1hinQbqaEKLRuNc4+oJe
         qGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iLRyY0a8elTKqVn+6zYBFs4gHEImTKmYEjI2FHLc1YE=;
        b=lrOgkHqKyLiX775Z4Kqmx283Y6Qkqc9DjKKbQZveA73CwlmEp3IEA4czcmeqrfx9xO
         Y18ZcUuky+UvjcfnReKLqVioC9h+FW0bIvaacvMHm5LkhTSGC4jISVDrioRHOYtRhoy8
         L+Q9CKmc6sN2mwTjbpaTApL1En/GltWsVLagEvs9ZCTgBB/cWbeQ47yPyHdZ2j2QtSxo
         yWOBLne9pOn2VqXLTo/kMlZePNTKmx6feeprpxl+iSvBzHLg+g/EaGQFj3L4oMdIcME5
         4xjO2V53Ve7KXuvNQ8C3crDPGriIwo0BaJRW9c6bDl0RnD2zNTYpBr9DRF1NSv6/KAvR
         b62A==
X-Gm-Message-State: AGi0PubuYOOay3IvdLBkEG/ThZNVd2iegbNx1m8MLSBjroTijGk+QosI
        6nCPkc8QP54hJXeqdBpCGj36HA==
X-Google-Smtp-Source: APiQypIgQoouxMAo2BZg/LNij6ECksmu73xlmMwCHMEoVb+TEqakFhkKK/RrErzqLKzbyaP1jZNvNQ==
X-Received: by 2002:a05:6000:12c7:: with SMTP id l7mr4376505wrx.239.1588257648459;
        Thu, 30 Apr 2020 07:40:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:40:48 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v6 25/25] iommu/arm-smmu-v3: Add support for PRI
Date:   Thu, 30 Apr 2020 16:34:24 +0200
Message-Id: <20200430143424.2787566-26-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For PCI devices that support it, enable the PRI capability and handle PRI
Page Requests with the generic fault handler. It is enabled on demand by
iommu_sva_device_init().

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 286 +++++++++++++++++++++++++++++-------
 1 file changed, 236 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index eb32a7cb5e920..306c58ae90900 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -252,6 +252,7 @@
 #define STRTAB_STE_1_S1COR		GENMASK_ULL(5, 4)
 #define STRTAB_STE_1_S1CSH		GENMASK_ULL(7, 6)
 
+#define STRTAB_STE_1_PPAR		(1UL << 18)
 #define STRTAB_STE_1_S1STALLD		(1UL << 27)
 
 #define STRTAB_STE_1_EATS		GENMASK_ULL(29, 28)
@@ -382,6 +383,9 @@
 #define CMDQ_PRI_0_SID			GENMASK_ULL(63, 32)
 #define CMDQ_PRI_1_GRPID		GENMASK_ULL(8, 0)
 #define CMDQ_PRI_1_RESP			GENMASK_ULL(13, 12)
+#define CMDQ_PRI_1_RESP_FAILURE		0UL
+#define CMDQ_PRI_1_RESP_INVALID		1UL
+#define CMDQ_PRI_1_RESP_SUCCESS		2UL
 
 #define CMDQ_RESUME_0_SID		GENMASK_ULL(63, 32)
 #define CMDQ_RESUME_0_RESP_TERM		0UL
@@ -454,12 +458,6 @@ module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
 
-enum pri_resp {
-	PRI_RESP_DENY = 0,
-	PRI_RESP_FAIL = 1,
-	PRI_RESP_SUCC = 2,
-};
-
 enum arm_smmu_msi_index {
 	EVTQ_MSI_INDEX,
 	GERROR_MSI_INDEX,
@@ -546,7 +544,7 @@ struct arm_smmu_cmdq_ent {
 			u32			sid;
 			u32			ssid;
 			u16			grpid;
-			enum pri_resp		resp;
+			u8			resp;
 		} pri;
 
 		#define CMDQ_OP_RESUME		0x44
@@ -624,6 +622,7 @@ struct arm_smmu_evtq {
 
 struct arm_smmu_priq {
 	struct arm_smmu_queue		q;
+	struct iopf_queue		*iopf;
 };
 
 /* High-level stream table and context descriptor structures */
@@ -757,6 +756,8 @@ struct arm_smmu_master {
 	unsigned int			num_streams;
 	bool				ats_enabled;
 	bool				stall_enabled;
+	bool				pri_supported;
+	bool				prg_resp_needs_ssid;
 	bool				sva_enabled;
 	struct list_head		bonds;
 	unsigned int			ssid_bits;
@@ -1061,14 +1062,6 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[0] |= FIELD_PREP(CMDQ_PRI_0_SSID, ent->pri.ssid);
 		cmd[0] |= FIELD_PREP(CMDQ_PRI_0_SID, ent->pri.sid);
 		cmd[1] |= FIELD_PREP(CMDQ_PRI_1_GRPID, ent->pri.grpid);
-		switch (ent->pri.resp) {
-		case PRI_RESP_DENY:
-		case PRI_RESP_FAIL:
-		case PRI_RESP_SUCC:
-			break;
-		default:
-			return -EINVAL;
-		}
 		cmd[1] |= FIELD_PREP(CMDQ_PRI_1_RESP, ent->pri.resp);
 		break;
 	case CMDQ_OP_RESUME:
@@ -1648,6 +1641,7 @@ static int arm_smmu_page_response(struct device *dev,
 {
 	struct arm_smmu_cmdq_ent cmd = {0};
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	bool pasid_valid = resp->flags & IOMMU_PAGE_RESP_PASID_VALID;
 	int sid = master->streams[0].id;
 
 	if (master->stall_enabled) {
@@ -1665,8 +1659,27 @@ static int arm_smmu_page_response(struct device *dev,
 		default:
 			return -EINVAL;
 		}
+	} else if (master->pri_supported) {
+		cmd.opcode		= CMDQ_OP_PRI_RESP;
+		cmd.substream_valid	= pasid_valid &&
+					  master->prg_resp_needs_ssid;
+		cmd.pri.sid		= sid;
+		cmd.pri.ssid		= resp->pasid;
+		cmd.pri.grpid		= resp->grpid;
+		switch (resp->code) {
+		case IOMMU_PAGE_RESP_FAILURE:
+			cmd.pri.resp = CMDQ_PRI_1_RESP_FAILURE;
+			break;
+		case IOMMU_PAGE_RESP_INVALID:
+			cmd.pri.resp = CMDQ_PRI_1_RESP_INVALID;
+			break;
+		case IOMMU_PAGE_RESP_SUCCESS:
+			cmd.pri.resp = CMDQ_PRI_1_RESP_SUCCESS;
+			break;
+		default:
+			return -EINVAL;
+		}
 	} else {
-		/* TODO: insert PRI response here */
 		return -ENODEV;
 	}
 
@@ -2257,6 +2270,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			 FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
 			 FIELD_PREP(STRTAB_STE_1_STRW, strw));
 
+		if (master->prg_resp_needs_ssid)
+			dst[1] |= STRTAB_STE_1_PPAR;
+
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
 		    !master->stall_enabled)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
@@ -2501,61 +2517,110 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 static void arm_smmu_handle_ppr(struct arm_smmu_device *smmu, u64 *evt)
 {
-	u32 sid, ssid;
-	u16 grpid;
-	bool ssv, last;
-
-	sid = FIELD_GET(PRIQ_0_SID, evt[0]);
-	ssv = FIELD_GET(PRIQ_0_SSID_V, evt[0]);
-	ssid = ssv ? FIELD_GET(PRIQ_0_SSID, evt[0]) : 0;
-	last = FIELD_GET(PRIQ_0_PRG_LAST, evt[0]);
-	grpid = FIELD_GET(PRIQ_1_PRG_IDX, evt[1]);
-
-	dev_info(smmu->dev, "unexpected PRI request received:\n");
-	dev_info(smmu->dev,
-		 "\tsid 0x%08x.0x%05x: [%u%s] %sprivileged %s%s%s access at iova 0x%016llx\n",
-		 sid, ssid, grpid, last ? "L" : "",
-		 evt[0] & PRIQ_0_PERM_PRIV ? "" : "un",
-		 evt[0] & PRIQ_0_PERM_READ ? "R" : "",
-		 evt[0] & PRIQ_0_PERM_WRITE ? "W" : "",
-		 evt[0] & PRIQ_0_PERM_EXEC ? "X" : "",
-		 evt[1] & PRIQ_1_ADDR_MASK);
-
-	if (last) {
-		struct arm_smmu_cmdq_ent cmd = {
-			.opcode			= CMDQ_OP_PRI_RESP,
-			.substream_valid	= ssv,
-			.pri			= {
-				.sid	= sid,
-				.ssid	= ssid,
-				.grpid	= grpid,
-				.resp	= PRI_RESP_DENY,
-			},
+	u32 sid = FIELD_PREP(PRIQ_0_SID, evt[0]);
+
+	bool pasid_valid, last;
+	struct arm_smmu_master *master;
+	struct iommu_fault_event fault_evt = {
+		.fault.type = IOMMU_FAULT_PAGE_REQ,
+		.fault.prm = {
+			.pasid		= FIELD_GET(PRIQ_0_SSID, evt[0]),
+			.grpid		= FIELD_GET(PRIQ_1_PRG_IDX, evt[1]),
+			.addr		= evt[1] & PRIQ_1_ADDR_MASK,
+		},
+	};
+	struct iommu_fault_page_request *pr = &fault_evt.fault.prm;
+
+	pasid_valid = evt[0] & PRIQ_0_SSID_V;
+	last = evt[0] & PRIQ_0_PRG_LAST;
+
+	/* Discard Stop PASID marker, it isn't used */
+	if (!(evt[0] & (PRIQ_0_PERM_READ | PRIQ_0_PERM_WRITE)) && last)
+		return;
+
+	if (last)
+		pr->flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+	if (pasid_valid)
+		pr->flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+	if (evt[0] & PRIQ_0_PERM_READ)
+		pr->perm |= IOMMU_FAULT_PERM_READ;
+	if (evt[0] & PRIQ_0_PERM_WRITE)
+		pr->perm |= IOMMU_FAULT_PERM_WRITE;
+	if (evt[0] & PRIQ_0_PERM_EXEC)
+		pr->perm |= IOMMU_FAULT_PERM_EXEC;
+	if (evt[0] & PRIQ_0_PERM_PRIV)
+		pr->perm |= IOMMU_FAULT_PERM_PRIV;
+
+	master = arm_smmu_find_master(smmu, sid);
+	if (WARN_ON(!master))
+		return;
+
+	if (iommu_report_device_fault(master->dev, &fault_evt)) {
+		/*
+		 * No handler registered, so subsequent faults won't produce
+		 * better results. Try to disable PRI.
+		 */
+		struct iommu_page_response resp = {
+			.flags		= pasid_valid ?
+					  IOMMU_PAGE_RESP_PASID_VALID : 0,
+			.pasid		= pr->pasid,
+			.grpid		= pr->grpid,
+			.code		= IOMMU_PAGE_RESP_FAILURE,
 		};
 
-		arm_smmu_cmdq_issue_cmd(smmu, &cmd);
+		dev_warn(master->dev,
+			 "PPR 0x%x:0x%llx 0x%x: nobody cared, disabling PRI\n",
+			 pasid_valid ? pr->pasid : 0, pr->addr, pr->perm);
+		if (last)
+			arm_smmu_page_response(master->dev, NULL, &resp);
 	}
 }
 
 static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 {
+	int num_handled = 0;
+	bool overflow = false;
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->priq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
+	size_t queue_size = 1 << llq->max_n_shift;
 	u64 evt[PRIQ_ENT_DWORDS];
 
+	spin_lock(&q->wq.lock);
 	do {
-		while (!queue_remove_raw(q, evt))
+		while (!queue_remove_raw(q, evt)) {
+			spin_unlock(&q->wq.lock);
 			arm_smmu_handle_ppr(smmu, evt);
+			spin_lock(&q->wq.lock);
+			if (++num_handled == queue_size) {
+				q->batch++;
+				wake_up_all_locked(&q->wq);
+				num_handled = 0;
+			}
+		}
 
-		if (queue_sync_prod_in(q) == -EOVERFLOW)
+		if (queue_sync_prod_in(q) == -EOVERFLOW) {
 			dev_err(smmu->dev, "PRIQ overflow detected -- requests lost\n");
+			overflow = true;
+		}
 	} while (!queue_empty(llq));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
 		      Q_IDX(llq, llq->cons);
 	queue_sync_cons_out(q);
+
+	wake_up_all_locked(&q->wq);
+	spin_unlock(&q->wq.lock);
+
+	/*
+	 * On overflow, the SMMU might have discarded the last PPR in a group.
+	 * There is no way to know more about it, so we have to discard all
+	 * partial faults already queued.
+	 */
+	if (overflow)
+		iopf_queue_discard_partial(smmu->priq.iopf);
+
 	return IRQ_HANDLED;
 }
 
@@ -2589,6 +2654,35 @@ static int arm_smmu_flush_evtq(struct arm_smmu_device *smmu)
 	return ret;
 }
 
+/*
+ * arm_smmu_flush_priq - wait until all requests currently in the queue have
+ *                       been consumed.
+ *
+ * See arm_smmu_flush_evtq().
+ */
+static int arm_smmu_flush_priq(struct arm_smmu_device *smmu)
+{
+	int ret;
+	u64 batch;
+	bool overflow = false;
+	struct arm_smmu_queue *q = &smmu->priq.q;
+
+	spin_lock(&q->wq.lock);
+	if (queue_sync_prod_in(q) == -EOVERFLOW) {
+		dev_err(smmu->dev, "priq overflow detected -- requests lost\n");
+		overflow = true;
+	}
+
+	batch = q->batch;
+	ret = wait_event_interruptible_locked(q->wq, queue_empty(&q->llq) ||
+					      q->batch >= batch + 2);
+	spin_unlock(&q->wq.lock);
+
+	if (overflow)
+		iopf_queue_discard_partial(smmu->priq.iopf);
+	return ret;
+}
+
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
 static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
@@ -3293,6 +3387,75 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 	pci_disable_pasid(pdev);
 }
 
+static int arm_smmu_init_pri(struct arm_smmu_master *master)
+{
+	int pos;
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return -EINVAL;
+
+	if (!(master->smmu->features & ARM_SMMU_FEAT_PRI))
+		return 0;
+
+	pdev = to_pci_dev(master->dev);
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI);
+	if (!pos)
+		return 0;
+
+	/* If the device supports PASID and PRI, set STE.PPAR */
+	if (master->ssid_bits)
+		master->prg_resp_needs_ssid = pci_prg_resp_pasid_required(pdev);
+
+	master->pri_supported = true;
+	return 0;
+}
+
+static int arm_smmu_enable_pri(struct arm_smmu_master *master)
+{
+	int ret;
+	struct pci_dev *pdev;
+	/*
+	 * TODO: find a good inflight PPR number. According to the SMMU spec we
+	 * should divide the PRI queue by the number of PRI-capable devices, but
+	 * it's impossible to know about future (probed late or hotplugged)
+	 * devices. So we might miss some PPRs due to queue overflow.
+	 */
+	size_t max_inflight_pprs = 16;
+
+	if (!master->pri_supported || !master->ats_enabled)
+		return -ENODEV;
+
+	pdev = to_pci_dev(master->dev);
+
+	ret = pci_reset_pri(pdev);
+	if (ret)
+		return ret;
+
+	ret = pci_enable_pri(pdev, max_inflight_pprs);
+	if (ret) {
+		dev_err(master->dev, "cannot enable PRI: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void arm_smmu_disable_pri(struct arm_smmu_master *master)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return;
+
+	pdev = to_pci_dev(master->dev);
+
+	if (!pdev->pri_enabled)
+		return;
+
+	pci_disable_pri(pdev);
+}
+
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
 	unsigned long flags;
@@ -3661,6 +3824,8 @@ static void arm_smmu_sva_unbind(struct iommu_sva *handle)
 
 	if (master->stall_enabled)
 		arm_smmu_flush_evtq(master->smmu);
+	else if (master->pri_supported)
+		arm_smmu_flush_priq(master->smmu);
 	iopf_queue_flush_dev(handle->dev, bond->mm->pasid);
 
 	mutex_lock(&arm_smmu_sva_lock);
@@ -3839,6 +4004,8 @@ static int arm_smmu_add_device(struct device *dev)
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
+	arm_smmu_init_pri(master);
+
 	ret = iommu_device_link(&smmu->iommu, dev);
 	if (ret)
 		goto err_disable_pasid;
@@ -3874,6 +4041,7 @@ static void arm_smmu_remove_device(struct device *dev)
 
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
+	iopf_queue_remove_device(smmu->priq.iopf, dev);
 	iopf_queue_remove_device(smmu->evtq.iopf, dev);
 	WARN_ON(master->sva_enabled);
 	arm_smmu_detach_dev(master);
@@ -3998,7 +4166,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 
 static bool arm_smmu_iopf_supported(struct arm_smmu_master *master)
 {
-	return master->stall_enabled;
+	return master->stall_enabled || master->pri_supported;
 }
 
 static bool arm_smmu_dev_has_feature(struct device *dev,
@@ -4050,6 +4218,15 @@ static int arm_smmu_dev_enable_sva(struct device *dev)
 		ret = iopf_queue_add_device(master->smmu->evtq.iopf, dev);
 		if (ret)
 			return ret;
+	} else if (master->pri_supported) {
+		ret = iopf_queue_add_device(master->smmu->priq.iopf, dev);
+		if (ret)
+			return ret;
+
+		if (arm_smmu_enable_pri(master)) {
+			iopf_queue_remove_device(master->smmu->priq.iopf, dev);
+			return ret;
+		}
 	}
 
 	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
@@ -4063,6 +4240,8 @@ static int arm_smmu_dev_enable_sva(struct device *dev)
 	return 0;
 
 err_disable_iopf:
+	arm_smmu_disable_pri(master);
+	iopf_queue_remove_device(master->smmu->priq.iopf, dev);
 	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 	return ret;
 }
@@ -4081,6 +4260,8 @@ static int arm_smmu_dev_disable_sva(struct device *dev)
 	mutex_unlock(&arm_smmu_sva_lock);
 
 	iommu_unregister_device_fault_handler(dev);
+	arm_smmu_disable_pri(master);
+	iopf_queue_remove_device(master->smmu->priq.iopf, dev);
 	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 
 	/*
@@ -4259,6 +4440,10 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
 		return 0;
 
+	smmu->priq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
+	if (!smmu->priq.iopf)
+		return -ENOMEM;
+
 	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
 				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS,
 				       "priq");
@@ -5236,6 +5421,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
 	iopf_queue_free(smmu->evtq.iopf);
+	iopf_queue_free(smmu->priq.iopf);
 
 	return 0;
 }
-- 
2.26.2

