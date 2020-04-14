Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6241A86DC
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391592AbgDNRE7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391606AbgDNREv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D3CC0610D5
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i10so15238109wrv.10
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yAwC6I4Ox8TH0mxSQC8ehH0/PmJE7R7HKqfJxOiulbY=;
        b=beeH/vBaJDaUTPmtLSUnu2LsN4zO+Lw5SyI5i8qKik/VZrlOXf0vQuqnjh0AW+UqmF
         QhM89JnLEndk0rDE/PvFA6MmI9Ug0mP7npWlo7imD1kyPL4f+mVEthPWRbqRpm/kUrMH
         jjRphpoKaK5AOiTQXTTUXUADe6+6JV+YBifEN5z7Ix9C2sWsFsmZZEXplbm3t4YTTDH+
         DxSGZfOK2OQpDuohExrAN+qxSyUV9UaXSgRJ9r9QMC/Ik+ejlxiD16zDCl3vovRvxzeT
         k9iFVci01PNXmxKIvXdTQHG4jzM5nmkzHjhXp+qPvR22AWQu64MVMQ8HqrH41YZjPEla
         M7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yAwC6I4Ox8TH0mxSQC8ehH0/PmJE7R7HKqfJxOiulbY=;
        b=TJ5jQaH33jaemZnDX5sQnCEKLmryzwwJlYNY/7duzZZhs8vbekyYUlJ0hB/k0ZK5xp
         l2N40fbNm/JTIzzfP8tFe7XDNIM2Y0XG1oKc74OyM0VgXQ2BNewSSPbRFh6SvRRlwo2e
         zkrg76lMd3AzB/M3vwlDSlVngfSIyYNj5kIYWjbqg6Kou2y6nR0KUDkpKL3G2FmiTlSU
         RjEctKp57nVW1C2GrakwgmBS3AjQ6QQONaRdoLp8BZH6goPamF/72Eo/QxdtLk0SK4Uw
         HC24KQprLL9rVnA4FA1ifxxm3DK2qfnZFm0wXu2TAa0QCMKk9Nlr9lHVnYHZU5f5eZE0
         fICw==
X-Gm-Message-State: AGi0PuZEEEGFfyEbDajPOlVEnJM/HNlQSZkhEpEgHs2JjfTBWm0yhaok
        I7Oe6Nwx1RX30o/1cVEGPM8VnA==
X-Google-Smtp-Source: APiQypIRtD1FozsWi6qcdJJwoMw2+mrIE0giYunaj9iZh+1HzBq4OUk2y5sdhF7eBx2G+X9e6ZeR7g==
X-Received: by 2002:adf:fe41:: with SMTP id m1mr24407130wrs.52.1586883888888;
        Tue, 14 Apr 2020 10:04:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:48 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v5 22/25] iommu/arm-smmu-v3: Add stall support for platform devices
Date:   Tue, 14 Apr 2020 19:02:50 +0200
Message-Id: <20200414170252.714402-23-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SMMU provides a Stall model for handling page faults in platform
devices. It is similar to PCI PRI, but doesn't require devices to have
their own translation cache. Instead, faulting transactions are parked and
the OS is given a chance to fix the page tables and retry the transaction.

Enable stall for devices that support it (opt-in by firmware). When an
event corresponds to a translation error, call the IOMMU fault handler. If
the fault is recoverable, it will call us back to terminate or continue
the stall.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v4->v5: Improve comment for flush()
---
 include/linux/iommu.h       |   2 +
 drivers/iommu/arm-smmu-v3.c | 282 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/of_iommu.c    |   5 +-
 3 files changed, 277 insertions(+), 12 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4b9c25d7246d5..7dd615954e8c7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -578,6 +578,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
  * @iommu_fwnode: firmware handle for this device's IOMMU
  * @iommu_priv: IOMMU driver private data for this device
  * @num_pasid_bits: number of PASID bits supported by this device
+ * @can_stall: the device is allowed to stall
  * @num_ids: number of associated device IDs
  * @ids: IDs which this device may present to the IOMMU
  */
@@ -585,6 +586,7 @@ struct iommu_fwspec {
 	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
 	u32			num_pasid_bits;
+	bool			can_stall;
 	unsigned int		num_ids;
 	u32			ids[];
 };
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 7a4c5914a2fe2..a7becf1c5347e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -382,6 +382,13 @@
 #define CMDQ_PRI_1_GRPID		GENMASK_ULL(8, 0)
 #define CMDQ_PRI_1_RESP			GENMASK_ULL(13, 12)
 
