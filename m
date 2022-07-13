Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B1F5731E0
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 11:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbiGMJBb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 05:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiGMJBW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 05:01:22 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A5DE6337;
        Wed, 13 Jul 2022 02:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DswwfH916w6u/ZPYp2v4QT8vdQRuOGQO3p3vhXbAvhoLuMua0BKVSSulPyVzg3hpTRZL4lpbb2AydS0cA05qMDY1QInBUFPlBvHSlwccWANYGoOfP3cNZmu1qW7PuSaXyGq/E2Qdho1RyGeTjV+BJK/mpFBNPNmhQ6ZF+dlAx7owLDaUDcNZge5jBhuYhEysfPmcMMGp17GNfbmqQFbeUHd0rh3/APBjjQ3yY772Z1e8YFbw4l+5sfpNO9Pe3l9JjfxKk90ZUougCwyLZ2B4H8QeUcZKOIlntUBo2tU9VZWy6aKeaHhK5E8IFMx0e2pvv764Xs9C9+wXcJ6oQJrHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGD7RO7zuiAZaIcXEiG3Hq279VTf8NmzJeZmrNtMw3I=;
 b=na52CwQr9QP5Cp2Xn9enqNAJmO6c6uoCBlpM3Q9cR3S5BtcOZXpUcpkgsXrpJPSvnmjuz6dhlbFJsfT7L77TDn5BYmeeO/Fu8aFhrTOgOAMzYWprYwc5LUAZR7BJ2+iSYfkxwZaM1zUgm6l0b5y7Dh1XRWkA8QwvSFCkph9+0SF1ZV5qYc+OA4JoezdMwwpqK0r5IaqXFCsUIzwY+//pH+k9PecXuc7EjRx61e3U/+YrwjEiPdFcgpjrRaFKiZ0rT/r898VN3YDIbCAcKOrcjP0bU0fgkqyNb51q55TtHb91QHSMIs9LLsPx//wMFu9Scvte/5ln1hYgMaltVaHmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGD7RO7zuiAZaIcXEiG3Hq279VTf8NmzJeZmrNtMw3I=;
 b=WdX2d0WiEMTpStCDCL0DxiFIYTqU+d3Z9XqRFVawuQ1uy5h1J8GsrRJYNlRCB+GBDj3uSzkcFZChZG9gTDckEZ5Y0NmBgmCBthHfCF8ybULReqvd23FxsRVbjYMiK96/nBnIPDW7gEeWz+qbpe6oMjjNtpgU1Zw1C+5SEYZ/lAhVYRtrrZAl8mPrhk7vAMv8jWLwpnTTuBNg9qasqSlVaYreajxu4gd4brcHmXCS6kMYBKoh6/cuzjOAuVs9DFcTgSiL7vpHQ4oWRCSIGePbHhPxtLXoI9H3sN65iAlIeyjjS2pvuPrRV50oQoRY+l2yjnvQng0gHSBSF6ecAs3XCQ==
Received: from MW4P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::6) by
 BYAPR12MB3574.namprd12.prod.outlook.com (2603:10b6:a03:ae::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.23; Wed, 13 Jul 2022 09:01:17 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::62) by MW4P221CA0001.outlook.office365.com
 (2603:10b6:303:8b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Wed, 13 Jul 2022 09:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 09:01:17 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Jul
 2022 09:01:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 13 Jul
 2022 02:01:13 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 13 Jul 2022 02:01:09 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 6/9] arm64: tegra: Enable PCIe slots in P3737-0000 board
