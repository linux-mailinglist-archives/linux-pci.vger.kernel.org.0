Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C553011E0
	for <lists+linux-pci@lfdr.de>; Sat, 23 Jan 2021 02:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbhAWBNR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 20:13:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:26863 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbhAWBNQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jan 2021 20:13:16 -0500
IronPort-SDR: 776HFPjcKlr6XFb1Yn7oh5vxT/fnHjZ5xNbYXjb9XoR3MZhsj4rI3GoZl2rIACIzkVOt6LXHHo
 ZB65oU5/oZgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="176962176"
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="176962176"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 17:11:21 -0800
IronPort-SDR: iweWeVOelx2YQAJpOv/c4t3z7XfnQ8I6Nr+bw3HA/fb3pCQxWU2Ap7UrEh96S344H90sxAwJPI
 HRILpxbLUmAw==
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="386084685"
Received: from usundar-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.36.142])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 17:11:20 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v13 2/5] PCI: Assume control of portdrv-related features only when portdrv enabled
Date:   Fri, 22 Jan 2021 17:11:10 -0800
Message-Id: <a36cd1bfdca9bfdff8130d3a99a3aae6cae926c5.1611364025.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1611364024.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1611364024.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Native control of PME, AER, DPC, and PCIe hotplug depends on the portdrv,
so default to native handling of them only when CONFIG_PCIEPORTBUS is
enabled.

Native control LTR and SHPC hotplug does not depend on portdrv, so we can
always take control of them unless some platform interface, e.g., _OSC,
tells us otherwise.

[bhelgaas: commit log]
Link: https://lore.kernel.org/r/fcbe8a624166a1101a755edfef44a185d32ff493.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc850..97498f61f5ad 100644
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
2.25.1

