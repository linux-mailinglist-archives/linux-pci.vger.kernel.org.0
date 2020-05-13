Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00EF1D1EE0
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 21:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390645AbgEMTQf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 15:16:35 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8013 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390443AbgEMTQf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2020 15:16:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ebc47860001>; Wed, 13 May 2020 12:16:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 May 2020 12:16:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 May 2020 12:16:35 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 May
 2020 19:16:34 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 May 2020 19:16:34 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ebc478f0002>; Wed, 13 May 2020 12:16:33 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <robh+dt@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH] arm64: tegra: Fix flag for 64-bit resources in 'ranges' property
Date:   Thu, 14 May 2020 00:46:27 +0530
Message-ID: <20200513191627.8533-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589397382; bh=w/XekWVPrm/cmb5lCApL00WgoP1t9EJZ4Acir2w8jUA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=fJdx3dGzM+xx6XYDbd8KVP2yTcEkYlhmvqIGOjDrDeuODwyOf+5xgFeVPCi9816q0
         QAWNHAvwAQcs73ENjFicPlQCgRUthO/29eqpWonuFgT8xIAzO2fiFlKZ/CHvhIWSW4
         6zhnvh9SrEUVhnozZGihscrFUnxXRrUfC9U4GweLLAGR1WBrVdQv0bp3CsHncFRwvG
         Zp3qMdWOQu5taLQIZ98Zt0EftsZL7DmxF9RyEHQhdI/t7bauTIBp3nzHGjnedFk1le
         F23nAdZ/zACzLiKkNjY1QEWJt+j+kCP2VaGFK1RoRbnqp36CJOTpIwssH8BIk3M530
         4tyYceuYIEF8A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix flag in PCIe controllers device-tree nodes 'ranges' property to correctly
represent 64-bit resources.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index e1ae01c2d039..f7462ad4aa70 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1540,7 +1540,7 @@
 
 		bus-range = <0x0 0xff>;
 		ranges = <0x81000000 0x0  0x36100000 0x0  0x36100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc2000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
+			  0xc3000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
 			  0x82000000 0x0  0x40000000 0x17 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
 	};
 
@@ -1585,7 +1585,7 @@
 
 		bus-range = <0x0 0xff>;
 		ranges = <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
+			  0xc3000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
 			  0x82000000 0x0  0x40000000 0x1b 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
 	};
 
@@ -1634,7 +1634,7 @@
 
 		bus-range = <0x0 0xff>;
 		ranges = <0x81000000 0x0  0x3a100000 0x0  0x3a100000 0x0 0x00100000   /* downstream I/O (1MB) */
-			  0xc2000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
+			  0xc3000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000   /* prefetchable memory (13GB) */
 			  0x82000000 0x0  0x40000000 0x1f 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
 	};
 
-- 
2.17.1

