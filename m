Return-Path: <linux-pci+bounces-33062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C441B13C7B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB05717FCFF
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D43273D91;
	Mon, 28 Jul 2025 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mX3ZdPKz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BD0273D7C;
	Mon, 28 Jul 2025 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710935; cv=none; b=HUTFh/5FJx3514diBoiLB4/DmJ9xYBmwdPevz0ct5Ux/WRCIlh8KpvGqvLkKqVj24xVCNE3/VD81RWKC5Bk8DZY5KPYrFJz6CFG00bKj+Yo9eZVcLjOOvZF46weG8WBMZgmn7fGZKCqaQqkJ1UJJQJsJYeBDV3YS4uuAxV4RDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710935; c=relaxed/simple;
	bh=RN0CUhbZzR040Mg0s29M+9z5gFuvjBCdUvvmi2BiIEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOvaOS/U5rpaahrXk0UTdoYrjyjnuYyCLsGiVi4RWdRevn16+4of7hAc3f4RU3M+d5fs/sT8jknHCaWypDXlFO0CEiWGsl/TRlIafG33CgfWCkGOa1tVEQQmGeJjiALaep1aBsbOFXELkjRQi2WFA59Uzq5xikRJCDCjwEGpImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mX3ZdPKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176AFC4CEFE;
	Mon, 28 Jul 2025 13:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710935;
	bh=RN0CUhbZzR040Mg0s29M+9z5gFuvjBCdUvvmi2BiIEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mX3ZdPKz02WSxNRrbXpCzA2um2VhieabFSA7AL+4A2JIB+zlzWvbQJatA96WeJwNS
	 Y08gFfbphtbkRgplTRqNZCrLfiK6lsjM59WkowBvOrRiQQlPn+xJEPHaGi7xdiFlZV
	 /9/1qoeqikPt4tOmIF3yJmWdQQ9WBbBqZx/bnfuXxj2SsgIu3vghiuilZq9WAgIlPt
	 Lr2UhRlBGZsy+cQscYAcaYp1uiEuQCZb69+3UnxOhvzKbu2vDNQwPMQdfPAxReIBaP
	 CRRCGWn5Teu6nFJPSF/lyIBJ0jU28nCHIh88WSrPx/xMBDibj7HMzBw3NRX8MjJyCL
	 +Hyfdx1iaXBwg==
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
Subject: [RFC PATCH v1 30/38] coco: host: arm64: Add support for realm host interface (RHI)
Date: Mon, 28 Jul 2025 19:22:07 +0530
Message-ID: <20250728135216.48084-31-aneesh.kumar@kernel.org>
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

Device assignment-related RHI calls result in a REC exit, which is
handled by the tsm guest_request callback.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/include/asm/rhi.h             | 32 ++++++++++
 drivers/virt/coco/arm-cca-host/arm-cca.c | 68 ++++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmm-da.c  | 81 ++++++++++++++++++++++++
 drivers/virt/coco/arm-cca-host/rmm-da.h  |  4 ++
 include/linux/tsm.h                      |  3 +
 5 files changed, 188 insertions(+)
 create mode 100644 arch/arm64/include/asm/rhi.h

