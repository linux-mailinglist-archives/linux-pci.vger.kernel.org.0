Return-Path: <linux-pci+bounces-36224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E2CB58F70
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 09:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F35F3A5EB9
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 07:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BAC2E88A2;
	Tue, 16 Sep 2025 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UngFFcwG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EFC2EAB66;
	Tue, 16 Sep 2025 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008716; cv=none; b=UhdRt4ghx9YV8kWouRNArIxJT14ZYdm4n53CaKqkEqMS5u27z3Llz9cuYYdkBWcwdIR/c4jieEpF9XGv4VxppoMad5qcjH52Y10xKX3pvX9vgB+qO+8zz9Swqugomnh3R6utF0GKPUkH3DaPzK7ubEaCndc5rBVmO6LZeI6vkJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008716; c=relaxed/simple;
	bh=lEhfWp7QYoAPVlmQF5giE1FuFrKDQ7XoZLDtcD0EBGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mtq/zpAu77ISfSf1ptn5ZqyBZ4WVRt9zeIjApGgXS/aE6XwU0Y8f8qqO1buJ9BC6CU0F0eKqX3QBSHtoHJG08mOY4sBMBjyTWhtRxAU6S2FTFypTSXRFAP50A6z1TxABdlu9rZg1IAKSjDf2EUylvDkgn7TUF5EAWYxXrUD7yAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UngFFcwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED75FC4CEFC;
	Tue, 16 Sep 2025 07:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758008715;
	bh=lEhfWp7QYoAPVlmQF5giE1FuFrKDQ7XoZLDtcD0EBGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UngFFcwGtQVT8n+N524LZAYDVOBivzm+ZqbfJ2nhtSZlSaaPlIsA7TzSRsWZ3T0Xt
	 QDqhzuhCKE/IY69zaqwf0lT1v30sMUKyy+dr/iixg9LF1zsvFIs7y5a5sigyey4GCu
	 6yjFPr84scN1slzlYrb5Do9EqhkV6Af4FV5j6fddMLf2QpnHN7Fx0JjCYvq07Xl+fC
	 f0+G0x7TZTGCzNM3utPUcL4ybMnmTwRU5BJ/rL5wySc7ZdFEPP5mIaDl4STPceMSmm
	 ByZns/Pc4ecg8ahRpynQdDPExQDyzoSMjUlC+GJ0ARROXUros2AdKKAcPYk03Nu8i5
	 LFTAbaMbzYIUw==
From: Chris Li <chrisl@kernel.org>
Date: Tue, 16 Sep 2025 00:45:09 -0700
Subject: [PATCH v2 01/10] PCI/LUO: Register with Liveupdate Orchestrator
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-luo-pci-v2-1-c494053c3c08@kernel.org>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
In-Reply-To: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

Register PCI subsystem with the Liveupdate Orchestrator
and provide noop liveupdate callbacks.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 MAINTAINERS              |  2 ++
 drivers/pci/Makefile     |  1 +
 drivers/pci/liveupdate.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 91cec3288cc81aea199f730924eee1f5fda1fd72..85749a5da69f88544ccc749e9d723b1b54c0e3b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14014,11 +14014,13 @@ F:	tools/testing/selftests/livepatch/
 
 LIVE UPDATE
 M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+M:	Chris Li <chrisl@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-liveupdate
 F:	Documentation/admin-guide/liveupdate.rst
 F:	drivers/misc/liveupdate/
+F:	drivers/pci/liveupdate/
 F:	include/linux/liveupdate.h
 F:	include/uapi/linux/liveupdate.h
 F:	tools/testing/selftests/liveupdate/
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 67647f1880fb8fb0629d680398f5b88d69aac660..aa1bac7aed7d12c641a6b55e56176fb3cdde4c91 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_PCI_DOE)		+= doe.o
 obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
 obj-$(CONFIG_PCI_NPEM)		+= npem.o
 obj-$(CONFIG_PCIE_TPH)		+= tph.o
+obj-$(CONFIG_LIVEUPDATE)	+= liveupdate.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
new file mode 100644
index 0000000000000000000000000000000000000000..86b4f3a2fb44781c6e323ba029db510450556fa9
--- /dev/null
+++ b/drivers/pci/liveupdate.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Chris Li <chrisl@kernel.org>
+ */
+
+#define pr_fmt(fmt) "PCI liveupdate: " fmt
+
+#include <linux/liveupdate.h>
+
+#define PCI_SUBSYSTEM_NAME "pci"
+
+static int pci_liveupdate_prepare(void *arg, u64 *data)
+{
+	pr_info("prepare data[%llx]\n", *data);
+	return 0;
+}
+
+static int pci_liveupdate_freeze(void *arg, u64 *data)
+{
+	pr_info("freeze data[%llx]\n", *data);
+	return 0;
+}
+
+static void pci_liveupdate_cancel(void *arg, u64 data)
+{
+	pr_info("cancel data[%llx]\n", data);
+}
+
+static void pci_liveupdate_finish(void *arg, u64 data)
+{
+	pr_info("finish data[%llx]\n", data);
+}
+
+struct liveupdate_subsystem pci_liveupdate_ops = {
+	.prepare = pci_liveupdate_prepare,
+	.freeze = pci_liveupdate_freeze,
+	.cancel = pci_liveupdate_cancel,
+	.finish = pci_liveupdate_finish,
+	.name = PCI_SUBSYSTEM_NAME,
+};
+
+static int __init pci_liveupdate_init(void)
+{
+	int ret;
+
+	ret = liveupdate_register_subsystem(&pci_liveupdate_ops);
+	if (ret && liveupdate_state_updated())
+		panic("PCI liveupdate: Register subsystem failed: %d", ret);
+	WARN(ret, "PCI liveupdate: Register subsystem failed %d", ret);
+	return 0;
+}
+late_initcall_sync(pci_liveupdate_init);

-- 
2.51.0.384.g4c02a37b29-goog


