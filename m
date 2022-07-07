Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B32569CC8
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 10:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiGGIOd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 04:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbiGGIN6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 04:13:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618914D165;
        Thu,  7 Jul 2022 01:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXKfvtEQnVxgJqItnQDhKyqEOio50WPg5FLEbdIkgV6mMyYLdBQUozNyWOynyY/xvP2qv+jn8rejwt6Ro3x5uIYD5x9ZV8i92MVj+regiqgWatFDjXLNL8XV4P1Vw2paF9Qlq3N1+DwPalgu2uPx3SHuSAGtc+h+l4OjQTx/UzhZP8dyV8KI9PN3F80zQ9VnIBXm2waRM2KRicnUWvIAFASVuMVDUvJlmuelzhU0CbsVlQgnKb4OrFffSZGQYrQQtJqzbSTUWagMCZ3rvz7Y7W2JZ8IKB6ogmgrZyVFG+D2K5k91p3FQQ5iQ56TpnBbulZGSaiBQRIFVU6LTt/Rasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oqfC3GPNvpNHBrDz5xuAtMa7gUBsVNLlA5/1w8/6EY=;
 b=my/EMtfNvR+V/0Z1rDiaIbnNg4mao28I9JGS0wN+c9d9Vr/cNanEm64K6oEg4OFkVd6sUdxKUZTPcoy5aANQhSkEqtM0Pf77WcULif2WtWeX/+e0Ca2x1rDVGbNxOj/+7g40FgOkBnx3o+j7ge5gEeknZ/C3ftcjwV2JYScpYAwHSxOCrNbCheocMCn83KxVYeEsot1KEzZsPi7a7tn/5ptBlVEjsVL8l9I/2O12pqdYi4/MKKNRm6guPT3nGo3SJWaw3ZJ2DudJmCGMRdL95Ryr+qLd+qFVjSgoFUMk6DBhIHXbFW9/7Wwr78Xl/rrBRumVgeQzjQkOzPhHu/ib5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oqfC3GPNvpNHBrDz5xuAtMa7gUBsVNLlA5/1w8/6EY=;
 b=nUYUDpsr1vk5gO5m2ACQOu+V+D84nLjZCDsw5h2KPW0la8xvk/g7R3cA+w8RvmdSvBgt+boczLX2DonxVQp8FEyY3ZcLhLxlbvHomFlWo5L1vsjE2j5b0LwTm/xee0/YrhJgZaZ1UaA7dWbmiJKFu5apvRu3YQXdhQpv5cAWyIseBeuBrOjrVwR/NjOWPk9IwgtWBCTKxl7rXKR1fckStiJqnJDGFJY3/PBgqgfY0T9P/ETmevlt/XZdxV9tOeQ7G0gjfG6N7dC0bRufME4m0lyLkPHX8xuvt3AKqCyJSlSDPe8+JOJG9g5y9LkKVPnYypAZX7VcY2THpIi4s7RvpQ==
Received: from MWHPR17CA0078.namprd17.prod.outlook.com (2603:10b6:300:c2::16)
 by CH0PR12MB5188.namprd12.prod.outlook.com (2603:10b6:610:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 7 Jul
 2022 08:13:50 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::5f) by MWHPR17CA0078.outlook.office365.com
 (2603:10b6:300:c2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Thu, 7 Jul 2022 08:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 08:13:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Jul
 2022 08:13:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 7 Jul 2022
 01:13:48 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 7 Jul 2022 01:13:44 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4 6/9] arm64: tegra: Enable PCIe slots in P3737-0000 board
Date:   Thu, 7 Jul 2022 13:42:58 +0530
Message-ID: <20220707081301.29961-7-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707081301.29961-1-vidyas@nvidia.com>
References: <20220707081301.29961-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c08efe89-fd1f-45ab-2aac-08da5ff09f99
X-MS-TrafficTypeDiagnostic: CH0PR12MB5188:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVxiKmv5wsWK2KI2tG+2/rTqBBwl4GlXlEK7fvAbw41wbl6K2e5ITe+TFzkTE/4RODZm23MCPF580mOI3m50JrlYIroGnZjWnkxxCr7LMMeD/+rrz239UVpGuO/8TGkHHnWAq8aMm8xfUTtQYHYJ/lyVRt7Aes5Z5xrkyf8kWStYsSWqvEZlZrsWP/V0Erwu+h54exmfhenqOiKaFgy6i7D5QAP5N9tKA52XbayaS2toWBhymM9gVCOG4NYN41J0yQdkdHJKgn7mj35jpgDoKE3FrT6rTAhoINGqDR9eK40b+YtHcAwp3/Ljjw164l+wBVVpOy5O3PcPCh8aSY56j5kVM1yGdSnlQ5jclCgZ9MJTS2oohjgfd+4jYCou9aBgBWtt3O7ceuL1tOAEHYsgSzKtmYVgivux+ZKLWIVbD+uyYPjhhX0OllOTHBKEHvUHkac3rj6pMNyLVQkejMIRqczgEhQHupvWSQAyhHFZ/jWuo3gPSwnGPmXC3dFTb9dDXGTO48C+76vWr8ZPIloKx6xY3FGbElOPBFpAEY9cWMzG8pA/gHUeq4sAc/2Icem8pXLY/KL4cjpn7nCX6M24NfOcpNVdzu+fCgGVUR2S/nAmRmdFMt6eIcyigKUAmtV40pBs1FCi2Uk8JsQTSgjzf04l81dx6wzOuNDAawpPAzI/LZZHacdFDzuN1J4U6y+grYxUl8iII21W787do7Krj0gKbLuZZXWUHMjA5fgPa1pD5ag3MrvFM4Zwpvr0f6F3yrojNie8tQOsueuUvM4E3LYnir7gOi9n2r4gIlwlnbx+MXY+5FDhFpT8QGYuVyJP4ghe0b5ehctqR7t9sGVm2z9xpHUOVSUCVy+KLnddf1sESVgI3Ds19M5qM0uvMEOm
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966006)(36840700001)(40470700004)(8936002)(478600001)(186003)(426003)(40460700003)(336012)(83380400001)(5660300002)(86362001)(7416002)(36756003)(316002)(1076003)(110136005)(54906003)(40480700001)(2616005)(26005)(47076005)(82740400003)(356005)(41300700001)(70206006)(6666004)(81166007)(70586007)(36860700001)(2906002)(4326008)(82310400005)(8676002)(7696005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 08:13:49.9501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c08efe89-fd1f-45ab-2aac-08da5ff09f99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5188
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
@@ -2111,4 +2111,55 @@
 
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
2.17.1

