Return-Path: <linux-pci+bounces-33011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3BDB13672
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F26D3A7051
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E22258CC1;
	Mon, 28 Jul 2025 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te9cLWBh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12712580F3;
	Mon, 28 Jul 2025 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691094; cv=none; b=e+qh/WrsPhArLS6w5iFgxzq6zv6v73E6IxfUCImp8Y26eshle+LAlUVc9sYslX8BJpKtHclmqdBIR3JZNba5p52PBfMLJBqcQKk3oVZ1cHbEyg7K8i/3avxr1ByGkwxAZjUtqCkupGC+j1bepZbQl1A4I6rK8jJ2seJeiK+29GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691094; c=relaxed/simple;
	bh=9pT7auVR6FAltHXHR5et0YHF+AalsZ3feMtnFd9sQdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C83Zua4+FsY13LAAHklIKNxzrDGRCPhhi6T1laQrAlPajtFi9xUTjcOgIInBHwm+Q6N7f5qMGY2myv7jvbpBsFrZQ2wzZ21TWH7uKpxtmCfF/lixTg0N3RfVg/yB2ub6lj9F//3CPWhfpGayr3NEi8Km7q+54g3GByT7H3pBPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te9cLWBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E68C4CEF8;
	Mon, 28 Jul 2025 08:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691094;
	bh=9pT7auVR6FAltHXHR5et0YHF+AalsZ3feMtnFd9sQdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Te9cLWBhiy6rREo9AL32h61LkBX2ll6ENb8FEHGmx958YLvwYrdnQPWVm91ESDTLr
	 PxLToLiWJB0NHo9sZZwh+1Ic0yIDnOzToI3ZzEAHedmWBRp/1+xO8s3T4PHD822v5P
	 SymgEhj/FrrRMXf9qbeoREmcB7YStz7YIfRg7wjsZ2jZOlY/lSfkKfsiQ/2oXuL5RO
	 fyh7yl9B7PriipNKsCrb0OzZ0YUO4dsjJRAX8yvl0IfxSLKBr0f6dzk+gXAEhk3jDa
	 MdlYYfsVGqdlRwNkBIGcaNhYAPBiSVbw1vMPU+N5o7EBZEiP4aPIiPqq5PxI15rytg
	 c0YEjb9LHYjeg==
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Jul 2025 01:24:41 -0700
Subject: [PATCH RFC 11/25] PCI: pci-lu-stub: Add a stub driver for Live
 Update testing
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-11-955b078dd653@kernel.org>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
In-Reply-To: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

Introduce a new driver, pci-lu-stub, that can be bound to any PCI device
and used to test the PCI subsystem support for Live Update. This driver
gives developers a way to opt-in a device for Live Update and driver
interaction with the PCI subsystem. This driver is only intended for
testing purposes.

In the future this driver can be extended to test other scenarios (such
as failing prepare() on purpose).

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/Kconfig       |  10 ++++
 drivers/pci/Makefile      |   1 +
 drivers/pci/pci-lu-stub.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9c0e4aaf4e8cb7fecd9f80ac6289b8d854ce03aa..37e44782fa35c64c2eba6a0f6942d44d8003a499 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -327,3 +327,13 @@ source "drivers/pci/switch/Kconfig"
 source "drivers/pci/pwrctrl/Kconfig"
 
 endif
+
+config PCI_LU_STUB
+	tristate "PCI Live Update Stub Driver"
+	depends on LIVEUPDATE
+	help
+	  Say Y or M here if you want to enable support for the Live Update stub
+	  driver. This driver can be used to test the PCI subsystem support for
+	  Live Updates.
+
+	  When in doubt, say N.
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index aa1bac7aed7d12c641a6b55e56176fb3cdde4c91..061e98d0411a951573e1996c61ce5a98f2775e53 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
 obj-$(CONFIG_LIVEUPDATE)	+= liveupdate.o
