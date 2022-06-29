Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDAA55F642
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 08:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiF2GE5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 02:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiF2GEy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 02:04:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E038117073;
        Tue, 28 Jun 2022 23:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2oVsIiE7lb6z4j6rUYNFteEVMil5lcZZYPJjmEYiX38zO57XnYDwrunEzba24NAOxe3dGUR5KXuCpzjVaj3IBnGT8tgMgkZxXNfYLMIcOg9eqMGKVAp7EbleB+/T/n0gm47hIenYeKCRug0cmvPRz294fuM/n9mw8c92wCKmdM+71f5Ke/RvDjxdzHEdbti64U3mwqOS0aLx4i3ySQDlMF39MXe3axua8w3l7wU9NquPDAFyaXOL8X4j3wEp9pwbO5OkxhGxbiqbvydIfHtQTBujmtej1J3QgdhcnomECJNY7P4O5uv8y5mpsw7LE1aeHEfmgp0nyf6sut4OqdW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dW1XX8d+yHb7A+atzZh6MNylzpurW7rDTcBYcijnwaE=;
 b=BiX10O7g2p39I9w30LcCPK6bRPZX8ZdAn5broHjZwNSgafGP0BpkJ6ilFzmBFGvq8oSr5q3UpRhctV6jADfp0eYj4nkxMP7TBKFMU0T4nwbFk6/EdAtYSpgfcQz0ux65hgSPZhprleHg8qWTC0yRPmFVjG5CoBbtIrOqUEjm1W038E6BVqLz/zuvSg8N761LJSOJMFnt7sW2hiCm2qeyvrY9FZum1KuBkdJ4sPNbGh3P4zSEyn/gc+zksi7XOeBRBSglONxsVwUAe2/4jJ0ESkxyw3JD6d4OMSJJeARB86njiaqcd6ncp9EXzmsGOhEv1Zw1NVRmD4xbSUL0WU0o5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW1XX8d+yHb7A+atzZh6MNylzpurW7rDTcBYcijnwaE=;
 b=AidKK8A9Iq85hB7fIUAzyIrGa1kRw/L/EMhXXMGny5KDG/it0hzTW6Ne7Ed8tfMg3MzV1RK1uKil7jjLPLmCAljkV6Jlz4vU6h7b0JYfz3wMA0PAzhdyxm9eoNFNZg6bSqxQTL2nC4wzrKeZ1UFaoC2xMTb6qbIvVBBXbXJx+YsXif5kpU+D9DkgG1vtahHi24UW6uSogUD/E+p9TAhvdExdyuLMmqOLRrH/LMRqh5ERt/L7BYEo/JWTZyKASjlIGj5IXb/HNSz+Kt4mZ1IyzO1TowIbB9vbIjetdnZlZR9IInQrgMtYNhnX0VQgAISji3/ACOCbwCorZN9PDuwdww==
Received: from DM6PR03CA0034.namprd03.prod.outlook.com (2603:10b6:5:40::47) by
 MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 06:04:51 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::43) by DM6PR03CA0034.outlook.office365.com
 (2603:10b6:5:40::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Wed, 29 Jun 2022 06:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 06:04:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 06:04:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 28 Jun
 2022 23:04:49 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Tue, 28 Jun 2022 23:04:44 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <kw@linux.com>,
        <krzk@kernel.org>, <p.zabel@pengutronix.de>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 01/11] dt-bindings: PHY: P2U: Add support for Tegra234 P2U block
