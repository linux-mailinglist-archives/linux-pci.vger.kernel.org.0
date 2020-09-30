Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559BB27E3A8
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 10:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgI3IZc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 04:25:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60571 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbgI3IZb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 04:25:31 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kNXQV-0001mB-KU; Wed, 30 Sep 2020 08:25:28 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com, jonathan.derrick@intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] PCI: vmd: Enable ASPM for mobile platforms
Date:   Wed, 30 Sep 2020 16:24:54 +0800
Message-Id: <20200930082455.25613-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930082455.25613-1-kai.heng.feng@canonical.com>
References: <20200930082455.25613-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

BIOS may not be able to program ASPM for links behind VMD, prevent Intel
SoC from entering deeper power saving state.

So enable ASPM for links behind VMD to increase battery life.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/controller/vmd.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index f69ef8c89f72..058fdef9c566 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -417,6 +417,22 @@ static int vmd_find_free_domain(void)
 	return domain + 1;
 }
 
+static const struct pci_device_id vmd_mobile_bridge_tbl[] = {
+	{ PCI_VDEVICE(INTEL, 0x9a09) },
+	{ PCI_VDEVICE(INTEL, 0xa0b0) },
+	{ PCI_VDEVICE(INTEL, 0xa0bc) },
+	{ }
+};
+
+static int vmd_enable_aspm(struct device *dev, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
+
+	return 0;
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -603,8 +619,12 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	 * and will fail pcie_bus_configure_settings() early. It can instead be
 	 * run on each of the real root ports.
 	 */
-	list_for_each_entry(child, &vmd->bus->children, node)
+	list_for_each_entry(child, &vmd->bus->children, node) {
+		if (pci_match_id(vmd_mobile_bridge_tbl, child->self))
+			device_for_each_child(&child->self->dev, NULL, vmd_enable_aspm);
+
 		pcie_bus_configure_settings(child);
+	}
 
 	pci_bus_add_devices(vmd->bus);
 
-- 
2.17.1

