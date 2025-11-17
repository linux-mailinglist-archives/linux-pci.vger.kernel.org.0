Return-Path: <linux-pci+bounces-41413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B927C64924
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA1433583EA
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C8133556B;
	Mon, 17 Nov 2025 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFeJFKjj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D95335560;
	Mon, 17 Nov 2025 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388061; cv=none; b=tEQ1pqN2UM66PZj0k3QLffaW9knI7kvWDgGB7t9uLvgGWVKDCH8hfUiqrbYk9uTSaY9V27UDfiUlwpVJYkouT6pu63eLtQ7R48tzmVQHO4XxXIPsBZDU6z3Lh/GioIzM1NomWMpQEV5MDTBjT8lEK13zG+vfyOa8E5FSkU6bYuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388061; c=relaxed/simple;
	bh=QOotzErKUJ2UaZQTjbPYpTcSWX1UPnLvI2XjpJa+XTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuHZ5LA65UCU9zGasWS4K+WwFFQphO31t+kA3ZRi6FDvQkwZi5Lj0RdALQRCqKAKfDqaiYrB7RlefvKFcsRDOxKWtgZ4SUE/r7hNDa7CGQtcms5PvmdOcwQE3IDTW4dUR73C60CYXj3PdaOOFZG9HfmiYkN3bLtIkiDY6+BCDjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFeJFKjj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BB9C4CEF1;
	Mon, 17 Nov 2025 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763388060;
	bh=QOotzErKUJ2UaZQTjbPYpTcSWX1UPnLvI2XjpJa+XTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFeJFKjjC2I3ItiTyu7uG8ec2TT/gzlBySnmgzkfWN+sib6gXC9GzA3nAbxDsQjNq
	 QNc4OqNDn7nFULZSGaoOGvUG/AGTQJx4R4a2tYFWGV5kQZ8kMTvVxfzhZYofZf+8YG
	 OTM+vQgRKHx4WcToMLhfUKz079IQs4p1ZqVhAWnDYO7JNzehExBDjsi3299tPQ6TS4
	 MrqbOPE3Y8h7Cklv7WwqSsTuBmA3yeu+aR8hqbvDnoNbV6AlDnPeFOSed6MvTOSAms
	 9DdrJpmhneXQFlcuswhBMyucqSRg6at+p75avi728UICh0mghTxrLA++9hEikP3iDd
	 INJdITu+3OUgw==
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
Subject: [PATCH v2 06/11] coco: guest: arm64: Add support for reading cached objects from host
Date: Mon, 17 Nov 2025 19:30:02 +0530
Message-ID: <20251117140007.122062-7-aneesh.kumar@kernel.org>
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

Teach rsi_device_start() to pull the interface report and device
certificate from the host by querying size, sharing a decrypted buffer
for the read, copying the payload to private memory. Also track the
fetched blobs in struct cca_guest_dsc so later stages can hand them to
the attestation flow.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rhi.h             |  7 +++
 drivers/virt/coco/arm-cca-guest/rhi-da.c | 80 ++++++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/rhi-da.h |  1 +
 drivers/virt/coco/arm-cca-guest/rsi-da.h |  8 +++
 4 files changed, 96 insertions(+)

diff --git a/arch/arm64/include/asm/rhi.h b/arch/arm64/include/asm/rhi.h
index ce2ed8a440c3..738470dfb869 100644
--- a/arch/arm64/include/asm/rhi.h
+++ b/arch/arm64/include/asm/rhi.h
@@ -39,6 +39,13 @@
 				 RHI_DA_FEATURE_VDEV_SET_TDI_STATE)
 #define RHI_DA_FEATURES			SMC_RHI_CALL(0x004B)
 
+#define RHI_DA_OBJECT_CERTIFICATE		0x1
+#define RHI_DA_OBJECT_MEASUREMENT		0x2
+#define RHI_DA_OBJECT_INTERFACE_REPORT		0x3
+#define RHI_DA_OBJECT_VCA			0x4
+#define RHI_DA_OBJECT_SIZE		SMC_RHI_CALL(0x004C)
+#define RHI_DA_OBJECT_READ		SMC_RHI_CALL(0x004D)
+
 #define RHI_DA_VDEV_CONTINUE		SMC_RHI_CALL(0x0051)
 #define RHI_DA_VDEV_GET_INTERFACE_REPORT SMC_RHI_CALL(0x0052)
 
diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.c b/drivers/virt/coco/arm-cca-guest/rhi-da.c
index aa17bb3ee562..d29aee0fca58 100644
--- a/drivers/virt/coco/arm-cca-guest/rhi-da.c
+++ b/drivers/virt/coco/arm-cca-guest/rhi-da.c
@@ -248,3 +248,83 @@ int rhi_update_vdev_measurements_cache(struct pci_dev *pdev,
 
 	return ret;
 }
+
+int rhi_read_cached_object(int vdev_id, int da_object_type, void **object, int *object_size)
+{
+	int ret;
+	int max_data_len;
+	struct page *shared_pages;
+	void *data_buf_shared, *data_buf_private;
+	struct rsi_host_call *rhicall;
+
+	rhicall = kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
+	if (!rhicall)
+		return -ENOMEM;
+
+	rhicall->imm = 0;
+	rhicall->gprs[0] = RHI_DA_OBJECT_SIZE;
+	rhicall->gprs[1] = vdev_id;
+	rhicall->gprs[2] = da_object_type;
+
+	ret = rsi_host_call(virt_to_phys(rhicall));
+	if (ret != RSI_SUCCESS) {
+		ret = -EIO;
+		goto err_return;
+	}
+
+	if (rhicall->gprs[0] != RHI_DA_SUCCESS) {
+		ret = -EIO;
+		goto err_return;
+	}
+
+	/* validate against the max cache object size used on host. */
+	max_data_len = rhicall->gprs[1];
+	if (max_data_len > MAX_CACHE_OBJ_SIZE || max_data_len == 0) {
+		ret = -EIO;
+		goto err_return;
+	}
+	*object_size = max_data_len;
+
+	data_buf_private = kmalloc(*object_size, GFP_KERNEL);
+	if (!data_buf_private) {
+		ret = -ENOMEM;
+		goto err_return;
+	}
+
+	shared_pages = alloc_shared_pages(NUMA_NO_NODE, GFP_KERNEL, max_data_len);
+	if (!shared_pages) {
+		ret = -ENOMEM;
+		goto err_shared_alloc;
+	}
+	data_buf_shared = page_address(shared_pages);
+
+	rhicall->imm = 0;
+	rhicall->gprs[0] = RHI_DA_OBJECT_READ;
+	rhicall->gprs[1] = vdev_id;
+	rhicall->gprs[2] = da_object_type;
+	rhicall->gprs[3] = 0; /* offset within the data buffer */
+	rhicall->gprs[4] = max_data_len;
+	rhicall->gprs[5] = virt_to_phys(data_buf_shared);
+	ret = rsi_host_call(virt_to_phys(rhicall));
+	if (ret != RSI_SUCCESS || rhicall->gprs[0] != RHI_DA_SUCCESS) {
+		ret = -EIO;
+		goto err_rhi_call;
+	}
+
+	memcpy(data_buf_private, data_buf_shared, *object_size);
+	free_shared_pages(shared_pages, max_data_len);
+
+	*object = data_buf_private;
+	kfree(rhicall);
+	return 0;
+
+err_rhi_call:
+	free_shared_pages(shared_pages, max_data_len);
+err_shared_alloc:
+	kfree(data_buf_private);
+err_return:
+	*object = NULL;
+	*object_size = 0;
+	kfree(rhicall);
+	return ret;
+}
diff --git a/drivers/virt/coco/arm-cca-guest/rhi-da.h b/drivers/virt/coco/arm-cca-guest/rhi-da.h
index f90e0e715073..303d19a80cd0 100644
--- a/drivers/virt/coco/arm-cca-guest/rhi-da.h
+++ b/drivers/virt/coco/arm-cca-guest/rhi-da.h
@@ -14,4 +14,5 @@ int rhi_vdev_set_tdi_state(struct pci_dev *pdev, unsigned long target_state);
 int rhi_update_vdev_interface_report_cache(struct pci_dev *pdev);
 int rhi_update_vdev_measurements_cache(struct pci_dev *pdev,
 				       struct rhi_vdev_measurement_params *params);
+int rhi_read_cached_object(int vdev_id, int da_object_type, void **object, int *object_size);
 #endif
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
index 3b01182924bc..fa9cc01095da 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
@@ -10,8 +10,16 @@
 #include <linux/pci-tsm.h>
 #include <asm/rsi_smc.h>
 
+#define MAX_CACHE_OBJ_SIZE	SZ_16M
+
 struct cca_guest_dsc {
 	struct pci_tsm_devsec pci;
+	void *interface_report;
+	int interface_report_size;
+	void *certificate;
+	int certificate_size;
+	void *measurements;
+	int measurements_size;
 };
 
 static inline struct cca_guest_dsc *to_cca_guest_dsc(struct pci_dev *pdev)
-- 
2.43.0


