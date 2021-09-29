Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E7241C5D1
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 15:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344301AbhI2NjM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 09:39:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:59006 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344291AbhI2NjL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 09:39:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212025192"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="212025192"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 06:37:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="617514196"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Sep 2021 06:37:26 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: Use software node API with additional device properties
Date:   Wed, 29 Sep 2021 16:37:28 +0300
Message-Id: <20210929133729.9427-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929133729.9427-1-heikki.krogerus@linux.intel.com>
References: <20210929133729.9427-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Using device_create_managed_software_node() to inject the
properties in quirk_huawei_pcie_sva() instead of with the
old device_add_properties() API.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b6b4c803bdc94..fe5eedba47908 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1850,7 +1850,7 @@ static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
 	 * can set it directly.
 	 */
 	if (!pdev->dev.of_node &&
-	    device_add_properties(&pdev->dev, properties))
+	    device_create_managed_software_node(&pdev->dev, properties, NULL))
 		pci_warn(pdev, "could not add stall property");
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
-- 
2.33.0

