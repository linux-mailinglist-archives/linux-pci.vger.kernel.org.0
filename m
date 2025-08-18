Return-Path: <linux-pci+bounces-34152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE84B29699
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 04:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FF5202D85
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 02:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593BA23E32B;
	Mon, 18 Aug 2025 02:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGfB0X89"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D9D221FBD;
	Mon, 18 Aug 2025 02:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755482479; cv=none; b=rMb/3bd35O8SbLVeZyR9TQzfsYtuxbGt8oxksQJcr+oh1QYFY3OKbdLAnj5ceHx5GNEwszaDn66Uy9o7QNSrnodJrt/t6zQKTaEbuHw0RmRzvAtxHM49IoPuQPU0S+g2wax4qaUAm64gfraWCLY4o7FsAtC/ud6mUsFF1cwooU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755482479; c=relaxed/simple;
	bh=0L8ILI5VlxDH9DgDwEiUXlzII6qULtClGxRZoPNq2oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9NDHaUhS95DsVx8LhMm5QDT42PMGAPubfgQkrx5JWbzIL/pIgybEh8K2zCUQWKGW0jQTb1ynSdEPH34dgYaPqz6CLgUBLmpjYrZjUOg4eAIVwwyx3xF6lXSMj0CZrX2cgFzyTDK+ChTier+9uqyHWXcS+7Z6d7QgIrcZCzWaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGfB0X89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E63C116C6;
	Mon, 18 Aug 2025 02:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755482478;
	bh=0L8ILI5VlxDH9DgDwEiUXlzII6qULtClGxRZoPNq2oQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SGfB0X89biQmOHnG1yCRVMNo+hV8TnW+piPVRSJlEss/44kZmvpLndawpa0efYNuL
	 Fg3S9JGHqQFLOzJs3nTfiDvJe/UPtmlDaFRhw9W3dzHjXMHAdKs67F4iLju9aXaM7u
	 NkU0yUYqtAELPMEtGlUSpxgyRGoe9FLpr8JS32GQLmD+LaQTsI/GxzCmymcwmut2GW
	 hZGfps3IeRFz46VOaml614tzFWKiPHOAOZL1vUymV0RZs919X9mtaDQl21SSaX5Gwj
	 rAm2zelBNM5lxdBl3vGMDCj6ZIynpKlG3CUlu3oIq6Yr5Z9akObCQ0af32qq+wZ0CZ
	 9/hP70QdqYznw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
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
Subject: [PATCH v6 03/11] usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
Date: Sun, 17 Aug 2025 21:00:53 -0500
Message-ID: <20250818020101.3619237-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818020101.3619237-1-superm1@kernel.org>
References: <20250818020101.3619237-1-superm1@kernel.org>
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
 * Add tags
v4:
 * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
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


