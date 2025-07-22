Return-Path: <linux-pci+bounces-32758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94392B0E59A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 23:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7960D189F7EF
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 21:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10EE27EC7C;
	Tue, 22 Jul 2025 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqLpx53M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934427CB04;
	Tue, 22 Jul 2025 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220273; cv=none; b=AM5fKumUuvLJAp3GYy4B/HbvUeTQu1yqYgIgiiGd+p0kHy+xd0DyMz/QCgBPMK2RI9aP7xx2CDDFINbW0Td8mhn7zXZGJR8D42Nm3CpNyLVQR4dPOjiqADol8PdF0pDx+Q90tR8iWGu+OLd728329/sIvVhmy/vZYGonKYNK2LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220273; c=relaxed/simple;
	bh=4EuaGBavEjWDJrhPhMou/dnGF54p27LtPVgtBCiF2hI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=heK7uHV8ZITPTZpFuaH7586uZ+hFPrSMnzEAt61WMbO9SiGdBVBln5B6pyE4gGuMVXMrSJLn5i7dAqbNSVI7eowHzRt16eecmXrRrYloguQnanLimMCdcpqRBdgRFQSyaBNhlPwhZr7seXR8mMSyZj/KBBa2XdrmjfDpiJcWY34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqLpx53M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE118C4CEEB;
	Tue, 22 Jul 2025 21:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753220272;
	bh=4EuaGBavEjWDJrhPhMou/dnGF54p27LtPVgtBCiF2hI=;
	h=From:To:Cc:Subject:Date:From;
	b=TqLpx53M9w8kIMrqFSAAW+NG5/n53jywiByn4AwB6rqhDkhwS22lKYw8RwRXvhLhk
	 ZUxWdQeSg9g0DjKNcmGSJN8MJkieTBXfeDbnxLlDi1gZkbvBPMN6uxCTQBAM128kcU
	 tXU2q9/P5nTDE/opKyMCpfLI4Byj0NeRFwFNrWI4G8zGOZVh6teLd+25vrqgbLiRlZ
	 3EWhjHqoi9KyLdIYyRJC7uEjUqOT5CqXsjj6NqFoHHF/tgTAKVVbdRa4BB3mU8kS4m
	 A6DLTOx8SShW1HbQgpkLAbWKCR0ksGsgZDyVMFf6UC+PQmOdhZwJjh1YvHvoJ22zVk
	 8QanVQCBhcLCA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Fix typos
Date: Tue, 22 Jul 2025 16:37:34 -0500
Message-ID: <20250722213743.2822761-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 drivers/pci/msi/msi.c                 | 2 +-
 drivers/pci/pcie/ptm.c                | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 92887b394eb4..4d59ce231a64 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -970,7 +970,7 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
 	 *
 	 * The PCIe host controller by design must set the inbound viewport to
 	 * be a contiguous arrangement of all of the system's memory.  In
-	 * addition, its size mut be a power of two.  To further complicate
+	 * addition, its size must be a power of two.  To further complicate
 	 * matters, the viewport must start on a pcie-address that is aligned
 	 * on a multiple of its size.  If a portion of the viewport does not
 	 * represent system memory -- e.g. 3GB of memory requires a 4GB
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 6ede55a7c5e6..7683635261e0 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -941,7 +941,7 @@ int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
 	/*
 	 * This is a horrible hack, but short of implementing a PCI
 	 * specific interrupt chip callback and a huge pile of
-	 * infrastructure, this is the minor nuissance. It provides the
+	 * infrastructure, this is the minor nuisance. It provides the
 	 * protection against concurrent operations on this entry and keeps
 	 * the control word cache in sync.
 	 */
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index ee5f615a9023..b5103448eb4d 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -506,7 +506,7 @@ struct pci_ptm_debugfs *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
 	if (!ops->check_capability)
 		return NULL;
 
-	/* Check for PTM capability before creating debugfs attrbutes */
+	/* Check for PTM capability before creating debugfs attributes */
 	ret = ops->check_capability(pdata);
 	if (!ret) {
 		dev_dbg(dev, "PTM capability not present\n");
-- 
2.43.0


