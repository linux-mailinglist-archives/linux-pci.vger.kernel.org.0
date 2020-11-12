Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EBF2B05E7
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 14:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgKLNDj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 08:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgKLNDa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 08:03:30 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2110BC0617A6
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 05:03:30 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id c17so5873087wrc.11
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 05:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KzHG2PweYWkDaJQol3GXcq+4FrqBl3EkRXm7+VNwUmc=;
        b=QzsCjHvgwTaDtXJ9+Q3O62Yd7pbjZCU3265TBqqZMjaMxMwjrdRp4jHXltzEEU07rs
         8mmfQkm8fEnqYqM0E0REckDPxMoROlKoFtzVSydnxin5V/rRTpPx8c5+TuZBGtaTYEuO
         f4LcmtfroCNh/UOj+hBVBMGKXKu9b7RngKKy6U2RaRfTApWKsBcZ42osFB8fh4Pp9Nqs
         W67apIz096ig0sdMkpZ2/bsUrG70tIHfMCGQW8OLPOyP3hEhSDWYdVJKLEoDu4+aCb4V
         Ds1lnR59Y3qMAHjkDFnLi9V4r9sGgD5xjVu1aE0drSG6GBMw+oN9u15GPn+X/9k+IF7F
         km9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzHG2PweYWkDaJQol3GXcq+4FrqBl3EkRXm7+VNwUmc=;
        b=rhUDb/RcEIiz2qaxJJn/WXFS/7yMKz2uoPlRKs29qnrNjzCcvr0LAlViUZvI9Jj5sA
         lElM+shrnPsd1aTa/mPDPqH4CqT0wwPiRacyCQnmlKusUaIHZ1rDmt95i1zCXpSP8GXe
         FDqlz52WMFNt6ECWEywp3/tVezAtoDrhVIJahrnmwjGnMakAN2YC7O6UD7OYLoEUBqat
         G9glExm3S/Dfcd3dV4d1xnf0v7fCzDt713kagwZFjHjDmuXSgSIUtotd+xKquzkyTEwl
         KEvIVzAZxkl3ktgZ7gg9YRX0Nt0UWFPwgXsddZhU2sP1UX3iCXCxw3c55477nC1CPnel
         EtZw==
X-Gm-Message-State: AOAM533jASxsS+0nmSVAKIaRv6AYN4+1pACLPPihjCYKJ3XVYdpUEcEm
        HHuE4dKpCQFWTsm1yDooQfpw1A==
X-Google-Smtp-Source: ABdhPJxuUemJNG+7LLzequD96xCA6dBRHFX8NgjY+pEi0PeawvJzITH5k3FZUtnf92WjB1bi7h2w8A==
X-Received: by 2002:adf:f041:: with SMTP id t1mr12188827wro.139.1605186208754;
        Thu, 12 Nov 2020 05:03:28 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:03:28 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, baolu.lu@linux.intel.com,
        zhangfei.gao@linaro.org, shameerali.kolothum.thodi@huawei.com,
        vivek.gautam@arm.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v8 9/9] iommu/arm-smmu-v3: Add support for PRI
Date:   Thu, 12 Nov 2020 13:55:21 +0100
Message-Id: <20201112125519.3987595-10-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For PCI devices that support it, enable the PRI capability and handle
PRI Page Requests with the generic fault handler. It is enabled on
demand by iommu_sva_device_init().

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  20 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  28 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 275 +++++++++++++++---
 3 files changed, 272 insertions(+), 51 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 124f604ed677..7c2d31133148 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -230,6 +230,7 @@
 #define STRTAB_STE_1_S1COR		GENMASK_ULL(5, 4)
 #define STRTAB_STE_1_S1CSH		GENMASK_ULL(7, 6)
 
+#define STRTAB_STE_1_PPAR		(1UL << 18)
 #define STRTAB_STE_1_S1STALLD		(1UL << 27)
 
 #define STRTAB_STE_1_EATS		GENMASK_ULL(29, 28)
@@ -360,6 +361,9 @@
 #define CMDQ_PRI_0_SID			GENMASK_ULL(63, 32)
 #define CMDQ_PRI_1_GRPID		GENMASK_ULL(8, 0)
 #define CMDQ_PRI_1_RESP			GENMASK_ULL(13, 12)
+#define CMDQ_PRI_1_RESP_FAILURE		0UL
+#define CMDQ_PRI_1_RESP_INVALID		1UL
+#define CMDQ_PRI_1_RESP_SUCCESS		2UL
 
 #define CMDQ_RESUME_0_SID		GENMASK_ULL(63, 32)
 #define CMDQ_RESUME_0_RESP_TERM		0UL
@@ -427,12 +431,6 @@
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
 
