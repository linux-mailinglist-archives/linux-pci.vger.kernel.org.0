Return-Path: <linux-pci+bounces-14747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C54CD9A1C73
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33673B260CA
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3421D90B6;
	Thu, 17 Oct 2024 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ldYuBMjX"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913461D8E0D;
	Thu, 17 Oct 2024 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152177; cv=fail; b=hH4XYDldC8zXVuznwXzTpgT3EYcK9DxEE5fpz34PEw+eVWmU5iW2J7T6mG+sdM9ZkSaxe6w0BU2EvKaW5v29jpgERYafvCqcQHDj/LKQPL84zujnHMt+4eAs+sILwBtLOaxdS1qcYxp2HW6L4PHrv8T3o1ZY/7tcBKbMTqP+z6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152177; c=relaxed/simple;
	bh=Y9VB2lMkXu7TqIIpxe6/+zkAzDT407nFiUlSvUQF1+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tZqUY5E8iOpJHikcK2ogTNDespIGPRjYxlBAFZw6IPZVKHT28XcI9MdEBmj2ykXRI3RAfLvFaeMJaZZoDtqPdeyLoki8chpBpA2yEw7TKq3XNQU2aQO8kadwI5x3sA+faksiypr43UD5NSTGI4ZYDSVuO0YejabZW8wrhvSIuAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ldYuBMjX; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkISyW2sPzz8ubM3tgJVQgU7ImIyv7K/3BHrAxnT6I/LUgW0JY0eD9zRZX/BXvvwlitV1k8huXjIF4NnAVTn9xx+Pkn/IwqOadexAw4D56D5Pp7gtZvq5KhDy1BEDKnLK2JFWzZy6fdUaHOVFdhLuAU3wsXOMnIrcPYKcaDt02xDPn+ktFKKSMS4cdduo52xIDoI/a0KR2XWvA8DIUIEZ1AAoz7zaZ8Vouo4xwZ0UF0/zURGlUh4IOeE0huh6aPH8AgUPlCa9u9A8sO5DGcmD5hid9zUvCj5Ln8Y2TksXAFU/hSTUkjFWwvowfO79TRRxgx+Z+1k/MUURY8VR3yQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bud6rPBs/2UfmNduq5sq+WL5/0HR6qF4vB7lNEIW+go=;
 b=cxL52XH0MG+w/0yQZjfKv8KiV45HidbWVC1gSitLkwC+0cLAOOJSKdEbBcqt5+mm2sQfjMeOD+NZB8ko2bJUNmIm5SNLqGo2pBKWmSJE7BOxeqp+NRTxZx0lPt8MiXkkNWnbSx8JZyL8Yt6JS4Ioo9XJksvdd6Egw9AsF0CW7s3HvPvWPOZu10EJHnSkJXW3GCTtOGssHHFCMsfc3Beim88vu+UAZ0U0GPY1VfNGTynvB87vGQOEzw8OhAbm4AJq8CWp/kgpMT+ILdqVNt5ZPAl1MDWYt8YBZFAZQwYKkCwc3NI7eK9g66MnuAVIahcQq4To333wDM8QZNVE0e0reA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bud6rPBs/2UfmNduq5sq+WL5/0HR6qF4vB7lNEIW+go=;
 b=ldYuBMjXaf9YIOKgLM114Cen/ol/iREADXqrYrwQ1tLt18GQCVVTBjvRsgvlX7gXdl0uK5T+S9Q5WknBn67Sw1or8iXSL08FwBz6w04NOw+3ZxLjozMjRrPOVhUXTENSH6oAHht9IqypmAXZXKZ4kUoQqCXUQqyn2GwiJ+xt/Hyi4hmE0QqP11MRLByc/99KwIa/nSQQsSX/qrqWhCwb4MEGl5FTcIvdQkW8wHDaNC8TrrEPG/z0/j4cOeDsuUvqeRNVohL/fb5i7hvTr7cG2G/AnFAFeQ9uLpAbyJrWoZ/N9omCPQJkDZGE0xJV1puqjOK4xlJvuSmosKEeeb2QHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:02:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 08:02:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 net-next 09/13] net: enetc: add i.MX95 EMDIO support
