Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EC150CA27
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 14:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiDWMxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 08:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiDWMwc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 08:52:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECD31C132;
        Sat, 23 Apr 2022 05:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StNOJWjgTazI4xj4TNnciAfLRzptqz4NJoFSWqCGtsOqThAjEpZiCCqIjr2z9aeWHkT0zBFhLzgMlv4SI342oU/6tDeAwE+r4guusHr2WQzGUnzwjHl2oBn6P+UH14IXP+Mif6SFAJlJLaXHBtWIGIbThEKhSdqN+AYeinL16pzw4id/aVN0Y1m8t7wLrQbV5QbwgzDuUE+WL2O0evHkCMmIpiu+QItCpzd6c0YVwmYANxLkoqueXT34MvZRyT+tP9nU0kODiNf1GlsE//r92Yy029WU+s3X3YVzye0AdmidEf+DXR55JJfIKJZsaJJxA9VUMVhkKqMamKTarAWOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP66I+368OHYlTq+rk7phDqTrq+itIjlGxp5+bK7lY0=;
 b=d2KRGESoxrYCWJeN+8IguRv086otH4pnpqtGkmx0WbQDIq4e1CFLmiLwalniRgF7e2LPOfigHiZ3dFAQlfDML1MpK2+a1caIgui9mLtJt92bCWWrfvbP6ruNFyrxFhHmG5vMob7IPlpQrxXwicov3EqE7DgQASmUIT/h98IR0dNw7lIg7c2+636wmbt87ZCB8DMz/4n72UNAHd4fJapS5huvXuDgOGTIonljik7wDzKJxLtbekxGB4AHsDL0vJM/KO+j6FWb3+lHEhE4IfQ/8a90i+asyJ8cqQBiHMwiUgor4vydTgU8iDhbd/jGkGAObai8jnTcOadv3M65Il6ayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP66I+368OHYlTq+rk7phDqTrq+itIjlGxp5+bK7lY0=;
 b=Cvym41yjf01YkbQRtEbzDB1tOGgoIde42YuR6tl9MjMle2GnmJfvvXe0i8T7BvtUTZlnl9dNfCCkXd65RkK01X3PAmCrry4GRVWQn9mKt1cgzWMPbZhgWoVMkXMffJwuKQ3Lk6kgZChArCydkdwXfu9Tebsy7VR63drXsHj2rmPyt2R8/7eu2kvaZHwsLOkAkZaRLnYM675rbWjDnFa2g/VSyRY39yHDm8onm7Jkr1XhZwN7btpzu8hldsxdjdt2gSbCBzry0Vs+5mPOq221VNkgqTprxJ6fOVpMnCvyuu3mMTBmQhW2wj1b7R17mPNAVO0hGc2SngNBTfOIv7mIEA==
Received: from DM6PR07CA0056.namprd07.prod.outlook.com (2603:10b6:5:74::33) by
 SJ0PR12MB5503.namprd12.prod.outlook.com (2603:10b6:a03:37f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Sat, 23 Apr
 2022 12:49:33 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::41) by DM6PR07CA0056.outlook.office365.com
 (2603:10b6:5:74::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Sat, 23 Apr 2022 12:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Sat, 23 Apr 2022 12:49:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Sat, 23 Apr 2022 12:49:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 23 Apr 2022 05:49:31 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Sat, 23 Apr 2022 05:49:26 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <kw@linux.com>,
        <krzk@kernel.org>, <p.zabel@pengutronix.de>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 4/8] arm64: tegra: Enable PCIe slots in P3737-0000 board
Date:   Sat, 23 Apr 2022 18:18:54 +0530
Message-ID: <20220423124858.25946-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220423124858.25946-1-vidyas@nvidia.com>
References: <20220423124858.25946-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 651ee20b-3e37-436f-c24e-08da2527b6ea
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5503:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB550336B0E02CF4744FEEADA3B8F69@SJ0PR12MB5503.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1GOJX84jeyxaicsbVBtOlJ6ZWAKevnngwmjDeG78spd54S0Umt2BwHeedJnPjvrjTVM+DgugsNNafEjpca5Lb8ghhgwm7CMXeKFI3zrhYI+ag7En+3ynVuCbw/IsflR2XKziXyVy1N3DK2AN3pw02TCZq42puSOqNGsADtaLYy48oQO7N0hxDPsr3PzrEkPT0stdcPzvpEPR+tbNUdByPrFGMi3BsI9lp7DOsI6HUe3lXqu7pQduXmn97eMOCZpBRpGsx1z7vj+rhleFUYNbgz2xEjMBq4FGS/uEweCVYTRkPj951vp547jLHzRFaoP6ICnTbdCUnkZ6JeRCdubKZkKatg+C01/jA9GcjmQKT4fGXThtYKd86JyqI9UU33lmhlAWyAmakLPvXwMatNzNCN68RTCl8KhdOfbzT6BFPbkAe0XHqEUwmYz6UBgqKdXMv+2jWI30edbli7lkcVoHc9d23PKvDI73f7fvgkDN4TG6LixdPSvpvaJcYndqvviPHKGP/W626vpJPNvD3lQsQ+5xbq4Y/rtMPZpPMMnH3dLdjn9JY9OtLsVIp27xp6a/lk9H56w4GINBkP0E22jscZ3jD/HbBgASi2eePi6NIiM2jFgeAyoXqcf2Pfw7crmUHnMwT3+sCs5ZLAxkR3DqpqwVyoC8uLRKuGrja+qk1CNAPxgfjItTJMKaEOCW+y31CPCvTJ9RVi1Myy6SGBokHw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6636002)(82310400005)(356005)(4326008)(2616005)(508600001)(8676002)(81166007)(1076003)(186003)(86362001)(36756003)(26005)(7696005)(8936002)(6666004)(70206006)(70586007)(40460700003)(2906002)(7416002)(47076005)(36860700001)(426003)(54906003)(5660300002)(316002)(336012)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 12:49:32.7887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 651ee20b-3e37-436f-c24e-08da2527b6ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5503
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIe controller nodes to enable respective PCIe slots on
P3737-0000 board. Following is the ownership of slots by different
PCIe controllers.
Controller-1 : On-board Broadcom WiFi controller
Controller-4 : M.2 Key-M slot
Controller-5 : CEM form-factor x8 slot

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Addressed review comment from Krzysztof

 .../nvidia/tegra234-p3737-0000+p3701-0000.dts | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index 34d6a01ee1c6..0cd3df3292ae 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -1845,4 +1845,29 @@
 
 		label = "NVIDIA Jetson AGX Orin APE";
 	};
+
+	pcie@14100000 {
+		status = "okay";
+
+		phys = <&p2u_hsio_3>;
+		phy-names = "p2u-0";
+	};
+
+	pcie@14160000 {
+		status = "okay";
+
+		phys = <&p2u_hsio_4>, <&p2u_hsio_5>, <&p2u_hsio_6>,
+		       <&p2u_hsio_7>;
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
+	};
+
+	pcie@141a0000 {
+		status = "okay";
+
+		phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
+		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
+		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
+			    "p2u-5", "p2u-6", "p2u-7";
+	};
 };
-- 
2.17.1

