Return-Path: <linux-pci+bounces-33024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D771B136A5
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1D43BCDCD
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B08265CBD;
	Mon, 28 Jul 2025 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDlIrPep"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E0F26563F;
	Mon, 28 Jul 2025 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691103; cv=none; b=h/m3PqtB3zZsw6IxnMxA9mJhgxtz/SCqdJAk05vIxWnLJwGqaBa8vwHuF2cxdRWTe/9M9d7QXhC1JEjfB0IZmNOBYbrg/HiY0OvNhVEtIKV1n04+uQVxDrCZH3imF+wdFi3PjaoLkF6l4bdKtFLDEcL5LBx247yzUl+gYryVdDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691103; c=relaxed/simple;
	bh=sv3oWelMOQyMoFDHjlmqzXOzxi5DPs/X9scDkrB3vWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sAhvUHb5jHwt3EbTQhKt1DnzUHgtq4ec9XrtmoQrYl1Vkqs2G6KhgELA3f2gEW2KU1EANRXmvM/aZB0Yzimm/lxygAaUkvs5SAluj15I2MVxKGp195itfb7D4k652aw4dzn5y0tUj+JRu6t4Twc5uCedy06/2HpJzxzwmxI3nRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDlIrPep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DD8C4CEF7;
	Mon, 28 Jul 2025 08:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691103;
	bh=sv3oWelMOQyMoFDHjlmqzXOzxi5DPs/X9scDkrB3vWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kDlIrPepMU5jvgXNzzNAsZ1eSZzHIUMm5Bef1gYbocK8QkaVlM/6jXkoxRH76HcC8
	 clW8mIExNRGa6/2qp5cux+WfNZ5N701CPHAru6hYhYhyRUzP2ogkL7n4+JhNU5URgZ
	 +P2lkA553nlaGy4x92Buyx6I8uRZd9pnPRkuCxMfHeKT4iJYFUok0R//+kYvwKt2kV
	 ToP/J/ksWQO0wS0+eh8swQxQ/I0GgusKYA6Fsce3WqmN3iyDH/8fHX8uMnu8AaxycQ
	 4h0Gu/kWonmoixpxUQq1XX7ugpXSEqpaCzCEb/izTzlnOBPJW/ZwnBZGwONM4Mus23
	 oeABf1ub7eKBA==
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Jul 2025 01:24:54 -0700
Subject: [PATCH RFC 24/25] PCI: pci-lu-pf-stub: Add a PF stub driver for
 Live Update testing
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-24-955b078dd653@kernel.org>
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

The pci-lu-stub driver will always request device in probe(). However if
the PF driver might be add the liveupdate device list due to "depended" bit
rather than "requested" bit.

Create the pci-lu-stub-pf driver base on the pci-lu-stuf driver, it will
not request the device at probe().

For PF device, also restore the number of VFs at probe().

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/pci-lu-stub.c | 85 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-lu-stub.c b/drivers/pci/pci-lu-stub.c
index ea8142dcb250d31cbf817df957157bc4ec3a876d..ff6230102b83ff3ad646c23b79d4e1b6de58b43f 100644
--- a/drivers/pci/pci-lu-stub.c
+++ b/drivers/pci/pci-lu-stub.c
@@ -5,6 +5,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include "pci.h"
+
 struct pci_lu_stub_ser {
 	u16 dev_id;
 } __packed;
@@ -32,15 +34,47 @@ static int validate_folio(struct pci_dev *dev, struct folio *folio)
 	return 0;
 }
 
