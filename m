Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5081F0CE5
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jun 2020 18:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgFGQU2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Jun 2020 12:20:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:61717 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgFGQUP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 7 Jun 2020 12:20:15 -0400
IronPort-SDR: eKpJnsWQToC5KihUAqN7XGd9tvY6mAG3jO0EUsoOLbnUXj8/d9amNdoLwpsUbN+/lb1S8Milan
 yHMSinoN5Sow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2020 09:20:14 -0700
IronPort-SDR: rVyeuHvLRWNpx6PPXW8s9/WefTd23njzcDTt2vJ5b7o8vG0ymi/zU49eH3NJlzVOF3wSnLZFzV
 oa6PA22nC0UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,484,1583222400"; 
   d="scan'208";a="348938499"
Received: from skaushal-mobl5.gar.corp.intel.com (HELO localhost.localdomain) ([10.255.229.193])
  by orsmga001.jf.intel.com with ESMTP; 07 Jun 2020 09:20:13 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v5 3/4] PCI/portdrv: Remove redundant pci_aer_available() check in DPC enable logic
Date:   Sun,  7 Jun 2020 09:20:00 -0700
Message-Id: <3d4e2e8ddfd50c24cf2f1618fce9338dbea5a7f5.1591545462.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1591545462.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1591545462.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

In DPC service enable logic, check for
services & PCIE_PORT_SERVICE_AER implies pci_aer_available()
is true. So there is no need to explicitly check it again.

Also, passing pcie_ports=dpc-native in kernel command line
implies DPC needs to be enabled in native mode irrespective
of AER ownership status. So checking for pci_aer_available()
without checking for pcie_ports status is incorrect.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/portdrv_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 2c0278f0fdcc..e257a2ca3595 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -252,7 +252,6 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 * permission to use AER.
 	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-	    pci_aer_available() &&
 	    (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
 		services |= PCIE_PORT_SERVICE_DPC;
 
-- 
2.17.1

