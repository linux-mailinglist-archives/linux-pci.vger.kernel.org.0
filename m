Return-Path: <linux-pci+bounces-33769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD0EB21222
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 18:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F23B77A3763
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7EA296BDF;
	Mon, 11 Aug 2025 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PebfqRMX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668B296BB3;
	Mon, 11 Aug 2025 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930113; cv=none; b=UPkA4Qo2aDKKo7PBP88VXn/5WTi4jUhiIOGlSWRpkh8dPUHmbJmv45hX72pQxoiyPpIpr57RCTBPf7We/ffR/u12BXtOif+CUBZrBZhixFB3IOxLxmzZ8hz7b2cHk8pAXnkD9teNnurIR8o7h8S6S3NAGyX6b2gKXEYD+jTkKNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930113; c=relaxed/simple;
	bh=m+o8XltTupvNOF4f9Ds1w9GcVyeTQlv0L4YJYKj6Rmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kabHHfQWvAmtBMWgdkJbvhPEx133GPtjSnxeFkfvnrgF7kN7c8iE8F+tpIvsa89e4Nd+NaoFBDSkQ0Ee99FAkzfg+sXihWmwwF70t8Cr+AgT+tyU+a1JRj05dG3vSrpX/wZXGQ9S2fA50JbtMH60Z77/8SP3fA8Nk5enLZdx3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PebfqRMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73070C4CEED;
	Mon, 11 Aug 2025 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754930113;
	bh=m+o8XltTupvNOF4f9Ds1w9GcVyeTQlv0L4YJYKj6Rmo=;
	h=From:To:Cc:Subject:Date:From;
	b=PebfqRMXYgfh501NSxBuRxqtKF8uX+YLR1WHUzUgLtc7fjTJrooZ0e4DDyMnxdR/i
	 0qJbJ3s0y5iKl3c9t17yH6R8crkkULN31ZUdizdSYTzsvyYM+BebFkmQy4Lhj1s9uf
	 71WcY3NkcNPIQtVFTy0oFesEJ1voz/hR4wRpNNCcqGjMRm+pA/y7Obkr//7swF2h62
	 Il6WzSmnIpYRZy928ohlCeWpbr4AqzgYZ8iJbbwQSeiRYAWjzMrHz6HCKBqBaY1JDq
	 Ll5gu6YUaos6UW0/iFRvBNjKQXuhr42KpiLYZN0hkxQQQVhZX8YIYwFCYDigy6wjwn
	 x3VotoF3CRYsg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
Cc: linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Mario Limonciello <superm1@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH v6] PCI/PM: Skip resuming to D0 if disconnected
Date: Mon, 11 Aug 2025 11:35:10 -0500
Message-ID: <20250811163510.601103-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When a USB4 dock is unplugged the PCIe bridge it's connected to will
issue a "Link Down" and "Card not detected event". The PCI core will
treat this as a surprise hotplug event and unconfigure all downstream
devices. This involves setting the device error state to
`pci_channel_io_perm_failure` which pci_dev_is_disconnected() will check.

It doesn't make sense to runtime resume disconnected devices to D0 and
report the (expected) error, so bail early.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v6:
 * rebase on v6.17-rc1
v5:
 * Pick up tags, rebase on linux-next
 * https://lore.kernel.org/linux-pci/20250709205948.3888045-1-superm1@kernel.org/T/#mbd784f786c50a3d1b5ab1833520995c01eae2fd2
---
 drivers/pci/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b0f4d98036cdd..036511f5b2625 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1374,6 +1374,11 @@ int pci_power_up(struct pci_dev *dev)
 		return -EIO;
 	}
 
+	if (pci_dev_is_disconnected(dev)) {
+		dev->current_state = PCI_D3cold;
+		return -EIO;
+	}
+
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (PCI_POSSIBLE_ERROR(pmcsr)) {
 		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.43.0


