Return-Path: <linux-pci+bounces-35755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ED5B5064B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 21:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7E07B22D8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 19:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E650734F497;
	Tue,  9 Sep 2025 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8OCkK/k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DFE1531F9;
	Tue,  9 Sep 2025 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445405; cv=none; b=dpTDCqbjDdp2NSjYcFLz6T3JyB4/l2s2Nav8O841i2REKxvqW/4FOm5LIoTv0myZDDVPHc0/rxYOlhPRT9/Z1UQCm9d2glHjBhH+r2bqbTypxZn2vVfSRTsaIDx9KEmwEbTgrDKfg8eKGWv80vSJzm3X/9gXbgyJXbCus0O+BjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445405; c=relaxed/simple;
	bh=Gi7TAFmyKWLsGJiQRhzYB7164rEc624qwBmsJLMUCyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YqkACX/5DGbGIU81lLjOlqBKb46ak6Tt7PqW+IM6ju4zU1KjlT043OJC8J48AjwJn7oHNLmn8NSAFr6vopy2kLcD9fIrh/Mwpo62Z7pNE/bfNVaU7pW4sO5PF+/XH122GbwRg7qVTDXdRENB3GG5k8BHwR0tRzsdsqrYpe2qJ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8OCkK/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F38C4CEF4;
	Tue,  9 Sep 2025 19:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757445405;
	bh=Gi7TAFmyKWLsGJiQRhzYB7164rEc624qwBmsJLMUCyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s8OCkK/kWB/AyQXcON8slx09Yc2bY3r2Rsg5I4dSHkp2G7U4nm7jlkGPIS++u4zIs
	 yRjR2uRqTK0mSNQmxywVszC8jITq8gIUDYvwLuEKXs+zP7MtNq2Clv/6+BerF3FWYq
	 pihsiu4JIXfEjjFzCbMuSfwezW+FB/Nx6OFN+4T0I3gTwmYP/6P/ZI0xGjagRBwOFm
	 mkPo1sQC/zKks1PQ33CXHY5jztSVlBMbpGuTKJ1Xr+zwEm4vWuLBs3y6IgRo+K1FjY
	 C+alVJ4fs4iqZAx44zN9PWOA75MVuO3pUJAbaHhNIfk79J4b+IuP4KfLAGN0QehBjC
	 gqeNZdBUYSZIQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	linux-trace-kernel@vger.kernel.org (open list:TRACING),
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v7 04/12] USB: Pass PMSG_POWEROFF event to suspend_common()
Date: Tue,  9 Sep 2025 14:16:11 -0500
Message-ID: <20250909191619.2580169-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909191619.2580169-1-superm1@kernel.org>
References: <20250909191619.2580169-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If powering off the system USB wakeup sources should be ignored.
Add a new callback hcd_pci_poweroff() which will differentiate whether
target state is halt or power off and pass PMSG_POWEROFF as the
message so that suspend_common() will avoid doing wakeups.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v7:
 * Reword commit mesasge
v6:
 * Fix LKP robot issue without CONFIG_PM_SLEEP
v5:
 * New patch
v4:
 * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/

Fix lkp robot issue
---
 drivers/usb/core/hcd-pci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index cd223475917ef..921d1d0940016 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pm.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 
@@ -531,6 +532,13 @@ static int hcd_pci_freeze(struct device *dev)
 	return suspend_common(dev, PMSG_FREEZE);
 }
 
+static int hcd_pci_poweroff(struct device *dev)
+{
+	if (system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF)
+		return suspend_common(dev, PMSG_POWEROFF);
+	return suspend_common(dev, PMSG_SUSPEND);
+}
+
 static int hcd_pci_suspend_noirq(struct device *dev)
 {
 	struct pci_dev		*pci_dev = to_pci_dev(dev);
@@ -602,6 +610,7 @@ static int hcd_pci_restore(struct device *dev)
 #define hcd_pci_suspend		NULL
 #define hcd_pci_freeze			NULL
 #define hcd_pci_suspend_noirq	NULL
+#define hcd_pci_poweroff	NULL
 #define hcd_pci_poweroff_late	NULL
 #define hcd_pci_resume_noirq	NULL
 #define hcd_pci_resume		NULL
@@ -639,7 +648,7 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
 	.freeze_noirq	= check_root_hub_suspended,
 	.thaw_noirq	= NULL,
 	.thaw		= hcd_pci_resume,
-	.poweroff	= hcd_pci_suspend,
+	.poweroff	= hcd_pci_poweroff,
 	.poweroff_late	= hcd_pci_poweroff_late,
 	.poweroff_noirq	= hcd_pci_suspend_noirq,
 	.restore_noirq	= hcd_pci_resume_noirq,
-- 
2.43.0


