Return-Path: <linux-pci+bounces-33787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33675B215AF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 21:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6515219086E6
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D552E2EE6;
	Mon, 11 Aug 2025 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjsg3j/0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127E2D8791;
	Mon, 11 Aug 2025 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941279; cv=none; b=bbOySXfBgavb8F9P/6QTos1w+MqPv/li+Bl6IpCUVgcVSEHtvQMnuVvbvFzCqlPCV9KBmLgFZqbT646ubS1f10RS/LdswMKAjf2cf1BezHeFMb854pNLJnPQPyrnCJRz76EbnQBr+T3lIA/DppKJzOYW5nkUS8SSqxv7cXxzp/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941279; c=relaxed/simple;
	bh=gmu/PdQ4UxFejc1aL5S++SztnEvLGmrvTcqy4XQi3rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5Yij7PbhVwwmGwdBEnrHvTgvxhPT2YF8EZr2F+vl3L2rKPKKkAb44MZo0zkoCTRFcLYq7GnALU2cnX1cj7yJe0RttgTmVVJlVhynAEqSvjykk5Ecc63cu+yZuGJ7gNJxI6CgI+J0s4ciDgsRdowoBijsDbR6JcDeW5+3awkLPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjsg3j/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D7FC4CEED;
	Mon, 11 Aug 2025 19:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754941279;
	bh=gmu/PdQ4UxFejc1aL5S++SztnEvLGmrvTcqy4XQi3rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qjsg3j/07ZReEOnxg6m/AmjVhXPo6OPYT8eJ9QF9hsuFhxg4hCafJXhdyfQfFzqrm
	 u2hje27TlIVizJvWIkEuqss8W6eGIluGlI5Nz9en43rtkoG372j6JDIiE8TvOP0nKk
	 G165hW4lDJKyJWkVTaGI6Na0BvoMF+6bS849VmX6Kj0a7QraGvEZik5KHVE1JSYh6R
	 QnraQQlbZCyeqiqDSRL44ayQBBfEeP0hNhfNYOFjW9VOSFJ87zzFOF8CVY2xMDaqiv
	 LOiYx3H9RH98fs0mB0Aw1bedXeMFgPiz0NlBheiBY+empw4VbYP9/EKNZez9iApLtE
	 wiWUfrWNARN8Q==
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
Subject: [PATCH v5 05/11] PCI: PM: Disable device wakeups when halting system through S4 flow
Date: Mon, 11 Aug 2025 14:40:56 -0500
Message-ID: <20250811194102.864225-6-superm1@kernel.org>
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


