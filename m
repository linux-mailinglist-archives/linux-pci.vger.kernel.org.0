Return-Path: <linux-pci+bounces-29891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F01ADB98D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 21:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75281890AC3
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 19:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC6289E00;
	Mon, 16 Jun 2025 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxNadmqW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA5F2E40E
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750102102; cv=none; b=Y1it2X3sv5mOe9MyZV01NbJx60G8OTUEVd1OCQcjlfRdaQywC5hD7EsQmKH341KqHkBfX7X+ENOF5KS4l7QLh3aN/Xq6zpwuikLhN2UbyOcGJh+wltzRIVH4UHNLFS8z5WrIvOeiXFFhTbMhsm/LyxYxtt8zVHWT6Q2AfQb7270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750102102; c=relaxed/simple;
	bh=xYa9bGIisz2p+cx/BizkJpSrIfhy9tTQCoRjsQt671s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOMTCwVYHO0zrFdlAJQTZDjW8zDpTcPDAKNDKpaxHy9NPoRgx6L3peuBrVIeJaZ6vHoSHOIucHNh91FvJdwRmxDEnMBNwJkx3rfeZECZ9IyS7FR9a9/G5Z3+euvSe26Eqr4jifdfjB2esxEjFfd9X9L8Ghk5CJ+FnAIThWcPhn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxNadmqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FD5C4CEEF;
	Mon, 16 Jun 2025 19:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750102102;
	bh=xYa9bGIisz2p+cx/BizkJpSrIfhy9tTQCoRjsQt671s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxNadmqWmMJbNINpgcrkOM5F5jPJqowhqGiP1wJLweuSQ4JBD8jY3b1zlUwpPjHcz
	 OUdSh2U6OBZKSKwiQQa7MRU9uZ9sUa/ymNYA0XaWDK77uPhKy1lwv+RJZcqKRmOO36
	 19udNslJGtqrswpxdKpBEX+CJdTcBdySy+TNZSa00r3hgFXyEO7VgSSrxKNw0VfoR6
	 zKa6B/xRlnCdeGn7X1aFjv92qHtULOzhgSExzH2i8ZmXZBgKoA9ayXVH6UQT6iZYbt
	 BJ7CnAy8APduoWxEcr/PKQSAwiv8BgDdwJF+R3tlismZiD5N0umQo2iM2nqajt806s
	 vPL9bxZt5/p2Q==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com
Cc: Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: Don't show errors on inaccessible PCI devices
Date: Mon, 16 Jun 2025 14:26:56 -0500
Message-ID: <20250616192813.3829124-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616192813.3829124-1-superm1@kernel.org>
References: <20250616192813.3829124-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When a USB4 dock is unplugged the PCIe bridge it's connected to will
remove issue a "Link Down" and "Card not detected event". The PCI core
will treat this as a surprise hotplug event and unconfigure all downstream
devices. This involves setting the device error state to
`pci_channel_io_perm_failure` which pci_dev_is_disconnected() will check.

As the device is already gone and the PCI core is cleaning up there isn't
really any reason to show error messages to the user about failing to
change power states. Detect the device is marked disconnected and skip the
messaging.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Use pci_dev_is_disconnected()
v1: https://lore.kernel.org/linux-usb/20250609020223.269407-1-superm1@kernel.org/T/#mf95c947990d016fbfccfd11afe60b8ae08aafa0b
---
 drivers/pci/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9448d55113bd..3dd44d1ad829b 100644
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


