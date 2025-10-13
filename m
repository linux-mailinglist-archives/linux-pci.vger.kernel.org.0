Return-Path: <linux-pci+bounces-37991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0470ABD6930
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 00:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08333425840
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 22:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357A2FC87E;
	Mon, 13 Oct 2025 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgzO1yAp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E93C2FB994
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760393317; cv=none; b=dZ/b0zHGac/531sCZNfP+jEHdwkSjxuRyReWl26y+uzlvPAy9aEZIHj/aUpJzUBaGumZCTk2fN2THz+1yLbAOJh4a5byI6T7dxncRLbkbEzRLa1EEfqBU/6AsceV3mcdLegHXVRguqwAzXKcmBlICQtyVvRIBeN9W+nEgocdWjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760393317; c=relaxed/simple;
	bh=piQEhMzlpmHIZlJUCGpNzeQ5J0I8lLCNdwUNi88u+PI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CdOzZKbHKJL8iwOiuOKgW6ouQIOKZ2oe1f5DEnbhR/0l1OAGX7KrKWN3m1yA8wQ31dD0enUgzUerD+/uj0zQueKGmLahrN/i2OEQYaQyAdeeZ1cqaOrb6UgghCtBt4vptjnLDqEb/T/worYTH7lmpDlczm2YZkpiMMNf7mvdo6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgzO1yAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0035C4CEE7;
	Mon, 13 Oct 2025 22:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760393316;
	bh=piQEhMzlpmHIZlJUCGpNzeQ5J0I8lLCNdwUNi88u+PI=;
	h=From:To:Cc:Subject:Date:From;
	b=QgzO1yApMOnzMFZSyUKPAVPfDA95pB9jb1bhMOUmBq+TWBmixKBgx04CY5u9KXJt6
	 CJ1hhhAO+U8k475OEJGVoi8XbJ8D9QpUqcEzGhH74t3tw5/DRVJKMn5C0dUqPKIf0d
	 YsQnSYAM/6SQv9eV1CM3v7hgZqQQQ9sUq/kpNihuymM9ODAQ1fllkHLKTq8LSBhb4A
	 Vjw3cuKOau/ztnxcAymSJA0MV3yFD9lFttVpH5jwllkJMK5FOBOvd7kesehJb3xqhu
	 Lz0VXw5dci3KQiZ3QY1U5DhgbI1Uy0NQWtaxI67UoV/HuFvPZD3sYzwKYX7p2qxFgu
	 kIFOeWmxpnxvg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com,
	tzimmermann@suse.de,
	superm1@kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3] PCI/VGA: Select SCREEN_INFO on X86
Date: Mon, 13 Oct 2025 17:08:26 -0500
Message-ID: <20251013220829.1536292-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with
a screen info check") introduced an implicit dependency upon SCREEN_INFO
by removing the open coded implementation.

If a user didn't have CONFIG_SCREEN_INFO set vga_is_firmware_default()
would now return false.  SCREEN_INFO is only used on X86 so add add a
conditional select for SCREEN_INFO to ensure that the VGA arbiter works
as intended.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pci/Kconfig  | 1 +
 drivers/pci/vgaarb.c | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 7065a8e5f9b14..f94f5d384362e 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -306,6 +306,7 @@ config VGA_ARB
 	bool "VGA Arbitration" if EXPERT
 	default y
 	depends on (PCI && !S390)
+	select SCREEN_INFO if X86
 	help
 	  Some "legacy" VGA devices implemented on PCI typically have the same
 	  hard-decoded addresses as they did on ISA. When multiple PCI devices
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index b58f94ee48916..436fa7f4c3873 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -556,10 +556,8 @@ EXPORT_SYMBOL(vga_put);
 
 static bool vga_is_firmware_default(struct pci_dev *pdev)
 {
-#ifdef CONFIG_SCREEN_INFO
-	struct screen_info *si = &screen_info;
-
-	return pdev == screen_info_pci_dev(si);
+#if defined CONFIG_X86
+	return pdev == screen_info_pci_dev(&screen_info);
 #else
 	return false;
 #endif
-- 
2.43.0


