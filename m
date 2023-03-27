Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB636CAA40
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 18:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjC0QQj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 12:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjC0QQe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 12:16:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F875BAD;
        Mon, 27 Mar 2023 09:16:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMXyUav1xBnAc2SOZcxDsGsyPzhIesznSQkqSdZmFDMw55DHLMtTerHjZhmWhLpfcUm1mf74m/8XW2ioD93wL7e3hE0BQeQA7Qh3G4VwG3TFyGPpuYDdC19tsnf45yL8uuHV9RzXHzfMo4EzBDP0PBNPr6ZKun5BJBKRCGOwZbROeVeUA+Qio4MrhpDGed/1cVlPUFSAf3RFidkWW3uCcAdbB8TWOjbSoOd+r2uV2pYPR1UUxgZCtVgrBaPmUmApBOv1t9h7RKRsZOR3F3HeTEfo3emH3Zh76hmyxnQ7nWLvxybf3uJu+EzQZh5fL57yOfJ9smfzQg3CXrK50pPqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EOLSj2IMC6AmgQP+x8WnAbrOd38Fq0L406q4vninRQ=;
 b=kwQMxOD6O6Y7ki+2pdcvuHL2HjTysYWF3GcgcCaVGVQS9Hko9a0eBQk5vEsTtNnkn/cCBERS3gBYonassZoQ1TJg/dRVkfTftiFvlOGem6krfxmB2sV6hrrKLwtzmsrXhccgIzUkDYnuISS2NB1TLyHlNLjO0cizitiQp2JhjqaP0miRWN2ufhyF9nE44ZK3Y/yfnNJ+iPbKNRUMp5OZL+D/umrqiEzYdi5bNcZK7Yrk0AqwsIFrpi95tiqhgxVK0/OM5Nczc/LAFP5K2EH6eJ59QKT9h38KxqeLqsL3c/03yqNBtfTB3cXQG8c4OEnsV+cdE+dIIQPBTMiYuUhJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EOLSj2IMC6AmgQP+x8WnAbrOd38Fq0L406q4vninRQ=;
 b=B9Y0hLsTZLtrtCc8dYnrW6c75kLlC0fQpk1I9pPMCjOTxz7FZim3NOpt5ugAmMMioHulpRGTF/F+WzuAfmEjhrv0EVwSKXzQEqGdv3q4Ujkuvp4/k6pmI/Pbr4OACc/eIHe+y9PDnZY6HV3z3EJONIADzXGVXrsNjyr+IfoVvYeV7Y3gJlaWTfwbXxJ+z7527FzDyco043SKwSDGWJWB4cZ49Of7drg2H6ALUTiZo+i++Cr3SXqvhHnqhp9/Tw23o1f7/1JmpKazg8jCZYydYw6cM8YgF3hB5IP9S4seQTnFLv9EsgJS8EuqTaKvytd39/lXo9hAHR1X+l8tQ8+dig==
Received: from CY5P221CA0129.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::14)
 by CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 16:16:08 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:1f:cafe::dc) by CY5P221CA0129.outlook.office365.com
 (2603:10b6:930:1f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 16:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 16:16:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 09:16:01 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Mar 2023 09:16:01 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Mar 2023 09:15:56 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <mmaddireddy@nvidia.com>,
        <kw@linux.com>, <bhelgaas@google.com>, <vidyas@nvidia.com>,
        <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <ishah@nvidia.com>,
        <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch v4 06/10] dt-bindings: tegra: add icc ids for dummy MC clients
Date:   Mon, 27 Mar 2023 21:44:22 +0530
Message-ID: <20230327161426.32639-7-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230327161426.32639-1-sumitg@nvidia.com>
References: <20230327161426.32639-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|CH0PR12MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: a78fae38-a8c5-43c4-4f98-08db2ede92eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOMoIdQLj18BjcEL/6IGAM2etvuaBlCeyezlGXvpJUS3qLbfPb8Wujn+lwS7fS+9bLsvE/Tk5a8gQ6tpfaQiu1r5SWLbmsnKeO57RYHlA4nXR7vy01mA0Y/AhIDmiHlhMvh9bmWnRyZwIUV8pZ4dTj9eh/LoGOgM+wVUhWx81mniIDGsJkh/O8+FhXIPYbKxTblNfkxg8pZw60YHn3hV6v0gWOBLHaOiEQgUA7J5wrwiII4OH39SQg5RI98gEwJd+/u6Gxsu0Q14nOGa3G6luZngPkQQftvGN+5TbgUMPkQcJ5Vt6gfG42ngh+vPC6XzDfhoTLhtAHQBUDWmlH4c2ltpuBMMyN2d2Cfd3pJXNzzpIbK4dsFke65sLLLpq9SZIK/tW55UjGdzBMcKofhkXsp3V8BM3+VAr4krlsYuursEpXdUFcvucWL/BUGYP+iXPFgjGZ2deozNqRSPwhN3Vsb0Fm5D2nOjoKAE9yGnk8Mdch9/LwQKrlf49Gi7L3sPwkN7Jqb4V3IRsqzZkfg5PHViboJyLPRA8FwzH9eQDeGmdw2zAcb191UxbtljoD29h78/BYkObVP0+l7sGjyxlHIRvUIluPqMcskqpyel+lBE3vsgXiVy3dHwr3h9JPQdB5+I0fNtbd1kv7tZGuz20NjpPrKbZHNbyXTKrI9287iDamhV85haulDm68IxTPt5tdof83BLwLRxwEEVtMZMTGAgRed2J5l9ndFh1ssVYUh05HG0QdpNof//RZ0stqeP
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(316002)(110136005)(40460700003)(36860700001)(54906003)(478600001)(356005)(7636003)(82740400003)(8936002)(5660300002)(36756003)(82310400005)(86362001)(4744005)(7416002)(2906002)(4326008)(8676002)(70206006)(70586007)(41300700001)(40480700001)(107886003)(6666004)(186003)(1076003)(26005)(426003)(2616005)(336012)(47076005)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 16:16:08.4476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a78fae38-a8c5-43c4-4f98-08db2ede92eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5266
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add ICC id's for dummy software clients representing CCPLEX clusters.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/memory/tegra234-mc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bindings/memory/tegra234-mc.h
index 347e55e89a2a..6e60d55491b3 100644
--- a/include/dt-bindings/memory/tegra234-mc.h
+++ b/include/dt-bindings/memory/tegra234-mc.h
@@ -536,4 +536,9 @@
 #define TEGRA234_MEMORY_CLIENT_NVJPG1SRD 0x123
 #define TEGRA234_MEMORY_CLIENT_NVJPG1SWR 0x124
 
+/* ICC ID's for dummy MC clients used to represent CPU Clusters */
+#define TEGRA_ICC_MC_CPU_CLUSTER0       1003
+#define TEGRA_ICC_MC_CPU_CLUSTER1       1004
+#define TEGRA_ICC_MC_CPU_CLUSTER2       1005
+
 #endif
-- 
2.17.1

