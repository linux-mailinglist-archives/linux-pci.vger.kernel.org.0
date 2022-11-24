Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB34637AFB
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 15:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiKXOCz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 09:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiKXOCa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 09:02:30 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2107.outbound.protection.outlook.com [40.107.20.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960ECE18;
        Thu, 24 Nov 2022 05:59:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNNrGGPzPZr+1uAH0Qa1C4L7iFUhukH+jpIzRakLl2/P9FYL7SQeOb7xiLwHfd4Ji+M8jTnGLcU3t80061BiXAQXyEOYUL4swA601BtRDlAcyVVMpgv2Z4Yaf3YJBoO+rtpf38GGDFbTVUifrdT3tBH+AVdzcUSiQkcy/068ESSL9ACfR2FiTaMEEq4zU25f5ntjSc19xZccyuXvfvjzZ8ifhg4hrtmDSsHllztTdqMwEzeYcNJ0NQT9GIuZICgmFVmYpF5s7bFdYW/HSKRX5vj2sRXR2/Y4iWLUx3DZbTS0kS5XagUk/2VKMzME8Hin6zGUwCcG4lMh6FOORGi73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7396+6ZiFBQD4iMFbUA/ppiHVWn/Lc/v6+EqomZUYow=;
 b=AXSQmEG8q5uhJ+iE6NJrIrwhekWZKDxzgvW8xXKZpJScTlrotkTnL6iJz/ZkKmPtzrZtx9Y1UPQ86Qv+13R5xVvhVComXlg4mc/YBw9ZKp4chfn6yDOqsgpR7EB09tzmq4L33Pf/9qxSfoAAmgky0ApoAFCuMJxsV+HhUcto0bqc/RGOSsb8MTGQPL72qE9Z7jIrtxdFt80CttgwlUzACMBHvvy0DfcQeZBLZ+txPjeJtiA3FuiynX27+A/QBcMoZOKywFzbmZBGt4JGdSbSoVRP68Q25fNCtQ4HGMHeugwPN89L66U/tG2G8Ll/98HcANP/ahtmm65Jim+C7lOxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7396+6ZiFBQD4iMFbUA/ppiHVWn/Lc/v6+EqomZUYow=;
 b=VGyC/Q2DyYUItCCQZwrJJyto3K1zLxzjdVUv6Q6HWscFT2MpswbE+9NLUTWmW0bebxka3XbYsdjKQQ0CQPuASVYVYxfr9Gq2WVe7I9pCL0EAblz1cakWatJD0cT/bu2TcnWWsd8z93/GqF0echc8ltPxDj4VcLlaLc09x4uiA8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM7P190MB0758.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:117::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 24 Nov
 2022 13:58:56 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5912:e2b4:985e:265a%3]) with mapi id 15.20.5834.016; Thu, 24 Nov 2022
 13:58:56 +0000
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
        Yuval Shaia <yshaia@marvell.com>
