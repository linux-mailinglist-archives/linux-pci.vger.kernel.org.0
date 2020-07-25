Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97A922D48A
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jul 2020 05:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgGYD7Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 23:59:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:58730 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgGYD7K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 23:59:10 -0400
IronPort-SDR: OyQyJfhj989yufYs5GLBv6qX1zI5q08iqkZddcOrIpuxnVjbhcD9cE24yAuoF/AhMJ3ram1t1o
 AI51/sQQtl6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="212351103"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="212351103"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 20:59:09 -0700
IronPort-SDR: rwDZZpPWz82tTvN8Pt1YoS5kjjVxCj5YiRUhnZhcZeT4h/on/gnF8rD47m/ZZI0uVdD3M8QITR
 HpC1RceGm4SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="489405391"
Received: from pittner-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.77.166])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2020 20:59:09 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v8 4/5] PCI/portdrv: Remove redundant pci_aer_available() check in DPC enable logic
Date:   Fri, 24 Jul 2020 20:58:55 -0700
Message-Id: <27b4894d600a36df2522e3edd9dcf9cce6fe72ee.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1595649348.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

