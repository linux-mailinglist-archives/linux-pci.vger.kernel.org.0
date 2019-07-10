Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E196411F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2019 08:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfGJGXG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jul 2019 02:23:06 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9831 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfGJGXF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jul 2019 02:23:05 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d2584420001>; Tue, 09 Jul 2019 23:22:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 09 Jul 2019 23:23:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 09 Jul 2019 23:23:03 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Jul
 2019 06:23:03 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 10 Jul 2019 06:23:03 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d2584410000>; Tue, 09 Jul 2019 23:23:02 -0700
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
Subject: [PATCH V13 02/12] PCI: Disable MSI for Tegra root ports
Date:   Wed, 10 Jul 2019 11:52:02 +0530
Message-ID: <20190710062212.1745-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710062212.1745-1-vidyas@nvidia.com>
References: <20190710062212.1745-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562739778; bh=C2RgPOePUyK0ZeerFvt6uxTRpV/wqjkx1DWzpJAA8QY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=BhKvylXxrvdcBFYR+OoOCd3gCRtas2Z71EBa6xAkWdVhiHzPBzRtEeI+LjUNgabw1
         Jf/nE1Ne/YpsrVwtdODY9m31FTg9TwvyBYU86AQOEbfMRNVBrRNWm3eC+G4+tyf++3
         KKSe1//r9qIcqGKNlrMv7lnhE7kMm6Jnfxvzekp9Ga+UYMsPo4UlP2JQyYYJ9tI4FY
         8PoVsflQ40xEIb49WiDXJVcCKWGkfLLuTUQhZHOGje4+sxZRR08cHiRgH+r3oTYHAc
         K60W/T8P8/Q6vGl1iOkwEg49BLoxiZfeFNP7v85EYxtFBeVq5Lb6qIclsXUi0ZLtA5
         xZhsYyre02jVQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra PCIe rootports don't generate MSI interrupts for PME and AER events.
Since PCIe spec (Ref: r4.0 sec 7.7.1.2 and 7.7.2.2) doesn't support using
a mix of INTx and MSI/MSI-X, MSI needs to be disabled to avoid root ports
service drivers registering their respective ISRs with MSI interrupt and
to let only INTx be used for all events.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
---
V13:
* None

V12:
* None

V11:
* Included older Tegra chips to extend the quirk as this issue is present in
  older Tegra chips as well.

V10:
* None

V9:
* None

V8:
* Changed quirk macro to consider class code as well to avoid this quirk
  getting applied to Tegra194 when it is operating in endpoint mode. Also
  quoted relevant sections from PCIe spec in comments.

V7:
* This is a new patch

 drivers/pci/quirks.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c66c0ca446c4..1d3cac43ecbc 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2592,6 +2592,59 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA,
 			PCI_DEVICE_ID_NVIDIA_NVENET_15,
 			nvenet_msi_disable);
 
+/*
+ * PCIe spec r4.0 sec 7.7.1.2 and sec 7.7.2.2 say that if MSI/MSI-X is enabled,
+ * then the device can't use INTx interrupts. Tegra's PCIe root ports don't
+ * generate MSI interrupts for PME and AER events instead only INTx interrupts
+ * are generated. Though Tegra's PCIe root ports can generate MSI interrupts
+ * for other events, since PCIe specificiation doesn't support using a mix of
+ * INTx and MSI/MSI-X, it is required to disable MSI interrupts to avoid port
+ * service drivers registering their respective ISRs for MSIs.
+ */
+static void pci_quirk_nvidia_tegra_disable_rp_msi(struct pci_dev *dev)
+{
+	dev->no_msi = 1;
+}
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad0,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad1,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x1ad2,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf0,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e12,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e13,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0fae,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0faf,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e5,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_NVIDIA, 0x10e6,
+			      PCI_CLASS_BRIDGE_PCI, 8,
+			      pci_quirk_nvidia_tegra_disable_rp_msi);
+
 /*
  * Some versions of the MCP55 bridge from Nvidia have a legacy IRQ routing
  * config register.  This register controls the routing of legacy
-- 
2.17.1

