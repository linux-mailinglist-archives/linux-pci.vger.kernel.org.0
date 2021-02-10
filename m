Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D0D315CE8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 03:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbhBJCJB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 21:09:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:55654 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234773AbhBJCIT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Feb 2021 21:08:19 -0500
IronPort-SDR: cX3nKQXXP2jtkstCRz/RYYSAMY2ZxnjKreYAA5NaaiF0id1Axz15nXLG3ZYobDGsIohpjzk+vX
 LxmQ+aP8h9ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="161748060"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="161748060"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 18:07:09 -0800
IronPort-SDR: ZIYRofkClCG24wq35CWWIL37qCS+WZ7fnXiO5uUlOMBxLH38CZ0OxTDLEznqHRg67Ik/8bn1kA
 tAertE8fxlag==
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="379628247"
Received: from qiuxu-lab.sh.intel.com ([10.239.53.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 18:07:06 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Jin, Wen" <wen.jin@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] PCI/RCEC: Fix failure to inject errors to some RCiEP devices
Date:   Wed, 10 Feb 2021 10:05:16 +0800
Message-Id: <20210210020516.95292-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On a Sapphire Rapids server, it failed to inject correctable errors
to the RCiEP device e8:02.0 which was associated with the RCEC device
e8:00.4. See the following error log before applying the patch:

aer-inject -s e8:02.0 examples/correctable
Error: Failed to write, No such device

This was because rcec_assoc_rciep() mistakenly used "rciep->devfn" as
device number to check whether the corresponding bit was set in
the RCiEPBitmap of the RCEC. So that the RCiEP device e8:02.0 wasn't
linked to the RCEC and resulted in the above error.

Fix it by using PCI_SLOT() to convert rciep->devfn to device number.
Ensure that the RCiEP devices associated with the RCEC are linked to
the RCEC as the RCEC is enumerated. After applying the patch, correctable
errors can be injected to the RCiEP successfully.

Reported-and-tested-by: Wen Jin <wen.jin@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
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

