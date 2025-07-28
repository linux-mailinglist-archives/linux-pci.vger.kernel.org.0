Return-Path: <linux-pci+bounces-33069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBBEB13C76
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E0A1C21804
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7AF274670;
	Mon, 28 Jul 2025 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1geoA6l"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0071126B74A;
	Mon, 28 Jul 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710980; cv=none; b=ozN5B8EYAt/kBFUPKtgoA91lvOchzKvz7EtEyPK4Gvadw1Y9e4Wq8z3IC4XALpqosPDfKeyJ499nHYoFnOQ5CEVmdqcchgzfYz0SNhwl+Cz9omZCJ9Fhl3yRl85dUMLR/YX+s5LwVsOpbYLdro9b/0/GzCvorQUBQcPuX0qaDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710980; c=relaxed/simple;
	bh=8+fCHdn3Uns+Oh6BXNa0Zteex0tK6krOn+9GZide67k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RByeGsy9ksS8kwswNCm/5OfBqs67junPBrE8pvytbDMAMpmEI/fkGWyyVSFMw2j6AIeHfeovokQYn0dJiKzMIiME7YCnK8rfwxzeDZukNx21PXRhvEO35DPC5pfKhniLyHZqxJi02r6v7znh9tvAuAHtO070Yj6VjXD2xuwj6l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1geoA6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE318C4CEEF;
	Mon, 28 Jul 2025 13:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710977;
	bh=8+fCHdn3Uns+Oh6BXNa0Zteex0tK6krOn+9GZide67k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1geoA6leMbw+9D0jt9eF8zWeFNkt4O2OHbAi45jQAPG5w1ugatgPh4ACE+lQL7To
	 1iUfueuU6Pk6RiEqlW9ZwDCocMmoptgrHn7C2DmowHztL6PwwQrjSWFnef/TTvF5do
	 b37xstGeN36rrnM/aD4yFfeV3I/s33PLgYC+cwLwC/JBVYE8FsnBQ6rUghcqL2lygU
	 8zx3zgE0P+ongzkqUaW2ZYGWl6xsiNCcsi8zmKOPLQy1md+eCEkVY4rf9rwoYsDvlM
	 bOiTupDCeBfy5aYEB+a+ASAGscX+SfeQSl9VSsgH7Dg0oqL2Z8l2TCZKyrxWNFF27E
	 rEYH5f2Eo+nhg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [RFC PATCH v1 37/38] coco: guest: arm64: Add support for fetching device measurements
Date: Mon, 28 Jul 2025 19:22:14 +0530
Message-ID: <20250728135216.48084-38-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250728135216.48084-1-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fetch device measurements using RSI_RDEV_GET_MEASUREMENTS.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rsi_cmds.h        | 11 +++++++
 arch/arm64/include/asm/rsi_smc.h         | 16 ++++++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.c | 39 ++++++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.h |  2 ++
 4 files changed, 68 insertions(+)

diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index 3463d571d7db..42b998f44a0e 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -265,4 +265,15 @@ static inline unsigned long __rsi_rdev_stop(unsigned long vdev_id, unsigned long
 	return res.a0;
 }
 
+static inline unsigned long __rsi_rdev_get_measurements(unsigned long vdev_id,
+						       unsigned long inst_id,
+						       phys_addr_t meas)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(SMC_RSI_RDEV_GET_MEASUREMENTS, vdev_id, inst_id, meas, &res);
+
+	return res.a0;
+}
+
 #endif /* __ASM_RSI_CMDS_H */
diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
index f6aa647239c0..f051db54cdc3 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/arch/arm64/include/asm/rsi_smc.h
@@ -202,6 +202,22 @@ struct rsi_host_call {
 
 #define SMC_RSI_RDEV_GET_INTERFACE_REPORT	SMC_RSI_FID(0x1a6)
 
+#define RSI_DEV_MEASURE_ALL		BIT(0)
+#define RSI_DEV_MEASURE_SIGNED		BIT(1)
+#define RSI_DEV_MEASURE_RAW		BIT(2)
+
+struct rsi_device_measurements_params {
+	union {
+		struct {
+			u64 flags;
+			u8 indices[32];
+			u8 nounce[32];
+		};
+		u8 padding[0x100];
+	};
+};
+
+#define SMC_RSI_RDEV_GET_MEASUREMENTS		SMC_RSI_FID(0x1a7)
 #define SMC_RSI_RDEV_LOCK			SMC_RSI_FID(0x1a9)
 #define SMC_RSI_RDEV_START			SMC_RSI_FID(0x1aa)
 #define SMC_RSI_RDEV_STOP			SMC_RSI_FID(0x1ab)
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
index 64034d220e02..6222b10964ee 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
@@ -166,10 +166,31 @@ static long rhi_get_report(int vdev_id, int da_object_type, void **report, int *
 	return ret;
 }
 
+static inline unsigned long
+rsi_rdev_get_measurements(struct pci_dev *pdev, unsigned long vdev_id,
+			  unsigned long inst_id, phys_addr_t meas)
+{
+	unsigned long ret;
+
+	ret = __rsi_rdev_get_measurements(vdev_id, inst_id, meas);
+	if (ret != RSI_SUCCESS)
+		return ret;
+
+	do {
+		ret = rsi_rdev_continue(vdev_id, inst_id);
+	} while (ret == RSI_INCOMPLETE);
+	if (ret != RSI_SUCCESS) {
+		pci_err(pdev, "failed to communicate with the device (%lu)\n", ret);
+		return ret;
+	}
+	return RSI_SUCCESS;
+}
+
 int rsi_device_lock(struct pci_dev *pdev)
 {
 	unsigned long ret;
 	unsigned long tdisp_version;
+	struct rsi_device_measurements_params *rsi_dev_meas;
 	struct cca_guest_dsc *dsm = to_cca_guest_dsc(pdev);
 	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
 		PCI_DEVID(pdev->bus->number, pdev->devfn);
@@ -198,6 +219,17 @@ int rsi_device_lock(struct pci_dev *pdev)
 		return -EOPNOTSUPP;
 	}
 
+	rsi_dev_meas = (struct rsi_device_measurements_params *)__get_free_page(GFP_KERNEL);
+	rsi_dev_meas->flags = RSI_DEV_MEASURE_ALL;
+	ret = rsi_rdev_get_measurements(pdev, vdev_id, dsm->instance_id,
+					virt_to_phys(rsi_dev_meas));
+
+	free_page((unsigned long)rsi_dev_meas);
+	if (ret != RSI_SUCCESS) {
+		pci_err(pdev, "failed to get device measurement (%lu)\n", ret);
+		return -EIO;
+	}
+
 	/* Now make a host call to copy the interface report to guest. */
 	ret = rhi_get_report(vdev_id, RHI_DA_OBJECT_INTERFACE_REPORT,
 			     &dsm->interface_report, &dsm->interface_report_size);
@@ -213,6 +245,13 @@ int rsi_device_lock(struct pci_dev *pdev)
 		return -EIO;
 	}
 
+	ret = rhi_get_report(vdev_id, RHI_DA_OBJECT_MEASUREMENT,
+			     &dsm->measurements, &dsm->measurements_size);
+	if (ret) {
+		pci_err(pdev, "failed to get device certificate from the host (%lu)\n", ret);
+		return -EIO;
+	}
+
 	return ret;
 }
 static inline unsigned long rsi_rdev_start(struct pci_dev *pdev,
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
index 71ee1edb832e..f26156d9be81 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
@@ -40,6 +40,8 @@ struct cca_guest_dsc {
 	int interface_report_size;
 	void *certificate;
 	int certificate_size;
+	void *measurements;
+	int measurements_size;
 };
 
 static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)
-- 
2.43.0


