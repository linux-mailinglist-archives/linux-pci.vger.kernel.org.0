Return-Path: <linux-pci+bounces-29157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A46DAD10E4
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jun 2025 05:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893627A5F92
	for <lists+linux-pci@lfdr.de>; Sun,  8 Jun 2025 03:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774962CCC5;
	Sun,  8 Jun 2025 03:33:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B591372;
	Sun,  8 Jun 2025 03:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749353598; cv=none; b=KXrSCQ4eT2woaz7My2iwmgpkPYa3Hq2Q4/N4BOuWU2ANaxp7G0Q9AjbpwHOwIQLBJW8GITdE1+KipHb64ky/j/5LdfxTUpdt/NhPFslssxOb6BBlNaQuDl/UCKBJWSqPmhIxR6LOeM1I2wKSr4JVq1MONrE/Yd0ZQtcJtSpjdj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749353598; c=relaxed/simple;
	bh=eht5tDWbXFu4zrv3T3ChtN5Vz7TQI86f13AacKXOrVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNANMZk0EpOSNoZxsesxiePhaEmtDwGup4HgWpyAMAnFCelfjCIRGgCJZ7ubHhGfuPwQHfOAV57GFk05QFNywX47ioFDNB4rtFzqxtNDjmpMANMeKJMAp8faNQSWtAv3UQ7Di8JKw+TRVWmQuXtmLNXZlkUCNJfbpRjemS/Sb3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD8FC4CEEF;
	Sun,  8 Jun 2025 03:33:15 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] PCI/PTM: Build debugfs code only if CONFIG_DEBUG_FS is enabled
Date: Sun,  8 Jun 2025 09:03:05 +0530
Message-ID: <20250608033305.15214-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise, the following build error will happen for CONFIG_DEBUG_FS=n &&
CONFIG_PCIE_PTM=y.

    drivers/pci/pcie/ptm.c:498:25: error: redefinition of 'pcie_ptm_create_debugfs'
      498 | struct pci_ptm_debugfs *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
          |                         ^
    ./include/linux/pci.h:1915:2: note: previous definition is here
     1915 | *pcie_ptm_create_debugfs(struct device *dev, void *pdata,
          |  ^
    drivers/pci/pcie/ptm.c:546:6: error: redefinition of 'pcie_ptm_destroy_debugfs'
      546 | void pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs)
          |      ^
    ./include/linux/pci.h:1918:1: note: previous definition is here
     1918 | pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs) { }
          |

Fixes: 132833405e61 ("PCI: Add debugfs support for exposing PTM context")
Reported-by: Eric Biggers <ebiggers@kernel.org>
Closes: https://lore.kernel.org/linux-pci/20250607025506.GA16607@sol
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/pcie/ptm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index ee5f615a9023..4bd73f038ffb 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -254,6 +254,7 @@ bool pcie_ptm_enabled(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pcie_ptm_enabled);
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
 static ssize_t context_update_write(struct file *file, const char __user *ubuf,
 			     size_t count, loff_t *ppos)
 {
@@ -552,3 +553,4 @@ void pcie_ptm_destroy_debugfs(struct pci_ptm_debugfs *ptm_debugfs)
 	debugfs_remove_recursive(ptm_debugfs->debugfs);
 }
 EXPORT_SYMBOL_GPL(pcie_ptm_destroy_debugfs);
+#endif
-- 
2.43.0


