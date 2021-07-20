Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83E43D0393
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 23:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhGTUXh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 16:23:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:37796 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234263AbhGTULc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 16:11:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="272440829"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="272440829"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 13:51:42 -0700
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="415371396"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.248.31])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 13:51:42 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH v2 2/2] PCI: vmd: Issue vmd domain window reset
Date:   Tue, 20 Jul 2021 13:50:09 -0700
Message-Id: <20210720205009.111806-3-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210720205009.111806-1-nirmal.patel@linux.intel.com>
References: <20210720205009.111806-1-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to properly re-initialize the VMD domain during repetitive driver
attachment or reboot tests, ensure that the VMD root ports are re-initialized
to a blank state that can be re-enumerated appropriately by the PCI core.
This is performed by re-initializing all of the bridge windows to ensure
that PCI core enumeration does not detect potentially invalid bridge windows
and misinterpret them as firmware-assigned windows, when they simply may be
invalid bridge window information from a previous boot.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 6e1c60048774..e52bdb95218e 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -651,6 +651,39 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 	return 0;
 }
 
+
+static void vmd_domain_reset_windows(struct vmd_dev *vmd)
+{
+	u8 hdr_type;
+	char __iomem *addr;
+	int dev_seq;
+	u8 functions;
+	u8 fn_seq;
+	int max_devs = resource_size(&vmd->resources[0]) * 32;
+
+	for (dev_seq = 0; dev_seq < max_devs; dev_seq++) {
+		addr = VMD_DEVICE_BASE(vmd, dev_seq) + PCI_VENDOR_ID;
+		if (readw(addr) != PCI_VENDOR_ID_INTEL)
+			continue;
+
+		addr = VMD_DEVICE_BASE(vmd, dev_seq) + PCI_HEADER_TYPE;
+		hdr_type = readb(addr) & PCI_HEADER_TYPE_MASK;
+		if (hdr_type != PCI_HEADER_TYPE_BRIDGE)
+			continue;
+
+		functions = !!(hdr_type & 0x80) ? 8 : 1;
+		for (fn_seq = 0; fn_seq < functions; fn_seq++)
+		{
+			addr = VMD_FUNCTION_BASE(vmd, dev_seq, fn_seq) + PCI_VENDOR_ID;
+			if (readw(addr) != PCI_VENDOR_ID_INTEL)
+				continue;
+
+			memset_io((VMD_FUNCTION_BASE(vmd, dev_seq, fn_seq) + PCI_IO_BASE),
+			 0, PCI_ROM_ADDRESS1 - PCI_IO_BASE);
+		}
+	}
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -741,6 +774,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		.parent = res,
 	};
 
+	vmd_domain_reset_windows(vmd);
+
 	sd->vmd_dev = vmd->dev;
 	sd->domain = vmd_find_free_domain();
 	if (sd->domain < 0)
-- 
2.27.0

