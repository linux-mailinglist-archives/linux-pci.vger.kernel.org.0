Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916532C4C86
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 02:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgKZBSf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 20:18:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729679AbgKZBSf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 20:18:35 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF8C2075A;
        Thu, 26 Nov 2020 01:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606353514;
        bh=kayfTHjVZqi4HstmiwYn3EZrEONOA4LIw0UnN/vjhkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLg+9yV6k4tyTHm7tx/rGfvCRiGfB5pWKCeAKq2m+m+ZWR7y2hbkucaitNMcwMF4+
         w2LFC/eod7G7zXVV1S9L/L0YsWrt8bUau2m9gNE+4WAH2A7lJ7Qfbzvnm2cr3CQY7K
         ioFJ7RC8c5ysY12GOcOQA6wu+Oaq/rvMFADCt2r8=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     ashok.raj@intel.com, knsathya@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/5] PCI: Assume control of portdrv-related features only when portdrv enabled
Date:   Wed, 25 Nov 2020 19:18:13 -0600
Message-Id: <20201126011816.711106-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126011816.711106-1-helgaas@kernel.org>
References: <20201126011816.711106-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

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
2.25.1

