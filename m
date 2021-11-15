Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3AC450420
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 13:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhKOMNC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 07:13:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:14027 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhKOMNA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 07:13:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="233266319"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="233266319"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 04:10:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="644818589"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2021 04:10:01 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v4 1/3] PCI: Convert to device_create_managed_software_node()
Date:   Mon, 15 Nov 2021 15:09:59 +0300
Message-Id: <20211115121001.77041-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211115121001.77041-1-heikki.krogerus@linux.intel.com>
References: <20211115121001.77041-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In quirk_huawei_pcie_sva(), device_add_properties() is used to
inject additional device properties, but there is no
device_remove_properties() call anywhere to remove those
properties. The assumption is most likely that the device is
never removed, and the properties therefore do not also never
need to be removed.

Even though it is unlikely that the device is ever removed in
this case, it is safer to make sure that the properties are
also removed if the device ever does get unregistered.

To achieve this, instead of adding a separate quirk for the
case of device removal where device_remove_properties() is
called, using device_create_managed_software_node() instead of
device_add_properties(). Both functions create a software node
(a type of fwnode) that holds the device properties, which is
then assigned to the device very much the same way.

The difference between the two functions is, that
device_create_managed_software_node() guarantees that the
software node (together with the properties) is removed when
the device is removed. The function device_add_property() does
not guarantee that, so the properties added with it should
always be removed with device_remove_properties().

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 003950c738d26..b4cb658cce2b1 100644
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

