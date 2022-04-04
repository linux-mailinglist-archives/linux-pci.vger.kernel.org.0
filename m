Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF254F1095
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 10:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiDDIRR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 04:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiDDIRQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 04:17:16 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2134.outbound.protection.outlook.com [40.107.23.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E22132989
        for <linux-pci@vger.kernel.org>; Mon,  4 Apr 2022 01:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POL78Ea00lDaM7RceC4UOoxHQ5NM1Nyft5EWTq/c/dzn4YY2tGXXCYt0oHgUFbzddMX86T/Tw9XEkO1BvqxbJu6pggjiR8tZSwEmi188lhMd6s8Mzc55e7QtrncVyjIvmCGH5tVdtzwJlKrmSnneGI2YcDI1u70bZQ3dFDN+/aEUogQN33oS9RO6ykXMybi5EXKgHqvK29Y+kVDvKwj+zXTJj82iAsSXpIyLLR62tDkh/5GwiIOkTtDWr8fypHotxGIwDKSpPrpDRn/2Jt4sLV1vkT9cnBRaezzYr09pSS+Hv5BcrnIfjvLM42bRJwD30y58uG2Gvxo4FVT25UwMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOl+zZk/9sCVnb+yit5x8rxN64Bl6GLpqGr8Evvq/yY=;
 b=WVBy3sKby+wAQ0np/XOSQd+Y6hV7NZQ/EdUNRKrfT+VsS18qD5TlEHlTB9IhbnX+BdpCPi6vIecpuqHRw84ZSsxHKrTdYbnuJePY+r+WaHq15+nrbsPTn0IJLzdzH5RTQHrCtqjt4oNH39iqZBpSrg5tFEeXz6Rqec1DURkCWZaHq3S9cMRxygA42EK/2OA3U5fBajdBmAyikZjyzczTrQfYyLyCu3+e2MeALvbma6QMAYrRyY7SMpVRwndIk1OW07o8R6G04oaoDRfB1BWkII0SCZAbQJWZ5Wb47SAuEf0fCQl7qHkrRMIAuvHtj9H0/Qlu3skAxSjsz3bBMOa9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOl+zZk/9sCVnb+yit5x8rxN64Bl6GLpqGr8Evvq/yY=;
 b=rYU3zf9dNnUtgln1GM4os0umuREYD9G5N3akq8bEHXVLHFWQM9gWf9TQ1eHfS7Bg/8GYDNT0EKSFyF8N8J9tTsZafU5Qkr4HWajUVMDQfuqrpqWGkaoDWd3gurfZ8KErNGMcixqtJnL1ks8uOIqQ9tzS/qqccl1LOUpo8ApcHOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0551.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.31; Mon, 4 Apr 2022 08:15:17 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7d6c:79fa:a2e4:ede8]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7d6c:79fa:a2e4:ede8%7]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 08:15:17 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] PCI: imx6: Fix PERST# start-up sequence