Subject: [PATCH v2 3/3] PCI: armada8k: Add MSI support for AC5 SoC
Date:   Thu, 24 Nov 2022 15:58:28 +0200
Message-Id: <20221124135829.2551873-4-vadym.kochan@plvision.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 779bcf49-8303-42fe-c21b-08dace24070d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ubqmJQpNQP3QDbkOs+bYzvBRIw60pqOMTVjj0J/GcvKHNl570gLs+vINCScH8k+i/nR2mXE0nqTS6qp58vRr3dKx8RwXXyiNFz2Zd5il//YX/humGcfobYR7ARXDr6bgobTb3JBeTpXnVhjJCLFTMbP8ClGE18ULV9+xgIznSjdwaNwgH6SBEG2DsC/2JkvhuIIR53Cf1t3WjJCHZ7xtSegzQO5N1+1HzPl4fPz3GsJghmov6Joi8VzR2AoPbkUXVc+jFi9VMiA+lcGgiLfDBHTkMGWKY2IFVvT0BXuVBszi9AeloV9+awJkrSt9Wdrrtyu7HRW4rxAV0Cr2gF9v+Z+5BPr630wxEz5oQVGNMwD0DTHS4nuxbUdXH3qZu8e3j/LgxiDzOAHqzcZRFbOQIGdsvwpEqg5ouUJbnTN+Fnqo4dXsWgK+v9tvzn6SwbsF+FYzgM6FfFu+EGTGh4ECLosrrXtawQMhLjt7HVxYzaodmnM23tS1VMyd7A7D8IecAFSOg8MCyHAeXztngPXyBma/92xgoVQEiu5nDn8+iwJ4D363npT+Uei2Lv1NUIffsXktOk/k5W4fIB7Mo9FmCC5Leupi6Veo0j7cYIX7l3nNIyUWLmrFOobwb4TryC82sbtgyjuBqiR1hTFrJQ10tdfa9kybsoeFAPD1guQAK0yFgvP7IPVhnua97N5mwWMiZWp8BNg1YhndkA6xLba1Kt7p29OmUc6ySQXt7/ZDU8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39830400003)(34036004)(366004)(346002)(396003)(451199015)(1076003)(8936002)(36756003)(83380400001)(2906002)(2616005)(41300700001)(44832011)(5660300002)(41320700001)(86362001)(921005)(38350700002)(38100700002)(6506007)(110136005)(54906003)(186003)(316002)(6666004)(52116002)(26005)(6512007)(7416002)(508600001)(6486002)(66946007)(8676002)(4326008)(66476007)(66556008)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jT9o6Icc5JjNxVYmz9Wu0qTWQxpiTKb4onx2/brrnWbMh74wWw7MTeOvCyoh?=
 =?us-ascii?Q?T2bFlQgngx5uHZi3YcRDifCe//WpMLniKC9aV4fWR4jrMU5tqnStN+Qv7HgK?=
 =?us-ascii?Q?XEdAbj7MpzCsqI5Bw9ywdFsSFWQ16QmkXB68smyYflX6i9O73SfuuVOVshy+?=
 =?us-ascii?Q?6hC4ADErwem0+Z+Q+HiU0OPCtPhOFkz477e14NcEjVKWQSyDn4vpESHMYH1W?=
 =?us-ascii?Q?iZSlB9NgSSyy1+P3OBWBoOUQUhPHN8KpDN/F4k2jFZNRaAbSEQPt8qKfORsT?=
 =?us-ascii?Q?cBC+K0QqncQ8rSBhap381pJNdOrbpZDFbHH5nH8JVMliiA/B2htm6MuwkN+H?=
 =?us-ascii?Q?u7VSmYnpNBGq+D4SFGkMetPeBOBf16MtcDj2+Qaa0VEAclXJVOL5jV4JoVUj?=
 =?us-ascii?Q?qBvTabRzAdmt8KHHJGHsw/9jdNxnjHUVNbOeSeSORjz6RXyrf7opw//gLhjq?=
 =?us-ascii?Q?PFBGQaR/K3jubShQnXjKqltbguyZEbK0bRCp2IZqkch+2XOm3oFFa79ofVfY?=
 =?us-ascii?Q?iYQNbDCp7qV3oxsgf1X/IA7USdurUINrMAprp5l2tYfDlexRsFo9ApN+SEVy?=
 =?us-ascii?Q?e9qfXbiEhpuy/w3FeUfL3WAtbjR4fiPGpIJnd4/Tg2UMtZ6Nmth2W4hP0wCu?=
 =?us-ascii?Q?zC8FZSR/wzu1D4mB9RYliprgVps2WKKQJphfffd2f6RjcJnRkWMI8p+k3iYe?=
 =?us-ascii?Q?ejI0zqG9PvWJIyh28+afi7K2l/oOBREQn03U1/yUcl8DzK9nXsyVsyQAcS9v?=
 =?us-ascii?Q?rtoD65kUVFUTm9/jdBKK+68FMxeklSRSSkDTwp1PrK2mJV6dx46wXCLUlPj3?=
 =?us-ascii?Q?6zKvlGA8hi7dd8pKYEAoiry0sA+QOB4+r2Gt1xigHzsqkjHBjQD2angHWWBl?=
 =?us-ascii?Q?4Q17wu3uSNegKvoilI+3SuhYkCb/ffMe4Dov8VQk8OG0RahlN3ZjwXXoO18u?=
 =?us-ascii?Q?9ZO7XFHk95FH4CcrLPg0DyThEqUyS2dTaNlwYOFKDWNiK8mzb10LQALQaOI2?=
 =?us-ascii?Q?PnNfgFxXgNWqIfTnlC7JKlNHR8qWZwhxrPodBXniKACRWVw7jyW7kS5W7JOH?=
 =?us-ascii?Q?inMmrQY9b1BUPEVr8YKcQBVp0R3S0i9BCvFiw+Um66C+E5rL+rrsEpO+k81f?=
 =?us-ascii?Q?fxRrEXGYsVY5K3+6Ufuqry1PgyFQwGu8XI7y4FC3q5oGaREwmnXwOqDP5w9j?=
 =?us-ascii?Q?7ptp3Eo238prnZv3gOKAyBg8rg2PPasiLxZUE5ETmsHnsQEoRUa3UxtgtKSM?=
 =?us-ascii?Q?mh0qkTRR8jApd9wwv+8ExJhTiiz/zmioyPPM2MC8PgSlSS3zAF/B9gHynDTR?=
 =?us-ascii?Q?0lGPOs036J4GCw/jlCyYS9x0XbOZFhyMCterUu4bxUo/gAa2WprFhsh37vi5?=
 =?us-ascii?Q?Nl4a+eMtL/9vrFMkGRfvbTSTdWCetHz8dRgHgOof5uR5l//kA42/f3e/DA+J?=
 =?us-ascii?Q?lFCSEqxKDK+y0X1tLFbVwMEZrEjiZt4vDyi29og1W7ToQh4+JcHOsRWV68cw?=
 =?us-ascii?Q?4onwop2hIBnU3u0xGc8maYTsP8FQfYOIpe5iy00vat24C0ku/7pehGFifQb1?=
 =?us-ascii?Q?hoJWXMnHlRgpCI3lxSBRhq19ytWDycQvnb9XMYzfZU2IEXGHbcuPZLwyCbDv?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 779bcf49-8303-42fe-c21b-08dace24070d
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 13:58:56.6488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xKOD06exHN/wcvrRXOotE+/jRWNYF7LzYZtcYDrWoSfvz6iTaO5JT3wNQtu+Tbm82/YBAnV7sXxRW/eVII1Cxj+C2cfXrnBdUoRcjQ9tfGs=
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

