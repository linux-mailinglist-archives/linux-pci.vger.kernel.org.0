Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E01A41D96D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 14:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348839AbhI3MOm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 08:14:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:38148 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348818AbhI3MOf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 08:14:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="223283954"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="223283954"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 05:12:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="618097814"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Sep 2021 05:12:43 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: Convert to device_create_managed_software_node()
Date:   Thu, 30 Sep 2021 15:12:45 +0300
Message-Id: <20210930121246.22833-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930121246.22833-1-heikki.krogerus@linux.intel.com>
References: <20210930121246.22833-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In quirk_huawei_pcie_sva(), use device_create_managed_software_node()
instead of device_add_properties() to set the "dma-can-stall"
property.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Hi,

The commit message now says what Bjorn requested, except I left out
the claim that the patch fixes a lifetime issue.

There shouldn't be any functional impact.

thanks,
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

