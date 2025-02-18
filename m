Return-Path: <linux-pci+bounces-21735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4D1A3A02C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 15:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1F817897C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF59F26AAB9;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR1AOBvU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA79269D0C;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889418; cv=none; b=hjRNY9khXs1KNoOwiD4PRmRWnHbu9eNbVOIZQdmDtgD5MsgDSv1ZwTKRaUL4Tsw371cNxFOtjBXFU6Uzekr0Fi+BhGhZuLIco6NGcYAzhMTVWg208UQPuqQZcTjMJ1ZCbJVmwyIe9kts7FJndxautErblJt6tMT8OM6R9850zog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889418; c=relaxed/simple;
	bh=XvXJ1MQzZf8WxpV47LK31HmkCLpKbYI67sP8fyugYhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YMRNuKsDGNw4Q/EllK4CdYJk3y9ukelYLtoqo3DIt/vfme/fqxHRP0m5dl+5Qf14JRFAMRzEmp47TaaMnRUd5PqXgXUohEWJO13LKkY2owJ62JacYx4Y8jTUZoJdtDGxnOURV5Ef5z/MQ83JFuCPb9VS2xONB3y+ZRrE1ci9/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WR1AOBvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B148C4AF0C;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739889418;
	bh=XvXJ1MQzZf8WxpV47LK31HmkCLpKbYI67sP8fyugYhg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WR1AOBvU62L8mEO2I+7eZI9gdzc7wzHtWF8rZpJj/bBw7dEKac093v+Qyq7O+KAIO
	 4FndUZ4/MSroaLq9epWCYD3iS9akQkKxm2NJsLLy/ReXoddpAzHkuGgWbtwUI+fHsU
	 O5iCiosREJ1ZUQSUzvtnty0WZr/cXSGe0AggSWRU1KRCK66TfMK1nR62CkWzddx39c
	 aEDXYWJGmU2LXOZwYvT5ImGEzAb1enmC8LKohLzk0YS+obcjAwjGlK3KyT5D/5Eyfy
	 c+kbvPGo16c0XszRieHCgfOW/vViRw8EmStZEAxlCSH9/9PqUyT0t0ABYccG9MKd1f
	 AerMrl+GLQY+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5688FC021AA;
	Tue, 18 Feb 2025 14:36:58 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Tue, 18 Feb 2025 20:06:42 +0530
Subject: [PATCH 3/4] PCI: dwc: Add sysfs support for PTM
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pcie-qcom-ptm-v1-3-16d7e480d73e@linaro.org>
References: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
In-Reply-To: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>, 
 Jing Zhang <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=18987;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=5we3kVgHWg7M829Zle66KXOdTLPGMfu81moqV1JyCok=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBntJsH1hJHIthERT3CmHc7DQfD24GuSgnn+YKwl
 QFloS1dmIuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ7SbBwAKCRBVnxHm/pHO
 9bfTB/4z8ICBL4dTx6r5zP2lqPDngG11R9h1mGrYDdE0evxxnhKo/KR0YzvLC5tpz6KsJfyb39N
 Cky7bgtkL6PvLeHpv5eTdNOQ0qPfEM8xsySnDo+Uzt8S2SItrzaw036GDRfirPN7p+hE0KIwazw
 ddJsVeRebV7+kEynVOsI5o9csVAllEtg0S0PKkOW6dQXAhmxraD32/BEd2NuaVMmSn3ONa7ANFW
 17lCNcUj4UjQTCQniDfCfeE4nAffXTA6VLJl3A1yaI6OZOpXNjWg8manT2M8wKbsGuRu9JbZ2PV
 xQxLeoHJzFywJ9sBrnhGhFN0NImcN9sWxtsSdr5UFDYu9Vpn
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Precision Time Management (PTM) mechanism defined in PCIe spec r6.0,
sec 6.22 allows precise coordination of timing information across multiple
components in a PCIe hierarchy with independent local time clocks.

While the PTM support itself is indicated by the presence of PTM Extended
Capability structure, Synopsys Designware IPs expose the PTM context
(timing information) through Vendor Specific Extended Capability (VSEC)
registers.

Hence, add the sysfs support to expose the PTM context information to
userspace from both PCIe RC and EP controllers. Below PTM context are
exposed through sysfs:

PCIe RC
=======

1. PTM Local clock
2. PTM T2 timestamp
3. PTM T3 timestamp
4. PTM Context valid

PCIe EP
=======

1. PTM Local clock
2. PTM T1 timestamp
3. PTM T4 timestamp
4. PTM Master clock
5. PTM Context update

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/ABI/testing/sysfs-platform-dwc-pcie  |  70 ++++++
 MAINTAINERS                                        |   1 +
 drivers/pci/controller/dwc/Makefile                |   2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   3 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |   4 +
 drivers/pci/controller/dwc/pcie-designware-sysfs.c | 278 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c       |   6 +
 drivers/pci/controller/dwc/pcie-designware.h       |  22 ++
 include/linux/pcie-dwc.h                           |   8 +
 9 files changed, 393 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-dwc-pcie b/Documentation/ABI/testing/sysfs-platform-dwc-pcie
