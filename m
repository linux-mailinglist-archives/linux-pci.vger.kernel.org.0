Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCA75F6500
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 13:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiJFLNC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 07:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiJFLNA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 07:13:00 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2100.outbound.protection.outlook.com [40.107.22.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83B210B7;
        Thu,  6 Oct 2022 04:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTHDAnFxdmLrsHg6wDY8hx5uhwZ7NkKbUdgRzmmjJJN2+IIhGKBxBEbSqtyu7eZLM3CEvC1bgReuCnPFOIovIIHangsxbNiVzQpChTr/ZZ6oIrxvAfNvFA2anlwrpjlJdhWjiaZq33mq00eptgi4ah4wJzBP8yA3I14eLW6JLLPDS8d8pby8PdOe6hoOzZIJ0noI4/BOd4ZwgdNxuDCOX9GyEInB8ti5ChvWzMhOzfO1Pp91GwguFyDFY0l9yNUcUnuGDn1G0d8m7SwiJ1jOEaoNNO1G/NdEcofYJaImESqHBZYzplTxdPyZcWeqlZ4PrXh0Ze5kiet50ylpGhhxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ibl4ewbv6uqUue+uaLILFyOEDjbpTnpuNTbLgjx5Nk=;
 b=Tucpy9bp5YEsUAbAX3BE2y8GJzlefWJdLh+IflegLELWEE17h6oOdJ4mq6VYCDmf1CgaSuJR/8kWAbp9Ll7Mx5154U/t2arucwzLParRSMT+H7KLvjzMUBOG+HmFlrIAoeu1ystnm+tLtU22C73Ev8xhktpjt0yZGPPaj1qOotOrW4E0F1hXPgkZI3yC5Y+yY+lFneO4ehbEg06YoUaPV/FCPKJg1emASQvKx25f+SU/zSkTnHnpTrb9pzdU6P0iyXcJoW3/LPzeUjqqMQ+fe6CDTzIRSI2sOBriLhBCEjAuqPyi34Dh6o6Txet/+7X1JqJ7kMrofFuf78DZXkzmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ibl4ewbv6uqUue+uaLILFyOEDjbpTnpuNTbLgjx5Nk=;
 b=O8weiuyGtzWnDnzTGO1Ql+uZbmPM2h/rNmt5O4fA2Kk83HtM40F+1O6nJw6UepJoL9o6YkZwMXYCqfhxR85PUfDvA+kLET8tjSAGQZ2YkZI9byYkrTXgwB5hCMULZnLcNBqDI4pUiJQXYVmpSyybTgAQAngNwvwn0k8QwKYZ1iQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DU0P190MB1929.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 11:12:56 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::eb13:ec7c:e027:8404]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::eb13:ec7c:e027:8404%3]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 11:12:56 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Yuval Shaia <yshaia@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH 2/2] PCI: armada8k: Add MSI support for AC5 SoC
