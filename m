Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399E034783B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 13:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhCXMT4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 08:19:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55160 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhCXMTX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Mar 2021 08:19:23 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12OCJDSJ012494;
        Wed, 24 Mar 2021 07:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616588353;
        bh=cowBO1dcfWlhVDX9uRu8VrJ6Mb2a92ZE4IRbCBJpBKo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sTbKL1tlWI5F8XPGpDfHYCsupd8u88PTi3MsGp7tw4V+6AXZr6KaLvLo2zBnpFJ+k
         X+N4uz9xmk7ncs4UCM8Bmwi8ze/945mX3mGzgvYmiz4GOGLBosucAjLr1PQcpFfd6M
         v7O/AjvFq0P8QAgv8QnLt56wu+UEGNEphMciw1W8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12OCJD1V021542
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Mar 2021 07:19:13 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 24
 Mar 2021 07:19:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 24 Mar 2021 07:19:13 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12OCJ1Ci121061;
        Wed, 24 Mar 2021 07:19:09 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 2/2] PCI: keystone: Add link up check in ks_child_pcie_ops.map_bus()
Date:   Wed, 24 Mar 2021 17:49:01 +0530
Message-ID: <20210324121901.1856-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324121901.1856-1-kishon@ti.com>
References: <20210324121901.1856-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

K2G forwardS the error triggered by a link-down state (e.g.,
no connected endpoint device) on the system bus for PCI configuration
transactions; these errors are reported as an SError at system level,
which is fatal and hangs the system. So fix it similar to how
it was done in designware core driver
commit 15b23906347c ("PCI: dwc: Add link up check in
dw_child_pcie_ops.map_bus()").

Fixes: 10a797c6e54a ("PCI: dwc: keystone: Use pci_ops for config space accessors")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Cc: <stable@vger.kernel.org> # v5.10
---
 drivers/pci/controller/dwc/pci-keystone.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 7171ea70da49..4de8c8e5e3f2 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -432,6 +432,17 @@ static void __iomem *ks_pcie_other_map_bus(struct pci_bus *bus,
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 	u32 reg;
 
+	/*
+	 * Checking whether the link is up here is a last line of defense
+	 * against platforms that forward errors on the system bus as
+	 * SError upon PCI configuration transactions issued when the link
+	 * is down. This check is racy by definition and does not stop
+	 * the system from triggering an SError if the link goes down
+	 * after this check is performed.
+	 */
+	if (!dw_pcie_link_up(pci))
+		return NULL;
+
 	reg = CFG_BUS(bus->number) | CFG_DEVICE(PCI_SLOT(devfn)) |
 		CFG_FUNC(PCI_FUNC(devfn));
 	if (!pci_is_root_bus(bus->parent))
-- 
2.17.1

