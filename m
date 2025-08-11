Return-Path: <linux-pci+bounces-33767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A4B21208
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 18:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08E318928BC
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1556B296BC4;
	Mon, 11 Aug 2025 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dy9ekQLR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242B296BC1;
	Mon, 11 Aug 2025 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929577; cv=none; b=egxaeAUyvkDGjh4I/LbH5ku9+w77Mx1Q2zexrjpPiq4lTNZvbFEfdVW07WHNVnrU1wEiEHpfAoG2M/6CWpdnkseK8i4oLCjgB8KVMPNxX2HSzPzrWNc2alMSZOL08aNYDo4fn7yMadWwwCEyPtcev7atB2j31myGLs+NSgsMRlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929577; c=relaxed/simple;
	bh=Uy45rFF3sSENBdoxYFFYHSypKn6OdyziyptjHlCs8G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjj1EHA/S3o8TCs3I34XDS0Epoq/M6uIAJb11Fnwa3glTiXO7RoOOGo2WaVhpAlfP4I2c9ON5H6Dho++d1FppWyLcjGG5wOc8Xlsirb7jw1Opby0pKz+G+ZRzfxkzWBzDRKyG2HxrUNm0EevLG6c1/7Jfd38JqgpsnFuoKM/zvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dy9ekQLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEE6C116D0;
	Mon, 11 Aug 2025 16:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754929576;
	bh=Uy45rFF3sSENBdoxYFFYHSypKn6OdyziyptjHlCs8G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dy9ekQLR6mkD5W85Bjo49dz/1HO73Li7IDAC8Ly4zTqjn6w5SMXnS3h65k4ymMQ8P
	 GQzfcTHFRNfz+FdAC0Som2Dvz4XPWPqrIGi4M1/SM3jRER3FaLRKF+79TAwCn8DZma
	 GuoltQeoSQU6uaFnh9gGrCvarsLTcfyX7z0Go2a1x0/MRPCTvhocHdWmttL5yi8lD4
	 oGY8ECiolEWrqtLXNhIb2jvsGE/yWDOWWDMkTvjcjw7yG33snK6UqxhEsWP/aLIVLP
	 rwMfXb/mny/Z+cZQAVSOYRik8mqtkQF+6AAoDiDIkTZSGjSpJoUURU5KdqDodD+15s
	 wWMpDmV8auuVA==
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
Subject: [PATCH v10 3/4] fbcon: Use screen info to find primary device
Date: Mon, 11 Aug 2025 11:26:05 -0500
Message-ID: <20250811162606.587759-4-superm1@kernel.org>
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

On systems with non VGA GPUs fbcon can't find the primary GPU because
video_is_primary_device() only checks the VGA arbiter.

Add a screen info check to video_is_primary_device() so that callers
can get accurate data on such systems.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v10:
 * Rebase on 6.17-rc1
 * Squash 'fbcon: Stop using screen_info_pci_dev()'
---
 arch/x86/video/video-common.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
index 81fc97a2a837a..e0aeee99bc99e 100644
--- a/arch/x86/video/video-common.c
+++ b/arch/x86/video/video-common.c
@@ -9,6 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/screen_info.h>
 #include <linux/vgaarb.h>
 
 #include <asm/video.h>
@@ -27,6 +28,11 @@ EXPORT_SYMBOL(pgprot_framebuffer);
 
 bool video_is_primary_device(struct device *dev)
 {
+#ifdef CONFIG_SCREEN_INFO
+	struct screen_info *si = &screen_info;
+	struct resource res[SCREEN_INFO_MAX_RESOURCES];
+	ssize_t i, numres;
+#endif
 	struct pci_dev *pdev;
 
 	if (!dev_is_pci(dev))
@@ -34,7 +40,24 @@ bool video_is_primary_device(struct device *dev)
 
 	pdev = to_pci_dev(dev);
 
-	return (pdev == vga_default_device());
+	if (!pci_is_display(pdev))
+		return false;
+
+	if (pdev == vga_default_device())
+		return true;
+
+#ifdef CONFIG_SCREEN_INFO
+	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
+	for (i = 0; i < numres; ++i) {
+		if (!(res[i].flags & IORESOURCE_MEM))
+			continue;
+
+		if (pci_find_resource(pdev, &res[i]))
+			return true;
+	}
+#endif
+
+	return false;
 }
 EXPORT_SYMBOL(video_is_primary_device);
 
-- 
2.43.0


