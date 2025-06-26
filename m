Return-Path: <linux-pci+bounces-30690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E957CAE96F3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 09:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C607189A96F
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 07:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DCD22ACF3;
	Thu, 26 Jun 2025 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V4mKktgr"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F341B043C;
	Thu, 26 Jun 2025 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750923619; cv=fail; b=Ne0KEcHT0d0J+6Vn8qleSfcJovfsTDJdqlDVzb/eBYwEomh30nXoPz8XpMHQvlNDCR986jGt/54fux9OJjXSH7F2WQ1pWHlJyeORv0NBV5m8dc8QW+v5lrcP01GVP2E3TNabVRS9su1GdiyrgYRpEml+LsMAo+mZBKh3ymddAQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750923619; c=relaxed/simple;
	bh=wXJrw9FwzqByOmiU6dbnah+1/dloX9nhqpUZBgA2nso=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KpKjam/qKwTsV2C20Cn9cTr5rAbNgBGGv//EX9jCKE1ahKZ3Hhv9y6UcagxjKDcan5eXeBcz57QumE6qw8yliEo3hF2DdOLCqDg9oDMMnch5zI8zNoFCZZBvpZNROwXDqMwygM5fm22A9UQy7t/1+LamVLaQpbMIfjlcysfxQvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V4mKktgr; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9IGPESHyOl0ClCfNXYxbx8ep82AqV7PUqcv4QhBBcnqWEfPdj0waIKd27AuCJXt0wcpGS/geeRhwG7k5tE7tJ7MA+LZ4mLGSVSfh76PnUojhON2CaASwvs8TxfufaxdspxfuNu80F/8IW9tn+f2WOsvcDHzfG4gtW886A9YFhHZVCqCxlIEGrME5XY+A4B8/QVM1yvcxXshZLAwvIlA2NKtkEFBpMsaPe9heNNxVzTfCLAhAxhZTeJUtVrWUJVjKlj0USFhO9gX5yUeFudz/o36QXOhI5FX2LcWt6DnWgHgtdIfI9zESEK3jQ+3oyWDXEsLwph4bAl9MkrawNLsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oH+AILj89rJ48qtPI2Yp3FzrirSbsImCWq9G1gT+xjM=;
 b=uZD4GAuzyr7VAOn+8mN0+yJpCPYGetF2ND8rnAyF21aXKiyMInDMqz03UmFb8mjQ70Wf6+GRFztfUrirw5x9pSC8W88x1TuW/g7geDCB/R2yCg6DSmOW1YlYh+RbDvKSTe5RBTMdudU+KyFBgi3dc+g4BWxvGXkMFEaHijQkwceqyfv0Wu5a3vPu8rKCzd2Yc05SCnlmGictAtgKzyq8+ws28iunb9OcgA+ZVxTjnpnLxDzOwXUujsaLhMm4vd92jTEb677NazIygvl+hTIevnKWeSogq3AXCkNBfVf+1ynR5lKquNPzSaZ3BV/AFbqyNI6WJG+BBLGfvw/d+f4qtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oH+AILj89rJ48qtPI2Yp3FzrirSbsImCWq9G1gT+xjM=;
 b=V4mKktgrYjlXwQBBoHrKbgjcQBgNRWoDiYpOnG6HRAQp2Kdl229wifImcbX9xXfPyVp68DhbeCoQDiknXHtUsMPSsWM5n7BYayJDZDdqkAD2fuNPh52yiPbzQi56pyRkzgcjaPt0Doy41czrilea82134x38F26uiP9FacUoseims7noLjFLic2bkr4b9E8TowBqueYFpP1YxtOSKWXL6KiwS5AaUktRDk0LSTAIh6QsycJDLkLaVDUD2py2TSByaVyv5AkFTRRGO6zTfX/4QJmWNpGH4odiFSyfolleEg0wZG2YsY/d1KIXYT6XVQ2O9kkhpXb3qJGeEPDvuFoqFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8425.eurprd04.prod.outlook.com (2603:10a6:102:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Thu, 26 Jun
 2025 07:40:13 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 07:40:13 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] PCI: imx6: Add external reference clock mode support
