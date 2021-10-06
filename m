Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4F1423CCB
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 13:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbhJFL2g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 07:28:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:41647 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238121AbhJFL2g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 07:28:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="206091106"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="206091106"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 04:26:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="623860170"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2021 04:26:38 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 1/3] PCI: Convert to device_create_managed_software_node()
Date:   Wed,  6 Oct 2021 14:26:41 +0300
Message-Id: <20211006112643.77684-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006112643.77684-1-heikki.krogerus@linux.intel.com>
References: <20211006112643.77684-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In quirk_huawei_pcie_sva(), use device_create_managed_software_node()
instead of device_add_properties() to set the "dma-can-stall"
property.

This is the last user of device_add_properties() that relied on
device_del() to take care of also calling device_remove_properties().
After this change we can finally get rid of that
device_remove_properties() call in device_del().

After that device_remove_properties() call has been removed from
device_del(), the software nodes that hold the additional device
properties become reusable and shareable as there is no longer a
default assumption that those nodes are lifetime bound the first
device they are associated with.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
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

