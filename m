Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD0E5FA96
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2019 17:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbfGDPEw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jul 2019 11:04:52 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19741 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbfGDPEw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jul 2019 11:04:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1e158f0000>; Thu, 04 Jul 2019 08:04:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Jul 2019 08:04:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Jul 2019 08:04:50 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Jul
 2019 15:04:50 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Jul
 2019 15:04:50 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 4 Jul 2019 15:04:50 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d1e158f0000>; Thu, 04 Jul 2019 08:04:50 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <treding@nvidia.com>, <swarren@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3] PCI: tegra: Enable Relaxed Ordering only for Tegra20 & Tegra30
Date:   Thu, 4 Jul 2019 20:34:28 +0530
Message-ID: <20190704150428.4035-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562252687; bh=I9PI6WHqBagP/fx7Jo91kKuvHpefk2PKC9kpvjEKNjM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=VWZzQta7ei0fC6qz+iEfm4aZo9ZUxJ9rmWsYhoRNuVjZrFqnf8bmlAv1DX2xl/lwA
         CTJwSF0HZmUtifXHU13jKHtujF7PLuOSDiHrJI4ec2WGXMYMm7h+LFgWJ0DkcsRNt3
         SVNhWSfq4VxpHfiaTHesJgzbN9gS6Sm4ofQH0kADi56nmraLnbrzlQMw27zB4mrLiG
         iQA2pBguK3DL2Nm8bh0T/OfiTflyXyHAkEbJD9uEeSZETMSyQn1XK/3hh5vgMeOhOH
         9aSb3Kk2F6Py0oJ39UJZgbADImcaJUlJT0bpw9nATlmTNlqIHC/kwIjEkNVppjWk1o
         hw4+GXyPDHp0A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently Relaxed Ordering bit in the configuration space is enabled for
all PCIe devices as the quirk uses PCI_ANY_ID for both Vendor-ID and
Device-ID, but, as per the Technical Reference Manual of Tegra20 which is
available at https://developer.nvidia.com/embedded/downloads#?search=tegra%202
in Sec 34.1, it is mentioned that Relexed Ordering bit needs to be enabled in
its root ports to avoid deadlock in hardware. The same is applicable for
Tegra30 as well though it is not explicitly mentioned in Tegra30 TRM document,
but the same must not be extended to root ports of other Tegra SoCs or
other hosts as the same issue doesn't exist there.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* Modified commit message to make it more precise and explicit

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

