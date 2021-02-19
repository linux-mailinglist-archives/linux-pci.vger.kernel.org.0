Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE18031F3FB
	for <lists+linux-pci@lfdr.de>; Fri, 19 Feb 2021 03:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBSCZX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Feb 2021 21:25:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:59705 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBSCZX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Feb 2021 21:25:23 -0500
IronPort-SDR: SdkfUqqtNLkhT8HhhHceBHIRPjCcPt/J90dRISrW6P8v59V79153pAWX83RDL5VHCquX7ya4P8
 lS2Iyc2R0zWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="163496464"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="163496464"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:24:42 -0800
IronPort-SDR: wridYpnCfqyWboBlmTMXUpYK/L+B6bq2R9zDkep7T1n9mtxU6ktvQ5/3xBnRyOXQLBbQhtrI7f
 bPrSmqKF1VbQ==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="400797364"
Received: from qiuxu-lab.sh.intel.com ([10.239.53.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:24:40 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Jin, Wen" <wen.jin@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] PCI/RCEC: Fix RCiEP capable devices RCEC association
Date:   Fri, 19 Feb 2021 10:23:59 +0800
Message-Id: <20210219022359.435-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <57a7bbc1ba294ce39c309e519fe45842@intel.com>
References: <57a7bbc1ba294ce39c309e519fe45842@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Function rcec_assoc_rciep() incorrectly used "rciep->devfn" (a single
byte encoding the device and function number) as the device number to
check whether the corresponding bit was set in the RCiEPBitmap of the
RCEC (Root Complex Event Collector) while enumerating over each bit of
the RCiEPBitmap.

As per the PCI Express Base Specification, Revision 5.0, Version 1.0,
Section 7.9.10.2, "Association Bitmap for RCiEPs", p. 935, only needs to
use a device number to check whether the corresponding bit was set in
the RCiEPBitmap.

Fix rcec_assoc_rciep() using the PCI_SLOT() macro and convert the value
of "rciep->devfn" to a device number to ensure that the RCiEP devices
associated with the RCEC are linked when the RCEC is enumerated.

[ Krzysztof: Update commit message. ]

Fixes: 507b460f8144 ("PCI/ERR: Add pcie_link_rcec() to associate RCiEPs")
Reported-and-tested-by: Wen Jin <wen.jin@intel.com>
Reviewed-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
v1->v2:
  - Update the subject and the commit message.
  - Add 'Reviewed-by: Sean V Kelley <sean.v.kelley@intel.com>' to the SoB chain.

 drivers/pci/pcie/rcec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
index 2c5c552994e4..d0bcd141ac9c 100644
--- a/drivers/pci/pcie/rcec.c
+++ b/drivers/pci/pcie/rcec.c
@@ -32,7 +32,7 @@ static bool rcec_assoc_rciep(struct pci_dev *rcec, struct pci_dev *rciep)
 
 	/* Same bus, so check bitmap */
 	for_each_set_bit(devn, &bitmap, 32)
-		if (devn == rciep->devfn)
+		if (devn == PCI_SLOT(rciep->devfn))
 			return true;
 
 	return false;
-- 
2.17.1

