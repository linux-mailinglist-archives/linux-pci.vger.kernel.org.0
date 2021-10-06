Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E65423CCD
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 13:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhJFL2j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 07:28:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:41644 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238143AbhJFL2g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 07:28:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="206091109"
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="206091109"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 04:26:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,350,1624345200"; 
   d="scan'208";a="623860178"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2021 04:26:41 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 2/3] driver core: Don't call device_remove_properties() from device_del()
Date:   Wed,  6 Oct 2021 14:26:42 +0300
Message-Id: <20211006112643.77684-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006112643.77684-1-heikki.krogerus@linux.intel.com>
References: <20211006112643.77684-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All the drivers that relied on device_del() to call
device_remove_properties() have now been converted to either
use device_create_managed_software_node() instead of
device_add_properties(), or to register the software node
completely separately from the device.

This will make it finally possible to share and reuse the
software nodes that hold the additional device properties.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index c4a2c97a21a2b..ea39ffad11179 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3584,7 +3584,6 @@ void device_del(struct device *dev)
 	device_pm_remove(dev);
 	driver_deferred_probe_del(dev);
 	device_platform_notify_remove(dev);
-	device_remove_properties(dev);
 	device_links_purge(dev);
 
 	if (dev->bus)
-- 
2.33.0

