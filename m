Return-Path: <linux-pci+bounces-26733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D41D4A9C483
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 11:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A017A7145
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 09:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B49238D27;
	Fri, 25 Apr 2025 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Jehkz7ub"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6D82367A7;
	Fri, 25 Apr 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575129; cv=none; b=FOhuYXgp8PA/lz1FFcg1q+YggMUhupqUdI6PeBVqXaftwmCbWmdiCPTaxxMMmQ71oguw1DfCShdAU/cvDAR8nV6b/GmsA56ZNwZCCHuNbmcBluGB8KdLWOjKa8u0AwegOS/yqQ2PeF4ksdyVK9XNOP5TOIbfS0P9AjveKvMnRQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575129; c=relaxed/simple;
	bh=a5Q2NDtt9juFbbGm6oBY4b2wE1/JswxDiFchnEZWsHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NNff2yFhPUuCGsl8bsxxvMH8sNc97ugWWmPZSzn1iBLiayixMiGiI/pkyhWz10Iz0MbnKnZ+Ml15fl09fGsg/yp27bll8cdhjwEYym6Jpvh2hhBCDed+/huy8P6itMc20TjdayGq4hbSiqwQ7aEZGtEcviwE4r4BiRQbk9ilFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Jehkz7ub; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xmLII
	sSXZlE0yxGj02mf0oBCyw8RS0RVRfp2xWsIfpc=; b=Jehkz7ubRygGolxPxQNMg
	IcYsez6GN8mfFRtntr2kdYWZZL9Mf4Ws8fTuBicJ2wzAm6aAfXAk3Arew7yZjCx9
	0V4tO6BIsp3/cNDwrs2rcnWdDFjVQyDXSlmhsgYNBlpofAyO8OQeq3t9R7TbZNfM
	zQIrlFpvQQA/2+FIGlGpZ0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnfJt2XAtowU4iAw--.17018S3;
	Fri, 25 Apr 2025 17:57:14 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de,
	thomas.petazzoni@bootlin.com,
	manivannan.sadhasivam@linaro.org,
	yue.wang@Amlogic.com
Cc: pali@kernel.org,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 1/2] PCI: Configure root port MPS to hardware maximum during host probing
Date: Fri, 25 Apr 2025 17:57:07 +0800
Message-Id: <20250425095708.32662-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250425095708.32662-1-18255117159@163.com>
References: <20250425095708.32662-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnfJt2XAtowU4iAw--.17018S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw1rKw18Cw47Wr1ftFWUurg_yoW5Jw1Upa
	yYkw48Jr48Gry3Wa1kt3Wv9rWYqFn5CrW3trZ8XwnIv3W5Aa4jqrW2ka1rXF97GFZayryY
	qr4qqFyUuanYvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziZYFAUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhI6o2gLWelYOwABsA

Current PCIe initialization logic may leave root ports operating with
non-optimal Maximum Payload Size (MPS) settings. While downstream device
configuration is handled during bus enumeration, root port MPS values
inherited from firmware or hardware defaults might not utilize the full
capabilities supported by the controller hardware. This can result in
suboptimal data transfer efficiency across the PCIe hierarchy.

During host controller probing phase, when PCIe bus tuning is enabled,
the implementation now configures root port MPS settings to their
hardware-supported maximum values. By iterating through bridge devices
under the root bus and identifying PCIe root ports, each port's MPS is set
to 128 << pcie_mpss to match the device's maximum supported payload size.
The Max Read Request Size (MRRS) is subsequently adjusted through existing
companion logic to maintain compatibility with PCIe specifications.

Explicit initialization at host probing stage ensures consistent PCIe
topology configuration before downstream devices perform their own MPS
negotiations. This proactive approach addresses platform-specific
requirements where controller drivers depend on properly initialized root
port settings, while maintaining backward compatibility through
PCIE_BUS_TUNE_OFF conditional checks. Hardware capabilities are fully
utilized without altering existing device negotiation behaviors.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/probe.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a514f8..3973c593fdcf 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3206,6 +3206,7 @@ EXPORT_SYMBOL_GPL(pci_create_root_bus);
 int pci_host_probe(struct pci_host_bridge *bridge)
 {
 	struct pci_bus *bus, *child;
+	struct pci_dev *dev;
 	int ret;
 
 	pci_lock_rescan_remove();
@@ -3228,6 +3229,17 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	 */
 	pci_assign_unassigned_root_bus_resources(bus);
 
+	if (pcie_bus_config != PCIE_BUS_TUNE_OFF) {
+		/* Configure root ports MPS to be MPSS by default */
+		for_each_pci_bridge(dev, bus) {
+			if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
+				continue;
+
+			pcie_write_mps(dev, 128 << dev->pcie_mpss);
+			pcie_write_mrrs(dev);
+		}
+	}
+
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
 
-- 
2.25.1


