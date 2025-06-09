Return-Path: <linux-pci+bounces-29194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CD9AD172C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 04:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0032F1888A27
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 02:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E55A24BC07;
	Mon,  9 Jun 2025 02:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZvKR70r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E310624BBFC;
	Mon,  9 Jun 2025 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749437207; cv=none; b=ocKW8SGCDnK+6SYuIHhbu7nfvKePN4Mp7nAwskxVgksia5V/CV1ihS/dmVHCv+dUA2h9a85SfOGGUkJogtAF3O7uBzhj8YRhXgddt0TMOM05uAlC0bs8t4E7UAyIkdMHvDlpNXpFivfX0a8zCKmloG63MpbUQc6hJQk8xD70Ldg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749437207; c=relaxed/simple;
	bh=kU6/5PrnoLPvsSRESMinNLoRD724Pj4qIwsER9avoT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jR8oXmZbDbaAPxp3eCoAHPQ5FntdHuUGEU+9ttqn/1EUkVUC0wsFJFXOnAIbQXZusv4kx6LdPvm+80qZavvmfLly1bgOyIatHTcJEs+mP7xhV2Z2UMA8mEYWXbmRjq3fvAivibokbgdRwWtYMdeDr0GFHOmtwpynNnjKKSyAD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZvKR70r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18763C4CEF5;
	Mon,  9 Jun 2025 02:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749437205;
	bh=kU6/5PrnoLPvsSRESMinNLoRD724Pj4qIwsER9avoT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UZvKR70rBdP3dlik5UAP5m+f8VYflYUmi6Tv6l+mEvoC6VJoRyzu72O2599XlVn6o
	 lTbUVQVIXEEJ5cIkl8pyOEmdDI0u+JD3VgxZdsCcuspODUmLpVKUQeOYStOAqyfGXi
	 8+hE9sFcPQSXmOwE2dZ7B+78khv437ikXt8MvsaU+SCwJv3ERtK89bUgI8FyUURrln
	 9Z93cSsv/BfCw9XgQWzpUOo3PHl8nMgL9M6EjIAT/aUDdd0bjtam5aFsMD7tA7tN6y
	 IrtbehRzta/vL2J+cYTVxEnBuZIm84+eMthlOe9pjxOuqjTjeqSwvMXcScVRtb8dbN
	 QdaudT+cjQWow==
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
Subject: [PATCH v3 5/5] usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
Date: Sun,  8 Jun 2025 21:46:19 -0500
Message-ID: <20250609024619.407257-6-superm1@kernel.org>
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
 drivers/usb/host/sl811-hcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index ea3cab99c5d40..5d6dba681e503 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1748,6 +1748,7 @@ sl811h_suspend(struct platform_device *dev, pm_message_t state)
 		break;
 	case PM_EVENT_SUSPEND:
 	case PM_EVENT_HIBERNATE:
+	case PM_EVENT_POWEROFF:
 	case PM_EVENT_PRETHAW:		/* explicitly discard hw state */
 		port_power(sl811, 0);
 		break;
-- 
2.43.0


