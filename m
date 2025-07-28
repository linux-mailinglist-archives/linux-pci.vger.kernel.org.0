Return-Path: <linux-pci+bounces-33009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8CEB1366E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435BB3BB539
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DB8257423;
	Mon, 28 Jul 2025 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uL73lvVE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC42571B9;
	Mon, 28 Jul 2025 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691094; cv=none; b=XfjSYHUzvmiJKegTJTk/ISeA1YVD40Z757uOhxFuuAN3Dh8bTiK2QRLJvNr7CuebNWl898g7NHavpZo+7DFfJsH50BW+DdNcPZKvPKtnJPCq0XYCk40hsjWtAWCaHpPAHtySkqtlF1pDygJlJzpvmY/1gwZXfLbItYC3O8C925s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691094; c=relaxed/simple;
	bh=/sFaBdMjGwDl1mH7fe9xS4pA+fmlg0Igj7ajJY841K4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mqy3yjbQXG+TXodL/6p7aUYZYDBbrRJC+KhgljK0kjP9ppaCIABvdIhZS8KfxbSj+iNRsiUntnDQg0tko7vUnNggsdlp6uPsHjCuF5dAVyCyYlyorkJLXqPCLSpJQ9g2enHD3iEOl3V3N8q1YF3N4LACqnecZAv8Y3Eth6H+gvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uL73lvVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843D8C113D0;
	Mon, 28 Jul 2025 08:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691094;
	bh=/sFaBdMjGwDl1mH7fe9xS4pA+fmlg0Igj7ajJY841K4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uL73lvVE05TLPb6h14bdYg1Bk1bcCIF9oiU/MhYnakKrXSttNuYvhdFO9ZFp3HRpS
	 HGCV9rY6kCXv58vGPETGfLERZyz5Ld9/U6ZTiv6iSZXXT2C3c8NevQ2ubT4nnRoxc9
	 MsN1GiN1QjYIfQmQZwznIXhGwuzd6V9Ic9Pc4okk2hAurMATW9rSiiiPRCwfj2zeGg
	 lrwLx9XNfY+6XvC9qKGFtd6zKac7ydScnqBIY0SivFtZKQSEDJDXgf1YoxvmqO4GQO
	 /18VHjnDDoHrzNmqx8n0j+jjXjUvzjUTk4DN1+JxIem31wbGrmRX0UBm4rlDLDbfLa
	 891VWBBMRneVA==
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Jul 2025 01:24:40 -0700
Subject: [PATCH RFC 10/25] PCI/LUO: Add pci_liveupdate_get_driver_data()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250728-luo-pci-v1-10-955b078dd653@kernel.org>
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

Similar to liveupdate_get_subsystem_data(), the PCI subsystem
provide pci_liveupdate_get_driver_data() for the driver to
receive the driver data during new kernel boot up, in the liveupdate
updated state.

This function  will return an error on any other liveupdate state.

For example, vfio-pci will use this API in probe() to access the
liveupdate state from the previous kernel.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c | 15 +++++++++++++++
 include/linux/pci.h      |  9 +++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 09faba99e9218b443f66060db5142208e22c7dd5..f84c0a455f7055b9b64051b125368fb0f9e6144f 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -406,6 +406,21 @@ void pci_liveupdate_restore(struct pci_dev *dev)
 			return pci_dev_do_restore(dev, s);
 }
 
+int pci_liveupdate_get_driver_data(struct pci_dev *pdev, u64 *data)
+{
+	struct dev_liveupdate *lu = &pdev->dev.lu;
+	struct pci_dev_ser *s = lu->dev_state;
+
+	if (!liveupdate_state_updated())
+		return -EINVAL;
+
+	if (!lu->dev_state)
+		return -ENOENT;
+
+	*data = s->driver_data;
+	return 0;
+}
+
 void pci_liveupdate_override_driver(struct pci_dev *dev)
 {
 	struct pci_dev_ser *s = dev->dev.lu.dev_state;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f39238f8b9ce08df97b384d1c1e89bbe..50296bb04aaa7f2bbd2260f8ec4670533e019e38 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2767,4 +2767,13 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 	WARN_ONCE(condition, "%s %s: " fmt, \
 		  dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
 
+#ifdef CONFIG_LIVEUPDATE
+int pci_liveupdate_get_driver_data(struct pci_dev *pdev, u64 *data);
+#else
+static inline int pci_liveupdate_get_driver_data(struct pci_dev *pdev,
+						 u64 *data)
+{
+	return 0;
+}
+#endif
 #endif /* LINUX_PCI_H */

-- 
2.50.1.487.gc89ff58d15-goog


