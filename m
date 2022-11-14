Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7C862846F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 16:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiKNPyN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 10:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbiKNPyL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 10:54:11 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5072E9F1;
        Mon, 14 Nov 2022 07:54:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6SYWen3icZZQq+q5aR2hpK8UWCzKEeCzPSVNXmqm14LMfK7SgYuq23q7Lm03vGQg0sITbRhJHt34MxeJZhLrM1uqWw3VCkSLmrn5UwyaH/BiFEWvOYIvrKenoGL5qQdg8mtWX8yyWbu8VCxhMZJXiTsfDWBDibU8MGHAtbvgWX7ThWZDsjPE26WTWByK8yv2m+R7cZ9oSVQNEB2tp4dgXUAW/ywiW5km8NxGfCkubtgM/Dhni8ZAEmbcmcFCD4XInqprhV1BqUHXZjlPjqraLDbGevdjTRXPJ28nAnc7ZxZfXj9Hh7DP7bMmHYZMH+dmYBThFb7W/b9Tu251XIRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at8nVNeSBehtwHReWKUQmBvADwEDthY0tdztznSvF+k=;
 b=Jj9woRUPUJSnkzd3S3IHjEsBrz479R+MWuHqnYmHSeHGv0wQi/ifzA8jm4E/NFjSqQbJr6bHW7eAlccspFJPmmWolaYRMRJ0ZFWD10SKTvnuYf1NeypVnJbQCDsfLZ2bwwdoeMavwQ5X/KPqFdwXa+QPwvgY31o49LrJ5BONbVLsnnFoJNskjG0t9gwAOdgFM+svjDTFw/dRytzky6TLdv7IVzoH59h1zwLukHAGwrSEM2hO3vFw5cf2BGaUF+9XZiKuHnzN+pPzd0Yt1nCg6keoDm2WawqyCt9NXeDOIVQxCC087bOo2M6xL+qXuqK6Q9WYTIc0Yq7N0UzpZsLRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at8nVNeSBehtwHReWKUQmBvADwEDthY0tdztznSvF+k=;
 b=Iu+WnuSnthyGwtHNy0cdXMAlFE3+aRqpsUJIxZDy2iyIS6yr+EUrnlOfu8E8aQigQg1U0n+SLCGfE5UXgnhZHeDJSnH+yIkml749F+yhDF13dEtFJ8HRnbNSc31dUeKo4bHhblY4Ec1lQN7aC+13bSUjCfwovUjWiBlw/HLhs66uiCfinxkJj6UAWyhPqKsJpwOYW0xajW79ZMR27/LsA63Ds9v2sy2/cAe+6D4b94MjphM8CUGsztYcMKzMHLXUX2xTJJwwaAgKD2TWn0El3AO6uFznEG9fQ7Sdv/I9EraFS/LU1CW6We1jBWVpunBSxwA52jHyqRpS7uv0CqBlHw==
Received: from DM6PR04CA0016.namprd04.prod.outlook.com (2603:10b6:5:334::21)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Mon, 14 Nov
 2022 15:54:05 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::de) by DM6PR04CA0016.outlook.office365.com
 (2603:10b6:5:334::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 15:54:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 15:54:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 07:53:52 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 07:53:51 -0800
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 07:53:49 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <vidyas@nvidia.com>,
        <mmaddireddy@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 2/2] arm64: tegra: Add ECAM aperture info for all the PCIe controllers
