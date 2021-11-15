Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4D1450423
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 13:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhKOMNF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 07:13:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:14027 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231347AbhKOMND (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 07:13:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="233266345"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="233266345"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 04:10:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="644818624"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2021 04:10:03 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v4 2/3] driver core: Don't call device_remove_properties() from device_del()
Date:   Mon, 15 Nov 2021 15:10:00 +0300
Message-Id: <20211115121001.77041-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211115121001.77041-1-heikki.krogerus@linux.intel.com>
References: <20211115121001.77041-1-heikki.krogerus@linux.intel.com>
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
index fd034d7424472..a40b6fb1ebb01 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3582,7 +3582,6 @@ void device_del(struct device *dev)
 	device_pm_remove(dev);
 	driver_deferred_probe_del(dev);
 	device_platform_notify_remove(dev);
-	device_remove_properties(dev);
 	device_links_purge(dev);
 
 	if (dev->bus)
-- 
2.33.0

