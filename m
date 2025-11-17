Return-Path: <linux-pci+bounces-41411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 949B3C648B8
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9533B3484
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4A233342E;
	Mon, 17 Nov 2025 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM5LpFML"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D28933033A;
	Mon, 17 Nov 2025 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388047; cv=none; b=sU/c1jFuqcA2PmqmRTmddx6P1FwXi7iGIqxhBh5xL4Rg3sMSXpZmc9crWXIyeRuItaO3pXgf3tt2LXQ5FyoNLnC5JinRM538Lat/3fgKWYbIyDMtCtw5RN6xqkhrZ29p9lD40q81vBhzjAQ6BdhB5HAtzf6d6Ba/95O8JOL17Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388047; c=relaxed/simple;
	bh=iuqwUAzOCRRtnJwXt/+Ru2PZgwzmTFNgKLsPlP94gFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9QuDg+q6/D1I/7GHjXtdcahG9TRexfpP8MRyL1/UGfkhs0+pGj31btRklvcslxC008vRxmGUl5Zk+8rlgI4upQf4FUjg4Bue0wThkKHrUwXUSfgMqbkt6wKjCqs97nm+auvpP6f2c+i3UeiKUGr1MfbopPkkmvt8YA6F3TRXVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM5LpFML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC40C19422;
	Mon, 17 Nov 2025 14:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763388046;
	bh=iuqwUAzOCRRtnJwXt/+Ru2PZgwzmTFNgKLsPlP94gFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lM5LpFMLdNss7FFTtHLNcMSjoNJxkGfrhd4BZyeY26yW9Ps3LQl9yREH0i0oR0RsL
	 PhUhT4TFjcgWbT6HJwlu53bfek0ZorxVI2lobe8NRds/NDBzYWLYsuJsEl/ld3AKgr
	 4XVhX+3DeYf1YPhxa8/9qsE+25lJKHoNSnluJ0oUEeiy34kUDQOWcoKvoCYhH7zHAo
	 WFckdJavyQd66x9TSmQTpIS49qsKAxGUFuVDJPpHftyixdbOMLghporIqSsTBCkqi8
	 g3MPiDnX/tye3OSjutWZ20fDE56OYfMU4zuG1SV0CzlTgoYptNy6dhdNu1WwwVkSKT
	 zD1ToPBvTEOKA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	kvmarm@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	aik@amd.com,
	lukas@wunner.de,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: [PATCH v2 04/11] coco: guest: arm64: Add support for updating interface reports from device
Date: Mon, 17 Nov 2025 19:30:00 +0530
Message-ID: <20251117140007.122062-5-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117140007.122062-1-aneesh.kumar@kernel.org>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support collecting interface reports using RSI calls. The fetched
interface report will be cached in the host.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rhi.h              |  1 +
 drivers/virt/coco/arm-cca-guest/arm-cca.c |  6 ++++
 drivers/virt/coco/arm-cca-guest/rhi-da.c  | 44 +++++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/rhi-da.h  |  1 +
 drivers/virt/coco/arm-cca-guest/rsi-da.c  | 13 +++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.h  |  2 ++
 6 files changed, 67 insertions(+)

diff --git a/arch/arm64/include/asm/rhi.h b/arch/arm64/include/asm/rhi.h
index 335930bbf059..5f140015afc3 100644
--- a/arch/arm64/include/asm/rhi.h
+++ b/arch/arm64/include/asm/rhi.h
@@ -40,6 +40,7 @@
 #define RHI_DA_FEATURES			SMC_RHI_CALL(0x004B)
 
 #define RHI_DA_VDEV_CONTINUE		SMC_RHI_CALL(0x0051)
