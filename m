Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3E95F64FF
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 13:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiJFLNA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 07:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiJFLM7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 07:12:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2100.outbound.protection.outlook.com [40.107.22.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F190A447;
        Thu,  6 Oct 2022 04:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=My+eO8pfNrOqGa8xcVijq50vTmofbWhyfUyURhTwuPfE2R61BcaK7stWxQgyU7shThcwFB/Ptu1M8pUwOkPVrUE+kt8lw7EeVbon8HUtA1Dhh3NSdMe8Up6KPcpEJUZb4a85xbtN0yqopajiGRB9tOFubjkccPhNQm2CPy7Jk9Do9NGJuNVKQMvJVlsscERRelIwsmF51E7p2YBzYyOLQCNkPCXbEh0fVCO60rVfelKAdMq6YeNxhlnDaFJ9Ei33vJA3QQ57znPG984Bt2u7nDEPYrJKwtGwVOX7XlM2FwJK0gpQ6DvGVH+LJis+fuxgopHYHaD9S7Umj0sPhtqzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lShxXW/1sU/o9nj54qgWW5gJfWSrBUt6/nYntkmWuRw=;
 b=HEFaDvQfE0vdT1psi6yOjByNxhZjpk1yMeBl5EvKsQ3/zhqPeQiJdDvPkPh45AA+IdEYmUU6n+jCWvDri4RZVUwq4b1a/2Xkv8Of6bfIbJw7dEaVXmfNFg+gYxuOBmc2bbqtghcXN5Pc6YtxQlOlJY1XdI8mbJkpLAIrt28XGcvO+ujgRcXTQI0uS9OfvTH3jhOKXuTD8xEYh2laz/xxtuRC5+qC7UQKkfaF2TrwLPWdzC7Bl8E8eF5KCeTLd+j0ssdcSiKkyUy7L6lh5BZiYPgJJXux9WljRPSyWR1g6ePbAZ1u2YTIAFR2o5g+XzKfKZKZHRzOjZh04KRcKiKy9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lShxXW/1sU/o9nj54qgWW5gJfWSrBUt6/nYntkmWuRw=;
 b=TmYaT7dNP54fgqPyg7pV1itwDEERx25itPYM06tLX04zQgVOVz+MMVhawsFUalVYp+TR2zyCG9TIu1gJw5jZb1chTgfO/Lju3dkMzEn1SlogMm2ycIHn7Jb2eINY5vCQE3fvPSe7ZdkeeRlaHWIgEK23jk1fM3DnUF8W+qzrN8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DU0P190MB1929.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:3be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 11:12:55 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::eb13:ec7c:e027:8404]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::eb13:ec7c:e027:8404%3]) with mapi id 15.20.5676.032; Thu, 6 Oct 2022
 11:12:55 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Yuval Shaia <yshaia@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        raza <raza@marvell.com>
