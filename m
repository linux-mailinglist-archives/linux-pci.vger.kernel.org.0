Return-Path: <linux-pci+bounces-29841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AFAADAB01
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 10:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94945188E7CF
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 08:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04B426D4D0;
	Mon, 16 Jun 2025 08:44:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8217F20D4F8;
	Mon, 16 Jun 2025 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750063488; cv=none; b=ZFXyf6tDHGTMCRVlXJJh3wfgaYwStg43vRv6+8zTvwykzn/CbEz9RaP2nRJyiIsCJwzJoQWJNMPwLMJl26OUKHIv30A074C+Dun+4AyasAnLX1rPxRgsxkbM444ZpQVWokEUMP/lW5yWS+iuk7zHbYs92dkNc8tiC5CMTABcJTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750063488; c=relaxed/simple;
	bh=JHFm4OQiSuNkSNbxKgW7+3HLF75dme7NUdtwX0vWLnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cll9tmjrCKh++oziBkRSRHmwtAXci423RsNfUBjtHhj24qB5Rx3HbWxTWwMNblkmvPgUGYyCNgNNNBWdqpbBSoCSMs4+nb4rrAydPqyCr5qVUkhdvmuoe2EF3Av3D2VQ4fZkwO1Muu1CLEDs4s3+5NYvf0R3m4/D19VQThuImKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from qiao.. (unknown [210.73.43.2])
	by APP-05 (Coremail) with SMTP id zQCowAAnsA5q2U9o_G72Bg--.56606S2;
	Mon, 16 Jun 2025 16:44:27 +0800 (CST)
From: Zhe Qiao <qiaozhe@iscas.ac.cn>
To: sashal@kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	qiaozhe@iscas.ac.cn
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH] PCI/ACPI: Fix double free bug in pci_acpi_scan_root() function
Date: Mon, 16 Jun 2025 16:44:20 +0800
Message-ID: <20250616084420.526381-1-qiaozhe@iscas.ac.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnsA5q2U9o_G72Bg--.56606S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw1rtw18KryDtw4ftw17GFg_yoWkKFg_CF
	98Wr17Gr4UKr45Gw43K3yfJFWFk3Z7WFn7WFsrKa9xCa4xGr15u3Z7Jrs3Xry3Gw4qkF9x
	Cw1DXr18Cw1IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUjrgA7UUUUU==
X-CM-SenderInfo: ptld061kh6x2xfdvhtffof0/

Fix the double free bug introduced in the patch "PCI/ACPI: Fix
allocated memory release on error in pci_acpi_scan_root()".

Fixes: 631b2af2f357 ("PCI/ACPI: Fix allocated memory release on error in pci_acpi_scan_root()")
Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
---
 drivers/pci/pci-acpi.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index b78e0e417324..49b72596ae37 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1653,15 +1653,7 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
 }
 
 /* release_info: free resources allocated by init_info */
-static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
-{
-	struct acpi_pci_generic_root_info *ri;
-
-	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
-	pci_ecam_free(ri->cfg);
-	kfree(ci->ops);
-	kfree(ri);
-}
+static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci) {}
 
 /* Interface called from ACPI code to setup PCI host controller */
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-- 
2.43.0


