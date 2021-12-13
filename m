Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7737473361
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 18:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbhLMR7c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 12:59:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:56114 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241425AbhLMR73 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Dec 2021 12:59:29 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="225648984"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="225648984"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 09:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="505000141"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 09:59:25 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.243.203])
        by linux.intel.com (Postfix) with ESMTP id 357A5580B54;
        Mon, 13 Dec 2021 09:59:25 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com,
        david.e.box@linux.intel.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org, Mark Gross <markgross@kernel.org>
Subject: [PATCH V3 2/6] driver core: auxiliary bus: Add driver data helpers
Date:   Mon, 13 Dec 2021 09:59:17 -0800
Message-Id: <20211213175921.1897860-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213175921.1897860-1-david.e.box@linux.intel.com>
References: <20211213175921.1897860-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adds get/set driver data helpers for auxiliary devices.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Mark Gross <markgross@kernel.org>
---
V3
  - No changes
V2
  - No changes

 include/linux/auxiliary_bus.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index fc51d45f106b..a8338d456e81 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -28,6 +28,16 @@ struct auxiliary_driver {
 	const struct auxiliary_device_id *id_table;
 };
 
+static inline void *auxiliary_get_drvdata(struct auxiliary_device *auxdev)
+{
+	return dev_get_drvdata(&auxdev->dev);
+}
+
+static inline void auxiliary_set_drvdata(struct auxiliary_device *auxdev, void *data)
+{
+	dev_set_drvdata(&auxdev->dev, data);
+}
+
 static inline struct auxiliary_device *to_auxiliary_dev(struct device *dev)
 {
 	return container_of(dev, struct auxiliary_device, dev);
-- 
2.25.1

