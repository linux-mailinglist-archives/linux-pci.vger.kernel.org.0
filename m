Return-Path: <linux-pci+bounces-41410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5E9C64872
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 15:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4D54223FC8
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4493328F3;
	Mon, 17 Nov 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq2lWTjW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ECF332EB2;
	Mon, 17 Nov 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763388040; cv=none; b=hOQ1oyzkODU5Z8bDaya97WG9jlsbYTl+/tJhfZyIeJ8gdjvkuWJgUlX1JhkeLRj6HMnoIyef35zU39KxztPb/cJvwskb8wRQZM3MtAqNnUU0OO/1RMafWH02byVlhoK5vv9xgZBJTuXt4tqDwzbR7B7sByRXBp5JLMskejhqBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763388040; c=relaxed/simple;
	bh=skmqiPydXKmGDZG76wasmKG8RYvqg1SsacoWzOtzd+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEFHYCdAHNiBs+Vy8blaG6baJIeWwScWnVotv/LoolgcyuvrvKTFY/5MVAJLsy8AsORkLF0QFLLxV5hy9sBfyA9O1/1Pvl/J0iTK2oyre+tniSEn3VQ8rMlelLqIKsiDloJKHD6It8Spkt20Gc/JYD5cTKamf4i4Afp+1CK9Rc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq2lWTjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B1BC4CEFB;
	Mon, 17 Nov 2025 14:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763388040;
	bh=skmqiPydXKmGDZG76wasmKG8RYvqg1SsacoWzOtzd+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mq2lWTjWxhJSZOR6Qpek3FMz0T6WEP1L++ClRQanE8zuxdFK9gc3pTZ5bArzQU96r
	 yOw2oD/HektMSARh6Br7oIRNq6H9DhAuXU9nQsFDuvrvWKM19LJX6EnOUQs02kwMfi
	 oEVzWGtPmtwSdxFNbr3QEJb/IR3xx+D1LlDxAXhzy4KkEAJAMQS8NG018FW83Enyg+
	 FPuklEp5thTm6hNFVnNkG2gaJVeGmmj/o6xU9H87lY/5awtBpDP9JOMY5WSVZ5Qn8h
	 x+anrBYpkFZRTfVJdlPQqHl9I/ie6BkSCpimLOv08JQHi5zhPHI3P46HirLugZJTEr
	 KEy1ugEHvlYRA==
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
Subject: [PATCH v2 03/11] coco: guest: arm64: Add support for guest initiated TDI bind/unbind
Date: Mon, 17 Nov 2025 19:29:59 +0530
Message-ID: <20251117140007.122062-4-aneesh.kumar@kernel.org>
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

Add RHI for VDEV_SET_TDI_STATE

Note: This is not part of RHI spec. This is a POC implementation
and will be later converted to correct interface defined by RHI.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/virt/coco/arm-cca-guest/Makefile  |  2 +-
 drivers/virt/coco/arm-cca-guest/arm-cca.c |  8 ++++-
 drivers/virt/coco/arm-cca-guest/rsi-da.c  | 36 +++++++++++++++++++++++
 drivers/virt/coco/arm-cca-guest/rsi-da.h  |  2 ++
 4 files changed, 46 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virt/coco/arm-cca-guest/rsi-da.c

diff --git a/drivers/virt/coco/arm-cca-guest/Makefile b/drivers/virt/coco/arm-cca-guest/Makefile
index 04d26e398a1d..146af69d0362 100644
--- a/drivers/virt/coco/arm-cca-guest/Makefile
+++ b/drivers/virt/coco/arm-cca-guest/Makefile
@@ -2,4 +2,4 @@
 #
 obj-$(CONFIG_ARM_CCA_GUEST) += arm-cca-guest.o
 
-arm-cca-guest-y +=  arm-cca.o rhi-da.o
+arm-cca-guest-y +=  arm-cca.o rhi-da.o rsi-da.o
diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/coco/arm-cca-guest/arm-cca.c
index 26be2e8fe182..f4c9e529c43e 100644
--- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
+++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
@@ -208,13 +208,19 @@ static struct pci_tsm *cca_tsm_lock(struct tsm_dev *tsm_dev, struct pci_dev *pde
 	if (ret)
 		return ERR_PTR(ret);
 
-	return ERR_PTR(-EIO);
+	ret = cca_device_lock(pdev);
+	if (ret)
+		return ERR_PTR(-EIO);
+
+	return &no_free_ptr(cca_dsc)->pci.base_tsm;
 }
 
 static void cca_tsm_unlock(struct pci_tsm *tsm)
 {
 	struct cca_guest_dsc *cca_dsc = to_cca_guest_dsc(tsm->pdev);
 
+	cca_device_unlock(tsm->pdev);
+
 	kfree(cca_dsc);
 }
 
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
new file mode 100644
index 000000000000..6770861629f2
--- /dev/null
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 ARM Ltd.
+ */
+
+#include <linux/pci.h>
+#include <asm/rsi_cmds.h>
+
+#include "rsi-da.h"
+#include "rhi-da.h"
+
+#define PCI_TDISP_MESSAGE_VERSION_10	0x10
+
+int cca_device_lock(struct pci_dev *pdev)
+{
+	int ret;
+
+	ret = rhi_vdev_set_tdi_state(pdev, RHI_DA_TDI_CONFIG_LOCKED);
+	if (ret) {
+		pci_err(pdev, "failed to lock the device (%u)\n", ret);
+		return -EIO;
+	}
+	return 0;
+}
+
+int cca_device_unlock(struct pci_dev *pdev)
+{
+	int ret;
+
+	ret = rhi_vdev_set_tdi_state(pdev, RHI_DA_TDI_CONFIG_UNLOCKED);
+	if (ret) {
+		pci_err(pdev, "failed to unlock the device (%u)\n", ret);
+		return -EIO;
+	}
+	return 0;
+}
diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.h b/drivers/virt/coco/arm-cca-guest/rsi-da.h
index 5ad3b740710e..d1f4641a0fa1 100644
--- a/drivers/virt/coco/arm-cca-guest/rsi-da.h
+++ b/drivers/virt/coco/arm-cca-guest/rsi-da.h
@@ -29,4 +29,6 @@ static inline int rsi_vdev_id(struct pci_dev *pdev)
 	       PCI_DEVID(pdev->bus->number, pdev->devfn);
 }
 
+int cca_device_lock(struct pci_dev *pdev);
+int cca_device_unlock(struct pci_dev *pdev);
 #endif
-- 
2.43.0


