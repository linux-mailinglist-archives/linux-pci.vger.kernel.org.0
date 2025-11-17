Return-Path: <linux-pci+bounces-41412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B72DC648E8
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FF3A4F1478
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3EA23BD17;
	Mon, 17 Nov 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhn0KxUU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A176230D35;
	Mon, 17 Nov 2025 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388054; cv=none; b=pFNjJHcMJYSN0JQnXzyK8GYoekCzr/HmEU2R3d+SESWvFaOnexsgC6FrMWtO33ds8r0SZD5OUBtPx7G5FrS6eyHX/DJw3NWrGo+bqEMzbH5STGp1Qikn+44JMt2iV72GEPFHlAXjIGcAR0WVuRQJpbEKTLeD+i0NxpczExaFrak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388054; c=relaxed/simple;
	bh=KFq6hm4wYhWj0CmT978SYJI5xZKP3t2GSOqoFO/Gl9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn9KtCfBnFgJ20LLQAGrlk94GopRR1oN7Igr0mu+eJZXylR/+7zA/fF8VJA2Kf3r0w5NqXDCgy/2v/oiBwZrJVcElGzVtH5eGVNnMgLUVVftNOLh3dBsXtH1clgHa/kqrW4CrpZYgusUW0X+1Crf6j/SJC2N1sNRGQzZWGULSGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhn0KxUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B64C4CEF1;
	Mon, 17 Nov 2025 14:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763388053;
	bh=KFq6hm4wYhWj0CmT978SYJI5xZKP3t2GSOqoFO/Gl9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhn0KxUUd4EfMAPW9lCXLqPUSvai+QFYXMBBDnYQyZ2HrFezJsI9kJO1kx757u491
	 wWO0rFl8c2mC+6VrJheGIEYPLUiB8pOhNbh/EhoG50+fzclLHA5meGbE8VaRrAnLJ3
	 RiXRZtxYoRzo6Y8q4IacUAN4QTZjl8FN5ph0Wdz7q0cc94PYQdo5qMMZyukxQQEAEX
	 oTpZERFalCAx82mv/GRxsGzbRiEOm+TK1RUdDxCZX769ZI80eTgr395wz01K31y7DC
	 UC8aEMS3DsDCxdeQfl95Jw0Qr+Mt7bytHyfQ5y6DUVwaW0cKA8ZDjRQnUhBQmWUJJk
	 ViZ5NHlNK4KAQ==
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
Subject: [PATCH v2 05/11] coco: guest: arm64: Add support for updating measurements from device
Date: Mon, 17 Nov 2025 19:30:01 +0530
Message-ID: <20251117140007.122062-6-aneesh.kumar@kernel.org>
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

Fetch device measurements using RSI_RDEV_GET_MEASUREMENTS. The fetched
device measurements will be cached in the host.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rhi.h             | 19 ++++++++
 drivers/virt/coco/arm-cca-guest/rhi-da.c | 48 ++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/rhi-da.h |  2 +
 drivers/virt/coco/arm-cca-guest/rsi-da.c | 58 ++++++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.h |  2 +
 5 files changed, 129 insertions(+)

diff --git a/arch/arm64/include/asm/rhi.h b/arch/arm64/include/asm/rhi.h
index 5f140015afc3..ce2ed8a440c3 100644
--- a/arch/arm64/include/asm/rhi.h
+++ b/arch/arm64/include/asm/rhi.h
@@ -42,6 +42,25 @@
 #define RHI_DA_VDEV_CONTINUE		SMC_RHI_CALL(0x0051)
 #define RHI_DA_VDEV_GET_INTERFACE_REPORT SMC_RHI_CALL(0x0052)
 
+#define RHI_VDEV_MEASURE_SIGNED		BIT(0)
+#define RHI_VDEV_MEASURE_RAW		BIT(1)
+#define RHI_VDEV_MEASURE_EXCHANGE	BIT(2)
+struct rhi_vdev_measurement_params {
+	union {
+		u64 flags;
+		u8 padding0[256];
+	};
+	union {
+		u8 indices[32];
+		u8 padding1[256];
+	};
+	union {
+		u8 nonce[32];
+		u8 padding2[256];
+	};
+};
+#define RHI_DA_VDEV_GET_MEASUREMENTS	SMC_RHI_CALL(0x0053)
+
 #define RHI_DA_TDI_CONFIG_UNLOCKED		0x0
 #define RHI_DA_TDI_CONFIG_LOCKED		0x1
 #define RHI_DA_TDI_CONFIG_RUN			0x2
diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.c b/drivers/virt/coco/arm-cca-guest/rhi-da.c
index f4fb8577e1b5..aa17bb3ee562 100644
--- a/drivers/virt/coco/arm-cca-guest/rhi-da.c
+++ b/drivers/virt/coco/arm-cca-guest/rhi-da.c
@@ -200,3 +200,51 @@ int rhi_update_vdev_interface_report_cache(struct pci_dev *pdev)
 
 	return ret;
 }
