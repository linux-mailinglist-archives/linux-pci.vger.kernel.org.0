Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE482AC1F5
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 18:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgKIRTs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 12:19:48 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7947 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgKIRTs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 12:19:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa97a3a0001>; Mon, 09 Nov 2020 09:19:54 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Nov
 2020 17:19:44 +0000
Received: from vidyas-desktop.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 9 Nov 2020 17:19:40 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <amanharitsh123@gmail.com>,
        <dinghao.liu@zju.edu.cn>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4 0/6] Enhancements to Tegra194 PCIe driver
Date:   Mon, 9 Nov 2020 22:49:31 +0530
Message-ID: <20201109171937.28326-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604942394; bh=IvYjbG1KgA2RgVe9ud9fZCD/tmcc0soDLVo+WY2WI4k=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=jGviRclDUALFaFOx+2Rj72bKpCpsVZnrFDn1P9EDeOQcW0ZMmM9+4QaWPJZFraXGx
         1Khz8ytJucSpnOJdD5uCVPm/Fuj5MzYQM/+MJ2GJw8i4G9sHDbZtSXxToY+67qzJN5
         Cw6wVpXK+VMfDksCUA/+DvpvbVKar/Fz9iyT/Hkn0/kebjdCLL9EugTrtQa4n0gXxb
         k3KkONzzuqLOhJHE9CGfzzW3dWsmgMURl4uUgaRzfpBvij7OsFumG81QRXgiCylkU3
         eY5oH5RIui4R6+vNhgxfNXnztFABQgOl3DLlrTCHz0YNCeGjppofHcQBCCJfBSQYSY
         tq9uo9oV547cg==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches do some enhancements and some bug fixes to the
Tegra194 PCIe platform driver like
- Fix Vendor-ID corruption
- Map DBI space correctly
- Update DWC IP version
- Continue with uninitialization sequence even if parts fail
- Check return value of tegra_pcie_init_controller()

V4:
* Added a new patch to address link-up issues with some of the cards

V3:
* Addressed Bjorn's review comments
* Split earlier patch-4 into two
  - Continue with the uninitialization sequence even if some parts fail
  - Check return value of tegra_pcie_init_controller() and exit accordingly

V2:
* Addressed Rob's comments. Changed 'Strongly Ordered' to 'nGnRnE'

Vidya Sagar (6):
  PCI: tegra: Fix ASPM-L1SS advertisement disable code
  PCI: tegra: Map configuration space as nGnRnE
  PCI: tegra: Set DesignWare IP version
  PCI: tegra: Continue unconfig sequence even if parts fail
  PCI: tegra: Check return value of tegra_pcie_init_controller()
  PCI: tegra: Disable LTSSM during L2 entry

 drivers/pci/controller/dwc/pcie-tegra194.c | 78 +++++++++++-----------
 1 file changed, 39 insertions(+), 39 deletions(-)

-- 
2.17.1

