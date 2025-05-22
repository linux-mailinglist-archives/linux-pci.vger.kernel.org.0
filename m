Return-Path: <linux-pci+bounces-28289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D507AC17AA
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01403AF70D
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10D02D193A;
	Thu, 22 May 2025 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkcntFcJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C2F2D1932;
	Thu, 22 May 2025 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956228; cv=none; b=YosQIwsjS1ZXy9Iu9ynHleG3sXLzYgDaPBT0RQxipKaSn850QigHhBzBTXIMUBfudo6RKL1/9m0BccaNkjsnou00/ZmgcmJaUvGYNUrxjI0/fRq/g4V8FRMqZMuk3dj+dqhYtPUoJHFHXrAZZljVUscTqjQDcY7aoemo5+SiEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956228; c=relaxed/simple;
	bh=pn/dR/CbimTLWHM7EyVtv7Q1clQ07rb3CKvRX8pteXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRsO6C/wOCBg2Snl2vu4eFmMT/2SMj9rILjiw0LCeSMYkKvfDUGhQVYmS6FFjAwELcuowWK0+FgwTxZS933uy6TmVG/J9gi0QiyT6QLwc//ZI7DZ2UFDCxhnR8UNyqHiGw2DKojSMORVK5mR0rZ7OjUlhLx4gSIuVgubBK0TIy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkcntFcJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFF0C4CEE4;
	Thu, 22 May 2025 23:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747956228;
	bh=pn/dR/CbimTLWHM7EyVtv7Q1clQ07rb3CKvRX8pteXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WkcntFcJCToN90oNzgVQTYsDXxVket++VztYoB6dE3jgAX63R3KmKwswXdX5dqfWJ
	 +ZIF7ZW4xQSpHIUFfb7l1JS37VXwZUKhy70aB8CCaNQeN+G3kDr9FQYU9sksequ5dU
	 BBCW7SLm2+Vg2rEh6o2B2DXQsDiW39JFhMMIqrbHfaHN1biJQkXFPUFUelBpWoBFtq
	 S6gZ4lA8tRYM7GmNm6590IFB6i8NePxkPNPIPMmgdnvnuCbzq/d4FrnL6XhF3FyTSi
	 XdH/1JqCul0CAlAGM06P7hOazwIshJSv1o/hli7HnPbCnXN6LfvJEfRZmKmp7fQip0
	 omdKkGnFiFX+g==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: [PATCH v8 02/20] PCI/DPC: Log Error Source ID only when valid
Date: Thu, 22 May 2025 18:21:08 -0500
Message-ID: <20250522232339.1525671-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522232339.1525671-1-helgaas@kernel.org>
References: <20250522232339.1525671-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

DPC Error Source ID is only valid when the DPC Trigger Reason indicates
that DPC was triggered due to reception of an ERR_NONFATAL or ERR_FATAL
Message (PCIe r6.0, sec 7.9.14.5).

When DPC was triggered by ERR_NONFATAL (PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE)
or ERR_FATAL (PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) from a downstream device,
log the Error Source ID (decoded into domain/bus/device/function).  Don't
print the source otherwise, since it's not valid.

For DPC trigger due to reception of ERR_NONFATAL or ERR_FATAL, the dmesg
logging changes:

  - pci 0000:00:01.0: DPC: containment event, status:0x000d source:0x0200
  - pci 0000:00:01.0: DPC: ERR_FATAL detected
  + pci 0000:00:01.0: DPC: containment event, status:0x000d, ERR_FATAL received from 0000:02:00.0

and when DPC triggered for other reasons, where DPC Error Source ID is
undefined, e.g., unmasked uncorrectable error:

  - pci 0000:00:01.0: DPC: containment event, status:0x0009 source:0x0200
  - pci 0000:00:01.0: DPC: unmasked uncorrectable error detected
  + pci 0000:00:01.0: DPC: containment event, status:0x0009: unmasked uncorrectable error detected

Previously the "containment event" message was at KERN_INFO and the
"%s detected" message was at KERN_WARNING.  Now the single message is at
KERN_WARNING.

Fixes: 26e515713342 ("PCI: Add Downstream Port Containment driver")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20250520215047.1350603-3-helgaas@kernel.org
---
 drivers/pci/pcie/dpc.c | 64 ++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3daaf61c79c9..9d85f1b3b761 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -261,37 +261,45 @@ void dpc_process_error(struct pci_dev *pdev)
 	struct aer_err_info info = {};
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
-	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
-
-	pci_info(pdev, "containment event, status:%#06x source:%#06x\n",
-		 status, source);
 
 	reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN;
-	ext_reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT;
-	pci_warn(pdev, "%s detected\n",
-		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR) ?
-		 "unmasked uncorrectable error" :
-		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE) ?
-		 "ERR_NONFATAL" :
-		 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
-		 "ERR_FATAL" :
-		 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO) ?
-		 "RP PIO error" :
-		 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_SW_TRIGGER) ?
-		 "software trigger" :
-		 "reserved error");
 
-	/* show RP PIO error detail information */
-	if (pdev->dpc_rp_extensions &&
-	    reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT &&
-	    ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO)
-		dpc_process_rp_pio_error(pdev);
-	else if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR &&
-		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
-		 aer_get_device_error_info(pdev, &info)) {
-		aer_print_error(pdev, &info);
-		pci_aer_clear_nonfatal_status(pdev);
-		pci_aer_clear_fatal_status(pdev);
+	switch (reason) {
+	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR:
+		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
+			 status);
+		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
+		    aer_get_device_error_info(pdev, &info)) {
+			aer_print_error(pdev, &info);
+			pci_aer_clear_nonfatal_status(pdev);
+			pci_aer_clear_fatal_status(pdev);
+		}
+		break;
+	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE:
+	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE:
+		pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID,
+				     &source);
+		pci_warn(pdev, "containment event, status:%#06x, %s received from %04x:%02x:%02x.%d\n",
+			 status,
+			 (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE) ?
+				"ERR_FATAL" : "ERR_NONFATAL",
+			 pci_domain_nr(pdev->bus), PCI_BUS_NUM(source),
+			 PCI_SLOT(source), PCI_FUNC(source));
+		break;
+	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT:
+		ext_reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT;
+		pci_warn(pdev, "containment event, status:%#06x: %s detected\n",
+			 status,
+			 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO) ?
+			 "RP PIO error" :
+			 (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_SW_TRIGGER) ?
+			 "software trigger" :
+			 "reserved error");
+		/* show RP PIO error detail information */
+		if (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO &&
+		    pdev->dpc_rp_extensions)
+			dpc_process_rp_pio_error(pdev);
+		break;
 	}
 }
 
-- 
2.43.0


