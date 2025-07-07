Return-Path: <linux-pci+bounces-31629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93652AFB96B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 19:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F411317424E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C249C22DF9E;
	Mon,  7 Jul 2025 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNrMiErM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9CF2264A0
	for <linux-pci@vger.kernel.org>; Mon,  7 Jul 2025 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907860; cv=none; b=YTLC4kspVWskwz9xJnypJcuhzzTg9ts/g7z4TrwwTTJSuxtbHTgpylzCd0twVXeBAEqFWMXGG9PmVFLVUniIWmjRRQPPTWdSRGpswdUgbQOxzE6DXOyVkBJRjwfEkxqumCOHhTpCt+8TjHEpd4jcjp9XaEL+oG+jqVWoWlwtMSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907860; c=relaxed/simple;
	bh=LFPf5j1dTwiYI98UPWSw5Yke7PmDgeBKnydW+hMRlpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M53SaLzDwNbJ4TI/Jzu4lqZg36RFolr8bLcPOJRS2Rpp2O/LvPwZ9nGjl2VTYqHMKXX1I39HSx5hBpv4fsyNR7pgcOdcJOBluTkBlJftKRwc4tI0TxqGZdZE8Nz9bItGYwoExvt+o3mrzCe3VP5yGWggKNl8flUMaOBnEnCCSoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNrMiErM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D149AC4CEF1;
	Mon,  7 Jul 2025 17:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751907857;
	bh=LFPf5j1dTwiYI98UPWSw5Yke7PmDgeBKnydW+hMRlpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BNrMiErMX06JyWoqjcJSBlJBZoPFVhQgUYVj/TjBwF5cGv5XF788C3dNcJes+vOQM
	 s5wb8s/rtKB3xVRjwk5SaROS3yj5PCAhoVzQkZlPhLzlsNV0FJbxzJS7qT/g1yeNvX
	 pqIZMStp4FwKGRdczHD2FbsikWuoSAe/qx22z3NuSj2tDrbB2YCUf1JeH56S6A4nm4
	 /05Ay64uDt74p0qNFw9r1rhdqFvjC1bz5G6a4AZbfN0FQU781DmUJJBD5S5hY5uEsF
	 DZ4xArXwK7ZBZgDw7fy3RDgYm343fZpTLzejFBBs6QTXClNm1zKS7Yj3n8U9aXXIq+
	 vHELVHgA/y2Ow==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH rdma-next 1/8] pci/tph: Expose pcie_tph_get_st_table_size()
Date: Mon,  7 Jul 2025 20:03:01 +0300
Message-ID: <bb2b18f612dc99bb46c9f5c2690013aeddeacca8.1751907231.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751907231.git.leon@kernel.org>
References: <cover.1751907231.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

Expose pcie_tph_get_st_table_size() to be used by drivers as will be
done in the next patch from the series.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/tph.c       | 11 ++++++-----
 include/linux/pci-tph.h |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 77fce5e1b830..cc64f93709a4 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -168,7 +168,7 @@ static u32 get_st_table_loc(struct pci_dev *pdev)
  * Return the size of ST table. If ST table is not in TPH Requester Extended
  * Capability space, return 0. Otherwise return the ST Table Size + 1.
  */
-static u16 get_st_table_size(struct pci_dev *pdev)
+u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 {
 	u32 reg;
 	u32 loc;
@@ -185,6 +185,7 @@ static u16 get_st_table_size(struct pci_dev *pdev)
 
 	return FIELD_GET(PCI_TPH_CAP_ST_MASK, reg) + 1;
 }
+EXPORT_SYMBOL(pcie_tph_get_st_table_size);
 
 /* Return device's Root Port completer capability */
 static u8 get_rp_completer_type(struct pci_dev *pdev)
@@ -211,7 +212,7 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
 	int offset;
 
 	/* Check if index is out of bound */
-	st_table_size = get_st_table_size(pdev);
+	st_table_size = pcie_tph_get_st_table_size(pdev);
 	if (index >= st_table_size)
 		return -ENXIO;
 
@@ -443,7 +444,7 @@ void pci_restore_tph_state(struct pci_dev *pdev)
 	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, *cap++);
 	st_entry = (u16 *)cap;
 	offset = PCI_TPH_BASE_SIZEOF;
-	num_entries = get_st_table_size(pdev);
+	num_entries = pcie_tph_get_st_table_size(pdev);
 	for (i = 0; i < num_entries; i++) {
 		pci_write_config_word(pdev, pdev->tph_cap + offset,
 				      *st_entry++);
@@ -475,7 +476,7 @@ void pci_save_tph_state(struct pci_dev *pdev)
 	/* Save all ST entries in extended capability structure */
 	st_entry = (u16 *)cap;
 	offset = PCI_TPH_BASE_SIZEOF;
-	num_entries = get_st_table_size(pdev);
+	num_entries = pcie_tph_get_st_table_size(pdev);
 	for (i = 0; i < num_entries; i++) {
 		pci_read_config_word(pdev, pdev->tph_cap + offset,
 				     st_entry++);
@@ -499,7 +500,7 @@ void pci_tph_init(struct pci_dev *pdev)
 	if (!pdev->tph_cap)
 		return;
 
-	num_entries = get_st_table_size(pdev);
+	num_entries = pcie_tph_get_st_table_size(pdev);
 	save_size = sizeof(u32) + num_entries * sizeof(u16);
 	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
 }
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index c3e806c13d64..9e4e331b1603 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -28,6 +28,7 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
 			unsigned int cpu_uid, u16 *tag);
 void pcie_disable_tph(struct pci_dev *pdev);
 int pcie_enable_tph(struct pci_dev *pdev, int mode);
+u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 #else
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
-- 
2.50.0