Date:   Mon, 14 Nov 2022 15:53:33 +0000
Message-ID: <20221114155333.234496-3-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221114155333.234496-1-jonathanh@nvidia.com>
References: <20221114155333.234496-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2a147b-652c-44aa-046c-08dac6587546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WF3pt8euxqtctLuflsx5yejszGTtV+5wIgsz5ODpVDQiodUlFJqpZqS6vJBC7iYTlDyE/onoDIVRnnU8e4N5TW5veDmCTMo9iLlG0137VuyQXjI7DbZJIba7282p2+p/+DCPsr93PBIjReUsHtvT3fKOd+X6RCTJcLbFpF4cY7w7zCjWOMOB+HO2SweCMKhrzxqyyYu0Zbk1RMUwzRRXuiQhmGkpBrZsqRlPItGk2RRXRXn1iMMOmN0UvodG+iDCiz2VMZN0EUu3DKcrdY8jaHD8xiOv5zbPvfUeHK1WFVek7Jg0jFzUnHiY4lGZt8nmK3sKdy6SkoYrjT9LTM2GuKIVPiZgjxQMMF0OpkrFM/9EqjwbcrYNzU75UbJDnohjnKi2U6AKRAmdLrmvUZfoEv3ep5oe/0ITECDo8/7O8daP3BznVZpNynapwr+P/tYXz6NFKe4baeST0iUrVCa4X3JWnwOmOKV7eMfRqDSSfWmAHkqdA/2d8RenQ8S4DInU6ONKBc8FqY5Fk3QOHqUnSIbwJWOBfb4j87b+8g5BxJJhUH1uq+P1eaRIffbSYkOQ9BtsIIPTeLeJaeqEO/jRRjixjHgN5MZp4ka453wRqyCZmiV2NFbbSQTiHjLS0tSboWp3fWVB5J/bcbQeQ/QougqVDS7vScpG8LhUIhLIiGAVSfem5WJzku/Ne+uWRTaQPuWFkmxDF/0iZWYo/11fbu9Ec5R3yGgHe0faRXwwdcFu5wAuwixQNxJ7bt5Sqr2gmAB5kFYsbbvMAMl9LM29dg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(8936002)(5660300002)(2616005)(41300700001)(36860700001)(7636003)(40460700003)(82740400003)(82310400005)(47076005)(356005)(36756003)(2906002)(426003)(336012)(86362001)(186003)(40480700001)(1076003)(83380400001)(107886003)(6666004)(110136005)(70586007)(8676002)(4326008)(316002)(70206006)(26005)(7696005)(478600001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 15:54:05.1884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2a147b-652c-44aa-046c-08dac6587546
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Vidya Sagar <vidyas@nvidia.com>

Add the ECAM aperture information for all the PCIe controllers of
Tegra234.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
Changes since V2:
- None
Changes since V1:
- None

 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 55 ++++++++++++++----------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index ed7676c9521b..37afe1e03700 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -2235,8 +2235,9 @@ pcie@140a0000 {
 		reg = <0x00 0x140a0000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x2a000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x2a040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x2a080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x2a080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x35 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2288,8 +2289,9 @@ pcie@140c0000 {
 		reg = <0x00 0x140c0000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x2c000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x2c040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x2c080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x2c080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x38 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2341,8 +2343,9 @@ pcie@140e0000 {
 		reg = <0x00 0x140e0000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x2e000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x2e040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x2e080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x2e080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x3b 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2394,8 +2397,9 @@ pcie@14100000 {
 		reg = <0x00 0x14100000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x30000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x30040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x30080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x30080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x20 0xb0000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2447,8 +2451,9 @@ pcie@14120000 {
 		reg = <0x00 0x14120000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x32000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x32040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x32080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x32080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x20 0xf0000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2500,8 +2505,9 @@ pcie@14140000 {
 		reg = <0x00 0x14140000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x34000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x34040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x34080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x34080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x21 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2553,8 +2559,9 @@ pcie@14160000 {
 		reg = <0x00 0x14160000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x36000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x36040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x36080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x36080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x24 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2606,8 +2613,9 @@ pcie@14180000 {
 		reg = <0x00 0x14180000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x38000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x38040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x38080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x38080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x27 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2659,8 +2667,9 @@ pcie@141a0000 {
 		reg = <0x00 0x141a0000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x3a000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x3a040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x3a080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x3a080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x2b 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2712,8 +2721,9 @@ pcie@141c0000 {
 		reg = <0x00 0x141c0000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x3c000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x3c040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x3c080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x3c080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x2e 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
@@ -2765,8 +2775,9 @@ pcie@141e0000 {
 		reg = <0x00 0x141e0000 0x0 0x00020000>, /* appl registers (128K)      */
 		      <0x00 0x3e000000 0x0 0x00040000>, /* configuration space (256K) */
 		      <0x00 0x3e040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
-		      <0x00 0x3e080000 0x0 0x00040000>; /* DBI reg space (256K)       */
-		reg-names = "appl", "config", "atu_dma", "dbi";
+		      <0x00 0x3e080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x32 0x30000000 0x0 0x10000000>; /* ECAM (256MB)               */
+		reg-names = "appl", "config", "atu_dma", "dbi", "ecam";
 
 		#address-cells = <3>;
 		#size-cells = <2>;
-- 
2.25.1

