Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73681A86B4
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391552AbgDNREo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391450AbgDNREl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9444EC061A10
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:39 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so13830689wmc.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hiETRXfeZLt0WY2JvQ+8wg567BFjejHnLqaaI4LKSM=;
        b=ggXFs8UqysltNuEcHyHwogoctE8XNDFDfAu1AwROQXAOMyMogcSE0j72TDoP1TCx/6
         XlOWMCWDGs2EJmNoARvv9gY3JhDVUlHZ/HqkwOGzwgH33UvMVBa06XrUlaLgXGwJCymx
         ITUuuxeHnRndaKzy3EocRi5yX73vqtLaEgPI/+TNl8JqLo59tjesU7IB8k2do61bP42/
         quM6cTlpZvSQWBud+xyZMfoer/1r/ScL8zsYDivwWoSN5g61lCoW6+OOfLW0E3ubCvvf
         YRhsFhoBX2K/RXr4fcyKbYIfRuwy+y0OgWmRjlMNS0/zZulCxy1mGcShYuzLlijBO545
         FqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hiETRXfeZLt0WY2JvQ+8wg567BFjejHnLqaaI4LKSM=;
        b=Ql6FVbNUgzb6uDywcQAdcADF2gSVZOTVjTLcywrngvuq4ujDYenVdMU/6mhEEm/WIr
         tU2GFWhcndf+tFhl7ieV30EKCCUtybEXQRPSEJ+36Jd49Wp/hR6uUxsTlXX6L0CsygTn
         cZTE12xZoFw1WIzYwTddyxN8H7TZGhE1ovL4bqZqJOnwMXrLtVBcZHJlIoWqnYLB7UT4
         FiEj0xtq8CbiZczcWkquqikPMJCeVOFQT2tC5LxdgYROlos8GvZ6J6nLHAlgr/iilmrC
         gA3m8/mdRl7TkB93+niuPdDDLXM6+TpQ7hdgBMvByKuGXheQRKqVTw41YEEmcJflnK5x
         4ghA==
X-Gm-Message-State: AGi0PuaqP9UQAiyF3lZiQcPSAeU4gApV79gt24XsFfiXx2WASpKHDYwR
        joPhHd2BMLNPQmgKd4QMrEix3g==
X-Google-Smtp-Source: APiQypJeBEUtsFeDxdQMOdRxs85MGZqmg6nyXk4JwZKpcy//4Udg+l2ZYnvs4q2GACl0XhRwyq7rHw==
X-Received: by 2002:a1c:cc0a:: with SMTP id h10mr729491wmb.127.1586883878270;
        Tue, 14 Apr 2020 10:04:38 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:37 -0700 (PDT)
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
Subject: [PATCH v5 14/25] iommu/arm-smmu-v3: Add support for VHE
Date:   Tue, 14 Apr 2020 19:02:42 +0200
Message-Id: <20200414170252.714402-15-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ARMv8.1 extensions added Virtualization Host Extensions (VHE), which allow
to run a host kernel at EL2. When using normal DMA, Device and CPU address
spaces are dissociated, and do not need to implement the same
capabilities, so VHE hasn't been used in the SMMU until now.

With shared address spaces however, ASIDs are shared between MMU and SMMU,
and broadcast TLB invalidations issued by a CPU are taken into account by
the SMMU. TLB entries on both sides need to have identical exception level
in order to be cleared with a single invalidation.

