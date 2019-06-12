Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D237042184
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 11:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437775AbfFLJyE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 05:54:04 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16042 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437698AbfFLJyE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jun 2019 05:54:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d00cbbb0004>; Wed, 12 Jun 2019 02:54:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 12 Jun 2019 02:54:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 12 Jun 2019 02:54:02 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Jun
 2019 09:54:02 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 12 Jun 2019 09:54:02 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d00cbb50000>; Wed, 12 Jun 2019 02:54:01 -0700
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
Subject: [PATCH V10 02/15] PCI: Disable MSI for Tegra194 root port
Date:   Wed, 12 Jun 2019 15:23:26 +0530
Message-ID: <20190612095339.20118-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612095339.20118-1-vidyas@nvidia.com>
References: <20190612095339.20118-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560333243; bh=TgQh0KW52B5ee+vdx914db29NSc2mR2j2vjGrGdjUk0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=HpwBXYlm6Pe3pz+1sU6mccGoS+Gy+fsXzbJR719nE+AW0j9nj488+yRteNXND5u71
         xFvMtwUleQ7tIGt/ArvKKpbSxV6pqdNRH8bkK9drvzRamTjiwdjFAEE44sqACG1z5q
         3L8foU5qUCXMYap/2PqCrDkcJADmjof6vDCSPj7wRjXnxT7hqic+qScBEKxD/mcaZI
         u6NNehGfkqdF32FxDNJHl9AklEPfw4M2EIYYvC+kWuBcg7ze/EbPgp+9IaMUfN6Mum
         +e1VjbfNjnz8beh1aYWrlky+DvuCLdINkp+GHWNpiVmdaZwJxghbm18S2EiIPE09qO
         yLGy88eMaQr3Q==
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
Changes since [v9]:
* None

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

