Return-Path: <linux-pci+bounces-35758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE33BB50630
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 21:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED8B3AD972
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 19:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCF13629A5;
	Tue,  9 Sep 2025 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuyotVXB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D598352FDC;
	Tue,  9 Sep 2025 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445412; cv=none; b=muGc3ONBDE5YUCGWDBwW6EAf+9UlhJVK45LSzsMivbvcKWRsRw6zprJLew9IKLy0P/FGdCPejhkKzoUGpawmKM1Udh1cFSlav84WdGlBL614MWlQDb/2ooGRvbylXAn2gfK8CAG2I6u04bz8J1UkDCceIoYQhk00lx6VJd0Rc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445412; c=relaxed/simple;
	bh=qo/nXPgD6t+5JmE6kSj9gPD09yHbz8n18Ee/jE77cRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ymr98HDk+p9Z7iHOm+rFrjHtfReLYvc8coifoG0QWvAdJbMmHT7ANfRItWddUmHeEK/9kSTUCV+XMlkYjijT9gqAC3ta4KwI7I0LHnxpzqft55uVHtV5/ku4eh3e2kclPrknN7YWqZLZAVhysQ01fk5U2+bIwlHeCHi4DNikf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuyotVXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAF3C4CEF9;
	Tue,  9 Sep 2025 19:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757445412;
	bh=qo/nXPgD6t+5JmE6kSj9gPD09yHbz8n18Ee/jE77cRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AuyotVXByJn2siUp6eTu1q0geBjuyBYVMcJRBkYj/dIHkEmCDFZDu32Q4JdZcAAq9
	 vxnKStnSXAabvS5aJ920kjTZa5yb5CNs+QaHMzEzoGTK5Vbd1fbwRwU/1zAdkXWvuy
	 TD/fn8UnHxoBtcl5cydX8d4+My4mcU0/b9WJBUzSicAddoBLlv5xayhypPa301YPku
	 t8vcvaVreEHZf9OwRbyF9VBFnj+RE25rZRn0SsfZMW6SIEsBbkQJEMZAWi09qEGxr2
	 E4TOYVGvsB9O+1W21DTu55QYDDf4WPDNvOtTO9ezGzfPBKZZUAEUK25QyrMOtd/GYL
	 hvBQrvc+DYK0w==
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
Subject: [PATCH v7 07/12] PCI/PM: Run bridge power up actions as part of restore phase
Date: Tue,  9 Sep 2025 14:16:14 -0500
Message-ID: <20250909191619.2580169-8-superm1@kernel.org>
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

Suspend resume actions will check the state of the device and whether
bus PM should be skipped.  These same actions make sense during hibernation
image restore.  Apply them there as well.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v7:
 * Reword title
v5:
 * Split out patch
---
 drivers/pci/pci-driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 571a3809f163a..fb6f1f60b2f1f 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1246,10 +1246,15 @@ static int pci_pm_restore_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	pci_power_t prev_state = pci_dev->current_state;
+	bool skip_bus_pm = pci_dev->skip_bus_pm;
 
 	pci_pm_default_resume_early(pci_dev);
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
+	if (!skip_bus_pm && prev_state == PCI_D3cold)
+		pci_pm_bridge_power_up_actions(pci_dev);
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return 0;
 
-- 
2.43.0


