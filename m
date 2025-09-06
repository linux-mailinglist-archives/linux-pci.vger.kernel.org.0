Return-Path: <linux-pci+bounces-35604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7D2B470A6
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 16:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACDE7C18DD
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17F31F4162;
	Sat,  6 Sep 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUNiJ0rq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986511F462C;
	Sat,  6 Sep 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757169430; cv=none; b=bzqMLdKzrLNbnFKO7+dGGVs0szUQefJ5/gbSM7abEi5eLFkdaqlF25h++gu+hcWMHmNT74aGJ7cQg+N4x/wVC6i5tEPlnqMYE3nMTIzik4yEb+rNkrOHKorNFMHjj6R/aZWqnX8Ml3DYHLxrUiHr3MgCWCZokefEvdv2nXuQKKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757169430; c=relaxed/simple;
	bh=gEhVcdfHmARzAI1nxkb/sOlulPpWTjfsshzz5cygmTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ss34pM23oTmu2YH9/YshVSKQOgb+q271UCORvlgxSI6qo/KMadWQ+6O4MXwPh/XwAQg3g8r04okDdXnNNcl+bGQ4xFecxZpZvIEqs6lXbUn3xEYPNs63O76j6yk0mjujmcsWcQFggPUkWFcxo6lxFhHfjVHrRryG1Ai9GWgfIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUNiJ0rq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922EEC4CEF8;
	Sat,  6 Sep 2025 14:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757169430;
	bh=gEhVcdfHmARzAI1nxkb/sOlulPpWTjfsshzz5cygmTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUNiJ0rqi+dvjIoqO5HHnEHBqo48X/A1jZJ7JnGJiBYXHyfHC+tjxul6Lwbx6MrWG
	 96a3HVWEezBLLRqWM3jfHpAu8Iaz5Lr5LrgO2qkmfmjcIB36RJL8NpLSh5gJ52KjnE
	 W97HBXi11FLeCJTKnTfbePRU2t4YLwOO2vuhRaDPf9PDAmvAgGecrCHiLz7iGS6lXS
	 jugUqukj8XowRnYg8akft98jerIN+GDnfgw6eafQHIVxjnQhSoTfhfi+0XrvRuHFAS
	 KJUhpCPaOEjqn+T7bOSrzie5EV8gJxcgKLvz7qpMgUoY83nXJvgPNTMpTo7JAdkOSa
	 3oulahNrOhdZw==
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
Subject: [PATCH v6 RESEND 05/11] PCI: PM: Disable device wakeups when halting system through S4 flow
Date: Sat,  6 Sep 2025 09:36:36 -0500
Message-ID: <20250906143642.2590808-6-superm1@kernel.org>
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

PCI devices can be programmed as a wakeup source from low power states
by sysfs.  However when using the S4 flow to go into S5 these wakeup
sources should be disabled to avoid what users would perceive as
spurious wakeup events.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pci/pci-driver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 63665240ae87f..f201d298d7173 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1139,6 +1139,10 @@ static int pci_pm_poweroff(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
+	if (device_may_wakeup(dev) &&
+	    (system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF))
+		device_set_wakeup_enable(dev, false);
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
-- 
2.43.0