diff --git a/arch/arm64/include/asm/rhi.h b/arch/arm64/include/asm/rhi.h
new file mode 100644
index 000000000000..d3c22e582678
--- /dev/null
+++ b/arch/arm64/include/asm/rhi.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 ARM Ltd.
+ */
+
+#ifndef __ASM_RHI_H_
+#define __ASM_RHI_H_
+
+#define SMC_RHI_CALL(func)				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,		\
+			   ARM_SMCCC_SMC_64,		\
+			   ARM_SMCCC_OWNER_STANDARD_HYP,\
+			   (func))
+
+
+#define RHI_DA_FEATURES			SMC_RHI_CALL(0x004d)
+#define RHI_DA_OBJECT_SIZE		SMC_RHI_CALL(0x004e)
+#define RHI_DA_OBJECT_READ		SMC_RHI_CALL(0x004f)
+
+#define RHI_DA_OBJECT_CERTIFICATE		0x1
+#define RHI_DA_OBJECT_MEASUREMENT		0x2
+#define RHI_DA_OBJECT_INTERFACE_REPORT		0x3
+#define RHI_DA_OBJECT_VCA			0x4
+
+
+#define RHI_DA_SUCCESS				0x1
+#define RHI_ERROR_INVALID_VDEV_ID		0x2
+#define RHI_ERROR_INVALID_DA_OBJECT_TYPE	0x3
+#define RHI_ERROR_DATA_NOT_AVAILABLE		0x4
+#define RHI_ERROR_INVALID_OFFSET		0x5
+#define RHI_ERROR_INVALID_ADDR			0x6
+#endif
diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
index be1296fb1bf2..0807fcf8d222 100644
--- a/drivers/virt/coco/arm-cca-host/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
@@ -260,6 +260,73 @@ static void cca_tsm_unbind(struct pci_tdi *tdi)
 	module_put(THIS_MODULE);
 }
 