new file mode 100644
index 000000000000..6b429108cd09
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-dwc-pcie
@@ -0,0 +1,70 @@
+What:		/sys/devices/platform/*/dwc/ptm/ptm_local_clock
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM local clock in nanoseconds. Applicable for both Root
+		Complex and Endpoint mode.
+
+What:		/sys/devices/platform/*/dwc/ptm/ptm_master_clock
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM master clock in nanoseconds. Applicable only for
+		Endpoint mode.
+
+What:		/sys/devices/platform/*/dwc/ptm/ptm_t1
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T1 timestamp in nanoseconds. Applicable only for
+		Endpoint mode.
+
+What:		/sys/devices/platform/*/dwc/ptm/ptm_t2
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T2 timestamp in nanoseconds. Applicable only for
+		Root Complex mode.
+
+What:		/sys/devices/platform/*/dwc/ptm/ptm_t3
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T3 timestamp in nanoseconds. Applicable only for
+		Root Complex mode.
+
+What:		/sys/devices/platform/*/dwc/ptm/ptm_t4
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RO) PTM T4 timestamp in nanoseconds. Applicable only for
+		Endpoint mode.
+
+What:		/sys/devices/platform/*/dwc/ptm/ptm_context_update
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RW) Control the PTM context update mode. Applicable only for
+		Endpoint mode.
+
+		Following values are supported:
+
+		* auto = PTM context auto update trigger for every 10ms
+
+		* manual = PTM context manual update. Writing 'manual' to this
+			   file triggers PTM context update (default)
+
+What:		/sys/devices/platform/*/dwc/ptm/ptm_context_valid
+Date:		February 2025
+Contact:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+Description:
+		(RW) Control the PTM context validity (local clock timing).
+		Applicable only for Root Complex mode. PTM context is
+		invalidated by hardware if the Root Complex enters low power
+		mode or changes link frequency.
+
+		Following values are supported:
+
+		* 0 = PTM context invalid (default)
+
+		* 1 = PTM context valid
diff --git a/MAINTAINERS b/MAINTAINERS
index b4d09d52a750..1c3e21cfbc6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18120,6 +18120,7 @@ M:	Jingoo Han <jingoohan1@gmail.com>
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-platform-dwc-pcie
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
 F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
 F:	drivers/pci/controller/dwc/*designware*
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index a8308d9ea986..3a962971249d 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PCIE_DW) += pcie-designware.o
+obj-$(CONFIG_PCIE_DW) += pcie-designware.o pcie-designware-sysfs.o
 obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 8e07d432e74f..4bb7fd5d2fb0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -666,6 +666,7 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
+	pcie_designware_sysfs_exit(pci);
 	dw_pcie_edma_remove(pci);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
@@ -837,6 +838,8 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 
 	dw_pcie_ep_init_non_sticky_registers(pci);
 
+	pcie_designware_sysfs_init(pci, DW_PCIE_EP_TYPE);
+
 	return 0;
 
 err_remove_edma:
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ffaded8f2df7..bd3195de923c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -548,6 +548,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->ops->post_init)
 		pp->ops->post_init(pp);
 
+	pcie_designware_sysfs_init(pci, DW_PCIE_RC_TYPE);
+
 	return 0;
 
 err_stop_link:
@@ -572,6 +574,8 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
+	pcie_designware_sysfs_exit(pci);
+
 	pci_stop_root_bus(pp->bridge->bus);
 	pci_remove_root_bus(pp->bridge->bus);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-sysfs.c b/drivers/pci/controller/dwc/pcie-designware-sysfs.c
new file mode 100644
index 000000000000..1ba41163cf58
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-designware-sysfs.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+
+#include "pcie-designware.h"
+
+static ssize_t ptm_context_update_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct dw_pcie *pci = dev_get_drvdata(dev);
+	u32 val;
+
+	if (sysfs_streq(buf, "auto")) {
+		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+		val |= PTM_REQ_AUTO_UPDATE_ENABLED;
+		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
+	} else if (sysfs_streq(buf, "manual")) {
+		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+		val &= ~PTM_REQ_AUTO_UPDATE_ENABLED;
+		val |= PTM_REQ_START_UPDATE;
+		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
+	} else {
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t ptm_context_update_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct dw_pcie *pci = dev_get_drvdata(dev);
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+	if (FIELD_GET(PTM_REQ_AUTO_UPDATE_ENABLED, val))
+		return sysfs_emit(buf, "auto\n");
+
+	/*
+	 * PTM_REQ_START_UPDATE is a self clearing register bit. So if
+	 * PTM_REQ_AUTO_UPDATE_ENABLED is not set, then it implies that
+	 * manual update is used.
+	 */
+	return sysfs_emit(buf, "manual\n");
+}
+
+static ssize_t ptm_context_valid_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct dw_pcie *pci = dev_get_drvdata(dev);
+	unsigned long arg;
+	u32 val;
+
+	if (kstrtoul(buf, 0, &arg) < 0)
+		return -EINVAL;
+
+	if (!!arg) {
+		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+		val |= PTM_RES_CCONTEXT_VALID;
+		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
+	} else {
+		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+		val &= ~PTM_RES_CCONTEXT_VALID;
+		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
+	}
+
+	return count;
+}
+
+static ssize_t ptm_context_valid_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct dw_pcie *pci = dev_get_drvdata(dev);
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+
+	return sysfs_emit(buf, "%u\n", !!FIELD_GET(PTM_RES_CCONTEXT_VALID, val));
+}
+
+static ssize_t ptm_local_clock_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct dw_pcie *pci = dev_get_drvdata(dev);
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_LOCAL_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_LOCAL_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_LOCAL_MSB));
+
+	return sysfs_emit(buf, "%llu\n", ((u64) msb) << 32 | lsb);
+}
+
+static ssize_t ptm_master_clock_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct dw_pcie *pci = dev_get_drvdata(dev);
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_MASTER_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_MASTER_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_MASTER_MSB));
+
+	return sysfs_emit(buf, "%llu\n", ((u64) msb) << 32 | lsb);
+}
+
+static ssize_t ptm_t1_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct dw_pcie *pci = dev_get_drvdata(dev);
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_MSB));
+
+	return sysfs_emit(buf, "%llu\n", ((u64) msb) << 32 | lsb);
+}
+
+static ssize_t ptm_t2_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct dw_pcie *pci = dev_get_drvdata(dev);
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_MSB));
+
+	return sysfs_emit(buf, "%llu\n", ((u64) msb) << 32 | lsb);
+}
+
+static ssize_t ptm_t3_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct dw_pcie *pci = dev_get_drvdata(dev);
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_MSB));
+
+	return sysfs_emit(buf, "%llu\n", ((u64) msb) << 32 | lsb);
+}
+
+static ssize_t ptm_t4_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct dw_pcie *pci = dev_get_drvdata(dev);
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_MSB));
+
+	return sysfs_emit(buf, "%llu\n", ((u64) msb) << 32 | lsb);
+}
+
+static DEVICE_ATTR_RW(ptm_context_update);
+static DEVICE_ATTR_RW(ptm_context_valid);
+static DEVICE_ATTR_RO(ptm_local_clock);
+static DEVICE_ATTR_RO(ptm_master_clock);
+static DEVICE_ATTR_RO(ptm_t1);
+static DEVICE_ATTR_RO(ptm_t2);
+static DEVICE_ATTR_RO(ptm_t3);
+static DEVICE_ATTR_RO(ptm_t4);
+
+static struct attribute *ptm_attrs[] = {
+	&dev_attr_ptm_context_update.attr,
+	&dev_attr_ptm_context_valid.attr,
+	&dev_attr_ptm_local_clock.attr,
+	&dev_attr_ptm_master_clock.attr,
+	&dev_attr_ptm_t1.attr,
+	&dev_attr_ptm_t2.attr,
+	&dev_attr_ptm_t3.attr,
+	&dev_attr_ptm_t4.attr,
+	NULL
+};
+
+static umode_t ptm_attr_visible(struct kobject *kobj, struct attribute *attr,
+				int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct dw_pcie *pci = dev_get_drvdata(dev);
+
+	/* RC only needs local, t2 and t3 clocks and context_valid */
+	if ((attr == &dev_attr_ptm_t1.attr && pci->mode == DW_PCIE_RC_TYPE) ||
+	    (attr == &dev_attr_ptm_t4.attr && pci->mode == DW_PCIE_RC_TYPE) ||
+	    (attr == &dev_attr_ptm_master_clock.attr && pci->mode == DW_PCIE_RC_TYPE) ||
+	    (attr == &dev_attr_ptm_context_update.attr && pci->mode == DW_PCIE_RC_TYPE))
+		return 0;
+
+	/* EP only needs local, master, t1, and t4 clocks and context_update */
+	if ((attr == &dev_attr_ptm_t2.attr && pci->mode == DW_PCIE_EP_TYPE) ||
+	    (attr == &dev_attr_ptm_t3.attr && pci->mode == DW_PCIE_EP_TYPE) ||
+	    (attr == &dev_attr_ptm_context_valid.attr && pci->mode == DW_PCIE_EP_TYPE))
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group ptm_attr_group = {
+	.name = "ptm",
+	.attrs = ptm_attrs,
+	.is_visible = ptm_attr_visible,
+};
+
+static const struct attribute_group *dwc_pcie_attr_groups[] = {
+	&ptm_attr_group,
+	NULL,
+};
+
+static void pcie_designware_sysfs_release(struct device *dev)
+{
+	kfree(dev);
+}
+
+void pcie_designware_sysfs_init(struct dw_pcie *pci,
+				    enum dw_pcie_device_mode mode)
+{
+	struct device *dev;
+	int ret;
+
+	/* Check for capabilities before creating sysfs attrbutes */
+	ret = dw_pcie_find_ptm_capability(pci);
+	if (!ret) {
+		dev_dbg(pci->dev, "PTM capability not present\n");
+		return;
+	}
+
+	pci->ptm_vsec_offset = ret;
+	pci->mode = mode;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return;
+
+	device_initialize(dev);
+	dev->groups = dwc_pcie_attr_groups;
+	dev->release = pcie_designware_sysfs_release;
+	dev->parent = pci->dev;
+	dev_set_drvdata(dev, pci);
+
+	ret = dev_set_name(dev, "dwc");
+	if (ret)
+		goto err_free;
+
+	ret = device_add(dev);
+	if (ret)
+		goto err_free;
+
+	pci->sysfs_dev = dev;
+
+	return;
+
+err_free:
+	put_device(dev);
+}
+
+void pcie_designware_sysfs_exit(struct dw_pcie *pci)
+{
+	if (pci->sysfs_dev)
+		device_unregister(pci->sysfs_dev);
+}
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index a7c0671c6715..30825ec0648e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -323,6 +323,12 @@ static u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci,
 	return 0;
 }
 
