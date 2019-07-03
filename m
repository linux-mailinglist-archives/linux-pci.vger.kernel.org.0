Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F26995ED8E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 22:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfGCUcV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 16:32:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:60930 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727289AbfGCUcU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 16:32:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 13:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="158089428"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga008.jf.intel.com with ESMTP; 03 Jul 2019 13:32:18 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 8/8] PCI/DPC: Clear AER registers in EDR mode
Date:   Wed,  3 Jul 2019 13:29:55 -0700
Message-Id: <052bd7e4bccabce2051fcfb9878c7ab3f3abdcb6.1562185606.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1562185606.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1562185606.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per PCI firmware specification r3.2 Downstream Port Containment
Related Enhancements ECN, OS is responsible for clearing the AER
registers in EDR mode. So clear AER registers in dpc_process_error()
function.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 34f4e6ca24df..a04a76d1efe0 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -276,6 +276,10 @@ static void dpc_process_error(struct dpc_dev *dpc)
 			pci_aer_clear_fatal_status(pdev);
 	}
 
+	/* In EDR mode, OS is responsible for clearing AER registers */
+	if (dpc->firmware_dpc)
+		pci_cleanup_aer_error_status_regs(pdev);
+
 	/*
 	 * Irrespective of whether the DPC event is triggered by
 	 * ERR_FATAL or ERR_NONFATAL, since the link is already down,
-- 
2.21.0