Subject: [PATCH 1/2] PCI: armada8k: Add AC5 SoC support
Date:   Thu,  6 Oct 2022 14:11:09 +0300
Message-Id: <20221006111110.8574-2-vadym.kochan@plvision.eu>
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
X-MS-Office365-Filtering-Correlation-Id: cc4d32e1-6b6f-42e5-7f38-08daa78bb7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4V3qdUzYC5HZNSHXA4qZEaGl4GJQniGaI8HHJa8tAi3RQ8HD1nGk1SylGxzwwzNoZzsYThOojG0XTdSo6GR6TqqsNa6PGymGR4UaEA8ihpL5qjjQAlrVuhUkMwulXLzrd5UnePMP7pqgtUpl2TGGS9ql2emv1bRYeuyoJD6ne//dTToNzZbAPFH1YayIrDLdK+0bEilhxkqFnwuagDlFYz/yN/b/GQuZY/M8MWfOGQA8l/4ZijGCoOuJhlw+GO6xrkX7CulNT+OHqu3HV/hHhes+xoq5Yz3WDIu731BOytOq7+IIwIX1rmElBVkDnzGWN1vdHjih+qW3YlTD74D2cMLJqURqszBuh6H903wIvOFEUS3F6poPSUiQ1vxbeDZHrijJZkZmVbBJ1ffmSzt1P0f/GQmSJ8HV7D6qcTJzeHX6BH9eSitAvJ1f47FRwhHr5pZfenZ5ep1ntbLhzOkBms8LjfKCo0zcf8ZBK5f327WuqPDaMLykI3QWwCPSJtXRlFaw9yJ+VZUiYmBJz1u5f21Vmj55Z7wuLngNr3bMAy1zmnAxz3/oxuXE17BpGrkB5M7yr0iSBk6ZT3kXG8kXhmZ+hbcdwtQNmuBbyolGy24J1ufI+en+XixTm9Lrlqha7LCctFAWZfV+SHnITJiymBJy8MmkcAPt0iaYfzsk4MvmsiPaU6zKczR1OeEMaJ0aYyZ+m3bIsZzLAh/WW7NlEUKQNeWwIeU73Qk8DOXJcbo4eYijaP6NHo5mEtMRsRPUxLpDoOpYAIzMn21MKYF02ADoNTpObVEylI9+zNBDA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(346002)(39840400004)(136003)(451199015)(86362001)(478600001)(110136005)(4326008)(8676002)(44832011)(41300700001)(66476007)(66556008)(6666004)(316002)(54906003)(38350700002)(52116002)(83380400001)(36756003)(38100700002)(6486002)(7416002)(6512007)(5660300002)(66946007)(6506007)(8936002)(26005)(2906002)(2616005)(186003)(1076003)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?InNquC3ePGNEvZd81RG9N2LvLKNUmcf3byX7Nm88GaBYyR8aIDNIxFX8ahVZ?=
 =?us-ascii?Q?TLI8rpnICasXPgNpoW4t+NsMn+nkfTjb9B5fZVeFCiACM2fdLZI47YxoyKoB?=
 =?us-ascii?Q?muMCJPOaWrX+tiVEgeem0NSAIw6CkjuOcbllSDZAhrWXrAWGQ9wU1YF0hgPc?=
 =?us-ascii?Q?5DaZzOJBbwAEnzjkzsF/PEUgBg+7w3B58vq2buG9Qb5HS8zETUe8YrPlCt46?=
 =?us-ascii?Q?KgxQ1oGYyk8ST7tByBNAXG0xbtyGSO1yVlm0W3BXrh9O3TO24Z5KVLijSKlh?=
 =?us-ascii?Q?ngwcbwoxH1CRGsUXtn+WcMiivjHvMZODgn8ooE0dSfVpTxK7CNmlvm2J2kWx?=
 =?us-ascii?Q?Jkk/a04SVNQ9lyM3+AIGz4ewG37FdeSopoKNlvTQzO2JJDFM1YV5X7W5WTsW?=
 =?us-ascii?Q?q9AQNTDs2Uk0GDd3Uwa9yTOelXwU8KusSXtNXOvZLfHVUSWgyBlhOqJTszL+?=
 =?us-ascii?Q?nl2BgGayTbWfHv9DSJ7CijH0bTmeZl0FrHd8k77fcaEwCITuU3YmP/mTYukJ?=
 =?us-ascii?Q?VwuL0tF8+a9e5DuGYoN/nbJC3xz1iZX1PIUEPtOTnpXihjr/rxlEwXxhHz4a?=
 =?us-ascii?Q?MIkyFGTqnLE7+T3fCzTk3b5fDxloXfbnE3QC+C1NMkBZGcjHjReKmUmDtXgg?=
 =?us-ascii?Q?/2vK8juNmesogKAhoj4mr4bT2ed6VgIB71MyAjBwlY2YYYTm0cQ4HEBq3+0d?=
 =?us-ascii?Q?Inuij5Z9HNDNDQLfndd0VVl3pVlDujYdhX4igfZ9Ffw3lGisA1NFle4H/21H?=
 =?us-ascii?Q?T+kmq5G3xOE0IT0sPEz6PpyHJQgE8kh4XUATJbLfq9vXBs9UlY0V8R4bJfaq?=
 =?us-ascii?Q?1I6OtK4yNugCyB34rKlF3XsU6g5Y1L0Py83c1VtTXW4ob+OIzTEuZCAuMeQE?=
 =?us-ascii?Q?MBqcmWcEYjtxPg+M8Os/pHxpP9HZ74lBmC7T4AbOznCpSUqTx1drIZSLBkTz?=
 =?us-ascii?Q?mSlUxYQleY2cF8iY0tz8a9OlPxDY/Om81siKqnFq+WYIZgUdjRWpe3WXewt3?=
 =?us-ascii?Q?Ptdubucz/F+GNV1+v8RhGREHzThgbsCpH+HKD8JdSKAq4/5sEkZg3lulE9Sb?=
 =?us-ascii?Q?pcpEzOydyqTJFdrBQM4//prC5gLS95ZIsRi9hfF0GWzMdJLtueR7INYKxZfN?=
 =?us-ascii?Q?Rjqx8iVE2eha0DC5H0bundy6R/IIRElDQPjOc+tPZlkNeUzgpExA4sIKqyTq?=
 =?us-ascii?Q?Ts2X0ko+dKDeJjmo1g7uWTrwY6g0E0c0U7qxFzbbYSTcAUHJvWrR9vbCqmWK?=
 =?us-ascii?Q?SgAYES2agHVUp4G0t89fHxCk3EYutrPxhlz2nakDVfVCpnDVGwav0aB3kfkk?=
 =?us-ascii?Q?29R3/MoAva2185M5STNxapGaDzmirDkUsRUSUeV1lFICDRj5rV/J2ZjOFOEm?=
 =?us-ascii?Q?z1Py+oDb0Zez2aGOFA+yZhTFOKaN4r4yH5WlNXD6RaHHH2dr2gY2CAocjHKt?=
 =?us-ascii?Q?XkVzsO2Gr8EFtna4mW7GzZDtj5qQQuCaz19h/vIUWxOgXgdpFRToFcVPmX9Z?=
 =?us-ascii?Q?MncADx93uyQncS8M7g9tyVITLbrN3HjAKAwMCcVfA+GRA5EJ9DaIPrq5dII1?=
 =?us-ascii?Q?CEzrjI9ov35b+/KJSsp5a9HdZA1AC1fQ//2bj/hiEh3Ywv9KGkPBq+3EhS2O?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4d32e1-6b6f-42e5-7f38-08daa78bb7c0
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 11:12:55.2578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XKWHu4nNST+s2oxx9DkGfqexiAO1lsLYquRlir1cGpewtNx0K7QSFglsAWxFdTrYX7qhouz/9P32HhzCh5lQokG4VjSnKOO2/QkyuRNUJA=
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

