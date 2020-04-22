Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F3A1B4BC7
	for <lists+linux-pci@lfdr.de>; Wed, 22 Apr 2020 19:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDVR2V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 13:28:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:62138 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDVR2V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 13:28:21 -0400
IronPort-SDR: ufjgFpL1A8OVAQrAua13tkXA4PnVS1Kdb6zwTiu4F58IUJ8dQUT2sq0Yr/7ClUrMIM/K1hJ7XE
 5PKQK09cgzbg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 10:28:18 -0700
IronPort-SDR: GIoBfjkDeD7w2hdiabPdW2SOdEki+l8ydPDm/m266t8HN5f/JoVFcTG/1OWHUbyg+4vRY8ADXc
 LmqU3ff6uroA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="429999418"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.40])
  by orsmga005.jf.intel.com with ESMTP; 22 Apr 2020 10:28:18 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, qemu-devel@nongnu.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Andrzej Jakowski <andrzej.jakowski@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 1/1] pci: vmd: Use Shadow MEMBAR registers for QEMU/KVM guests
Date:   Wed, 22 Apr 2020 13:13:05 -0400
Message-Id: <20200422171305.10923-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200422171305.10923-1-jonathan.derrick@intel.com>
References: <20200422171305.10923-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD device 28C0 provides native guest passthrough of the VMD endpoint
through the use of shadow registers that provide Host Physical Addresses
to correctly assign bridge windows. A quirk has been added to QEMU's
VFIO quirks to emulate the shadow registers for VMD devices which don't
support this mode natively in hardware.

The VFIO quirk assigns the VMD a subsystem vendor/device ID using the
standard QEMU vendor/device, which are typically only used for emulation
and not VFIO. There are no plans for an emulated VMD controller, but if
one is developed in the future, support for this mode can be added by
emulating the VMD VMLOCK and Shadow MEMBAR registers

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index dac91d60701d..764404b45ebb 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -598,6 +598,7 @@ static irqreturn_t vmd_irq(int irq, void *data)
 static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct vmd_dev *vmd;
+	unsigned long features = id->driver_data;
 	int i, err;
 
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
@@ -648,9 +649,14 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			return err;
 	}
 
+	/* VFIO-quirked VMD controllers emulate the Shadow MEMBAR feature */
+	if (dev->subsystem_vendor == PCI_SUBVENDOR_ID_REDHAT_QUMRANET &&
+	    dev->subsystem_device == PCI_SUBDEVICE_ID_QEMU)
+		features |= VMD_FEAT_HAS_MEMBAR_SHADOW;
+
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
-	err = vmd_enable_domain(vmd, (unsigned long) id->driver_data);
+	err = vmd_enable_domain(vmd, features);
 	if (err)
 		return err;
 
-- 
2.18.1

