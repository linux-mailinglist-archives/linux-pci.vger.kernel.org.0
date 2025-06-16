Return-Path: <linux-pci+bounces-29885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C717ADB81D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 19:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D0F188D64D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF4B28AAEB;
	Mon, 16 Jun 2025 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7ow5wJg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB6828A737;
	Mon, 16 Jun 2025 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750096240; cv=none; b=fYWdi5/dh3afUUAisvUurr7gIRkyzLDdsxZAEh5sVeKmWwZjlJsu7WAxzaMFb/b3AOtrvTWSOdZnV+rN7m7wF4IncMc6NxCkGS34GQgk08jVf6Eea+JcYI+sIiekkgM0qDjQFiJAsSBFkhYGPTUMiWQbSl2eDSUX/ACC7Sc/3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750096240; c=relaxed/simple;
	bh=kzKMod4I7trzDSgNu24uRFQQmwK7y0+QIxuaSSqQlpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9Ti30IWSF9Ki1g1CK+OzKVu3JhxGwFNDhsq0UVFRTphq/nXOM3Li4fBkgocBjWKWvGB9Up/zDMJIbpqpjC1gm8If5fAs30baHZsQ/CGMmzfAFMP4N2VjnrMe296joxd5a8dREBNzOoP2D9LsHLYz+4WwR2mkafhqgpfo9be/84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7ow5wJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A46AC4CEF0;
	Mon, 16 Jun 2025 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750096240;
	bh=kzKMod4I7trzDSgNu24uRFQQmwK7y0+QIxuaSSqQlpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h7ow5wJgVkPm9yWdKVjD60KWlSRkSmm6cw/oTDox6/0rJnALyI2LzVVZmftnEbk1a
	 cj19J5s9m/xSEt0Q1lGfyisLPD/xhUWj3eJ09ZV7Cq2eDPmHpFKxV9ttKVAXRYO9xL
	 t3i75y+Zn+c41hwcIVmbXzN/gyJv/L/HXJ9RMmvRcJWAYVbn7Jsm+qspDe1DC5VhaI
	 cwuktwZSEI59MRvzFnWWFepW6VoI0xSUtYpv3awwFbio469BFaBdVvfj8WcGXMvj9t
	 TFKV9Aoh0KnDwKQtpZ/8VlqOm2A7m2x7gAcDDj2Nru3AaKfILw0lJ+N9Iz9jFs4TIV
	 bTShavQtFBzpQ==
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
Subject: [PATCH v4 5/5] usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
Date: Mon, 16 Jun 2025 12:50:19 -0500
Message-ID: <20250616175019.3471583-6-superm1@kernel.org>
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
v3: https://lore.kernel.org/linux-pm/20250609024619.407257-1-superm1@kernel.org/T/#me6db0fb946e3d604a8f3d455128844ed802c82bb
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


