Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96CAE49AB9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 09:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfFRHiT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 03:38:19 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9237 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRHiT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jun 2019 03:38:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0894ea0000>; Tue, 18 Jun 2019 00:38:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Jun 2019 00:38:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Jun 2019 00:38:18 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Jun
 2019 07:38:18 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 18 Jun 2019 07:38:18 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d0894e60008>; Tue, 18 Jun 2019 00:38:17 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH] PCI: tegra: Enable Relaxed Ordering only for Tegra20 & Tegra30
Date:   Tue, 18 Jun 2019 13:08:10 +0530
Message-ID: <20190618073810.30270-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560843498; bh=b6l2MOnYvA7QD1RhZe0gmc+lZ9NiSwOeR+S40ZiwKI0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=OcKPYCfp23DM0vyKm/uOs4PNd7VneVJrkeKDMB8VNupUPadM8k/Kq+lYzgQLR1bWl
         X7MUHbI6z9eQpBQI2QMXPG/I4C1TZlcCnVaxOAsKqkGIlNhUfRJgGtEBCqsfXQb4If
         s9GbGEuLRAq/5UsMErQ5MDM9U3AOflpf51/ktyhvIuZ+TbPeI7U6aZCGLNZ/lEQ+/j
         5IPCIXIpGDsAU2d53RoUriJ7yQbmyjksA1LuNTKJ/ruEI5mXIPT7tKyp4tJNWxiQKL
         zLHggdntrIPZc3yXX6wnJqKtkMl5hdHROKTTD58f/rc6dJnYhAsWUpolsmOTXzw3vr
         IjqcAdy7JNG2g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently Relaxed Ordering bit in the configuration space is enabled for
all devices whereas it should be enabled only for root ports for Tegra20
and Tegra30 chips to avoid deadlock in hardware.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 464ba2538d52..bc7be369c1b3 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -545,12 +545,15 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_fixup_class);
 
-/* Tegra PCIE requires relaxed ordering */
+/* Tegra20 and Tegra30 PCIE requires relaxed ordering */
 static void tegra_pcie_relax_enable(struct pci_dev *dev)
 {
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_RELAX_EN);
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, tegra_pcie_relax_enable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0bf0, tegra_pcie_relax_enable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_relax_enable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_relax_enable);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_relax_enable);
 
 static int tegra_pcie_request_resources(struct tegra_pcie *pcie)
 {
-- 
2.17.1

