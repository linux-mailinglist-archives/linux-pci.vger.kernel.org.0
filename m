Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF8E4B55DD
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 17:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344339AbiBNQPk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 11:15:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiBNQPk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 11:15:40 -0500
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2091.outbound.protection.outlook.com [40.107.24.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2876FD48
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 08:15:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2tWWtjSHLK8KJHYorzzzFVMGHKnOK/aDv7sBhPLAHMvhpEJFu4tZecSrF09Q+jpg/rFIrwhsmfYEEo4hwjEV5zOTJEsi3hPxI/dIh7wu0I87+Pd8S8c5WUGy6yA1vkdfVyeIR3VRN7d4v9IwZ27ldrRFulmfWchD9NqhMBwgIHSbP6ob4Z/M+enEB8uObKTKYlxle7ryNFV3w+fzG4gntJxsJBFlwo9t9KTq54xtHQgiLpSRG47Rur8TsOtAL7WsmkXcYUSYDr3e8m5uv15h4GEDacnVy8ier1hfdU4biLm4plshHZTAboAuePWCiATxzjV7yo5LlYTgIJiFWoSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYZFzmtBoOEajSfuVoadkl121V7GgYuROLfTE12ScNo=;
 b=jKNKlvgvYMQxLHo76XzlbtWXzdH3y1STgMRm/THwzSoNNqd78E1/ew9x4ZGjsObqozpi+gfFj/ztyPBssOhGTt0HKC9XivveB1VK9/pxTxG3l1xdYBMyNH5f2vl64TL70voJwnn4egT1oGrxPdaEovAnUb08eXsgVpZokjqR6NBqhXQZ4B9pU8hesRVwZTQY+GEGxetM2/XdOJJrV5/dirKUtGmzvU27Wq1Xu40xU07fWOOaXr3mP3q6GJ6MRdW8QdyBG/uqsvWzZaMl3MJ8GnfVKS25WXL1HwkkfbX92mmW/lqS6wnv2wQLCzZQB8AJAL8uUdfha4cPM7c4M9OiZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYZFzmtBoOEajSfuVoadkl121V7GgYuROLfTE12ScNo=;
 b=Y/m+/FkEUSZd0iaNG3tuK2LXOzDzJrYsjOBXEnmvkM9joV78y34U0+UD+BH+9ATQbMZ0ohxk8jeagoUapeLi+MEaJ5pIwi0E9S4Krv4aeq+clVo2oqPT/A05jYrqGZAxsYH0adzEZTf0ginivVfXCrDTI/JhtPVRq61y1EGPXfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by ZR0P278MB0313.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:36::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Mon, 14 Feb
 2022 16:15:29 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb%6]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 16:15:29 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] PCI: imx6: Fix PERST# start-up sequence
