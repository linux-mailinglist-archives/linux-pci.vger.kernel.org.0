Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B115F1268
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiI3T2Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 15:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiI3T2W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 15:28:22 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D087C8435;
        Fri, 30 Sep 2022 12:28:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+J3E882V7IJERWsbrjm/VgPQbfND2nsvu7jAZTloeSQr5vD07JR7Tyo2qK3qEZ81v/38n8BC80zgVVa5zzV4RbhtKDrpprDxLebl4gt2Q+hwP7OtSV6QXhJIAkGwkrd9UJc4H4I+Vj7pDgoAy5CURro4aVmWZW6yGasclTQRmFahKWNmB1oRUYe3PE7cdmqZK5K59wUdvCdbwwxCyu/jW1Qd7z9EUdq/uT10rEBn9uGLsi5GkPu9BWRG9xKdI4+YQSYApZ9ZvDDiRsnZt4QaeJh5Ezb6shME4T5+rWuHLokiB6EDXUo4GSi0BXJW7kV/RHNvsMFMG/mLqGOekCZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1WX6RbnZmIvbHIN2Mo6cT7oH4UudQr/woHWRR+UUv8=;
 b=MUyyeI4CrnnP0dolKqIn2CRe6a6BvlE8ChPuc1xigeJ5eSGKIDXzByn8jGegKKS888X4mYufHO5rIZUwfwfqGjjlcnba9rERfK9ZE7K3aBd13se1Cp1DCw2zmpCMVtexbAxdxJWUvwOyY/oMuuHtiYxb8/4YfoK1NrxAULnSwg11kw44DDF/fTNOYD+GCGQb2NPWUUsGF3iZaAZ+Dp4pxYWkJsok7EDuCgXj78xGVA1dgn6S+7C/ZEbPrSxeM0gd7zcJRKOLYv2QkoBY2NI7OAp4E8uMjmcbEsE79K+1eqiuiY56MgrjH08r7pvZ0ecQ0UbV6dzt9rJkt10IZJ3LRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1WX6RbnZmIvbHIN2Mo6cT7oH4UudQr/woHWRR+UUv8=;
 b=KMr5quEp+OPNtgVhNZlZwco2WTbD6HUMlQ3NS7CNtt94VcMOR1rpme1UUSJ3v4CeYL50l662OYVxKuZoDIcNp40GCvItGxyXGXYk86F5WP/WT2+2Zc+Hr8j7zqAI+HbYm7xZwgo1JlZwbcs+hgE1YdPU1gjEbtqE70XjO04hGaRNjIW2DTt2hBceQNLE1FGGSkr3vLRo/fON0cE5YM0YGlJ/VzrRHPDCfp7+isEJozeowCcWFhAsg+yFxiB1uQ9y9d8tKq2dXBCyfT9qKMZ/5DzEIOKEWx9QiZXHC8JbIWHaxeKqrdU7i/U1Eog44JGCcHvQZcU/br4Z0cDgHKVi2w==
Received: from BN1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:408:e2::24)
 by DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 19:28:17 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::c4) by BN1PR13CA0019.outlook.office365.com
 (2603:10b6:408:e2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Fri, 30 Sep 2022 19:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 19:28:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 30 Sep
 2022 12:28:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 12:28:04 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 30 Sep 2022 12:28:00 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mani@kernel.org>, <Sergey.Semin@baikalelectronics.ru>,
        <jszhang@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 1/4] dt-bindings: Add "hotplug-gpios" PCIe property
Date:   Sat, 1 Oct 2022 00:57:44 +0530
Message-ID: <20220930192747.21471-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220930192747.21471-1-vidyas@nvidia.com>
References: <20220930192747.21471-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT008:EE_|DM4PR12MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c06304-ed3f-4ffa-bf91-08daa319ed3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LSDlUvgnlATxJkdLXFwUJ10Mhoa+vdiGF3yoCJnmaWZnXYE0jfTikD4AS/cJj6S6zjQIigw6pE6rG+U9ulWJ2+CJ6Guq8PpbPM+2LoLQfgdtkNXg4cAKtm6DCJ0dPQiWTY47y6IsIQPicCk00S7IiTGn9ikiBFbfFEaB86QRON6QazGpnJqAeiRKqviBkVnDTgNJonf5pFQh2OarHJyTlx4W+Ikwfa9HYHjWPiaJfRZltRuOnRg1BR89rGmJs5bEaIMxPMbjRifWljdwtDuoAnQ8RNGU8ADiFGUeGw+IAmB6rSDH1HcSmDz/daACGD9Hz4wvXf2cTJrkwq2HY5GvPRwRX072Ob7Ij5GOdWUXj2adnF47J+iX9yIzXJGoZVYFvCM4ly9lVgJcnYCAkuC2sBugXmJgCKUbGbecwmfHWO5cs/28RRBYnjp1ka91NiecuvBcsnHIiKUw2U9Ip7a6z/vIYjIidccK0/74TNB7YbwF3M7JvyDY/wG0WIRBBSDynDUj04qKuJVRClMkm2xutChXye599/vPfrMOQ3K72djhkHMVdOFacpZb5W+V27VdjRv/pVeXThbc1p1eXMaSwpwTx/j4ky1ZuBBbWinjLqizr+AyZyF4tRY5bBJWUkboqJTjbjQISQC63IJ1Mhx5heOXgAHDLcHYC8IeKBt+olaHPuk7oLkzvB/t1ghL6Kl7IfdcQfffCh4NMUTzrVyXq7PAg172T4Oj7cCpW+WSTyj0TEERHpoN5ELrsryp63r90xbfxN2IwYDpdBuMgo5CPJwrStMG4/Gf8XhsY0Yn4cs=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(2616005)(186003)(1076003)(7636003)(426003)(47076005)(7416002)(82740400003)(921005)(336012)(356005)(5660300002)(2906002)(41300700001)(8936002)(36860700001)(40480700001)(40460700003)(82310400005)(478600001)(6666004)(26005)(7696005)(316002)(4326008)(8676002)(70206006)(70586007)(110136005)(54906003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 19:28:17.3875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c06304-ed3f-4ffa-bf91-08daa319ed3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5213
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide a way for the firmware to tell the OS about the GPIO that can be
used to get the Hot-Plug and Unplug events.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 Documentation/devicetree/bindings/pci/pci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 6a8f2874a24d..7b89bddc8dde 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -32,6 +32,10 @@ driver implementation may support the following properties:
    root port to downstream device and host bridge drivers can do programming
    which depends on CLKREQ signal existence. For example, programming root port
    not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
+- hotplug-gpios:
+   If present this property specifies the GPIO to be used for Hot-Plug/Unplug
+   functionality. It is used by the PCIe GPIO Hot-Plug core driver for
+   PCIe device Hot-Plug/Unplug events.
 
 PCI-PCI Bridge properties
 -------------------------
-- 
2.17.1

