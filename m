Return-Path: <linux-pci+bounces-28149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48356ABE650
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AA71B68335
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 21:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA8225F788;
	Tue, 20 May 2025 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdX9Ks0C"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C025E80E;
	Tue, 20 May 2025 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747777854; cv=none; b=fD91U9cELr6HCuCM1QbiJJ/THpEYGqvilONksNRyK/P4gGNWxWeFt4aSmFDULH35errF5TPrbyIAfumeqrb1WIUBCOATtVsHyNM6TklZvrbiHATPq34JOlX+yywssZNZnU+7CCOeUWgt16O/vepSrwGHG2PUX9pRCBDb8LSpf6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747777854; c=relaxed/simple;
	bh=QwvVWrxi7iBWdrqG6pYf4YuhiglWgJnIgPVufOYLSSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYFkmwICknsYd1JmBb8YvQvpYxVPw/GUt8r4SvUM6orQr6sQI0qJwd1CLQPFcpsSWMCZCblCDEDZUkZfozsPNTsI2qMEMkPcIu7PMFlwTBaFquZr7RNtTtq0a8a3JFbXmq9oKrF4EvD2D+95nC/84wN9TRjfPI2K2S38iPtHXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdX9Ks0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6C9C4CEEF;
	Tue, 20 May 2025 21:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747777854;
	bh=QwvVWrxi7iBWdrqG6pYf4YuhiglWgJnIgPVufOYLSSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdX9Ks0CnQ41BiuDz9Ex3aR1oGbwtju+ESW4X8rK6//LJcwoTSRiptr24R1tjOM3H
	 Gkmuc3ZcV9dSJbiGNpeXp7C2Df267ND7gRbWf/X/U+cY8RS9kZfOEIt70Vv3zFdrmm
	 p+elXReVnrJF5qxvqWXuoV6Z+kqFrRqcKgUn1owSTsGumk2pyIdn/ipnnRjH5ut7VK
	 knXJqYh9+d78ppa0JEmjt5LJAMPuwT4c40JoSIKIihN7CBtog6hx/u5V/hWuIbJjt/
	 UWK39D7xV4zXWAuhSzMHpeEsr7AloJc/idKblnw+IKvLdd7Ys6hEH3guc7Wp8DDBEU
	 4CYf9FZNSIaSg==
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
Subject: [PATCH v7 02/17] PCI/DPC: Log Error Source ID only when valid
Date: Tue, 20 May 2025 16:50:19 -0500
Message-ID: <20250520215047.1350603-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520215047.1350603-1-helgaas@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
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

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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


