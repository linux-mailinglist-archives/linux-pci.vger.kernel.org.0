Return-Path: <linux-pci+bounces-20734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68249A28AB6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 13:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F3C167A6B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 12:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2634623;
	Wed,  5 Feb 2025 12:52:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37F1CD0C;
	Wed,  5 Feb 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759942; cv=none; b=t0M+EddVDSKAzdOZYQL+GAIxvy0StTa9TE6uZwIGiYKiq3068LwSjzL9TI3e18h0IrAWPOvS03J1HZln8afZiuK+VUExVorkkH3t+JmGyIvgCJVwDJeZ0Ec39xupMs/bs+WlGaseaTz7jWerwMQJxGA51rIO3zzq2TBgvNx4pD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759942; c=relaxed/simple;
	bh=SJTPGDJemwijdL2MUWu/QoFG9zLYSanSXP5KBqj5cpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LFWQpQT3V0D30paQsLc7VM/UUsIwRKDnxCNWu3qfO7zgm+Dw5f845PfyA3TGX6TSELvo/cHKiAhYYm3wX6cnIOln29o+dfVrnJvI82LyGeeuX+qvjkJm3LBuLdaEH+YtxjhCYL9MlteTpkrcnE0KnwdPbZE9sNyKVOYvqRbmAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79D0F1007;
	Wed,  5 Feb 2025 04:52:43 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 129ED3F63F;
	Wed,  5 Feb 2025 04:52:18 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wei.huang2@amd.com
Subject: [PATCH] PCI/TPH: Restore TPH Requester Enable correctly
Date: Wed,  5 Feb 2025 12:52:13 +0000
Message-Id: <13118098116d7bce07aa20b8c52e28c7d1847246.1738759933.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we reenable TPH after changing a Steering Tag value, we need the
actual TPH Requester Enable value, not the ST Mode (which only happens
to work out by chance for non-extended TPH in interrupt vector mode).

Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
Spotted by inspection.
---
 drivers/pci/tph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 1e604fbbda65..07de59ca2ebf 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -360,7 +360,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
 		return err;
 	}
 
-	set_ctrl_reg_req_en(pdev, pdev->tph_mode);
+	set_ctrl_reg_req_en(pdev, pdev->tph_req_type);
 
 	pci_dbg(pdev, "set steering tag: %s table, index=%d, tag=%#04x\n",
 		(loc == PCI_TPH_LOC_MSIX) ? "MSI-X" : "ST", index, tag);
-- 
2.39.2.101.g768bb238c484.dirty


