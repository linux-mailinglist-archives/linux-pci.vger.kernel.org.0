Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE521299640
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 19:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783730AbgJZS6H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 14:58:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:52492 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404845AbgJZS6H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 14:58:07 -0400
IronPort-SDR: 4k0AKJfjE/eIQLjcI9K2Vr9M/eNPyqEdaIrWRRf3y5AyfSHu5bBqPnchkTEpivXyE9TlUW3CIl
 jGSSqqmX4RiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168073143"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="168073143"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 11:58:06 -0700
IronPort-SDR: caTCKd572v7xQ6AABclg6jnE5hyqcN1jjoLw+eGO1zgUACsPF1FVBmSxQ48kS/Vy5+k5Mc6cvd
 gNRDKJNgbycg==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="525607448"
Received: from dhrubajy-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.53])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 11:58:06 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        knsathya@kernel.org
Subject: [PATCH v10 1/5] PCI: Conditionally initialize host bridge native_* members
Date:   Mon, 26 Oct 2020 11:56:39 -0700
Message-Id: <fcbe8a624166a1101a755edfef44a185d32ff493.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1603738449.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If CONFIG_PCIEPORTBUS is not enabled in kernel then initialing
struct pci_host_bridge PCIe specific native_* members to "1" is
incorrect. So protect the PCIe specific member initialization
with CONFIG_PCIEPORTBUS.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/probe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4289030b0fff..756fa60ca708 100644
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

