Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7835EA72A
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 15:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiIZN2V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 09:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiIZN1s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 09:27:48 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815157677F;
        Mon, 26 Sep 2022 04:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWVyDxBrAfJ0H7Nr9oxrr896BzfjYRWyI5sRIeqxrkWpy6u0nw0ibwmcJQwpr5VaabR+wsMUq5qyRYsiGY6ojsYpDJhJWScn1b+OfXd8Ce+8TYcRiZE7kLfuvPHHd8pN2HA7G7f8JjsB0ICLPrjCAHkZBCyDGrfycXG+8uc2ZYOAtZBQFExwfn6eB3OBv2TbJK7ughQKRcSqN4Vgaxo7nlbncRsh9/ny/8QqRZm4AgiAR76kTEQYbEJ1qOO9O/0C2R0vfQZmKti4woj90igpJlgVYPxvOXOHdlYoQirCSQb6FyjfKCxVocqQN3DAfCUYYXy5Ky1XaYbh8P7b4dOIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS4tAl4e4GdO0ByBukVOwers8V1PitXMTTFaTisp6rg=;
 b=HLss4Nl+9lE/+fnk4nE7S1rFzLmH8GjwF2h/JB9CjNhL11RCYc6bWjVnkni7xXibz9gfAJoDXmrRcSdF3CVauXY+AUP6LxqvoAFVVXuIaJ+Ub0eMEAMuvc0zCcLwIr9IpHvEF1je14ZQqQcMmP+YKF0c8ACK+gXxp9ECju/8ZXsYt0h+D8sxvPBCDQymtdIaKHI77/ONXG6UE22VHE2nIEt62jTnoJ++wwbiEK+jaS4qW7yT83V9e3v9Zy/LbA8tmXU7yQRG+MXDg2kldKFN9FG4ainR2HmnU8RfjRDn8KN3w3JsmYCDXniyIb/Pg1psmFyrh3nNiWWHR9Sz0/h/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS4tAl4e4GdO0ByBukVOwers8V1PitXMTTFaTisp6rg=;
 b=gcs0gYhnLoOHf/H41PUuHaoD2cG/iDhp9M297Xrla0oJTcvuGyue1ODcYtOZ8L8k+GsSDjOUhl99i1AwpF+Jb22cbExRRJ11oNVnQ54lYOesiz52D7i2ptTXmW/Vg3sAyqWzItYMR+NyjqBni4W+AJVrpEGT15q5AXg3Y3Qy5idFqIs3OBrhjznp+081/Meh4geYM00OA3ryOGA/Jev5pY9wbRK0UT6f2eIi0HFg5MHxO5X/Lob0dA//oTGEmFaqxcFjiWqbgTLZpWeY+bFa+aMj/dcmA9wJsKrukEyy4TE6hdUZjTKmsYpSuIacH6nEA6Cyl6xUv1/oyRwiUor1dw==
Received: from DS7PR03CA0334.namprd03.prod.outlook.com (2603:10b6:8:55::11) by
 CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.26; Mon, 26 Sep 2022 11:51:22 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::b1) by DS7PR03CA0334.outlook.office365.com
 (2603:10b6:8:55::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Mon, 26 Sep 2022 11:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 11:51:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 04:51:13 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 04:51:12 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 04:51:07 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <vkoul@kernel.org>,
        <mani@kernel.org>, <Sergey.Semin@baikalelectronics.ru>,
        <ffclaire1224@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V2 4/9] PCI: tegra194: Handle errors in BPMP response
Date:   Mon, 26 Sep 2022 17:20:33 +0530
Message-ID: <20220926115038.24727-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926115038.24727-1-vidyas@nvidia.com>
References: <20220926115038.24727-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f869d32-93bf-4c61-32e6-08da9fb56f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wx+UI7xsDOsCC5XPmjfaZJ+36U+afKuSDHIS4hUaFf9UxPMjUcUTPDT/QaZrSKU7xm7WD5pqDsnvdzqMBQ+URoKip/RCf5R+TRyHvjW2vIy3wyU9oeWFcOmT/l2k+Q9feIAypezyyb960KsF8tozPMe3xb2ax8PHQsDNLX0PTbzu90vbUoShja87rF/wNka3Ne6NLt7XiUHH8XzRrM2O2fZ3+OR5mEg3aL3++TaeJYOdZClrgT8XmSRdu+t2BSMh18hMXIBNQdR0VCAXPXMvvtFKGqiTfvw4oRLP9Rk5lA5FK91x0sBszdZNK5nKxVBvCLkrVgVZ2f3gqMfEa9462lhyUqmdI+hMZfihdUExys+0pmxyTXU8OjQ6mjC2dr4hsTuUXVYr9Gl1S20AOkFOSjpnaJ48OpGvZeqxmSujPkIfDkCN3X6f/7GL7NcOWPxTaksIO8moCwwnw2ntMnxG779d0z3b8uIIkyhreATW62VPTW2dpeo6VeayTDkl6hL3LVhzo3fIkafclgebe89VdanG74bsaruRCNkD+a2JCNoKpVgvOPXGOUrBeYhBOEvkaN4NbetsPqaHKvJ9ibRqioFQBjGqTnMM2YkvDeBRBdhF1r120tli7qdb+l9pfWpegccL0zxK0AN9rV0yIC278rKFD9LUsYLGG0ymNG9GAX8mXlgRcQiOFucddhbNTMb6WJurvvPHIJhomkfJEcyU9ffy2pFCvnC8PtMcK/U7BMgPWINdtGnFQiYGctzsuwcE1K7P/COc32KIl4ahiY73XIu3N/30hQe85M5b1Ii2xoY=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(316002)(5660300002)(26005)(70206006)(70586007)(478600001)(8676002)(7696005)(8936002)(6666004)(41300700001)(7416002)(7636003)(921005)(2616005)(47076005)(83380400001)(356005)(82310400005)(2906002)(186003)(1076003)(336012)(54906003)(110136005)(36860700001)(426003)(4326008)(40460700003)(86362001)(36756003)(40480700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 11:51:22.6381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f869d32-93bf-4c61-32e6-08da9fb56f18
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The return value from tegra_bpmp_transfer indicates the success or
failure of the IPC transaction with BPMP. If the transaction
succeeded, we also need to check the actual command's result code.
Add code to do this.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* None

 drivers/pci/controller/dwc/pcie-tegra194.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 7d6e54a12eff..0268eacdae48 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1203,6 +1203,7 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	/*
 	 * Controller-5 doesn't need to have its state set by BPMP-FW in
@@ -1225,7 +1226,13 @@ static int tegra_pcie_bpmp_set_ctrl_state(struct tegra_pcie_dw *pcie,
 	msg.rx.data = &resp;
 	msg.rx.size = sizeof(resp);
 
-	return tegra_bpmp_transfer(pcie->bpmp, &msg);
+	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
 }
 
 static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
@@ -1234,6 +1241,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	struct mrq_uphy_response resp;
 	struct tegra_bpmp_message msg;
 	struct mrq_uphy_request req;
+	int err;
 
 	memset(&req, 0, sizeof(req));
 	memset(&resp, 0, sizeof(resp));
@@ -1253,7 +1261,13 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 	msg.rx.data = &resp;
 	msg.rx.size = sizeof(resp);
 
-	return tegra_bpmp_transfer(pcie->bpmp, &msg);
+	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
+	if (err)
+		return err;
+	if (msg.rx.ret)
+		return -EINVAL;
+
+	return 0;
 }
 
 static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
-- 
2.17.1

