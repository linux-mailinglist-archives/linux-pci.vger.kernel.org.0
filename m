Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79FE320EFD
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 02:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBVBSD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Feb 2021 20:18:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:16866 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhBVBSC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 21 Feb 2021 20:18:02 -0500
IronPort-SDR: Qz7k2j+NlNLcH4GnGFlVWDa2N3t/MSSYQjCjV6SFxUC8jBQmHzvq+0sbf5ARdB5PZzBK7Ogd7a
 xQLADd5mTcsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9902"; a="163508221"
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="163508221"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 17:17:21 -0800
IronPort-SDR: JpFBsS5FfOtqOFdx+oG2MqSRlAKrfPDQZuqavKtqDBP2U4jHQxyeNfH8C0hRVM/qtk6pJ8xthC
 crHysZ/sVJqw==
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="402317241"
Received: from qiuxu-lab.sh.intel.com ([10.239.53.1])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 17:17:18 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Jin, Wen" <wen.jin@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] PCI/RCEC: Fix RCiEP capable devices RCEC association
Date:   Mon, 22 Feb 2021 09:17:17 +0800
Message-Id: <20210222011717.43266-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <4a0bf3a852ed47deb072890319fb39ec@intel.com>
References: <4a0bf3a852ed47deb072890319fb39ec@intel.com>
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

Fixes: 507b460f8144 ("PCI/ERR: Add pcie_link_rcec() to associate RCiEPs")
Reported-and-tested-by: Wen Jin <wen.jin@intel.com>
Reviewed-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
v2->v3:
 Drop "[ Krzysztof: Update commit message. ]" from the commit message

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