Date:   Wed, 29 Jun 2022 11:34:25 +0530
Message-ID: <20220629060435.25297-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220629060435.25297-1-vidyas@nvidia.com>
References: <20220629060435.25297-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 446dfc37-3f7b-4e91-928c-08da59954773
X-MS-TrafficTypeDiagnostic: MN0PR12MB5905:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?shuE4vd6xu6udkwWcEouGeNzFOtTMWwkQ+tFwb8BI+iKKS+mTl7rUN4VdTAT?=
 =?us-ascii?Q?MP4XIxWGw50jZ55Y10Xi4w+O23TJf3D9sMoRii7DabRV11JT71EHQ54pyfW5?=
 =?us-ascii?Q?nGIiPClPcYQmicVZWXMtW1W0h7/3Wq2ZZ/7ZpsVNElUyiJ+zJIR7v3VvfK6N?=
 =?us-ascii?Q?vnRDU+y0y3H6K11X/gLSB7Dt/5i7FUCQkVXTyviQIrM8uatv83STyYBCNa1a?=
 =?us-ascii?Q?M5/hTTAUiQi7QOjgpfoqcniivILbP/PdcUfqPuQ2Bkxck+n/jb/YWJJax/Bc?=
 =?us-ascii?Q?4eizNHqrlpNHjWKgpAq8NzfTL7eVRFKDvRnOTe9voK/LpcIsGe8iEYFwrvoK?=
 =?us-ascii?Q?FbQUuEVqeTTKgm6r1FGrq8wDm1X2IoBbslFh3UaPj0qDV6UxVlJ0zsP1zC6Q?=
 =?us-ascii?Q?VUjtWmlvKJcJWBduPeAmnnzc42TtqFofwQICu8Qax2/mK0CDpCE8xKD1T8N6?=
 =?us-ascii?Q?8C+DFd5w6g3hwborS3nSOQWR7CJqD9o8b1WLwFy/Rxrf87/+uREJM3kvW7/S?=
 =?us-ascii?Q?/5mRGU4VKrygVPPHaFUZqw9RrBeSXa53ny+vCi2pBajl4qpDWeYBNyyGSvsP?=
 =?us-ascii?Q?4AHpFR6CtP1bXjzSF42NnBB4NjRLMaTivT1REq5dlgVZ7kjOCLgKy5JF6WJu?=
 =?us-ascii?Q?6IofNXbY1MJi1XDtmDKst9JKS/waLNavhJYVeJ8AqltSmG6PBPf0yTfG7jRk?=
 =?us-ascii?Q?5NUdi1awQWFNRUaN/eEMe1tYy8KezN2nANom9UKBdCrn4vtK0jGXHJANUMYf?=
 =?us-ascii?Q?pFPtEoLGtikXjPlV7kRtnHkLhx/SnkMxq4x3hJdakxVE+1yLhk2rmISuri+L?=
 =?us-ascii?Q?4XEEt+RMLgelM2BwbPM5i0NdyMnTqIV9R7AwYuYCLxYK95qHq7uGJ/ITuWuS?=
 =?us-ascii?Q?Bl1ydRlXcQ+OuFJAeadKNXKs7BeujU8FG/MX0HnVukuezqUCELzulIuVmU5i?=
 =?us-ascii?Q?DFMIbWETGQTGtgyJl7wL3g=3D=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(40470700004)(46966006)(36840700001)(7416002)(47076005)(81166007)(1076003)(8936002)(83380400001)(186003)(336012)(356005)(6666004)(82740400003)(426003)(7696005)(70206006)(40480700001)(40460700003)(8676002)(36860700001)(26005)(82310400005)(316002)(110136005)(2906002)(478600001)(86362001)(6636002)(70586007)(2616005)(4326008)(41300700001)(36756003)(54906003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 06:04:50.8852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 446dfc37-3f7b-4e91-928c-08da59954773
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Tegra234 P2U (PIPE to UPHY) module block which is a glue
module instantiated once for each PCIe lane between Synopsys DesignWare
core based PCIe IP and Universal PHY block.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V3:
* Added 'Reviewed-by: Rob Herring <robh@kernel.org>'

V2:
* Addressed review comments from Rob and Raul
* Ran 'dt_binding_check' and 'dtbs_check' on this change

 .../bindings/phy/phy-tegra194-p2u.yaml          | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
index 9a89d05efbda..4dc5205d893b 100644
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
+  Tegra234 has three PHY bricks namely HSIO, NVHS and GBE (Gigabit Ethernet)
+  each interfacing with 8, 8 and 8 P2U instances respectively.
   A P2U instance is a glue logic between Synopsys DesignWare Core PCIe IP's PIPE
-  interface and PHY of HSIO/NVHS bricks. Each P2U instance represents one PCIe
-  lane.
+  interface and PHY of HSIO/NVHS/GBE bricks. Each P2U instance represents one
+  PCIe lane.
 
 properties:
   compatible:
-    const: nvidia,tegra194-p2u
+    enum:
+      - nvidia,tegra194-p2u
+      - nvidia,tegra234-p2u
 
   reg:
     maxItems: 1
@@ -28,6 +32,11 @@ properties:
     items:
       - const: ctl
 
+  nvidia,skip-sz-protect-en:
+    description: Should be present if two PCIe retimers are present between
+      the root port and its immediate downstream device.
+    type: boolean
+
   '#phy-cells':
     const: 0
 
-- 
2.17.1

