Return-Path: <linux-pci+bounces-33928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89725B24042
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 07:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F968585519
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 05:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809A02BE05F;
	Wed, 13 Aug 2025 05:35:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE49D1E835B
	for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063314; cv=none; b=UtW/mvUob8fdive2UxuJFxW4LZ3y3X7blgYP0LX3rycO2uX/FTdg3EO36zwHAxTytbsywW2KIDNxV8cWYAfz/9hFecPB0ZJKeUbEm6ohzl/OjNP5VQ2y8dwq6rXCdwWQyple9I70kxQmaxGDderEEwFECcLs/jCSFP3d3knWqCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063314; c=relaxed/simple;
	bh=HtH8WRTMHVPXnJFRwo3xzR1yyZI9pDwgfFKujxLzJ74=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=aLakkR18t5DNkBMnFEMkc2BregEM37zv7R4y/vU46dC05NZQHFExxJnOMgUAixGkjWid//QNIumD2sr7JleQtaRgHTnAw8OTD6CyYedsbNfHWa5kmU5X4XtRxWFgMOsU1zhBUHtA+Ea6VHBDljMbbDfJDnRaBxJMU3OmwiEnIOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with UTF8SMTPS id 34A712C1E4C7;
	Wed, 13 Aug 2025 07:27:06 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id EBC256000EA5;
	Wed, 13 Aug 2025 07:27:05 +0200 (CEST)
X-Mailbox-Line: From 68fc527a380821b5d861dd554d2ce42cb739591c Mon Sep 17 00:00:00 2001
Message-ID: <68fc527a380821b5d861dd554d2ce42cb739591c.1755008151.git.lukas@wunner.de>
In-Reply-To: <cover.1755008151.git.lukas@wunner.de>
References: <cover.1755008151.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 13 Aug 2025 07:11:02 +0200
Subject: [PATCH 2/5] PCI/ERR: Fix uevent on failure to recover
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>, Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>, "Sean C. Dardis" <sean.c.dardis@intel.com>, Terry Bowman <terry.bowman@amd.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Linas Vepstas <linasvepstas@gmail.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, "Oliver OHalloran" <oohall@gmail.com>, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Upon failure to recover from a PCIe error through AER, DPC or EDR, a
uevent is sent to inform user space about disconnection of the bridge
whose subordinate devices failed to recover.

However the bridge itself is not disconnected.  Instead, a uevent should
be sent for each of the subordinate devices.

Only if the "bridge" happens to be a Root Complex Event Collector or
Integrated Endpoint does it make sense to send a uevent for it (because
there are no subordinate devices).

Right now if there is a mix of subordinate devices with and without
pci_error_handlers, a BEGIN_RECOVERY event is sent for those with
pci_error_handlers but no FAILED_RECOVERY event is ever sent for them
afterwards.  Fix it.

Fixes: 856e1eb9bdd4 ("PCI/AER: Add uevents in AER and EEH error/resume")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org  # v4.16+
---
 drivers/pci/pcie/err.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index e795e5ae6b03..21d554359fb1 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -108,6 +108,12 @@ static int report_normal_detected(struct pci_dev *dev, void *data)
 	return report_error_detected(dev, pci_channel_io_normal, data);
 }
 
+static int report_perm_failure_detected(struct pci_dev *dev, void *data)
+{
+	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
+	return 0;
+}
+
 static int report_mmio_enabled(struct pci_dev *dev, void *data)
 {
 	struct pci_driver *pdrv;
@@ -272,7 +278,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 failed:
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
 
-	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
+	pci_walk_bridge(bridge, report_perm_failure_detected, NULL);
 
 	pci_info(bridge, "device recovery failed\n");
 
-- 
2.47.2


