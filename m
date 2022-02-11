Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D133A4B290D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 16:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351369AbiBKPZ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 10:25:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbiBKPZz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 10:25:55 -0500
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2111.outbound.protection.outlook.com [40.107.24.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A8ED84
        for <linux-pci@vger.kernel.org>; Fri, 11 Feb 2022 07:25:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnnjW9vlJHeBCUUmJ0SqYmCi1b5d4Ly4K4pFf2rNMg2FnA1cgtUmtaoo0HE6x3xNJI98O2S/Q1kh14YSohr08wzj96BC4uiyr7Rwes4u/fG6YUPk8AbtTrjs+JBb5t6w/Igb4fYgmoetiQQQIelNUnHDP8bRHZ0n0F0ibqUexPgYo6nBTf4oYk1yK/VUOJMFvQHpUkwF4JNTbU+/Uuj4YZ6ca8345vE+04geM5pJtzANFW45m+qh4Wl2qq3GAEC7rQZIHRj85E+p1HsdkG2lE/ORRYJjUnCdg30CfbSipaVBNEgl8OE5FMe6zehMaq8zQ++637o8Nt24p+7wndGwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3affic6ucbgpmSgkmynOInYgU3hd72ooIup2i+5m+g8=;
 b=Lxuh08a0aF3QkDzUQNEaVrUlbdppnUc1eEH8mjLnUxqrCn2dpfMv3AtI7+e2Dx7+2Zb5TAe3cN53573uc6rNbzLE9FLcDJeZLj19rhHAyUaKFzqGaLAJqtbj5PLBlGmYj8Gekv/0qbtAw6TgsAZCLFpDctQ1SVTYpeiQkioSjwSdAUl7PEigYZYtijIyZoLjvNRBPGy1CvtmzDHtu4x6GUWPp98do/r2NTMTPSncolDbsSG7ZjT6mUPgTPiT0ry+P0aoJadAd5ZbPxPkv0Y+eUrJzhujS/KQHD4QdDRRtQYcZsNE5+aEAlWbAH1UOhmN6fp1VAI1XXT/ggxHTT/Fwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3affic6ucbgpmSgkmynOInYgU3hd72ooIup2i+5m+g8=;
 b=VP6we60VssgvC3HOaJ/AaPTjwBfWMqwVstvl9hrnFxjzoslRLK+FwqWR5RIgdgPd2yOx9HC+rDFQpV1JazFyNUiZIRLMnZIBlMb9RZ5W+JJDa92XmKrSW0oIlUQQ5U2gqer3t3Lrq5WvFk90FNr5TG7BiFxiYsPeuMA3iiSjTRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by GV0P278MB0177.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:30::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 15:25:52 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c4e:9890:b0f5:6abb%4]) with mapi id 15.20.4951.021; Fri, 11 Feb 2022
 15:25:52 +0000
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
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1] PCI: imx6: Fix PERST# start-up sequence
Date:   Fri, 11 Feb 2022 16:25:50 +0100
Message-Id: <20220211152550.286821-1-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0073.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::6) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a63d4407-8c80-46db-8703-08d9ed72c9ee
X-MS-TrafficTypeDiagnostic: GV0P278MB0177:EE_
X-Microsoft-Antispam-PRVS: <GV0P278MB017724AF80BAC796E3423187E2309@GV0P278MB0177.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPsIQaSOo2HL3lKThBhOAejDSqynj10Vw1g0sTY0K4WT8mx1fSmfh95242Yh8uz/7cfNzXXT4Li/OabMfA/aqhwdNKkI/jAgcsknDOfBbq7Us1s/yIg3hYVGLf5Tzse15DHOkdV5jDH2SoyEAMWxamUu4jGUBOZ5lBvRkdjyizIJWwIurcKfYpnUlTskdIhDAsVryI4L+FO0mZBy/6OpDHoueGQzZRgBQ1NON7At4he5QfHS3Ngri/b8I52DjbmsyzF/BZu72rEqIpN6+8TmQ8M7X5acRY9k+Jo5/2lgQ7mBKL+0qIe/+8N1TwqHW6zVmDG2SMeMQe4GaMjrKNT9NoADMso0AEOpus6UD58fnTWsizIHyK/ktIxDUplhM3dE+7gR7VM0UF9U96qGvW+42CkVuR1t3FuFgwm/JP6Qb+CfCfapi2/XDOZBlzey+mdrqCBfzvCE6ljnodtXSYfbDEl/0lD/1wKw5uknIcL1P5mZR1X32p9Qhwa21+Q7QgaD1NN2xO1johM0JqOfsb7yWu5s4e6HZkqZ9wBRjxXvTmJaOxY4xzPoiBMuNjZDWX3yoB/Eb11jLuXrgFQOg/xQB5VHTz5R8DlCkWWvHCfjca+1GWCAVo59KR+FGjDTBXUGnfh0OvfavAjOu0JjY9ZXs5kJgtX0YpY8HrcpwTV8bJzyqUHkQjhiEsxi8Vr09LnC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(136003)(376002)(366004)(39850400004)(346002)(44832011)(8936002)(38100700002)(38350700002)(5660300002)(66476007)(4326008)(316002)(86362001)(508600001)(6486002)(66946007)(66556008)(8676002)(7416002)(110136005)(54906003)(83380400001)(186003)(26005)(1076003)(52116002)(6506007)(6512007)(2616005)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qaqJwak09S8BBHCV7Y14zJYW6e2uXsoAsmcQZ3rvMCnS/6/eCP0TiffzE9ek?=
 =?us-ascii?Q?P2Jtf1KVIGFf5gp9WH8J8qL/hAjSN14SXn/C+eRQ7/vBvPRALx8LrGGOmXBB?=
 =?us-ascii?Q?xV8Qdf7agi//HNzZM0EgF7zK5zhOEj5y5OPqcvuFCtB1CXFCWC2jf4ZfYRWh?=
 =?us-ascii?Q?Az7MbRfI9mqGh8JG9lez6AjS2eDC2rtCCqj1MMsa6w+6lDCRt7dm8/j+6cwj?=
 =?us-ascii?Q?aZJ9c9+cDh9XiO3VoWa+t0/jhmO2ksPZQ5dvrT3BoLPPYY7FM/lGgc/s/q/x?=
 =?us-ascii?Q?vTSD/Rm5Tw+A4JLf+XsHlbmWRCpfhgz5AyQeuJ94xfm78zTGjT+aXbK2CWOf?=
 =?us-ascii?Q?zhDs+FC4zXbyIw7zgXtxklf0qe+yLy5EE6IYxNOUd7SRcug7foabynozy0IB?=
 =?us-ascii?Q?sH8osT5gyVvV2yfHlVWJz697z4Dn97kbO53j7vChai5vxoKUThGUlQi7xx+9?=
 =?us-ascii?Q?Nu4RbBKMtbGiW3PVXVo6FT0OQWceF9n9inerI9zkSwWDIaqwqqJIe02BCD3d?=
 =?us-ascii?Q?62kX5JUj3xY805vaKA2GEphabnycw7deEZgjPxypRddROlpACD7CsLPDe2m9?=
 =?us-ascii?Q?Qic0W9RLQuoPcnQBg4FXdoO6UTvkOj0HGIA0DuZhQ6S5plcGhbZzpmUwMhE7?=
 =?us-ascii?Q?e35GCpUzZdQ2pMwdKQMYdyLIOBWhFY4ABWxM6mtLx8PbQD70xFG67tGVag0b?=
 =?us-ascii?Q?OMjqi+UjujzUDF2MHZ09zYxMEZHu8hAy644hA6XQqDCWWEutgjrFE9xqCntP?=
 =?us-ascii?Q?LlItniHnPGFzqzGTwPVbJiDR8NfBWvKUu3bXemROeb2j08XVTZkGZXOsqL/s?=
 =?us-ascii?Q?/1qglvaDK6zUD2xFisIE1IqI7LY3IHQemhAk4PsOd1HYw/XJCrHsl5qstLpK?=
 =?us-ascii?Q?bw11BjC8zBzKtcsAuOzBiV+lp/Z5Z7QNsyEr4FhRgJzFeBvYo+L6ZHdbKvDE?=
 =?us-ascii?Q?h9Eo5DJhYg4ZVVVPW/+yrhyOMLUS9BU//dokJYEz3zrelTze/npj4HG0SidJ?=
 =?us-ascii?Q?5Mm3XYkzMFDDnbRit2N3f7fkqw6/aOFe838TcPw06pC3azDf0VTCC+oKUv0S?=
 =?us-ascii?Q?hfdEMzkIIYr9/xmcnI44Dx/sR6zYsvqjJ2UIBsWuQS/M9fZ1Jm+gKx+4Z0av?=
 =?us-ascii?Q?UbVp5SR6VD0CbgCuxxQUA6TFcAh4XGc2UcTJCfJBMrdWzocJw3tkcAcFUJBe?=
 =?us-ascii?Q?WVnxFMdICzUBnNAhoaRYepMvW7RTqet3iDYfapM0N4E2DrOTtgIh4z9Ad/zT?=
 =?us-ascii?Q?xMqjDfcG83GoYAyO7nDakIeQ9ul6344+9wxzgKGqkONLijf+G9hSby6nHeDk?=
 =?us-ascii?Q?SFysJs/1Nwx01J8CJid8uedrdi2bBFPIWF3pvx2A5CGcKWe9DgeytkZWdAdw?=
 =?us-ascii?Q?a3iIbc7gztQ7+wokQnFdrOkPIZiKt6tPUtY8PXHWMJv6z7zhpXVSGAGjHvZU?=
 =?us-ascii?Q?AhcWhscM6AZhsMMyWUQ646+pzs0eV5irDYOusO63OZ/XZYOCW1XT5su4l+54?=
 =?us-ascii?Q?hGLYojj90cx3k/+9sHWWoQXTyA+2c6gvJ639eGc3stZsbDeWZ5Aj1lDbmSNf?=
 =?us-ascii?Q?LtWTpp63ldM17sOdPjElJlmcM6xo0wMYASbLyywnvUFOORJacRv/K6gvIvLF?=
 =?us-ascii?Q?Ot9z354GzOZ4GxbJD2atH/Bf9CeUSFsHiUUDt3pv51MxfiV3ddTv0fL/6g9P?=
 =?us-ascii?Q?z17ksA=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63d4407-8c80-46db-8703-08d9ed72c9ee
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 15:25:52.0168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCT3Tvg2QG1GdxfKQflCxvBlghwxUIHAzyAtgEFRCgXeMeWHqLwWwAIGzV0eFQGLPJuEf0NbTphGM0rg+xCkbziW8FkamZ321dALh1wyioE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0177
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to the PCI-E standard the PERST# signal (reset-gpio in
fsl,imx6* compatible dts) should be kept asserted for at least 100 usec
before the PCI-E refclock is stable, should be kept asserted for at
least 100ms after the power rails are stable and the host should wait
at least 100 msec after it is de-asserted before accessing the
configuration space of any attached device.