Date:   Wed, 13 Jul 2022 14:30:26 +0530
Message-ID: <20220713090029.30395-7-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220713090029.30395-1-vidyas@nvidia.com>
References: <20220713090029.30395-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18d7cdf9-e471-4cba-8295-08da64ae3f45
X-MS-TrafficTypeDiagnostic: BYAPR12MB3574:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w8vnI+RBoNAyoQvDPT59xoeiWMohzpff7DMEvguv/LpNrJk3SLGheDDvfMrYsEBkiR1RF0TfGFG1vmIkgV7m4wcWNWKJ81SdXJojQzRZz4dGM5I3ZAjt0X++mezpSD5k9hLSTHNYsnQnbExlrS/13Dy1uhzcHMk6mTKTVz2C6K/9ntbtV6+ASRz0W2Wdu9hmwdgdyLXPJjecEuBU6TN1U/HXZ0HZ0voWac1L7nwMyiHQxTe4HSKaddIxwleUbf+ZpGRgQAQc2iPcm+xO/Ji9yFVyNSXlqThRh2F/N/2mt5whkzsX/ySGVtcWYewrVgmv8a0Wbd6Ma4Q7vh9LiO/pm6AwNGKIa99+ZMPRnUoRQAcRvPd5XOYcajyvGr8imxM/+RZlzHYQuBEhA6cINzVJ9iAaTI560sU97/voGXFQLo2SgHpAS8UoT90LSgrPELbiqyD3UClopNB4wXRpNLvcmZDePHFhPAJn+FRl6+R+mHx45QysJvNUo6OvueaRJcRpQuepO5QY0pFAAybqVc3FHwumArrYOHmCc/2LtSaih7jPNst+FfxjDvGgoqbWbdXwgimXtoBmNERDCHskQw8ZUSL10LTCecIiYDnYTGqYlXoYQNvhIdpPbKh65NRlAP6qnVW+Ssib7Z2v/lrZTk/kcDiJuo8RyW2yWt/26wCk61AKFsR8CAVDRxx1EDtx3YPOk7oOxQ5ADqGF9dXu5NXtUcFo457QoEG3O5CebMapzER/a8yP33JkEQLDRVt6wH9739AjrFJHrnkE1edM4gDNUgbaTZXIWhJpK+zcA2OJLW7w0qhEhuYjg/tP5yFzBHmabpneKID6JRzK23MN58bW781ePOWlhVBo5GhZysvNlUt+4cz0yieE3BLSwyp/sKeL
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(396003)(46966006)(40470700004)(36840700001)(40460700003)(86362001)(82740400003)(83380400001)(336012)(8936002)(316002)(186003)(36860700001)(1076003)(47076005)(40480700001)(4326008)(110136005)(70206006)(8676002)(81166007)(54906003)(36756003)(426003)(70586007)(2616005)(5660300002)(2906002)(7696005)(26005)(7416002)(478600001)(356005)(82310400005)(6666004)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 09:01:17.3234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d7cdf9-e471-4cba-8295-08da64ae3f45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3574
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
V5:
* None

V4:
* Rebased on top of the previous patches

V3:
* Added 'vddio-pex-ctl-supply' property
* Added a node for C5 controller's EndPoint mode

V2:
* Addressed review comment from Krzysztof

 .../nvidia/tegra234-p3737-0000+p3701-0000.dts | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index 02a10bb38562..dc11a4f4c10a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -2111,4 +2111,55 @@ sound {
 
 		label = "NVIDIA Jetson AGX Orin APE";
 	};
+
+	pcie@14100000 {
+		status = "okay";
+
+		vddio-pex-ctl-supply = <&vdd_1v8_ao>;
+
+		phys = <&p2u_hsio_3>;
+		phy-names = "p2u-0";
+	};
+
+	pcie@14160000 {
+		status = "okay";
+
+		vddio-pex-ctl-supply = <&vdd_1v8_ao>;
+
+		phys = <&p2u_hsio_4>, <&p2u_hsio_5>, <&p2u_hsio_6>,
+		       <&p2u_hsio_7>;
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
+	};
+
+	pcie@141a0000 {
+		status = "okay";
+
+		vddio-pex-ctl-supply = <&vdd_1v8_ls>;
+		vpcie3v3-supply = <&vdd_3v3_pcie>;
+		vpcie12v-supply = <&vdd_12v_pcie>;
+
+		phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
+		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
+		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
+			    "p2u-5", "p2u-6", "p2u-7";
+	};
+
+	pcie-ep@141a0000 {
+		status = "disabled";
+
+		vddio-pex-ctl-supply = <&vdd_1v8_ls>;
+
+		reset-gpios = <&gpio TEGRA234_MAIN_GPIO(AF, 1) GPIO_ACTIVE_LOW>;
+
+		nvidia,refclk-select-gpios = <&gpio_aon
+					      TEGRA234_AON_GPIO(AA, 4)
+					      GPIO_ACTIVE_HIGH>;
+
+		phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
+		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
+		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
+			    "p2u-5", "p2u-6", "p2u-7";
+	};
 };
-- 
2.34.1