From: raza <raza@marvell.com>

pcie-armada8k driver is utilized to serve also AC5.
Driver assumes interrupt mask registers are located in the same address in
both CPUs.
This assumption is incorrect - fix it for AC5.

Co-developed-by: Yuval Shaia <yshaia@marvell.com>
Signed-off-by: Yuval Shaia <yshaia@marvell.com>
Signed-off-by: raza <raza@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 116 +++++++++++++++++----
 1 file changed, 93 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index dc469ef8e99b..b025d23bb058 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -27,12 +27,18 @@
 
 #define ARMADA8K_PCIE_MAX_LANES PCIE_LNK_X4
 
+enum mvpcie_type {
+	MVPCIE_TYPE_A8K,
+	MVPCIE_TYPE_AC5
+};
+
 struct armada8k_pcie {
 	struct dw_pcie *pci;
 	struct clk *clk;
 	struct clk *clk_reg;
 	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
 	unsigned int phy_count;
+	enum mvpcie_type pcie_type;
 };
 
 #define PCIE_VENDOR_REGS_OFFSET		0x8000
@@ -49,10 +55,15 @@ struct armada8k_pcie {
 
 #define PCIE_GLOBAL_INT_CAUSE1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x1C)
 #define PCIE_GLOBAL_INT_MASK1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x20)
+#define PCIE_GLOBAL_INT_MASK2_REG	(PCIE_VENDOR_REGS_OFFSET + 0x28)
 #define PCIE_INT_A_ASSERT_MASK		BIT(9)
 #define PCIE_INT_B_ASSERT_MASK		BIT(10)
 #define PCIE_INT_C_ASSERT_MASK		BIT(11)
 #define PCIE_INT_D_ASSERT_MASK		BIT(12)
+#define PCIE_INT_A_ASSERT_MASK_AC5	BIT(12)
+#define PCIE_INT_B_ASSERT_MASK_AC5	BIT(13)
+#define PCIE_INT_C_ASSERT_MASK_AC5	BIT(14)
+#define PCIE_INT_D_ASSERT_MASK_AC5	BIT(15)
 
 #define PCIE_ARCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x50)
 #define PCIE_AWCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x54)
@@ -170,6 +181,7 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	u32 reg;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct armada8k_pcie *pcie = to_armada8k_pcie(pci);
 
 	if (!dw_pcie_link_up(pci)) {
 		/* Disable LTSSM state machine to enable configuration */
@@ -178,32 +190,41 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
-	/* Set the device to root complex mode */
-	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
-	reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
-	reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
-	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
+	if (pcie->pcie_type == MVPCIE_TYPE_A8K) {
+		/* Set the device to root complex mode */
+		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
+		reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
+		reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
+		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
 
-	/* Set the PCIe master AxCache attributes */
-	dw_pcie_writel_dbi(pci, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
-	dw_pcie_writel_dbi(pci, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
+		/* Set the PCIe master AxCache attributes */
+		dw_pcie_writel_dbi(pci, PCIE_ARCACHE_TRC_REG, ARCACHE_DEFAULT_VALUE);
+		dw_pcie_writel_dbi(pci, PCIE_AWCACHE_TRC_REG, AWCACHE_DEFAULT_VALUE);
 
-	/* Set the PCIe master AxDomain attributes */
-	reg = dw_pcie_readl_dbi(pci, PCIE_ARUSER_REG);
-	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
-	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	dw_pcie_writel_dbi(pci, PCIE_ARUSER_REG, reg);
+		/* Set the PCIe master AxDomain attributes */
+		reg = dw_pcie_readl_dbi(pci, PCIE_ARUSER_REG);
+		reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
+		reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
+		dw_pcie_writel_dbi(pci, PCIE_ARUSER_REG, reg);
 
-	reg = dw_pcie_readl_dbi(pci, PCIE_AWUSER_REG);
-	reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
-	reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
-	dw_pcie_writel_dbi(pci, PCIE_AWUSER_REG, reg);
+		reg = dw_pcie_readl_dbi(pci, PCIE_AWUSER_REG);
+		reg &= ~(AX_USER_DOMAIN_MASK << AX_USER_DOMAIN_SHIFT);
+		reg |= DOMAIN_OUTER_SHAREABLE << AX_USER_DOMAIN_SHIFT;
+		dw_pcie_writel_dbi(pci, PCIE_AWUSER_REG, reg);
+	}
 
 	/* Enable INT A-D interrupts */
-	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG);
-	reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
-	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
-	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
+	if (pcie->pcie_type == MVPCIE_TYPE_AC5) {
+		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG);
+		reg |= PCIE_INT_A_ASSERT_MASK_AC5 | PCIE_INT_B_ASSERT_MASK_AC5 |
+		       PCIE_INT_C_ASSERT_MASK_AC5 | PCIE_INT_D_ASSERT_MASK_AC5;
+		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG, reg);
+	} else {
+		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG);
+		reg |= PCIE_INT_A_ASSERT_MASK | PCIE_INT_B_ASSERT_MASK |
+		       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
+		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
+	}
 
 	return 0;
 }