Date: Thu, 26 Jun 2025 15:38:01 +0800
Message-Id: <20250626073804.3113757-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::6) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: d57e18fe-4b97-4865-db73-08ddb484afdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A3if0QX62iY2pwd0+h3kdpQNGb55qeiaiK+orUH8O2Ku2WxOPOAN+S9a478L?=
 =?us-ascii?Q?CY1NJe2QwZ859WSQLlo8mfDVAehploCFWIspjd1OHwF4X6YNAzzr6oVkR+gr?=
 =?us-ascii?Q?XKqfsQw1up0Up+ILFbWqKfrJUqcEHB4SVSD+Vpf4DdVjdQfdcGKMbPLZ25ze?=
 =?us-ascii?Q?vzyW/OKN7zohSRdVeW3jHbhhyZYZ5FbK5Kv1M47+dOmL5Kkln+Sn7hKjW8a2?=
 =?us-ascii?Q?oiVYDiSr8ty2bIlWxi/ODr4J76gmiUvZ9DUi8BK5VTX+/PMalIJTyZK7kgaZ?=
 =?us-ascii?Q?F3a/cTtHoVPVyLHDm8VijoPz4Ewt2kFGOzN9SzN72+t2AUSmNca9lOhXwou3?=
 =?us-ascii?Q?jpx3yS2ap8gb43GZgPSVCmVXVdHwArsEua1Ggjbp55USV2wzjAzTdpM8KBPc?=
 =?us-ascii?Q?vUv5AHGMSD+RU9Cpb1l1IiNkVxZTb0EBkg+uwQxO3DQvzEYZXZihuSt/PxBv?=
 =?us-ascii?Q?Wr2DnWE6CNsQBYqTZ18Q4zHk7IyzM3C8jc+Bk064NekZAVucAANYcYcHoIe8?=
 =?us-ascii?Q?V20bREepcGdHd2+tKRQVPL7jlj6/uSvB2tqIRVn6EuojAgn41grAmuI4Y55L?=
 =?us-ascii?Q?lY/57RyVT8VmHWFo8889HPGhIKI2uJiZVt4Hjk9UqazvhGFVpW5w0WbZrrIQ?=
 =?us-ascii?Q?n+d6GemnJbebhhQgBE48K+neAGCacXU3uCYSIP6gI6OK8KXxas43iAc3BYtE?=
 =?us-ascii?Q?ejG4klEJOoak50cLNr9n/ED+z0dp+CCi8TetlrYEs09pJAcCeVRiyzZqJ3Cq?=
 =?us-ascii?Q?vyvbrWbEKQn0D+NzKV3o6CNb5BaXf4U3vwF4gwGkpizhU67ff1xPc6Y9+9PB?=
 =?us-ascii?Q?PSND9YizMez3YK5kcdlwo93e2rymtop/XFFCbmZWRgJFN3xY6x7OCNQ18JFt?=
 =?us-ascii?Q?KHIxrw4O4bJPKrk1zo7MzIKh5lZnBetbJw24Ys0VW4LPvbAktEjANGP0C8IP?=
 =?us-ascii?Q?ZYJ1h2saf6CQG/Mb7v40uggZ6wRB8Jr7EhOLEYssk67Grr+T8Z31N5SHssDv?=
 =?us-ascii?Q?EHqzDFwd4LBanolgmg+JynVBHyrIxknbfo0Bv1TMoTmdntDbzG3u+WkOTd+v?=
 =?us-ascii?Q?fpMSza6kMO+8piDMP/PaTSHH5+ptzHE3HEtBoicLNMJf4rkRFp9kiurROwB/?=
 =?us-ascii?Q?VD+BC3360JJaMPOMaLFVUPl6ZXJDtisUW1yARNKugrP4RfYHTi6nND8i9+yw?=
 =?us-ascii?Q?I/s7pjq/7PHD2SgSRRH2Poi+f2J1AysOOKNRzU4UQa673lOJRFnG+Zdw3zdi?=
 =?us-ascii?Q?MKE3owTtcQYQ0YyWxZO/2+U/eljuP0ygAAbKyr0D1S36etVq3OKY43flbojW?=
 =?us-ascii?Q?bfbrNVBRcbLuCrc9LvjivpDEzWmdwD3PdjWlpwXDlRBIWSNuiunAva+mjK+4?=
 =?us-ascii?Q?qpg1KvJSpdcD0h5QhWe29a9RUbCcgMJ5Fi8okSa4+rsn5xW/RdMTICKjvFXj?=
 =?us-ascii?Q?feTctHt6RKQ+Sa6Z3XyX1rQ1dEl0RVeWofTQnsrOSDASf7UR9s9JMl8OW9b0?=
 =?us-ascii?Q?q7h+djOkg6mtfyY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WBmxvZdjaVn53btH6bAoJWUhn0FDfFm832wNJkzBju4Vz0grAtjkJpByIlXU?=
 =?us-ascii?Q?UWxrLg7jyMlV8mRzVbs0HhU7rMD1OXop3FHf87sZypD5pGj9x2bKvtdMbmTO?=
 =?us-ascii?Q?ynqSK1IiQfeirQb65thQ+iNBdely5TerkNwSzgovOSvP7AcMA04Syet8Tw+l?=
 =?us-ascii?Q?EZtaumn6kc3wdrUaJH5AglIXa7JmyJwKYdT/aibsAZMN96YNU3S2xTwa+fAI?=
 =?us-ascii?Q?Y4lgP17yHefUtcbGgXe7QaZX6vzAx2oLnHH6PmOplCe3LH4UdXHsrFpDAc/n?=
 =?us-ascii?Q?gxLXwxYPnruVLFw5Xkc02YPXkJ/4I83raFvp9eo0aCieDXZ8HFHvEY8yOZYf?=
 =?us-ascii?Q?O+Rr7jf7tgeDj0Zpg9KtvgZlxLheiKecYlgWwEWa8Gm3euCPJXmkwr3bzpbv?=
 =?us-ascii?Q?s8vxtLw821/7CztKIL5vHeOeFhcxnyZy7tQKKdwzB0yk2lEM0z2MFz/AjgUt?=
 =?us-ascii?Q?96/G/wj757rV0Kx2k+l2afX4G6RBryxYcjjYmSK0J+B/SNtxZ4CzgBz3UrhF?=
 =?us-ascii?Q?LiW/TRg5yS080TACKOBSHCI30kGJj7zOyrOYffS7ZFSQ7RU35TCujaAcFkTv?=
 =?us-ascii?Q?S7qXJlPOiEft+Uz5Ux2+zw249Pas/mtOyDyuUZ/QBQ20AofPfABpRD6S84SI?=
 =?us-ascii?Q?GCiiujzfqjpW/O/qb1DWRS5yFomKITnx8s4ZSaZHKlPwgFXvchAxA05oz/yW?=
 =?us-ascii?Q?gUsO3qj6Z3OVprWHQRq6BaRZ09nYe8qL2LRNTTqtI2zyIHvHveHXHhMzTHya?=
 =?us-ascii?Q?syVkiI5Cme5yoJ0cQWOmjdP6ujkw4ZUkn5HGX15VmiBKaPfeQHmzTP/Qagkl?=
 =?us-ascii?Q?ZRhc2pFtQ1PDnuUT+swPquDDAQ586nIP0DRMrB83o8g+nBB3Cbpgy7L/2A3G?=
 =?us-ascii?Q?LCEjVEyXsJkMR8vQVbMQP2VUM4SVRTVsbhLPGMooQFNqM8GXs63lNgC94WnC?=
 =?us-ascii?Q?BT3C5/aEChH8y7mzfbgSlFf+3GRP1LjtLr/veWH2YvYX7T2Om+N5TxpAqVuV?=
 =?us-ascii?Q?BYb82dAUSgCA3xgPp0v/ZpryGgfgFzHgICSwzWbeUU1grplv4Z6yFhcFS3iR?=
 =?us-ascii?Q?0OV5Lbo0Z0iYlCVeAJ3a5JJSj3MNT68fjCjSm/y75sopsVlyylgzr8wf9hYg?=
 =?us-ascii?Q?3hmaoGH9azs7Hjn1TZY3dSqIMMEGnFrHO70Q3Zln/J7k3MuO5a1ZW8Sz9/sc?=
 =?us-ascii?Q?TY17CoX+PxwwSIm9aJHodu69YI7w7VRgnKcdeBf1KcWYrwhJbg3qCvlKmapy?=
 =?us-ascii?Q?+QMAT7Eb2IYIWk800GH2bnED0GAJKWS2ye/f0mZXb7Is5itdr5Quw5qa9XIe?=
 =?us-ascii?Q?TLeG2eY1ew2o6YJoYjLRex71gFcPJvA3m6qIiCE4octbWqxL1z4g5Z9blyne?=
 =?us-ascii?Q?blTVvufZC5GqthjjdvfFKUEgLaoxPDHUTw6hS5MVZrRiXC0L5FLnoGFAJ5iW?=
 =?us-ascii?Q?BIsuD0cw6EdAtJX/fbQWM4Tdfyzi4Bv3Y10X1+Q1wzhVdxUZDeA4cEaRa85E?=
 =?us-ascii?Q?QWH3py9FL/dlynFFk4zjVlv3dkR5YDVlCIsTgb/7YmGERbc6JlMeERXrpLpq?=
 =?us-ascii?Q?x0WMofBEW5U2WRxDV2nT1c952EXy/0p/srYF5NB1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57e18fe-4b97-4865-db73-08ddb484afdb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 07:40:13.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNYmZtjksi9QJVfgnhyMJHB3L6FOa8RFAsmWgmHeLc3n9Sv/Adj2+NmmSzRXewKAw1voYba6W6OR1xX1Qs+Mjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8425

On i.MX, the PCIe reference clock might come from either internal system
PLL or external clock source. Add the external reference clock source
for reference clock.

Main change in v4:
- Add one more reference clock "extref" to be onhalf the reference clock
  that comes from external crystal oscillator.

Main change in v3:
- Update the logic check external reference clock mode is enabled or
  not in the driver codes.

Main change in v2:
- Fix yamllint warning.
- Refine the driver codes.

[PATCH v4 1/3] dt-bindings: PCI: dwc: Add one more reference clock
[PATCH v4 2/3] dt-binding: pci-imx6: Add external reference clock
[PATCH v4 3/3] PCI: imx6: Add external reference clock mode support

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml      |  7 ++++++-
Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml |  6 ++++++
drivers/pci/controller/dwc/pci-imx6.c                          | 20 +++++++++++++-------
3 files changed, 25 insertions(+), 8 deletions(-)


