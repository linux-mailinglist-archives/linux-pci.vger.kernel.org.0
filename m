Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1538DA8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2019 16:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfFGOrQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jun 2019 10:47:16 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5149 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbfFGOrQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jun 2019 10:47:16 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfa78f30000>; Fri, 07 Jun 2019 07:47:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 07:47:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 07 Jun 2019 07:47:15 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Jun
 2019 14:47:15 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 7 Jun 2019 14:47:15 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cfa78ed0000>; Fri, 07 Jun 2019 07:47:14 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V9 02/15] PCI: Disable MSI for Tegra194 root port
Date:   Fri, 7 Jun 2019 20:16:27 +0530
Message-ID: <20190607144640.13427-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607144640.13427-1-vidyas@nvidia.com>
References: <20190607144640.13427-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559918835; bh=FvBIBBeSeJABCphcZGdPQIZy0gR/G92fkmrjhmkqJLQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ozeUXYXeoGlfalFcn/VSuwxrDtHu9h31BbbiCwJW9LZuXulsRVHzozGe8udTozY3w
         mKWla0eNMBU7NlH4JQNrkiWoMSl+bdrXprw6ua286ph0A22WIiGPlGcS43mwKjvdSz
         qeQV8yYVVIUE4qpU4FzckD5LN7EiIV74wMOgRKm4CeH0fispnunET9fqP627+vm7BG
         7KMNvLv50buQSNEOh8dpeLfeX6L3JOE13/23UVDJkE6zahSzO68hC0BfKATKu7zbNi
         ZyT8FGNwF/ftAq7bq7nNR2zXmR6WUhy0aeMANYqw+ehsh47R8s40Cvep0CDHqdmXSy
         Hiu+aoUBsLojw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra194 rootports don't generate MSI interrupts for PME and AER events.
Since PCIe spec (Ref: r4.0 sec 7.7.1.2 and 7.7.2.2) doesn't support using
a mix of INTx and MSI/MSI-X, MSI needs to be disabled to avoid root ports
service drivers registering their respective ISRs with MSI interrupt and
to let only INTx be used for all events.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
Changes since [v8]:
* None

Changes since [v7]:
* Changed quirk macro to consider class code as well to avoid this quirk
  getting applied to Tegra194 when it is operating in endpoint mode. Also
  quoted relevant sections from PCIe spec in comments.

Changes since [v6]:
* This is a new patch

 drivers/pci/quirks.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0f16acc323c6..69c061e0ca7d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2592,6 +2592,29 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
 			PCI_DEVICE_ID_NVIDIA_NVENET_15,
 			nvenet_msi_disable);
 
+/*
+ * PCIe spec r4.0 sec 7.7.1.2 and sec 7.7.2.2 say that if MSI/MSI-X is enabled,
+ * then the device can't use INTx interrupts. Tegra194's PCIe root ports don't
+ * generate MSI interrupts for PME and AER events instead only INTx interrupts
+ * are generated. Though Tegra194 can generate MSI interrupts for other events,
+ * since PCIe specificiation doesn't support using a mix of INTx and MSI/MSI-X,
+ * it is required to disable MSI interrupts to avoid port service drivers
+ * registering their respective ISRs for MSIs.
+ */
+static void pci_quirk_nvidia_tegra194_disable_rp_msi(struct pci_dev *dev)
+{
+	dev->no_msi = 1;
+}
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad0,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra194_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad1,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra194_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad2,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra194_disable_rp_msi);
+
 /*
  * Some versions of the MCP55 bridge from Nvidia have a legacy IRQ routing
  * config register.  This register controls the routing of legacy
-- 
2.17.1

