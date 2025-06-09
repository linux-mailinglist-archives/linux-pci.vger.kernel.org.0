Return-Path: <linux-pci+bounces-29193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFA0AD1725
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 04:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288A63A6E10
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 02:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3170A248F7D;
	Mon,  9 Jun 2025 02:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOYZtfjn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04620248F75;
	Mon,  9 Jun 2025 02:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749437204; cv=none; b=qIinu+IYl/sOu9upMO5232DXRBv1bidUesFrpJFicEuvR+wVfTHjkAoNmmqILArLYTXL+9mzWBbBvEKP6sM0X6eUwamPmadzjMjyW/k6RoTSvW9K6SXmlg5P0Ziy6JRUKfkPQLv7w9Ifr+ns4+u4pgpsrdmAhsIOtj2nml1MU4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749437204; c=relaxed/simple;
	bh=OloXrw3xRIAtL6oQ+ic+cZq3x0zPylu+4Y8fZrphD2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRoXIc39xFcaTTdUS8JGZWOzpgLEXSpqpAZM7KncnevcOYgj+Fg1JjrXFOHSGURB5d3G2yvHEv7641w5HsVcFsaa+R7X2B1D0DtnjLpvvvGRWJFUNYP7bb5FwXE14C4x9Xi7nE/m+FJD0QRPAUUdMQ3jqwp5eiJfa1bxvhFwS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOYZtfjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB40C4CEEE;
	Mon,  9 Jun 2025 02:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749437203;
	bh=OloXrw3xRIAtL6oQ+ic+cZq3x0zPylu+4Y8fZrphD2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iOYZtfjnX7mRmNhehMbarMUyvinQ1IZmG62gX2LMonv9S+oOssImBrb39ii7EpCFd
	 fb7eCQ4QLwAGMBWvXmeXT1PU7Bf5+juQs9383AgXBguhl2MkpQUqXQTiHQJI+h/TC3
	 41W5B4REpqzJ/92N3o0UUtSOf+OmqsgIMvD5SGoMTGz5KcnZd9EAiDvk9Jsp+A5WCo
	 ZBrB2Kvzc4MhCuvnSj+CP8dCNmahOn1L2kXNyePN1HgLzIp3Ory/9uLNyJwl36+Ehx
	 OfS/NvULqOdvcksibsgFrJ2Ty7FPqXP/hmbW/MeSTnV3ogSYn46vJYLlcDtDvPmwh3
	 mQITDbkIEmPoQ==
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
Subject: [PATCH v3 4/5] scsi: Add PM_EVENT_POWEROFF into suspend callbacks
Date: Sun,  8 Jun 2025 21:46:18 -0500
Message-ID: <20250609024619.407257-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609024619.407257-1-superm1@kernel.org>
References: <20250609024619.407257-1-superm1@kernel.org>
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


