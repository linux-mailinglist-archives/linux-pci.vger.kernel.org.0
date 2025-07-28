Return-Path: <linux-pci+bounces-33001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10478B13652
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AEF81899B87
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF99C2356C7;
	Mon, 28 Jul 2025 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Keksb5hB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558223535F;
	Mon, 28 Jul 2025 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691088; cv=none; b=UipmtD7cH5IovpXXjf+qmgGKaql/LeToemtYX4bY1d6Xdk5//YLw2HTI60TIjhML3oSsOqpfHRG57ZfU+2xqZdyRgjj2y6FN7pCh3LYSvNX9ML65qrtFiAy7O0LGS22msQF4XWGFG5Gy1M2HCBduf6zk+Xu7GDh6jP7hZA2En+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691088; c=relaxed/simple;
	bh=339S8W+LIbjLrc20LVLjOM20MZJcWx7ggezRpXxT290=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=spKFkSHrjMDHkKYn74NbWNECtAgrKK4EfMJQbd13Wc7Q6HwhRG4EK21hFjoEPe4g166fUAbLeIebNHxnn8n/uNia5ttPa/0QQtIpWySc+xgNlhIqz6RajUwkOTWXWJ4xak+qoySVrF4++p2Va6OMgUW1ngMQXsnwh2sIQyPBF8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Keksb5hB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93042C4CEF9;
	Mon, 28 Jul 2025 08:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691088;
	bh=339S8W+LIbjLrc20LVLjOM20MZJcWx7ggezRpXxT290=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Keksb5hBboY7LZ/TRxonenEr39KjJj2lrEO06nYmBJmzdKjWAZZjlRnAEfp9y8tGW
	 lvoxJBKn37mhQMYn8quJt1/klA3Irm9/BH4roP86BfhUOoz+oXxipVKiWjEzhna8SW
	 PgerGsO1jpZHxCch9pO5rhcRwkaymMCFa1oZwe0xnxHJNPHyAai2fJa0MTeeX+Xwry
	 ActoKKkoL8BUyxQpVeTLeThD5t477BQeXqNk/AhlGT1Y5xkTinGKESIQlYmMfC924D
	 4PfMzLWNYcvXfP94YamRzAXRx8vazDuxZ3utreP65y0GNYk30Ag/Lxi858qO582Q/q
	 q2uvb7UzalM9w==
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Jul 2025 01:24:31 -0700
Subject: [PATCH RFC 01/25] PCI/LUO: Register with Liveupdate Orchestrator
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-1-955b078dd653@kernel.org>
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

Register PCI subsystem with the Liveupdate Orchestrator
and provide noop liveupdate callbacks.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/Makefile     |  1 +
 drivers/pci/liveupdate.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

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
2.50.1.487.gc89ff58d15-goog


