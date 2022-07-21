Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6D457CD56
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiGUOWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiGUOWE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:22:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D54085D56;
        Thu, 21 Jul 2022 07:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/6EsXx/eNVBBcGaEsh/rv4KnRl48R5AAy6tEp9eycjqJMJJTmq/3hVcVoOuOo57QTwTOjPRVRzEQy9op8bnJXAI6ms47Byzs++ohSpJvFgKsvWSX6L+OYSQXx/F8YSlwiBAyb625r7XD3jAw0oeACwbB7X5NeXHgyMSiUJg/A4mUfgEkkqM2cPgBvBARAJnVULb8zYx/M7e9S9sfWeTY77zKFTfEubEzVovZ8CElijsd6Byja8ZXecoa5zM40+aikoDXJU4RRuFVBsH/+4izoHI9qMqfDyLpcGN7vB4FAElhvQxwSySXlyL8aEAHEUhGOZsZswviKIdzcIcSXsOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RmZKf1UjaOO17FruJlp7RBYmPOUayDTICFlL62MivA=;
 b=h3oYTP1p56v2iZOK78EPOC1sYwfpAa7m1nfednyPsA692/u+wwjHpn6SRVLWYx8/BmDxUgU8KL4NP7mIq/ubE38NT+qPIDTc//TSHB/OCCvo7rKgKaH3pBImvWQq/YT3uQ7MCf+rc0Vq9Be2Gd2KqC3qa7PRSlW/F0d7S9pSCU9LLDz+M9cBdzwwRVnxZyTP0tV8tJayGXC135PYVWnYvov8S7pkHtSgkS1Xr0U9k7IH0Udv3+nbvyCNDEPptFbfVmQz9xgJ7jWkj/32YERH/q8FqsOm9pupQVpQJoxmTw7JjEoDanzmH7deZf3q36OQoFThKsIHpaDaw5IxZ9W/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RmZKf1UjaOO17FruJlp7RBYmPOUayDTICFlL62MivA=;
 b=JV/lK9TddPcuWsppPWogjJKpzXXs86pwStYomK2/tTWHAatWGsutKuipBJiQHyL0AG4EEFRDA6P7nUk3B2D2HOVuP6gZoevJogfTKSHWRpkGAf4C/3ssIgGhBLfUvY+clI+pBwpdWYb/NYVNow+O5dEJe4n2JhYrx9q4GG4sWS2kQ3CVnOb+7XdURLXC4XXS/YHFecz54Co4aYBR8ESw+PPlizXdV0dUOj1CHsfGhc9xBjA93LZrgxZIIpirPOhuPLaBtPxCBPlp3g/dNFNx+s+dqfa2Adk294JaJyJ5VQzqxXtrd9bvnDrT9Z9MNwOiWBU+4tR/S2XZI+nkBrAnZQ==
Received: from BN8PR04CA0037.namprd04.prod.outlook.com (2603:10b6:408:d4::11)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 14:21:54 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::ad) by BN8PR04CA0037.outlook.office365.com
 (2603:10b6:408:d4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Thu, 21 Jul 2022 14:21:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:21:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 21 Jul 2022 14:21:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 21 Jul 2022 07:21:52 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 21 Jul 2022 07:21:48 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 06/16] arm64: tegra: Enable PCIe slots in P3737-0000 board
Date:   Thu, 21 Jul 2022 19:50:42 +0530
Message-ID: <20220721142052.25971-7-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721142052.25971-1-vidyas@nvidia.com>
References: <20220721142052.25971-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13f5d1a5-6775-4668-7425-08da6b245c50
X-MS-TrafficTypeDiagnostic: BY5PR12MB4195:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUmBk8+IHO0EWbbo6FZZy6OSs62OJBtVj7lI3N4YAnAN9cTYQQik6PmW9oJTXR0Pf3ljlPvF3HFkvzBeXFsqbD1uZcHopgoIK0rPBE2b5iJVUFjGTDasC6wOztgMq7ALbk5wIen4YGn7f86KR51cHtlvt0rLhfnp6+BG62V9iUDX4/5DhWqHGVmU+K02cfOMqDNggrfothMW51WJAvr9jrsXbntw0V+EVtaTH1y9UVYEcUrZjaSSPt/5ZHKiE+z6NJcEVDB3HKQqtbKJRQQil2WkY7tW+eXPOxQxE88ovbgYshHImgh67GTLPv3IoansNYZ6C5q3lAOnQSZSR5QN88cBiez0SCw2cz8JJzMNRlfWzE0k8y3VZrya0ebloqYkcMolussQYPDG2KXAmYNPGvCHTt4JazEYoVzIgslgZV4LVeePZ7jGPBO7e0KONSJlezSxDdoeVtY/SV+7TBxwRDtQkjwKAyGUsHEvvHQ3xBpYHpar7ApUv7KidOhNSwd5JhOHLEoJbOtcsMZjCdtdt1b+F0OSyo8+K+fEKnZdjtw4EhVOyda2spEFflmprLCxEs6iVyW5WmslB0wnpaGvnMvfNk7H0d6Bl4lH3qXeVDh9M64dQs9sMxybFuxZbDjoFF8FhjHHEaT0Ghdv9qpVi0zDqAstx0aCxeut9dNCEt1BlanXq8J1b8TG2oynXd+g0Bq8Rc3bLR/dr0Yw1/OodIlfUNPsHaRb7TW892t0GJWSVF6YCqlP6+9eBEAzKLvXEwGHNP01+bS2btnr8CodedLBvXKWMSIHLkkkO0Ovo99o2z2yVx+eIetbQ68OTX0CylYIXUkULa4Q3vrWfLJKx3OvsOYYX3wQ66v2HYs6Pfc=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(36840700001)(46966006)(40470700004)(4326008)(36860700001)(70206006)(81166007)(41300700001)(70586007)(2906002)(8676002)(316002)(40480700001)(82740400003)(36756003)(478600001)(7416002)(8936002)(356005)(5660300002)(186003)(110136005)(1076003)(47076005)(426003)(2616005)(336012)(6666004)(83380400001)(82310400005)(54906003)(26005)(40460700003)(86362001)(7696005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:21:53.6242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f5d1a5-6775-4668-7425-08da6b245c50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
V6:
* None

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

