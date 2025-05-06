Return-Path: <linux-pci+bounces-27253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E14C9AABA14
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 09:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D121C1C28007
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 07:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DBE17A2EB;
	Tue,  6 May 2025 04:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/GlAI4L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC1725DAE7
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 04:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746505182; cv=none; b=ufXDmvdRYFTjvAd0BgF8hJV04EHEAGus9ttFaPmoZSDXrnKB6rJWhBzZqy1lo8VzIssGmvS4x8DjOMGVcRuCoWYDImbryFMbDu3+6+5kvv4UKh1axC+IrH+EZmcncnzhZGlyZQsm99DMawheGm0dPHuyQtNSt6dOHF9SnAn9HLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746505182; c=relaxed/simple;
	bh=t8cQe8nXohngeucO0MJHqRtEgqTlh4lHd36y72uHp8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LDFiKnkwIaUWYHYFH8OviBV4aL+mpxWGN4WCcDyqYu/PzfvZhauS2ABVNlwhjDp0Bko0RRTmphUYQtTFOoV+64L5xhQWiiJJd3I2rxW73ceGqJjcthucUDwIEr2zl7yBCo8HnjahfxANCUtEYDL77tXjcsjRrXEpoiULGQswBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/GlAI4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE405C4CEE4;
	Tue,  6 May 2025 04:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746505181;
	bh=t8cQe8nXohngeucO0MJHqRtEgqTlh4lHd36y72uHp8U=;
	h=From:To:Cc:Subject:Date:From;
	b=e/GlAI4LQCQ+aZVNU2q6LDuK3qjC3j3mrreGuFjP79dyt508wiKSV/bDpUk2CGgsY
	 zLPttRgiC/sVy4hGAtYmMVrgYFmhOfBthb9irJ5jBLEI3YeFzsesvxzd8wuPgDNZke
	 MZ1zRoPnb8UCn90+U+J3QyPw1QbVnaCeSb+8u5XWSX14a+1OsDWdoWJwZfwMIol4y2
	 vQfkjlJrX6kEyupKGeLY+zSjAUu7jOmi7+Hgw/ZuUi14hWogE7yXf0xuRnAkXSTOIW
	 lS2lkD0UpYn+4UZ3NVCe4LEBgSvznADlcw5pISGPRsOSHWwSrw3g1kzCUJCAJsuPHo
	 jy9pcWyovBXng==
From: Mario Limonciello <superm1@kernel.org>
To: rafael@kernel.org,
	bhelgaas@google.com
Cc: Kai-Heng Feng <kaihengf@nvidia.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Denis Benato <benato.denis96@gmail.com>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3] PCI/PM: Put devices to low power state on shutdown
Date: Mon,  5 May 2025 23:19:21 -0500
Message-ID: <20250506041934.1409302-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kai-Heng Feng <kaihengf@nvidia.com>

Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
connected.

The following error message can be found during shutdown:
pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
pcieport 0000:09:04.0:    [ 7] BadDLLP

Calling aer_remove() during shutdown can quiesce the error message,
however the spurious wakeup still happens.

The issue won't happen if the device is in D3 before system shutdown, so
putting device to low power state before shutdown to solve the issue.

ACPI Spec 6.5, "7.4.2.5 System \_S4 State" says "Devices states are
compatible with the current Power Resource states. In other words, all
devices are in the D3 state when the system state is S4."

The following "7.4.2.6 System \_S5 State (Soft Off)" states "The S5
state is similar to the S4 state except that OSPM does not save any
context." so it's safe to assume devices should be at D3 for S5.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
Cc: AceLan Kao <acelan.kao@canonical.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by: Denis Benato <benato.denis96@gmail.com>
Tested-by: Merthan Karakaş <m3rthn.k@gmail.com>
Link: https://lore.kernel.org/r/20241208074147.22945-1-kaihengf@nvidia.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3:
 * Pick up tags
 * V2 was waiting for Rafael to review, rebase on pci/next and resend.
---
 drivers/pci/pci-driver.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0c5bdb8c2c07b..5bbe8af996390 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
 
+	/*
+	 * If driver already changed device's power state, it can mean the
+	 * wakeup setting is in place, or a workaround is used. Hence keep it
+	 * as is.
+	 */
+	if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
+		pci_prepare_to_sleep(pci_dev);
+
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
-- 
2.43.0