Date:   Mon, 14 Feb 2022 17:15:22 +0100
Message-Id: <20220214161522.102810-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVAP278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::12) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c4cd423-fed6-41b7-7712-08d9efd537d7
X-MS-TrafficTypeDiagnostic: ZR0P278MB0313:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB0313A4A5F63921FB21FFA87DE2339@ZR0P278MB0313.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3UG6QUNGfgNYY6YyqG/Ius/AleL3aSJft33D6dLXNgdtF8FJp5uPdmk60DCKPqOiQNLWTEUHqywOAVRRaWvR1TrVXP558BKI2mvDnbGQpXuV+W5aP39J5/SFAptuu3elvVccPzrzf6QWV1cN5bJLfSrsZFwPzsulL+93yZkkevDq5J1xfIj2XGGBpX8Arz0Wh0ElESyzsgzAgyAXmAwVukpdPB1QGes+UR/UmrLaLQM04xPt/LpuZuFnYpkvb//EigKyr4qvrjX6wBtHD3ZAm9tftCo0xTmVX+4LsCC0YKnaj5Mm50GE8lEIjFt71aqs5/3MQDbK6YNWK1a/8+jRcYVOTa8TPis+hHUD5pJzyMD802lUltRfdLQGzGAnTVl4tUvQKT7Uzgs6OnWfrnKmffqP/1misbCfJjF6004I7kDXRWnxxddYhYbXeXthy8oon6kZuwhTA8eGza+dNKTiTgB+Wjf8IoQ6iwrxUNSRSdTvy0v/NEzWcYKv3swXpUFjS3zjJHsDK0BQixNsmqJSwVUYlOoAptOXuxgPRts1sfmYcd2k1dmHnRISQbWAtJ4rP/n7hlPZNg2SOawxk8RWPsdajW+xDVJOMYh4jV94IcPIDS1pMjT57oluhZ6OJIWwyVjhl2QiIMSRgE00sgjRJvbHSqVfkJp8pIgloUx8dek2Qz7dXBqe9uPpWjBxSjpojPMyonABHWlqeZdBNCrFMRzDB2WGgxeLTZsFG0pSnA7tb+C+J9rXD4X3gwG2V6qs1yBH0oyPtb7b/kfbGydU3j9SOMFy/xDbbCm1XrjWKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(2906002)(5660300002)(508600001)(7416002)(38100700002)(44832011)(38350700002)(6486002)(966005)(6512007)(110136005)(6666004)(52116002)(6506007)(54906003)(8936002)(316002)(66476007)(8676002)(66556008)(4326008)(66946007)(36756003)(186003)(1076003)(2616005)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?03nRd875vYSqW94gfKD+Onnpixet0afznLRu6z4/Hud2nd7gFOoW07ICF9UR?=
 =?us-ascii?Q?TndTIf+goK/41LtKFrN72AzPldYYEpnD6v1omZgbZ8MMPvv2+xUXPDHgRTXp?=
 =?us-ascii?Q?EFYeOK+88bnmXguMuGijPm+8krabzvnbniF1dDHrFXIbo+M/nVYe6hMhmti8?=
 =?us-ascii?Q?FWShqgT2zo02QtLmio4txtd29KmB/9G2E3trA+sV8xp71hTDn4U8zPYP7VbU?=
 =?us-ascii?Q?MyRuo5s5I2MXBD0DtoT3Sbo/oUyeAXNw9IE4Z3WIREHf99lVDiYFdYzi3QIu?=
 =?us-ascii?Q?DF99uo5VGt56yZCs2SJPs6XI+REtkjxLwl6Ob158CvqwNuqzyP6HDMVxKOWP?=
 =?us-ascii?Q?vESWEKAmdOwVR3Wt/qlZUY4MlwNpxd6pX61UcsFHphGaQxfLAV8IiSaT/P6r?=
 =?us-ascii?Q?vPMB4lA2vf1KLFHVzKVQhe6d39X8w/dv0jSkQc4a1G5RClBBeTGfW8OxhY0q?=
 =?us-ascii?Q?URUkdq8FzcgqrXU8q/9UUIXb7EZ367Ve3ylxMJOU/MVicez6k4s+Q0YO09WU?=
 =?us-ascii?Q?6wEfjgV8EtesHxPrYARMI/5ItjqFSrmsFx9+woLR775D7j9L4yw/Np/32tkE?=
 =?us-ascii?Q?Rrnhn/GLm44629ZgNvGF/NOrE6ShmPE/XcAiDCAKRPSKHiWAv7dVFzd+6wMc?=
 =?us-ascii?Q?7CWc1ELib9Qva2ZR/PE/VxKKubGQxXDGEKIDNHagkEc8xq9P7WkCIZ1UR560?=
 =?us-ascii?Q?CPHJLABrg6rpbMkZs0EEs1v6JDVmvHAaSFwhkg5QWdHItqUHzv2jGvBjcx0N?=
 =?us-ascii?Q?X6jleDe1jJd2SRWE51ZWMPGVYtlLeoQj7xPkZVtD9hsxIm0HU84giPYDgcmX?=
 =?us-ascii?Q?PWMvOsMUzS7+T9BAbo9Mua98O9gHQtuCoS1XrxXRCl9g27tdlgjP0BszC9uT?=
 =?us-ascii?Q?MmR6AZLwfT0I2b7VcEg2pqdiHBUfwTFlwe7Smc0rg/l2L6jc9dYaUWi9AGEz?=
 =?us-ascii?Q?t5FjOmBtgKzcAbt69i1qf8pmDNZUkn62u3sqOzbazMUuVIFLQbiKaPejzbYF?=
 =?us-ascii?Q?LTbxzASEITjZ++GDtVabwLd9lOlcIGcXDc7e/Rq5qnQcYRAHXNJeXoS9u4Hq?=
 =?us-ascii?Q?VRKfNIO0FMY6X11QnEhy+80g2OCvhZlu+ioCByNuP/38caeBGMWUrkMIOrEv?=
 =?us-ascii?Q?8a6g535dsKAyylx3OILAc+7GYlG6/xSeEe20HL3rj3vc/J/3GKZVF3WwtIkB?=
 =?us-ascii?Q?o/klzkY4aOL33vOFdH795h5dei5vSa5bbHbH8DM+3H8anLI6+2JiV9RipyUO?=
 =?us-ascii?Q?YGgNVr+P2uh94k48PfrbLCk+4ZutbSHwQVCfWrWQAFWdVDw0WMrzvSH8qnJe?=
 =?us-ascii?Q?KsRYIR1KhJm4cupl9B1Ymq8KrTepxTML0E3oaJXEWubMtpFJYR8w/AXVTBFu?=
 =?us-ascii?Q?XB7ArB3vSE4DouOGm/0AKEC+Ykg82a+HE9Djy2vaeTqgpcptlxuvc94iGwCU?=
 =?us-ascii?Q?fIzhcmoDhep0WoVVGHsPLqKfZEwKyCHFbS/Utl5gK/yFWGBEXNitsONmEPKp?=
 =?us-ascii?Q?ZGAUMfo5N8exbmi9O8olOpz+QUc75zkDRJWhg9+pCSdRzJti2QW93yNvvA5V?=
 =?us-ascii?Q?XWkymK3UWTVb+6dZpYiCFxAGtO00E7Pqiq15vsa87IgBrqG5T/ZhzA03lrET?=
 =?us-ascii?Q?Zk1w2Y8Ip25qIynpvnt1u4dNTkIMt3Du2murP8AjIfd1ftOsO7QxiXh8P8EJ?=
 =?us-ascii?Q?OTn36g=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4cd423-fed6-41b7-7712-08d9efd537d7
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 16:15:29.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6DeUGrf8Dl9gcATTYVR6V/qVsaSG1Mix9OYndTB3PUz1hv4rFw1cUv4blyP7FNyLB/Xu2ZO5aPsS3G0sPsPejWDdtC5K5uYouDTN9Mv3hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to the PCIe standard the PERST# signal (reset-gpio in
fsl,imx* compatible dts) should be kept asserted for at least 100 usec
before the PCIe refclock is stable, should be kept asserted for at
least 100 msec after the power rails are stable and the host should wait
at least 100 msec after it is de-asserted before accessing the
configuration space of any attached device.