+
+static inline int rhi_vdev_get_measurements(unsigned long vdev_id,
+					    phys_addr_t vdev_meas_phys,
+					    unsigned long *cookie)
+{
+	unsigned long ret;
+
+	struct rsi_host_call *rhi_call __free(kfree) =
+		kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
+	if (!rhi_call)
+		return -ENOMEM;
+
+	rhi_call->imm = 0;
+	rhi_call->gprs[0] = RHI_DA_VDEV_GET_MEASUREMENTS;
+	rhi_call->gprs[1] = vdev_id;
+	rhi_call->gprs[2] = vdev_meas_phys;
+
+	ret = rsi_host_call(virt_to_phys(rhi_call));
+	if (ret != RSI_SUCCESS)
+		return -EIO;
+
+	*cookie = rhi_call->gprs[1];
+	return map_rhi_da_error(rhi_call->gprs[0]);
+}
+
+int rhi_update_vdev_measurements_cache(struct pci_dev *pdev,
+				       struct rhi_vdev_measurement_params *params)
+{
+	int ret;
+	unsigned long cookie;
+	int vdev_id = rsi_vdev_id(pdev);
+	phys_addr_t vdev_meas_phys = virt_to_phys(params);
+
+	for (;;) {
+		ret = rhi_vdev_get_measurements(vdev_id, vdev_meas_phys, &cookie);
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
index d83e61359b35..f90e0e715073 100644
--- a/drivers/virt/coco/arm-cca-guest/rhi-da.h
+++ b/drivers/virt/coco/arm-cca-guest/rhi-da.h
@@ -12,4 +12,6 @@ struct pci_dev;
 bool rhi_has_da_support(void);
 int rhi_vdev_set_tdi_state(struct pci_dev *pdev, unsigned long target_state);
 int rhi_update_vdev_interface_report_cache(struct pci_dev *pdev);
+int rhi_update_vdev_measurements_cache(struct pci_dev *pdev,
+				       struct rhi_vdev_measurement_params *params);
 #endif
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
index c8ba72e4be3e..aa6e13e4c0ea 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/mem_encrypt.h>
 #include <asm/rsi_cmds.h>
 
 #include "rsi-da.h"
@@ -35,9 +36,50 @@ int cca_device_unlock(struct pci_dev *pdev)
 	return 0;
 }
 
+struct page *alloc_shared_pages(int nid, gfp_t gfp_mask, unsigned long min_size)
+{
+	int ret;
+	struct page *page;
+	/* We should normalize the size based on hypervisor page size */
+	int page_order = get_order(min_size);
+
+	/* Always request for zero filled pages */
+	page = alloc_pages_node(nid, gfp_mask | __GFP_ZERO, page_order);
+
+	if (!page)
+		return NULL;
+
+	ret = set_memory_decrypted((unsigned long)page_address(page),
+				   1 << page_order);
+	/*
+	 * If set_memory_decrypted() fails then we don't know what state the
+	 * page is in, so we can't free it. Instead we leak it.
+	 * set_memory_decrypted() will already have WARNed.
+	 */
+	if (ret)
+		return NULL;
+
+	return page;
+}
+
+int free_shared_pages(struct page *page, unsigned long min_size)
+{
+	int ret;
+	/* We should normalize the size based on hypervisor page size */
+	int page_order = get_order(min_size);
+
+	ret = set_memory_encrypted((unsigned long)page_address(page), 1 << page_order);
+	/* If we fail to mark it encrypted don't free it back */
+	if (!ret)
+		__free_pages(page, page_order);
+	return ret;
+}
+
 int cca_update_device_object_cache(struct pci_dev *pdev, struct cca_guest_dsc *dsc)
 {
 	int ret;
+	struct page *shared_pages;
+	struct rhi_vdev_measurement_params *dev_meas;
 
 	ret = rhi_update_vdev_interface_report_cache(pdev);
 	if (ret) {
@@ -45,5 +87,21 @@ int cca_update_device_object_cache(struct pci_dev *pdev, struct cca_guest_dsc *d
 		return ret;
 	}
 
+	shared_pages = alloc_shared_pages(NUMA_NO_NODE, GFP_KERNEL, sizeof(struct rhi_vdev_measurement_params));
+	if (!shared_pages)
+		return -ENOMEM;
+
+	dev_meas = (struct rhi_vdev_measurement_params *)page_address(shared_pages);
+	/* request for signed full transcript */
+	dev_meas->flags = RHI_VDEV_MEASURE_SIGNED | RHI_VDEV_MEASURE_EXCHANGE;
+	/* request all measurement block. Set bit 254 */
+	dev_meas->indices[31] = 0x40;
+	ret = rhi_update_vdev_measurements_cache(pdev, dev_meas);
+
+	free_shared_pages(shared_pages, sizeof(struct rhi_vdev_measurement_params));
+	if (ret) {
+		pci_err(pdev, "failed to get device measurement (%d)\n", ret);
+		return ret;
+	}
 	return 0;
 }
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
index fd4792a50daf..3b01182924bc 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
@@ -32,5 +32,7 @@ static inline int rsi_vdev_id(struct pci_dev *pdev)
 int cca_device_lock(struct pci_dev *pdev);
 int cca_device_unlock(struct pci_dev *pdev);
 int cca_update_device_object_cache(struct pci_dev *pdev, struct cca_guest_dsc *dsc);
+struct page *alloc_shared_pages(int nid, gfp_t gfp_mask, unsigned long min_size);
+int free_shared_pages(struct page *page, unsigned long min_size);
 
 #endif
-- 
2.43.0


