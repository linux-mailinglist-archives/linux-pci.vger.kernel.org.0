Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6A32A80A
	for <lists+linux-pci@lfdr.de>; Sun, 26 May 2019 06:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfEZEiO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 May 2019 00:38:14 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8054 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfEZEiO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 May 2019 00:38:14 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cea18350000>; Sat, 25 May 2019 21:38:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 25 May 2019 21:38:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 25 May 2019 21:38:13 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 26 May
 2019 04:38:13 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 26 May 2019 04:38:12 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cea18300000>; Sat, 25 May 2019 21:38:12 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V8 02/15] PCI: Disable MSI for Tegra194 root port
Date:   Sun, 26 May 2019 10:07:38 +0530
Message-ID: <20190526043751.12729-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526043751.12729-1-vidyas@nvidia.com>
References: <20190526043751.12729-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558845493; bh=Az+kW1ONauchHOwl4YBjfseZK+r8JuCMRaKHGANgg34=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=V9Plcp+4UTSX2W+IpWnHyrFxqJ0s6X9Cek2ZX2/3l39PbhMJmB4TozxHv2/B+RALr
         ATbM3krZYsxSsnR2upx36FlLfkfZygFFtJGBHw1cAMzUM7R9TXhhYkbCoWKZfCaxaq
         Cc+05S0SKzTG6LBchYcg3YXMLX9bQOwd2aZtgMpVTg61u49KQMYKjUBFgegpfR4zHw
         Y21WWvBzctz62NAVsNyMjb9TDfNBtasmCLoZazC26Q48cLMBRAkcB2bQrlUj47DlyS
         PbmR+/IiDHN7vp4PJKHzPFGKSOXDthjUPgyd1kfzOhik5CbobQRlf5MrtMOclIzIF6
         4hiN95FeNf+vw==
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

