Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F1B6CAA20
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 18:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjC0QO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 12:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjC0QOy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 12:14:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A682524B;
        Mon, 27 Mar 2023 09:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwwKRFJ3SxWIxBwjdYwghyrVGqN+/Njwgfh3pkuoI4XgJwh+deMdYMxdrRJshV1CtsetDqjDBGUQOq9YSASUkJoaCp51knnaE7aviq710dPDiTwI08lrK9RScFcztfxxweirLHlSqUuGzLX+XU/mChJV+onYuQ+594uZlYpTJsN+cHdCmWdTvgsnYKSPEx7bxKJkcZWsh8FjdBKUI4lQMEW5/Op/IouaXm/Cxx0gSZm00AT1mAJu1Uoe8GarRWLBWY9a7QHa0EV+2zm9K6sdxRGUtQNjtChnLz9y4AZIkeO00SQ1yB/UCxswgq1ZVpbYjg8GWMzpxmVow393PmZ/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kCK6BGvJPhQTmZQ3JOKLSN9nwtRh23WxH5PPHqq81Q=;
 b=foXcIB5tTn+9GdhPZtPHPDpYl1oS4be7iym1b/A50fBxPjk+HDeGRBL1YDeYmsZLCUri23v/DQWsNupD49T+30f5YcSBzUtFAfv9D8U/ZMOCD4mG+O6aWhp3IeWI671C35fRN/BC5gFeFunOwpgwSHUCbn9JZKTw/4T/EVkax9qiM4O6aVo9FCr4hQxFchw4BDzjVfL4IgVDVJMxjTnA9iu0U8qULAstWboDA2otmvP9Qp7fh2G1M6kw6VkFg6EILvKXDWkJ7htgET+On51npKbK9ghQZFUYAB8Fw+uxMxY3TNYk6iLh0pLGZXBwBhQyI1ctEL4iyYRfP26ioZPMrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kCK6BGvJPhQTmZQ3JOKLSN9nwtRh23WxH5PPHqq81Q=;
 b=f2FFYSz1wvqNo/+YqyBR+KDSOvotRLXv74Xzk/Oe95b4PJSKfajtWAG+/lgNbPxXl7I/vaRSHBL5Irdjfv490Qx9iWYV+h6naeR5bhKG0Oz4yIgP7UxkF+oyjnIdne9bYgkm7IgA0Rc6gBJ4jNDIEKel2zYUM+tgW2YGbF9WAwoWyj2Af7fanvdvq5dIvCwGeENkUEQReOSJqK9sMK6Wrkga4JcO5LgZBcnSw5OnIDBJv6Gg8jMV0D2HVh1YR0/rLUATtMtDtUm4/we8hpiBoKY1CJMaIl70wXPxhJONBZq9RV4LbO27Qnfc0hXu40oNNWF2HOR2XncuVDkSkwY9Ew==
Received: from CYZPR05CA0044.namprd05.prod.outlook.com (2603:10b6:930:a3::23)
 by MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 16:14:51 +0000
Received: from CY4PEPF0000C97D.namprd02.prod.outlook.com
 (2603:10b6:930:a3:cafe::f0) by CYZPR05CA0044.outlook.office365.com
 (2603:10b6:930:a3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.17 via Frontend
 Transport; Mon, 27 Mar 2023 16:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000C97D.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 16:14:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 09:14:46 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Mar 2023 09:14:46 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Mar 2023 09:14:41 -0700
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
Subject: [Patch v4 01/10] dt-bindings: memory: tegra: add bpmp ref in tegra234-mc node
Date:   Mon, 27 Mar 2023 21:44:17 +0530
Message-ID: <20230327161426.32639-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230327161426.32639-1-sumitg@nvidia.com>
References: <20230327161426.32639-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97D:EE_|MW4PR12MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: a032bbb1-b936-4fa6-f8db-08db2ede64b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDQnUqo0ZNzHZvVb7WzcOxv65X2Cn8v480GcVEQVJMcKIPW3+4cAFp583AF8/KUcg+RfERBzUQXleQk4njRGD55agpTqk2BjlmR22ePtKkG8+TwLhmVr27Z8xL+fHB2x7DMq/klICUAEeL3nuyowczHBHc/zs8+ufmVe2Hqc3IehvdQO3VSKuQuZzP/autODDqinsZabav51Fnj1zsaQqK5LH1xDZHuFPgLC2BgT+TQvfTyHR9Iomz3V5Fmym7C52CJlRuWqSMNM3tr4TSERG5Bz77K86em75vQo9cvZn3BoBBIKzrqUo17gGdDdc1d9EqzCgAvpPJMLp3ZY7kB93cJCyBoFrksAmql1ejzDXeOpKWzttDpFfKmMeTYw43/WCPlgAsRmkC5/MQRA9fTmwhyRe9IqTloTWEfQt8eO+imI5lnibnJK5W41JZV2tVbMgTayOHX/MhR3mPdAl/gmxEcyB+1zsxSzaGnTGVvrP6dHFZ5IZuw3Nhcg0p77X+iqDM8H6zvdn/sYA71hjYSbMImRDt2ki4bN6YaypGne+3pogMeCCBzoUy9M/LtbfMFD1GThAAijx1jiFiBAW22SB2vNlIvTG9nx3hOsmnLWfJrfatKBwCRaOwmUntXNG+0oqDwTXE9ki52UT2Wj0EHnnZ7DVhmdM8MV23l2IVcbu13MdEEV/DCQrYdW0koKj3PhDoAguGOnDIKsuJDTruGt+QR/68S/+P/kJxs8L8Ly/ru4ouXkXtcmG7dk2n2j3LQr
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(316002)(110136005)(40460700003)(36860700001)(54906003)(478600001)(356005)(7636003)(82740400003)(8936002)(5660300002)(36756003)(82310400005)(86362001)(7416002)(2906002)(4326008)(8676002)(70206006)(70586007)(41300700001)(40480700001)(107886003)(6666004)(186003)(1076003)(26005)(426003)(2616005)(336012)(47076005)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 16:14:50.9252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a032bbb1-b936-4fa6-f8db-08db2ede64b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For Tegra234, add the "nvidia,bpmp" property within the Memory
Controller (MC) node to reference BPMP node. This is needed in
the MC driver to pass the client info to the BPMP-FW when memory
interconnect support is available.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../bindings/memory-controllers/nvidia,tegra186-mc.yaml    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
index 935d63d181d9..398d27bb2373 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
@@ -58,6 +58,10 @@ properties:
   "#interconnect-cells":
     const: 1
 
+  nvidia,bpmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle of the node representing the BPMP
+
 patternProperties:
   "^external-memory-controller@[0-9a-f]+$":
     description:
@@ -220,6 +224,9 @@ allOf:
             - const: ch14
             - const: ch15
 
+        nvidia,bpmp:
+          description: phandle of the node representing the BPMP
+
 additionalProperties: false
 
 required:
-- 
2.17.1