+u16 dw_pcie_find_ptm_capability(struct dw_pcie *pci)
+{
+	return dw_pcie_find_vsec_capability(pci, dwc_pcie_ptm_vsec_ids);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_find_ptm_capability);
+
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 501d9ddfea16..7d3cbdce37c8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -260,6 +260,21 @@
 
 #define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
 
+/* PTM register definitions */
+#define PTM_RES_REQ_CTRL		0x8
+#define PTM_RES_CCONTEXT_VALID		BIT(0)
+#define PTM_REQ_AUTO_UPDATE_ENABLED	BIT(0)
+#define PTM_REQ_START_UPDATE		BIT(1)
+
+#define PTM_LOCAL_LSB			0x10
+#define PTM_LOCAL_MSB			0x14
+#define PTM_T1_T2_LSB			0x18
+#define PTM_T1_T2_MSB			0x1c
+#define PTM_T3_T4_LSB			0x28
+#define PTM_T3_T4_MSB			0x2c
+#define PTM_MASTER_LSB			0x38
+#define PTM_MASTER_MSB			0x3c
+
 /*
  * The default address offset between dbi_base and atu_base. Root controller
  * drivers are not required to initialize atu_base if the offset matches this
@@ -439,6 +454,7 @@ struct dw_pcie_ops {
 
 struct dw_pcie {
 	struct device		*dev;
+	struct device		*sysfs_dev;
 	void __iomem		*dbi_base;
 	resource_size_t		dbi_phys_addr;
 	void __iomem		*dbi_base2;
@@ -464,6 +480,8 @@ struct dw_pcie {
 	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
+	u16			ptm_vsec_offset;
+	enum			dw_pcie_device_mode mode;
 	bool			suspended;
 };
 
@@ -478,6 +496,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
 
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
+u16 dw_pcie_find_ptm_capability(struct dw_pcie *pci);
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
@@ -499,6 +518,9 @@ void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
+void pcie_designware_sysfs_init(struct dw_pcie *pci,
+				enum dw_pcie_device_mode mode);
+void pcie_designware_sysfs_exit(struct dw_pcie *pci);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
index 261ae11d75a4..13835896290a 100644
--- a/include/linux/pcie-dwc.h
+++ b/include/linux/pcie-dwc.h
@@ -31,4 +31,12 @@ static const struct dwc_pcie_vsec_id dwc_pcie_pmu_vsec_ids[] = {
 	{} /* terminator */
 };
 
+static const struct dwc_pcie_vsec_id dwc_pcie_ptm_vsec_ids[] = {
+	{ .vendor_id = PCI_VENDOR_ID_QCOM, /* EP */
+	  .vsec_id = 0x03, .vsec_rev = 0x1 },
+	{ .vendor_id = PCI_VENDOR_ID_QCOM, /* RC */
+	  .vsec_id = 0x04, .vsec_rev = 0x1 },
+	{ }
+};
+
 #endif /* LINUX_PCIE_DWC_H */

-- 
2.25.1



