Return-Path: <linux-pci+bounces-12124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7305D95D1EB
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 17:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 458CAB2B901
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 15:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA7218CC0C;
	Fri, 23 Aug 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GG+jAER6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4E18C90C;
	Fri, 23 Aug 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427637; cv=none; b=d3eK3pERbThOlOmzRveMQ+q300zaZSIHmf34NQk/lPQN8mSM2ewuCaLph7SK12UtOh2VHBSY2xYBgl8AVA5Mz7Vlnn1MxL9KKT/1ljAUCrbYAIGyLmVwdd0An7Ge6cLur/LwbgQ8WHOtz8iExtbXZ5slYQvezypl7FlZESTqWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427637; c=relaxed/simple;
	bh=+H7Ob5CgTXkHeBCxTLSQpzmV08rXUMJJgwpIEqFFOvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIQTyOasAWhMSl2vmqk/H1i2Y03edrZNfm+H5SAIEIcn17MO/93MDB41wFvv7J3kWOpvGGR/DWHg3Bx5+EaW9U6Ea+u6EeUEfgaF5wgkN8TNZegdUMuUlbGzrjA2LD86+LfApdVFd8P/hMiNh9i6Zecz2CpjJMqgqK59Gy+4Y/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GG+jAER6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BE2C4AF0B;
	Fri, 23 Aug 2024 15:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724427637;
	bh=+H7Ob5CgTXkHeBCxTLSQpzmV08rXUMJJgwpIEqFFOvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GG+jAER6ctB5/V6Z2V5KpqNiXc8BAI63lz/sWVKXjjaaKjhoyxuL3QIJJGTP91bxw
	 PvEe4VWzoNPb1M8ggfa3/wCiQIAO3owRWJ6tQxPRSbampjPCVzkM/6PHJ1uWo+efpB
	 uQ6gBZqBzmm0q94MuFl9KdnDo7x8W1E0Tovg6ryrpIOqgRXJEEC73Lv8t3ALBWMXUH
	 /MbKsFj27S/yVHaa3hnQkFYSMVlHOrS8+TvfqxaM1aQAAJ+OlJn3VdjCywIbG/PkKs
	 IHLEwvqBNB9O5GGbr5u2IPYf5iXUmMWM3aNs0yNwY/P3ctGpQsJtvKH5CPlDDzhi+c
	 KSD4Uoub0/mnQ==
From: Mario Limonciello <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in pci_dev_wait()
Date: Fri, 23 Aug 2024 10:40:20 -0500
Message-ID: <20240823154023.360234-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823154023.360234-1-superm1@kernel.org>
References: <20240823154023.360234-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

If a dock is plugged in at the same time as autosuspend delay then this
can cause malfunctions in the USB4 stack. This happens because the
device is still in D3cold at the time that the PCI core handed
control back to the USB4 stack.

A device that has gone through a reset may return a value in PCI_COMMAND
but that doesn't mean it's finished transitioning to D0.  For evices that
support power management explicitly check PCI_PM_CTRL on everything but
system resume to ensure the transition happened.

Devices that don't support power management and system resume will
continue to use PCI_COMMAND.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * Fix misleading indentation
 * Amend commit message
---
 drivers/pci/pci.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1e219057a5069..f032a4aaec268 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1309,21 +1309,33 @@ static int pci_dev_wait(struct pci_dev *dev, enum pci_reset_type reset_type, int
 	 * the read (except when CRS SV is enabled and the read was for the
 	 * Vendor ID; in that case it synthesizes 0x0001 data).
 	 *
-	 * Wait for the device to return a non-CRS completion.  Read the
-	 * Command register instead of Vendor ID so we don't have to
-	 * contend with the CRS SV value.
+	 * Wait for the device to return a non-CRS completion.  On devices
+	 * that support PM control and on waits that aren't part of system
+	 * resume read the PM control register to ensure the device has
+	 * transitioned to D0.  On devices that don't support PM control,
+	 * or during system resume read the command register to instead of
+	 * Vendor ID so we don't have to contend with the CRS SV value.
 	 */
 	for (;;) {
-		u32 id;
-
 		if (pci_dev_is_disconnected(dev)) {
 			pci_dbg(dev, "disconnected; not waiting\n");
 			return -ENOTTY;
 		}
 
-		pci_read_config_dword(dev, PCI_COMMAND, &id);
-		if (!PCI_POSSIBLE_ERROR(id))
-			break;
+		if (dev->pm_cap && reset_type != PCI_DEV_WAIT_RESUME) {
+			u16 pmcsr;
+
+			pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+			if (!PCI_POSSIBLE_ERROR(pmcsr) &&
+			    (pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D0)
+				break;
+		} else {
+			u32 id;
+
+			pci_read_config_dword(dev, PCI_COMMAND, &id);
+			if (!PCI_POSSIBLE_ERROR(id))
+				break;
+		}
 
 		if (delay > timeout) {
 			pci_warn(dev, "not ready %dms after %s; giving up\n",
-- 
2.43.0