Date:   Thu,  6 Oct 2022 14:11:10 +0300
Message-Id: <20221006111110.8574-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221006111110.8574-1-vadym.kochan@plvision.eu>
References: <20221006111110.8574-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0243.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::6) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|DU0P190MB1929:EE_
X-MS-Office365-Filtering-Correlation-Id: 8134490f-2db2-41dc-ea03-08daa78bb870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXYpTkN/Pip5MDpVJrTZ8Iv/535ACaBoQ48pOOxxyglFunglPV7SgcItUp4D/4cOp4HtagILjHfwO5DiGx8t7+qyD4Z4d/yeOzM4NEptxcfq0/hTerMunkba0jSwUkfdmna7BVogZkTYcpRJbqWoiCzOPArAfqdWYVQXIWG82TErolZdAWkFjFYuAE5W0x2xInukMABiprybhulcOM7Ni2S+54gsBNLEL2lQvJ+x6j0+O4zfiy7Kn09An0qi6P/kqjOSYRBVM4n2xmj4zNv7mq3hXZCAVhUsqA1GN7/vEygzNl71z/HkuzZg2zvmW9ZCQTbxB49ELkTbhler357n1e2s7uGRRsIvI8toxlElivDn4Iu6triMraVbYQlAreLqbds1BH1ENPUiNr2RdGYYD5VD+Lw6wAeyNzMgTseaxDLPSz3pfTakjo4eO0sxslzeArRRUaJwQ0tZo+Wu2Gn7U1Krt+QFlz3+EeRLgJj4619fICUy7gk5lO3CvhqGwH66UgSRr9S+s+O1G9u5yRSZSTHW97cUvL9JYSYJfIjtoM1Z4Kt3yGXP4aTshFkEOmcEHaW1jydPQ1oOlGgzmGxIDU60DlxKLCKmVzI6veW3J9pv8D7mlsUKpSr89s7vuukCxX5KQtpO9OTllZdeO5ujC0+uP9QeCbOUzg4bj+16ULmrie3BdKrem3mKbscep3Abg1Q7+OteW0ofj1FjdIb2D2F+EmuvgAOVr3Q+XO3H9OSCYyL7Xur2fLCgkBZEod2s3064WARWhHYI/mLp6yKlyHWs63IlG75vUHO5ipDeoHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(346002)(39840400004)(136003)(451199015)(86362001)(478600001)(110136005)(4326008)(8676002)(44832011)(41300700001)(66476007)(66556008)(6666004)(107886003)(316002)(54906003)(38350700002)(52116002)(83380400001)(36756003)(38100700002)(6486002)(7416002)(6512007)(5660300002)(66946007)(6506007)(8936002)(26005)(2906002)(2616005)(186003)(1076003)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1OTYOpWhKO/imG51HahsBpkd6ipBRwx3NLdsVmCBxRsMWsaM7YS5Yx4HT2KX?=
 =?us-ascii?Q?FSn9zPr2YykeT3u+nb+3vV0tRhIOaQ7cAfIA8vA9jNClthKJ+MZbrnRBNVLY?=
 =?us-ascii?Q?ZYs67q/ONVC7lZoOI7H5nX4xo9AmGc7fxhm3ExeS6WWjxfHzu+8bgPFsi46K?=
 =?us-ascii?Q?iKTtFDqgxfVcHntHwfvl0qedVel0DPK6R9xrLrShrXpbb+ntmilSQlNSt4Po?=
 =?us-ascii?Q?N4d9M/RT3SyLCKtFHE9YRuoPvAmQp8QFtipbq7kuRmzuh5QeLZWzA6+c/T1c?=
 =?us-ascii?Q?rPtrk+zMB9FE3sNMvJmKWl+jLS88q/kbODJDMmc8zspTni4SdBhGwYDZsnnI?=
 =?us-ascii?Q?xsvjdn/Z/UwokVHJRsCCpMPjfvm5eyfWu7P9ZbrVCGsGw5BwO4RRWY7rj/fY?=
 =?us-ascii?Q?ks7jJR4UGZZ87upDcH9j8hQEj9DcaApWmWPVTbczDKWeXP8EzzLBHcxdPnWg?=
 =?us-ascii?Q?3sBzCwmPgNIk09myZk8DXbh3Xh3GwpKyUnPSM1+D/8kBs54VcQ1xAnSGqYmD?=
 =?us-ascii?Q?tL+UF81cNMeiqzNMBBk3CfqZrUUOj6nr2jmmDVA34/vB9o3B4F8S/cURH6C7?=
 =?us-ascii?Q?N15YsDW4LVz+LfDPogviP4OYjgdtKsKpjlCsRbtydwzJR7UJc9y1NdSJnG8T?=
 =?us-ascii?Q?Mw5Jfly67n0Kt7vdCLvnaqVTtS679bU8t+tkVFJAbU88qYPusH2swtBR7YAc?=
 =?us-ascii?Q?WAvjhYbYK8t9KvWJKPlJbg6mOO7S6NEEDleP1GYwVPQtRqZDnswubOheh+Mv?=
 =?us-ascii?Q?tkVi3VtfINIcGdUKiuDmd5+hNjLPQrViEscgMpma2B8TbatAqILa+MDN84SM?=
 =?us-ascii?Q?LMKaUkhuBpGB3Z/T00fe8YlbZO7uLSlrvUVPowcAGtInvpXNIBuAekLO3nkS?=
 =?us-ascii?Q?umK78vAjHYxkS6ZCIAXVB0ZKe6bd9PmcbwTL6i4BECJ5tADIFoHOvG4oBgzG?=
 =?us-ascii?Q?qjNasOPYvF/OfbBAHD7uXUa9cr52gXNV7Y7FwUqVspnK+4sDhVZ9VKq8bFet?=
 =?us-ascii?Q?kXbnOoCc+DA1DaXJju3U9rwS/orLhsrhEHRq5XH5Nw7ABc+h4fJ8bm1ZttX7?=
 =?us-ascii?Q?vAshTPCkP0Q5skqoeIskw+XHb3O9Wm6oltuq+QobffgVPONCQW71zEByYWHA?=
 =?us-ascii?Q?pyJRPv8kQikagNxHCJZSXN6U2rkzmXugwlQQoB1fsgsYCYOc68EAZ+CMam2/?=
 =?us-ascii?Q?+LpbtJltT5JiECJ1J/EyoHqKblGs7U7JTMueKkhpRT0Ao/gz8a56sucHt9z7?=
 =?us-ascii?Q?IKakuNxyYH291GrEt1Xnmvd1m2abKfi4U7s5k+ZHNcxFkXgX7QNj8ZutB5a7?=
 =?us-ascii?Q?c6bHzUNb9njTaf04m/iIdEp8Ht4FJg5r9poZkNTUFWR9iCbsQgRn5bQ+1hJB?=
 =?us-ascii?Q?Wu5Wyz0tN2/Wa2Frtbf+yQZ9wam0mNWgLJIxMDM3MfaCQ2ZZjsI1PGydg7Ln?=
 =?us-ascii?Q?ArFidXl/YhKKV1OZP6spaiURc/+G8LY2LnHEVDOr/OhSZ4e8et5ha4Uvt8LV?=
 =?us-ascii?Q?2snx8F3PhtMGt2DtQm4SZqcoE6udvzee/YNKe7W1F1TjYkqFVHLSze00bsWb?=
 =?us-ascii?Q?+LiMfp1weOAKSidWXjGJaMiUNYxk4OSUwQtwbEUcc3vBHmLn5ykd3joulZ1m?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8134490f-2db2-41dc-ea03-08daa78bb870
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 11:12:56.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jh7YoaXP76bw7wfMVM9EV6euF+dQNKPruug7QJ6EkVVYr06ySjUXDyEO2CRT83UWB2yOaGmszoAkIaTC9DvkwfM1UbS/MdN9XTuXZa9/PAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yuval Shaia <yshaia@marvell.com>

