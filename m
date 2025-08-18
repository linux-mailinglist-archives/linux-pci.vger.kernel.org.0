Return-Path: <linux-pci+bounces-34154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B95F0B2968E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 04:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D68819635E8
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 02:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FAC242D82;
	Mon, 18 Aug 2025 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2nOETKo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563D9221FBD;
	Mon, 18 Aug 2025 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755482483; cv=none; b=ctP/wIbsgvuBGxaRprPH5Gk2amNu10NJQ1VZN9mOTwzNpwS2BA9oxjcuwatUVa60UsVD3a4+3cQdMjEksVCY2uVpRgSdG5r9/ap1suS40FZhqqG0m2xeilkQownu+SDM9qXjnP5hc0aNkiwJYJsTUNY47aY3+nONkTFHuIuy7KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755482483; c=relaxed/simple;
	bh=gmu/PdQ4UxFejc1aL5S++SztnEvLGmrvTcqy4XQi3rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1oB8Gbg03/SH3rREKSLsev9/0AnLU3zwyqrjKIjIltRj+2DnF/cSTuTHZ90/iHC5Km2O0XKHFfXaP3M5sEIbw6sbn57vtUlEZbRXnnGQCHty8GDXQLBdx665Fdj3MjdP01L0b2F0XbxJuHjaxTB/bmwLxHSlExMrbjyukD6LII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2nOETKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BB8C116D0;
	Mon, 18 Aug 2025 02:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755482482;
	bh=gmu/PdQ4UxFejc1aL5S++SztnEvLGmrvTcqy4XQi3rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k2nOETKoqZ9uE91kGG8cbeIu5ptgj5y9DfDbi2//AI05EnLaABTEpKqqvbCZNSP2I
	 +VQzrVH2xT0S+rPb9rl2n0Qc3muJk4SCJrep/mH/6FEcBHpFrjg7nTNfZF5mZSET3D
	 V/wD4fiUtsjQKWwamz1EeU9xSfHe4mL2E4g6LoirlvgsL4rmLOByrBzsoLha4I/IsC
	 XQGybKwDOqVxB6+rsNoPalU+9ClpRkZggyr3goyZp/NzsbaM1RxC/n+JHJ7kLHITIy
	 Dw3evZhU7vrPhqSsmf4OCRvgGKudsLcyEJ+No6bSnZexzP8aur+kUoHY4Jt0QDm/PY
	 tXNzGWgp/j73Q==
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
Subject: [PATCH v6 05/11] PCI: PM: Disable device wakeups when halting system through S4 flow
Date: Sun, 17 Aug 2025 21:00:55 -0500
Message-ID: <20250818020101.3619237-6-superm1@kernel.org>
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

PCI devices can be programmed as a wakeup source from low power states
by sysfs.  However when using the S4 flow to go into S5 these wakeup
sources should be disabled to avoid what users would perceive as
spurious wakeup events.

Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v5:
 * Re-order
 * Add tags
v4:
 * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
---
 drivers/pci/pci-driver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 63665240ae87f..f201d298d7173 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1139,6 +1139,10 @@ static int pci_pm_poweroff(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
+	if (device_may_wakeup(dev) &&
+	    (system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF))
+		device_set_wakeup_enable(dev, false);
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
-- 
2.43.0