From PCIe CEM r2.0, sec 2.6.2

  T-PVPERL: Power stable to PERST# inactive - 100 msec
  T-PERST-CLK: REFCLK stable before PERST# inactive - 100 usec.

From PCIe r5.0, sec 6.6.1

  With a Downstream Port that does not support Link speeds greater than
  5.0 GT/s, software must wait a minimum of 100 ms before sending a
  Configuration Request to the device immediately below that Port.

Failure to do so could prevent PCIe devices to be working correctly,
and this was experienced with real devices.

Move reset assert to imx6_pcie_assert_core_reset(), this way we ensure
that PERST# is asserted before enabling any clock, move de-assert to the
end of imx6_pcie_deassert_core_reset() after the clock is enabled and
deemed stable and add a new delay of 100 msec just afterward.

Link: https://lore.kernel.org/all/20220211152550.286821-1-francesco.dolcini@toradex.com
Fixes: bb38919ec56e ("PCI: imx6: Add support for i.MX6 PCIe controller")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: Add complete reference to the PCIe standards, s/PCI-E/PCIe/g
---
 drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7b200b66114a..73baa2044ccf 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -408,6 +408,11 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 			dev_err(dev, "failed to disable vpcie regulator: %d\n",
 				ret);
 	}
+
+	/* Some boards don't have PCIe reset GPIO. */
+	if (gpio_is_valid(imx6_pcie->reset_gpio))
+		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
+					imx6_pcie->gpio_active_high);
 }
 
 static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
@@ -544,15 +549,6 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
 
-	/* Some boards don't have PCIe reset GPIO. */
-	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
-					imx6_pcie->gpio_active_high);
-		msleep(100);
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
-					!imx6_pcie->gpio_active_high);
-	}
-
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
@@ -599,6 +595,15 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		break;
 	}
 
+	/* Some boards don't have PCIe reset GPIO. */
+	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
+		msleep(100);
+		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
+					!imx6_pcie->gpio_active_high);
+		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
+		msleep(100);
+	}
+
 	return;
 
 err_ref_clk:
-- 
2.25.1