-static int pci_lu_stub_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static bool is_pf_driver(struct pci_dev *dev)
+{
+	return pci_get_drvdata(dev);
+}
+
+static int check_lu_flags(struct pci_dev *dev, bool is_pf)
+{
+	struct dev_liveupdate *lu = &dev->dev.lu;
+	bool expect_requested = !is_pf;
+	bool expect_depended = is_pf;
+
+	if (lu->requested != expect_requested) {
+		pci_err(dev, "Device requested bit %d not match expected %d\n",
+			lu->requested, expect_requested);
+		return -EINVAL;
+	}
+
+	if (lu->depended != expect_depended) {
+		pci_err(dev, "Device requested bit %d not match expected %d\n",
+			lu->depended, expect_depended);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int __pci_lu_stub_probe(struct pci_dev *dev, const struct pci_device_id *id,
+			       bool is_pf)
 {
 	struct folio *folio;
 	u64 data;
 	int ret;
+	int vfs;
+	struct dev_liveupdate *lu = &dev->dev.lu;
+	struct pci_dev_ser *s;
 
+	pci_set_drvdata(dev, (void *)(intptr_t) is_pf);
 	if (liveupdate_state_normal()) {
-		pci_info(dev, "Marking device as liveupdate requested\n");
-		dev->dev.lu.requested = 1;
+		if (!is_pf) {
+			pci_info(dev, "Marking device as liveupdate requested\n");
+			lu->requested = 1;
+		}
 		return 0;
 	}
 
@@ -49,6 +83,10 @@ static int pci_lu_stub_probe(struct pci_dev *dev, const struct pci_device_id *id
 		return -EOPNOTSUPP;
 	}
 
+	ret = check_lu_flags(dev, is_pf);
+	if (ret)
+		return ret;
+
 	ret = pci_liveupdate_get_driver_data(dev, &data);
 	if (ret) {
 		pci_err(dev, "Failed to get driver data for device (%d)\n", ret);
@@ -63,7 +101,31 @@ static int pci_lu_stub_probe(struct pci_dev *dev, const struct pci_device_id *id
 		return -ENOENT;
 	}
 
-	return validate_folio(dev, folio);
+	ret = validate_folio(dev, folio);
+	if (ret)
+		return ret;
+
+	s = lu->dev_state;
+	vfs = s->num_vfs;
+	if (dev->is_physfn && vfs) {
+		ret = pci_sriov_configure_simple(dev, vfs);
+		if (vfs != ret) {
+			pci_err(dev, "Failed to restore num VFs %d got %d\n",
+				vfs, ret);
+			return (ret < 0) ? ret : -EAGAIN;
+		}
+	}
+	return  0;
+}
+
+static int pci_lu_stub_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	return __pci_lu_stub_probe(dev, id, false);
+}
+
+static int pci_lu_stub_pf_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	return __pci_lu_stub_probe(dev, id, true);
 }
 
 static void pci_lu_stub_remove(struct pci_dev *dev)
@@ -74,10 +136,15 @@ static void pci_lu_stub_remove(struct pci_dev *dev)
 
 static int pci_lu_stub_prepare(struct device *dev, u64 *data)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pci_lu_stub_ser *ser;
 	struct folio *folio;
 	int ret;
 
+	ret = check_lu_flags(pdev, is_pf_driver(pdev));
+	if (ret)
+		return ret;
+
 	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, get_order(sizeof(*ser)));
 	if (!folio)
 		return -ENOMEM;
@@ -135,5 +202,15 @@ static struct pci_driver pci_lu_stub_driver = {
 	.driver.lu	= &liveupdate_ops,
 };
 
+static struct pci_driver pci_lu_stub_pf_driver = {
+	.name		= "pci-lu-stub-pf",
+	.id_table	= pci_lu_stub_id_table,
+	.probe		= pci_lu_stub_pf_probe,
+	.remove		= pci_lu_stub_remove,
+	.sriov_configure = pci_sriov_configure_simple,
+	.driver.lu	= &liveupdate_ops,
+};
+
 module_pci_driver(pci_lu_stub_driver);
+module_pci_driver(pci_lu_stub_pf_driver);
 MODULE_LICENSE("GPL");

-- 
2.50.1.487.gc89ff58d15-goog


