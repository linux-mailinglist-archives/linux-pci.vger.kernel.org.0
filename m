Return-Path: <linux-pci+bounces-35602-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9ECB470A0
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 16:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E49C87B20D0
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38B91C863B;
	Sat,  6 Sep 2025 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMBoVB+a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D50366;
	Sat,  6 Sep 2025 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757169426; cv=none; b=oIPwO23Y8h1GAefCrPLF2GSOFQgE4CQwj6lrDcn5tKGQJtaU7RPcaKVdd+eTsBz67plmHUqw9wQcED7auYKNA0BrVYpjBZfnae45gxe8hA1kpPsVbRAGrxOwhHdbBI0/Iq1lb5thzntdMMkDBG95g1GTz1bb0buVH0BzTGTdRDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757169426; c=relaxed/simple;
	bh=vMjuqv/6Epvwu+TrDCjqG+fGd18pE9xtaDD5a6rvOTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLoiH+qE25vnfkSRZv7UEVzGHuE9HfXlSkZe8mCtbzY2+NCwKnynFstyGegDK3oOqUJBVjI6iQE7dtofcnZahuuxMokm4DKzwTqiAvtsON8sOiTCoJn+qkEroobG2wkanEB3nbLpRGfEQ/ucDoKciLlfgoXm1P5RjqrPhHLlpPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMBoVB+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D28C4CEF9;
	Sat,  6 Sep 2025 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757169426;
	bh=vMjuqv/6Epvwu+TrDCjqG+fGd18pE9xtaDD5a6rvOTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMBoVB+aXooA5GXesvJRx2cD+hmFMFJ1Wxm7st4nve1hXXd6gdWwfbN21AmjKAVgY
	 HgMR/rsnurmiVWFrwWqPslWyOKX5CRtQBIIJ8P9D32ikX3Lne/XgPzhAxQ+Z0LpqgG
	 UyKNmOBGDebnSPi1KHwOYBimPgljUYmvSzhkGTqznu0axmS48mUl3A8ALYCxEJMBEX
	 ANvQ70irE/TqavSuOCsmlcQBow62zsR+hhxNyPwshxUoqm1cG9ZTyY09RLPc0BXax/
	 5FFOI9yVnyvhgBr7aRxfBwnJgsjvqYXYh22ezXGTG9xeKVvRSrClwGVIgZU63eWGSg
	 OAyQQyFpOkApA==
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
Subject: [PATCH v6 RESEND 03/11] usb: sl811-hcd: Add PM_EVENT_POWEROFF into suspend callbacks
Date: Sat,  6 Sep 2025 09:36:34 -0500
Message-ID: <20250906143642.2590808-4-superm1@kernel.org>
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

When the ACPI core uses hibernation callbacks for shutdown drivers
will receive PM_EVENT_POWEROFF and should handle it the same as
PM_EVENT_HIBERNATE would have been used.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
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


