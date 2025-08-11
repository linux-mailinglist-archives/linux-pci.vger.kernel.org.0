Return-Path: <linux-pci+bounces-33789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21271B215B5
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 21:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB6D19080C5
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 19:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076862D8DD3;
	Mon, 11 Aug 2025 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXZvNHha"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F382D8791;
	Mon, 11 Aug 2025 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941283; cv=none; b=tTNBVOFxtjv5vc/Jg7+ST+rH7XIxCvEKbL3hKUmATrK96SQVQ8HlI+fLoor1UpuCf5/LTpBjcNsSjro4Oq5EXflUxWnGb7usYMUdNHVSl4U1lteAmZZzb2FFz3sox9S9ysdcBNrg6iifRC+BF9mF9lWXn9vDaZECjoJotjWLeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941283; c=relaxed/simple;
	bh=UGv8yMZlE7pfJwSGLN7xjf9pNffnerK8ACuf3st8kZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PeyHAHmbkvsDFYHYpTrfx1cWVH1oJEmGM7I/gdcIzBcdCx9rrk+kR4u8reptHWdJ0fjiC4gDwOymbvN+Uz/fvuf0daCOOG3pxTno+snpqpTOs+bpqRT7JDq/AX/MUyFQ0fthrVmBldOXPRFmlDf69s7ycOWxr0BOoMHXFZA+v8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXZvNHha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5403C4CEF8;
	Mon, 11 Aug 2025 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754941283;
	bh=UGv8yMZlE7pfJwSGLN7xjf9pNffnerK8ACuf3st8kZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXZvNHhalPpwKgkEGAM7UhVylOee8KOqIAP+0IQo71O0HM36Nck8sWeezIOPniQD8
	 64NyAv7NMRYsD+NqlI+3NyKHGsF8iK901LIqHdZy9tyFSMmDjgKw6aRcndT2VAGIYW
	 bwVxZftEW/QnfUkAws9pu+sZ4tybuFZmGqplQ36Fgk7mC+SfMjNlGdZXHWmsOrZG/e
	 IGE//aw8yVq5182TM3+yHEnFDbNeNbIC9Z/IWRFb6NOMBMRTyJwfBtQLTROCZL8Uw5
	 IwD0MyD2ZYg/SW9GboQ1+LyEHSlYhd8bGSSLadxAL1BHzsX5d1UN7yuVmEE9yWCD9u
	 knqe3D47KLvCQ==
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
Subject: [PATCH v5 07/11] PCI: PM: Run bridge power up actions as part of restore phase
Date: Mon, 11 Aug 2025 14:40:58 -0500
Message-ID: <20250811194102.864225-8-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811194102.864225-1-superm1@kernel.org>
References: <20250811194102.864225-1-superm1@kernel.org>
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


