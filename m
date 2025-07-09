Return-Path: <linux-pci+bounces-31810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08DEAFF368
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 22:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D43172B28
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 20:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BA2233152;
	Wed,  9 Jul 2025 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmOLpTeO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1221A3179
	for <linux-pci@vger.kernel.org>; Wed,  9 Jul 2025 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094791; cv=none; b=S30aSYKWw40dnLCo7OESkkNNSyWKnpl3RwWnbz2pe9Fxx96DHo8F8bhkTRbiMjzEf73cPoPiqDtdG0xhSY4pE7Vke5k3qh/5U+QJREsrkBMyl5/aXQsmIqLdRrKAPnR2+3OEVQ/6ayBVyLoKcExVw1Fr9O21RwsidBDjq9OgEw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094791; c=relaxed/simple;
	bh=3D6XvBEoxZfSZJhFXmFowr5XV47OssK/vQKvevYaMA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VkQO00dm2zOp5h/hswgvAekaIvuasMnegWTzB1GuKlVRBtQH9TdfaGLES5xZyu8ZkLGx8Bu065CB4/WrDVdGhd0B4CjprzquDDVUnWPlGUrNyKp42SzMX59chOqV24w7fe83t9QsXHBC/dsdWkbPjPFtVikUHH+OrNZGV6Hb/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmOLpTeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C13C4CEEF;
	Wed,  9 Jul 2025 20:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752094790;
	bh=3D6XvBEoxZfSZJhFXmFowr5XV47OssK/vQKvevYaMA4=;
	h=From:To:Cc:Subject:Date:From;
	b=RmOLpTeOBKrZ5rC/E2MHhcuMlRYXK4f/Nk+zYsxeJBGEfRiFrUpsSNiduWIhfOsnm
	 i5uXt+OzPvpBomESHZhGPF1BtScvElMvXVNs9dCaL958m+a9al7T51RxHzbqPet30k
	 0+xlGROBiq3vCWmlV/6K9tL88paBO7YmRgtuEFqziwMNcLnWXz84xiS3GSavZsXs2L
	 VzPRPRm026Ld9GHuYkJP0k8ujqxAmuUrdGO2mYazERX72UvwxCusCF51qNZbKz21b/
	 ljoe3g2uqj9Dc0n1wgmR6NKb5GIAaBXQFeddwuRJpeayybehvF0MQw0W+hVuhYji9s
	 9EH5VNWrNcAlQ==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com
Cc: Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v5] PCI/PM: Skip resuming to D0 if disconnected
Date: Wed,  9 Jul 2025 15:59:46 -0500
Message-ID: <20250709205948.3888045-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

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
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v5:
 * Pick up tags, rebase on linux-next
---
 drivers/pci/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9e42090fb1089..160a9a482c732 100644
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
-- 
2.43.0


