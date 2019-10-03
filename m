Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF40CB266
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 01:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbfJCXlr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Oct 2019 19:41:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:39187 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731838AbfJCXli (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Oct 2019 19:41:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2019 16:41:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,254,1566889200"; 
   d="scan'208";a="343819289"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga004.jf.intel.com with ESMTP; 03 Oct 2019 16:41:35 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v9 7/8] PCI/DPC: Clear AER registers in EDR mode
Date:   Thu,  3 Oct 2019 16:39:03 -0700
Message-Id: <d4e51ce547feb6251ee2c64a4141c6dc772717ac.1570145778.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570145778.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1570145778.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
Acked-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/dpc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index fafc55c00fe0..de2d892bc7c4 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -275,6 +275,10 @@ static void dpc_process_error(struct dpc_dev *dpc)
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

