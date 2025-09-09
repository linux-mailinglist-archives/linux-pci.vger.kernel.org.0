Return-Path: <linux-pci+bounces-35753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AEEB5061E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 21:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64791C23B46
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 19:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D11301010;
	Tue,  9 Sep 2025 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tha22Vom"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BF63009E1;
	Tue,  9 Sep 2025 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445400; cv=none; b=blHiuMXNP9TlimujJYYmGhtqt8QHtAT97muvvpBl6mllEvemMkkoky913yCCtrWa2WIsEQIRSuBfcqf6RNi9zgGMgNOhgamiOH+z4qUNNXnM3EPVCdvQYKxtkiyK6UPlBCwk7ouTl0DUbWh9/R+T0uk4Vua7Tpi4fg2rhLPr+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445400; c=relaxed/simple;
	bh=nP9n5VGF2FskJeZ1oNEb2BbawXh/NPFp8tsiOD47chk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAPvZg0SYuwdD/gzARldq7zKL8MwOQPov/7pu88W1KgerYS6qBkjmXWXhRQAA581fzmWuX0WnF1jD+LojSebdsigqTxS69pnkLhNOAQjeVsTSnm9VAs1/AJ7ROhc6Ip1TPPEac5Spi+StH7PynRkAhJBXhgV/l+sTHYMLyfrC0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tha22Vom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941CEC4CEF4;
	Tue,  9 Sep 2025 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757445399;
	bh=nP9n5VGF2FskJeZ1oNEb2BbawXh/NPFp8tsiOD47chk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tha22VomXzKKVDuNMsYaaI/v4sKoE2TBohnaT1Kl90FdSl4ElBIns+GBpzpL9ZIqO
	 5LrGnCaxPAIl0sixS0v/qko2Odfkb5iDJTFeg51yTRy5tk2HKmheUWID1mVXcA1eSC
	 kafOmegbUsAGQmwrM7k8nr0x3Lfm3QCPzluT14+H4jU3YNVHMJR3QfFciouEgHqArw
	 6Z2EdHXT0/9uiX/VopJtSBSpWaNBMfHTZO/WNGlX3xjdwf1IjGMsQtzVCf0L2iKG9r
	 tsLsyAw2QiWkN4bAe6QEEkQ9DR6/DxTAoFYeWLCxar83LxxkEJ82myIYQiJs8f2yOQ
	 cJswWDh9xLc/A==
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
Subject: [PATCH v7 02/12] scsi: Add PM_EVENT_POWEROFF into suspend callbacks
Date: Tue,  9 Sep 2025 14:16:09 -0500
Message-ID: <20250909191619.2580169-3-superm1@kernel.org>
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

When the ACPI core uses hibernation callbacks for shutdown drivers
will receive PM_EVENT_POWEROFF and should handle it the same as
PM_EVENT_HIBERNATE would have been used.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v5:
 * Re-order
v4:
 * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
---
 drivers/scsi/mesh.c | 1 +
 drivers/scsi/stex.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
index 1c15cac41d805..768b85eecc8fd 100644
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -1762,6 +1762,7 @@ static int mesh_suspend(struct macio_dev *mdev, pm_message_t mesg)
 	case PM_EVENT_SUSPEND:
 	case PM_EVENT_HIBERNATE:
 	case PM_EVENT_FREEZE:
+	case PM_EVENT_POWEROFF:
 		break;
 	default:
 		return 0;
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 63ed7f9aaa937..ee9372e1f7f07 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -1965,6 +1965,7 @@ static int stex_choice_sleep_mic(struct st_hba *hba, pm_message_t state)
 	case PM_EVENT_SUSPEND:
 		return ST_S3;
 	case PM_EVENT_HIBERNATE:
+	case PM_EVENT_POWEROFF:
 		hba->msi_lock = 0;
 		return ST_S4;
 	default:
-- 
2.43.0


