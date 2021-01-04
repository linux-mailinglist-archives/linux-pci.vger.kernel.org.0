Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46F22EA055
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 00:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbhADXDr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 18:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbhADXDr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jan 2021 18:03:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75EA72255F;
        Mon,  4 Jan 2021 23:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609801386;
        bh=Rh2aHJURwBC2xknvbCANoE2Rg4qvZj7EUZ6MjeOJbe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcWt3mM5LkhWGoqGNXSbCvi4D7+qcTjyW2wPuvKPEEI+C24zqyBB+JSUKajDx6E+K
         eRpaIezYVLOEWrgn80MwBtfqK9YlobwbAmXlkfAxIOLiAtJ16IWU7k/quWvx0V+ETE
         iAgEPk6Qeu2hqGnZnKd+PzE8NyqNi5Hf1q56qjw2DI+wbm/Q5eqAmXEG/TCa5dgO95
         NhPUozq9y1ZXPFdDIr4USaawMT38wIPvl3tmapj03xe3r/Zaairi0wRkB0ghEzgNjc
         DI13pjkmtmp9NuMZIQ6ghr2qyrh9mJZ0Qj29ocRkIDEhngbiB01eZVotWHfKwLDoai
         +5o17cxIrZkwA==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCHv2 1/5] PCI/ERR: Clear status of the reporting device
Date:   Mon,  4 Jan 2021 15:02:56 -0800
Message-Id: <20210104230300.1277180-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210104230300.1277180-1-kbusch@kernel.org>
References: <20210104230300.1277180-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Error handling operates on the first downstream port above the detected
error, but the error may have been reported by a downstream device.
Clear the AER status of the device that reported the error rather than
the first downstream port.

Acked-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pcie/err.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 510f31f0ef6d..a84f0bf4c1e2 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -231,15 +231,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_walk_bridge(bridge, report_resume, &status);
 
 	/*
-	 * If we have native control of AER, clear error status in the Root
-	 * Port or Downstream Port that signaled the error.  If the
-	 * platform retained control of AER, it is responsible for clearing
-	 * this status.  In that case, the signaling device may not even be
-	 * visible to the OS.
+	 * If we have native control of AER, clear error status in the device
+	 * that detected the error.  If the platform retained control of AER,
+	 * it is responsible for clearing this status.  In that case, the
+	 * signaling device may not even be visible to the OS.
 	 */
 	if (host->native_aer || pcie_ports_native) {
-		pcie_clear_device_status(bridge);
-		pci_aer_clear_nonfatal_status(bridge);
+		pcie_clear_device_status(dev);
+		pci_aer_clear_nonfatal_status(dev);
 	}
 	pci_info(bridge, "device recovery successful\n");
 	return status;
-- 
2.24.1

