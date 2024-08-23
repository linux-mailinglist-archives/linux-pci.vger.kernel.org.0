Return-Path: <linux-pci+bounces-12060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF6B95C427
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 06:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BB028580C
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 04:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737BB745F4;
	Fri, 23 Aug 2024 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2ucnUs7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475827345B;
	Fri, 23 Aug 2024 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724387158; cv=none; b=JJ8pk0njYPPVkqpPrhfRqd8jva9KnfI0GqeHCtQKy5sL1dp5Ab5PmFaK0p1PQ93i3K9wT1XwdsSpGW4FdA29j5+aEoqAhOweX2kBeu5FGHDGpaSroZY29beVCzyVj6zeOjnfqlc3r3Zg7ohd3f2INY5AEWDHs7sQ5C8suMlmWnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724387158; c=relaxed/simple;
	bh=khgcZTdcadskw9ICjrzaNIg7PTgVIwoH2HRI4HWP9KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egnnglIAYb9P6Mzskge2/ATqVQPhRedodzH1NA49uyDgyYz1V5prGabm6Mkx1DaqZ4jWh5eM/RMoqaPkqr4LDbFDN3gIJXOAZcQmGVhihvoTLguwpGeBeyP3S5vCNmN5x2DQeQl4pLB4H7G7d1HBzZHdNC8WeaAQJnIdIbABRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2ucnUs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C074C32786;
	Fri, 23 Aug 2024 04:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724387158;
	bh=khgcZTdcadskw9ICjrzaNIg7PTgVIwoH2HRI4HWP9KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2ucnUs7aUD0SBaMn+cJjeszHD1Ml9yZoXuy2mgg14dfcbJEB/EO7ytzXZJ3Ko9qS
	 Z2NlkAGES1aYrqApD+XrIV0JvZGM5vvPL1as0CEA6ZEzZ93leKUIldgBef519e9Duu
	 5WVgNIxviQfdRyIHqll3+/kP3JRHLEgj0uVBVgHRYK7D4V8n38flDye07XDlR9ym3k
	 07GA8mp1/C/cWyMnfESC7GPV4b/IiKt8oqQYHFydtwBmERRpTwvKAN1J2e9yIvmDvw
	 rSK2t2Bvfq4Rn+EoDgVVPgQLMRahr4rjubg+ifU8QM1CpizbbpPuO51Y/gHsHX0bJH
	 w6SKd89FhCrvA==
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
Subject: [PATCH v4 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in pci_dev_wait()
Date: Thu, 22 Aug 2024 23:25:05 -0500
Message-ID: <20240823042508.1057791-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823042508.1057791-1-superm1@kernel.org>
References: <20240823042508.1057791-1-superm1@kernel.org>
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
 drivers/pci/pci.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e4a7f5dfe6bf4..b7717155e2fd0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1308,21 +1308,33 @@ static int pci_dev_wait(struct pci_dev *dev, enum pci_reset_type reset_type, int
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
+				(pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D0)
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


