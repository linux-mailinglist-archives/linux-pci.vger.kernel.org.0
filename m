Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC2C22CC06
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 19:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGXRWu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 13:22:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:2790 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgGXRWq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 13:22:46 -0400
IronPort-SDR: qTktffYZK0JzygwODfhRcSUwEo6I2Uxgf2oDaM9ILzQ+7bPZuovC0KpkFp+fhOULA+Y+mTFAr4
 WYXCVXgWJ7kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="130823291"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="130823291"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:22:46 -0700
IronPort-SDR: dOx3JrqPVcHLFgwXArKOC8n2r4nD78EtZ4kiSpUMRBA/GLIbKLsBoLMQlwjyc8SPf3FYk4/TB+
 2KO9S6AU1uMQ==
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="302730341"
Received: from seokjaeb-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.24.239])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:22:44 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@kernel.org, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [RFC PATCH 9/9] PCI/AER: Add RCEC AER error injection support
Date:   Fri, 24 Jul 2020 10:22:23 -0700
Message-Id: <20200724172223.145608-10-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724172223.145608-1-sean.v.kelley@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

The Root Complex Event Collectors(RCEC) appear as peers to Root Ports
and also have the AER capability. So add RCEC support to the current AER
error injection driver.

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/aer_inject.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 21cc3d3387f7..5264847bd714 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -333,8 +333,11 @@ static int aer_inject(struct aer_error_inj *einj)
 	if (!dev)
 		return -ENODEV;
 	rpdev = pcie_find_root_port(dev);
+	/* If Root port not found, try to find an RCEC */
+	if (!rpdev)
+		rpdev = dev->rcec;
 	if (!rpdev) {
-		pci_err(dev, "Root port not found\n");
+		pci_err(dev, "Root port or RCEC not found\n");
 		ret = -ENODEV;
 		goto out_put;
 	}
-- 
2.27.0

