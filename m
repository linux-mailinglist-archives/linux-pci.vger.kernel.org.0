Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B56970958C
	for <lists+linux-pci@lfdr.de>; Fri, 19 May 2023 13:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjESK7v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 May 2023 06:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjESK7u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 May 2023 06:59:50 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEE8113;
        Fri, 19 May 2023 03:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuF2ocjn0b/gNTw6pi+RH2w+NXrHzKYbSWijbpeKLOvVYn7aisSDErhTdndfDQMiUmueU2P4ZFbzocbiqGPLR6IsoRwu20n5R8HsTN6IVTM5eiuEMfvRkdMqYEAcijQte7Nyl71sLLa1C4UiwECnDllHpqW9JeERJP2o/rq3orJ17NyaqanP+JvmM6ULOUBqVcz2OKpN0VaMBMEdK+Sou4drQCkyp/SY+8T09Nt3VynssBz8AAjUolp7s+FpWnOBvaYZ2IQeU04lJb+4/Ewpyn+5d6+YnB/TPjfZQZ28uEqv48Ff3WvG57q3XBEjmVOsLAqHdmuSIu/0v6lwYPJtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZmicaCvfQOrReh28SooQJoroCwMOl2g2iv2NvidjWs=;
 b=l3YNLuFOCGfNkttTVxN1VmLrtk15Fg/i4O/hHNGazPXJ+/IITRUo8gS8h87RijvZhw3bRl26qZh3ooL6UOVC18pXv8bV5GQyiF4kPZ817fhKer9kDablWMYXUVEIVGsDfPC2ZtgKlodWwPj6rUUEGyeyA/Dsn8+v58lEdxhkmm0hG3VS5Udjache/zwGEb6eVQIPUKCw5oiMvcMzA0/Z7OGAiKXSkQ10eiFZIGsF21/RrFqQ+xXyI8KuAaYOyAADQBjl61R5odpWcnnam4caDvjjLcr0TsQK0sKa2Lg8JFkwJK4+R7aTZk1izxnzhZOJqMTzAfYb7l1s7lWJEG+Wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZmicaCvfQOrReh28SooQJoroCwMOl2g2iv2NvidjWs=;
 b=3n+L/vrq+y5ZXA1VXEMu1PvbiqiwJWokj13TBCB41gaxpQUD68OiMjvP0KyIgjlwQUHsU89unjN8HmsVR9Bhjra33AwJyh0i/3HXWcpkVOCofkrqvIpyM6E4B1+gaD79biq04gO26S3iM9B7AT7fUDCINI+KdQGeN+evBQw0uoE=
Received: from DM6PR04CA0025.namprd04.prod.outlook.com (2603:10b6:5:334::30)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 10:59:46 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::56) by DM6PR04CA0025.outlook.office365.com
 (2603:10b6:5:334::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 10:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 10:59:46 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 05:59:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 03:59:45 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 19 May 2023 05:59:42 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <krzysztof.kozlowski@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <bhelgaas@google.com>
CC:     <lorenzo.pieralisi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <bharat.kumar.gogada@amd.com>, <michals@amd.com>,
        <nagaradhesh.yeleswarapu@amd.com>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Subject: [PATCH v3 0/3] Add support for Xilinx XDMA Soft IP as Root Port.
Date:   Fri, 19 May 2023 16:28:58 +0530
Message-ID: <20230519105901.2399452-1-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad5cf5f-39c0-447f-bbf3-08db585828a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+Ef8nytKT6Q2MhmLZ3TvWqRTOgjktXy0vpl5clEXxOSKNnSHx31VpJi4saqyoj0p30m7s8AJ1gXmSGNTFDv5rVNiLe2M6KtKnd1FCZzcNImgJYWwYISLbmHdXs6P3gW+8/uPMVK8hTgqzZUNjL/g22X0WW2Ny6A+x4kJY1skvamhLZ7wAn4/NX6CyQvLMMleOuxdT8n15K9/HNSj5FSObSGNBJjHawrdTCHRdZgv7I0zxB++K1Rlc0dPaxWQyc9zQEW/XXLfYPZ7BqmcrvtsvZ0Eb23ckrv9H+2Et/M/Wjc5YqqqSJcHYKE2yYDd4/uz/bbhZDLarqHG4cAzceWxmjcXbRijO+Am3AzUXNE4W+qRZp+jQxmtpMybW/JeGW8MTD2INELNRnkPPyyY/12CjbBU9dW/j16ZszExaUqNdzr25/ONbMDgWz/dSH56MxDu453IhhtXc9GlJNdhmQgYiIEHeMdNgxYs7Czp3StlmKImZP5RnfHNs2uvHMTIg7ePoaTWuoa/+pnLBe9uUgg44AT5hVQxNzXAY0GZIfsJZpFaTZuC2JLtZKJFLpP3TzFiMBvYvrAod8IwCNnFBHdp6xWKLWumieTiKvkB18bZpkd4LoBaBXC1u5mzfWOK5yf62dUDFCT2VXbPsHE8ab/xIxeTftOI/3NwkfgjjIMwOnQT55d8k9AM1ocKs2MHrna7IS6RbipjqVbhATmYmfT00jozDqxGhYHaVnGsGr1+FeZAV5Rle1o9Zo83AVOUSAl6MefgHUiQzL7mVQxU49cKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(6666004)(40460700003)(70586007)(82740400003)(54906003)(110136005)(44832011)(2906002)(5660300002)(86362001)(41300700001)(36756003)(356005)(316002)(81166007)(82310400005)(4326008)(8676002)(8936002)(70206006)(40480700001)(478600001)(336012)(426003)(36860700001)(83380400001)(2616005)(186003)(47076005)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 10:59:46.4330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad5cf5f-39c0-447f-bbf3-08db585828a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patch add support for Xilinx XDMA Soft IP as Root Port.

The Xilinx XDMA Soft IP support's 32 bit and 64bit BAR's.
As Root Port it supports MSI and legacy interrupts.

For code reusability existing CPM4 error interrupt bits are moved to
common header.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
---
Thippeswamy Havalige (3):
  Move and rename error interrupt bits to a common header.
  dt-bindings: PCI: xilinx-xdma: Add YAML schemas for Xilinx XDMA PCIe
    Root Port Bridge
  PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver

 .../bindings/pci/xlnx,xdma-host.yaml          | 114 +++
 drivers/pci/controller/Kconfig                |  11 +
 drivers/pci/controller/Makefile               |   1 +
 drivers/pci/controller/pcie-xilinx-common.h   |  31 +
 drivers/pci/controller/pcie-xilinx-cpm.c      |  38 +-
 drivers/pci/controller/pcie-xilinx-dma-pl.c   | 795 ++++++++++++++++++
 6 files changed, 959 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,xdma-host.yaml
 create mode 100644 drivers/pci/controller/pcie-xilinx-common.h
 create mode 100644 drivers/pci/controller/pcie-xilinx-dma-pl.c

-- 
2.25.1

