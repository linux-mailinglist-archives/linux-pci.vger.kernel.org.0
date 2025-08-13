Return-Path: <linux-pci+bounces-33930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813C3B24076
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 07:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBFD18895DD
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 05:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217DD2BEFE3;
	Wed, 13 Aug 2025 05:38:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208EA2BF3F4;
	Wed, 13 Aug 2025 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063539; cv=none; b=qeyDwsSW/2+BzuOg+rTmKZw7o1rzpS8fIjaxuKs8ujh1bNvsjqIMJOk8vuKK0bFQBFpjK+uDQ54DnXNu44hkY2yOwuh1Ew8casB9GEwcO/EFoj/SKqLqk9t76YlTb0v95irRxJcRKUvFyyye7vcV3/Jl4XWZfeEEg2PpC9vd/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063539; c=relaxed/simple;
	bh=DnHe/8uhrTSolwGbLrqRvX8yq71GzArGeEqXIun4kOI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=AN10cT6lITsWABmvIZ3U6TxQbb4bD98xTZCrwzRPm1D9kIsBhajOdJgIMZu1OPoOuU3GkEwA4IRSo8HMcbeLyo4rI2xx8jVuB/M5Q/pio87JKwva0Kib5kHva7af2+/xwjE1CQ57u1EN7mjnPhM7Mrj2WaRJn2sIGir2Im0adxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with UTF8SMTPS id C5F3A18C4C;
	Wed, 13 Aug 2025 07:38:54 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id 8F1496031AA6;
	Wed, 13 Aug 2025 07:38:54 +0200 (CEST)
X-Mailbox-Line: From 4517af6359ffb9d66152b827a5d2833459144e3f Mon Sep 17 00:00:00 2001
Message-ID: <4517af6359ffb9d66152b827a5d2833459144e3f.1755008151.git.lukas@wunner.de>
In-Reply-To: <cover.1755008151.git.lukas@wunner.de>
References: <cover.1755008151.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 13 Aug 2025 07:11:04 +0200
Subject: [PATCH 4/5] PCI/ERR: Update device error_state already after reset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>,
	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
	"Sean C. Dardis" <sean.c.dardis@intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Linas Vepstas <linasvepstas@gmail.com>,
	"Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
	"Oliver OHalloran" <oohall@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <"ku ba"@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

After a Fatal Error has been reported by a device and has been recovered
through a Secondary Bus Reset, AER updates the device's error_state to
pci_channel_io_normal before invoking its driver's ->resume() callback.

By contrast, EEH updates the error_state earlier, namely after resetting
the device and before invoking its driver's ->slot_reset() callback.
Commit c58dc575f3c8 ("powerpc/pseries: Set error_state to
pci_channel_io_normal in eeh_report_reset()") explains in great detail
that the earlier invocation is necessitated by various drivers checking
accessibility of the device with pci_channel_offline() and avoiding
accesses if it returns true.  It returns true for any other error_state
than pci_channel_io_normal.

The device should be accessible already after reset, hence the reasoning
is that it's safe to update the error_state immediately afterwards.

This deviation between AER and EEH seems problematic because drivers
behave differently depending on which error recovery mechanism the
platform uses.  Three drivers have gone so far as to update the
error_state themselves, presumably to work around AER's behavior.

For consistency, amend AER to update the error_state at the same recovery
steps as EEH.  Drop the now unnecessary workaround from the three drivers.

Keep updating the error_state before ->resume() in case ->error_detected()
or ->mmio_enabled() return PCI_ERS_RESULT_RECOVERED, which causes
->slot_reset() to be skipped.  There are drivers doing this even for Fatal
Errors, e.g. mhi_pci_error_detected().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c | 1 -
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c    | 2 --
 drivers/pci/pcie/err.c                              | 3 ++-
 drivers/scsi/qla2xxx/qla_os.c                       | 5 -----
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
index d7cdea8f604d..91e7b38143ea 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -4215,7 +4215,6 @@ static pci_ers_result_t qlcnic_83xx_io_slot_reset(struct pci_dev *pdev)
 	struct qlcnic_adapter *adapter = pci_get_drvdata(pdev);
 	int err = 0;
 
-	pdev->error_state = pci_channel_io_normal;
 	err = pci_enable_device(pdev);
 	if (err)
 		goto disconnect;
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
index 53cdd36c4123..e051d8c7a28d 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_main.c
@@ -3766,8 +3766,6 @@ static int qlcnic_attach_func(struct pci_dev *pdev)
 	struct qlcnic_adapter *adapter = pci_get_drvdata(pdev);
 	struct net_device *netdev = adapter->netdev;
 
-	pdev->error_state = pci_channel_io_normal;
-
 	err = pci_enable_device(pdev);
 	if (err)
 		return err;
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 930bb60fb761..bebe4bc111d7 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -153,7 +153,8 @@ static int report_slot_reset(struct pci_dev *dev, void *data)
 
 	device_lock(&dev->dev);
 	pdrv = dev->driver;
-	if (!pdrv || !pdrv->err_handler || !pdrv->err_handler->slot_reset)
+	if (!pci_dev_set_io_state(dev, pci_channel_io_normal) ||
+	    !pdrv || !pdrv->err_handler || !pdrv->err_handler->slot_reset)
 		goto out;
 
 	err_handler = pdrv->err_handler;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index d4b484c0fd9d..4460421834cb 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -7883,11 +7883,6 @@ qla2xxx_pci_slot_reset(struct pci_dev *pdev)
 	       "Slot Reset.\n");
 
 	ha->pci_error_state = QLA_PCI_SLOT_RESET;
-	/* Workaround: qla2xxx driver which access hardware earlier
-	 * needs error state to be pci_channel_io_online.
-	 * Otherwise mailbox command timesout.
-	 */
-	pdev->error_state = pci_channel_io_normal;
 
 	pci_restore_state(pdev);
 
-- 
2.47.2


