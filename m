Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60154AA9FC
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 17:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380381AbiBEQW3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Feb 2022 11:22:29 -0500
Received: from mail-mw2nam12on2046.outbound.protection.outlook.com ([40.107.244.46]:12352
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380394AbiBEQW2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Feb 2022 11:22:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCgxH8aHpWoksQxBBnq2UcGU5AcgboHlafRLN5UfFon4rO2KOxi5eKM7zGI8lhT4LBj34vdjLduDr/KD+lAVMkh8AaSF32Z9Y1UE7Xn9T9oBPX8qczNK0+ZtQ3rwN/xifNhzUccOixD6d24E95Eom9YBVnyw4CeL1xYRjXcAWqlk1sv2bPznKWck8chyRJUAAiJ3KdYhKElaITFyD29AtKOwMM7tbnCjkHUp1MTH8vb14PZMarPD6kDL6BcPiCLOxJ5rgRfrE6AyL7TcbqKBQzA6BL4sxvFd8cjl4osiTZEb2khVpGCJk/LdM5yslYzJvM2w/8wwLtwHCkcPlD8R2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1hOyyex1ujTDTaDnJm7l/gW58ruqzAGgdxTmcO13Bk=;
 b=fN15OZQu0/FHPFuL/eZ3BrVYXLdcrHBK5+NbWQdSgNpM3wRppDwtdgPFnfnrboS+tK23aK0hunfv5xzQTAkAN5BEpjrxZ2yNppgXDJnIz8fm+6pEDjaMpKewtr3rGDNQjbwqZwSPUj5mvqpivo7r1t0MpjuN9f4Brr6MvOpCrlMuqVhDCSdMPdlxyDJFkGkat15SMQ82+4j0ttWp6T+9EiZFuwxKx6e+MXoZjBBR5Yzaq3GX+yFiFdFJhx4phZ7LcTUQ1yJINB7bGwy6Ajx2z83mPEys3rnvL5I3AxyDSbDUB3AXI1lvA+02XdU8oZrg3ymk7FJIxDMtd+dNyoM4/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1hOyyex1ujTDTaDnJm7l/gW58ruqzAGgdxTmcO13Bk=;
 b=bgmI5SwgjYwrTImn4wtwVgUJ7Z/YnrOlpiO6AgTEe/7czk0BOnZ2qrX8TFWEIBdwHizcX0SyYu1eHsgABFOpdno7t9nPhPcZqa6x8JdqVQv2GdaAgy+9tAbyDt3BPPWsDrpvPK7EZPnjw20JT/p3NvR8xouGD3Q0X2hts+lp3N4Vx0SL5FAkjS+bTsJJTIRYaP7IGoJbnmlhi/dSVsFPl3uRWG+Btxb1xhPOZHmbPBQmHEaLtQjfUzIdH6Cqhg4j+TGrD65SGq2kA43Nq92BX0yVby1jJw0BrGJbKE1vUateKld4Cfq4R4NUQhJVKuQNZYCYYae6XCbaoOczc9TyyA==
Received: from DS7PR03CA0160.namprd03.prod.outlook.com (2603:10b6:5:3b2::15)
 by DM5PR12MB1674.namprd12.prod.outlook.com (2603:10b6:4:11::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Sat, 5 Feb
 2022 16:22:26 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::76) by DS7PR03CA0160.outlook.office365.com
 (2603:10b6:5:3b2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Sat, 5 Feb 2022 16:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 16:22:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 5 Feb
 2022 16:22:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sat, 5 Feb 2022
 08:22:25 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sat, 5 Feb 2022 08:22:20 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski@canonical.com>, <p.zabel@pengutronix.de>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 04/10] dt-bindings: PHY: P2U: Add support for Tegra234 P2U block
Date:   Sat, 5 Feb 2022 21:51:38 +0530
Message-ID: <20220205162144.30240-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220205162144.30240-1-vidyas@nvidia.com>
References: <20220205162144.30240-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6493fa70-00a6-44de-0e99-08d9e8c3b2cf
X-MS-TrafficTypeDiagnostic: DM5PR12MB1674:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB16748F6505B8C0BF350760C4B82A9@DM5PR12MB1674.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vJKN/+pItjH2z7M/eK9i8dsofz98g1CgexWKME5bcvAmnatL65cj33vUXeV2IBw0S9BN7GeTFJ77oQX/pZE5DfUApUQ5hNMrJ57We0IwP+Yr51DzZtpm47wtey5kKjsjjNjC8wBXIajguqxb15rzQtSkIlPt3tBYZg8M+1Sbdoc3jzVstc+IUWpHRBXiygN5/uJntezErIY3h+1oNEtKGpa0v1cAC636YiePpUoXGTp++VvJxRpJg2LUEbYO8yLZyRdTaQH5FVtKt0W/NPgTuG5BzvMZ9NHh258FFe+BglG6ou1e2Tj6cEE22S3IX2FOMxWVGlfRu6AFn7dE24g/ME8DPjMzctBKH5eG0Zw8c4fpDoMqqe1jieWPVdtHEnfOBuWI1jR6+jZ5JxVLmQ+Pqvh4ngxeP9TXW7tSdFZZeL/+YCORfHPx40OvxdmXy669GnF/DMH43+4DpFIFtjYGjygBXkaTPhe7q9BB1ZCfz8AJpAtwWO9UiGKLYQAHwOIDs+vB5dIWJQ81DmafvI09RrxpvGOg2NQ+/ejznIWUsKlEC49vN43vfI/46UWu0ZzMwPYIc4O9D3pWw0kmLdbkF21Fw7IyFSAJEA6lS9gsF9Xc88OR8rE8XycgNu5nC5tMaYSVpGm0/Mzb2oExVTcV0PIMIFYjc07YSlVmPMjzvqrGv04x/oDkdhWpmsP+FjZL1D/p8OWA/j2z5Um3oiWJ12Y//l4yd3pg6Vq2U4zIjQEONQGnTBGg99ZL1fk7gVdtnW/1LwEt+wBmXDW9jm03HWWRa02fQxTHVLkQLpx6jh0YZdDflWAWkmNaK04zxpOC5B1mb42nj5DXH4dygaWFGw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(8936002)(70206006)(36860700001)(8676002)(70586007)(36756003)(7696005)(356005)(6666004)(81166007)(508600001)(40460700003)(6636002)(110136005)(47076005)(2906002)(86362001)(83380400001)(5660300002)(7416002)(54906003)(316002)(426003)(2616005)(1076003)(186003)(26005)(82310400004)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 16:22:26.4723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6493fa70-00a6-44de-0e99-08d9e8c3b2cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1674
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Tegra234 P2U (PIPE to UPHY) module block which is a glue
module instantiated once for each PCIe lane between Synopsys DesignWare
core based PCIe IP and Universal PHY block.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 .../bindings/phy/phy-tegra194-p2u.yaml          | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
index 9a89d05efbda..6ba1f69b1126 100644
--- a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
@@ -4,7 +4,7 @@
 $id: "http://devicetree.org/schemas/phy/phy-tegra194-p2u.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: NVIDIA Tegra194 P2U binding
+title: NVIDIA Tegra194 & Tegra234 P2U binding
 
 maintainers:
   - Thierry Reding <treding@nvidia.com>
@@ -12,13 +12,17 @@ maintainers:
 description: >
   Tegra194 has two PHY bricks namely HSIO (High Speed IO) and NVHS (NVIDIA High
   Speed) each interfacing with 12 and 8 P2U instances respectively.
+  Tegra234 has three PHY bricks namesly HSIO, NVHS and GBE (Gigabit Ethernet)
+  each interfacing with 8, 8 and 8 P2U instances respectively.
   A P2U instance is a glue logic between Synopsys DesignWare Core PCIe IP's PIPE
-  interface and PHY of HSIO/NVHS bricks. Each P2U instance represents one PCIe
-  lane.
+  interface and PHY of HSIO/NVHS/GBE bricks. Each P2U instance represents one
+  PCIe lane.
 
 properties:
   compatible:
-    const: nvidia,tegra194-p2u
+    oneOf:
+      - const: nvidia,tegra194-p2u
+      - const: nvidia,tegra234-p2u
 
   reg:
     maxItems: 1
@@ -28,6 +32,11 @@ properties:
     items:
       - const: ctl
 
+  nvidia,skip-sz-protect-en:
+    description: Should be present if two PCIe retimers are present between
+      the root port and its immediate downstream device.
+      type: boolean
+
   '#phy-cells':
     const: 0
 
-- 
2.17.1