Date: Thu, 17 Oct 2024 15:46:33 +0800
Message-Id: <20241017074637.1265584-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017074637.1265584-1-wei.fang@nxp.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBAPR04MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7fe6b4-fd90-4366-df75-08dcee821817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cuxmgKRtIk5qS4+TJXBSw+85nKtyakXl85hxtAaQUc2PtEaVNd7RglHlaQ1l?=
 =?us-ascii?Q?VP3G176/NRJOyaqHTw6s5O4U3w0kfJdZ600IPg/xyWJ0LOknTTkv3sNdb7Wc?=
 =?us-ascii?Q?oMgZB5TSB/VWNSQebqLD58Ssapnyj+MpVBbNzrC0wKVbQ1idm1MwBIXUuNfU?=
 =?us-ascii?Q?dcCtPlJj27WogbFG0EZrYAk4g+/kqTFToFSLKP5FiqGbTF/xXgAGLEQGZasl?=
 =?us-ascii?Q?bR60xTqTezno1DxxRCGcjVqjf7ewd1ZSA4B6Y4MVoCECIdV+r8F5hjIJQEWn?=
 =?us-ascii?Q?pEXpiEvZKMsiIjvgR6S2aKAOSBLvprexsAyGNGc83Lf4+deZ4TLsJq9fkmYi?=
 =?us-ascii?Q?F5JOOFYhs8lPwF7AdoCdk9AlUuKj7XOYdQlGgXBUStIKGOYQGgmm0TSWuymV?=
 =?us-ascii?Q?AE+VS+CRvn4ahv4NkowYcqGmYA0Kg5wAtEXumYkFYbyWpozD1IUPwcwTdPUe?=
 =?us-ascii?Q?/Ib/eWKTl7ZSu1g3OoZzmiG4V8sIeoi7GdpNOWKEKPPIlUdnlVO1qBJIkjbT?=
 =?us-ascii?Q?zasIy//RRo6fxu9Q2u/Xkwf8+Po8GeiQmXpStDeDrTHzRaghpHJJ9QLGqyuj?=
 =?us-ascii?Q?3NDQRGNigP2XdGpbaA8ezcA0YdMJbAIsRNvsch7YhyVErjmwHNLRvzAJzPBa?=
 =?us-ascii?Q?2cYZatgfRFVCtnsFzymwoXm7Ynod3LgYR5N+3zSJldRMslBkOjo4Oc1ntMbi?=
 =?us-ascii?Q?04ljy1ZfbF6y1gurDJOmh+r6CEaWLE8AhUWQ7SW1sRBFAON5Qt37OWh1nVHX?=
 =?us-ascii?Q?rc5Q6pVovU8qRdueljcqzydNRklP+eNp2vymTfIzYX0eJHJWCMyVjw+Xp4Ta?=
 =?us-ascii?Q?8z4DpmenBcwANdPTt6ulOBKsT/3rrJRZpSh5XZtIe7eUyWkHJNidYwrR2x5h?=
 =?us-ascii?Q?sGaI0FYD4+ny89X7zruUrsOXupA+xdIn5AGrA5afguDlKsq5ProyZuaD7LIl?=
 =?us-ascii?Q?Y4F1fqmNLg4+IRoJp0YMPHErnvrPUIhPniiA69HZFtCi/abPwHsisNlokvX3?=
 =?us-ascii?Q?OHn+JPGgFFx3HTWxpb8yYDCx1SZTUJZXglsLMCOsI2PTUDAVFAwMv2ejENiy?=
 =?us-ascii?Q?t4otZ811PDhMkKxwzefiAtP8Gwy7wwWF6zCWBMEz/3Ips60in4t5BGko6A7M?=
 =?us-ascii?Q?QRofIlFZe3TsKb6OtmRjPdWzfUkmCWg6z0lv2tl1Yn2cZTfyVMS1RKkOSGol?=
 =?us-ascii?Q?hkCWBL8rQRgilUfU2WmEquPbirSxdFYqZuKP9l24QjzMU1sZfOkZqCvVtQ5F?=
 =?us-ascii?Q?E0P175MO/LSogGUJZBRArQI2cRKIKtBS9YP5ywdhbSN1UqQNJgmCDHuSF0pD?=
 =?us-ascii?Q?LV1tumSGDTHYKrf6AmsxL4X7xM1aP24A56DwAle9j8qNHtng25NbU6vWShJc?=
 =?us-ascii?Q?/qV7yyPhGm3k1/X5lrzpmCy2ienb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bxVCSKBXxlfExLH/fSH6wisbxjCSAttWi6p1ZMDD/fjXkmCEVTazVEPuROVY?=
 =?us-ascii?Q?P12SFaxdu+2iVEebZ/rPcDyGfll3HUtbXGzOR36xI1EtpQZxprwI5vlYl9H5?=
 =?us-ascii?Q?0GNPXa7vnqEu3eVbIZh5y9YJ0YhBdpEdoFSTovJgyKB8LceVS+hr6kCPq2Gq?=
 =?us-ascii?Q?krRj8loOE2OLMjjRTw3epnNqxyScpk1MxZ43cciRHNDqlP3Q4M0QBdUI/ESF?=
 =?us-ascii?Q?OpHjGG3sN4DMLRcV24CTXlYnGmf2LR+a0qL6L/GmuIkusu5LDY+xBxtUxfXM?=
 =?us-ascii?Q?juecxmv6gljyGpZ+k4P15Rg8cuoLdtqcN6VVWPjvvbzgQGQEHELxZ6XBXOUA?=
 =?us-ascii?Q?6Ww+bXutZ5b27UMHqAC7yXTBiRLEtA89O8j+PwlFhd9Rh0dcC51DJXsJUqg2?=
 =?us-ascii?Q?P+Cv4AnWJak5Nza8AQt/lQiVHF6LpSq0YvY04Xoax/jdyRO/Zu37Iu1uJDS2?=
 =?us-ascii?Q?tTvPlbjFMfxMsEEboWxZJ2aXDwN67TRO0XaUkUvQDPmkK+hAEejgXUAV2th8?=
 =?us-ascii?Q?Ka4snNnzuryK47ehph9p6fz/WJrA9zB5wNBoWdxPwnJzvA/2B/5xw3eKYhh9?=
 =?us-ascii?Q?Yf8JaIlObaFRZbET1+1GPJA7zTWoTquh998hd87Ot2zS5bjsXmYByWlf3U1H?=
 =?us-ascii?Q?EQoGorPVmsQL0EVKS3x8XkkmEf4d18wQP2+t6M6Hljd1MDwEzdQhDh0hmcZA?=
 =?us-ascii?Q?G0bRCUvwA06xARO7lgRO31FJpasHEKkzgFVt3g/o71iDinEK4j4LGHKAPQIn?=
 =?us-ascii?Q?ddbbIMyNj2f7DWb9T/BTQJH/7twJvQJJ9D5oHF008yTAGaNCz4eJZex2hTMl?=
 =?us-ascii?Q?P8z0xaGHRXRt59iuzyIvJrotaIcwobHJUlCV6PICVoxr/p6mh9B159jiWxxL?=
 =?us-ascii?Q?scW7n1UQVKVjVyaP5rZ3aPkeshp0G0TjvlYoOdKEyXd4GMjfz6TdRkN19pRo?=
 =?us-ascii?Q?dVH27TPJ++WBwyg4GrkyKOQtAZ2FvHYqPb4NOfSI4vdVM7B20+Bj7f1Qf34e?=
 =?us-ascii?Q?fVedKFAbdnnap47DhfzeQ1WY7tVqlqpRL2cLKWEGzZsb/hCMaVBc2rMCKTkz?=
 =?us-ascii?Q?/YKEiQbWlfZzBP8RYop5cLZZSh0F9qAX5VdfOMPiYGTyWGQ/o+mRdNzAK4GV?=
 =?us-ascii?Q?ZMN0QGee6dMuVNv1JsddaBJIn79h4WBGvm2k1NWVCRkJ7qjYK+5gvZrf6GUT?=
 =?us-ascii?Q?dNr3KJwr7hb/oES/dhAjF5Q9MrEK+iKUuuIsagW/W1MtWFAdmx9R97aTQmL5?=
 =?us-ascii?Q?/OVSOFKUt+m2loWivpcC43JQYSUtE6NI605tsHNe9B9YHp1deGlzv5c+JnY+?=
 =?us-ascii?Q?amWD/UFHu4jm940OWYDlaWGVyMwQaGGzxWNEP8MKzgrc9LTJSwtDtFEaP2iB?=
 =?us-ascii?Q?4QNb+cfaPybRFV6LUqLAuvt6vUdBrYyohpOnKLyLe9yShlI2ZqqPi7A8H/TB?=
 =?us-ascii?Q?H8bQN9+T/s/S8lNRInuzB32gWqyJiia3dgLLps8TRjGnRlOPeIRcTB3cTRtP?=
 =?us-ascii?Q?mla50zS9mjofEwYcrtXjrjALOywj17nSLz3EHnt/Xr5td5tmb7CZz4u2Jf3u?=
 =?us-ascii?Q?wkeqdHLK2/avdrTu0bAst3nPe27kQ7Dvaau1RfY8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7fe6b4-fd90-4366-df75-08dcee821817
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:02:50.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6v8rbgpqX5oUsKn40r7tzy05X31y5DRmmpusPQdeirCNiS7vzDmqM7vu1Vh+MUJi0zJY8rpUDT4+wzSBbgh3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

The verdor ID and device ID of i.MX95 EMDIO are different from LS1028A
EMDIO, so add new vendor ID and device ID to pci_device_id table to
support i.MX95 EMDIO. And the i.MX95 EMDIO has two pins that need to be
controlled, namely MDC and MDIO.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v2: no changes
v3: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index 2445e35a764a..9968a1e9b5ef 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -2,6 +2,7 @@
 /* Copyright 2019 NXP */
 #include <linux/fsl/enetc_mdio.h>
 #include <linux/of_mdio.h>
+#include <linux/pinctrl/consumer.h>
 #include "enetc_pf.h"
 
 #define ENETC_MDIO_DEV_ID	0xee01
@@ -71,6 +72,8 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
 	}
 
+	pinctrl_pm_select_default_state(dev);
+
 	err = of_mdiobus_register(bus, dev->of_node);
 	if (err)
 		goto err_mdiobus_reg;
@@ -113,6 +116,7 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id enetc_pci_mdio_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NXP2, PCI_DEVICE_ID_NXP2_NETC_EMDIO) },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc_pci_mdio_id_table);
-- 
2.34.1


