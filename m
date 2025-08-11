Return-Path: <linux-pci+bounces-33790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D189B215B8
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 21:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C16190800F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 19:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2442E3AFF;
	Mon, 11 Aug 2025 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haaXI8ry"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD522D94A0;
	Mon, 11 Aug 2025 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941286; cv=none; b=Fp2fZTIYXcsOavXPDuIa1fyvtetFNXxOrJZ5L6emjmyeMqvfwuKWJvbLlITgjpZ4gTKJhjeMHOEVrp+xq7CKHrwWtvc9awyRhOB6Wn5txgBzq3guyWXz971MZbTbQuYoTr9/XWJWwTHbnNUbQcqp4g+PJfJ36RANszOqfRiyytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941286; c=relaxed/simple;
	bh=et7bJe3p9Q1yVCIYr8gWEO9Yxv/JOZsp+bMu8xhiGjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgFm9UsMWQ+r4X4z293AT/xS6Sb3+vMU6ELmoWvMwxoEOelIVT2aWzCDO5egBEaF8ubc35UIEkhrFh7sYfNS3LnqMEW/LlQz7LBa/ljVdDp5zjhhQtGc4B9XaSoAPYg3ExBjUZhgLtj/Eg4QX8TrnlqqZFbBDleyST6OPdwrbbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haaXI8ry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA63CC4CEF1;
	Mon, 11 Aug 2025 19:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754941285;
	bh=et7bJe3p9Q1yVCIYr8gWEO9Yxv/JOZsp+bMu8xhiGjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=haaXI8ry279qEit/tJgKYky7JRJ3ljqlonppbG1KJKJ5i5hermaNh8vS4JdQfqWjh
	 +edmheve6lNyRioFSKxfX+mNwEcNVJrEEX5ip4kwAgEk0qYQIFJI5Hzjtqmqcnn8h2
	 yT1Frav/Gim++o4EgDjZdNlGJTrp255SrEE74Fs7b4SqoxOfL0wSltpE4ioZe9TJuW
	 w6CYHOQ3H7yWhViIABLX9ihNe3A4aKhanjm3GQekB7CkkcoZGXjPksEyicgEWb+7OQ
	 fN/7Hb/Xu4d/z/C+OmdQdMdmyLS6II8V8Z1opOdGbmkFfDTOsdu3Bz+mB+A/onbouR
	 k7q8L+bFS6TmA==
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
Subject: [PATCH v5 08/11] PCI: PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
Date: Mon, 11 Aug 2025 14:40:59 -0500
Message-ID: <20250811194102.864225-9-superm1@kernel.org>
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

Devices with no subordinate should be put into D3 during hibernate, but
devices that have bridge_d3 set should also be put to sleep during
hibernate. Adjust the check in pci_pm_poweroff_noirq() to use
pci_power_manageable() to cover those as well.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v5:
 * Split out patch
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