Date:   Mon,  4 Apr 2022 10:15:09 +0200
Message-Id: <20220404081509.94356-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0172.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::6) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e4ac876-d1ab-489d-760a-08da1613407a
X-MS-TrafficTypeDiagnostic: GVAP278MB0551:EE_
X-Microsoft-Antispam-PRVS: <GVAP278MB0551903F4ECD85446246C617E2E59@GVAP278MB0551.CHEP278.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VALrbejnlPKadzeAX1m8GKMP4+bkq77epWwFPQ5FX7hySfrB7qhdtvqJkZ6JXezCAkGhI6CdSnBOpCH5CeBxtZxvqJ/We+0Jy8WXNbi5gN6TjqcsG8+IJfAVAxDezQBUeNgvLuwGoO4tSK3s5//591N6kRSAB2BhEMnaipk41t8C5Qrqk8DHWzt9cfYC2v2Qw+g4XcyRwz2NDtXnIgscdqGUFG03tR+Vf63eOTxKR8isvuBq4Ct69UCGEEXbyumeem9TLK7vO3fyKjFnAeMnL1rvmLTxaG1FPGRjcaac2yR3Zu72+uW4/5xKBo2CsIgpJRN5+lCSu8x6FrWELKios3lPxeGNzA0aVD9Del+GqreWcEw/cMekg+y2J85aEhXuPMIKqNBMNWoQ07b+0XH6lRNcD1juBCOyAI68f3+mLElIFz++fSfay3b/+XM5iRw7azO9EdaXZcmCeBeZMOmDLpBU+4HZmvd46xC3DovjouN4wO3iDGoV5+dXEHxaXsN+rG0Ny2mgHCdNEb+mCnm54Qz+T9bF2ryZql0Ba1drrHuVvqFttQivRQI5x8c88yJ5xzF0Du/UJjRUgh8vovYWNBl+b70CD+ss5vTYiL2ZeRjNvmEhFBJvy9KoFWtfUfNB+F4rx4m190fSK9+4s7QJAaKDzwfZEhJZwefYyd+M4YQHNwuy1AJPnDSh3HxEwZMnq/4Ju21OU4Zwbh96Hr2pzvIB8uAAXLIEa9KTDiBfIB0TBkgdSqzNzieDmGvvIGPfrZrw7Z6BNc5+YuiGqZTsAAkhjVcxvoDiO5DwKpfGzP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(346002)(39840400004)(376002)(366004)(136003)(396003)(6512007)(2906002)(83380400001)(6666004)(36756003)(508600001)(966005)(6486002)(110136005)(316002)(7416002)(8676002)(1076003)(2616005)(8936002)(6506007)(66946007)(66556008)(66476007)(86362001)(186003)(5660300002)(44832011)(4326008)(52116002)(38350700002)(38100700002)(54906003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rTOS5Ttxs7qQLo7amr9BfVX4mpg0WIZpVeM12auvPErUI3ym6b0auFABZUL0?=
 =?us-ascii?Q?9lUTLhvzHcKiZe1/m+YWnO8TKOIYaYMkdvD0kEPMP1ZAxczBltAj2WFLE9Y6?=
 =?us-ascii?Q?BfU2nagoABEz8OmSPZyLrub2bw48z740/nLEK2wD9OqLjdWOy6CwYySQ6rJN?=
 =?us-ascii?Q?NFXqZoK+Sho65UdXn1FSl0peuyTclDUZoe5HBWpi8P/vS2U+68FEhA/qiCdL?=
 =?us-ascii?Q?jdQfW9hnKNtQgbbVDeQL1bWpU0AYOkjt3hsWSybjzB/5p0PYpUddcmZn5b3l?=
 =?us-ascii?Q?t+JN+HTw6iizoc/cMVBtLx28aQ+wVeFavozJx6a9meJsV7O0hDCV5aeiJReh?=
 =?us-ascii?Q?EimiZCYs0HyQ9TKii3y0a1QksQYHhPXP0TRsKUTc+OuOsLee42BraGusnWMA?=
 =?us-ascii?Q?sFoB+Bn038NYX4EV1qiXr7KinsqB6yTWGZ8I3kM13E8bwwZRWm+nT9bfGIDu?=
 =?us-ascii?Q?Ga/P5GLTbNeuUW5I6buT9DFBthLscu5BYv9jMzlB5p4rpEbXPup2IJ8tNj0I?=
 =?us-ascii?Q?skynb7E8Hk0QiJr2Tthfmx0QSZE1DUW2Ygs/dm1EhBRnb4gqXL1qZFGV5lr8?=
 =?us-ascii?Q?hKMpXWmdUgZGxmcrtzDM5i/f/LT4TgYhJWUcSZloT5YOKVIRjSZOe0Axe+hl?=
 =?us-ascii?Q?Jmw0mNmA93oA0prsVAKkjIMOhmrmUR8nHNw7Ye2HU/3GtgqCkLkOqK9+6lOQ?=
 =?us-ascii?Q?Tf4Yci2TV5xp0+yFluvgQ6qyejyls6gx32AXtwfBB1NQDG1qM6ywfQpEWQ6L?=
 =?us-ascii?Q?TpKjth0uizB8j2xv/rlbgEru7WDW2F1jNtrz1BaOSIiHS/9zyPPsoiiHh4xE?=
 =?us-ascii?Q?j5MptdMQVTJY3HErUsKq19VeNdKEklIVX243994oZk30j28xCzOPVTUOUuwu?=
 =?us-ascii?Q?pFgK+JE1sB77HsU6qcYxOkga47CC1/d366JufDvI7JoV7AuhirM6DncgPzOs?=
 =?us-ascii?Q?w/xUIG1eYMXdrlb1vC+P8zciJu+O1chDGjwED+3iI2yCsc/CCjFx7w526r1F?=
 =?us-ascii?Q?ca8Pq0+lW75w+A2/FMImUksxSvpyTU+fZIHjIMH0afYDNFz9xn7UO1H0Rvqc?=
 =?us-ascii?Q?+O7cjMFzzXLPbk+QnlSwmI9wflVIb89lA1KNNs9SlxJuNACrKMcqXz48AA+9?=
 =?us-ascii?Q?Kk7tIeRlMGRn/11G0Y92TZ4KAQKy2DBwvjzzoqagmfbQnC92POtK4moWzJsQ?=
 =?us-ascii?Q?PurO4S2R7DOn+K4OzXfV19G6XBR6KkAlANm4fJeCxffJgqfKodcgmTFhfq0K?=
 =?us-ascii?Q?Sw6dWo6qqgXce4qFlMF7l3qCr/FxHPaQ9qioGRelwMTSkUIPrEv1MFzS7BYb?=
 =?us-ascii?Q?24ziuv58o2mNWaPMhQqjXBL7MADUpqlN8m+cbtPZk5R15+3qkPEypncCA/r8?=
 =?us-ascii?Q?JR1IF0hY0l7Ih52EspN8YuVxzqYI2dNZSfIhe46l0umN43ZCLUjQSLgnkk7i?=
 =?us-ascii?Q?Hau3JpZR4+PJlw6ml5PareE9ozwnUuKKXQqkDvVDNtUzm4P98Q6IN5oPuJlN?=
 =?us-ascii?Q?qMe/spHvuDdVE/nYwgV7fbz+LnJRPxuf034gqR0oU+CmgLqb2CxvjcCASV2e?=
 =?us-ascii?Q?JXOiXVQ/RDK78ujLqyIA3ampZBHKEaW8d1WsIJ8QYrgwggp3rVDcfeBBxElo?=
 =?us-ascii?Q?ZZ2M41kPQr6+trVMkp4CoHzUCSM0mNEjjmmwl1g9ipg1MBXOBpgP1HAG2fVz?=
 =?us-ascii?Q?RX70gwFTJ92Y9X7eZYtuF2V8OSRNWDBDmmnTZoYwl2xKa3qdGxzUHIbSPUYo?=
 =?us-ascii?Q?zUcG9EZL3JvihD1umg0kxMQ95Z4lNLQ=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4ac876-d1ab-489d-760a-08da1613407a
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 08:15:16.9397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O89J7E4IauOzXERikh426D2xrnDebJETAhXRRChujjt89asiGlYU2I3U5RXdXNHmLwcVewwg7i/tHD+KNK2+AE+HIGVAjVs9tpTn7e+O+p0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0551
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>

---
v3: Add Acked-by: Richard Zhu
v2: Add complete reference to the PCIe standards, s/PCI-E/PCIe/g
---
 drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6619e3caffe2..7a285fb0f619 100644
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
@@ -540,15 +545,6 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
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
@@ -595,6 +591,15 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
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