+#define CMDQ_RESUME_0_SID		GENMASK_ULL(63, 32)
+#define CMDQ_RESUME_0_RESP_TERM		0UL
+#define CMDQ_RESUME_0_RESP_RETRY	1UL
+#define CMDQ_RESUME_0_RESP_ABORT	2UL
+#define CMDQ_RESUME_0_RESP		GENMASK_ULL(13, 12)
+#define CMDQ_RESUME_1_STAG		GENMASK_ULL(15, 0)
+
 #define CMDQ_SYNC_0_CS			GENMASK_ULL(13, 12)
 #define CMDQ_SYNC_0_CS_NONE		0
 #define CMDQ_SYNC_0_CS_IRQ		1
@@ -398,6 +405,25 @@
 
 #define EVTQ_0_ID			GENMASK_ULL(7, 0)
 
+#define EVT_ID_TRANSLATION_FAULT	0x10
+#define EVT_ID_ADDR_SIZE_FAULT		0x11
+#define EVT_ID_ACCESS_FAULT		0x12
+#define EVT_ID_PERMISSION_FAULT		0x13
+
+#define EVTQ_0_SSV			(1UL << 11)
+#define EVTQ_0_SSID			GENMASK_ULL(31, 12)
+#define EVTQ_0_SID			GENMASK_ULL(63, 32)
+#define EVTQ_1_STAG			GENMASK_ULL(15, 0)
+#define EVTQ_1_STALL			(1UL << 31)
+#define EVTQ_1_PRIV			(1UL << 33)
+#define EVTQ_1_EXEC			(1UL << 34)
+#define EVTQ_1_READ			(1UL << 35)
+#define EVTQ_1_S2			(1UL << 39)
+#define EVTQ_1_CLASS			GENMASK_ULL(41, 40)
+#define EVTQ_1_TT_READ			(1UL << 44)
+#define EVTQ_2_ADDR			GENMASK_ULL(63, 0)
+#define EVTQ_3_IPA			GENMASK_ULL(51, 12)
+
 /* PRI queue */
 #define PRIQ_ENT_SZ_SHIFT		4
 #define PRIQ_ENT_DWORDS			((1 << PRIQ_ENT_SZ_SHIFT) >> 3)
@@ -522,6 +548,13 @@ struct arm_smmu_cmdq_ent {
 			enum pri_resp		resp;
 		} pri;
 