From: Yuval Shaia <yshaia@marvell.com>

AC5 requires different handling for MSI as with armada8k.
Fix it by:

1. Enabling the relevant bits in init phase
2. Dispatch virtual IRQ handlers when MSI interrupts are received

Also enable/disable PCIE_APP_LTSSM for AC5.

Signed-off-by: Yuval Shaia <yshaia@marvell.com>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
v2:
   1) fix W1 warnings which caused by unused leftover code

   2) fix type in "requieres" word in the description

 drivers/pci/controller/dwc/pcie-armada8k.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index bbe9a1750d0d..7e02eddaeac0 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -50,6 +50,7 @@ struct armada8k_pcie_of_data {
 
 #define PCIE_GLOBAL_CONTROL_REG		(PCIE_VENDOR_REGS_OFFSET + 0x0)
 #define PCIE_APP_LTSSM_EN		BIT(2)
+#define PCIE_APP_LTSSM_EN_AC5		BIT(24)
 #define PCIE_DEVICE_TYPE_SHIFT		4
 #define PCIE_DEVICE_TYPE_MASK		0xF
 #define PCIE_DEVICE_TYPE_RC		0x4 /* Root complex */
@@ -69,6 +70,7 @@ struct armada8k_pcie_of_data {
 #define PCIE_INT_B_ASSERT_MASK_AC5	BIT(13)
 #define PCIE_INT_C_ASSERT_MASK_AC5	BIT(14)
 #define PCIE_INT_D_ASSERT_MASK_AC5	BIT(15)
+#define PCIE_MSI_MASK_AC5		BIT(11)
 
 #define PCIE_ATU_ACCESS_MASK_AC5	GENMASK(21, 20)
 
@@ -172,6 +174,16 @@ static int armada8k_pcie_link_up(struct dw_pcie *pci)
 	return 0;
 }
 
+static void ac5_pcie_msi_init(struct dw_pcie *pci)
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
@@ -181,7 +193,10 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 	if (!dw_pcie_link_up(pci)) {
 		/* Disable LTSSM state machine to enable configuration */
 		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
-		reg &= ~(PCIE_APP_LTSSM_EN);
+		if (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5)
+			reg &= ~(PCIE_APP_LTSSM_EN_AC5);
+		else
+			reg &= ~(PCIE_APP_LTSSM_EN);
 		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, reg);
 	}
 
@@ -221,6 +236,9 @@ static int armada8k_pcie_host_init(struct dw_pcie_rp *pp)
 		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
 	}
 
+	if (IS_ENABLED(CONFIG_PCI_MSI) && (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5))
+		ac5_pcie_msi_init(pci);
+
 	return 0;
 }
 
@@ -237,6 +255,8 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 	 */
 	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG);
 	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG, val);
+	if ((PCIE_MSI_MASK_AC5 & val) && (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5))
+		dw_handle_msi_irq(&pci->pp);
 
 	return IRQ_HANDLED;
 }
-- 
2.25.1

