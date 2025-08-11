Return-Path: <linux-pci+bounces-33765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C59FB2124B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 18:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F5D2A4B26
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C431A9FB1;
	Mon, 11 Aug 2025 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLawpBrg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71C1A9FAA;
	Mon, 11 Aug 2025 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929574; cv=none; b=bhlaLApf/TbvAAk5/ETtBVALfthJg3g9qJH21gn6iXtwjf/pe35oTm7nMbc1l9Fy9yExRAsPnUTKJQMRKBgUw+/ory5rGOYWN3BlHmw/lpnAuAu7T0X60Y4Ewk0ijUquGEh+I5RM+nuwiqa2WtkZrSS+mqD2mFA+o/a6UQsQdls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929574; c=relaxed/simple;
	bh=uFYe+G36sd4L7j61HsBQZ7yPuWGZRAjmRmKIjuj/FEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLf9w2y3TM0x48ThEhQdSTiHPjaYONXN/Bl/o6rclb6SHbj9c8NmU/Jfc/6z0ov+Nbq9b3Qub46ZiIsCi5HVsIB9GaJ69eVkKA1EgBcVFKHjiJYYu6i09dSb9moft/h44fF8YJ5ui4nowtO0uTT79QX1rLl/HnRQY71chhPXFRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLawpBrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BD7C4CEF4;
	Mon, 11 Aug 2025 16:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754929573;
	bh=uFYe+G36sd4L7j61HsBQZ7yPuWGZRAjmRmKIjuj/FEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dLawpBrgoiOKtfh3SIlQtUgQLdnoyaOslY3yx2+bBBD9L2BUoNc0eK6W7A4mFItmR
	 NwPyFT8A8TrAoEGCybsGx9q9slb+Fj3EdaRwRVHnVF+4lkQkJg77Am/kMk7EIeXHeA
	 e1JXknwxu6ffHq7rb2UQlRhVG0qY/fUFZVtMTgAS4PNaPxLxzixun879GJ31tzrxJA
	 xslpItQbqzGV1aEqzXlup/oukASsjeenHFPakvVxtUaBX1RLv9rxuekB+57g34q4ei
	 yxEhdio5t741m2+r2DHqFhilO+j3/ts/P7KKGo9Zu3rGnWf6Nn7QRYiyTmEF0BZCzw
	 /PymKN3kKgDiQ==
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
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v10 1/4] Fix access to video_is_primary_device() when compiled without CONFIG_VIDEO
Date: Mon, 11 Aug 2025 11:26:03 -0500
Message-ID: <20250811162606.587759-2-superm1@kernel.org>
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

When compiled without CONFIG_VIDEO the architecture specific
implementations of video_is_primary_device() include prototypes and
assume that video-common.c will be linked. Guard against this so that the
fallback inline implementation that returns false will be used when
compiled without CONFIG_VIDEO.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506221312.49Fy1aNA-lkp@intel.com/
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v10:
 * Rebase on 6.17-rc1
v5:
 * add tag
v4:
 * new patch
---
 arch/parisc/include/asm/video.h | 2 +-
 arch/sparc/include/asm/video.h  | 2 ++
 arch/x86/include/asm/video.h    | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/video.h b/arch/parisc/include/asm/video.h
index c5dff3223194a..a9d50ebd6e769 100644
--- a/arch/parisc/include/asm/video.h
+++ b/arch/parisc/include/asm/video.h
@@ -6,7 +6,7 @@
 
 struct device;
 
-#if defined(CONFIG_STI_CORE)
+#if defined(CONFIG_STI_CORE) && defined(CONFIG_VIDEO)
 bool video_is_primary_device(struct device *dev);
 #define video_is_primary_device video_is_primary_device
 #endif
diff --git a/arch/sparc/include/asm/video.h b/arch/sparc/include/asm/video.h
index a6f48f52db584..773717b6d4914 100644
--- a/arch/sparc/include/asm/video.h
+++ b/arch/sparc/include/asm/video.h
@@ -19,8 +19,10 @@ static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
 #define pgprot_framebuffer pgprot_framebuffer
 #endif
 
+#ifdef CONFIG_VIDEO
 bool video_is_primary_device(struct device *dev);
 #define video_is_primary_device video_is_primary_device
+#endif
 
 static inline void fb_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
 {
diff --git a/arch/x86/include/asm/video.h b/arch/x86/include/asm/video.h
index 0950c9535fae9..08ec328203ef8 100644
--- a/arch/x86/include/asm/video.h
+++ b/arch/x86/include/asm/video.h
@@ -13,8 +13,10 @@ pgprot_t pgprot_framebuffer(pgprot_t prot,
 			    unsigned long offset);
 #define pgprot_framebuffer pgprot_framebuffer
 
+#ifdef CONFIG_VIDEO
 bool video_is_primary_device(struct device *dev);
 #define video_is_primary_device video_is_primary_device
+#endif
 
 #include <asm-generic/video.h>
 
-- 
2.43.0


