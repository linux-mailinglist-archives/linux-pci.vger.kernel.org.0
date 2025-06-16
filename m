Return-Path: <linux-pci+bounces-29884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F6BADB818
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 19:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346FE188F78F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E68D28A1F5;
	Mon, 16 Jun 2025 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qH6frSV8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A728A1EB;
	Mon, 16 Jun 2025 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750096239; cv=none; b=FTzuXMnIryiKCeAB1xjw8SpvoM0v2X5rLT6YefF4JGKmjZXRdvOTUq2zZTs9ZzTtlGkWD85NYxNs1TzSjBdKxh6NWIqNkaKUFuLQF1rm3u0HUcLSveA9SiSKkewS3k1qITzzR+sdg/b/pAAy4pRYxw4L/h+/fUl34EGNd4Ouyek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750096239; c=relaxed/simple;
	bh=JZ6ILTv0NyimVcIwJeioVSlHa7xlaGtlYECv3UsX1hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liEUGkhHryt787alcTZvm50ITC9XxfaMOXgISSVU3dZtiJ4sDn9wJ0sxIAk5w00+9aeuZh1jL9ji9QbCa6F4oDOvNSMf8Yj8OtnYa69S73kzEyotnw0mOgKXkIYIWk3SqeEsNeCyc/qcwsqVbzM5FS20540da+sLvl3/5qnJH0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qH6frSV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0FAC4CEF4;
	Mon, 16 Jun 2025 17:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750096238;
	bh=JZ6ILTv0NyimVcIwJeioVSlHa7xlaGtlYECv3UsX1hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qH6frSV8FE/GEWzUE0vxDVUeBLP7CHPlBfqhOBWWJe9x4PgchIl3xQeGzLoCf255i
	 3//oFBtEog43y3VqJIYpztcYh6mVa71tox5D1tpZJ477YcYL72GtxUFcfHvJlLkhXF
	 nyTLlXoUThjg4UoRw40i56/t3R5eDwN9YRIINOA3tszaVPDgoLVnRq9VfXvBwoYnZR
	 gXrYkhl2E932Nu4tedFJ72AFiMWuXoUMx9NnL5GEYzqo2l6D8t7U/kLC53OHvheYNT
	 HzW+gpx7regu4HKI06LE1OHuRxMLu23bw35Of5kxtQ3wWxowjtI6ZrTs5qTx+7j2ZV
	 13u1iWFmoKnow==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 4/5] scsi: Add PM_EVENT_POWEROFF into suspend callbacks
Date: Mon, 16 Jun 2025 12:50:18 -0500
Message-ID: <20250616175019.3471583-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616175019.3471583-1-superm1@kernel.org>
References: <20250616175019.3471583-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When the ACPI core uses hibernation callbacks for shutdown drivers
will receive PM_EVENT_POWEROFF and should handle it the same as
PM_EVENT_HIBERNATE would have been used.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * New patch
 * https://lore.kernel.org/linux-pm/20250609024619.407257-1-superm1@kernel.org/T/#me6db0fb946e3d604a8f3d455128844ed802c82bb
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


