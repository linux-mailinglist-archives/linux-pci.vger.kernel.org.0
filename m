Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB2E16AEE1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgBXSYz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37454 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgBXSYy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:54 -0500
Received: by mail-wm1-f66.google.com with SMTP id a6so353567wme.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5LozG5AByqC+Y2QsZ96qniz5z6ofm6RdMRwjrLXS+sI=;
        b=zuB/c0OAZTGH2gXaCP3au67WP342eVaV0fpGipW5OGGN73wuEBs/1ROZf/qKpO3VQt
         woFLTxZNGIJ4967+Me5izVNTthCeacqxnSzqP00CSdVZMYLxj/tNulidjUqG/0VzmRjZ
         QBZKhGAJqmIBtlFc+1BYL0isbmHkquFthlxS1h9jLjYAR2EePZIEbd27msJirvOsnTsx
         RtziIkQVAZ7U2qRYVUnPq6uOoH+JWffn9cp0foAx+2pOdmEGO8+xrnjYEsG5ZmahMt01
         evtZlwEGkxH6SJ4mAKSe6obj4rsKWhmZnxT9Y8StwOwgIqQtl1cZzvX0yP51JfpyAWBn
         X2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5LozG5AByqC+Y2QsZ96qniz5z6ofm6RdMRwjrLXS+sI=;
        b=XWIjplOd0KYYtPIt2LHC3/SvUHxdi4bN16P+pmm+Mlr3na98511JNcjnzl4/M5UPEd
         Cj7RChQbPZUvlf+vPuyU6RT9DFBIRmibYaMPoByfnaf2cYWUWbMsyh/LotsftEs402l8
         i1SCvBvBDqMdO8dln3e09BVclTCQo6yurmiCYLk2BNHktC8pTi4QZpTtfyIlTV1UVvsx
         MlJ2YzSFnkmOL0XUoGEHuqyhrz6Mhagm8Aml2/sqlpRhhySFM+6h/Uz4YLyoIwAVnVPT
         Hw/YcQ89al0blyaTT/z8mfMr13rJhdp4cPdAVj+9baI66nHeTkiL37Fy2atpHyffiw0E
         Awlw==
X-Gm-Message-State: APjAAAW4x38Cq2Og+gN4jf3hueVPKvZoGEIp65fxM7ReKfrGEh3hVD6A
        sgVr1lI37mUxnuOAM13aDM2aGQ==
X-Google-Smtp-Source: APXvYqzYYT4fN7IA/sD4kQOlIG2hDqJ3nfsH3tflLkE3KADa5Uj7qCLqWe6yrMSFQh0UM4q/4UEzKA==
X-Received: by 2002:a1c:f001:: with SMTP id a1mr323565wmb.76.1582568691412;
        Mon, 24 Feb 2020 10:24:51 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:51 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, yi.l.liu@intel.com,
        zhangfei.gao@linaro.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v4 20/26] iommu/arm-smmu-v3: Maintain a SID->device structure
Date:   Mon, 24 Feb 2020 19:23:55 +0100
Message-Id: <20200224182401.353359-21-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

When handling faults from the event or PRI queue, we need to find the
struct device associated to a SID. Add a rb_tree to keep track of SIDs.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 177 +++++++++++++++++++++++++++++-------
 1 file changed, 145 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 015e8e59e0ef..28f8583cd47b 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -684,6 +684,15 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+
+	struct rb_root			streams;
+	struct mutex			streams_mutex;
+};
+
+struct arm_smmu_stream {
+	u32				id;
+	struct arm_smmu_master		*master;
+	struct rb_node			node;
 };
 
 /* SMMU private data for each master */
@@ -692,8 +701,8 @@ struct arm_smmu_master {
 	struct device			*dev;
 	struct arm_smmu_domain		*domain;
 	struct list_head		domain_head;
-	u32				*sids;
-	unsigned int			num_sids;
+	struct arm_smmu_stream		*streams;
+	unsigned int			num_streams;
 	bool				ats_enabled;
 	unsigned int			ssid_bits;
 };
