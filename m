Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF0E274A6B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 22:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIVUys (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 16:54:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:11102 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgIVUyq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 16:54:46 -0400
IronPort-SDR: VMHRDGZuZ/MHx7/5N692IcyEwkMD1fC7YzTPWTrY8vbz8vvPgg260/Km+7nLGaC7UQToQ8wzm/
 J5UzCcOk259w==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="245542542"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="245542542"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 13:54:45 -0700
IronPort-SDR: RibewKUXrtIVyaX6+3KdOSnam6ywd94ODuD342Mkp3kfWNM1mPuVKOmN7+LyQMY4sE37X+Vk1P
 wBLkdkvvoj7Q==
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="510718934"
Received: from fkhoshne-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.255.230.168])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 13:54:42 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v9 1/5] PCI: Conditionally initialize host bridge native_* members
Date:   Tue, 22 Sep 2020 13:54:28 -0700
Message-Id: <a640e9043db50f5adee8e38f5c60ff8423f3f598.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1600457297.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

If CONFIG_PCIEPORTBUS is not enabled in kernel then initialing
struct pci_host_bridge PCIe specific native_* members to "1" is
incorrect. So protect the PCIe specific member initialization
with CONFIG_PCIEPORTBUS.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/probe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03d37128a24f..0da0fc034413 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -588,12 +588,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	 * may implement its own AER handling and use _OSC to prevent the
 	 * OS from interfering.
 	 */
+#ifdef CONFIG_PCIEPORTBUS
 	bridge->native_aer = 1;
 	bridge->native_pcie_hotplug = 1;
-	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = 1;
-	bridge->native_ltr = 1;
 	bridge->native_dpc = 1;
+#endif
+	bridge->native_ltr = 1;
+	bridge->native_shpc_hotplug = 1;
 
 	device_initialize(&bridge->dev);
 }
-- 
2.17.1