AC5 requieres different handling for MSI as with armada8k.
Fix it by:
1. Enabling the relevant bits in init phase
2. Dispatch virtual IRQ handlers when MSI interrupts are received

Also enable/disable PCIE_APP_LTSSM for AC5.

Signed-off-by: Yuval Shaia <yshaia@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 28 ++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index b025d23bb058..c2a285e33e90 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -45,6 +45,7 @@ struct armada8k_pcie {
 
 #define PCIE_GLOBAL_CONTROL_REG		(PCIE_VENDOR_REGS_OFFSET + 0x0)
 #define PCIE_APP_LTSSM_EN		BIT(2)
+#define PCIE_APP_LTSSM_EN_AC5		BIT(24)
 #define PCIE_DEVICE_TYPE_SHIFT		4
 #define PCIE_DEVICE_TYPE_MASK		0xF
 #define PCIE_DEVICE_TYPE_RC		0x4 /* Root complex */
@@ -64,6 +65,7 @@ struct armada8k_pcie {
 #define PCIE_INT_B_ASSERT_MASK_AC5	BIT(13)
 #define PCIE_INT_C_ASSERT_MASK_AC5	BIT(14)
 #define PCIE_INT_D_ASSERT_MASK_AC5	BIT(15)
+#define PCIE_MSI_MASK_AC5		BIT(11)
 
 #define PCIE_ARCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x50)
 #define PCIE_AWCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x54)
@@ -167,16 +169,30 @@ static int armada8k_pcie_link_up(struct dw_pcie *pci)
 
 static int armada8k_pcie_start_link(struct dw_pcie *pci)
 {
+	struct armada8k_pcie *pcie = to_armada8k_pcie(pci);
 	u32 reg;
 
 	/* Start LTSSM */
 	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
-	reg |= PCIE_APP_LTSSM_EN;
+	if (pcie->pcie_type == MVPCIE_TYPE_AC5)
+		reg |= PCIE_APP_LTSSM_EN_AC5;
+	else
+		reg |= PCIE_APP_LTSSM_EN;
 	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
 
 	return 0;
 }
 
+void ac5_pcie_msi_init(struct dw_pcie *pci)
+{
+	u32 val;
+
+	/* Set MSI bit in interrupt mask */
+	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG);
+	val |= PCIE_MSI_MASK_AC5;
+	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, val);
+}
+
 static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	u32 reg;
@@ -186,7 +202,10 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 	if (!dw_pcie_link_up(pci)) {
 		/* Disable LTSSM state machine to enable configuration */
 		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
-		reg &= ~(PCIE_APP_LTSSM_EN);
+		if (pcie->pcie_type == MVPCIE_TYPE_AC5)
+			reg &= ~(PCIE_APP_LTSSM_EN_AC5);
+		else
+			reg &= ~(PCIE_APP_LTSSM_EN);
 		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
@@ -226,6 +245,9 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
 	}
 
+	if (IS_ENABLED(CONFIG_PCI_MSI) && (pcie->pcie_type == MVPCIE_TYPE_AC5))
+		ac5_pcie_msi_init(pci);
+
 	return 0;
 }
 
@@ -242,6 +264,8 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 	 */
 	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG);
 	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG, val);
+	if ((PCIE_MSI_MASK_AC5 & val) && (pcie->pcie_type == MVPCIE_TYPE_AC5))
+		dw_handle_msi_irq(&pci->pp);
 
 	return IRQ_HANDLED;
 }
-- 
2.17.1