+struct da_object_size_req {
+	int object_type;
+};
+
+struct da_object_read_req {
+	int object_type;
+	unsigned long offset;
+};
+
+static int cca_tsm_guest_req(struct pci_dev *pdev, struct tsm_guest_req_info *info)
+{
+	int ret;
+
+	switch (info->type) {
+	case ARM_CCA_DA_OBJECT_SIZE:
+	{
+		int object_size;
+		struct da_object_size_req req;
+
+		if (sizeof(req) != info->req_len)
+			return -EINVAL;
+
+		if (copy_from_user(&req, info->req, info->req_len))
+			return -EFAULT;
+
+		object_size = rme_get_da_object_size(pdev, req.object_type);
+		if (object_size > 0) {
+			if (info->resp_len < sizeof(object_size))
+				return -EINVAL;
+			if (copy_to_user(info->resp, &object_size, sizeof(object_size)))
+				return -EFAULT;
+			info->resp_len = sizeof(object_size);
+			ret = 0;
+		} else
+			/* error */
+			ret = object_size;
+		break;
+	}
+	case ARM_CCA_DA_OBJECT_READ:
+	{
+		int resp_len;
+		struct da_object_read_req req;
+
+		if (sizeof(req) != info->req_len)
+			return -EINVAL;
+
+		if (copy_from_user(&req, info->req, info->req_len))
+			return -EFAULT;
+
+		resp_len = rme_da_object_read(pdev, req.object_type, req.offset,
+					      info->resp_len,
+					      info->resp);
+		if (resp_len > 0) {
+			info->resp_len = resp_len;
+			ret = 0;
+		} else
+			/* error */
+			ret = resp_len;
+		break;
+	}
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
 static const struct pci_tsm_ops cca_pci_ops = {
 	.probe = cca_tsm_pci_probe,
 	.remove = cca_tsm_pci_remove,
@@ -267,6 +334,7 @@ static const struct pci_tsm_ops cca_pci_ops = {
 	.disconnect = cca_tsm_disconnect,
 	.bind	= cca_tsm_bind,
 	.unbind = cca_tsm_unbind,
+	.guest_req = cca_tsm_guest_req,
 };
 
 static void cca_tsm_remove(void *tsm_core)
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
index bef33e618fd3..c7da9d12f258 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.c
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
@@ -10,7 +10,9 @@
 #include <keys/asymmetric-type.h>
 #include <keys/x509-parser.h>
 #include <linux/kvm_types.h>
+#include <linux/kvm_host.h>
 #include <asm/kvm_rme.h>
+#include <asm/kvm_emulate.h>
 
 #include "rmm-da.h"
 
@@ -769,6 +771,85 @@ static int rme_exit_vdev_req_handler(struct realm_rec *rec)
 	return 1;
 }
 
+int rme_get_da_object_size(struct pci_dev *pdev, int type)
+{
+	int ret = 0;
+	unsigned long len;
+	struct pci_tsm *tsm = pdev->tsm;
+	struct cca_host_dsc_pf0 *dsc_pf0;
+
+	if (!tsm)
+		return -EINVAL;
+
+	dsc_pf0 = to_cca_dsc_pf0(tsm->dsm_dev);
+
+	/* Determine the buffer that should be used */
+	if (type == RHI_DA_OBJECT_INTERFACE_REPORT) {
+		len = dsc_pf0->interface_report.size;
+	} else if (type == RHI_DA_OBJECT_MEASUREMENT) {
+		len = dsc_pf0->measurements.size;
+	} else if (type == RHI_DA_OBJECT_CERTIFICATE) {
+		len = dsc_pf0->cert_chain.cache.size;
+	} else if (type == RHI_DA_OBJECT_VCA) {
+		len = dsc_pf0->vca.size;
+	} else {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	return len;
+err_out:
+	return ret;
+}
+
+int rme_da_object_read(struct pci_dev *pdev, int type, unsigned long offset,
+		       unsigned long max_len, void __user *user_buf)
+{
+	void *buf;
+	int ret = 0;
+	unsigned long len;
+	struct cca_host_dsc_pf0 *dsc_pf0;
+	struct pci_tsm *tsm = pdev->tsm;
+
+	if (!tsm)
+		return -EINVAL;
+
+	dsc_pf0 = to_cca_dsc_pf0(tsm->dsm_dev);
+
+	/* Determine the buffer that should be used */
+	if (type == RHI_DA_OBJECT_INTERFACE_REPORT) {
+		len = dsc_pf0->interface_report.size;
+		buf = dsc_pf0->interface_report.buf;
+	} else if (type == RHI_DA_OBJECT_MEASUREMENT) {
+		len = dsc_pf0->measurements.size;
+		buf = dsc_pf0->measurements.buf;
+	} else if (type == RHI_DA_OBJECT_CERTIFICATE) {
+		len = dsc_pf0->cert_chain.cache.size;
+		buf = dsc_pf0->cert_chain.cache.buf;
+	} else if (type == RHI_DA_OBJECT_VCA) {
+		len = dsc_pf0->vca.size;
+		buf = dsc_pf0->vca.buf;
+	} else {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	/* Assume that the buffer is large enough for the whole report */
+	if ((max_len - offset) < len) {
+		/* FIXME!! the error code */
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	if (copy_to_user(user_buf + offset, buf, len)) {
+		ret = -EIO;
+		goto err_out;
+	}
+	ret = len;
+err_out:
+	return ret;
+}
+
 void rme_register_exit_handlers(void)
 {
 	realm_exit_vdev_comm_handler = rme_exit_vdev_comm_handler;
diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.h b/drivers/virt/coco/arm-cca-host/rmm-da.h
index cebddab8464d..457660ff3b69 100644
--- a/drivers/virt/coco/arm-cca-host/rmm-da.h
+++ b/drivers/virt/coco/arm-cca-host/rmm-da.h
@@ -10,6 +10,7 @@
 #include <linux/pci-ide.h>
 #include <linux/pci-tsm.h>
 #include <asm/rmi_smc.h>
+#include <asm/rhi.h>
 
 #define MAX_CACHE_OBJ_SIZE	4096
 struct cache_object {
@@ -101,4 +102,7 @@ void *rme_create_vdev(struct realm *realm, struct pci_dev *pdev,
 void rme_unbind_vdev(struct realm *realm, struct pci_dev *pdev,
 		     struct pci_dev *pf0_dev);
 void rme_register_exit_handlers(void);
+int rme_get_da_object_size(struct pci_dev *pdev, int type);
+int rme_da_object_read(struct pci_dev *pdev, int type, unsigned long offset,
+		       unsigned long max_len, void __user *user_buf);
 #endif
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 497a3b4df5a0..e82046b0c7fa 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -145,5 +145,8 @@ struct tsm_guest_req_info {
 	size_t resp_len;
 };
 
+#define ARM_CCA_DA_OBJECT_SIZE 0x1
+#define ARM_CCA_DA_OBJECT_READ 0x2
+
 int tsm_guest_req(struct device *dev, struct tsm_guest_req_info *info);
 #endif /* __TSM_H */
-- 
2.43.0


