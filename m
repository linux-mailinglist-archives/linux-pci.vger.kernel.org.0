Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7661A2B05DC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 14:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgKLNDb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 08:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbgKLND0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 08:03:26 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BEBC0617A7
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 05:03:24 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so5190017wmd.4
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 05:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cfEAlXk9Q/1m3LFYgSiXuEmltFiYPYDgoNOZyZUs8uU=;
        b=xRmdctiu68lUscLl4F5kD3aAMn/mNPne77+RMTMrwtYwTU5hY0lUgKs+DCAsBfckH5
         h+jbd1Q2MJvWNTpvmGwglKXdTsy5ETmzHwulfMVXUHZR0vh+1V+D1cl4xXAmhC5bUuNf
         3PnrpXxoAnAKR9uNbj7eH9MVZPZfXWyiF8Yr5Bj4Bmo8BlNgNM+jqKKxSv7jlVII/dYx
         8Mm04Zag62Qd34vkI7TIxiCV4QukQy4csUJKTzUp8kGquqoLEma5QVzgRwCJl1N6s6sG
         1en0i9zujF5wJHHHYWMHSAEO7BWE5l8f4u7J8uurlWNynBzacQk4+KKS/ILL/RZZU0hZ
         /qJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cfEAlXk9Q/1m3LFYgSiXuEmltFiYPYDgoNOZyZUs8uU=;
        b=Vl5+VAY2BRaKj8Yzle9bvgxPvHrrMBYEvtiefw5BUraOggVBONXQ+d3Lbv9JuAU0ub
         H+6jx9vSthDOnZ+x9xh6cAf+ZEZo/pv3UqR+mV13fI/NhCk4vRwoySTT96GlvJAshAJw
         yf2rL+EvjTLvkyCinBlJWQ+G4vDF2i5gk8b3fYDnMslJgkuXR4DK9H8AxmW5zTbj/ZWT
         5HC8GZZGI3ThdmRaKJSxZ9nEjm1Ikr9sPrZKIzdEn8rSZjTx9Uy1rUQ+EbX9UKMMXL6b
         NIWz54Zkw3qkXYAY9V2pF1JfDqgqw3r2cgeYaDc684g97HLqtP9XRAlhaJywrqX+RBgF
         nJsQ==
X-Gm-Message-State: AOAM530Vlo4Q2HApbZu+1NFqA0J98eToK3l7KdMvAp28Oye2u0Q230h2
        dB1ehLIponzpG/4EO4jrLf0wOA==
X-Google-Smtp-Source: ABdhPJyCTkmAmTs10iqu7CA7KPn82ozQDLsDMrmgaCq2Gq7UZiSspRy9iSQJIHf8wcojJHdfB8ysAQ==
X-Received: by 2002:a1c:ddc4:: with SMTP id u187mr9985624wmg.55.1605186203154;
        Thu, 12 Nov 2020 05:03:23 -0800 (PST)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m22sm6877508wrb.97.2020.11.12.05.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:03:22 -0800 (PST)
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
Subject: [PATCH v8 6/9] iommu/arm-smmu-v3: Add stall support for platform devices
Date:   Thu, 12 Nov 2020 13:55:18 +0100
Message-Id: <20201112125519.3987595-7-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201112125519.3987595-1-jean-philippe@linaro.org>
References: <20201112125519.3987595-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SMMU provides a Stall model for handling page faults in platform
devices. It is similar to PCIe PRI, but doesn't require devices to have
their own translation cache. Instead, faulting transactions are parked
and the OS is given a chance to fix the page tables and retry the
transaction.

