Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6049A41D0D7
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 03:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347568AbhI3BHR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 21:07:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:24480 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347152AbhI3BHO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 21:07:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212330104"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="212330104"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 18:05:31 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="521027367"
Received: from yzhu3-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.37.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 18:05:30 -0700
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
Subject: [PATCH v2 2/6] driver core: Add common support to skip probe for un-authorized devices
Date:   Wed, 29 Sep 2021 18:05:07 -0700
Message-Id: <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While the common case for device-authorization is to skip probe of
unauthorized devices, some buses may still want to emit a message on
probe failure (Thunderbolt), or base probe failures on the
authorization status of a related device like a parent (USB). So add
an option (has_probe_authorization) in struct bus_type for the bus
driver to own probe authorization policy.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/base/dd.c            | 5 +++++
 drivers/thunderbolt/domain.c | 1 +
 drivers/usb/core/driver.c    | 1 +
 include/linux/device/bus.h   | 4 ++++
 4 files changed, 11 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 68ea1f949daa..0cd03ac7d3b1 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -544,6 +544,11 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 			   !drv->suppress_bind_attrs;
 	int ret;
 
+	if (!dev->authorized && !dev->bus->has_probe_authorization) {
+		dev_dbg(dev, "Device is not authorized\n");
+		return -ENODEV;
+	}
+
 	if (defer_all_probes) {
 		/*
 		 * Value of defer_all_probes can be set only by
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 3e39686eff14..6de8a366b796 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -321,6 +321,7 @@ struct bus_type tb_bus_type = {
 	.probe = tb_service_probe,
 	.remove = tb_service_remove,
 	.shutdown = tb_service_shutdown,
+	.has_probe_authorization = true,
 };
 
 static void tb_domain_release(struct device *dev)
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index fb476665f52d..f57b5a7a90ca 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -2028,4 +2028,5 @@ struct bus_type usb_bus_type = {
 	.match =	usb_device_match,
 	.uevent =	usb_uevent,
 	.need_parent_lock =	true,
+	.has_probe_authorization = true,
 };
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 062777a45a74..571a2f6e7c1d 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -69,6 +69,9 @@ struct fwnode_handle;
  * @lock_key:	Lock class key for use by the lock validator
  * @need_parent_lock:	When probing or removing a device on this bus, the
  *			device core should lock the device's parent.
+ * @has_probe_authorization: Set true to indicate to the driver-core to skip
+ *			     the authorization checks and let bus drivers
+ *			     handle it locally.
  *
  * A bus is a channel between the processor and one or more devices. For the
  * purposes of the device model, all devices are connected via a bus, even if
@@ -112,6 +115,7 @@ struct bus_type {
 	struct lock_class_key lock_key;
 
 	bool need_parent_lock;
+	bool has_probe_authorization;
 };
 
 extern int __must_check bus_register(struct bus_type *bus);
-- 
2.25.1