@@ -1573,8 +1582,8 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		for (i = 0; i < master->num_sids; i++) {
-			cmd.cfgi.sid = master->sids[i];
+		for (i = 0; i < master->num_streams; i++) {
+			cmd.cfgi.sid = master->streams[i].id;
 			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 		}
 	}
@@ -2201,6 +2210,32 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
 	return 0;
 }
 
+__maybe_unused
+static struct arm_smmu_master *
+arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
+{
+	struct rb_node *node;
+	struct arm_smmu_stream *stream;
+	struct arm_smmu_master *master = NULL;
+
+	mutex_lock(&smmu->streams_mutex);
+	node = smmu->streams.rb_node;
+	while (node) {
+		stream = rb_entry(node, struct arm_smmu_stream, node);
+		if (stream->id < sid) {
+			node = node->rb_right;
+		} else if (stream->id > sid) {
+			node = node->rb_left;
+		} else {
+			master = stream->master;
+			break;
+		}
+	}
+	mutex_unlock(&smmu->streams_mutex);
+
+	return master;
+}
+
 /* IRQ and event handlers */
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
@@ -2434,8 +2469,8 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master, int ssid)
 
 	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
-	for (i = 0; i < master->num_sids; i++) {
-		cmd.atc.sid = master->sids[i];
+	for (i = 0; i < master->num_streams; i++) {
+		cmd.atc.sid = master->streams[i].id;
 		arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
 	}
 
@@ -2478,8 +2513,8 @@ static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 		if (!master->ats_enabled)
 			continue;
 
-		for (i = 0; i < master->num_sids; i++) {
-			cmd.atc.sid = master->sids[i];
+		for (i = 0; i < master->num_streams; i++) {
+			cmd.atc.sid = master->streams[i].id;
 			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
 		}
 	}
@@ -2846,13 +2881,13 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
 	int i, j;
 	struct arm_smmu_device *smmu = master->smmu;
 
-	for (i = 0; i < master->num_sids; ++i) {
-		u32 sid = master->sids[i];
+	for (i = 0; i < master->num_streams; ++i) {
+		u32 sid = master->streams[i].id;
 		__le64 *step = arm_smmu_get_step_for_sid(smmu, sid);
 
 		/* Bridged PCI devices may end up with duplicated IDs */
 		for (j = 0; j < i; j++)
-			if (master->sids[j] == sid)
+			if (master->streams[j].id == sid)
 				break;
 		if (j < i)
 			continue;
@@ -3105,8 +3140,8 @@ static void arm_smmu_mm_invalidate(struct device *dev, int pasid, void *entry,
 
 	arm_smmu_atc_inv_to_cmd(pasid, iova, size, &cmd);
 
-	for (i = 0; i < master->num_sids; i++) {
-		cmd.atc.sid = master->sids[i];
+	for (i = 0; i < master->num_streams; i++) {
+		cmd.atc.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
 	}
 
@@ -3206,11 +3241,99 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 	return sid < limit;
 }
 
+static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
+				  struct arm_smmu_master *master)
+{
+	int i;
+	int ret = 0;
+	struct arm_smmu_stream *new_stream, *cur_stream;
+	struct rb_node **new_node, *parent_node = NULL;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+
+	master->streams = kcalloc(fwspec->num_ids,
+				  sizeof(struct arm_smmu_stream), GFP_KERNEL);
+	if (!master->streams)
+		return -ENOMEM;
+	master->num_streams = fwspec->num_ids;
+
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < fwspec->num_ids && !ret; i++) {
+		u32 sid = fwspec->ids[i];
+
+		new_stream = &master->streams[i];
+		new_stream->id = sid;
+		new_stream->master = master;
+
+		/* Check the SIDs are in range of the SMMU and our stream table */
+		if (!arm_smmu_sid_in_range(smmu, sid)) {
+			ret = -ERANGE;
+			break;
+		}
+
+		/* Ensure l2 strtab is initialised */
+		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+			ret = arm_smmu_init_l2_strtab(smmu, sid);
+			if (ret)
+				break;
+		}
+
+		/* Insert into SID tree */
+		new_node = &(smmu->streams.rb_node);
+		while (*new_node) {
+			cur_stream = rb_entry(*new_node, struct arm_smmu_stream,
+					      node);
+			parent_node = *new_node;
+			if (cur_stream->id > new_stream->id) {
+				new_node = &((*new_node)->rb_left);
+			} else if (cur_stream->id < new_stream->id) {
+				new_node = &((*new_node)->rb_right);
+			} else {
+				dev_warn(master->dev,
+					 "stream %u already in tree\n",
+					 cur_stream->id);
+				ret = -EINVAL;
+				break;
+			}
+		}
+
+		if (!ret) {
+			rb_link_node(&new_stream->node, parent_node, new_node);
+			rb_insert_color(&new_stream->node, &smmu->streams);
+		}
+	}
+
+	if (ret) {
+		for (; i > 0; i--)
+			rb_erase(&master->streams[i].node, &smmu->streams);
+		kfree(master->streams);
+	}
+	mutex_unlock(&smmu->streams_mutex);
+
+	return ret;
+}
+
+static void arm_smmu_remove_master(struct arm_smmu_device *smmu,
+				   struct arm_smmu_master *master)
+{
+	int i;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
+
+	if (!master->streams)
+		return;
+
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < fwspec->num_ids; i++)
+		rb_erase(&master->streams[i].node, &smmu->streams);
+	mutex_unlock(&smmu->streams_mutex);
+
+	kfree(master->streams);
+}
+
 static struct iommu_ops arm_smmu_ops;
 
 static int arm_smmu_add_device(struct device *dev)
 {
-	int i, ret;
+	int ret;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master *master;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -3232,26 +3355,11 @@ static int arm_smmu_add_device(struct device *dev)
 
 	master->dev = dev;
 	master->smmu = smmu;
-	master->sids = fwspec->ids;
-	master->num_sids = fwspec->num_ids;
 	fwspec->iommu_priv = master;
 
-	/* Check the SIDs are in range of the SMMU and our stream table */
-	for (i = 0; i < master->num_sids; i++) {
-		u32 sid = master->sids[i];
-
-		if (!arm_smmu_sid_in_range(smmu, sid)) {
-			ret = -ERANGE;
-			goto err_free_master;
-		}
-
-		/* Ensure l2 strtab is initialised */
-		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-			ret = arm_smmu_init_l2_strtab(smmu, sid);
-			if (ret)
-				goto err_free_master;
-		}
-	}
+	ret = arm_smmu_insert_master(smmu, master);
+	if (ret)
+		goto err_free_master;
 
 	master->ssid_bits = min(smmu->ssid_bits, fwspec->num_pasid_bits);
 
@@ -3286,6 +3394,7 @@ static int arm_smmu_add_device(struct device *dev)
 	iommu_device_unlink(&smmu->iommu, dev);
 err_disable_pasid:
 	arm_smmu_disable_pasid(master);
+	arm_smmu_remove_master(smmu, master);
 err_free_master:
 	kfree(master);
 	fwspec->iommu_priv = NULL;
@@ -3308,6 +3417,7 @@ static void arm_smmu_remove_device(struct device *dev)
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
 	arm_smmu_disable_pasid(master);
+	arm_smmu_remove_master(smmu, master);
 	kfree(master);
 	iommu_fwspec_free(dev);
 }
@@ -3751,6 +3861,9 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	mutex_init(&smmu->streams_mutex);
+	smmu->streams = RB_ROOT;
+
 	ret = arm_smmu_init_queues(smmu);
 	if (ret)
 		return ret;
-- 
2.25.0

