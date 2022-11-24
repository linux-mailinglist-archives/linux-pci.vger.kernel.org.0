Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C26637AF7
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 15:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiKXOCc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 09:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiKXOCL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 09:02:11 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2107.outbound.protection.outlook.com [40.107.20.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAA016FB1F;
        Thu, 24 Nov 2022 05:59:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nucxy/mz8eXz5W8+EinPzQFOfK86gO6oAnsQMaWC9dX+25NvCLzcj16riX+RNmyRM29irrAH7mhrVKQq/gF2QfKC6ao4OCcZRpSDz6BtRv7wtM8S+OOH/qneFnxac/8IK9fL5t6O3DZDiwLz8cacthSrdZF+UXG2PPG0jzY6SVULHbzvlpkkvEYvMXqAHB+ZS5U9UihtryC5fGr/mEBHuLLQ9ARryeLa99GO/BeyZn1ggOgaJiyJUCnyTKY6FjoGA9eR/+sASk9xI192KTvjUv8/jQI0MS3fhiRMoRHOfycOYcO3EM7GOZRQ5gPXMsTNyCDx2CH8HfQnfyOyTqBzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7cylRnsRpLgxyddXHbnBWfHlJkqnior12AOdMfj4i4=;
 b=SZBEZBE+CSGxbq/lIPg9blTof0yKvpMVDWRRE2A1/rohCDmlVrgLkqzNGMZwGD2oITKOLqaiOwV05ArTmgPKSubyBGpFPyxwBflCKbI93tH0kHHebpcGWp0L53nZROtO29ULgYfI3kw60AkuOOGSlGGIowtaK0n04RZGKH+3XW8foxCA+RguiSEW1GaJOn7NgCfYqtQRja/X+oiKrY5spl9xeRRFyYuhG5vDlToGv6VB3wifNoryIlFXfDxUeCXGK1Os1KF4Lyd0UZvrHuvJfaNNtpUJcq51Bh52KEPy20Zk4opzLBdyyqWQABUH8wf5cjTpvTbE3wa6QNlssFcD9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7cylRnsRpLgxyddXHbnBWfHlJkqnior12AOdMfj4i4=;
 b=ZjKA5tvaqt/Psx/UKBmejQ8AB9WeqR3ie4i64C6wA9fqTai4HB7afFgkJNrv5KYq1WxD6463oYMbkJiNLzIuP4UOGIE6Kk3vEK0evQeTKDeCSrMl2AyYYloRcEZPY4QzdcTNkmVuF0Rr16fOUaP/2RWtJde2ilGpLQ+to1+gknM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM7P190MB0758.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:117::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 24 Nov
 2022 13:58:54 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5834.016; Thu, 24 Nov 2022
 13:58:54 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Raz Adashi <raza@marvell.com>, Yuval Shaia <yshaia@marvell.com>
Subject: [PATCH v2 2/3] PCI: armada8k: Add AC5 SoC support
Date:   Thu, 24 Nov 2022 15:58:27 +0200
Message-Id: <20221124135829.2551873-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124135829.2551873-1-vadym.kochan@plvision.eu>
References: <20221124135829.2551873-1-vadym.kochan@plvision.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AM7P190MB0758:EE_
X-MS-Office365-Filtering-Correlation-Id: 29010f78-bcd3-432c-ce1c-08dace240653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Gbq0uQ0GBzA+anYKIYfMH63IaO4JKOFzVkJVm33PuxTX6FwwpGBlnlxXhHFIbqkW6mOjFZqxhBt58oovKoCU0XgcyvP5cG4TNDiUfyfVfMWQU+tJtHhv2ucNgK43ZUKiX+Zoq98IBD/DKwnznoh4ji4FgvQxWEb49V8Fsjz3ySwi6KC6MS2v0jg0al1r4vpeafE89GKzX6kW8hDK/Lvg4mx6RR8j02rlfQ4y86UVHgKXDiRzrzSpOiPxUSKrSHfW5hZsri0RBnwFCoiiNXaOOktJ6kCCa8GVrobJFj23HfveEECggU41CIRsFDqD2JhtRycZuspR3Nf62hEJvcwO8BS/ffq2B7l70dS9uZW1nF+c/bE2m43xfezEkq750uNIWj9NzbDnYjkvUFASZR9mEtruBWniu+u/Z6N2BXmCJ96jh0sg7TsrHPfeCuM6gzeJ+0gBB6fOx8Y5oijyUp7jdNRuQqZjCP5+ate26Md06dG4qH3RMf3gz/XpeqweqACW3cB67CrXKFcDNNZJzn3K/IBcQL18Bq2POsAqqqJij1F22l0eLIwjqJ/6BFX586NJa3bkdUfd7DpZpccxAinKX32DNVTirkrL67aoGOgoKM2VjBqHIRwKeD3uERKsuV09hR1i4WmfPg5fNXLQ1+Y27oissfh4WOTcaxutH18Y9tqAV4E3w+paEBQeZubjcKsUUuJHGVkFxh6cPVRATeAayJoXoruFl94b+QS4VH4beI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39830400003)(34036004)(366004)(346002)(396003)(451199015)(1076003)(8936002)(36756003)(83380400001)(2906002)(2616005)(41300700001)(44832011)(5660300002)(41320700001)(86362001)(921005)(38350700002)(38100700002)(6506007)(110136005)(54906003)(186003)(316002)(6666004)(52116002)(26005)(6512007)(7416002)(508600001)(6486002)(66946007)(8676002)(4326008)(66476007)(66556008)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XjU8RDiPQHCdi3l9hhfHqN3xS8n6YzRkV6hQE/tSShwOLMNW+nirPv5rOQBa?=
 =?us-ascii?Q?W7epBTXRYq9pKH+FqXKmI14qHO6TrNC/X49W+JoS2hlH3ceO2xqzAecsV4k2?=
 =?us-ascii?Q?ykM8tOxFD1J6rpf996mJz3FK60qSDeleSlR0lzcSTQRfpC9BSyQa67+2y803?=
 =?us-ascii?Q?jGqt527ZrVat3pIJAjcyuDOO6TVT7Q4CF2g1dOf3q+F4x4MQUNBonuJGityU?=
 =?us-ascii?Q?cOdm2xah5e1CQn4wWOSBnTDEJfGzW4+AypZM9KcBeoe2q+mu8tefyi9/faGo?=
 =?us-ascii?Q?n8xJoy0HTdUGLTWqEwUhKG4tJslhQa5+qnHodMm5Q7Lj8dECkuu5DdbTd3MB?=
 =?us-ascii?Q?SE/qpRxFMpM1r3Ay60DPeu4vK4XL3r8/W3gVtT1MlWuh+J61xLqFkEcGQAcl?=
 =?us-ascii?Q?kYUw7Qp3z3K6FsHCy3VJ78beZ6lDs4kl/HaKAhyV4pVnVseJbJOBSGPVffd7?=
 =?us-ascii?Q?2V8RkZ7uiyk+UEPXq1rPsvnVyCsnxMFjaJFKnJOgHvNtnUHJiRmg735xILsZ?=
 =?us-ascii?Q?IUhaJGxqCr2htQmDJZP7xB0IPpQ9ex5NVbJM6NONVHomKIGKTDnBTA21+0dD?=
 =?us-ascii?Q?uTi+s2tQq98hIzL5Vm8RpZx5V2d8EofVskTqBJ349v6rkarxRZMA3Yz1tM05?=
 =?us-ascii?Q?4SlY4Q4DkufhuOcCMOGgA2+toPpaXUT2LEjtgYSrVvFU8yL6X4EkOCD4rcwC?=
 =?us-ascii?Q?HxGO8Ut79oifBWfM5xK/t8Vs8dZF/1wIDNnxyVy3a6pAuOC0292G2Cyo9ng6?=
 =?us-ascii?Q?yzfHGPD91xPpOqgg0du/SmmBV6JCdnV+/mw7vgvQSvueiJJmOmr6Xg4DWGfS?=
 =?us-ascii?Q?5ULYgH13XPKh4sHx4raGyAZIjm0tixrnNt9VB4iuSld6y1QdXfB2SMdnZa22?=
 =?us-ascii?Q?HUevY4tfdt17uUjkyBUfDFf0uV6+ArB4H0EU8lCNdRvEMiQ1+FvBEAWdPC++?=
 =?us-ascii?Q?sp3FU08/R0zO9lW/BjhMgfxFdnAMGDPaftCh31PU0veBy22nOsxZ9o2eu7nb?=
 =?us-ascii?Q?+QIW+HE5SdotwaMonEeM8LUsqUINkFTpImGKGo8ZOrod4RUcK7xtccBkSOb/?=
 =?us-ascii?Q?OxYuFV3115Fbv8tvE0tkQFOx+L2pVnWSYCh4BLw7iE664kR+tNr8VGYyE7Su?=
 =?us-ascii?Q?Dw/0zD8bM0QOBhxs1DE0xAg3hcHqZZzWsQUmceqKfB4dg4EIy7rc5DnplQgv?=
 =?us-ascii?Q?QhcxsJ1aXGM/5il/1WvBSsmDNhDGoz/RrKSZl5/gImH9IcA6Fnoixranz5fA?=
 =?us-ascii?Q?RRh2EzPEY3QGHztdUiOj4rAmq/coc6Xx0louW+bxXBvBmu8KJtnV04cLeUs4?=
 =?us-ascii?Q?WNinZIzjY4C1fLbQvK00L2mnhleMF13jCLIXW0mHTRC7AmhFyzQAFlG0CoFx?=
 =?us-ascii?Q?9QYUzx+kFCO66YTZfODkAFvq0vbQTP4nvMc1o03bjSt6CibdL87wC9AbCHzi?=
 =?us-ascii?Q?qobmu2QnI09Yp2N+Om5fNF1ORlyiOduqrYhlEd0DQrWA39pGD1zfU0QBkciU?=
 =?us-ascii?Q?uCq3bNM87BGNdWLsuKjARFpTuQ3Y2XakNaY9l8MP/sfH/m6dCqExR3g7NnB8?=
 =?us-ascii?Q?Rr51Ld7BvNwjZQ9SqE/yp6mMcDwmNbITvxqdQebBhpRYnpoLkrohYf9Vidpo?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 29010f78-bcd3-432c-ce1c-08dace240653
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 13:58:54.7740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OtuIh/UkBizsyZ97i68/aAtIPdurpoYDHjawOBcF0NBpXuQSDGBlh0sfRqqocxbUnAPdx1OCAk183ZbdFagjGq4Q/QZ+MRnEyeql4cWlPTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0758
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Raz Adashi <raza@marvell.com>

