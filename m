Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9891412AFF3
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2019 01:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfL0Alf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Dec 2019 19:41:35 -0500
Received: from mga02.intel.com ([134.134.136.20]:16202 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbfL0Alf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Dec 2019 19:41:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2019 16:41:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,361,1571727600"; 
   d="scan'208";a="219979351"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga006.jf.intel.com with ESMTP; 26 Dec 2019 16:41:32 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v11 7/8] PCI/DPC: Clear AER registers in EDR mode
Date:   Thu, 26 Dec 2019 16:39:13 -0800
Message-Id: <d24b1321a7b32aa8d1721d593c8fa133cdb2ad00.1577400653.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1577400653.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1577400653.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per PCI firmware specification r3.2 System Firmware Intermediary
(SFI) _OSC and DPC Updates ECR
(https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled
"DPC Event Handling Implementation Note", page 10, OS is responsible
for clearing the AER registers in EDR mode. So clear AER registers in
dpc_process_error() function.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/dpc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index db2e5cb635d7..588ae4f99781 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -284,6 +284,10 @@ static void dpc_process_error(struct dpc_dev *dpc)
 		pci_aer_clear_fatal_status(pdev, 0);
 	}
 
+	/* In EDR mode, OS is responsible for clearing AER registers */
+	if (pcie_aer_get_firmware_first(pdev))
+		pci_cleanup_aer_error_status_regs(pdev, 0);
+
 	/*
 	 * Irrespective of whether the DPC event is triggered by
 	 * ERR_FATAL or ERR_NONFATAL, since the link is already down,
-- 
2.21.0

