Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773D741D0DE
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 03:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347630AbhI3BHV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 21:07:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:24480 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347601AbhI3BHT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 21:07:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="212330117"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="212330117"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 18:05:37 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="521027386"
Received: from yzhu3-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.37.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 18:05:36 -0700
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
Subject: [PATCH v2 6/6] PCI: Initialize authorized attribute for confidential guest
Date:   Wed, 29 Sep 2021 18:05:11 -0700
Message-Id: <20210930010511.3387967-7-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Confidential guest platforms like TDX have a requirement to allow
only trusted devices. So initialize the "authorized" attribute
using cc_guest_dev_authorized().

By default the confidential-guest core arranges for all devices to
default to unauthorized (via dev_default_authorization) in
device_initialize(). So, consult a core list of allowed devices to
override that default.

ARCH code will use its device allow list in cc_guest_dev_authorized()
to determine the status of the authorized attribute.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/probe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index d9fc02a71baa..aab9d1917d52 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -20,6 +20,8 @@
 #include <linux/irqdomain.h>
 #include <linux/pm_runtime.h>
 #include <linux/bitfield.h>
+#include <linux/cc_platform.h>
+#include <linux/device.h>
 #include "pci.h"
 
 #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
@@ -2491,6 +2493,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	pci_configure_device(dev);
 
 	device_initialize(&dev->dev);
+	if (cc_platform_has(CC_ATTR_GUEST_DEVICE_FILTER))
+		dev->dev.authorized = cc_guest_dev_authorized(&dev->dev);
 	dev->dev.release = pci_release_dev;
 
 	set_dev_node(&dev->dev, pcibus_to_node(bus));
-- 
2.25.1

