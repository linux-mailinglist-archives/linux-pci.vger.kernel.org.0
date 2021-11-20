Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638A14580E8
	for <lists+linux-pci@lfdr.de>; Sun, 21 Nov 2021 00:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhKTXUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Nov 2021 18:20:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:64005 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237161AbhKTXUL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 20 Nov 2021 18:20:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10174"; a="295426752"
X-IronPort-AV: E=Sophos;i="5.87,251,1631602800"; 
   d="scan'208";a="295426752"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2021 15:17:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,251,1631602800"; 
   d="scan'208";a="551868336"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 20 Nov 2021 15:17:06 -0800
Received: from debox1-desk4.intel.com (dseghete-mobl.amr.corp.intel.com [10.209.30.58])
        by linux.intel.com (Postfix) with ESMTP id 80D2C580BF8;
        Sat, 20 Nov 2021 15:17:06 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com,
        david.e.box@linux.intel.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/4] driver core: auxiliary bus: Add driver data helpers
Date:   Sat, 20 Nov 2021 15:17:03 -0800
Message-Id: <20211120231705.189969-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211120231705.189969-1-david.e.box@linux.intel.com>
References: <20211120231705.189969-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adds get/set driver data helpers for auxiliary devices.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Mark Gross <markgross@kernel.org>
---

Note, I have another patchset that modifies current auxiliary drivers to
use this new helper. But since it touches 5 different subsystems, I plan to
submit it after this series is accepted.

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

