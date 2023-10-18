Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F9D7CDA88
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 13:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjJRLe2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 07:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjJRLeZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 07:34:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F7B11A;
        Wed, 18 Oct 2023 04:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697628863; x=1729164863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VjreTDi7jjJH97Z5MyoUOCUozCMclaID/DbiusXdx6k=;
  b=n+mNjmKR7c2Bqus+QmqeZqy4DnKw0j/iAXSscaw8HOCvNFgrducuxp7G
   067EiZeIxAzLh3+EPBf7NSPitb4GBmSUFgV0d7pkpCziTU5T4ZOcLGNA6
   2Zncv6woiUzgt6QK0KC/84blXuPu9Sg0Eat5zva/JhXWhPAc79hIHwxW7
   IWw1chKq9p0WO+FODIthqXp8KytqIPmfEGRaqWUwD4hTAq2ogWjeTT1Et
   QJAbjH2AMKK9vYI04le1Rgu6vmFOIMRlBwCDKZ1j/YkBMt4wYnNjKw+ot
   oI1+0twJOoYYDJ4cK/eytJEs1wRmWMY9+jQkBzEurxJw1Ncjro/PFUHiM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="383215893"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="383215893"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:34:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="826855199"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="826855199"
Received: from suguccin-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.44.63])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:34:13 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/7] PCI/DPC: Use FIELD_GET()
Date:   Wed, 18 Oct 2023 14:32:51 +0300
Message-Id: <20231018113254.17616-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com>
References: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use FIELD_GET() to remove dependencies on the field position, i.e., the
shift value. No functional change intended.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/dpc.c        | 5 +++--
 drivers/pci/quirks.c          | 2 +-
 include/uapi/linux/pci_regs.h | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3ceed8e3de41..a5c259ada9ea 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -9,6 +9,7 @@
 #define dev_fmt(fmt) "DPC: " fmt
 
 #include <linux/aer.h>
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -202,7 +203,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 
 	/* Get First Error Pointer */
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &dpc_status);
-	first_error = (dpc_status & 0x1f00) >> 8;
+	first_error = FIELD_GET(PCI_EXP_DPC_RP_PIO_FEP, dpc_status);
 
 	for (i = 0; i < ARRAY_SIZE(rp_pio_error_string); i++) {
 		if ((status & ~mask) & (1 << i))
@@ -338,7 +339,7 @@ void pci_dpc_init(struct pci_dev *pdev)
 	/* Quirks may set dpc_rp_log_size if device or firmware is buggy */
 	if (!pdev->dpc_rp_log_size) {
 		pdev->dpc_rp_log_size =
-			(cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
+				FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, cap);
 		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
 			pci_err(pdev, "RP PIO log size %u is invalid\n",
 				pdev->dpc_rp_log_size);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..a9fdc2e3f110 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6154,7 +6154,7 @@ static void dpc_log_size(struct pci_dev *dev)
 	if (!(val & PCI_EXP_DPC_CAP_RP_EXT))
 		return;
 
-	if (!((val & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8)) {
+	if (FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, val) == 0) {
 		pci_info(dev, "Overriding RP PIO Log Size to 4\n");
 		dev->dpc_rp_log_size = 4;
 	}
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 495f0ae4ecd5..2d6df02a4b93 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1047,6 +1047,7 @@
 #define  PCI_EXP_DPC_STATUS_INTERRUPT	    0x0008 /* Interrupt Status */
 #define  PCI_EXP_DPC_RP_BUSY		    0x0010 /* Root Port Busy */
 #define  PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT 0x0060 /* Trig Reason Extension */
+#define  PCI_EXP_DPC_RP_PIO_FEP		    0x1f00 /* Root Port PIO First Error Pointer */
 
 #define PCI_EXP_DPC_SOURCE_ID		 0x0A	/* DPC Source Identifier */
 
-- 
2.30.2

