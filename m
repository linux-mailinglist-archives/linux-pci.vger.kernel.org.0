Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0633277BEC3
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 19:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjHNRPb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 13:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjHNRPU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 13:15:20 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F042E6A;
        Mon, 14 Aug 2023 10:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpKGjIlTld2pG56ei3qR4fuwugYwwfEsBgceTge0imghk+wdQ2Uq2c8mk4zqM0Dwry/D68KV2vylSSdPMmiMR3dkjdQBl3dxnuNy3Qyb8yd2umyxit91Dj30CmVEE7cvYCE2FgU0e1fsKDAeGA6nW6AmGXLrAdlUz6zWxc4Q/locODA0foVmCeKxZ+NB8UWjv3XOgNQWukfsdf2bTyczL4JbrEElEvOK+wQJhrEW4WQzBHrzbHKxU04nK3LYzbwAnuJYViMsGbpXa5P7CVOYe/OyVoYs679twd3GBV2VVfc+aQRB+kTEKzG3+p2V6eqa0X5RksyXXSbDp0nQRZcOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uh9Rp04kDL48pQKn/zTZ+GEuVGKPGA6pCD5uDT5nbKs=;
 b=XEVkYSv1SmGo4z4oLeBAHUiDNCsisdohvER8v1cFoena0V6bRS3ypqGrqRgmJ8n0cpmUfUFTTeSKoeseS5ai8hnpx8SfHPyTQWC14EyLgKS4ZOLFLHax547JM1YlVgcm3lqzDBzx5giShd0vT16JZYMUak6FaI6freO95h5u3Knq39Z2RRPu2nqyIyeg8vhgYmaJcnch8iFKlYfeXMPt7+fnaPLYavTlajlP0+YaYj8X5HoG/KlE5NYApFSUUZ/wITOP57c909pcD0xgr0LbfpPz9wViBVPC7EcKFus1SrH17BBAvOTAweKUCNty1RFqzHRoI4rPKOarYwZ0trZ2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh9Rp04kDL48pQKn/zTZ+GEuVGKPGA6pCD5uDT5nbKs=;
 b=nEHWeBD9B19ZEPfToebqSX6tQsbqmaDRzFDuVzLR2nT/lzEffs8e4PsQzkVV6HJ6fTtw53rZAEUM0W9UIP/xi3Q9uK8NBI7zDG1wTnaj5M+BTie5gZ3f71qVYFHYvNaqbid+XLbV7emG3OpepRQC7mElCtgBEFodGG1IKn3Q+ZE=
Received: from BN0PR04CA0123.namprd04.prod.outlook.com (2603:10b6:408:ed::8)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 17:15:15 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::e8) by BN0PR04CA0123.outlook.office365.com
 (2603:10b6:408:ed::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Mon, 14 Aug 2023 17:15:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.12 via Frontend Transport; Mon, 14 Aug 2023 17:15:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 14 Aug
 2023 12:14:44 -0500
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 14 Aug 2023 12:14:41 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <conor+dt@kernel.org>
CC:     <lpieralisi@kernel.org>, <bharat.kumar.gogada@amd.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH v4 0/3] Fix ecam size value to discover 256 buses during
Date:   Mon, 14 Aug 2023 22:44:03 +0530
Message-ID: <20230814171406.214932-2-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814171406.214932-1-thippeswamy.havalige@amd.com>
References: <20230814171406.214932-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4eb0b3-5a1a-498c-7a16-08db9cea05e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhsGscbvfPPKbNrx3A7Z2pNj6UoTcTIWFnE6bhCGy4lqDSQMzERVi8rGpIfD5wasGFLY7rXIM1wYVemZGF0uLBJGIx9QPfRGHbuz2qj2xftv1EW+fNAV1KcrJ6ho1pzIAvcOlHBdBZ7Cr/2bnI9WNHhVtsABkNlpskds2KdkQ3LLth+JmKYph+I/R+pGKgbqJR+3Gy3Lkb0POBxCfdeUFPoF/xNTk2qfvk3IZ3bZsX7rDXDZH0w3XDzbVcPyPPQizsk+5OaM/ToytacICS7JtGsU02XEBAoiFLukUP4DlsVSmLITiipcgIqyLA6NLI+JATKRm7DpOg7jMdNQofUVK2ByyWS0ulqtoT7OCM5PipkPSBAS3GaVmqBJ0Ot8tcYSMjVAMspf2IwH10ISlgm8uf3BUfSjz1br7R2LFqBv5IyS18igXm6TVmfgiHMIMMESGsj70LSPtzxiRB8m5RDl/P5GYPNaqTz9QzNx12kyrJI3KAwV/YfjBvI25eRpyhWLwyZg6S6OerM6/eD5/nrMB5PxFZAtkGs8fHbX+mJpzTWZ0nt8VseU914V6FN7k5giNpExY8UY2OeJNWewe0d+JpdZHvsvjeyJFAN7Rmv5CXrCjRjEkkG5tsBn/6s5sXw2LrN0402vNfeUdpFv+uDt0NloDI7jQpPj0JNB1CgbLmu9XJVlrsvFX+E54YerZCZ6Z60u++i/q7nsR6mgb8LWYuQYArPrk5CbK6AiG8OQ/wGhYSBHbd+Ql8SOoOZzsvtnXf72mO3NvLxM+jHNUri/Jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(1800799006)(186006)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(26005)(1076003)(41300700001)(8936002)(336012)(70206006)(70586007)(316002)(8676002)(36860700001)(2616005)(47076005)(83380400001)(426003)(6666004)(81166007)(40460700003)(478600001)(40480700001)(110136005)(54906003)(44832011)(4744005)(36756003)(86362001)(4326008)(82740400003)(356005)(5660300002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 17:15:13.7440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4eb0b3-5a1a-498c-7a16-08db9cea05e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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


 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml | 2 +-
 drivers/pci/controller/pcie-xilinx-nwl.c                 | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.17.1