+		#define CMDQ_OP_RESUME		0x44
+		struct {
+			u32			sid;
+			u16			stag;
+			u8			resp;
+		} resume;
+
 		#define CMDQ_OP_CMD_SYNC	0x46
 		struct {
 			u64			msiaddr;
@@ -557,6 +590,10 @@ struct arm_smmu_queue {
 
 	u32 __iomem			*prod_reg;
 	u32 __iomem			*cons_reg;
+
+	/* Event and PRI */
+	u64				batch;
+	wait_queue_head_t		wq;
 };
 
 struct arm_smmu_queue_poll {
@@ -580,6 +617,7 @@ struct arm_smmu_cmdq_batch {
 
 struct arm_smmu_evtq {
 	struct arm_smmu_queue		q;
+	struct iopf_queue		*iopf;
 	u32				max_stalls;
 };
 
@@ -717,6 +755,7 @@ struct arm_smmu_master {
 	struct arm_smmu_stream		*streams;
 	unsigned int			num_streams;
 	bool				ats_enabled;
+	bool				stall_enabled;
 	unsigned int			ssid_bits;
 };
 
@@ -734,6 +773,7 @@ struct arm_smmu_domain {
 
 	struct io_pgtable_ops		*pgtbl_ops;
 	bool				non_strict;
+	bool				stall_enabled;
 	atomic_t			nr_ats_masters;
 
 	enum arm_smmu_domain_stage	stage;
@@ -1004,6 +1044,11 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		}
 		cmd[1] |= FIELD_PREP(CMDQ_PRI_1_RESP, ent->pri.resp);
 		break;
+	case CMDQ_OP_RESUME:
+		cmd[0] |= FIELD_PREP(CMDQ_RESUME_0_SID, ent->resume.sid);
+		cmd[0] |= FIELD_PREP(CMDQ_RESUME_0_RESP, ent->resume.resp);
+		cmd[1] |= FIELD_PREP(CMDQ_RESUME_1_STAG, ent->resume.stag);
+		break;
 	case CMDQ_OP_CMD_SYNC:
 		if (ent->sync.msiaddr) {
 			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
@@ -1570,6 +1615,45 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 	return arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, true);
 }
 
+static int arm_smmu_page_response(struct device *dev,
+				  struct iommu_fault_event *unused,
+				  struct iommu_page_response *resp)
+{
+	struct arm_smmu_cmdq_ent cmd = {0};
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	int sid = master->streams[0].id;
+
+	if (master->stall_enabled) {
+		cmd.opcode		= CMDQ_OP_RESUME;
+		cmd.resume.sid		= sid;
+		cmd.resume.stag		= resp->grpid;
+		switch (resp->code) {
+		case IOMMU_PAGE_RESP_INVALID:
+		case IOMMU_PAGE_RESP_FAILURE:
+			cmd.resume.resp = CMDQ_RESUME_0_RESP_ABORT;
+			break;
+		case IOMMU_PAGE_RESP_SUCCESS:
+			cmd.resume.resp = CMDQ_RESUME_0_RESP_RETRY;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		/* TODO: insert PRI response here */
+		return -ENODEV;
+	}
+
+	arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
+	/*
+	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
+	 * RESUME consumption guarantees that the stalled transaction will be
+	 * terminated... at some point in the future. PRI_RESP is fire and
+	 * forget.
+	 */
+
+	return 0;
+}
+
 /* Context descriptor manipulation functions */
 static void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 {
@@ -1733,8 +1817,7 @@ static int __arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain,
 			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
 			CTXDESC_CD_0_V;
 
-		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
-		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
+		if (smmu_domain->stall_enabled)
 			val |= CTXDESC_CD_0_S;
 	}
 
@@ -2154,7 +2237,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			 FIELD_PREP(STRTAB_STE_1_STRW, strw));
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
-		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
+		    !master->stall_enabled)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
 		val |= (s1_cfg->cdcfg.cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
@@ -2231,7 +2314,6 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
-__maybe_unused
 static struct arm_smmu_master *
 arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 {
@@ -2258,23 +2340,123 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 }
 
 /* IRQ and event handlers */
+static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
+{
+	int ret;
+	u32 perm = 0;
+	struct arm_smmu_master *master;
+	bool ssid_valid = evt[0] & EVTQ_0_SSV;
+	u8 type = FIELD_GET(EVTQ_0_ID, evt[0]);
+	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
+	struct iommu_fault_event fault_evt = { };
+	struct iommu_fault *flt = &fault_evt.fault;
+
+	/* Stage-2 is always pinned at the moment */
+	if (evt[1] & EVTQ_1_S2)
+		return -EFAULT;
+
+	master = arm_smmu_find_master(smmu, sid);
+	if (!master)
+		return -EINVAL;
+
+	if (evt[1] & EVTQ_1_READ)
+		perm |= IOMMU_FAULT_PERM_READ;
+	else
+		perm |= IOMMU_FAULT_PERM_WRITE;
+
+	if (evt[1] & EVTQ_1_EXEC)
+		perm |= IOMMU_FAULT_PERM_EXEC;
+
+	if (evt[1] & EVTQ_1_PRIV)
+		perm |= IOMMU_FAULT_PERM_PRIV;
+
+	if (evt[1] & EVTQ_1_STALL) {
+		flt->type = IOMMU_FAULT_PAGE_REQ;
+		flt->prm = (struct iommu_fault_page_request) {
+			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
+			.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]),
+			.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
+			.perm = perm,
+			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
+		};
+
+		if (ssid_valid)
+			flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+	} else {
+		flt->type = IOMMU_FAULT_DMA_UNRECOV;
+		flt->event = (struct iommu_fault_unrecoverable) {
+			.flags = IOMMU_FAULT_UNRECOV_ADDR_VALID |
+				 IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID,
+			.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]),
+			.perm = perm,
+			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
+			.fetch_addr = FIELD_GET(EVTQ_3_IPA, evt[3]),
+		};
+
+		if (ssid_valid)
+			flt->event.flags |= IOMMU_FAULT_UNRECOV_PASID_VALID;
+
+		switch (type) {
+		case EVT_ID_TRANSLATION_FAULT:
+		case EVT_ID_ADDR_SIZE_FAULT:
+		case EVT_ID_ACCESS_FAULT:
+			flt->event.reason = IOMMU_FAULT_REASON_PTE_FETCH;
+			break;
+		case EVT_ID_PERMISSION_FAULT:
+			flt->event.reason = IOMMU_FAULT_REASON_PERMISSION;
+			break;
+		default:
+			/* TODO: report other unrecoverable faults. */
+			return -EFAULT;
+		}
+	}
+
+	ret = iommu_report_device_fault(master->dev, &fault_evt);
+	if (ret && flt->type == IOMMU_FAULT_PAGE_REQ) {
+		/* Nobody cared, abort the access */
+		struct iommu_page_response resp = {
+			.pasid		= flt->prm.pasid,
+			.grpid		= flt->prm.grpid,
+			.code		= IOMMU_PAGE_RESP_FAILURE,
+		};
+		arm_smmu_page_response(master->dev, NULL, &resp);
+	}
+
+	return ret;
+}
+
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
-	int i;
+	int i, ret;
+	int num_handled = 0;
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->evtq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
+	size_t queue_size = 1 << llq->max_n_shift;
 	u64 evt[EVTQ_ENT_DWORDS];
 
