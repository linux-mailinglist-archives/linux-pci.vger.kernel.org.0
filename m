Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A056CAA25
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 18:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjC0QPH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 12:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjC0QPG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 12:15:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC4558F;
        Mon, 27 Mar 2023 09:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krZTSR2WaiH0gAu/GPaCIOQOEe1RpO0mbUwQ0dzM7ejwGa5/QOV+3PZFg4kTXFY3Ktk1MkzaBOxdG5c+WgkN7OIcKJw5dthqymX/4pHgdkEC4q1JbgGDunoTP0bnSuVhDfmwO7pOS44kPFDsHokl/yHUO8QIXq/k4RYEt30jxaIRvjJSnSz0cYZ6TaSFgTsUGCDXXEqI7pEmuyxFEf7RsAbRTq2mRrImX7B0XRbiNLAQCBdmLrbTDumVb2e0AWdAD4WpIRA4k8cRdSkuhWk3ElLcKdOPPnzPCWrM9HgYwfp2MzNX1bcxYmFEon66UGwslJZ0gWW1fNBgRmY31xXRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfsEk2TaRAD1qyB52N5Pqj8vvIEZIISIOqnJhAvh7J0=;
 b=RqCmQ9B/mUWTPHIwnDkCFLUUMTzVgGnuO3Q6LgMAhl0p4j5WVdNL62UIrk+nMZ5QRxIlBu7Pypp97pnPO9md3eUBK50Y+LQEbxg6SvIhwGJ14WD8jO5J1TSckrGeSnwNx5hbp3ffGtJ00MnCXvO23rEbozazLIdCx2zmfqHzWcyTBmOawQL0wabeSyM3i/TFpn8hzWINx9S2atnMEaLTNdcDlwOKuniHoUjVRYJO2j5slkuKOMnsn+uZTA6nMn6icm0HiQUmcuLn27TPnfct+Ft9dXg69hSiH2QLdzOFRgoDPfbz412mxSMY2P3tZOTiPhebmvUJ+KWKAXMfiHDu2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfsEk2TaRAD1qyB52N5Pqj8vvIEZIISIOqnJhAvh7J0=;
 b=fjfz1YrPhXmskERQoimBXfFA3FR6RrbWuIG4knE2gRTTZkke9Qs1etTS7j8J9YZlTxXVq+Vlhty1QB6AZmrArzzzaGBhcvHa/bbXlIrjFtDf8OKH1tLqPvepcZGlS0MQ96Lkqp4bpPIICoJsZ10S1Bc2jejL9aiNmARVg1NArjMhAsiU4szbT7tXUZLgSyyfGuwMiVpdAUnupe4oS9vqCGIIzy0VzZ3jYuzErkflZeITLf5GCnlHS52dCst3nBBdXB57o/CGY8fIIG6HoxTfnwzv05nLtcX0H3qKwg93oZLNIxKmeflS5apkqPDutG0Uq5F5InPV7B4YH1BqnXSreA==
Received: from DM6PR04CA0024.namprd04.prod.outlook.com (2603:10b6:5:334::29)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 16:14:59 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::3f) by DM6PR04CA0024.outlook.office365.com
 (2603:10b6:5:334::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 16:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 16:14:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 09:14:58 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Mar 2023 09:14:58 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Mon, 27 Mar 2023 09:14:53 -0700
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
Subject: [Patch v4 02/10] arm64: tegra: add bpmp ref in tegra234-mc node
Date:   Mon, 27 Mar 2023 21:44:18 +0530
Message-ID: <20230327161426.32639-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230327161426.32639-1-sumitg@nvidia.com>
References: <20230327161426.32639-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|DM6PR12MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: 276d1b58-2c30-441d-08d9-08db2ede69b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mMOaEMa935v6fLRMcY7irzdDUfZasAWDef53No+fdbPRW/bzrkJtsINTz7cnbOKSMggcnUSGH0lW/xwJB5h9WXJaHP3+7mA3x8cqhoveu/CAUMfIl0Za9iqvbTKI7u03/3/KQmVAe7rI98Ksd7ultt5l5Sge/nLvOQh+pX2sHqwqMkNxFRRJ2XR2oFdhvlxXA7zx+X8NyXCTuPDhMfoeqUhQZSj/54yXgB4CuLJvMuetSymgGDsLY1oq3cankiLaVni7mU+o15IJ7s255QVxc6MJiKgmHJPJNmIRB53OJ27yh1cmiG83J+MiA1jvi5CvJzXbWTbu569jRR3D6582lKr6n4n70eXIjdzSqNLn3ZA7nWWz5l28mdp3kx/vIR273L9ymNRRQRdm4jJ3VT13Iv/UN5BcQc9XxjTV8njit2pzl1h/wQiCtxAK0xjlU51ERt32T8M7sKDOSDlyukPD7nXQ0auWFQyDIGKSXNfxFAg/ulIVvcmd1jvwd5Dkg3MI5sTzwb+QwG/MXXPhNvI7ejRq2Kof+OY/yuVqvue75k11Kmtr7y+AgQqQ1FxeoRcNZvGxLWOD1ErquuLWXi2K4ahT9Up4NXNo1O70r6Yn49gybgCHFhSl1ClAuC9yw4cmWAYhChPrpVbyHjhiJ1epc5aKI7yWT3NQnba8WGuON6V5v+1gpGNNjrK0mtoZNtny64q0OYnrR8EmLeMCivDh3E+JMzmVtvIcTBOytaOAYEWkwZbX1UCfTYy9Nc0veaVL6Vv6oi0/NjjRiajKd/etpzYTYIhv4rlInogG7Ba09Ak=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(34020700004)(316002)(110136005)(40460700003)(36860700001)(54906003)(478600001)(356005)(7636003)(82740400003)(8936002)(5660300002)(36756003)(82310400005)(86362001)(4744005)(7416002)(2906002)(4326008)(8676002)(70206006)(70586007)(41300700001)(40480700001)(107886003)(6666004)(186003)(1076003)(26005)(426003)(2616005)(336012)(47076005)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 16:14:59.2831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 276d1b58-2c30-441d-08d9-08db2ede69b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the "nvidia,bpmp" property within the "memory-controller" node
to reference BPMP node. This is needed by the MC driver to pass
the client info to the BPMP-FW when memory interconnect support is
available.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 959d659dd5cd..348113b4928a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -656,6 +656,8 @@
 			 */
 			dma-ranges = <0x0 0x0 0x0 0x0 0x80 0x0>;
 
+			nvidia,bpmp = <&bpmp>;
+
 			emc: external-memory-controller@2c60000 {
 				compatible = "nvidia,tegra234-emc";
 				reg = <0x0 0x02c60000 0x0 0x90000>,
-- 
2.17.1

