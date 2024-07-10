Return-Path: <linux-pci+bounces-10103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA0E92DA70
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 22:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECD4284C3C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 20:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E10198E60;
	Wed, 10 Jul 2024 20:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckWBo0JT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DB1198A37;
	Wed, 10 Jul 2024 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720645128; cv=none; b=PNWdH/wca8TSbNaGraKYfkmg05YiCnugfowPvv+zMwLg68Z/Ic7M2Pz34e42ObgO51sFTvQNRdt2PHUmJZgr5uTK8Qu/YJeemaAYUotb9P7T2j3Y9A/vn3IT+OMa9XZst4UXHtGOfvCzgTS2MpQm5DZmly/Ol3ebqHP06XFRE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720645128; c=relaxed/simple;
	bh=ZCgND8fYZ7yP5CCsx/FWgBFuQOdUwdsY9anxzQLS25c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FubFY3+E0W+DdnEbxR5Dxqm9i3L+necYl+xlBiQpFkx7JxF86ZvU9N7S1D8wKdDeommbBrLmvSBuZ1XkpzGO1r4tOUv2l8yq94ZjPi/7GJW1DDw96Hu/dnkkC98sxVRqjRNd5snwQ1DZ7YLC/W+676FGWv4MU27BgRPzsINJjf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckWBo0JT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4631C4AF09;
	Wed, 10 Jul 2024 20:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720645127;
	bh=ZCgND8fYZ7yP5CCsx/FWgBFuQOdUwdsY9anxzQLS25c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckWBo0JTLDjVfhdxzXFrTybT+54AKOBysEWDrnBK+WketDLkMCbYjqOEPjH/0kvWA
	 uguEM/+3cftopaSoAiH3wq0Mnz39cy/a9lRiY4kbCFB+2voUwZizz/AJ1uUlL26Xqy
	 Oub9XO/4/zJpWz71cn1jv1/krwTLcyCQMsoMeGtPPPBWKwiqbQLOyI97KheJ1wJ7Lz
	 4d4m9YpcBYX8CU7qZYn0SZ85fcyqtH2cKgw7RHk2cZLMtfZ7XiakVXuV6pqcrM6Gnc
	 fiq/mORJ8x5VJIj3IfsCPvTSbZLxS6cXTrpCAIyroj/iTIP5GUh2ZetDwkMUlWcmbR
	 TrxThg9XwuPMg==
From: superm1@kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/4] PCI: Check PCI_PM_CTRL in pci_dev_wait()
Date: Wed, 10 Jul 2024 15:58:35 -0500
Message-ID: <20240710205838.2413465-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710205838.2413465-1-superm1@kernel.org>
References: <20240710205838.2413465-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

A device that has gone through a reset may return a value in PCI_COMMAND
but that doesn't mean it's finished transitioning to D0.  On devices that
support power management explicitly check PCI_PM_CTRL on everything but
system resume to ensure the transition happened.

Devices that don't support power management and system resume will
continue to use PCI_COMMAND.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 35fb1f17a589c..4ad02ad640518 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1270,21 +1270,34 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
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
 
 		if (pci_dev_is_disconnected(dev)) {
 			pci_dbg(dev, "disconnected; not waiting\n");
 			return -ENOTTY;
 		}
 
-		pci_read_config_dword(dev, PCI_COMMAND, &id);
-		if (!PCI_POSSIBLE_ERROR(id))
-			break;
+		if (dev->pm_cap && strcmp(reset_type, "resume") != 0) {
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


