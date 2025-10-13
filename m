Return-Path: <linux-pci+bounces-37928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E9FBD5251
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 18:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30A04836C5
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C2F26E6F6;
	Mon, 13 Oct 2025 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itQRh3Gc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA0B27055F
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370286; cv=none; b=II7HvvkaVbuzClgxzYM3aoRrNa7bNK63v+v8Vwkey/hA2Yg4sqlvljlHPxl0nu0/atJng5NR8molfRLiAg7Y4Xqk8gKfUiY0H+AeehcbXrylX5kgYT1WgGlUqahCMeyncxIlpCPV/G6qyjmLjCysLCupu+LkEO60kFPjVmUPOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370286; c=relaxed/simple;
	bh=v8gVje8y7mwbbzBI0CEjTGhfPmhqtnINkr6KWrJuvW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQkkZRSWqETb8P7efbWUuc5pO9MeyvGUiI+B19LR0NqDQCdykg0iJVklc5rmhLTg9BAj/DMuZykEcrtabEya/FzLhxJ/JUn+EeUaRvLZLnHdxd3J9uwSenHqVNA8IQH4RNgrFZUYihxE9k/v7IgJxQ2JEKy4Z2CiqhZX3Hpu0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itQRh3Gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07926C116B1;
	Mon, 13 Oct 2025 15:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760370286;
	bh=v8gVje8y7mwbbzBI0CEjTGhfPmhqtnINkr6KWrJuvW4=;
	h=From:To:Cc:Subject:Date:From;
	b=itQRh3Gcck5BFPD+mkzhg/RQ/ogNsQUiNWI2G+cAa0bh6HUK+t+Oju6qtCFNBARRs
	 Xa4B++wBrXf5ZEU9zg6t9YHfwC/pMVUWV13E31XF6++g1e3Q6Q04myE3TCuLe3RWQ1
	 x1pOC6ZKpgdvT03DSWzWCIng0NSY9cdv/MAYytyfFBJIoytm0FqyxStPrJXXDSfUkW
	 c9ovZDDcIxYYfBjuCf0pnl+VgqaA3J4R+Xro9JJqknwkEmAnaF3cXB3GzgHLMu7mZ3
	 hlDoSiCbAg3P+NTwL3DGV6fz0ntqmPbCpIiDrV9KpSK3dDAZs0+QlqGVsE4mLmWnfN
	 KUidA68OeVebw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com,
	superm1@kernel.org,
	tzimmermann@suse.de
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI/VGA: Select SCREEN_INFO
Date: Mon, 13 Oct 2025 10:44:23 -0500
Message-ID: <20251013154441.1000875-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
a screen info check") introduced an implicit dependency upon SCREEN_INFO
by removing the open coded implementation.

If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_default()
would now return false.  Add a select for SCREEN_INFO to ensure that the
VGA arbiter works as intended. Also drop the now dead code.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v2:
 * drop dead code (Ilpo)
---
 drivers/pci/Kconfig  | 1 +
 drivers/pci/vgaarb.c | 8 +-------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 7065a8e5f9b14..c35fed47addd5 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -306,6 +306,7 @@ config VGA_ARB
 	bool "VGA Arbitration" if EXPERT
 	default y
 	depends on (PCI && !S390)
+	select SCREEN_INFO
 	help
 	  Some "legacy" VGA devices implemented on PCI typically have the same
 	  hard-decoded addresses as they did on ISA. When multiple PCI devices
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index b58f94ee48916..8c8c420ff5b55 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -556,13 +556,7 @@ EXPORT_SYMBOL(vga_put);
 
 static bool vga_is_firmware_default(struct pci_dev *pdev)
 {
-#ifdef CONFIG_SCREEN_INFO
-	struct screen_info *si = &screen_info;
-
-	return pdev == screen_info_pci_dev(si);
-#else
-	return false;
-#endif
+	return pdev == screen_info_pci_dev(&screen_info);
 }
 
 static bool vga_arb_integrated_gpu(struct device *dev)
-- 
2.43.0