+obj-$(CONFIG_PCI_LU_STUB) 	+= pci-lu-stub.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/pci-lu-stub.c b/drivers/pci/pci-lu-stub.c
new file mode 100644
index 0000000000000000000000000000000000000000..ea8142dcb250d31cbf817df957157bc4ec3a876d
--- /dev/null
+++ b/drivers/pci/pci-lu-stub.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kexec_handover.h>
+#include <linux/liveupdate.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+struct pci_lu_stub_ser {
+	u16 dev_id;
+} __packed;
+
+static const struct pci_device_id pci_lu_stub_id_table[] = {
+	/* Allow binding to any device but only via driver_override. */
+	{ PCI_DEVICE_DRIVER_OVERRIDE(PCI_ANY_ID, PCI_ANY_ID, 1) },
+	{},
+};
+
+static int validate_folio(struct pci_dev *dev, struct folio *folio)
+{
+	const struct pci_lu_stub_ser *ser = folio_address(folio);
+
+	if (folio_order(folio) != get_order(sizeof(*ser))) {
+		pci_err(dev, "Restored folio has unexpected order %u\n", folio_order(folio));
+		return -ERANGE;
+	}
+
+	if (ser->dev_id != pci_dev_id(dev)) {
+		pci_err(dev, "Restored folio contains unexpected dev_id: 0x%x\n", ser->dev_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int pci_lu_stub_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	struct folio *folio;
+	u64 data;
+	int ret;
+
+	if (liveupdate_state_normal()) {
+		pci_info(dev, "Marking device as liveupdate requested\n");
+		dev->dev.lu.requested = 1;
+		return 0;
+	}
+
+	if (!liveupdate_state_updated()) {
+		pci_err(dev, "Unable to handle probe() outside of normal and updated states.\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = pci_liveupdate_get_driver_data(dev, &data);
+	if (ret) {
+		pci_err(dev, "Failed to get driver data for device (%d)\n", ret);
+		return ret;
+	}
+
+	pci_info(dev, "%s(): data: 0x%llx\n", __func__, data);
+
+	folio = kho_restore_folio(data);
+	if (!folio) {
+		pci_err(dev, "Failed to restore folio at 0x%llx.\n", data);
+		return -ENOENT;
+	}
+
+	return validate_folio(dev, folio);
+}
+
+static void pci_lu_stub_remove(struct pci_dev *dev)
+{
+	WARN_ON(!liveupdate_state_normal());
+	dev->dev.lu.requested = 0;
+}
+
+static int pci_lu_stub_prepare(struct device *dev, u64 *data)
+{
+	struct pci_lu_stub_ser *ser;
+	struct folio *folio;
+	int ret;
+
+	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, get_order(sizeof(*ser)));
+	if (!folio)
+		return -ENOMEM;
+
+	ret = kho_preserve_folio(folio);
+	if (ret) {
+		dev_err(dev, "Failed to preserve folio (%d)\n", ret);
+		folio_put(folio);
+		return ret;
+	}
+
+	ser = folio_address(folio);
+	ser->dev_id = pci_dev_id(to_pci_dev(dev));
+
+	*data = virt_to_phys(ser);
+	dev_info(dev, "%s(): data: 0x%llx\n", __func__, *data);
+	return 0;
+}
+
+static int pci_lu_stub_freeze(struct device *dev, u64 *data)
+{
+	struct folio *folio = pfn_folio(PHYS_PFN(*data));
+
+	dev_info(dev, "%s(): data: 0x%llx\n", __func__, *data);
+	return validate_folio(to_pci_dev(dev), folio);
+}
+
+static void pci_lu_stub_finish(struct device *dev, u64 data)
+{
+	struct folio *folio = pfn_folio(PHYS_PFN(data));
+
+	dev_info(dev, "%s(): data: 0x%llx\n", __func__, data);
+	WARN_ON(validate_folio(to_pci_dev(dev), folio));
+	folio_put(folio);
+}
+
+static void pci_lu_stub_cancel(struct device *dev, u64 data)
+{
+	dev_info(dev, "%s(): data: 0x%llx\n", __func__, data);
+	pci_lu_stub_finish(dev, data);
+}
+
+static struct dev_liveupdate_ops liveupdate_ops = {
+	.prepare	= pci_lu_stub_prepare,
+	.freeze		= pci_lu_stub_freeze,
+	.finish		= pci_lu_stub_finish,
+	.cancel		= pci_lu_stub_cancel,
+};
+
+static struct pci_driver pci_lu_stub_driver = {
+	.name		= "pci-lu-stub",
+	.id_table	= pci_lu_stub_id_table,
+	.probe		= pci_lu_stub_probe,
+	.remove		= pci_lu_stub_remove,
+	.driver.lu	= &liveupdate_ops,
+};
+
+module_pci_driver(pci_lu_stub_driver);
+MODULE_LICENSE("GPL");

-- 
2.50.1.487.gc89ff58d15-goog