Enable stall for devices that support it (opt-in by firmware). When an
event corresponds to a translation error, call the IOMMU fault handler.
If the fault is recoverable, it will call us back to terminate or
continue the stall.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v8:
* Extract firwmare setting into separate patch
* Don't drain event queue on unbind()
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  36 ++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  26 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 173 +++++++++++++++++-
 3 files changed, 224 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 7bd98fdce5c3..124f604ed677 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -361,6 +361,13 @@
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
@@ -377,6 +384,25 @@
 
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
@@ -471,6 +497,13 @@ struct arm_smmu_cmdq_ent {
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
@@ -529,6 +562,7 @@ struct arm_smmu_cmdq_batch {
 
 struct arm_smmu_evtq {
 	struct arm_smmu_queue		q;
+	struct iopf_queue		*iopf;
 	u32				max_stalls;
 };
 
@@ -668,6 +702,7 @@ struct arm_smmu_master {
 	struct arm_smmu_stream		*streams;
 	unsigned int			num_streams;
 	bool				ats_enabled;
+	bool				stall_enabled;
 	bool				sva_enabled;
 	struct list_head		bonds;
 	unsigned int			ssid_bits;
@@ -687,6 +722,7 @@ struct arm_smmu_domain {
 
 	struct io_pgtable_ops		*pgtbl_ops;
 	bool				non_strict;
+	bool				stall_enabled;
 	atomic_t			nr_ats_masters;
 
 	enum arm_smmu_domain_stage	stage;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index f734797ea07a..64e2082ef9ed 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -435,7 +435,7 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 
 static bool arm_smmu_iopf_supported(struct arm_smmu_master *master)
 {
-	return false;
+	return master->stall_enabled;
 }
 
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master)
@@ -459,24 +459,46 @@ bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master)
 
 int arm_smmu_master_enable_sva(struct arm_smmu_master *master)
 {
+	int ret;
+	struct device *dev = master->dev;
+
+	if (master->stall_enabled) {
+		ret = iopf_queue_add_device(master->smmu->evtq.iopf, dev);
+		if (ret)
+			return ret;
+	}
+
+	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
+	if (ret)
+		goto err_disable_iopf;
+
 	mutex_lock(&sva_lock);
 	master->sva_enabled = true;
 	mutex_unlock(&sva_lock);
 
 	return 0;
+
+err_disable_iopf:
+	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
+	return ret;
 }
 
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master)
 {
+	struct device *dev = master->dev;
+
 	mutex_lock(&sva_lock);
 	if (!list_empty(&master->bonds)) {
-		dev_err(master->dev, "cannot disable SVA, device is bound\n");
+		dev_err(dev, "cannot disable SVA, device is bound\n");
 		mutex_unlock(&sva_lock);
 		return -EBUSY;
 	}
 	master->sva_enabled = false;
 	mutex_unlock(&sva_lock);
 
+	iommu_unregister_device_fault_handler(dev);
+	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d87c87136d63..d412d063d3b6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -32,6 +32,7 @@
 #include <linux/amba/bus.h>
 
 #include "arm-smmu-v3.h"
+#include "../../iommu-sva-lib.h"
 
 static bool disable_bypass = 1;
 module_param(disable_bypass, bool, 0444);
@@ -324,6 +325,11 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
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
@@ -887,6 +893,44 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
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
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 {
@@ -1049,8 +1093,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
 			CTXDESC_CD_0_V;
 
-		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
-		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
+		if (smmu_domain->stall_enabled)
 			val |= CTXDESC_CD_0_S;
 	}
 
@@ -1294,7 +1337,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 			 FIELD_PREP(STRTAB_STE_1_STRW, strw));
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
-		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
+		    !master->stall_enabled)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
 		val |= (s1_cfg->cdcfg.cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
@@ -1371,7 +1414,6 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
-__maybe_unused
 static struct arm_smmu_master *
 arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
 {
@@ -1398,9 +1440,96 @@ arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
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
+			.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
+			.perm = perm,
+			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
+		};
+
+		if (ssid_valid) {
+			flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+			flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
+		}
+	} else {
+		flt->type = IOMMU_FAULT_DMA_UNRECOV;
+		flt->event = (struct iommu_fault_unrecoverable) {
+			.flags = IOMMU_FAULT_UNRECOV_ADDR_VALID |
+				 IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID,
+			.perm = perm,
+			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
+			.fetch_addr = FIELD_GET(EVTQ_3_IPA, evt[3]),
+		};
+
+		if (ssid_valid) {
+			flt->event.flags |= IOMMU_FAULT_UNRECOV_PASID_VALID;
+			flt->event.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
+		}
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
 	struct arm_smmu_device *smmu = dev;
 	struct arm_smmu_queue *q = &smmu->evtq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
@@ -1410,11 +1539,15 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 		while (!queue_remove_raw(q, evt)) {
 			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
 
-			dev_info(smmu->dev, "event 0x%02x received:\n", id);
-			for (i = 0; i < ARRAY_SIZE(evt); ++i)
-				dev_info(smmu->dev, "\t0x%016llx\n",
-					 (unsigned long long)evt[i]);
+			ret = arm_smmu_handle_evt(smmu, evt);
 
+			if (ret) {
+				dev_info(smmu->dev, "event 0x%02x received:\n",
+					 id);
+				for (i = 0; i < ARRAY_SIZE(evt); ++i)
+					dev_info(smmu->dev, "\t0x%016llx\n",
+						 (unsigned long long)evt[i]);
+			}
 		}
 
 		/*
@@ -1927,6 +2060,8 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 
 	cfg->s1cdmax = master->ssid_bits;
 
+	smmu_domain->stall_enabled = master->stall_enabled;
+
 	ret = arm_smmu_alloc_cd_tables(smmu_domain);
 	if (ret)
 		goto out_free_asid;
@@ -2270,6 +2405,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
 		ret = -EINVAL;
 		goto out_unlock;
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
+		   smmu_domain->stall_enabled != master->stall_enabled) {
+		dev_err(dev, "cannot attach to stall-%s domain\n",
+			smmu_domain->stall_enabled ? "enabled" : "disabled");
+		ret = -EINVAL;
+		goto out_unlock;
 	}
 
 	master->domain = smmu_domain;
@@ -2503,6 +2644,10 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		master->ssid_bits = min_t(u8, master->ssid_bits,
 					  CTXDESC_LINEAR_CDMAX);
 
+	if ((smmu->features & ARM_SMMU_FEAT_STALLS && fwspec->can_stall) ||
+	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
+		master->stall_enabled = true;
+
 	return &smmu->iommu;
 
 err_free_master:
@@ -2521,6 +2666,7 @@ static void arm_smmu_release_device(struct device *dev)
 
 	master = dev_iommu_priv_get(dev);
 	WARN_ON(arm_smmu_master_sva_enabled(master));
+	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 	arm_smmu_detach_dev(master);
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
@@ -2727,6 +2873,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.sva_bind		= arm_smmu_sva_bind,
 	.sva_unbind		= arm_smmu_sva_unbind,
 	.sva_get_pasid		= arm_smmu_sva_get_pasid,
+	.page_response		= arm_smmu_page_response,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
@@ -2804,6 +2951,7 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
 static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 {
 	int ret;
+	bool sva = arm_smmu_sva_supported(smmu);
 
 	/* cmdq */
 	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
@@ -2823,6 +2971,12 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+	if (sva && smmu->features & ARM_SMMU_FEAT_STALLS) {
+		smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
+		if (!smmu->evtq.iopf)
+			return -ENOMEM;
+	}
+
 	/* priq */
 	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
 		return 0;
@@ -3789,6 +3943,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
+	iopf_queue_free(smmu->evtq.iopf);
 
 	return 0;
 }
-- 
2.29.1

