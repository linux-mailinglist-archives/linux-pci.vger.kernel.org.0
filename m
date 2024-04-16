Return-Path: <linux-pci+bounces-6303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D844A8A626D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 06:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10BF4B226AE
	for <lists+linux-pci@lfdr.de>; Tue, 16 Apr 2024 04:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0672C19E;
	Tue, 16 Apr 2024 04:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HVSM+zjo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5C427715;
	Tue, 16 Apr 2024 04:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242021; cv=none; b=qJh6htR0fFMHOB05uOl/hz/vrQ5Igs1UFZpHH9x42wmlOcF37HQP08Cm5YOU2QKOXGTpvWiaUO711EhdaW/RBFPeIUjVqzYhyE2uFy3kEO3pYNDNoWgWmG912y+SkMWGIJb/nw+Tn/QfVZvgRCjK85tkFP+GDrgsczynUG5/Dr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242021; c=relaxed/simple;
	bh=fvKbBzyiYhgU7w3T3uMR6HIuVJIfj599ikHMznByMFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j/0T/Fut4uy4xwwe/mAw68fYgjahiu9ZDmwVo1OclwqUE4hYdWHCgXVfesAz8GeO95lT8FtYO7+muM5Y/r80iYwCe2JFgfJRsPQJQE9m8jhR/BWpX1zy/YR/eAiRzSVV5MLgmUI+sFFExU1+cCgn9A+mNeBeMYIGCRzNQ04S05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HVSM+zjo; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 967B740B81;
	Tue, 16 Apr 2024 04:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713242017;
	bh=UKp3++ga9pwOFwfl9SX2I6VDxPYriu1Ld2SUETczxGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=HVSM+zjoih8kwdzAuFBkJV2cPYIwRhYPOwAILzUUKOxOs2S6WamM4+DSseiYTl7Ub
	 sjM/XvtIglSMtgEcAtxZK1BphiT80MMW8qckz+uDLyip/Dfna435NZYLQsXGuABpDw
	 45FO5eBgstUKt2atiemkYGev6LytrI7FsR2B2GH3y4ePFdbFcUjmlDOb7AW6KB+jia
	 tCm8E28ZtJKTf7LNAi0rpIp8pGVEsCvnfRg1uBWJrIkJ+nUxXOVWGLPYhdEjXUKtGX
	 6R5A/VxDwA4OA7Tw93nBLNnIZ8bUhThFtiLXRVwpkwKmI7lrsYrFOxX1WvGjXkKUp/
	 85JVXVLr39SWg==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com
Cc: mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bagasdotme@gmail.com,
	regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	kch@nvidia.com,
	hch@lst.de,
	gloriouseggroll@gmail.com,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@suse.de,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v8 3/3] PCI/DPC: Disable DPC service on suspend
Date: Tue, 16 Apr 2024 12:32:25 +0800
Message-Id: <20240416043225.1462548-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416043225.1462548-1-kai.heng.feng@canonical.com>
References: <20240416043225.1462548-1-kai.heng.feng@canonical.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the power rail gets cut off, the hardware can create some electric
noise on the link that triggers AER. If IRQ is shared between AER with
PME, such AER noise will cause a spurious wakeup on system suspend.

When the power rail gets back, the firmware of the device resets itself
and can create unexpected behavior like sending PTM messages. If DPC is
enabled, the DPC reset happens before driver's resume routine. The DPC
reset usually fails because the device is not in the right state, and
the resume also fails because the device is being reset by hardware. If
the scenario happens to device like NVMe, it means the whole system
resume fails.

As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power
Management", TLP and DLLP transmission are disabled for a Link in L2/L3
Ready (D3hot), L2 (D3cold with aux power) and L3 (D3cold) states. So if
the power will be turned off during suspend process, disable DPC service
and re-enable it during the resume process. This should not affect the
basic functionality.

Furthermore, since DPC depends on AER to function, and AER is disabled
in previous patch, also disable DPC here.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=209149
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218090
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v8:
 - Wording.
 - Add more bug reports.

v7:
 - Wording.
 - Disable DPC completely (again) if power will be turned off

v6:
v5:
 - Wording.

v4:
v3:
 - No change.

v2:
 - Only disable DPC IRQ.
 - No more check on PME IRQ#.

 drivers/pci/pcie/dpc.c | 57 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a668820696dc..7682ac4d6a89 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/suspend.h>
 
 #include "portdrv.h"
 #include "../pci.h"
@@ -412,13 +413,34 @@ void pci_dpc_init(struct pci_dev *pdev)
 	}
 }
 
+static void dpc_enable(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	u16 ctl;
+
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
+	ctl &= ~PCI_EXP_DPC_CTL_EN_MASK;
+	ctl |= PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+}
+
+static void dpc_disable(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	u16 ctl;
+
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
+	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+}
+
 #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
 static int dpc_probe(struct pcie_device *dev)
 {
 	struct pci_dev *pdev = dev->port;
 	struct device *device = &dev->device;
 	int status;
-	u16 ctl, cap;
+	u16 cap;
 
 	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
 		return -ENOTSUPP;
@@ -433,11 +455,7 @@ static int dpc_probe(struct pcie_device *dev)
 	}
 
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
-
-	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
-	ctl &= ~PCI_EXP_DPC_CTL_EN_MASK;
-	ctl |= PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
-	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+	dpc_enable(dev);
 
 	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
 	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
@@ -450,14 +468,29 @@ static int dpc_probe(struct pcie_device *dev)
 	return status;
 }
 
-static void dpc_remove(struct pcie_device *dev)
+static int dpc_suspend(struct pcie_device *dev)
 {
 	struct pci_dev *pdev = dev->port;
-	u16 ctl;
 
-	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
-	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
-	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+	if (pci_ancestor_pr3_present(pdev) || pm_suspend_via_firmware())
+		dpc_disable(dev);
+
+	return 0;
+}
+
+static int dpc_resume(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+
+	if (pci_ancestor_pr3_present(pdev) || pm_resume_via_firmware())
+		dpc_enable(dev);
+
+	return 0;
+}
+
+static void dpc_remove(struct pcie_device *dev)
+{
+	dpc_disable(dev);
 }
 
 static struct pcie_port_service_driver dpcdriver = {
@@ -465,6 +498,8 @@ static struct pcie_port_service_driver dpcdriver = {
 	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
+	.suspend	= dpc_suspend,
+	.resume		= dpc_resume,
 	.remove		= dpc_remove,
 };
 
-- 
2.34.1


