Return-Path: <linux-pci+bounces-37897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A4EBD3514
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 15:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09843C6B27
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 13:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80CE233D85;
	Mon, 13 Oct 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qElfThJP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E621D3EE
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363976; cv=none; b=t/OXYTSb6T6+wADZ5HRgVIdqvdC1JLsdZB6qjAkf3RowNTrMq/HTdrtGyY/GIuyniwR51UPqYOxPvroB08mSavb1IaM5taP0zDcLwOzXMCJxgBNvHWLRenJaZTOSEEqzEwgn9+PfzIm5+vMC8J7qDN392IHT/cr8DMahI5oA/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363976; c=relaxed/simple;
	bh=Lh127QS4YIOw1UEPBOiMQfa8mZMtKtth/ie4S10Yi+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=grUyYRf/NQY4fQltj4Fo5FYIOzHiYHxyblDDRML5YRtYrCCZC4WQXfl59B/bmJOleafTbMmS593r1DbdvB+TvDAH+2BFNVBxvnNk80gpp/pYo5aLSCwQ+R+g82EcbaBVUsW7EczTp7me8UdtH1GFC8IZsd/C85an61ILdCzIDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qElfThJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C91C4CEE7;
	Mon, 13 Oct 2025 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760363976;
	bh=Lh127QS4YIOw1UEPBOiMQfa8mZMtKtth/ie4S10Yi+w=;
	h=From:To:Cc:Subject:Date:From;
	b=qElfThJPvWwEfcM48T4mggDua3gkWT7N9+0fi9xWFwhtxhUt8czH9XO225sr+zLv5
	 O3MkKgci/oEzmH8wQB2O5jOB8KV2pMR0m/FlpUssqyZYAKS6JsA35zsZFGMW51hafy
	 CkURHKt/Kzy6d1wzsr7IJnz/jaP5ti0Jcw3/y+DXN591xrPy6Qxm13GnJmxJazm84w
	 oGSyM1BAOm7aecuhwY953pxw2Ukxt7pUmrk9hFpDluL3bGwXQkTfrj7YgBFSFXySNs
	 /iFxiy9DOb0gs0JNyng/x17KluFgHIo/hJ0x4WVwAAouQSwkJBX9sI6G4PXI2NkJ8i
	 48KyscY9U5riQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com,
	superm1@kernel.org,
	tzimmermann@suse.de
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/VGA: Select SCREEN_INFO
Date: Mon, 13 Oct 2025 08:59:28 -0500
Message-ID: <20251013135929.913441-1-superm1@kernel.org>
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
VGA arbiter works as intended.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Closes: https://lore.kernel.org/linux-pci/20251012182302.GA3412@sol/
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 337bf13aa9dda ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.43.0


