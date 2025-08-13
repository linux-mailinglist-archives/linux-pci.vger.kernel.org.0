Return-Path: <linux-pci+bounces-33931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF5BB240B8
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 07:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2111AA4F8F
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 05:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BFD2C08AB;
	Wed, 13 Aug 2025 05:51:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FCF288C25;
	Wed, 13 Aug 2025 05:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064309; cv=none; b=EvIrfCT/ZRoK2HORZER/owV/RLOUKbg7LsIteOeyIfGO0h/00YI5IwrY86Uc1del/ipB3uikwbhxamDrjxtzlXvxDXslveeQP7AOILU3Txs4++FBavMvP8Hy4da7krCks+Huv8wTa4pieoj2kKk3SFjBJsAj6HB0UMWEb9uzm8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064309; c=relaxed/simple;
	bh=nWnp3IXM1iz81ZjutHNbtjNYh3k8Iu/UHIL/Nxw90fg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=nxW88KsiH3Uq5cdGmF4bCQ2nNgyATJaJ9Ud5CGQTKshqJpwKwTUyuScYj79a9ygWe7ICRHSjkjmEf3sJxDHCLIJysHrfXHywlrOVB8wR8DE3kDy7xcMjDqvS1SnL8sZkUL4gIRfWuQDPHp5ri78qDJAuxC+O+KmWZXxRtCLsU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with UTF8SMTPS id 624AE3006AC8;
	Wed, 13 Aug 2025 07:44:37 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id 0DAAF6031F22;
	Wed, 13 Aug 2025 07:44:37 +0200 (CEST)
X-Mailbox-Line: From 1d72a891a7f57115e78a73046e776f7e0c8cd68f Mon Sep 17 00:00:00 2001
Message-ID: <1d72a891a7f57115e78a73046e776f7e0c8cd68f.1755008151.git.lukas@wunner.de>
In-Reply-To: <cover.1755008151.git.lukas@wunner.de>
References: <cover.1755008151.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 13 Aug 2025 07:11:05 +0200
Subject: [PATCH 5/5] PCI/ERR: Remove remnants of .link_reset() callback
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>, Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>, "Sean C. Dardis" <sean.c.dardis@intel.com>, Terry Bowman <terry.bowman@amd.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Linas Vepstas <linasvepstas@gmail.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, "Oliver OHalloran" <oohall@gmail.com>, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, Edward Cree <ecree.xilinx@gmail.com>, linux-net-drivers@amd.com, James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni
 @redhat.com>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Back in 2017, commit 2fd260f03b6a ("PCI/AER: Remove unused .link_reset()
callback") removed .link_reset() from struct pci_error_handlers, but left
a few code comments behind which still mention it.  Remove them.

The code comments in the SolarFlare Ethernet drivers point out that no
.mmio_enabled() callback is needed because the driver's .error_detected()
callback always returns PCI_ERS_RESULT_NEED_RESET, which causes
pcie_do_recovery() to skip .mmio_enabled().  That's not quite correct
because efx_io_error_detected() does return PCI_ERS_RESULT_RECOVERED under
certain conditions and then .mmio_enabled() would indeed be called if it
were implemented.  Remove this misleading portion of the code comment as
well.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/net/ethernet/sfc/efx_common.c       | 3 ---
 drivers/net/ethernet/sfc/falcon/efx.c       | 3 ---
 drivers/net/ethernet/sfc/siena/efx_common.c | 3 ---
 drivers/scsi/lpfc/lpfc_init.c               | 2 +-
 4 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
index 5a14d94163b1..e8fdbb62d872 100644
--- a/drivers/net/ethernet/sfc/efx_common.c
+++ b/drivers/net/ethernet/sfc/efx_common.c
@@ -1258,9 +1258,6 @@ static void efx_io_resume(struct pci_dev *pdev)
 
 /* For simplicity and reliability, we always require a slot reset and try to
  * reset the hardware when a pci error affecting the device is detected.
- * We leave both the link_reset and mmio_enabled callback unimplemented:
- * with our request for slot reset the mmio_enabled callback will never be
- * called, and the link_reset callback is not used by AER or EEH mechanisms.
  */
 const struct pci_error_handlers efx_err_handlers = {
 	.error_detected = efx_io_error_detected,
diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
index b07f7e4e2877..0c784656fde9 100644
--- a/drivers/net/ethernet/sfc/falcon/efx.c
+++ b/drivers/net/ethernet/sfc/falcon/efx.c
@@ -3128,9 +3128,6 @@ static void ef4_io_resume(struct pci_dev *pdev)
 
 /* For simplicity and reliability, we always require a slot reset and try to
  * reset the hardware when a pci error affecting the device is detected.
- * We leave both the link_reset and mmio_enabled callback unimplemented:
- * with our request for slot reset the mmio_enabled callback will never be
- * called, and the link_reset callback is not used by AER or EEH mechanisms.
  */
 static const struct pci_error_handlers ef4_err_handlers = {
 	.error_detected = ef4_io_error_detected,
diff --git a/drivers/net/ethernet/sfc/siena/efx_common.c b/drivers/net/ethernet/sfc/siena/efx_common.c
index a0966f879664..35036cc902fe 100644
--- a/drivers/net/ethernet/sfc/siena/efx_common.c
+++ b/drivers/net/ethernet/sfc/siena/efx_common.c
@@ -1285,9 +1285,6 @@ static void efx_io_resume(struct pci_dev *pdev)
 
 /* For simplicity and reliability, we always require a slot reset and try to
  * reset the hardware when a pci error affecting the device is detected.
- * We leave both the link_reset and mmio_enabled callback unimplemented:
- * with our request for slot reset the mmio_enabled callback will never be
- * called, and the link_reset callback is not used by AER or EEH mechanisms.
  */
 const struct pci_error_handlers efx_siena_err_handlers = {
 	.error_detected = efx_io_error_detected,
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 4081d2a358ee..cf08bb5b37c3 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -14377,7 +14377,7 @@ lpfc_sli_prep_dev_for_perm_failure(struct lpfc_hba *phba)
  * as desired.
  *
  * Return codes
- * 	PCI_ERS_RESULT_CAN_RECOVER - can be recovered with reset_link
+ *	PCI_ERS_RESULT_CAN_RECOVER - can be recovered without reset
  * 	PCI_ERS_RESULT_NEED_RESET - need to reset before recovery
  * 	PCI_ERS_RESULT_DISCONNECT - device could not be recovered
  **/
-- 
2.47.2


