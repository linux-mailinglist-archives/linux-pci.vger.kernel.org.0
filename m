Return-Path: <linux-pci+bounces-30453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F9BAE4D66
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 21:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31ED8172E2A
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 19:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD921684A4;
	Mon, 23 Jun 2025 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZdeOPYX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DB019049B
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750706020; cv=none; b=khcYKONwB9UkGPEoPc32BFs7o2mdDWVFIsjRWokc7mdsMHsG0jpeuSteSV9UBwDNW2xg4NX5raq1UNasxGj/88bfIy3sLFcIjTjq331oOjR5sPvGWyJtO0kf8oOzcj66P2MqFvPPae2nSu3+W/62qxDUdrMqqzJEev/Yg7ZX6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750706020; c=relaxed/simple;
	bh=i7kragQ9Vz4m6vrIv01n865b2qgbKDWuA2cpQt9Hme8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RfOGvljXmddQU6x6GAwZSmhb4ryucGkvW7OUEF/29fyAxiTmBsoc8ltZqAjf1XZ1CLeTPEZQugT+JL6TmrmcecjK+tjkm4fwJw6o8ez5LhRPUxF28AcGDQyDcTmR6cJdwp9QIvPcooeEiWq6st/y07WGMb0MtJtJL9NAq6kwPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZdeOPYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F66C4CEEA;
	Mon, 23 Jun 2025 19:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750706019;
	bh=i7kragQ9Vz4m6vrIv01n865b2qgbKDWuA2cpQt9Hme8=;
	h=From:To:Cc:Subject:Date:From;
	b=fZdeOPYXKNDF+XebZKZ5AhLhq8iUSUx+bfP10SEahLxzd/GyD+kJfxpybhA9iiWEM
	 a5urTnH1b77bmemp1STK5czNsvl5Gy1SaDTbfpTeBY7fh26wcdog65lKkvMinxUkCB
	 VImgBy7ECCH9CB13adK/Ogta1g256egvSRPlrVMZ1KR1oWF+0+zBLAx2laOv94pbH/
	 o5mscb52DhLRlEfzQQvfsNgVjUfiC+uSKl7VwErfYNL//Bm1Y6ss5kNRetfxWaQnpL
	 M5TDf5H4IrZ9FFRQt0jhKBDuM+gQvurfFb//RvWG/GpU7WbaPJq1yZ7pgJjgxw68Gi
	 uaznQvCcbz4ag==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com
Cc: Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4] PCI/PM: Skip resuming to D0 if disconnected
Date: Mon, 23 Jun 2025 14:13:34 -0500
Message-ID: <20250623191335.3780832-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4:
 * no info message
v3:
 * Adjust text and subject
 * Add an info message instead
v2:
 * Use pci_dev_is_disconnected()
v1: https://lore.kernel.org/linux-usb/20250609020223.269407-1-superm1@kernel.org/T/#mf95c947990d016fbfccfd11afe60b8ae08aafa0b
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


