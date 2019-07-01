Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412015BA63
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 13:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfGALJt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 07:09:49 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19560 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfGALJt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 07:09:49 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d19e9ff0001>; Mon, 01 Jul 2019 04:09:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 01 Jul 2019 04:09:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 01 Jul 2019 04:09:48 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Jul
 2019 11:09:47 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 1 Jul 2019 11:09:47 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d19e9f90000>; Mon, 01 Jul 2019 04:09:47 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <treding@nvidia.com>, <swarren@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2] PCI: tegra: Enable Relaxed Ordering only for Tegra20 & Tegra30
Date:   Mon, 1 Jul 2019 16:39:42 +0530
Message-ID: <20190701110942.24305-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561979391; bh=ZbnJnTHs4oFdQE2uMI8aNFd9ivRt5GX/d6xemOgOi9I=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=dELN3TCNh1lkrDoIo0FAuPs7jeNlTODXm8TCtOMRQpyXp1WqVbVIBHkBPyNsGUkLp
         Z6A7pL1vC4npK+gQIuRoMEPIzlxroOPrr3Lw9UDvk8tGiRRjD+bwDL7FhQ0aVsZPs8
         Jm/+/K/XB7w+vlNz9HorL+hLi+V9UdY4l81eBfj3LPpoCWiYUZA/gZ41NbwL3QJMuK
         KZzx7cBLT8vacKrEdcGRaRg+f2AQpY3EmdNzbc399ITv6NALH/kmGcndZNI2oDL5jF
         oXlqsUGo6C5Ck6IelXQMrbBeobwrutBk9+ts4NqLo2j094Q/oFmltWpSm0uUmwlvAf
         G28LMpUBQxG6Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently Relaxed Ordering bit in the configuration space is enabled for
all devices, but, as per the Technical Reference Manual of Tegra20 which is
available at https://developer.nvidia.com/embedded/downloads#?search=tegra%202
in Sec 34.1, it is mentioned that Relexed Ordering bit needs to be enabled in
its root ports to avoid deadlock in hardware. The same is applicable for
Tegra30 as well though it is not explicitly mentioned in Tegra30 TRM document,
but the same should not be extended to root ports of other Tegra SoCs or
other hosts.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Modified commit message to include reference to Tegra20 TRM document.

 drivers/pci/controller/pci-tegra.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 9cc03a2549c0..241760aa15bd 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -787,12 +787,15 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
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