From PCI Express Card Electromechanical Specification

  T-PVPERL: Power stable to PERST# inactive - 100 msec
  T-PERST-CLK: REFCLK stable before PERST# inactive 100 usec.

From PCI Express Base Specification:

  To allow components to perform internal initialization, system
  software must wait for at least 100 ms from the end of a Conventional
  Reset of one or more devices before it is permitted to issue
  Configuration Requests to those devices

Failure to do so could prevent PCI-E devices to be working correctly,
and this was experienced with real devices.

Move reset assert to imx6_pcie_assert_core_reset(), this way we ensure
that PERST# is asserted before enabling any clock, move de-assert to the
end of imx6_pcie_deassert_core_reset() after the clock is enabled and
deemed stable and add a new delay of 100 msec just afterward.

Fixes: bb38919ec56e ("PCI: imx6: Add support for i.MX6 PCIe controller")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7b200b66114a..392803544364 100644
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
@@ -599,6 +595,19 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		break;
 	}
 
+	/* Some boards don't have PCIe reset GPIO. */
+	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
+		msleep(100);
+		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
+					!imx6_pcie->gpio_active_high);
+		/*
+		 * PCI Express Base Specification:
+		 *   A delay of at least 100ms is required after PERST# is
+		 *   de-asserted before issuing any Configuration Requests
+		 */
+		msleep(100);
+	}
+
 	return;
 
 err_ref_clk:
-- 
2.25.1

