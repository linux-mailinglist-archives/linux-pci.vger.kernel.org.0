Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4AA62A85AC
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 19:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgKESGs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 13:06:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:28684 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKESGs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 13:06:48 -0500
IronPort-SDR: LqpQtIhIr/Etz69LhYiesmJA3VZ17ATZzhZGUNl/iVlzPNuWa468SRCqWRSC2471r1wGXCut4u
 AnaWSLL2IeGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="254138495"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="254138495"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 10:06:47 -0800
IronPort-SDR: HFbDWWUYKKu2BPtEyB/CyyrNTeHoA6y9eTOMZjFeKolSt2AUmHHpKqem+7T10fxBo4lWCN+JRB
 QhCapuagznsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="528058222"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 05 Nov 2020 10:06:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A765A213; Thu,  5 Nov 2020 20:06:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        johan@kernel.org, linux-usb@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] PCI: Use predefined Pericom vendor ID
Date:   Thu,  5 Nov 2020 20:06:44 +0200
Message-Id: <20201105180644.42862-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105180644.42862-1-andriy.shevchenko@linux.intel.com>
References: <20201105180644.42862-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pericom has predefined vendor ID, use it instead of hard coded value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/quirks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7df7ae50618c..6fd5ce08d027 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2356,9 +2356,9 @@ static void quirk_enable_clear_retrain_link(struct pci_dev *dev)
 	dev->clear_retrain_link = 1;
 	pci_info(dev, "Enable PCIe Retrain Link quirk\n");
 }
-DECLARE_PCI_FIXUP_HEADER(0x12d8, 0xe110, quirk_enable_clear_retrain_link);
-DECLARE_PCI_FIXUP_HEADER(0x12d8, 0xe111, quirk_enable_clear_retrain_link);
-DECLARE_PCI_FIXUP_HEADER(0x12d8, 0xe130, quirk_enable_clear_retrain_link);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PERICOM, 0xe110, quirk_enable_clear_retrain_link);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PERICOM, 0xe111, quirk_enable_clear_retrain_link);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PERICOM, 0xe130, quirk_enable_clear_retrain_link);
 
 static void fixup_rev1_53c810(struct pci_dev *dev)
 {
-- 
2.28.0