When the CPU is using VHE, enable VHE in the SMMU for all STEs. Normal DMA
mappings will need to use TLBI_EL2 commands instead of TLBI_NH, but
shouldn't be otherwise affected by this change.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v4->v5: bump feature bit
---
 drivers/iommu/arm-smmu-v3.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8fbc5da133ae4..21d458d817fc2 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -13,6 +13,7 @@
 #include <linux/acpi_iort.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cpufeature.h>
 #include <linux/crash_dump.h>
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
@@ -480,6 +481,8 @@ struct arm_smmu_cmdq_ent {
 		#define CMDQ_OP_TLBI_NH_ASID	0x11
 		#define CMDQ_OP_TLBI_NH_VA	0x12
 		#define CMDQ_OP_TLBI_EL2_ALL	0x20
+		#define CMDQ_OP_TLBI_EL2_ASID	0x21
+		#define CMDQ_OP_TLBI_EL2_VA	0x22
 		#define CMDQ_OP_TLBI_S12_VMALL	0x28
 		#define CMDQ_OP_TLBI_S2_IPA	0x2a
 		#define CMDQ_OP_TLBI_NSNH_ALL	0x30
@@ -651,6 +654,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_STALL_FORCE	(1 << 13)
 #define ARM_SMMU_FEAT_VAX		(1 << 14)
 #define ARM_SMMU_FEAT_RANGE_INV		(1 << 15)
+#define ARM_SMMU_FEAT_E2H		(1 << 16)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
@@ -924,6 +928,8 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_NUM, ent->tlbi.num);
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_SCALE, ent->tlbi.scale);
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
+		/* Fallthrough */
+	case CMDQ_OP_TLBI_EL2_VA:
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
 		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_LEAF, ent->tlbi.leaf);
 		cmd[1] |= FIELD_PREP(CMDQ_TLBI_1_TTL, ent->tlbi.ttl);
@@ -945,6 +951,9 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	case CMDQ_OP_TLBI_S12_VMALL:
 		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
 		break;
+	case CMDQ_OP_TLBI_EL2_ASID:
+		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
+		break;
 	case CMDQ_OP_ATC_INV:
 		cmd[0] |= FIELD_PREP(CMDQ_0_SSV, ent->substream_valid);
 		cmd[0] |= FIELD_PREP(CMDQ_ATC_0_GLOBAL, ent->atc.global);
@@ -1538,7 +1547,8 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 static void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 {
 	struct arm_smmu_cmdq_ent cmd = {
-		.opcode = CMDQ_OP_TLBI_NH_ASID,
+		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
+			CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID,
 		.tlbi.asid = asid,
 	};
 
@@ -2093,13 +2103,16 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	}
 
 	if (s1_cfg) {
+		int strw = smmu->features & ARM_SMMU_FEAT_E2H ?
+			STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
+
 		BUG_ON(ste_live);
 		dst[1] = cpu_to_le64(
 			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
 			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
 			 FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
-			 FIELD_PREP(STRTAB_STE_1_STRW, STRTAB_STE_1_STRW_NSEL1));
+			 FIELD_PREP(STRTAB_STE_1_STRW, strw));
 
 		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
 		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
@@ -2495,7 +2508,8 @@ static void arm_smmu_tlb_inv_range(unsigned long iova, size_t size,
 		return;
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		cmd.opcode	= CMDQ_OP_TLBI_NH_VA;
+		cmd.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
+				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
 		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
@@ -3800,7 +3814,11 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	writel_relaxed(reg, smmu->base + ARM_SMMU_CR1);
 
 	/* CR2 (random crap) */
-	reg = CR2_PTM | CR2_RECINVSID | CR2_E2H;
+	reg = CR2_PTM | CR2_RECINVSID;
+
+	if (smmu->features & ARM_SMMU_FEAT_E2H)
+		reg |= CR2_E2H;
+
 	writel_relaxed(reg, smmu->base + ARM_SMMU_CR2);
 
 	/* Stream table */
@@ -3958,8 +3976,11 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (reg & IDR0_MSI)
 		smmu->features |= ARM_SMMU_FEAT_MSI;
 
-	if (reg & IDR0_HYP)
+	if (reg & IDR0_HYP) {
 		smmu->features |= ARM_SMMU_FEAT_HYP;
+		if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
+			smmu->features |= ARM_SMMU_FEAT_E2H;
+	}
 
 	/*
 	 * The coherency feature as set by FW is used in preference to the ID
-- 
2.26.0