-enum pri_resp {
-	PRI_RESP_DENY = 0,
-	PRI_RESP_FAIL = 1,
-	PRI_RESP_SUCC = 2,
-};
-
 struct arm_smmu_cmdq_ent {
 	/* Common fields */
 	u8				opcode;
@@ -494,7 +492,7 @@ struct arm_smmu_cmdq_ent {
 			u32			sid;
 			u32			ssid;
 			u16			grpid;
-			enum pri_resp		resp;
+			u8			resp;
 		} pri;
 
 		#define CMDQ_OP_RESUME		0x44
@@ -568,6 +566,9 @@ struct arm_smmu_evtq {
 
 struct arm_smmu_priq {
 	struct arm_smmu_queue		q;
+	struct iopf_queue		*iopf;
+	u64				batch;
+	wait_queue_head_t		wq;
 };
 
 /* High-level stream table and context descriptor structures */
@@ -703,6 +704,8 @@ struct arm_smmu_master {
 	unsigned int			num_streams;
 	bool				ats_enabled;
 	bool				stall_enabled;
+	bool				pri_supported;
+	bool				prg_resp_needs_ssid;
 	bool				sva_enabled;
 	struct list_head		bonds;
 	unsigned int			ssid_bits;
@@ -754,6 +757,9 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			    unsigned long iova, size_t size);
+int arm_smmu_enable_pri(struct arm_smmu_master *master);
+void arm_smmu_disable_pri(struct arm_smmu_master *master);
+int arm_smmu_flush_priq(struct arm_smmu_device *smmu);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 64e2082ef9ed..1fdfd40f70fd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -370,6 +370,19 @@ arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 void arm_smmu_sva_unbind(struct iommu_sva *handle)
 {
 	struct arm_smmu_bond *bond = sva_to_bond(handle);
+	struct arm_smmu_master *master = dev_iommu_priv_get(handle->dev);
+
+	/*
+	 * For stall, the event queue does not need to be flushed since the
+	 * device driver ensured all transaction are complete. For PRI however,
+	 * although the device driver has stopped all DMA for this PASID, it may
+	 * have left Page Requests in flight (if using the Stop Marker Message
+	 * to stop PASID). Complete them.
+	 */
+	if (master->pri_supported) {
+		arm_smmu_flush_priq(master->smmu);
+		iopf_queue_flush_dev(handle->dev);
+	}
 
 	mutex_lock(&sva_lock);
 	if (refcount_dec_and_test(&bond->refs)) {
@@ -435,7 +448,7 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 
 static bool arm_smmu_iopf_supported(struct arm_smmu_master *master)
 {
-	return master->stall_enabled;
+	return master->stall_enabled || master->pri_supported;
 }
 
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master)
@@ -466,6 +479,15 @@ int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
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
@@ -479,6 +501,8 @@ int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
 	return 0;
 
 err_disable_iopf:
+	arm_smmu_disable_pri(master);
+	iopf_queue_remove_device(master->smmu->priq.iopf, dev);
 	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 	return ret;
 }
@@ -497,6 +521,8 @@ int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
 	mutex_unlock(&sva_lock);
 
 	iommu_unregister_device_fault_handler(dev);
+	arm_smmu_disable_pri(master);
+	iopf_queue_remove_device(master->smmu->priq.iopf, dev);
 	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 
 	return 0;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d412d063d3b6..b4d58f3a77bc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -315,14 +315,6 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
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
@@ -894,11 +886,12 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 }
 
 static int arm_smmu_page_response(struct device *dev,
-				  struct iommu_fault_event *unused,
+				  struct iommu_fault_event *evt,
 				  struct iommu_page_response *resp)
 {
 	struct arm_smmu_cmdq_ent cmd = {0};
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	bool pasid_valid = resp->flags & IOMMU_PAGE_RESP_PASID_VALID;
 	int sid = master->streams[0].id;
 
 	if (master->stall_enabled) {
@@ -916,6 +909,28 @@ static int arm_smmu_page_response(struct device *dev,
 		default:
 			return -EINVAL;
 		}
+	} else if (master->pri_supported) {
+		bool needs_pasid = (evt->fault.prm.flags &
+				    IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID);
+
+		cmd.opcode		= CMDQ_OP_PRI_RESP;
+		cmd.substream_valid	= needs_pasid && pasid_valid;
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
 		return -ENODEV;
 	}
@@ -1336,6 +1351,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			 FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
 			 FIELD_PREP(STRTAB_STE_1_STRW, strw));
 
+		if (master->prg_resp_needs_ssid)
+			dst[1] |= cpu_to_le64(STRTAB_STE_1_PPAR);
+
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
 		    !master->stall_enabled)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
