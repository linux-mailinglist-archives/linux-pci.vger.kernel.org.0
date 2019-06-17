Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 744A948A72
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfFQRke (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:40:34 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10894 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFQRke (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:40:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d07d0910000>; Mon, 17 Jun 2019 10:40:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 10:40:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Jun 2019 10:40:33 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:40:32 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Jun 2019 17:40:29 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 10/27] PCI: tegra: Disable AFI dynamic clock gating
Date:   Mon, 17 Jun 2019 23:09:35 +0530
Message-ID: <20190617173952.29363-11-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617173952.29363-1-mmaddireddy@nvidia.com>
References: <20190617173952.29363-1-mmaddireddy@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560793233; bh=iSl9/j8Vg+G/etQQQmqnwRBVQSJNn9s8EUSvlisTGPw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=O5FVqlkbUE44/TLUKlW/pJAj+xQMEfcKGP5WzwufLyMY9zys7XgJFfRLVyOreDqHo
         /pveIhTyxlpq4jfssdxf2ikry9p6zagE+5NEGWwB+o4S15q3AmmEIDuHZG5A/du0T5
         q9nxL1kHpRzYmvvzMY7u3Qpk8hgFJemKHOyWqBPrO0WjArvzH3n0aoVl40+Pqcy1Gn
         EQp6TrKs2X2MWuWeNO7SDI5Ro5JDSX9vCeBHT7MTw0iskMvzTOU8e6uaI++Ck83FKz
         f+QSBvEQjmGdoxp349ZA0CWePWm4bKajKs3fu5N5mr6DRYYfxuP+F0E2Mw+IwsqsuE
         b8HgSUm5bXfTw==
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
V5: No change

V4: No change

V3: No change

V2: No change

 drivers/pci/controller/pci-tegra.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 51691252ca10..ca02866fbbb4 100644
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

