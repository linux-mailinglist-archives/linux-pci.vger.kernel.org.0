Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D562299645
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 19:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1791034AbgJZS6P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 14:58:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:52492 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1791039AbgJZS6J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 14:58:09 -0400
IronPort-SDR: 4H4bbXMAyMu2jdyOxfh/Lr0p+xoGNj4ItFHl+B+pUIY1tMmVTZpkA8zKG5Ga3G+2fGshYaOtRZ
 76/xwc7lpeLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168073148"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="168073148"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 11:58:07 -0700
IronPort-SDR: ZxGJ7nXIwwtu8Ac4Rg28Jx88yhF3qFt7Wh3WbAzEwYpsNXiduhBDgXaoDBUS/WvB8qONgTVv2D
 Ia1KwPVcCBJA==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="525607463"
Received: from dhrubajy-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.53])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 11:58:07 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        knsathya@kernel.org
Subject: [PATCH v10 4/5] PCI/portdrv: Remove redundant pci_aer_available() check in DPC enable logic
Date:   Mon, 26 Oct 2020 11:56:42 -0700
Message-Id: <fbb336832e5105d3879bf117e90cfe0db6fc5217.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