pcie-armada8k driver is utilized to serve also AC5.

Driver assumes interrupt mask registers are located
in the same address inboth CPUs. This assumption is
incorrect - fix it for AC5.

Co-developed-by: Yuval Shaia <yshaia@marvell.com>
Signed-off-by: Yuval Shaia <yshaia@marvell.com>
Signed-off-by: Raz Adashi <raza@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v2:
   1) fix W1 warnings which caused by unused leftover code

   2) Use one xlate function to translate ac5 dbi access. Also add
      mode description in comments about this translation.

   3) Use correct name of Raz

   4) Use matching data to pass the SoC specific params (type & ops)

 drivers/pci/controller/dwc/pcie-armada8k.c | 157 ++++++++++++++++-----
 1 file changed, 119 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 5c999e15c357..bbe9a1750d0d 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -26,15 +27,26 @@
 
 #define ARMADA8K_PCIE_MAX_LANES PCIE_LNK_X4
 
+enum armada8k_pcie_type {
+	ARMADA8K_PCIE_TYPE_A8K,
+	ARMADA8K_PCIE_TYPE_AC5
+};
+
 struct armada8k_pcie {
 	struct dw_pcie *pci;
 	struct clk *clk;
 	struct clk *clk_reg;
 	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
 	unsigned int phy_count;
+	enum armada8k_pcie_type pcie_type;
 };
 