@@ -1566,64 +1584,155 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
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
+	bool pasid_valid, last;
+	struct arm_smmu_master *master;
+	u32 sid = FIELD_PREP(PRIQ_0_SID, evt[0]);
+	struct iommu_fault_event fault_evt = {
+		.fault.type = IOMMU_FAULT_PAGE_REQ,
+		.fault.prm = {
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
+	if (pasid_valid) {
+		pr->flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+		pr->pasid = FIELD_GET(PRIQ_0_SSID, evt[0]);
+	}
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
+	if (pasid_valid && master->prg_resp_needs_ssid)
+		pr->flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
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
-	struct arm_smmu_queue *q = &smmu->priq.q;
+	struct arm_smmu_priq *priq = &smmu->priq;
+	struct arm_smmu_queue *q = &priq->q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
+	size_t queue_size = 1 << llq->max_n_shift;
 	u64 evt[PRIQ_ENT_DWORDS];
 
+	spin_lock(&priq->wq.lock);
 	do {
-		while (!queue_remove_raw(q, evt))
+		while (!queue_remove_raw(q, evt)) {
+			spin_unlock(&priq->wq.lock);
 			arm_smmu_handle_ppr(smmu, evt);
+			spin_lock(&priq->wq.lock);
+			if (++num_handled == queue_size) {
+				priq->batch++;
+				wake_up_all_locked(&priq->wq);
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
+	wake_up_all_locked(&priq->wq);
+	spin_unlock(&priq->wq.lock);
+
+	/*
+	 * On overflow, the SMMU might have discarded the last PPR in a group.
+	 * There is no way to know more about it, so we have to discard all
+	 * partial faults already queued.
+	 */
+	if (overflow)
+		iopf_queue_discard_partial(priq->iopf);
+
 	return IRQ_HANDLED;
 }
 
+/*
+ * arm_smmu_flush_priq - wait until all events currently in the queue have been
+ *                       consumed.
+ *
+ * When unbinding a PASID, ensure there aren't any pending page requests for
+ * that PASID in the queue.
+ *
+ * Wait either that the queue becomes empty or, if new events are continually
+ * added the queue, that the event queue thread has handled a full batch (where
+ * one batch corresponds to the queue size). For that we take the batch number
+ * when entering flush() and wait for the event queue thread to increment it
+ * twice. Note that we don't handle overflows on q->batch. If it occurs, just
+ * wait for the queue to become empty.
+ */
+int arm_smmu_flush_priq(struct arm_smmu_device *smmu)
+{
+	int ret;
+	u64 batch;
+	bool overflow = false;
+	struct arm_smmu_priq *priq = &smmu->priq;
+	struct arm_smmu_queue *q = &priq->q;
+
+	spin_lock(&priq->wq.lock);
+	if (queue_sync_prod_in(q) == -EOVERFLOW) {
+		dev_err(smmu->dev, "priq overflow detected -- requests lost\n");
+		overflow = true;
+	}
+
+	batch = priq->batch;
+	ret = wait_event_interruptible_locked(priq->wq, queue_empty(&q->llq) ||
+					      priq->batch >= batch + 2);
+	spin_unlock(&priq->wq.lock);
+
+	if (overflow)
+		iopf_queue_discard_partial(priq->iopf);
+	return ret;
+}
+
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu);
 
 static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
@@ -2336,6 +2445,73 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 	pci_disable_pasid(pdev);
 }
 
+static int arm_smmu_init_pri(struct arm_smmu_master *master)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(master->dev))
+		return -EINVAL;
+
+	if (!(master->smmu->features & ARM_SMMU_FEAT_PRI))
+		return 0;
+
+	pdev = to_pci_dev(master->dev);
+	if (!pci_pri_supported(pdev))
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
+int arm_smmu_enable_pri(struct arm_smmu_master *master)
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
+void arm_smmu_disable_pri(struct arm_smmu_master *master)
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
@@ -2648,6 +2824,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
+	arm_smmu_init_pri(master);
+
 	return &smmu->iommu;
 
 err_free_master:
@@ -2666,6 +2844,7 @@ static void arm_smmu_release_device(struct device *dev)
 
 	master = dev_iommu_priv_get(dev);
 	WARN_ON(arm_smmu_master_sva_enabled(master));
+	iopf_queue_remove_device(master->smmu->priq.iopf, dev);
 	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 	arm_smmu_detach_dev(master);
 	arm_smmu_disable_pasid(master);
@@ -2981,6 +3160,15 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
 		return 0;
 
+	if (sva) {
+		smmu->priq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
+		if (!smmu->priq.iopf)
+			return -ENOMEM;
+	}
+
+	init_waitqueue_head(&smmu->priq.wq);
+	smmu->priq.batch = 0;
+
 	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, ARM_SMMU_PRIQ_PROD,
 				       ARM_SMMU_PRIQ_CONS, PRIQ_ENT_DWORDS,
 				       "priq");
@@ -3944,6 +4132,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
 	iopf_queue_free(smmu->evtq.iopf);
+	iopf_queue_free(smmu->priq.iopf);
 
 	return 0;
 }
-- 
2.29.1

