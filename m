Return-Path: <linux-pci+bounces-35607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13310B470AE
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 16:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26CE7C1A9E
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A65D2F3C1A;
	Sat,  6 Sep 2025 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvmBBN6S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4B5219A7A;
	Sat,  6 Sep 2025 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757169437; cv=none; b=srFcy4FOxgJS52GEcT9/mejNZOj4Cl2NVmUvvmMpSCOlPfI9zS6rqePRtE2bSkM5HH2T12uOASR+JvgU4BJ0ivT8l4S9c0Htn6ayOjgKiIUY+FGtP8OuxClYsBwokkz1sMwWV0QYfypG5jMZiCxLDWLrnCwmlEpXUubmU8FkU4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757169437; c=relaxed/simple;
	bh=aeX9aaqYt9fcYBzVbUpYXIN2578EUxkqsf3WrMGS36U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qk/AGWFdX/OlIZM8h+JCidPkOfwi1XhAYBdWiRqu1NpUnkRLa3CsnPF464MFo0nMXeFeASA7iiThSYepb9y5YvHQKhaRulhe58plIiAWRXx3WTzSQjl4l1KX/IFGFLUhGEEawXStQ8vRlnJIkH9VX6iby3nMdWxLVZzMA1be4U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvmBBN6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5CCC4CEF9;
	Sat,  6 Sep 2025 14:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757169437;
	bh=aeX9aaqYt9fcYBzVbUpYXIN2578EUxkqsf3WrMGS36U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hvmBBN6SfIX9dfVHNWuoLk0ejgDIkyyPOdVqwMfgoWNYd/a3HBWfx+1ZS3nQE91sJ
	 lLl1Y6b5pu5xYCjDqBLkiLokrHceiwcvHy1aC3uZluV8G33IxEMrqhJiN7J9YcWpGm
	 7TrUZIEQA4YEZ1AkfDrDvgZ3+vQffNHQ1mFKB9C4fADnxmO16aoMJHb0SlqVPm1TIu
	 sGvlPpDwaH/WsxfiI6g+CTyAGBDu+Ub2wDiUJ8BMVHWwP9eFHNPpLSwTGFwsqWqKxB
	 U/fL+3RckHZvuDqokdEr9jS9zZNNlWsbsUw92hBbrNaiVfxUXg0gFkCPtAiLx9UGE2
	 RMBdRrBV9SiMQ==
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
Subject: [PATCH v6 RESEND 08/11] PCI: PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
Date: Sat,  6 Sep 2025 09:36:39 -0500
Message-ID: <20250906143642.2590808-9-superm1@kernel.org>
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

Devices with no subordinate should be put into D3 during hibernate, but
devices that have bridge_d3 set should also be put to sleep during
hibernate. Adjust the check in pci_pm_poweroff_noirq() to use
pci_power_manageable() to cover those as well.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pci/pci-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index fb6f1f60b2f1f..c563fd6af979d 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1227,7 +1227,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 			return error;
 	}
 
-	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
+	if (!pci_dev->state_saved && pci_power_manageable(pci_dev))
 		pci_prepare_to_sleep(pci_dev);
 
 	/*
-- 
2.43.0


