Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DC641D0DB
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 03:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347083AbhI3BHT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 21:07:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:24480 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347505AbhI3BHQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 21:07:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212330112"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="212330112"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 18:05:34 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="521027373"
Received: from yzhu3-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.37.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 18:05:33 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 4/6] virtio: Initialize authorized attribute for confidential guest
Date:   Wed, 29 Sep 2021 18:05:09 -0700
Message-Id: <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Confidential guest platforms like TDX have a requirement to allow
only trusted devices. By default the confidential-guest core will
arrange for all devices to default to unauthorized (via
dev_default_authorization) in device_initialize(). Since virtio
driver is already hardened against the attack from the un-trusted host,
override the confidential computing default unauthorized state

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/virtio/virtio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 588e02fb91d3..377b0ccdc503 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -5,6 +5,8 @@
 #include <linux/module.h>
 #include <linux/idr.h>
 #include <linux/of.h>
+#include <linux/cc_platform.h>
+#include <linux/device.h>
 #include <uapi/linux/virtio_ids.h>
 
 /* Unique numbering for virtio devices. */
@@ -390,6 +392,13 @@ int register_virtio_device(struct virtio_device *dev)
 	dev->config_enabled = false;
 	dev->config_change_pending = false;
 
+	/*
+	 * For Confidential guest (like TDX), virtio devices are
+	 * trusted. So set authorized status as true.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_DEVICE_FILTER))
+		dev->dev.authorized = true;
+
 	/* We always start by resetting the device, in case a previous
 	 * driver messed it up.  This also tests that code path a little. */
 	dev->config->reset(dev);
-- 
2.25.1

