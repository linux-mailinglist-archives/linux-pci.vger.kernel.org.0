Return-Path: <linux-pci+bounces-35756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB097B5062B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 21:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797B24E34BC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 19:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADE5318129;
	Tue,  9 Sep 2025 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oqy2acDF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC492FFDDB;
	Tue,  9 Sep 2025 19:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445409; cv=none; b=Aq8z9yVsx+fxNhYFVkuvlZNL62RBHSrkuR4m2QICm0C9tRHAi/yhH1h5xGGfw4+B69fvRqD9bvVIowPHLb8CujBArgmPyh0BIfIyP2TONX++tdsWqek1E+LrPGiNsvWPze/1t6OTk1wLedeCi09xSqsIpIxBV+HsEDKCCgr5QTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445409; c=relaxed/simple;
	bh=y7k8d5jsVOd5phy+8g1xjAepVVLhhoJ0pLaQErosHyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKRA8LWPBxK5Oi3gjhWbcL5h/w9vW2suZFY4lsaDpwDLSVAjAn5AIMcMVtO7NcIhxEW6lHcFmvoM2WdWxTrj+6fkvD/FTivpMNevIduA8BgwDsK2luDGlEzFEPKkyDGMnlz5JCWyj/T+iqVHuqQ0d/KIPDL47eKTlr07L8v4VlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oqy2acDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888B1C4CEF8;
	Tue,  9 Sep 2025 19:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757445407;
	bh=y7k8d5jsVOd5phy+8g1xjAepVVLhhoJ0pLaQErosHyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oqy2acDFLLQ7TKxBJvobhopBzu4swVkadBsaWgR0PPzvouttEATGkAF0lWjPDY54b
	 9PK2ZqzgNehftAQs2amwVwkYZVPt6MypQZJKi8+eofOzi377x74dCcsI7qCJqY5s3I
	 V/S56UXvLVxEp+G9sS0rX8+DND2ToS47tH3gN2oe26HlYw1MCdENitEDKwBolIIfRf
	 G4YgfhWnd+K3plxBBDXfhbtv6iwcyoJlzjG5/WPMXb3knvC3QaHR1Tfk+h/jUk5hlY
	 eJquGigeKu3fhUmolrPUj0henzU6KYnQjJDO3fjDlO4H/Gg+2j2YjMVI/FTV8THhCL
	 W3o1QIcU2qZXw==
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
Subject: [PATCH v7 05/12] PCI/PM: Disable device wakeups when halting or powering off system
Date: Tue,  9 Sep 2025 14:16:12 -0500
Message-ID: <20250909191619.2580169-6-superm1@kernel.org>
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

PCI devices can be configured as wakeup sources from low power states.
However, when the system is halting or powering off such wakeups are
not expected and may lead to spurious behavior.

ACPI r6.5, section 16.1.5 notes:

    "Hardware does allow a transition to S0 due to power button press
     or a Remote Start."

This implies that wakeups from PCI devices should not be relied upon
in these states. To align with this expectation and avoid unintended
wakeups, disable device wakeup capability during these transitions.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v7:
 * Reword title
 * Reword commit
v5:
 * Re-order
 * Add tags
v4:
 * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
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


