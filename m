Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB1D68EDB7
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 12:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjBHLT0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 06:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjBHLTE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 06:19:04 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE5647096;
        Wed,  8 Feb 2023 03:18:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVghLZk8wI37w0GD7mVSYFiB2natt1NgRKYqKYabnAyrbkDdYHSc0xVszc71vWPTkWSag3panalKUOEbvUU33Qqut7fw8REyZehfcATgulWvgTWDRaslZKQm5MgUcxy9i7TOimwC1pIZ3l3k3JtMy2f2CA3wxxj6KCYVtKgk2KaFt5kpFBCReMBTGePgEk94cZBkjX3AHP86J01kTPQ1BpWlp2hRfoHpDUDJVV1YB/9/bMIgOPhFYz4pfYP4SYE/FJlE/hHNoJYH8fi8wtbDvxcPSvHRLhc0cV1ejjKHV57KaVpTKOaJfGHouohuGtaFcfck+MyFP1TXcBjyAZbzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9TQPOQEHQ870a4qRyfXdcpDFIIS3KkVr+i6XqXCLro=;
 b=UAoRVsJgz2GV/BlvkIMFXTh7mcR+Cs6r70sI3Unn+5RN0YrcYgojvGrjoL7zEikG2kRGd8Di64Lr6bxFmdMQKqhgoxi32RXvZRwfGWwUzVvI5VGNNnaXSf0YP1qLUeLYSGQBGl8syGpf/SBeKuKduH9TwcvDep4k9crYGNyXvI/A4yl8jbUIWCmTvUyI1ujQ+W76VkZ/FOz5rA6Q2y+9h+WAioswCzlez2CJR0YICHX1Gf7ooRiC7i9WgtralEVKoFqo5cE7J41QYPP0GBuJVLCUZEw8WFj2ncTJUGjtEC27M5335IZWHabX//No0rFVr5v8uAacMLbLFIjdX+zJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9TQPOQEHQ870a4qRyfXdcpDFIIS3KkVr+i6XqXCLro=;
 b=HAWciG5B/e6SffkyBKSbseCgnLP4HACco0ZTvOnxMDIngMeXQ8lOOLrXkQBN/lc2t7wxQsYI+DNusWOvPDNCtYLLL4R5PLzcVQefYVcvfKlcA7H1PoFgvwJi1jmekplKvunSfbGFvUNxe6TGRB/lZ3JYGPoDFngzczINk1gXi2/kLcmtsStn/UhJFnI0b4+VCRXDzjaHjswquIdBF05u48hX00pi3OwZodco7ujnZP85923Euyjw6CkYolOc3SlByn8ipP0rpBAFvYAvkRDKtvJDCtBA2OKgobXgHdRlk5x1+nkQakaqF36+Fiw/UmXywltlVud6WVs63Wsy6RFwlA==
Received: from BN9PR03CA0223.namprd03.prod.outlook.com (2603:10b6:408:f8::18)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 11:17:51 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::c2) by BN9PR03CA0223.outlook.office365.com
 (2603:10b6:408:f8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18 via Frontend
 Transport; Wed, 8 Feb 2023 11:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Wed, 8 Feb 2023 11:17:51 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 03:17:37 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 03:17:37 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 8 Feb 2023 03:17:30 -0800
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
Subject: [RFC,v14 4/5] arm64: tegra: Add PCIe port node with PCIe WAKE# for C1 controller
Date:   Wed, 8 Feb 2023 16:46:44 +0530
Message-ID: <20230208111645.3863534-5-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|SN7PR12MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0acefc-9730-411c-810d-08db09c61e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O4c4zBOjRzWgghsS9s35oBFxUCvMCXeG8U/K8BGjpYWckAcllCQRIGb8zNHPK9MDBN9tQrvR3IIvDgVS7tPhb635p3H/rqILO6/pIrOoYgM4q/GZFOxxN3L6yKIAwKKqBkb91mWWbvtX5DdS8712UcwZsCmLsy1ZvLzxgU3tlIWBDR1rUinDyoZWZAIR1f4bbXUfMGGyLTc9Dc1nWeo/bpDw+mQwbXLNH/JgLDH4/bYJYV+aVWpcfOLwU9u153OoFej3opVrq1t5UzF+GAj4ln81a9N+GPrexhMRGZGat+tXc0GSwifG/ASphVBJ4jA1E98I/1spIwp6g+j0k8E7NjJ0pPFZqOb1AJ/fhOtHiLo1902EoLI02ZD+rqQfVsfrk+/ApiUviBYnx3/EIvXkBjevqv+F9rxKha4a0AiLX4a6OngV1mQxJGXaLIl9G5hbNL+3zkV4W/S56D9S34TzsAiPSWCXVJVXdEsA6aey8Ffs1jeixPJjXwPzIOaGzgdB3z5C0sVrmchrtdMuSHI1Hwz6Q9MFzcudnrU6gzNBEh3qEjKilU/D3DCN13KBB/24G2EbDGYmvRzBqexSE87kCNPU7qRlheQNWK7GlMPvJUqJc/adRhSGXtppOy5EGJtTZWzJ6Y2kTbDoZrhODTrh1nMmB0e07MNIY9PMCQHMbDvuK5Oge0VoGXEISSe5vJPfUPnpLAQoANIeJt2yZYTZnw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199018)(46966006)(36840700001)(40470700004)(36860700001)(36756003)(86362001)(7636003)(82740400003)(356005)(41300700001)(8676002)(4326008)(7416002)(5660300002)(8936002)(110136005)(54906003)(70586007)(70206006)(316002)(82310400005)(40460700003)(40480700001)(2906002)(426003)(47076005)(2616005)(336012)(478600001)(7696005)(186003)(26005)(107886003)(6666004)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 11:17:51.4975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0acefc-9730-411c-810d-08db09c61e25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe port node under the PCIe controller-1 device tree node to support
PCIe WAKE# interrupt for WiFi.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---

Changes in v14:
New patch in the series to support PCIe WAKE# in NVIDIA Jetson AGX Orin.

 .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts     | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index 8a9747855d6b..9c89be263141 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -2147,6 +2147,17 @@ pcie@14100000 {
 
 			phys = <&p2u_hsio_3>;
 			phy-names = "p2u-0";
+
+			pci@0,0 {
+				reg = <0x0000 0 0 0 0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+
+				interrupt-parent = <&gpio>;
+				interrupts = <TEGRA234_MAIN_GPIO(L, 2) IRQ_TYPE_LEVEL_LOW>;
+				interrupt-names = "wakeup";
+			};
 		};
 
 		pcie@14160000 {
-- 
2.25.1

