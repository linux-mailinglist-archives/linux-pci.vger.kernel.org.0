Return-Path: <linux-pci+bounces-33929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE367B24047
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 07:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F18016BA08
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 05:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C812BE7D6;
	Wed, 13 Aug 2025 05:37:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0A29C325
	for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 05:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063464; cv=none; b=SI6FMtm/Z3uqlTO0j/JAYjpQVKFwynBk24Iu709LOcijR0IP5Mc5vC3Ra1aqlxL2JuKTbDj23WRB3R+STRbzKxWI17bGHORkvRwT/iuWtScGXwlx6d/F/l/7DagQAMJZLZvJpdPb7e9WjrXimLpi8JZX9VIkqqrClQ+61t5vfn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063464; c=relaxed/simple;
	bh=/CnKAyxLWPd1vpL5iHn1zWjIdMZ1AALBrE/NWA1v6w8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=MbNGZSsZDrDSEI8ywUCv06kDekJQ8DLnkdi06/FnjQ6Ib2ITdi7SEClyJJr0XbpYY5vQatG5+p5WuoTM6mOXJhUmyIMJGrxliTF2TlfJ8THYbr9riOitgWPrm4Z73vPWdJm9h2vmTx3YwgQ8KPJHg1+UJMnr9XmfX9fOZ938KcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with UTF8SMTPS id DF6522C1E4C7;
	Wed, 13 Aug 2025 07:37:40 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id AD9EC6029EED;
	Wed, 13 Aug 2025 07:37:40 +0200 (CEST)
X-Mailbox-Line: From ec212d4d4f5c65d29349df33acdc9768ff8279d1 Mon Sep 17 00:00:00 2001
Message-ID: <ec212d4d4f5c65d29349df33acdc9768ff8279d1.1755008151.git.lukas@wunner.de>
In-Reply-To: <cover.1755008151.git.lukas@wunner.de>
References: <cover.1755008151.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 13 Aug 2025 07:11:03 +0200
Subject: [PATCH 3/5] PCI/ERR: Notify drivers on failure to recover
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>, Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>, "Sean C. Dardis" <sean.c.dardis@intel.com>, Terry Bowman <terry.bowman@amd.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Linas Vepstas <linasvepstas@gmail.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, "Oliver OHalloran" <oohall@gmail.com>, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

According to Documentation/PCI/pci-error-recovery.rst, the following shall
occur on failure to recover from a PCIe Uncorrectable Error:

  STEP 6: Permanent Failure
  -------------------------
  A "permanent failure" has occurred, and the platform cannot recover
  the device.  The platform will call error_detected() with a
  pci_channel_state_t value of pci_channel_io_perm_failure.

  The device driver should, at this point, assume the worst. It should
  cancel all pending I/O, refuse all new I/O, returning -EIO to
  higher layers. The device driver should then clean up all of its
  memory and remove itself from kernel operations, much as it would
  during system shutdown.

Sathya notes that AER does not call error_detected() on failure and thus
deviates from the document (as well as EEH, for which the document was
originally added).

Most drivers do nothing on permanent failure, but the SCSI drivers and a
number of Ethernet drivers do take advantage of the notification to flush
queues and give up resources.

Amend AER to notify such drivers and align with the documentation and EEH.

Link: https://lore.kernel.org/r/f496fc0f-64d7-46a4-8562-dba74e31a956@linux.intel.com/
Suggested-by: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/err.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 21d554359fb1..930bb60fb761 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -110,7 +110,19 @@ static int report_normal_detected(struct pci_dev *dev, void *data)
 
 static int report_perm_failure_detected(struct pci_dev *dev, void *data)
 {
+	struct pci_driver *pdrv;
+	const struct pci_error_handlers *err_handler;
+
+	device_lock(&dev->dev);
+	pdrv = dev->driver;
+	if (!pdrv || !pdrv->err_handler || !pdrv->err_handler->error_detected)
+		goto out;
+
+	err_handler = pdrv->err_handler;
+	err_handler->error_detected(dev, pci_channel_io_perm_failure);
+out:
 	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
+	device_unlock(&dev->dev);
 	return 0;
 }
 
-- 
2.47.2


