Return-Path: <linux-pci+bounces-35606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD8FB470B0
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 16:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 832987B3A12
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 14:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7268C2F3616;
	Sat,  6 Sep 2025 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyJSEKbw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233B1F4615;
	Sat,  6 Sep 2025 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757169435; cv=none; b=NNRWcFxS3Q4g994ti05aE+HyqWzmzXvEOzc3KmvZfB2uGPNq42z3s1T4TzhYygsTPWtyAe2gDsqcEYtrj9d2n4aPHkMxybArLPMzAVzyxhgX4Pzp36UZNa5MQpwR4AZXFAnhQVxqSOKjmMryqnjCRrDg1XdYdo3WKSdaMIE5UxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757169435; c=relaxed/simple;
	bh=1i5HEoE6PHb6KQdOsJdeI9fhAnruv3cKTePhpGmwTAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GU6i63e41tanw5BjJ/WLJ9JQjy86FNloAeeA7nJTWnVGIKl4cwdVWgqFsmn+77vF1aGmvPol6waqyGXC0NvaINOXWkHdMUqGHhSLimMEzEboatvFxywOMFA34vwY2OhHOToa5GutQOaAzOZubJQlw5IyC//XcPjEnJ5Rr9Crm7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyJSEKbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC572C4CEF8;
	Sat,  6 Sep 2025 14:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757169434;
	bh=1i5HEoE6PHb6KQdOsJdeI9fhAnruv3cKTePhpGmwTAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GyJSEKbwBq4XAWPCBawQvs+Wk/oB5RrtkpPGACGS67kIrgIFavgpFYQAV/3Q/w9jO
	 T82hp5AzHTed51Il47LJtHZnyrm1sYTcThC0PDRAwPAfBdQ0OAGmYfuSMy0KmpSxbH
	 1sNtkkn0se3rQhuqXQ8bYcerS7ZaeCp4FexspigDQrMkzFxhwsCS/QTlOATclVRKc7
	 ylc7mVKXJTBv2xqnmPavM7dFq3zbAaIqQFzcyUnLItJGLrH1u5pAqYKzHhNC7L3P6B
	 WZOw90at7csyle5hJe4OXAp9lPWQv3kzvIWv3VpyV/r6xqfypPOt6VaUEZwN3IzkdO
	 Q8JSCK2hV/cUg==
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
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v6 RESEND 07/11] PCI: PM: Run bridge power up actions as part of restore phase
Date: Sat,  6 Sep 2025 09:36:38 -0500
Message-ID: <20250906143642.2590808-8-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906143642.2590808-1-superm1@kernel.org>
References: <20250906143642.2590808-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suspend resume actions will check the state of the device and whether
bus PM should be skipped.  These same actions make sense during hibernation
image restore.  Apply them there as well.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pci/pci-driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 571a3809f163a..fb6f1f60b2f1f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1246,10 +1246,15 @@ static int pci_pm_restore_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	pci_power_t prev_state = pci_dev->current_state;
+	bool skip_bus_pm = pci_dev->skip_bus_pm;
 
 	pci_pm_default_resume_early(pci_dev);
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
+	if (!skip_bus_pm && prev_state == PCI_D3cold)
+		pci_pm_bridge_power_up_actions(pci_dev);
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return 0;
 
-- 
2.43.0


