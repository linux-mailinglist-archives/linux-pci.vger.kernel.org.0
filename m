Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90B541D0D3
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 03:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhI3BHQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 21:07:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:24481 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347347AbhI3BHP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 21:07:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212330108"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="212330108"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 18:05:33 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="521027370"
Received: from yzhu3-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.37.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 18:05:31 -0700
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
Subject: [PATCH v2 3/6] driver core: Allow arch to initialize the authorized attribute
Date:   Wed, 29 Sep 2021 18:05:08 -0700
Message-Id: <20210930010511.3387967-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Authorized device attribute is used to authorize or deauthorize
the driver probe of the given device. Currently this attribute
is initialized to "true" (allow all) by default.

But for platforms like TDX guest, in which the host is an untrusted
entity, it has a requirement to disable all devices by default and
allow only a trusted list of devices with hardened drivers. So
define a variable "dev_default_authorization" which is used to
initialize the "authorized" attribute in device_initialize(). Also
allow arch code to override the default value by updating
dev_default_authorization value.

More discussion about the need for device/driver filter and the use
of allow list can be found in article [1] titled "firewall for
device drivers".

Also note that USB and Thunderbolt both override this initial value
in their respective device initializations so this is not a regression
for those buses.

[1] - https://lwn.net/Articles/865918/

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/base/core.c    | 7 +++++++
 include/linux/device.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e65dd803a453..98717f00b90b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -47,6 +47,12 @@ static int __init sysfs_deprecated_setup(char *arg)
 early_param("sysfs.deprecated", sysfs_deprecated_setup);
 #endif
 
+/*
+ * Default authorization status set as allow all. It can be
+ * overridden by arch code.
+ */
+bool __ro_after_init dev_default_authorization = true;
+
 /* Device links support. */
 static LIST_HEAD(deferred_sync);
 static unsigned int defer_sync_state_count = 1;
@@ -2855,6 +2861,7 @@ void device_initialize(struct device *dev)
 #ifdef CONFIG_SWIOTLB
 	dev->dma_io_tlb_mem = &io_tlb_default_mem;
 #endif
+	dev->authorized = dev_default_authorization;
 }
 EXPORT_SYMBOL_GPL(device_initialize);
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 899be9a2c0cb..c97b1e59d23a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -959,6 +959,8 @@ int devtmpfs_mount(void);
 static inline int devtmpfs_mount(void) { return 0; }
 #endif
 
+extern bool dev_default_authorization;
+
 /* drivers/base/power/shutdown.c */
 void device_shutdown(void);
 
-- 
2.25.1

