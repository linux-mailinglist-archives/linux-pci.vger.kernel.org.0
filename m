Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B681F1FF04
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEPFxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:53:51 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8933 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPFxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:53:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfaf40000>; Wed, 15 May 2019 22:53:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:53:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:53:49 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:53:48 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:53:49 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:53:46 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 10/28] PCI: tegra: Disable AFI dynamic clock gating
Date:   Thu, 16 May 2019 11:22:49 +0530
Message-ID: <20190516055307.25737-11-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516055307.25737-1-mmaddireddy@nvidia.com>
References: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557986036; bh=5SgOrP+nLbb7ym9qce2XkEKQzw6Yhv0YLLj+21ajHjM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=IaWYTcjvVJjdC/EoD9VJA4xMSbLp0vUxanBTE+2fleCueHI/yEMERQvAjeHfMQKNP
         44mUNggEIa+crFYPd6bQPUtUhlsA3h+hJcRtiwl+dN5LKkC4KDI00UZINZ4ufvROfq
         vCLDHkYXW4/cDqjSmU44GI0nrh7BibjFnADdRXKN8kOtlimT8KXSoN2ethSzOQOrEM
         4WQXjUAmsVx8iSOrNjEEVA+h6eGJldz/n598uL46sXgPYekPKBys1ROi+2fZHEzcKD
         aO+2VtyYtChbfJgk2D1zomjW+f04l7YPNt+r935ya0jTgfGgUGJc5vymBeRA+Cqf61
         VAOwB9vbPIPNg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Outstanding write counter in AFI is used to generate idle signal to
dynamically gate the AFI clock. When there are 32 outstanding writes
from AFI to memory, the outstanding write counter overflows and
indicates that there are "0" outstanding write transactions.

When memory controller is under heavy load, write completions to AFI
gets delayed and AFI write counter overflows. This causes AFI clock gating
even when there are outstanding transactions towards memory controller
resulting in system hang.

Disable dynamic clock gating of AFI clock to avoid system hang.

CLKEN_OVERRIDE bit is not defined in Tegra20 and Tegra30, however
programming this bit doesn't cause any side effects. Program this
bit for all Tegra SoCs to avoid conditional check.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4: No change

V3: No change

V2: No change

 drivers/pci/controller/pci-tegra.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index b1e2e398b4e8..17c6d858ddc6 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -95,7 +95,8 @@
 #define AFI_MSI_EN_VEC7		0xa8
 
 #define AFI_CONFIGURATION		0xac
-#define  AFI_CONFIGURATION_EN_FPCI	(1 << 0)
+#define  AFI_CONFIGURATION_EN_FPCI		(1 << 0)
+#define  AFI_CONFIGURATION_CLKEN_OVERRIDE	(1 << 31)
 
 #define AFI_FPCI_ERROR_MASKS	0xb0
 
@@ -1065,9 +1066,10 @@ static void tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 		afi_writel(pcie, value, AFI_FUSE);
 	}
 
-	/* finally enable PCIe */
+	/* Disable AFI dynamic clock gating and enable PCIe */
 	value = afi_readl(pcie, AFI_CONFIGURATION);
 	value |= AFI_CONFIGURATION_EN_FPCI;
+	value |= AFI_CONFIGURATION_CLKEN_OVERRIDE;
 	afi_writel(pcie, value, AFI_CONFIGURATION);
 
 	value = AFI_INTR_EN_INI_SLVERR | AFI_INTR_EN_INI_DECERR |
-- 
2.17.1