+#define RHI_DA_VDEV_GET_INTERFACE_REPORT SMC_RHI_CALL(0x0052)
 
 #define RHI_DA_TDI_CONFIG_UNLOCKED		0x0
 #define RHI_DA_TDI_CONFIG_LOCKED		0x1
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
index f4c9e529c43e..7988ff6d4b2e 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
@@ -212,6 +212,12 @@ static struct pci_tsm *cca_tsm_lock(struct tsm_dev *tsm_dev, struct pci_dev *pde
 	if (ret)
 		return ERR_PTR(-EIO);
 
+	ret = cca_update_device_object_cache(pdev, cca_dsc);
+	if (ret) {
+		cca_device_unlock(pdev);
+		return ERR_PTR(-EIO);
+	}
+
 	return &no_free_ptr(cca_dsc)->pci.base_tsm;
 }
 
diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.c b/drivers/virt/coco/arm-cca-guest/rhi-da.c
index 3430d8df4424..f4fb8577e1b5 100644
--- a/drivers/virt/coco/arm-cca-guest/rhi-da.c
+++ b/drivers/virt/coco/arm-cca-guest/rhi-da.c
@@ -156,3 +156,47 @@ int rhi_vdev_set_tdi_state(struct pci_dev *pdev, unsigned long target_state)
 
 	return ret;
 }
+
+static inline int rhi_vdev_get_interface_report(unsigned long vdev_id,
+						unsigned long *cookie)
+{
+	unsigned long ret;
+
+	struct rsi_host_call *rhi_call __free(kfree) =
+		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
+	if (!rhi_call)
+		return -ENOMEM;
+
+	rhi_call->imm = 0;
+	rhi_call->gprs[0] = RHI_DA_VDEV_GET_INTERFACE_REPORT;
+	rhi_call->gprs[1] = vdev_id;
+
+	ret = rsi_host_call(virt_to_phys(rhi_call));
+	if (ret != RSI_SUCCESS)
+		return -EIO;
+
+	*cookie = rhi_call->gprs[1];
+	return map_rhi_da_error(rhi_call->gprs[0]);
+}
+
+int rhi_update_vdev_interface_report_cache(struct pci_dev *pdev)
+{
+	int ret;
+	unsigned long cookie;
+	int vdev_id = rsi_vdev_id(pdev);
+
+	for (;;) {
+		ret = rhi_vdev_get_interface_report(vdev_id, &cookie);
+		if (ret != -EBUSY)
+			break;
+		cond_resched();
+	}
+
+	while (ret == E_INCOMPLETE) {
+		if (should_abort_rhi_call_loop(vdev_id))
+			return -EINTR;
+		ret = rhi_vdev_continue(vdev_id, cookie);
+	}
+
+	return ret;
+}
diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.h b/drivers/virt/coco/arm-cca-guest/rhi-da.h
index 8dd77c7ed645..d83e61359b35 100644
--- a/drivers/virt/coco/arm-cca-guest/rhi-da.h
+++ b/drivers/virt/coco/arm-cca-guest/rhi-da.h
@@ -11,4 +11,5 @@
 struct pci_dev;
 bool rhi_has_da_support(void);
 int rhi_vdev_set_tdi_state(struct pci_dev *pdev, unsigned long target_state);
+int rhi_update_vdev_interface_report_cache(struct pci_dev *pdev);
 #endif
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
index 6770861629f2..c8ba72e4be3e 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
@@ -34,3 +34,16 @@ int cca_device_unlock(struct pci_dev *pdev)
 	}
 	return 0;
 }
+
+int cca_update_device_object_cache(struct pci_dev *pdev, struct cca_guest_dsc *dsc)
+{
+	int ret;
+
+	ret = rhi_update_vdev_interface_report_cache(pdev);
+	if (ret) {
+		pci_err(pdev, "failed to get interface report (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
index d1f4641a0fa1..fd4792a50daf 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
@@ -31,4 +31,6 @@ static inline int rsi_vdev_id(struct pci_dev *pdev)
 
 int cca_device_lock(struct pci_dev *pdev);
 int cca_device_unlock(struct pci_dev *pdev);
+int cca_update_device_object_cache(struct pci_dev *pdev, struct cca_guest_dsc *dsc);
+
 #endif
-- 
2.43.0


