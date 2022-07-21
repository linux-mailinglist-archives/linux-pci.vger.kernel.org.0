Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D89A57CD77
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiGUOXd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiGUOXJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:23:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDA9863F2;
        Thu, 21 Jul 2022 07:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAgk/kW2cMeI8cJoVNipnEhBo8bp+KMFWlS3JCSnT0kfAdFcTf0Qcwwv1iOXI4m8/lm2KB6rgmQUJi8YoOUEEKKyaGM4kXWOovjTgTaLNERDAwPBmuJB3IGmY2hRMF9xHU+HaS4Xwp6DJtDYMDGxmnLmnT2PwwuyAq9CZT2ntU2tOVTiqqJE95iCWzmjdvAuJ6vMj5/W7ZIZ+X1ORd1/F51peTxmlRSUNTFq40ZduPF7llEIinZZHFdxy4NaHgj8XZ7RborgJiUE/Iq6qrIxoquWe+8s8697n7+x2C6v0YD9PK4ndym66QrKKUkWSsdJ/7i5Yz4Wf2qAmsyekzULfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TW1ezsUJMiW0HdTUI5h8rBu2OnEXOijmvFlGFkaRmUI=;
 b=W8Gp5r6w9A9awuczY5DOxUGlReHorlGCKpatzwm4wEZngVxh9CBdqOhVGe7jqJGK6viQa2sIFxDr82pxhbwcrQEsnU8msYeH5RuHeoZqfjLtP31VHWkXchuC+Dx7U9O/fqmSw3pFmPHoNs/XrBQzxclQD4CPqRjnB8I7xQNKlludQirUCbV0AtbVI0vOtvwcQR6ZBjHmB14xOZ4E20D5rRu/vN1KxcRKLUsAUO4Hx8mc5w1/HX9KrGvta+idghCzl8VnPlAefyvCTQ2G8cYUae5n0+k7HWVOKpOXIHpgvNZooQP3TjoSxejzpATu9SQcFWmksH/T/BTAykj6dYoYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW1ezsUJMiW0HdTUI5h8rBu2OnEXOijmvFlGFkaRmUI=;
 b=bHAqSp+p2xepY/81r6p5hufY3N+HQB7KJa+kzJxeaxT+rDjbMl/SQGTnQg3OtJURy9ProYv+1gSFBsWTvW/dKL8uQywu931ZnLTVhPWYTV0oFfwoMw70aNUiB9emoysYp0H9NfR7rgcdQhQKt0WgAaYFRP4AXBrLT9YHzzDl1TIrHeaEtc/mzjJAyuaZ1yisNRCThs2ySpadQY/vs08JBibVSqrWvgqfaYZxKF3jO4yr7Vpl8aGZEuTGdTy6dfMKg1g33eh4uMGogPVWoTugB+FmxqXU9796IZ505awupPiPgJ3Z0aQaF94Hg1Pij7YZQP56ECTOL4L5Nf9b65z7vA==
Received: from DM6PR11CA0028.namprd11.prod.outlook.com (2603:10b6:5:190::41)
 by MN2PR12MB3375.namprd12.prod.outlook.com (2603:10b6:208:cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Thu, 21 Jul
 2022 14:22:46 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::24) by DM6PR11CA0028.outlook.office365.com
 (2603:10b6:5:190::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17 via Frontend
 Transport; Thu, 21 Jul 2022 14:22:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:22:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 21 Jul 2022 14:22:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 21 Jul 2022 07:22:43 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 21 Jul 2022 07:22:39 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 14/16] PCI: tegra194: Fix link up retry sequence
Date:   Thu, 21 Jul 2022 19:50:50 +0530
Message-ID: <20220721142052.25971-15-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721142052.25971-1-vidyas@nvidia.com>
References: <20220721142052.25971-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34d71983-6a80-414a-993f-08da6b247b85
X-MS-TrafficTypeDiagnostic: MN2PR12MB3375:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/qV499Ti3irzQ82KFJAB1EQWKJ8WP5Ot1cIBbh/mm1tij9kyJX7vBcBQxgl9uced1Gk0fJCTgRj+vRB/K/45L3qVHvs4LT2DgdewbsyUcmuiuA2pHdlyOa1frdm0Ks0EatrxZai1X+O1P+xRk9GwhY4GliEIAqDTShpFYlwspHeXau/yTjtHSS6zDtUv4qLITfK6aZ66OqxwVheqVnCfnMojz/QR1E9zN/f3Ika2kxdtQ+HE7ozWJ1U/g9L6+/7PqqKr7jeQexLdbYn8ktaF6ezVR1lzMrGBzUtZJfMrukKAY6lPkvPf8DQ8KUB2XiJ7AzdqUrMqyh/mFkdHDR3ET+3LRwLrCcn/JjYwGRUI6Qd15VobXyclXANg3FjT1kT63WMeh5Qg98a1SFUl8X5kRyqFSDK24+YZ6Cg2PIGiZvDz2fIF2rwUq8LmUvjpp7ozJuBUo4wv/jBx+CAXVBGIqMXEV64aeivlSw5SUKmLhMnp484L4ftuXLRoI4svBKQR5Jf8WkAZk17fVY+qaPGFfG301W6a7U/eTfwnYxBxmbR7cgZRSr3CHYFXjIUQc3Y0L5eTURPrFDILevFnwJsDxy1t9lzNDLTtPJEOTtJAET1y7imdnUEuTi0HMYWgtlVpzF8/+4Ygea5/1UddW0zR8uwjyPlGG60ahi9gKBDeEWv1l2/fCBmi5goQsuZqaVpGWXRp1pwJ8Wbixps7YGLE3lbWQV2ZAQjvph6GcwNa7WGWhFle8qHzzdpq+fb0cym7gLcKRvM1fh0gg2ARBJrCfurqaF32+scrgBNydN0wP5p2qspz5s55kMawpB/N8jULmLWYSScqe+u5X+2yqGeG6zwfTU3jFTXE8pzFPikAoM=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(376002)(396003)(46966006)(40470700004)(36840700001)(186003)(47076005)(8676002)(478600001)(4326008)(2616005)(336012)(426003)(8936002)(6666004)(83380400001)(82310400005)(36756003)(7696005)(41300700001)(26005)(81166007)(356005)(5660300002)(54906003)(1076003)(2906002)(40480700001)(4744005)(36860700001)(82740400003)(110136005)(70206006)(70586007)(316002)(7416002)(86362001)(40460700003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:22:46.0600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d71983-6a80-414a-993f-08da6b247b85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3375
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the missing DLF capability offset while clearing
DL_FEATURE_EXCHANGE_EN bit during link up retry.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V6:
* New addition in V6 based on Bjorn's review comment

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 39f7ae61fdc6..bac2e1ad0a29 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -967,7 +967,7 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 		offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_DLF);
 		val = dw_pcie_readl_dbi(pci, offset + PCI_DLF_CAP);
 		val &= ~PCI_DLF_EXCHANGE_ENABLE;
-		dw_pcie_writel_dbi(pci, offset, val);
+		dw_pcie_writel_dbi(pci, offset + PCI_DLF_CAP, val);
 
 		tegra_pcie_dw_host_init(pp);
 		dw_pcie_setup_rc(pp);
-- 
2.17.1

