Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F26628213
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 15:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiKNOKD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 09:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbiKNOKC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 09:10:02 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1552824948;
        Mon, 14 Nov 2022 06:10:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A726soQOH0Pyo2ydWfBnDO033rShP16iIULanWjy2pZPF7mwDGFnFAzI0KSgjkg7w8U8g6fZ5uMUGF1XCbr2BwIJVhT/BSlZejqMODWItp+mdbrJPdsn0reTSPl69XEq13BkyOO6has1Wmf9SliRdhw4XORbuhDd8h/IFgaKx3x7qk/a18/ifwbjscVVFEwfVOKOnk5oH2vzlZHrDZtoDl96UJSQ5d31SaIyMhtzh6G2Ndqj/gwFpG5Rn9VE8yA7uyw20XfQHSz5cmlJb0P+1yp9IDZDK2XZMz03WQluGPRWqgBtVUilX/c6Rz3QfnJwIFvvThHtlxNp1uUzMLYlOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTs0bAfnzwEZntQVTAXiQaWSWDu5J8SA/OapT3IVPGc=;
 b=KO5MJpsuGELWyjb+5K8MfneRukCVfwO/PflAne6Ty5ebvV8H9wcmQYWlRpPTSjBa32TO3ObvNoHRDSn9AdMfmJQ/eubQzRgavoWU5MrSbMS2N5CuzRIzeCIeWlP63UgWDSORoUNKg7mkOYMrMVXCNt9GPA3jJ5fj+p18gbXGWxXeCmbdGr5160NWbKNW6Vo6yZHMWfAP94N6bw0S8sN3rEDP3MhlaQNOgTfJN5xIPuyMXIFlB5RiZXX43vQSn2yjBeTCK+XPPJlGmM0OCjqbMcibQm9TSXBrCI9WC6JoqcPLilRiKFGoXFGLKDp8uri0hAXMaBRmRLNUSz+sKeiNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTs0bAfnzwEZntQVTAXiQaWSWDu5J8SA/OapT3IVPGc=;
 b=N7vrpbYHKKCst7TzAw/O4NxsUJ7ISCl1ON2a8E4FhOSJAr/CmVv3N5ZEXsUmRXwWgba1xJ9phsRlB6aYciBzJlQysYEhg4VM3PLREuN1IEhtb2bztO9VmlfhLsb1lcaEs8q4f9n5+Qb8RGk8dyAfKe2bCl6eyaHkKUo61uHANK+b9JFCyKUupz92ld/Bw4CmdvUGhTYRHrA/zH5z3jVlXM/KcZNziX5enCVTCOHKioOPA5gFhDXgnmAba1b36ywhqnTICe3soeKElY+IPZvufAVSTdAlbm2rwoEYJHt5JOtMVRlud9bPLMKTTo+2J6Yz8thf/tFgfUa9KLvp3gXVLA==
Received: from DM5PR07CA0102.namprd07.prod.outlook.com (2603:10b6:4:ae::31) by
 MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 14:09:58 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::4a) by DM5PR07CA0102.outlook.office365.com
 (2603:10b6:4:ae::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 14:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 14:09:58 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 06:09:56 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 14 Nov 2022 06:09:56 -0800
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Mon, 14 Nov 2022 06:09:54 -0800
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <vidyas@nvidia.com>,
        <mmaddireddy@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 2/2] arm64: tegra: Add ECAM aperture info for all the PCIe controllers
Date:   Mon, 14 Nov 2022 14:09:16 +0000
Message-ID: <20221114140916.200395-3-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221114140916.200395-1-jonathanh@nvidia.com>
References: <20221114140916.200395-1-jonathanh@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 945f443d-5c49-40ff-b6f6-08dac649e9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fJ2k9Ky49zWkGlo7U77+W8O1i8R/OnGZRULxKQB+ivnbunlaKqp+Omg6aZZRlXPbnghs8Sus2MO5vqOPIjYLDIivovyKaPZq/H02ebAnOpDzq2T4rUGxUsQmIknXG3mHcEV5qWutmRk/fIDx3eH3/ta7Qel0V5k3PfE+x1e2DPVtBtHwPbF1qD5oEwadlNZzSMdOaDNuSP3sKLS21ybzYcXWJyhqzetbnLWG8E77nwyIATnk8jb1YdPDN//eiCjqnDRrXIhVizjDGrp9EX8qAHNXTQVaANFQw8tWotrCn9zOcVbz76aRi1LVu3MP9pw9mgKxk2irDesg/CiWoL7TjrOXnYshjHnqmex5GAKx2TtfYozMGMB6PJ1YdY/E5YGHBsRpxQMdRhVub2ukBex3yHIvFUT9sPV8KzIknO3wLGZfclzjPC6wWfJnIOI2NfF80v3FnKHsnxemLmwMj2ZyvbZC0f21u1MtjEBZtJ8lJBULMgE7/JFebavni5zUpXQYkEGtoq9qO7XLYvtKQzSzUSq+WKb8Y0oTYaUKt9MsII/UETCF0Fn2DbLQ3By8kR3mXXxm43eR3P2cttPJIWEayQA4uHKfRzO6YaKBTcCgEBlWvjWEkk3VutEBuBlotERMVJVCTfugd1HsfSAG/Lm9P1psZ0ruZf7Taar65cV25QsNk8ruxvGhaHEpcyLi5cw1kSi61qoQ8hRq3WGIXIiBneulZ2oTkyvXguWKHRdZKDDYZ3nZv4lzVRI1m78+Jzg1vXPzuqEhj74tRyWxRAQ6nw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(5660300002)(86362001)(40460700003)(8936002)(41300700001)(426003)(47076005)(336012)(186003)(2616005)(1076003)(83380400001)(107886003)(6666004)(7696005)(26005)(82740400003)(478600001)(82310400005)(8676002)(4326008)(70206006)(40480700001)(356005)(7636003)(36860700001)(316002)(54906003)(110136005)(70586007)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 14:09:58.5243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945f443d-5c49-40ff-b6f6-08dac649e9f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600
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

