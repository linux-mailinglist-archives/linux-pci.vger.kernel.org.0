Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE80DA1ED
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 01:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390020AbfJPXG0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 19:06:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:4571 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395304AbfJPXG0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 19:06:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 16:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,305,1566889200"; 
   d="scan'208";a="189833638"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.93])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2019 16:06:25 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Fugate <david.fugate@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 3/3] PCI: vmd: Restore domain info during resets/unloads
Date:   Wed, 16 Oct 2019 11:04:48 -0600
Message-Id: <1571245488-3549-4-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571245488-3549-1-git-send-email-jonathan.derrick@intel.com>
References: <1571245488-3549-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Persistent domain info written by VMD BIOS needs to be restored by the
driver during module unloads or resets. This adds a remove or reset
action to restore the parsed domain info to all enabled VMD Root Ports.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index dbe1bff..853aa93 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -562,6 +562,33 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 				 PCI_VENDOR_ID, 4, &temp) ||		\
 		    temp == 0xffffffff) {} else
 
+static void vmd_restore_domain(void *data)
+{
+	struct vmd_dev *vmd = data;
+	int root_port;
+	u32 temp, iobase;
+
+	/*
+	 * It shouldn't be possible for the Root Port layout to change
+	 * dynamically (outside of BIOS), however there is no harm in writing
+	 * the persistent data back to all enabled Root Ports. PCI resource
+	 * assignment will discard any modifications on the next VMD domain bus
+	 * scan following VMD reset/probe.
+	 */
+	for_each_vmd_root_port(vmd, root_port, temp) {
+		if (vmd_cfg_read(vmd, 0, PCI_DEVFN(root_port, 0),
+				 PCI_IO_BASE, 2, &iobase))
+			return;
+
+		iobase &= ~((0xf << 4) | (0x3 << 14));
+		iobase |= vmd->socket_nr << 4 | vmd->instance_nr << 14;
+
+		if (vmd_cfg_write(vmd, 0, PCI_DEVFN(root_port, 0),
+				  PCI_IO_BASE, 2, iobase))
+			return;
+	}
+}
+
 static int vmd_parse_domain(struct vmd_dev *vmd)
 {
 	int root_port, ret;
@@ -579,6 +606,11 @@ static int vmd_parse_domain(struct vmd_dev *vmd)
 		vmd->socket_nr = (iobase >> 4) & 0xf;
 		vmd->instance_nr = (iobase >> 14) & 0x3;
 
+		ret = devm_add_action_or_reset(&vmd->dev->dev,
+					       vmd_restore_domain, vmd);
+		if (ret)
+			return ret;
+
 		/* First available will be used */
 		break;
 	}
-- 
1.8.3.1