@@ -259,6 +280,45 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
 	return 0;
 }
 
+static u32 ac5_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
+			     u32 reg, size_t size)
+{
+	u32 val;
+
+	/* Handle AC5 ATU access */
+	if ((reg & ~0xfffff) == 0x300000) {
+		reg &= 0xfffff;
+		reg = 0xc000 | (0x200 * (reg >> 9)) | (reg & 0xff);
+	} else if ((reg & 0xfffff000) == PCIE_VENDOR_REGS_OFFSET)
+		reg += 0x8000; /* PCIE_VENDOR_REGS_OFFSET in ac5 is 0x10000 */
+	dw_pcie_read(base + reg, size, &val);
+
+	return val;
+}
+
+static void ac5_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
+			       u32 reg, size_t size, u32 val)
+{
+	/* Handle AC5 ATU access */
+	if ((reg & ~0xfffff) == 0x300000) {
+		reg &= 0xfffff;
+		reg = 0xc000 | (0x200 * (reg >> 9)) | (reg & 0xff);
+	} else if ((reg & 0xfffff000) == PCIE_VENDOR_REGS_OFFSET)
+		reg += 0x8000; /* PCIE_VENDOR_REGS_OFFSET in ac5 is 0x10000 */
+
+	dw_pcie_write(base + reg, size, val);
+}
+
+static const struct dw_pcie_ops armada8k_dw_pcie_ops = {
+	.link_up = armada8k_pcie_link_up,
+};
+
+static const struct dw_pcie_ops ac5_dw_pcie_ops = {
+	.link_up = armada8k_pcie_link_up,
+	.read_dbi = ac5_pcie_read_dbi,
+	.write_dbi = ac5_pcie_write_dbi,
+};
+
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = armada8k_pcie_link_up,
 	.start_link = armada8k_pcie_start_link,
@@ -269,6 +329,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct armada8k_pcie *pcie;
 	struct device *dev = &pdev->dev;
+	struct device_node *dn = pdev->dev.of_node;
 	struct resource *base;
 	int ret;
 
@@ -281,8 +342,16 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
-
+	if (of_device_is_compatible(dn, "marvell,armada8k-pcie")) {
+		pci->ops = &armada8k_dw_pcie_ops;
+		pcie->pcie_type = MVPCIE_TYPE_A8K;
+	} else if (of_device_is_compatible(dn, "marvell,ac5-pcie")) {
+		pci->ops = &ac5_dw_pcie_ops;
+		pcie->pcie_type = MVPCIE_TYPE_AC5;
+	} else {
+		dev_err(dev, "couldn't find compatible ops\n");
+		return -EOPNOTSUPP;
+	}
 	pcie->pci = pci;
 
 	pcie->clk = devm_clk_get(dev, NULL);
@@ -336,6 +405,7 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 
 static const struct of_device_id armada8k_pcie_of_match[] = {
 	{ .compatible = "marvell,armada8k-pcie", },
+	{ .compatible = "marvell,ac5-pcie", },
 	{},
 };
 
-- 
2.17.1

