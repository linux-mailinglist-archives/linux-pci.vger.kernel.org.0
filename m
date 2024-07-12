Return-Path: <linux-pci+bounces-10214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08D693004C
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 20:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E4B1C21F89
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2641A17D36F;
	Fri, 12 Jul 2024 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGmcLY1c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC96617D35D;
	Fri, 12 Jul 2024 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807975; cv=none; b=rXVRd52/DhvmCgjXrJtW7Fq5Qqfq1U5+Mm8RWpzG1qDKVCL0uYoh56qLfEObq5DXzgBoMWrRI9iHzu9SKfJi0xxVyizPVjq2R2iTRAhxnqPuAusTe6EDeEnPvCgwnTd8/sUnuXLc8rZUlhQbFE7LHIcacqY8m+kfKvM7DADaTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807975; c=relaxed/simple;
	bh=AMtk4b2IlFGIBldcx6HMuJbUNmXf2iqdlc1O1ICsuTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VupyPPZyxSzLWNMZ2o04DHJUMqf5D+OBdvnXml/4fz8gYMorq9qPaAK7oHJ+NgOi7RISge9SNFfgaEqtiTfA42qGPFTtWeaPU40J0B1fJ2XC0b99sfDwrSAFLImxVVpMnzYGCLZMpR8IBhKlyvZQmVJEiLTRooXRs8e05+TAiAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGmcLY1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E3BC4AF13;
	Fri, 12 Jul 2024 18:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720807974;
	bh=AMtk4b2IlFGIBldcx6HMuJbUNmXf2iqdlc1O1ICsuTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZGmcLY1cEouptx9VXFMDD6hB8itjvpeUsKLDbxROK2AvjDLYed2Gz7BVk6YUKUjf4
	 M3vomZtilLfZmhhy4vS/m5DTUAXsZKse6MHPslgIxyR1dVVjPDBkM2CdzGHchF8+un
	 M/uZ+ydwZplcCUcSTibuTuCF8XcvhF3CnVTVT3P3rPnujrbhk/+VTvxBVLf3UutyN2
	 zluHaFrbQoWZbNyzr/aXKKSOvfazv5e0je5UN47ELZG1CKZbTGgb4vN01opzLxcaee
	 KkkjscBdv+SUeMaOtylR0Dtpb4/6XSWdiXI44AdDMWcA0G3WunkHVRSHYkFlUD2ivw
	 1Ln6qOnKSyKwQ==
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
Subject: [PATCH v3 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in pci_dev_wait()
Date: Fri, 12 Jul 2024 13:12:43 -0500
Message-ID: <20240712181246.811044-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712181246.811044-1-superm1@kernel.org>
References: <20240712181246.811044-1-superm1@kernel.org>
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
index 115361a08d9e3..658a139f74ab0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1279,21 +1279,33 @@ static int pci_dev_wait(struct pci_dev *dev, enum pci_reset_type reset_type, int
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


