Return-Path: <linux-pci+bounces-35713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1957AB49FE0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 05:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE962165C58
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 03:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C941F25393B;
	Tue,  9 Sep 2025 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv8HaLpX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B3E22A7E4
	for <linux-pci@vger.kernel.org>; Tue,  9 Sep 2025 03:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387962; cv=none; b=pVkLUnuUohrdM7CQtC/kuBGa1+IvbnFLB1eqJmq0SPi3SnCmVCLG5oT3RgkVLPQe3u10InhwNQ3/rbk7qvOwNJP7Z+50urs0JY/vVeoCmvL79hmiX5Buep/pfEN3xDA662pCAb3KJr/BtGw7n+Aqc/ZFU1zdUo4lJQYB6bVM0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387962; c=relaxed/simple;
	bh=qM9Tv1clMNRKl4UaRRVOdoo9xvNi5iB8023F21Ij+N0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AGLztEytgf0ebiZb4DGzEEq0xr48S4xbtMnCjOPB0rIIFO9GcYYtk+QjgkW04hNbfVuNs+EePi+JfFTZ1yPkVr6raFGpGC6gD84EIKQp+z0UBzWAbRO6WSUB4oOnSPilw/pzNn30QwWmE7l805+KnSiaERJ1ShKPjhfjMk66X3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv8HaLpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEBCC4CEF1;
	Tue,  9 Sep 2025 03:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757387962;
	bh=qM9Tv1clMNRKl4UaRRVOdoo9xvNi5iB8023F21Ij+N0=;
	h=From:To:Cc:Subject:Date:From;
	b=sv8HaLpXFJdPvazcaXNYg9p8YZdw3yaDAJbwSYzqbaLcCPlHekMw9S8ZHAq8yfcC6
	 qNrKEnkATTpejfp1KcD6LJdPXFdq+WiFC+kuVcX3oYmxgQ9gCg3DRd9m3CP3tSeulu
	 7pWP+WsSM2j1Dfs7SH+fIOAfldIdr4OlPbX6x0j3PRBF2jIr0wjs8T8dK1SeNQtqSZ
	 deoNz3w6KKWtQfjorUhUG9ThGlhBpfLqNicO5VN4/l9M3zyDRVmsr3/KpmDOh9diLS
	 10ZYwR+0C5T628oi0RYdm9xNKiXlXAfGCMcc99XDP1u3N82bANOLtzZjy84b14ZIYZ
	 BDAnsju8mK8Tg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com
Cc: Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v7] PCI/PM: Skip resuming to D0 if device is disconnected
Date: Mon,  8 Sep 2025 22:19:15 -0500
Message-ID: <20250909031916.4143121-1-superm1@kernel.org>
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

When a PCIe device is surprise-removed (e.g., due to a dock unplug),
the PCI core unconfigures all downstream devices and sets their error
state to `pci_channel_io_perm_failure`. This marks them as disconnected
via `pci_dev_is_disconnected()`.

During device removal, the runtime PM framework may attempt to resume
the device to D0 via `pm_runtime_get_sync()`, which calls into
`pci_power_up()`. Since the device is already disconnected, this
resume attempt is unnecessary and results in a predictable error.
Avoid powering up disconnected devices by checking their status early
in `pci_power_up()` and returning -EIO.

Suggested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v7:
 * Reword commit message
 * Rebase on v6.17-rc5
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
-- 
2.43.0