-#define PCIE_VENDOR_REGS_OFFSET		0x8000
+struct armada8k_pcie_of_data {
+	enum armada8k_pcie_type pcie_type;
+	const struct dw_pcie_ops *pcie_ops;
+};
+
+#define PCIE_VENDOR_REGS_OFFSET		0x8000	/* in ac5 is 0x10000 */
 
 #define PCIE_GLOBAL_CONTROL_REG		(PCIE_VENDOR_REGS_OFFSET + 0x0)
 #define PCIE_APP_LTSSM_EN		BIT(2)
@@ -48,10 +60,17 @@ struct armada8k_pcie {
 
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
+
+#define PCIE_ATU_ACCESS_MASK_AC5	GENMASK(21, 20)
 
 #define PCIE_ARCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x50)
 #define PCIE_AWCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x54)
@@ -153,22 +172,11 @@ static int armada8k_pcie_link_up(struct dw_pcie *pci)
 	return 0;
 }
 
-static int armada8k_pcie_start_link(struct dw_pcie *pci)
-{
-	u32 reg;
-
-	/* Start LTSSM */
-	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
-	reg |= PCIE_APP_LTSSM_EN;
-	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
-
-	return 0;
-}
-
 static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	u32 reg;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct armada8k_pcie *pcie = to_armada8k_pcie(pci);
 
 	if (!dw_pcie_link_up(pci)) {
 		/* Disable LTSSM state machine to enable configuration */
@@ -177,32 +185,41 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
-	/* Set the device to root complex mode */
-	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
-	reg &= ~(PCIE_DEVICE_TYPE_MASK << PCIE_DEVICE_TYPE_SHIFT);
-	reg |= PCIE_DEVICE_TYPE_RC << PCIE_DEVICE_TYPE_SHIFT;
-	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
+	if (pcie->pcie_type == ARMADA8K_PCIE_TYPE_A8K) {
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
+	if (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5) {
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
@@ -258,9 +275,59 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
 	return 0;
 }
 
-static const struct dw_pcie_ops dw_pcie_ops = {
+static u32 ac5_xlate_dbi_reg(u32 reg)
+{
+	/* Handle AC5 ATU access */
+	if ((reg & ~0xfffff) == PCIE_ATU_ACCESS_MASK_AC5) {
+		reg &= 0xfffff;
+		/* ATU registers offset is 0xC00 + 0x200 * n,
+		 * from RFU registers.
+		 */
+		reg = 0xc000 | (0x200 * (reg >> 9)) | (reg & 0xff);
+	} else if ((reg & 0xfffff000) == PCIE_VENDOR_REGS_OFFSET) {
+		/* PCIe RFU registers in A8K are at offset 0x8000 from base
+		 * (0xf2600000) while in AC5 offset is 0x10000 from base
+		 * (0x800a0000) therefore need the addition of 0x8000.
+		 */
+		reg += PCIE_VENDOR_REGS_OFFSET;
+	}
+
+	return reg;
+}
+
+static u32 ac5_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
+			     u32 reg, size_t size)
+{
+	u32 val;
+
+	dw_pcie_read(base + ac5_xlate_dbi_reg(reg), size, &val);
+	return val;
+}
+
+static void ac5_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
+			       u32 reg, size_t size, u32 val)
+{
+	dw_pcie_write(base + ac5_xlate_dbi_reg(reg), size, val);
+}
+
+static const struct dw_pcie_ops armada8k_dw_pcie_ops = {
+	.link_up = armada8k_pcie_link_up,
+};
+
+static const struct dw_pcie_ops ac5_dw_pcie_ops = {
 	.link_up = armada8k_pcie_link_up,
-	.start_link = armada8k_pcie_start_link,
+	.read_dbi = ac5_pcie_read_dbi,
+	.write_dbi = ac5_pcie_write_dbi,
+};
+
+static const struct armada8k_pcie_of_data a8k_pcie_of_data = {
+	.pcie_type = ARMADA8K_PCIE_TYPE_A8K,
+	.pcie_ops = &armada8k_dw_pcie_ops,
+};
+
+static const struct armada8k_pcie_of_data ac5_pcie_of_data = {
+	.pcie_type = ARMADA8K_PCIE_TYPE_AC5,
+	.pcie_ops = &ac5_dw_pcie_ops,
 };
 
 static int armada8k_pcie_probe(struct platform_device *pdev)
@@ -268,9 +335,15 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct armada8k_pcie *pcie;
 	struct device *dev = &pdev->dev;
+	const struct armada8k_pcie_of_data *data;
 	struct resource *base;
 	int ret;
 
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
@@ -279,9 +352,10 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	pci->ops = data->pcie_ops;
 	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
 
+	pcie->pcie_type = data->pcie_type;
 	pcie->pci = pci;
 
 	pcie->clk = devm_clk_get(dev, NULL);
@@ -334,7 +408,14 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id armada8k_pcie_of_match[] = {
-	{ .compatible = "marvell,armada8k-pcie", },
+	{
+		.compatible = "marvell,armada8k-pcie",
+		.data = &a8k_pcie_of_data,
+	},
+	{
+		.compatible = "marvell,ac5-pcie",
+		.data = &ac5_pcie_of_data,
+	},
 	{},
 };
 
-- 
2.25.1

