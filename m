Return-Path: <linux-pci+bounces-33766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE87B21238
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 18:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004E23E159F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF58311C1D;
	Mon, 11 Aug 2025 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOk9zvjI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA42475F7;
	Mon, 11 Aug 2025 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929575; cv=none; b=R38OKQY2fgbBgPDh+F3oALG8+t9xmeWqGVF1OXZ+TUVx6Q2hxFSx+AD9hXlA1uI2/8j6E7PUZ4XBx8mTmnNWzfZtxUF8BMazZO0MDDfX04Fe1oT/3Pl9FNrjX9827ZlDjJ+H0Uq46G4+/AiNO82RGS0RbPBhMGbmmYxMIzuYOXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929575; c=relaxed/simple;
	bh=3qWKQM0HeorWqsuGJKtJ97sthSR1l4jtNX1BHSpBD1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2PDCanTojlx5UnJ13tq3r/926uK4qKNnQKaYG+7CMafWjyRivrdeQ/FivtQluCYjbk0DWFPyp4jJOJP/c0O4JNidU4Ertg0HSl97I8GhP6U/43n63MXyRoVrQkgI9o94oIsC7hDAMg9tFYmkRDDQw+WslrwjysBIqRjB6E/eX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOk9zvjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26C9C4CEF8;
	Mon, 11 Aug 2025 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754929575;
	bh=3qWKQM0HeorWqsuGJKtJ97sthSR1l4jtNX1BHSpBD1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YOk9zvjI403VpTO2HOJ64iKT6OeNpu0nCB2AK2EvA4q+UAc/taaEHbm6M0S8r/Asn
	 ESm1wZ8m8CcBIe3RCrFuk5taAeBXUPia44525IAPKom/B5NemGwFXe6fsSxxV+0ayZ
	 dpPbn+a8rTgfnwh6myX/LjYwa+bRBXr9Q99SBdGOJptXd4XaVdTAl68fOEDWGJgHdK
	 GziqtMtCCXkFMa3ubGoAxbWUcUJvcY6VWIJxvwUbd1MFLTRREcmZTHlHLC1+azKeYp
	 fdugt0DypSFz5eKM1CUN42LST8V26IrqWmq/J1j4Mqy9t3hMMS4XDIxnEWAIwUclL7
	 Bu1R/3Y6IL3Lw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: David Airlie <airlied@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	Daniel Dadap <ddadap@nvidia.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v10 2/4] PCI/VGA: Replace vga_is_firmware_default() with a screen info check
Date: Mon, 11 Aug 2025 11:26:04 -0500
Message-ID: <20250811162606.587759-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811162606.587759-1-superm1@kernel.org>
References: <20250811162606.587759-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vga_is_firmware_default() checks firmware resources to find the owner
framebuffer resources to find the firmware PCI device.  This is an
open coded implementation of screen_info_pci_dev().  Switch to using
screen_info_pci_dev() instead.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v10:
 * Rebase on 6.17-rc1
---
 drivers/pci/vgaarb.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 78748e8d2dbae..b58f94ee48916 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -556,34 +556,13 @@ EXPORT_SYMBOL(vga_put);
 
 static bool vga_is_firmware_default(struct pci_dev *pdev)
 {
-#if defined(CONFIG_X86)
-	u64 base = screen_info.lfb_base;
-	u64 size = screen_info.lfb_size;
-	struct resource *r;
-	u64 limit;
+#ifdef CONFIG_SCREEN_INFO
+	struct screen_info *si = &screen_info;
 
-	/* Select the device owning the boot framebuffer if there is one */
-
-	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		base |= (u64)screen_info.ext_lfb_base << 32;
-
-	limit = base + size;
-
-	/* Does firmware framebuffer belong to us? */
-	pci_dev_for_each_resource(pdev, r) {
-		if (resource_type(r) != IORESOURCE_MEM)
-			continue;
-
-		if (!r->start || !r->end)
-			continue;
-
-		if (base < r->start || limit >= r->end)
-			continue;
-
-		return true;
-	}
-#endif
+	return pdev == screen_info_pci_dev(si);
+#else
 	return false;
+#endif
 }
 
 static bool vga_arb_integrated_gpu(struct device *dev)
-- 
2.43.0