+	spin_lock(&q->wq.lock);
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
 
-			dev_info(smmu->dev, "event 0x%02x received:\n", id);
-			for (i = 0; i < ARRAY_SIZE(evt); ++i)
-				dev_info(smmu->dev, "\t0x%016llx\n",
-					 (unsigned long long)evt[i]);
+			spin_unlock(&q->wq.lock);
+			ret = arm_smmu_handle_evt(smmu, evt);
+			spin_lock(&q->wq.lock);
 
+			if (++num_handled == queue_size) {
+				q->batch++;
+				wake_up_all_locked(&q->wq);
+				num_handled = 0;
+			}
+
+			if (ret) {
+				dev_info(smmu->dev, "event 0x%02x received:\n",
+					 id);
+				for (i = 0; i < ARRAY_SIZE(evt); ++i)
+					dev_info(smmu->dev, "\t0x%016llx\n",
+						 (unsigned long long)evt[i]);
+			}
 		}
 
 		/*
@@ -2288,6 +2470,11 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	/* Sync our overflow flag, as we believe we're up to speed */
 	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
 		    Q_IDX(llq, llq->cons);
+	queue_sync_cons_out(q);
+
+	wake_up_all_locked(&q->wq);
+	spin_unlock(&q->wq.lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -2351,6 +2538,37 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+/*
+ * arm_smmu_flush_evtq - wait until all events currently in the queue have been
+ *                       consumed.
+ *
+ * Wait until there are no more event for this @pasid in the queue. Either until
+ * the queue becomes empty or, if new events are continually added the queue,
+ * until the event queue thread has handled a full batch (where one batch
+ * corresponds to the queue size). For that we take the batch number when
+ * entering flush() and wait for the event queue thread to increment it twice.
+ * Note that we don't handle overflows on q->batch. If it occurs, just wait for
+ * the queue to become empty.
+ */
+static int arm_smmu_flush_evtq(void *cookie, struct device *dev, int pasid)
+{
+	int ret;
+	u64 batch;
+	struct arm_smmu_device *smmu = cookie;
+	struct arm_smmu_queue *q = &smmu->evtq.q;
+
+	spin_lock(&q->wq.lock);
+	if (queue_sync_prod_in(q) == -EOVERFLOW)
+		dev_err(smmu->dev, "evtq overflow detected -- requests lost\n");
+
+	batch = q->batch;
+	ret = wait_event_interruptible_locked(q->wq, queue_empty(&q->llq) ||
+					      q->batch >= batch + 2);
+	spin_unlock(&q->wq.lock);
+
+	return ret;
+}
+
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
 static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
@@ -2781,6 +2999,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 
 	cfg->s1cdmax = master->ssid_bits;
 
+	smmu_domain->stall_enabled = master->stall_enabled;
+
 	ret = arm_smmu_alloc_cd_tables(smmu_domain);
 	if (ret)
 		goto out_free_asid;
@@ -3119,6 +3339,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
 		ret = -EINVAL;
 		goto out_unlock;
+	} else if (smmu_domain->stall_enabled && !master->stall_enabled) {
+		dev_err(dev, "cannot attach to stall-enabled domain\n");
+		ret = -EINVAL;
+		goto out_unlock;
 	}
 
 	master->domain = smmu_domain;
