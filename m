Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0C1773D70
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjHHQRm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjHHQQK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 12:16:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E34826B8;
        Tue,  8 Aug 2023 08:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4XnAYrjOf+5HPjb5xW+jUw4LJHM9x2onQoYjqjyir8WypiLgDKWxNpUBZlhHm0sjnOl2nfSkzo8OLs6AiBBEY+S0RggsHj07w55QQ8qEgL2mQolJeOWkNP7U4lN0zej0zBPXLFkTj9VkVOhoD2xRrkALdWzkTIcp/LjV+jlHmy3XQAYNr1daKKf7yPXbenlLLw5Zn/vv0CYy7vOSSWqGjQB3P376JJ+/jWJcFIh62h/uM7ZNsGoouVlDSHa9VFgZeWecnMLuvqYacqJsPYLlo8MNflk8Nhb02ZkKhbVsvwCG3UoRvvhCralTUX6BwEqRxWZDm29sRG0BMRFH5OKXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6iMn9NAKlcBVF7tE7k+QmxyMwxfxbxz27R5FDL+wpU=;
 b=TKFrTlfW/00lygvqeyiFo81rpTadcwCBQokhwzgO907MRZvKkLgxfwreg72UIbUwIOW39skE0DzAAw5f3rmizpCZcZZmbQYgSCDWB1iN5/Gimgd6OMmHNJ4JhwErY7hDTxPnmDl0iJCcBKsxoixtNdIzgBKBfn53jRAWYGxM+efS0PPn4KGhhOQ+CbcpfFnjLYIydCqUwDaGNCOnJW1lPkh2THq6n5lkElUamPb3T4IHpzBRyZ7xSW0F2RXJF80gfY1IFIg34v+XDAdNOvuZKWj7WWYUfuOKEEKnwjPAAcVTiBd1vvZRdXWu999TFmxcewif2iBJXksvY3EOJRDuMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6iMn9NAKlcBVF7tE7k+QmxyMwxfxbxz27R5FDL+wpU=;
 b=XfV+8yr1LIthpGUbSUFQx0q2aEmvJL3SwoueUt9h5vGvVqWSq5Cg3OacOAdN5vOZ+NU5dSEXybcDRx4XIN7sgA5606DFwgywTIztwAAu/sAXuORGACnhWIbSfNURyiLX+Rwzz0Dp0VthntvMI3f0AzW9bEU3jafaka7O3KmCQY0=
Received: from SA9PR13CA0114.namprd13.prod.outlook.com (2603:10b6:806:24::29)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Tue, 8 Aug
 2023 10:38:03 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::5a) by SA9PR13CA0114.outlook.office365.com
 (2603:10b6:806:24::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.17 via Frontend
 Transport; Tue, 8 Aug 2023 10:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 10:38:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:38:02 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:37:48 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 8 Aug 2023 05:37:45 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v2 0/2] Increase ecam size value to discover 256 buses during
Date:   Tue, 8 Aug 2023 16:07:31 +0530
Message-ID: <20230808103733.93707-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808103733.93707-1-thippeswamy.havalige@amd.com>
References: <20230808103733.93707-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 525f69cd-89fd-467f-9575-08db97fb8b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIQa9haKkOYq8Miv4wqNeG5+r3MYz83J3W9xyinmEDeSiZiu/A0mz8wgfVFdadu/J3KLDN4YVl61o+BOaqrpXLUX18O+sPdl+lAoSpSqwMgZI88hChW1YwcHJST/tnDX4P2k5hLuliJ3WUv7Rj8QjjXdd/VeAmNo9tgGvNwuTf4dpfy7b3on8WrlAl6I2sZ6bU2N299shDbsOcFFdxjZ0u2ZZkl+9/DWlJ5hum0f8BY5g1JoycPsMhgy2pFP7Bh4kF/jZwOrAjMXJOlNeFhzTfBzgEetEgqHvtaGhpy36BY8higywS+6SCyxQIJe45ypRIpiN0UEcGGgXtPvXD5y0emVGvuOJ2VZeIuvTkbzaOdnKeXtteeMJ2hHs4do1U4TTXVuhc/e872few8zTAPBYxHyUNK4ASVVFdEbD9WyM+p9FXDpnup0SSgkhfaFQffQ8xMLRFhWyt3qquyaKX040B2Vn+QpvXJEfiypb0mmPCyreWjE5Byw57BKH8ukArvj2sdS9bbvC/QOtw05Dtu/C7TXJmsJMh4B9Q4IGustVO4ShmCjud2EEPeAY22gNlLoOgAsLkDM183Gz9HsBSZNzewtMX3lsII8Y3JbXtt7c7m8im8xSHpD9VHMdW41/SR02O7xx6hAUONZL9C1fZrfPCD53QPp1vcM0G6o8A4ligciRkkWAU0gc/7EFIIDpCQmpmR4Sx2y7F8mzfnXQ4XPuNf4e3D0YPvw80MeXkWRZjCdxv9TyxGI/SAH2JfjVIP8mlMxo2u9WoNoUgZBCcWmmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(82310400008)(1800799003)(186006)(451199021)(46966006)(36840700001)(40470700004)(426003)(1076003)(26005)(2906002)(5660300002)(44832011)(83380400001)(8676002)(36860700001)(4744005)(47076005)(41300700001)(8936002)(2616005)(40460700003)(40480700001)(336012)(82740400003)(86362001)(316002)(356005)(54906003)(110136005)(478600001)(6666004)(81166007)(70206006)(70586007)(4326008)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:38:03.2659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 525f69cd-89fd-467f-9575-08db97fb8b55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Current driver is supports up to 16 buses. The following code fixes 
to support up to 256 buses.

update "NWL_ECAM_VALUE_DEFAULT " to 16  can access up to 256MB ECAM
region to detect 256 buses.

Update ecam size to 256MB in device tree binding example.

Thippeswamy Havalige (2):
  dt-bindings: PCI: xilinx-nwl: Modify ECAM size in example.
  PCI: xilinx-nwl: Increase ECAM size to accommodate 256 buses.

 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 2 +-
 drivers/pci/controller/pcie-xilinx-nwl.c                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.8.3.1

