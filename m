Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8C68EDB3
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 12:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjBHLTY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 06:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjBHLS4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 06:18:56 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147784A1C2;
        Wed,  8 Feb 2023 03:18:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnE0AbJms1WLI/nb/yoGs5ZE9M0pHQKQ2QlVPsJgCLhkzw2xzLR6SloHQt0rXFngGtXSbQwsYtFyPFeDBHuf3Eas0f+yku4ZzgaGjtsA82RUlhZZxwZRkWJPa3XKLXGsHEgBHnexh0nAaidPBZarXe4AhXSiTc1GxXlzpqr/xapckirpQXzkPUVVdRjovqe5dT/DOMBTPE+eL4kCzM+n5or3OoXyhDTutvRxtwLLhW3/59yEKmwvFaY5l/A8WV/5Nhb7pLr6ynM5rdS+9W8IFq7wqhEBmdDyGqk+fXe2vAiQfBvFbJLHkUckac2kwBGBZiv6TR32m9WcCtDXnUdIGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfaXVI76TXahnRnVbHUBRzNlZIyydKFs9cl3KNIylYU=;
 b=RrKu5JKfI3SaJdyjDjQFg12sZcfJt6XPkUzsvRn5DCHmu3WBb3gFIkbHznq6ds6us3tlcFhMsckrs+g48WZ5sa3rTLPWWmUXgmwx8ETUrB9vKN71qbB/cymZs7oOLHFbI6sXw73DN9Vz59/5z1LHOtnmBDDs0UNmCNvOSrJAZcpibGEm9WpHKzGmmpbjy923Xki/fgHfSwZ7X2exH2wK0WKPydNcy/5YfiHO9AEsZsVqHNVoUDnaKtJg2gHxSk/JOjaXg5NHB2QdzAc1sXmteWjvK3wGdn6iaIFKeaX1IV49l3oY31+hTQ0iBILesGvnjOwFL34rYnF7SLGO/+/V1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfaXVI76TXahnRnVbHUBRzNlZIyydKFs9cl3KNIylYU=;
 b=cd5Q8vmWhB8c7c1s4vWJR2/AadTb7cu+36V67WBQI22PC7MN2KdjQWsRJMeQsIJ+JQfQ191VVuOHA1CNk4quOXJiOX3yiBGV0np9LRpQlh210GXsKUIC+W77mql8adMAAIsDVrYsykF18aVmz4elhXadn4g5lBApOdF/GP7SI7BJ6vNN450XCSDA8aAwlnicWr75E+TAPInQJ6w+aIG7uig7dpcYshCoCZK9WIaG8/cXw896Luf7h2DiMNDOPh3bTNEvUySpDaG9Q1TnWcVWqBhrejb+zRYcgLqug7ecfCyuiKgJX4k1oU04SHQb4eNoOuLmsKID/jrO5y8aSIoytg==