@@ -3477,6 +3701,10 @@ static int arm_smmu_add_device(struct device *dev)
 		master->ssid_bits = min_t(u8, master->ssid_bits,
 					  CTXDESC_LINEAR_CDMAX);
 
+	if ((smmu->features & ARM_SMMU_FEAT_STALLS && fwspec->can_stall) ||
+	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
+		master->stall_enabled = true;
+
 	ret = iommu_device_link(&smmu->iommu, dev);
 	if (ret)
 		goto err_disable_pasid;
@@ -3512,6 +3740,7 @@ static void arm_smmu_remove_device(struct device *dev)
 
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
+	iopf_queue_remove_device(smmu->evtq.iopf, dev);
 	WARN_ON(iommu_sva_disable(dev));
 	arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
@@ -3635,7 +3864,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 
 static bool arm_smmu_iopf_supported(struct arm_smmu_master *master)
 {
-	return false;
+	return master->stall_enabled;
 }
 
 static bool arm_smmu_dev_has_feature(struct device *dev,
@@ -3676,6 +3905,7 @@ static bool arm_smmu_dev_feature_enabled(struct device *dev,
 
 static int arm_smmu_dev_enable_sva(struct device *dev)
 {
+	int ret;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct iommu_sva_param param = {
 		.min_pasid = 1,
@@ -3683,7 +3913,21 @@ static int arm_smmu_dev_enable_sva(struct device *dev)
 	};
 
 	param.max_pasid = min(param.max_pasid, (1U << master->ssid_bits) - 1);
-	return iommu_sva_enable(dev, &param);
+
+	ret = iommu_sva_enable(dev, &param);
+	if (ret)
+		return ret;
+
+	if (master->stall_enabled) {
+		ret = iopf_queue_add_device(master->smmu->evtq.iopf, dev);
+		if (ret)
+			goto err_disable_sva;
+	}
+	return 0;
+
+err_disable_sva:
+	iommu_sva_disable(dev);
+	return ret;
 }
 
 static int arm_smmu_dev_enable_feature(struct device *dev,
@@ -3706,11 +3950,14 @@ static int arm_smmu_dev_enable_feature(struct device *dev,
 static int arm_smmu_dev_disable_feature(struct device *dev,
 					enum iommu_dev_features feat)
 {
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
 	if (!arm_smmu_dev_feature_enabled(dev, feat))
 		return -EINVAL;
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_SVA:
+		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 		return iommu_sva_disable(dev);
 	default:
 		return -EINVAL;
@@ -3742,6 +3989,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.sva_bind		= arm_smmu_sva_bind,
 	.sva_unbind		= iommu_sva_unbind_generic,
 	.sva_get_pasid		= iommu_sva_get_pasid_generic,
+	.page_response		= arm_smmu_page_response,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
@@ -3785,6 +4033,10 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	q->q_base |= FIELD_PREP(Q_BASE_LOG2SIZE, q->llq.max_n_shift);
 
 	q->llq.prod = q->llq.cons = 0;
+
+	init_waitqueue_head(&q->wq);
+	q->batch = 0;
+
 	return 0;
 }
 
@@ -3838,6 +4090,13 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+	if (smmu->features & ARM_SMMU_FEAT_STALLS) {
+		smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev),
+						   arm_smmu_flush_evtq, smmu);
+		if (!smmu->evtq.iopf)
+			return -ENOMEM;
+	}
+
 	/* priq */
 	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
 		return 0;
@@ -4818,6 +5077,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
+	iopf_queue_free(smmu->evtq.iopf);
 
 	return 0;
 }
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 20738aacac89e..dd70177509543 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -205,9 +205,12 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
 		}
 
 		fwspec = dev_iommu_fwspec_get(dev);
-		if (!err && fwspec)
+		if (!err && fwspec) {
 			of_property_read_u32(master_np, "pasid-num-bits",
 					     &fwspec->num_pasid_bits);
+			fwspec->can_stall = of_property_read_bool(master_np,
+								  "dma-can-stall");
+		}
 	}
 
 	/*
-- 
2.26.0

