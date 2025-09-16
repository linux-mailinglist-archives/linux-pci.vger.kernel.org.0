Return-Path: <linux-pci+bounces-36231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B58EB58F86
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 09:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927C31BC4CF7
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 07:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02A9283FC2;
	Tue, 16 Sep 2025 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inkYiJxx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7E28315D;
	Tue, 16 Sep 2025 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008721; cv=none; b=NPUAq9UfZKe5C6hmTpFFHdqxP2xsYwHm/PhxHIqoVbl030xaKKjjAxbNrfnbT/hOVje9zSOL4P3lSiLZFrByMBwzIn/gBciFwMZ9mwDV3384cfWZHhKHGHgzHTWDbx3WivnXsaHiZf0jZ8//BusmdpaD1ul3DP0igwjJcd6N37w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008721; c=relaxed/simple;
	bh=ruILf0f+2IGG4simAnF8+HVvvX3jTzt4/RPGtC8FTFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j1QgT5U/s6Ne1u51qMoX15H2JMH9b/+nvO5msoMpbwwaJxFbJV/X2xGgIDQ6+tgyDFTItTWvUsMoy8trW5Pa26/f845xFlGb537pXaUKief8bYf3+Dqa11KqevPH3RZBCe6Z2pf4Z2yEO2ZfPHkoXLoTEIytMC6C3bfj0VUV6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inkYiJxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9122C4AF09;
	Tue, 16 Sep 2025 07:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758008721;
	bh=ruILf0f+2IGG4simAnF8+HVvvX3jTzt4/RPGtC8FTFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=inkYiJxxixU8FzK+JezaaEYGBHOPiEfY43ZDFH413sF5U0C3yaFApc3x2iDdnVCKL
	 79zwtEz97JLJPUkxciW1TIN7+y+LO37xc2WtZ1xx7RzFqNYCuX7LciT0vOfhkEzDf7
	 1ndWiG0ailCvob7pkhvMRIye6cF1kTL/JvvwnFx3jTy8H3djXhXYgUpHTRUXEw/clD
	 KG3RXLd2YozJ3cNMaxAcsoS5nSh0ERWoEv2I4D4NVLlXuTJlsvH8pBXFm2XtcrIZmt
	 LJNFdKmkeAaU7HdXn41b7WXNaXa45L11ftptry+3JetADK1VT5EKU1Fs+70nPdNxP3
	 Q9e7zkRgB+oBw==
From: Chris Li <chrisl@kernel.org>
Date: Tue, 16 Sep 2025 00:45:16 -0700
Subject: [PATCH v2 08/10] PCI/LUO: Add pci_liveupdate_get_driver_data()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250916-luo-pci-v2-8-c494053c3c08@kernel.org>
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
index ae8f4dc5cf92577a4da83743c3b80bc72974a43e..1b12fc0649f479c6f45ffb26e6e3754f41054ea8 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -395,6 +395,21 @@ void pci_liveupdate_restore(struct pci_dev *dev)
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
2.51.0.384.g4c02a37b29-goog