Received: from BN1PR10CA0027.namprd10.prod.outlook.com (2603:10b6:408:e0::32)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 11:17:30 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::62) by BN1PR10CA0027.outlook.office365.com
 (2603:10b6:408:e0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Wed, 8 Feb 2023 11:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 11:17:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 03:17:15 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 03:17:15 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 8 Feb 2023 03:17:08 -0800
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <petlozup@nvidia.com>, <rafael.j.wysocki@intel.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>,
        <jeffy.chen@rock-chips.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <jonathanh@nvidia.com>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <gregkh@linuxfoundation.org>, <steven.price@arm.com>,
        <kw@linux.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <vidyas@nvidia.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [RFC,v14 1/5] dt-bindings: PCI: Add definition of PCIe WAKE# irq and PCI irq
Date:   Wed, 8 Feb 2023 16:46:41 +0530
Message-ID: <20230208111645.3863534-2-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 0021138e-f15f-4e10-dbbc-08db09c6112b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDqWAlE9uGeN/HJnROXHSSmOsDMZ4yDYCF4T4HKouTPoIXXBo4rKX4GUDove2rT0teBfsDLCCDJPeDXJu09XBU+detL3q4/DMEi71/rmN1PsOj/BS5FlipL7XiDEaQLtr+x+cKlDaIVA3I89oWS7hy98vQ1UzW76j0vgJJJL0NxGJvL1BtkJr0+5QFzC5IvmxpT0Hv/qwkqZuZt56jr78/lFsc90TqeLmFjSjaObsCqQuoqV4vBiW73F6dlHfffK0+HIsuYivwfsFiMDtdEHKaJq11UKL5ggC4kwC/ps9anYuPbwNVZBw9McXSksNyBNQvlLCO0AOLxQXh0XiOZOseTdky7cYD7ifQMQ/K8Ts2kEXtBajoOzq54ys/B0Ukt40zcZ6XqpeSHkk84UyqmqkSpIQ767/RlMl5OLYJzyjcCodjkcM4G4AVlqNm7C+e1bky93pURQ+P3O4PwsrXu3TohA1ohlDDbhpFLecbARNX11Id5iNwIDmVTo5TUZBqx2M/4l2OvufHRoOq/i0cnzFECUrU1eZlcqVwifh8rWnO0VisO1CXqTcgLM7fEl/BpFJ7UIRupxrt/l5gPrZJeQoJLIeymUM8XcR4QjB8rdi7cF9OUAeIdMJw8r/6sBT7RklgzME/yGbkm2s12nXAevm1kvjHE2WudkaQDR8TqaihIvsnFcAj8QBR7bpSDHStNyUqb3kemlSBBkrleEAL5Lqw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(83380400001)(426003)(36756003)(86362001)(2906002)(8936002)(7416002)(5660300002)(4326008)(70206006)(40480700001)(8676002)(70586007)(41300700001)(356005)(7636003)(316002)(82740400003)(36860700001)(110136005)(54906003)(47076005)(6666004)(107886003)(40460700003)(7696005)(336012)(2616005)(1076003)(478600001)(26005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 11:17:29.7287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0021138e-f15f-4e10-dbbc-08db09c6112b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jeffy Chen <jeffy.chen@rock-chips.com>

Add device tree support to pass PCIe WAKE# pin information to PCI core
driver. To support PCIe WAKE# and PCI irqs, add definition of the optional
properties "interrupts" and "interrupt-names". These properties should be
defined by the PCIe port to which wake capable Endpoint is connected,
so the definition is added under "PCI-PCI Bridge properties" section.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v14:
Move the device tree properties definition to "PCI-PCI Bridge properties"
section and also update commit message.

Changes in v13: None
Changes in v12:
Only add irq definitions for PCI devices and rewrite the commit message.

Changes in v11: None
Changes in v10: None
Changes in v9:
Add section for PCI devices and rewrite the commit message.

Changes in v8:
Add optional "pci", and rewrite commit message.

Changes in v7: None
Changes in v6: None
Changes in v5:
Move to pci.txt

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/pci/pci.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
index 6a8f2874a24d..53bd559a7305 100644
--- a/Documentation/devicetree/bindings/pci/pci.txt
+++ b/Documentation/devicetree/bindings/pci/pci.txt
@@ -71,6 +71,14 @@ Optional properties:
    trusted with relaxed DMA protection, as users could easily attach
    malicious devices to this port.
 
+- interrupts: Interrupt specifier for each name in interrupt-names.
+- interrupt-names:
+    May contain "wakeup" for PCIe WAKE# interrupt and "pci" for PCI interrupt.
+    The PCI devices may optionally include an 'interrupts' property that
+    represents the legacy PCI interrupt. And when we try to specify the PCIe
+    WAKE# pin, a corresponding 'interrupt-names' property is required to
+    distinguish them.
+
 Example:
 
 pcie@10000000 {
-- 
2.25.1

