Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F06A2BBAA5
	for <lists+linux-pci@lfdr.de>; Sat, 21 Nov 2020 01:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgKUAKq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 19:10:46 -0500
Received: from mga02.intel.com ([134.134.136.20]:34309 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbgKUAKp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 19:10:45 -0500
IronPort-SDR: /Awp1QBwpze6qkLZW3L7ySeBPgqfWescSFWOEkxbBc+uleMAL8tvl45XRCgNDUbU8nICFcaDA1
 cWsjkI6MTs2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="158601597"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="158601597"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 16:10:44 -0800
IronPort-SDR: ZjNlmnti1lkyM+nfXCx92q105tkNxV3vs80opNdb5IuRzCnHLO7IxbJBQ/WdIavyTFYl/bpUpt
 SzsMtz/jn5Rg==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="369387338"
Received: from unknown (HELO arch-ashland-svkelley.intel.com) ([10.212.171.128])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 16:10:44 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v12 15/15] PCI/AER: Add RCEC AER error injection support
Date:   Fri, 20 Nov 2020 16:10:36 -0800
Message-Id: <20201121001036.8560-16-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201121001036.8560-1-sean.v.kelley@intel.com>
References: <20201121001036.8560-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Root Complex Event Collectors (RCEC) appear as peers to Root Ports and may
also have the AER capability.

Add RCEC support to the AER error injection driver.

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-15-seanvk.dev@oregontracks.org
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/aer_inject.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index c2cbf425afc5..767f8859b99b 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -333,8 +333,11 @@ static int aer_inject(struct aer_error_inj *einj)
 	if (!dev)
 		return -ENODEV;
 	rpdev = pcie_find_root_port(dev);
+	/* If Root Port not found, try to find an RCEC */
+	if (!rpdev)
+		rpdev = dev->rcec;
 	if (!rpdev) {
-		pci_err(dev, "Root port not found\n");
+		pci_err(dev, "Neither Root Port nor RCEC found\n");
 		ret = -ENODEV;
 		goto out_put;
 	}
-- 
2.29.2

