Return-Path: <linux-pci+bounces-15580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4CD9B5F89
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 11:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92486B21178
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 10:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7D91E3DF4;
	Wed, 30 Oct 2024 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tv2ii15t"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401C51E3DF0;
	Wed, 30 Oct 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282161; cv=fail; b=hhGJFY2H77u2O/xXAMyFR52gMTU+HgTiD1XZetr+OJu0QYejJ4jTqC0JorhPcNP54QX/ZRHNXBJNnsQPSWiIXTgdbqJudNoOvkPNDg46ve6hky3YdV07y7UR1kqjBahDSWMamGYzkYPc2ZtwQVuqEVc86KeLBmBHILr/RRIuJkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282161; c=relaxed/simple;
	bh=INVeBupvy2cGxoXb75qDtjwyGRZT4IU8RJxMIn66mWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CneDF1ffToOAEQ+7r1IIPjC/UeAFhZ97Vr9ZKJbv/Ad47iwid2Hi/YbruUBnv/LM8nYBj0nQoPeciASFC8ygiAe0uKD22Td0DgeEXVKBYUw+D73PiDBdxPYPJhhpjvPioLMetKwPaYPR+2B1o7yN1ajof4X0lyyvrmAw5B3dywo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tv2ii15t; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4x34l0eZ/qBVrvh4Qzwte8PKZAr52BbGbJnDSJe9+E0YaHsZ6yU09evc8KGau3Mnb+mh62qgQlfCqAoiLUtoywlnbAFFxSScDhLUoZ6kJ31Jnx5aVJtPGaoE1No4ePcaCyUmjRKEbQZiY3iVZCjG1YEFY/LU67yE32Y86x2lKlaooyfa9SVphMp7qrEEg1aeoUG1s2hVi55cWVZmCGQrGjsrowdCZyvJYhN1Q4cH3+OZQ+1vD3H96DgfYPrh5iH+HYySlPyVQD6a16n5Gh4z2btWKwDJX+ne738YM5RA+WTAca7/m4LoLIhEB+VnKcHaEutukW9rfIIHtPJydx/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6zcPzxzKup2kBuony84RRVBCouQ1NZX9F8Tw/hVJOk=;
 b=e++np/VouDnH0LlMPMG0ZvpJqEEA1PAzTPBSV/5W9FeGhkG38MF2PXoInKAGFHqeFx239fzSRJrpI2XCASHClXWqwhr9gQXNNSxXjozuOGgEn1H+uw3GpI6D4CZjZLJZmn2WOb4/rxX1IHaaQfcnaIQbrGBT4FD2Q7X2bwxRrKPx1NMqRqRwKDaclTWHHfR3GTUcmJrg97bzqvaWkzq8FvsGbiYh41uVwtqpV1E89Zx6zRUPBiqGtvpoCLeRW3q8p7eEi/R2miHqI9Z/fpFJ8f62llLtxQsEF675rKtqkMZ5T7bZNVF8RzOMtvrOk613WV6i4gGmJ+cYi9MZ2c09kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6zcPzxzKup2kBuony84RRVBCouQ1NZX9F8Tw/hVJOk=;
 b=Tv2ii15toUJwljlIK4hrCScJtEesdY+jX0FFlbXTZn+dbd5GzV7SSRoDx/kxc6A2BisQ91lgYdCu94x4e8Ebbcax2Wqw0yPW5Nc82q+nWDrtOwtvvl3Fr9jUvDUHOYmGMZ3t/pBniHSE0zagTBTQ0mcux/QthvRYLccPFPk8ZICid8f9DVHYT3F2lU5vh/DJjdEvFhxzywpS92QpFoiZwABMm+r+70wkmZRl7MyL+DXQm6SqEfODkJaMMhGkY8GkxQ6ata0qJ+X/1iePGAdPEEtaL8rriYLPGVEb+KIeDkvFMk/yJ5tyIgr6xjP9LOLWsh9Cf+fGQveemZpCVpcrbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8912.eurprd04.prod.outlook.com (2603:10a6:102:20f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 09:55:52 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:55:52 +0000
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
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v6 net-next 11/12] net: enetc: add preliminary support for i.MX95 ENETC PF
Date: Wed, 30 Oct 2024 17:39:22 +0800
Message-Id: <20241030093924.1251343-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030093924.1251343-1-wei.fang@nxp.com>
References: <20241030093924.1251343-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ccb9bd-c400-4845-adc6-08dcf8c90950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m+Vi81aOhls74g9AN/c7+rLlpZY3i6djrZlpD/Q2Ng9x91fIKc5wDL+0hn2w?=
 =?us-ascii?Q?lPVa/OeGdbc7pLVLWess2DyJVJY+tS8nxZmmOf5ZI46iGnhn6Uut/eKRg4GW?=
 =?us-ascii?Q?kmv+4DDJ8FujcRdB98K4QIt8I06CkMIiYv1MqkdEutKMcIRLVqVA2iqA0MP9?=
 =?us-ascii?Q?CvAfj5aHFupxy+262ewXqQXNg/rg9Zr69jNlioSW1tTC0nrshXXRWEar3OFy?=
 =?us-ascii?Q?ljv9KKbZ5R/HzIQXiQZU+EZP+Jpx2zAyGS4x+lhucJSliLg3CbkRXEvHIJLG?=
 =?us-ascii?Q?ZqVF8cLyx9F2SkDvetGcszqKhlmFXeqaCo6Ot0mVWnzva/fVs44MmodhGRMc?=
 =?us-ascii?Q?NmtPmjI7pSFDG8JqERqOrla3Hz9+4LLcqRqHhUg4WrjSV1+Esz6E0Drc96mD?=
 =?us-ascii?Q?9dgYfGStTSTshi+Wl9Z34G+PkzYHS7IeM5W/f/xUjuLFTszekV9VUPeRqxDg?=
 =?us-ascii?Q?DpGWOKsHkSyqZRnzxv7YK2Ip9nXuEB0HVMYPsrJxWLszbtzzWiaW6s4PFGJ7?=
 =?us-ascii?Q?/SWBY5SD6JKqRJALO3/x9nq+N+m2S8EXAMZrpWPzaNE5LphZDnpJY6YAPLaW?=
 =?us-ascii?Q?RyxCUnGe8pXjX7zvdL78SZ5Jxhj1kVwpHtmvRVLgLa6qGT/cdAMk/Ey4RM6b?=
 =?us-ascii?Q?oWuj2BX+jNSjqyu4qs7crL0wZqOoIwjunQzhrAseWMqPp+b8Yl0gVCVwdD9K?=
 =?us-ascii?Q?qzjZ14naMLh62o7AGukDmQ+kOun8D6JE7nDfKyQMVCLbz1rigNKbQKAJtUsH?=
 =?us-ascii?Q?FNGwJ/mWWx3r7q70uEQO2fK2k+b+TWVUegE81W6ufWDSMgz7EnwmQLT9XC1Z?=
 =?us-ascii?Q?Tcdn/jNREyo91oF7dfVLrphYXFMcw4EKs40AP4Vbi+/vzoyLQtZxG4w+Rh6v?=
 =?us-ascii?Q?aDjQ7RlVb1HoT1WZ4aVALItEhb3lCOSbZ3517fmGOG/iAvRP65p1KuMiEaF5?=
 =?us-ascii?Q?pTyfikl+3GgTfNQH9ckoqUpqbpFku3lMAxi4S+uI2FGrETvm9NR42JZpmxsO?=
 =?us-ascii?Q?0B8+UspqRvBa0SYykcqFs+MR0ByV10/jvykgUgPytV3IBphsSAEQiW7zk47o?=
 =?us-ascii?Q?srRt6ksb5M9W+GXYRfBQOkuX0etdruVAWy70vA/wc+9UEXCC6ZA0tjgAN55C?=
 =?us-ascii?Q?spJtsCDLQeDdsZZE91vuh1lTEr5R7mvNXBa6FzJ9irao3I/nc0JKT02qB31i?=
 =?us-ascii?Q?XWfx3GU3eVFNLEEl64l48n1lc4Li47pw2s5U4kJWC5dDmUgQXd1Iay8tI5xV?=
 =?us-ascii?Q?im0jPXNQUk4ZJ9FWnEa9ZlWthe6M5IeatAxe4zyWMW9X5tN6D6cNSGaJiEiv?=
 =?us-ascii?Q?ob4FENWD/TsOQTtUIsTqnj10dMsCXVElhsbeIB1gmjIhnl27h/FJLWD6pciQ?=
 =?us-ascii?Q?zWTBpE5Qz49wfRmc8W9qnelF8nU+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3nj75KhiNhOYolKLV9gST+QyZ9Ryqg1OS9LRVg6KcylrW8RBleFB7T8LXLK9?=
 =?us-ascii?Q?8gHuryZ9dQVGRQAenUYJMhjfnMcEn7pbxKXNdo1sdsK2Pj6in5u0+bSZmM7A?=
 =?us-ascii?Q?WzNmFHVDS0BZVJrROlKWVknMzZ8A2622pQ7VEReEaqxZ061js9QteyEZlvJz?=
 =?us-ascii?Q?BnShvCy99kbwrkXx8RenuZQ68t/xraBPbV7zKqQASpWg2bjFa0uxwPLuVYe0?=
 =?us-ascii?Q?P61LsvAzqQivqPV7S2nRMfMu0t1pQqZsiaPEN9TCJaKMYKfjOGlsWvkKeNfH?=
 =?us-ascii?Q?0YWDxDmWWCPJQKS5i5b1PxU9mBsBZgHUlnZryzqRfQPtMy3WxFi1qQOjjpmo?=
 =?us-ascii?Q?htgNdL3xcy6LBHJVKSOW1pKrgRuNep5VElVdfBphl5stpJnPmsbB/6A/nOu2?=
 =?us-ascii?Q?0I3u1y4us90aDJcHmzthybGNwaV9OUyUYpKtCT/J1eEYnBYdQYGJFSutjpil?=
 =?us-ascii?Q?f1hsC2oibI0xMuz1UnKorsSzbEX3aEXaBkpFC63bF1dVLAPlB0yGdEFU7/xv?=
 =?us-ascii?Q?DQdYAXZYmgteTHQICX8mVjtQiZxXSt4xv5gW/ugX+PKPj7gkp8bQn1wHm2rk?=
 =?us-ascii?Q?Qskh2s1uX0+CS3mp6CPn6SWL+nGuSRBdQSfNvrOH3ErwgVu/5YATW0E3o5yU?=
 =?us-ascii?Q?t4Bx7ILOGNGYCuLxdJIV6Nz5fpH5gYrr0IuGd7NLNUPJ3QnKpZ0c/MyYyTwu?=
 =?us-ascii?Q?vseuhsXNrc/EqDN6kS1DDOY79wxw7dI5kcwZKfpdHAi1+HZbsKL2AF5kZLmU?=
 =?us-ascii?Q?engb1MGJyzEUk1G4YVj/PRLPdBVs49Jxi1xPN447ANPzwG5NcJh4XEclk29P?=
 =?us-ascii?Q?3BJNET/O4dSt4Twrm+w4mZE/l9uCyILhjdvpF73y2thnduS5BEoE/f3OgPHw?=
 =?us-ascii?Q?hH5qi82J2D6Rz/jTqXw66fryPz7l+D8wnrZSwIVvsRNrDB2oigA/A8CVmL/F?=
 =?us-ascii?Q?kyyLu55AhuRYcYxa1hel/OQ/28pOAHoQjOnZ42HDqW1jkyX055Lj6HONsMJ3?=
 =?us-ascii?Q?nGVCyhwO1pnZI09r/vtB0juxD3A1bphALp1pKkvq+Od+PjPaBdsqv2st5lUp?=
 =?us-ascii?Q?n8CnZpWI7v1CZv87l8ywqiPlqiMzx1LI1wJCLDdSO8HptgsJw0Myzzu4yaLN?=
 =?us-ascii?Q?7vmyvJU99q9HfXENK2AJ3A+E9x0IGILjIta/lJ3BdV4cgx09qwm+0bUf6gzC?=
 =?us-ascii?Q?WWcKJGP7O0aqd+8Sq+ug7Wy/6tIXweA3CrNIyQ6dRq72lhFOfofs8N2Fgrxo?=
 =?us-ascii?Q?CWN4f17h5FKRWyAfdBmgCx6zvQ1bD3FzD7BVIQkN5CKYwlI87ClgB4sfRM/r?=
 =?us-ascii?Q?3OtXicw/2bQhv3hnbDEXt73f2yp0PEPs9SgU6PW4lPab83PeB3B1hpND1XNa?=
 =?us-ascii?Q?+RQ4wcrdWgsiXYXzO6XUK2dmMRiwUhrqjyLBrODslrAq0tuSK7wc5bkxVu8F?=
 =?us-ascii?Q?P7hX8UVit/4MAQHSISfZ0yK+pEcZ4gskPr2Qbk1VXRtx4/j12Fhx/+AU2uJj?=
 =?us-ascii?Q?sEZzUD+4y1X5GFABPW0sxZEv7vlGYBEMkWYxFSO0rWK2azBSRfy0zCFkF0zi?=
 =?us-ascii?Q?Hk4k+BURv/k0gY/u07S2Z5Xw6LNOVXx88COF5p/g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ccb9bd-c400-4845-adc6-08dcf8c90950
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:55:51.9672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNJp6U5V9iYkIwZG9jak5qDVXQ5Wfal+LuqfD6GO0ECfCWNmbP4OHFD0zNLcmbuCXWMw40ruD47wbkGz5n6SWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8912

The i.MX95 ENETC has been upgraded to revision 4.1, which is different
from the LS1028A ENETC (revision 1.0) except for the SI part. Therefore,
the fsl-enetc driver is incompatible with i.MX95 ENETC PF. So add new
nxp-enetc4 driver to support i.MX95 ENETC PF, and this driver will be
used to support the ENETC PF with major revision 4 for other SoCs in the
future.

Currently, the nxp-enetc4 driver only supports basic transmission feature
for i.MX95 ENETC PF, the more basic and advanced features will be added
in the subsequent patches. In addition, PCS support has not been added
yet, so 10G ENETC (ENETC instance 2) is not supported now.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v6:
1. remove pinctrl_pm_select_default_state()
2. add macros to define the vendor ID and device ID of ENETC PF
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  17 +
 drivers/net/ethernet/freescale/enetc/Makefile |   3 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  86 +-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  30 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  | 155 ++++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 756 ++++++++++++++++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  35 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  19 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   |   7 +
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   9 +
 .../freescale/enetc/enetc_pf_common.c         |  11 +-
 .../freescale/enetc/enetc_pf_common.h         |   5 +
 .../net/ethernet/freescale/enetc/enetc_qos.c  |   2 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   6 +
 14 files changed, 1113 insertions(+), 28 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_hw.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_pf.c

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index e1b151a98b41..6c2779047dcd 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -33,6 +33,23 @@ config FSL_ENETC
 
 	  If compiled as module (M), the module name is fsl-enetc.
 
+config NXP_ENETC4
+	tristate "ENETC4 PF driver"
+	depends on PCI_MSI
+	select MDIO_DEVRES
+	select FSL_ENETC_CORE
+	select FSL_ENETC_MDIO
+	select NXP_ENETC_PF_COMMON
+	select PHYLINK
+	select DIMLIB
+	help
+	  This driver supports NXP ENETC devices with major revision 4. ENETC is
+	  as the NIC functionality in NETC, it supports virtualization/isolation
+	  based on PCIe Single Root IO Virtualization (SR-IOV) and a full range
+	  of TSN standards and NIC offload capabilities.
+
+	  If compiled as module (M), the module name is nxp-enetc4.
+
 config FSL_ENETC_VF
 	tristate "ENETC VF driver"
 	depends on PCI_MSI
diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index ebe232673ed4..6fd27ee4fcd1 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -11,6 +11,9 @@ fsl-enetc-y := enetc_pf.o
 fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
 fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
 
+obj-$(CONFIG_NXP_ENETC4) += nxp-enetc4.o
+nxp-enetc4-y := enetc4_pf.o
+
 obj-$(CONFIG_FSL_ENETC_VF) += fsl-enetc-vf.o
 fsl-enetc-vf-y := enetc_vf.o
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 89d919c713df..4be7c767d1e9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3,6 +3,7 @@
 
 #include "enetc.h"
 #include <linux/bpf_trace.h>
+#include <linux/clk.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
 #include <linux/vmalloc.h>
@@ -21,7 +22,7 @@ void enetc_port_mac_wr(struct enetc_si *si, u32 reg, u32 val)
 {
 	enetc_port_wr(&si->hw, reg, val);
 	if (si->hw_features & ENETC_SI_F_QBU)
-		enetc_port_wr(&si->hw, reg + ENETC_PMAC_OFFSET, val);
+		enetc_port_wr(&si->hw, reg + si->drvdata->pmac_offset, val);
 }
 EXPORT_SYMBOL_GPL(enetc_port_mac_wr);
 
@@ -700,8 +701,9 @@ static void enetc_rx_dim_work(struct work_struct *w)
 		net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 	struct enetc_int_vector	*v =
 		container_of(dim, struct enetc_int_vector, rx_dim);
+	struct enetc_ndev_priv *priv = netdev_priv(v->rx_ring.ndev);
 
-	v->rx_ictt = enetc_usecs_to_cycles(moder.usec);
+	v->rx_ictt = enetc_usecs_to_cycles(moder.usec, priv->sysclk_freq);
 	dim->state = DIM_START_MEASURE;
 }
 
@@ -1736,9 +1738,15 @@ void enetc_get_si_caps(struct enetc_si *si)
 	si->num_rx_rings = (val >> 16) & 0xff;
 	si->num_tx_rings = val & 0xff;
 
-	val = enetc_rd(hw, ENETC_SIRFSCAPR);
-	si->num_fs_entries = ENETC_SIRFSCAPR_GET_NUM_RFS(val);
-	si->num_fs_entries = min(si->num_fs_entries, ENETC_MAX_RFS_SIZE);
+	val = enetc_rd(hw, ENETC_SIPCAPR0);
+	if (val & ENETC_SIPCAPR0_RFS) {
+		val = enetc_rd(hw, ENETC_SIRFSCAPR);
+		si->num_fs_entries = ENETC_SIRFSCAPR_GET_NUM_RFS(val);
+		si->num_fs_entries = min(si->num_fs_entries, ENETC_MAX_RFS_SIZE);
+	} else {
+		/* ENETC which not supports RFS */
+		si->num_fs_entries = 0;
+	}
 
 	si->num_rss = 0;
 	val = enetc_rd(hw, ENETC_SIPCAPR0);
@@ -2066,7 +2074,10 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
 	/* enable SI */
 	enetc_wr(hw, ENETC_SIMR, ENETC_SIMR_EN);
 
-	if (si->num_rss) {
+	/* TODO: RSS support for i.MX95 will be supported later, and the
+	 * is_enetc_rev1() condition will be removed
+	 */
+	if (si->num_rss && is_enetc_rev1(si)) {
 		err = enetc_setup_default_rss_table(si, priv->num_rx_rings);
 		if (err)
 			return err;
@@ -2090,9 +2101,9 @@ void enetc_init_si_rings_params(struct enetc_ndev_priv *priv)
 	 */
 	priv->num_rx_rings = min_t(int, cpus, si->num_rx_rings);
 	priv->num_tx_rings = si->num_tx_rings;
-	priv->bdr_int_num = cpus;
+	priv->bdr_int_num = priv->num_rx_rings;
 	priv->ic_mode = ENETC_IC_RX_ADAPTIVE | ENETC_IC_TX_MANUAL;
-	priv->tx_ictt = ENETC_TXIC_TIMETHR;
+	priv->tx_ictt = enetc_usecs_to_cycles(600, priv->sysclk_freq);
 }
 EXPORT_SYMBOL_GPL(enetc_init_si_rings_params);
 
@@ -2501,10 +2512,14 @@ int enetc_open(struct net_device *ndev)
 
 	extended = !!(priv->active_offloads & ENETC_F_RX_TSTAMP);
 
-	err = enetc_setup_irqs(priv);
+	err = clk_prepare_enable(priv->ref_clk);
 	if (err)
 		return err;
 
+	err = enetc_setup_irqs(priv);
+	if (err)
+		goto err_setup_irqs;
+
 	err = enetc_phylink_connect(ndev);
 	if (err)
 		goto err_phy_connect;
@@ -2536,6 +2551,8 @@ int enetc_open(struct net_device *ndev)
 		phylink_disconnect_phy(priv->phylink);
 err_phy_connect:
 	enetc_free_irqs(priv);
+err_setup_irqs:
+	clk_disable_unprepare(priv->ref_clk);
 
 	return err;
 }
@@ -2589,6 +2606,7 @@ int enetc_close(struct net_device *ndev)
 	enetc_assign_tx_resources(priv, NULL);
 
 	enetc_free_irqs(priv);
+	clk_disable_unprepare(priv->ref_clk);
 
 	return 0;
 }
@@ -3254,5 +3272,55 @@ void enetc_pci_remove(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(enetc_pci_remove);
 
+static const struct enetc_drvdata enetc_pf_data = {
+	.sysclk_freq = ENETC_CLK_400M,
+	.pmac_offset = ENETC_PMAC_OFFSET,
+	.eth_ops = &enetc_pf_ethtool_ops,
+};
+
+static const struct enetc_drvdata enetc4_pf_data = {
+	.sysclk_freq = ENETC_CLK_333M,
+	.pmac_offset = ENETC4_PMAC_OFFSET,
+	.eth_ops = &enetc4_pf_ethtool_ops,
+};
+
+static const struct enetc_drvdata enetc_vf_data = {
+	.sysclk_freq = ENETC_CLK_400M,
+	.eth_ops = &enetc_vf_ethtool_ops,
+};
+
+static const struct enetc_platform_info enetc_info[] = {
+	{ .revision = ENETC_REV_1_0,
+	  .dev_id = ENETC_DEV_ID_PF,
+	  .data = &enetc_pf_data,
+	},
+	{ .revision = ENETC_REV_4_1,
+	  .dev_id = NXP_ENETC_PF_DEV_ID,
+	  .data = &enetc4_pf_data,
+	},
+	{ .revision = ENETC_REV_1_0,
+	  .dev_id = ENETC_DEV_ID_VF,
+	  .data = &enetc_vf_data,
+	},
+};
+
+int enetc_get_driver_data(struct enetc_si *si)
+{
+	u16 dev_id = si->pdev->device;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(enetc_info); i++) {
+		if (si->revision == enetc_info[i].revision &&
+		    dev_id == enetc_info[i].dev_id) {
+			si->drvdata = enetc_info[i].data;
+
+			return 0;
+		}
+	}
+
+	return -ERANGE;
+}
+EXPORT_SYMBOL_GPL(enetc_get_driver_data);
+
 MODULE_DESCRIPTION("NXP ENETC Ethernet driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index fb7d98d57783..72fa03dbc2dd 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -14,6 +14,7 @@
 #include <net/xdp.h>
 
 #include "enetc_hw.h"
+#include "enetc4_hw.h"
 
 #define ENETC_MAC_MAXFRM_SIZE	9600
 #define ENETC_MAX_MTU		(ENETC_MAC_MAXFRM_SIZE - \
@@ -231,6 +232,18 @@ enum enetc_errata {
 #define ENETC_SI_F_QBV  BIT(1)
 #define ENETC_SI_F_QBU  BIT(2)
 
+struct enetc_drvdata {
+	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
+	u64 sysclk_freq;
+	const struct ethtool_ops *eth_ops;
+};
+
+struct enetc_platform_info {
+	u16 revision;
+	u16 dev_id;
+	const struct enetc_drvdata *data;
+};
+
 /* PCI IEP device data */
 struct enetc_si {
 	struct pci_dev *pdev;
@@ -246,11 +259,18 @@ struct enetc_si {
 	int num_fs_entries;
 	int num_rss; /* number of RSS buckets */
 	unsigned short pad;
+	u16 revision;
 	int hw_features;
+	const struct enetc_drvdata *drvdata;
 };
 
 #define ENETC_SI_ALIGN	32
 
+static inline bool is_enetc_rev1(struct enetc_si *si)
+{
+	return si->pdev->revision == ENETC_REV1;
+}
+
 static inline void *enetc_si_priv(const struct enetc_si *si)
 {
 	return (char *)si + ALIGN(sizeof(struct enetc_si), ENETC_SI_ALIGN);
@@ -302,7 +322,7 @@ struct enetc_cls_rule {
 	int used;
 };
 
-#define ENETC_MAX_BDR_INT	2 /* fixed to max # of available cpus */
+#define ENETC_MAX_BDR_INT	6 /* fixed to max # of available cpus */
 struct psfp_cap {
 	u32 max_streamid;
 	u32 max_psfp_filter;
@@ -341,7 +361,6 @@ enum enetc_ic_mode {
 
 #define ENETC_RXIC_PKTTHR	min_t(u32, 256, ENETC_RX_RING_DEFAULT_SIZE / 2)
 #define ENETC_TXIC_PKTTHR	min_t(u32, 128, ENETC_TX_RING_DEFAULT_SIZE / 2)
-#define ENETC_TXIC_TIMETHR	enetc_usecs_to_cycles(600)
 
 struct enetc_ndev_priv {
 	struct net_device *ndev;
@@ -389,6 +408,9 @@ struct enetc_ndev_priv {
 	 * and link state updates
 	 */
 	struct mutex		mm_lock;
+
+	struct clk *ref_clk; /* RGMII/RMII reference clock */
+	u64 sysclk_freq; /* NETC system clock frequency */
 };
 
 /* Messaging */
@@ -418,6 +440,7 @@ void enetc_init_si_rings_params(struct enetc_ndev_priv *priv);
 int enetc_alloc_si_resources(struct enetc_ndev_priv *priv);
 void enetc_free_si_resources(struct enetc_ndev_priv *priv);
 int enetc_configure_si(struct enetc_ndev_priv *priv);
+int enetc_get_driver_data(struct enetc_si *si);
 
 int enetc_open(struct net_device *ndev);
 int enetc_close(struct net_device *ndev);
@@ -434,6 +457,9 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 		   struct xdp_frame **frames, u32 flags);
 
 /* ethtool */
+extern const struct ethtool_ops enetc_pf_ethtool_ops;
+extern const struct ethtool_ops enetc4_pf_ethtool_ops;
+extern const struct ethtool_ops enetc_vf_ethtool_ops;
 void enetc_set_ethtool_ops(struct net_device *ndev);
 void enetc_mm_link_state_update(struct enetc_ndev_priv *priv, bool link);
 void enetc_mm_commit_preemptible_tcs(struct enetc_ndev_priv *priv);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
new file mode 100644
index 000000000000..26b220677448
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -0,0 +1,155 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * This header file defines the register offsets and bit fields
+ * of ENETC4 PF and VFs. Note that the same registers as ENETC
+ * version 1.0 are defined in the enetc_hw.h file.
+ *
+ * Copyright 2024 NXP
+ */
+#ifndef __ENETC4_HW_H_
+#define __ENETC4_HW_H_
+
+#define NXP_ENETC_VENDOR_ID		0x1131
+#define NXP_ENETC_PF_DEV_ID		0xe101
+
+/***************************ENETC port registers**************************/
+#define ENETC4_ECAPR0			0x0
+#define  ECAPR0_RFS			BIT(2)
+#define  ECAPR0_TSD			BIT(5)
+#define  ECAPR0_RSS			BIT(8)
+#define  ECAPR0_RSC			BIT(9)
+#define  ECAPR0_LSO			BIT(10)
+#define  ECAPR0_WO			BIT(13)
+
+#define ENETC4_ECAPR1			0x4
+#define  ECAPR1_NUM_TCS			GENMASK(6, 4)
+#define  ECAPR1_NUM_MCH			GENMASK(9, 8)
+#define  ECAPR1_NUM_UCH			GENMASK(11, 10)
+#define  ECAPR1_NUM_MSIX		GENMASK(22, 12)
+#define  ECAPR1_NUM_VSI			GENMASK(27, 24)
+#define  ECAPR1_NUM_IPV			BIT(31)
+
+#define ENETC4_ECAPR2			0x8
+#define  ECAPR2_NUM_TX_BDR		GENMASK(9, 0)
+#define  ECAPR2_NUM_RX_BDR		GENMASK(25, 16)
+
+#define ENETC4_PMR			0x10
+#define  PMR_SI_EN(a)			BIT((16 + (a)))
+
+/* Port Pause ON/OFF threshold register */
+#define ENETC4_PPAUONTR			0x108
+#define ENETC4_PPAUOFFTR		0x10c
+
+/* Port Station interface promiscuous MAC mode register */
+#define ENETC4_PSIPMMR			0x200
+#define  PSIPMMR_SI_MAC_UP(a)		BIT(a) /* a = SI index */
+#define  PSIPMMR_SI_MAC_MP(a)		BIT((a) + 16)
+
+/* Port Station interface promiscuous VLAN mode register */
+#define ENETC4_PSIPVMR			0x204
+
+/* Port RSS key register n. n = 0,1,2,...,9 */
+#define ENETC4_PRSSKR(n)		((n) * 0x4 + 0x250)
+
+/* Port station interface MAC address filtering capability register */
+#define ENETC4_PSIMAFCAPR		0x280
+#define  PSIMAFCAPR_NUM_MAC_AFTE	GENMASK(11, 0)
+
+/* Port station interface VLAN filtering capability register */
+#define ENETC4_PSIVLANFCAPR		0x2c0
+#define  PSIVLANFCAPR_NUM_VLAN_FTE	GENMASK(11, 0)
+
+/* Port station interface VLAN filtering mode register */
+#define ENETC4_PSIVLANFMR		0x2c4
+#define  PSIVLANFMR_VS			BIT(0)
+
+/* Port Station interface a primary MAC address registers */
+#define ENETC4_PSIPMAR0(a)		((a) * 0x80 + 0x2000)
+#define ENETC4_PSIPMAR1(a)		((a) * 0x80 + 0x2004)
+
+/* Port station interface a configuration register 0/2 */
+#define ENETC4_PSICFGR0(a)		((a) * 0x80 + 0x2010)
+#define  PSICFGR0_VASE			BIT(13)
+#define  PSICFGR0_ASE			BIT(15)
+#define  PSICFGR0_ANTI_SPOOFING		(PSICFGR0_VASE | PSICFGR0_ASE)
+
+#define ENETC4_PSICFGR2(a)		((a) * 0x80 + 0x2018)
+#define  PSICFGR2_NUM_MSIX		GENMASK(5, 0)
+
+#define ENETC4_PMCAPR			0x4004
+#define  PMCAPR_HD			BIT(8)
+#define  PMCAPR_FP			GENMASK(10, 9)
+
+/* Port configuration register */
+#define ENETC4_PCR			0x4010
+#define  PCR_HDR_FMT			BIT(0)
+#define  PCR_L2DOSE			BIT(4)
+#define  PCR_TIMER_CS			BIT(8)
+#define  PCR_PSPEED			GENMASK(29, 16)
+#define  PCR_PSPEED_VAL(speed)		(((speed) / 10 - 1) << 16)
+
+/* Port MAC address register 0/1 */
+#define ENETC4_PMAR0			0x4020
+#define ENETC4_PMAR1			0x4024
+
+/* Port operational register */
+#define ENETC4_POR			0x4100
+
+/* Port traffic class a transmit maximum SDU register */
+#define ENETC4_PTCTMSDUR(a)		((a) * 0x20 + 0x4208)
+#define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
+#define  PTCTMSDUR_SDU_TYPE		GENMASK(17, 16)
+#define   SDU_TYPE_PPDU			0
+#define   SDU_TYPE_MPDU			1
+#define   SDU_TYPE_MSDU			2
+
+#define ENETC4_PMAC_OFFSET		0x400
+#define ENETC4_PM_CMD_CFG(mac)		(0x5008 + (mac) * 0x400)
+#define  PM_CMD_CFG_TX_EN		BIT(0)
+#define  PM_CMD_CFG_RX_EN		BIT(1)
+#define  PM_CMD_CFG_PAUSE_FWD		BIT(7)
+#define  PM_CMD_CFG_PAUSE_IGN		BIT(8)
+#define  PM_CMD_CFG_TX_ADDR_INS		BIT(9)
+#define  PM_CMD_CFG_LOOP_EN		BIT(10)
+#define  PM_CMD_CFG_LPBK_MODE		GENMASK(12, 11)
+#define   LPBCK_MODE_EXT_TX_CLK		0
+#define   LPBCK_MODE_MAC_LEVEL		1
+#define   LPBCK_MODE_INT_TX_CLK		2
+#define  PM_CMD_CFG_CNT_FRM_EN		BIT(13)
+#define  PM_CMD_CFG_TXP			BIT(15)
+#define  PM_CMD_CFG_SEND_IDLE		BIT(16)
+#define  PM_CMD_CFG_HD_FCEN		BIT(18)
+#define  PM_CMD_CFG_SFD			BIT(21)
+#define  PM_CMD_CFG_TX_FLUSH		BIT(22)
+#define  PM_CMD_CFG_TX_LOWP_EN		BIT(23)
+#define  PM_CMD_CFG_RX_LOWP_EMPTY	BIT(24)
+#define  PM_CMD_CFG_SWR			BIT(26)
+#define  PM_CMD_CFG_TS_MODE		BIT(30)
+#define  PM_CMD_CFG_MG			BIT(31)
+
+/* Port MAC 0/1 Maximum Frame Length Register */
+#define ENETC4_PM_MAXFRM(mac)		(0x5014 + (mac) * 0x400)
+
+/* Port MAC 0/1 Pause Quanta Register */
+#define ENETC4_PM_PAUSE_QUANTA(mac)	(0x5054 + (mac) * 0x400)
+
+/* Port MAC 0/1 Pause Quanta Threshold Register */
+#define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
+
+/* Port MAC 0 Interface Mode Control Register */
+#define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
+#define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
+#define   IFMODE_XGMII			0
+#define   IFMODE_RMII			3
+#define   IFMODE_RGMII			4
+#define   IFMODE_SGMII			5
+#define  PM_IF_MODE_REVMII		BIT(3)
+#define  PM_IF_MODE_M10			BIT(4)
+#define  PM_IF_MODE_HD			BIT(6)
+#define  PM_IF_MODE_SSP			GENMASK(14, 13)
+#define   SSP_100M			0
+#define   SSP_10M			1
+#define   SSP_1G			2
+#define  PM_IF_MODE_ENA			BIT(15)
+
+#endif
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
new file mode 100644
index 000000000000..31dbe89dd3a9
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -0,0 +1,756 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* Copyright 2024 NXP */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+#include <linux/unaligned.h>
+
+#include "enetc_pf_common.h"
+
+#define ENETC_SI_MAX_RING_NUM	8
+
+static void enetc4_get_port_caps(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_ECAPR1);
+	pf->caps.num_vsi = (val & ECAPR1_NUM_VSI) >> 24;
+	pf->caps.num_msix = ((val & ECAPR1_NUM_MSIX) >> 12) + 1;
+
+	val = enetc_port_rd(hw, ENETC4_ECAPR2);
+	pf->caps.num_rx_bdr = (val & ECAPR2_NUM_RX_BDR) >> 16;
+	pf->caps.num_tx_bdr = val & ECAPR2_NUM_TX_BDR;
+
+	val = enetc_port_rd(hw, ENETC4_PMCAPR);
+	pf->caps.half_duplex = (val & PMCAPR_HD) ? 1 : 0;
+}
+
+static void enetc4_pf_set_si_primary_mac(struct enetc_hw *hw, int si,
+					 const u8 *addr)
+{
+	u16 lower = get_unaligned_le16(addr + 4);
+	u32 upper = get_unaligned_le32(addr);
+
+	if (si != 0) {
+		__raw_writel(upper, hw->port + ENETC4_PSIPMAR0(si));
+		__raw_writew(lower, hw->port + ENETC4_PSIPMAR1(si));
+	} else {
+		__raw_writel(upper, hw->port + ENETC4_PMAR0);
+		__raw_writew(lower, hw->port + ENETC4_PMAR1);
+	}
+}
+
+static void enetc4_pf_get_si_primary_mac(struct enetc_hw *hw, int si,
+					 u8 *addr)
+{
+	u32 upper;
+	u16 lower;
+
+	upper = __raw_readl(hw->port + ENETC4_PSIPMAR0(si));
+	lower = __raw_readw(hw->port + ENETC4_PSIPMAR1(si));
+
+	put_unaligned_le32(upper, addr);
+	put_unaligned_le16(lower, addr + 4);
+}
+
+static const struct enetc_pf_ops enetc4_pf_ops = {
+	.set_si_primary_mac = enetc4_pf_set_si_primary_mac,
+	.get_si_primary_mac = enetc4_pf_get_si_primary_mac,
+};
+
+static int enetc4_pf_struct_init(struct enetc_si *si)
+{
+	struct enetc_pf *pf = enetc_si_priv(si);
+
+	pf->si = si;
+	pf->total_vfs = pci_sriov_get_totalvfs(si->pdev);
+	pf->ops = &enetc4_pf_ops;
+
+	enetc4_get_port_caps(pf);
+
+	return 0;
+}
+
+static u32 enetc4_psicfgr0_val_construct(bool is_vf, u32 num_tx_bdr, u32 num_rx_bdr)
+{
+	u32 val;
+
+	val = ENETC_PSICFGR0_SET_TXBDR(num_tx_bdr);
+	val |= ENETC_PSICFGR0_SET_RXBDR(num_rx_bdr);
+	val |= ENETC_PSICFGR0_SIVC(ENETC_VLAN_TYPE_C | ENETC_VLAN_TYPE_S);
+
+	if (is_vf)
+		val |= ENETC_PSICFGR0_VTE | ENETC_PSICFGR0_SIVIE;
+
+	return val;
+}
+
+static void enetc4_default_rings_allocation(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	u32 num_rx_bdr, num_tx_bdr, val;
+	u32 vf_tx_bdr, vf_rx_bdr;
+	int i, rx_rem, tx_rem;
+
+	if (pf->caps.num_rx_bdr < ENETC_SI_MAX_RING_NUM + pf->caps.num_vsi)
+		num_rx_bdr = pf->caps.num_rx_bdr - pf->caps.num_vsi;
+	else
+		num_rx_bdr = ENETC_SI_MAX_RING_NUM;
+
+	if (pf->caps.num_tx_bdr < ENETC_SI_MAX_RING_NUM + pf->caps.num_vsi)
+		num_tx_bdr = pf->caps.num_tx_bdr - pf->caps.num_vsi;
+	else
+		num_tx_bdr = ENETC_SI_MAX_RING_NUM;
+
+	val = enetc4_psicfgr0_val_construct(false, num_tx_bdr, num_rx_bdr);
+	enetc_port_wr(hw, ENETC4_PSICFGR0(0), val);
+
+	num_rx_bdr = pf->caps.num_rx_bdr - num_rx_bdr;
+	rx_rem = num_rx_bdr % pf->caps.num_vsi;
+	num_rx_bdr = num_rx_bdr / pf->caps.num_vsi;
+
+	num_tx_bdr = pf->caps.num_tx_bdr - num_tx_bdr;
+	tx_rem = num_tx_bdr % pf->caps.num_vsi;
+	num_tx_bdr = num_tx_bdr / pf->caps.num_vsi;
+
+	for (i = 0; i < pf->caps.num_vsi; i++) {
+		vf_tx_bdr = (i < tx_rem) ? num_tx_bdr + 1 : num_tx_bdr;
+		vf_rx_bdr = (i < rx_rem) ? num_rx_bdr + 1 : num_rx_bdr;
+		val = enetc4_psicfgr0_val_construct(true, vf_tx_bdr, vf_rx_bdr);
+		enetc_port_wr(hw, ENETC4_PSICFGR0(i + 1), val);
+	}
+}
+
+static void enetc4_allocate_si_rings(struct enetc_pf *pf)
+{
+	enetc4_default_rings_allocation(pf);
+}
+
+static void enetc4_pf_set_si_vlan_promisc(struct enetc_hw *hw, int si, bool en)
+{
+	u32 val = enetc_port_rd(hw, ENETC4_PSIPVMR);
+
+	if (en)
+		val |= BIT(si);
+	else
+		val &= ~BIT(si);
+
+	enetc_port_wr(hw, ENETC4_PSIPVMR, val);
+}
+
+static void enetc4_set_default_si_vlan_promisc(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	int num_si = pf->caps.num_vsi + 1;
+	int i;
+
+	/* enforce VLAN promiscuous mode for all SIs */
+	for (i = 0; i < num_si; i++)
+		enetc4_pf_set_si_vlan_promisc(hw, i, true);
+}
+
+/* Allocate the number of MSI-X vectors for per SI. */
+static void enetc4_set_si_msix_num(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	int i, num_msix, total_si;
+	u32 val;
+
+	total_si = pf->caps.num_vsi + 1;
+
+	num_msix = pf->caps.num_msix / total_si +
+		   pf->caps.num_msix % total_si - 1;
+	val = num_msix & PSICFGR2_NUM_MSIX;
+	enetc_port_wr(hw, ENETC4_PSICFGR2(0), val);
+
+	num_msix = pf->caps.num_msix / total_si - 1;
+	val = num_msix & PSICFGR2_NUM_MSIX;
+	for (i = 0; i < pf->caps.num_vsi; i++)
+		enetc_port_wr(hw, ENETC4_PSICFGR2(i + 1), val);
+}
+
+static void enetc4_enable_all_si(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	int num_si = pf->caps.num_vsi + 1;
+	u32 si_bitmap = 0;
+	int i;
+
+	/* Master enable for all SIs */
+	for (i = 0; i < num_si; i++)
+		si_bitmap |= PMR_SI_EN(i);
+
+	enetc_port_wr(hw, ENETC4_PMR, si_bitmap);
+}
+
+static void enetc4_configure_port_si(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+
+	enetc4_allocate_si_rings(pf);
+
+	/* Outer VLAN tag will be used for VLAN filtering */
+	enetc_port_wr(hw, ENETC4_PSIVLANFMR, PSIVLANFMR_VS);
+
+	enetc4_set_default_si_vlan_promisc(pf);
+
+	/* Disable SI MAC multicast & unicast promiscuous */
+	enetc_port_wr(hw, ENETC4_PSIPMMR, 0);
+
+	enetc4_set_si_msix_num(pf);
+
+	enetc4_enable_all_si(pf);
+}
+
+static void enetc4_pf_reset_tc_msdu(struct enetc_hw *hw)
+{
+	u32 val = ENETC_MAC_MAXFRM_SIZE;
+	int tc;
+
+	val = u32_replace_bits(val, SDU_TYPE_MPDU, PTCTMSDUR_SDU_TYPE);
+
+	for (tc = 0; tc < ENETC_NUM_TC; tc++)
+		enetc_port_wr(hw, ENETC4_PTCTMSDUR(tc), val);
+}
+
+static void enetc4_set_trx_frame_size(struct enetc_pf *pf)
+{
+	struct enetc_si *si = pf->si;
+
+	enetc_port_mac_wr(si, ENETC4_PM_MAXFRM(0),
+			  ENETC_SET_MAXFRM(ENETC_MAC_MAXFRM_SIZE));
+
+	enetc4_pf_reset_tc_msdu(&si->hw);
+}
+
+static void enetc4_set_rss_key(struct enetc_hw *hw, const u8 *bytes)
+{
+	int i;
+
+	for (i = 0; i < ENETC_RSSHASH_KEY_SIZE / 4; i++)
+		enetc_port_wr(hw, ENETC4_PRSSKR(i), ((u32 *)bytes)[i]);
+}
+
+static void enetc4_set_default_rss_key(struct enetc_pf *pf)
+{
+	u8 hash_key[ENETC_RSSHASH_KEY_SIZE] = {0};
+	struct enetc_hw *hw = &pf->si->hw;
+
+	/* set up hash key */
+	get_random_bytes(hash_key, ENETC_RSSHASH_KEY_SIZE);
+	enetc4_set_rss_key(hw, hash_key);
+}
+
+static void enetc4_enable_trx(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+
+	/* Enable port transmit/receive */
+	enetc_port_wr(hw, ENETC4_POR, 0);
+}
+
+static void enetc4_configure_port(struct enetc_pf *pf)
+{
+	enetc4_configure_port_si(pf);
+	enetc4_set_trx_frame_size(pf);
+	enetc4_set_default_rss_key(pf);
+	enetc4_enable_trx(pf);
+}
+
+static int enetc4_pf_init(struct enetc_pf *pf)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	int err;
+
+	/* Initialize the MAC address for PF and VFs */
+	err = enetc_setup_mac_addresses(dev->of_node, pf);
+	if (err) {
+		dev_err(dev, "Failed to set MAC addresses\n");
+		return err;
+	}
+
+	enetc4_configure_port(pf);
+
+	return 0;
+}
+
+static const struct net_device_ops enetc4_ndev_ops = {
+	.ndo_open		= enetc_open,
+	.ndo_stop		= enetc_close,
+	.ndo_start_xmit		= enetc_xmit,
+	.ndo_get_stats		= enetc_get_stats,
+	.ndo_set_mac_address	= enetc_pf_set_mac_addr,
+};
+
+static struct phylink_pcs *
+enetc4_pl_mac_select_pcs(struct phylink_config *config, phy_interface_t iface)
+{
+	struct enetc_pf *pf = phylink_to_enetc_pf(config);
+
+	return pf->pcs;
+}
+
+static void enetc4_mac_config(struct enetc_pf *pf, unsigned int mode,
+			      phy_interface_t phy_mode)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(pf->si->ndev);
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	val = enetc_port_mac_rd(si, ENETC4_PM_IF_MODE(0));
+	val &= ~(PM_IF_MODE_IFMODE | PM_IF_MODE_ENA);
+
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val |= IFMODE_RGMII;
+		/* We need to enable auto-negotiation for the MAC
+		 * if its RGMII interface support In-Band status.
+		 */
+		if (phylink_autoneg_inband(mode))
+			val |= PM_IF_MODE_ENA;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		val |= IFMODE_RMII;
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		val |= IFMODE_SGMII;
+		break;
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_XGMII:
+	case PHY_INTERFACE_MODE_USXGMII:
+		val |= IFMODE_XGMII;
+		break;
+	default:
+		dev_err(priv->dev,
+			"Unsupported PHY mode:%d\n", phy_mode);
+		return;
+	}
+
+	enetc_port_mac_wr(si, ENETC4_PM_IF_MODE(0), val);
+}
+
+static void enetc4_pl_mac_config(struct phylink_config *config, unsigned int mode,
+				 const struct phylink_link_state *state)
+{
+	struct enetc_pf *pf = phylink_to_enetc_pf(config);
+
+	enetc4_mac_config(pf, mode, state->interface);
+}
+
+static void enetc4_set_port_speed(struct enetc_ndev_priv *priv, int speed)
+{
+	u32 old_speed = priv->speed;
+	u32 val;
+
+	if (speed == old_speed)
+		return;
+
+	val = enetc_port_rd(&priv->si->hw, ENETC4_PCR);
+	val &= ~PCR_PSPEED;
+
+	switch (speed) {
+	case SPEED_100:
+	case SPEED_1000:
+	case SPEED_2500:
+	case SPEED_10000:
+		val |= (PCR_PSPEED & PCR_PSPEED_VAL(speed));
+		break;
+	case SPEED_10:
+	default:
+		val |= (PCR_PSPEED & PCR_PSPEED_VAL(SPEED_10));
+	}
+
+	priv->speed = speed;
+	enetc_port_wr(&priv->si->hw, ENETC4_PCR, val);
+}
+
+static void enetc4_set_rgmii_mac(struct enetc_pf *pf, int speed, int duplex)
+{
+	struct enetc_si *si = pf->si;
+	u32 old_val, val;
+
+	old_val = enetc_port_mac_rd(si, ENETC4_PM_IF_MODE(0));
+	val = old_val & ~(PM_IF_MODE_ENA | PM_IF_MODE_M10 | PM_IF_MODE_REVMII);
+
+	switch (speed) {
+	case SPEED_1000:
+		val = u32_replace_bits(val, SSP_1G, PM_IF_MODE_SSP);
+		break;
+	case SPEED_100:
+		val = u32_replace_bits(val, SSP_100M, PM_IF_MODE_SSP);
+		break;
+	case SPEED_10:
+		val = u32_replace_bits(val, SSP_10M, PM_IF_MODE_SSP);
+	}
+
+	val = u32_replace_bits(val, duplex == DUPLEX_FULL ? 0 : 1,
+			       PM_IF_MODE_HD);
+
+	if (val == old_val)
+		return;
+
+	enetc_port_mac_wr(si, ENETC4_PM_IF_MODE(0), val);
+}
+
+static void enetc4_set_rmii_mac(struct enetc_pf *pf, int speed, int duplex)
+{
+	struct enetc_si *si = pf->si;
+	u32 old_val, val;
+
+	old_val = enetc_port_mac_rd(si, ENETC4_PM_IF_MODE(0));
+	val = old_val & ~(PM_IF_MODE_ENA | PM_IF_MODE_SSP);
+
+	switch (speed) {
+	case SPEED_100:
+		val &= ~PM_IF_MODE_M10;
+		break;
+	case SPEED_10:
+		val |= PM_IF_MODE_M10;
+	}
+
+	val = u32_replace_bits(val, duplex == DUPLEX_FULL ? 0 : 1,
+			       PM_IF_MODE_HD);
+
+	if (val == old_val)
+		return;
+
+	enetc_port_mac_wr(si, ENETC4_PM_IF_MODE(0), val);
+}
+
+static void enetc4_set_hd_flow_control(struct enetc_pf *pf, bool enable)
+{
+	struct enetc_si *si = pf->si;
+	u32 old_val, val;
+
+	if (!pf->caps.half_duplex)
+		return;
+
+	old_val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val = u32_replace_bits(old_val, enable ? 1 : 0, PM_CMD_CFG_HD_FCEN);
+	if (val == old_val)
+		return;
+
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+}
+
+static void enetc4_set_rx_pause(struct enetc_pf *pf, bool rx_pause)
+{
+	struct enetc_si *si = pf->si;
+	u32 old_val, val;
+
+	old_val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val = u32_replace_bits(old_val, rx_pause ? 0 : 1, PM_CMD_CFG_PAUSE_IGN);
+	if (val == old_val)
+		return;
+
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+}
+
+static void enetc4_set_tx_pause(struct enetc_pf *pf, int num_rxbdr, bool tx_pause)
+{
+	u32 pause_off_thresh = 0, pause_on_thresh = 0;
+	u32 init_quanta = 0, refresh_quanta = 0;
+	struct enetc_hw *hw = &pf->si->hw;
+	u32 rbmr, old_rbmr;
+	int i;
+
+	for (i = 0; i < num_rxbdr; i++) {
+		old_rbmr = enetc_rxbdr_rd(hw, i, ENETC_RBMR);
+		rbmr = u32_replace_bits(old_rbmr, tx_pause ? 1 : 0, ENETC_RBMR_CM);
+		if (rbmr == old_rbmr)
+			continue;
+
+		enetc_rxbdr_wr(hw, i, ENETC_RBMR, rbmr);
+	}
+
+	if (tx_pause) {
+		/* When the port first enters congestion, send a PAUSE request
+		 * with the maximum number of quanta. When the port exits
+		 * congestion, it will automatically send a PAUSE frame with
+		 * zero quanta.
+		 */
+		init_quanta = 0xffff;
+
+		/* Also, set up the refresh timer to send follow-up PAUSE
+		 * frames at half the quanta value, in case the congestion
+		 * condition persists.
+		 */
+		refresh_quanta = 0xffff / 2;
+
+		/* Start emitting PAUSE frames when 3 large frames (or more
+		 * smaller frames) have accumulated in the FIFO waiting to be
+		 * DMAed to the RX ring.
+		 */
+		pause_on_thresh = 3 * ENETC_MAC_MAXFRM_SIZE;
+		pause_off_thresh = 1 * ENETC_MAC_MAXFRM_SIZE;
+	}
+
+	enetc_port_mac_wr(pf->si, ENETC4_PM_PAUSE_QUANTA(0), init_quanta);
+	enetc_port_mac_wr(pf->si, ENETC4_PM_PAUSE_THRESH(0), refresh_quanta);
+	enetc_port_wr(hw, ENETC4_PPAUONTR, pause_on_thresh);
+	enetc_port_wr(hw, ENETC4_PPAUOFFTR, pause_off_thresh);
+}
+
+static void enetc4_enable_mac(struct enetc_pf *pf, bool en)
+{
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val &= ~(PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
+	val |= en ? (PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN) : 0;
+
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+}
+
+static void enetc4_pl_mac_link_up(struct phylink_config *config,
+				  struct phy_device *phy, unsigned int mode,
+				  phy_interface_t interface, int speed,
+				  int duplex, bool tx_pause, bool rx_pause)
+{
+	struct enetc_pf *pf = phylink_to_enetc_pf(config);
+	struct enetc_si *si = pf->si;
+	struct enetc_ndev_priv *priv;
+	bool hd_fc = false;
+
+	priv = netdev_priv(si->ndev);
+	enetc4_set_port_speed(priv, speed);
+
+	if (!phylink_autoneg_inband(mode) &&
+	    phy_interface_mode_is_rgmii(interface))
+		enetc4_set_rgmii_mac(pf, speed, duplex);
+
+	if (interface == PHY_INTERFACE_MODE_RMII)
+		enetc4_set_rmii_mac(pf, speed, duplex);
+
+	if (duplex == DUPLEX_FULL) {
+		/* When preemption is enabled, generation of PAUSE frames
+		 * must be disabled, as stated in the IEEE 802.3 standard.
+		 */
+		if (priv->active_offloads & ENETC_F_QBU)
+			tx_pause = false;
+	} else { /* DUPLEX_HALF */
+		if (tx_pause || rx_pause)
+			hd_fc = true;
+
+		/* As per 802.3 annex 31B, PAUSE frames are only supported
+		 * when the link is configured for full duplex operation.
+		 */
+		tx_pause = false;
+		rx_pause = false;
+	}
+
+	enetc4_set_hd_flow_control(pf, hd_fc);
+	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
+	enetc4_set_rx_pause(pf, rx_pause);
+	enetc4_enable_mac(pf, true);
+}
+
+static void enetc4_pl_mac_link_down(struct phylink_config *config,
+				    unsigned int mode,
+				    phy_interface_t interface)
+{
+	struct enetc_pf *pf = phylink_to_enetc_pf(config);
+
+	enetc4_enable_mac(pf, false);
+}
+
+static const struct phylink_mac_ops enetc_pl_mac_ops = {
+	.mac_select_pcs = enetc4_pl_mac_select_pcs,
+	.mac_config = enetc4_pl_mac_config,
+	.mac_link_up = enetc4_pl_mac_link_up,
+	.mac_link_down = enetc4_pl_mac_link_down,
+};
+
+static void enetc4_pci_remove(void *data)
+{
+	struct pci_dev *pdev = data;
+
+	enetc_pci_remove(pdev);
+}
+
+static int enetc4_link_init(struct enetc_ndev_priv *priv,
+			    struct device_node *node)
+{
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct device *dev = priv->dev;
+	int err;
+
+	err = of_get_phy_mode(node, &pf->if_mode);
+	if (err) {
+		dev_err(dev, "Failed to get PHY mode\n");
+		return err;
+	}
+
+	err = enetc_mdiobus_create(pf, node);
+	if (err) {
+		dev_err(dev, "Failed to create MDIO bus\n");
+		return err;
+	}
+
+	err = enetc_phylink_create(priv, node, &enetc_pl_mac_ops);
+	if (err) {
+		dev_err(dev, "Failed to create phylink\n");
+		goto err_phylink_create;
+	}
+
+	return 0;
+
+err_phylink_create:
+	enetc_mdiobus_destroy(pf);
+
+	return err;
+}
+
+static void enetc4_link_deinit(struct enetc_ndev_priv *priv)
+{
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+
+	enetc_phylink_destroy(priv);
+	enetc_mdiobus_destroy(pf);
+}
+
+static int enetc4_pf_netdev_create(struct enetc_si *si)
+{
+	struct device *dev = &si->pdev->dev;
+	struct enetc_ndev_priv *priv;
+	struct net_device *ndev;
+	int err;
+
+	ndev = alloc_etherdev_mqs(sizeof(struct enetc_ndev_priv),
+				  si->num_tx_rings, si->num_rx_rings);
+	if (!ndev)
+		return  -ENOMEM;
+
+	priv = netdev_priv(ndev);
+	priv->ref_clk = devm_clk_get_optional(dev, "ref");
+	if (IS_ERR(priv->ref_clk)) {
+		dev_err(dev, "Get referencce clock failed\n");
+		err = PTR_ERR(priv->ref_clk);
+		goto err_clk_get;
+	}
+
+	enetc_pf_netdev_setup(si, ndev, &enetc4_ndev_ops);
+
+	enetc_init_si_rings_params(priv);
+
+	err = enetc_configure_si(priv);
+	if (err) {
+		dev_err(dev, "Failed to configure SI\n");
+		goto err_config_si;
+	}
+
+	err = enetc_alloc_msix(priv);
+	if (err) {
+		dev_err(dev, "Failed to alloc MSI-X\n");
+		goto err_alloc_msix;
+	}
+
+	err = enetc4_link_init(priv, dev->of_node);
+	if (err)
+		goto err_link_init;
+
+	err = register_netdev(ndev);
+	if (err) {
+		dev_err(dev, "Failed to register netdev\n");
+		goto err_reg_netdev;
+	}
+
+	return 0;
+
+err_reg_netdev:
+	enetc4_link_deinit(priv);
+err_link_init:
+	enetc_free_msix(priv);
+err_alloc_msix:
+err_config_si:
+err_clk_get:
+	mutex_destroy(&priv->mm_lock);
+	free_netdev(ndev);
+
+	return err;
+}
+
+static void enetc4_pf_netdev_destroy(struct enetc_si *si)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(si->ndev);
+	struct net_device *ndev = si->ndev;
+
+	unregister_netdev(ndev);
+	enetc_free_msix(priv);
+	free_netdev(ndev);
+}
+
+static int enetc4_pf_probe(struct pci_dev *pdev,
+			   const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct enetc_si *si;
+	struct enetc_pf *pf;
+	int err;
+
+	err = enetc_pci_probe(pdev, KBUILD_MODNAME, sizeof(*pf));
+	if (err)
+		return dev_err_probe(dev, err, "PCIe probing failed\n");
+
+	err = devm_add_action_or_reset(dev, enetc4_pci_remove, pdev);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "Add enetc4_pci_remove() action failed\n");
+
+	/* si is the private data. */
+	si = pci_get_drvdata(pdev);
+	if (!si->hw.port || !si->hw.global)
+		return dev_err_probe(dev, -ENODEV,
+				     "Couldn't map PF only space\n");
+
+	si->revision = enetc_get_ip_revision(&si->hw);
+	err = enetc_get_driver_data(si);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "Could not get VF driver data\n");
+
+	err = enetc4_pf_struct_init(si);
+	if (err)
+		return err;
+
+	pf = enetc_si_priv(si);
+	err = enetc4_pf_init(pf);
+	if (err)
+		return err;
+
+	enetc_get_si_caps(si);
+
+	return enetc4_pf_netdev_create(si);
+}
+
+static void enetc4_pf_remove(struct pci_dev *pdev)
+{
+	struct enetc_si *si = pci_get_drvdata(pdev);
+
+	enetc4_pf_netdev_destroy(si);
+}
+
+static const struct pci_device_id enetc4_pf_id_table[] = {
+	{ PCI_DEVICE(NXP_ENETC_VENDOR_ID, NXP_ENETC_PF_DEV_ID) },
+	{ 0, } /* End of table. */
+};
+MODULE_DEVICE_TABLE(pci, enetc4_pf_id_table);
+
+static struct pci_driver enetc4_pf_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = enetc4_pf_id_table,
+	.probe = enetc4_pf_probe,
+	.remove = enetc4_pf_remove,
+};
+module_pci_driver(enetc4_pf_driver);
+
+MODULE_DESCRIPTION("ENETC4 PF Driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 2563eb8ac7b6..4c223eb90c19 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -775,9 +775,10 @@ static int enetc_get_coalesce(struct net_device *ndev,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_int_vector *v = priv->int_vector[0];
+	u64 clk_freq = priv->sysclk_freq;
 
-	ic->tx_coalesce_usecs = enetc_cycles_to_usecs(priv->tx_ictt);
-	ic->rx_coalesce_usecs = enetc_cycles_to_usecs(v->rx_ictt);
+	ic->tx_coalesce_usecs = enetc_cycles_to_usecs(priv->tx_ictt, clk_freq);
+	ic->rx_coalesce_usecs = enetc_cycles_to_usecs(v->rx_ictt, clk_freq);
 
 	ic->tx_max_coalesced_frames = ENETC_TXIC_PKTTHR;
 	ic->rx_max_coalesced_frames = ENETC_RXIC_PKTTHR;
@@ -793,12 +794,13 @@ static int enetc_set_coalesce(struct net_device *ndev,
 			      struct netlink_ext_ack *extack)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	u64 clk_freq = priv->sysclk_freq;
 	u32 rx_ictt, tx_ictt;
 	int i, ic_mode;
 	bool changed;
 
-	tx_ictt = enetc_usecs_to_cycles(ic->tx_coalesce_usecs);
-	rx_ictt = enetc_usecs_to_cycles(ic->rx_coalesce_usecs);
+	tx_ictt = enetc_usecs_to_cycles(ic->tx_coalesce_usecs, clk_freq);
+	rx_ictt = enetc_usecs_to_cycles(ic->rx_coalesce_usecs, clk_freq);
 
 	if (ic->rx_max_coalesced_frames != ENETC_RXIC_PKTTHR)
 		return -EOPNOTSUPP;
@@ -1178,7 +1180,7 @@ void enetc_mm_link_state_update(struct enetc_ndev_priv *priv, bool link)
 }
 EXPORT_SYMBOL_GPL(enetc_mm_link_state_update);
 
-static const struct ethtool_ops enetc_pf_ethtool_ops = {
+const struct ethtool_ops enetc_pf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
@@ -1213,7 +1215,7 @@ static const struct ethtool_ops enetc_pf_ethtool_ops = {
 	.get_mm_stats = enetc_get_mm_stats,
 };
 
-static const struct ethtool_ops enetc_vf_ethtool_ops = {
+const struct ethtool_ops enetc_vf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
@@ -1234,13 +1236,26 @@ static const struct ethtool_ops enetc_vf_ethtool_ops = {
 	.get_ts_info = enetc_get_ts_info,
 };
 
+const struct ethtool_ops enetc4_pf_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_MAX_FRAMES |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+	.get_ringparam = enetc_get_ringparam,
+	.get_coalesce = enetc_get_coalesce,
+	.set_coalesce = enetc_set_coalesce,
+	.get_link_ksettings = enetc_get_link_ksettings,
+	.set_link_ksettings = enetc_set_link_ksettings,
+	.get_link = ethtool_op_get_link,
+	.get_wol = enetc_get_wol,
+	.set_wol = enetc_set_wol,
+	.get_pauseparam = enetc_get_pauseparam,
+	.set_pauseparam = enetc_set_pauseparam,
+};
+
 void enetc_set_ethtool_ops(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
-	if (enetc_si_is_pf(priv->si))
-		ndev->ethtool_ops = &enetc_pf_ethtool_ops;
-	else
-		ndev->ethtool_ops = &enetc_vf_ethtool_ops;
+	ndev->ethtool_ops = priv->si->drvdata->eth_ops;
 }
 EXPORT_SYMBOL_GPL(enetc_set_ethtool_ops);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 6a7b9b75d660..7c3285584f8a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -6,6 +6,8 @@
 #define ENETC_MM_VERIFY_SLEEP_US	USEC_PER_MSEC
 #define ENETC_MM_VERIFY_RETRIES		3
 
+#define ENETC_NUM_TC			8
+
 /* ENETC device IDs */
 #define ENETC_DEV_ID_PF		0xe100
 #define ENETC_DEV_ID_VF		0xef00
@@ -25,6 +27,7 @@
 #define ENETC_SIPCAPR0_RSS	BIT(8)
 #define ENETC_SIPCAPR0_QBV	BIT(4)
 #define ENETC_SIPCAPR0_QBU	BIT(3)
+#define ENETC_SIPCAPR0_RFS	BIT(2)
 #define ENETC_SIPCAPR1	0x24
 #define ENETC_SITGTGR	0x30
 #define ENETC_SIRBGCR	0x38
@@ -368,6 +371,10 @@ enum enetc_bdr_type {TX, RX};
 /** Global regs, offset: 2_0000h */
 #define ENETC_GLOBAL_BASE	0x20000
 #define ENETC_G_EIPBRR0		0x0bf8
+#define EIPBRR0_REVISION	GENMASK(15, 0)
+#define ENETC_REV_1_0		0x0100
+#define ENETC_REV_4_1		0X0401
+
 #define ENETC_G_EIPBRR1		0x0bfc
 #define ENETC_G_EPFBLPR(n)	(0xd00 + 4 * (n))
 #define ENETC_G_EPFBLPR1_XGMII	0x80000000
@@ -971,15 +978,17 @@ struct enetc_cbd {
 	u8 status_flags;
 };
 
-#define ENETC_CLK  400000000ULL
-static inline u32 enetc_cycles_to_usecs(u32 cycles)
+#define ENETC_CLK_400M		400000000ULL
+#define ENETC_CLK_333M		333000000ULL
+
+static inline u32 enetc_cycles_to_usecs(u32 cycles, u64 clk_freq)
 {
-	return (u32)div_u64(cycles * 1000000ULL, ENETC_CLK);
+	return (u32)div_u64(cycles * 1000000ULL, clk_freq);
 }
 
-static inline u32 enetc_usecs_to_cycles(u32 usecs)
+static inline u32 enetc_usecs_to_cycles(u32 usecs, u64 clk_freq)
 {
-	return (u32)div_u64(usecs * ENETC_CLK, 1000000ULL);
+	return (u32)div_u64(usecs * clk_freq, 1000000ULL);
 }
 
 /* Port traffic class frame preemption register */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 1ff9a7a3386c..a76ce41eb197 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -947,6 +947,13 @@ static struct enetc_si *enetc_psi_create(struct pci_dev *pdev)
 		goto out_pci_remove;
 	}
 
+	si->revision = enetc_get_ip_revision(&si->hw);
+	err = enetc_get_driver_data(si);
+	if (err) {
+		dev_err(&pdev->dev, "Could not get PF driver data\n");
+		goto out_pci_remove;
+	}
+
 	err = enetc_setup_cbdr(&pdev->dev, &si->hw, ENETC_CBDR_DEFAULT_SIZE,
 			       &si->cbd_ring);
 	if (err)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 53d20752aacf..a26a12863855 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -28,6 +28,14 @@ struct enetc_vf_state {
 	enum enetc_vf_flags flags;
 };
 
+struct enetc_port_caps {
+	u32 half_duplex:1;
+	int num_vsi;
+	int num_msix;
+	int num_rx_bdr;
+	int num_tx_bdr;
+};
+
 struct enetc_pf;
 
 struct enetc_pf_ops {
@@ -61,6 +69,7 @@ struct enetc_pf {
 	phy_interface_t if_mode;
 	struct phylink_config phylink_config;
 
+	struct enetc_port_caps caps;
 	const struct enetc_pf_ops *ops;
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index e95252e898ae..0eecfc833164 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -100,6 +100,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	si->ndev = ndev;
 
 	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
+	priv->sysclk_freq = si->drvdata->sysclk_freq;
 	ndev->netdev_ops = ndev_ops;
 	enetc_set_ethtool_ops(ndev);
 	ndev->watchdog_timeo = 5 * HZ;
@@ -116,10 +117,17 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
+	ndev->priv_flags |= IFF_UNICAST_FLT;
+
+	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
+	if (!is_enetc_rev1(si)) {
+		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
+		goto end;
+	}
+
 	if (si->num_rss)
 		ndev->hw_features |= NETIF_F_RXHASH;
 
-	ndev->priv_flags |= IFF_UNICAST_FLT;
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
 			     NETDEV_XDP_ACT_NDO_XMIT_SG;
@@ -131,6 +139,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 		ndev->hw_features |= NETIF_F_HW_TC;
 	}
 
+end:
 	/* pick up primary MAC address from SI */
 	enetc_load_primary_mac_addr(&si->hw, ndev);
 }
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index 964d4f53806b..48f55ee743ad 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -12,3 +12,8 @@ void enetc_mdiobus_destroy(struct enetc_pf *pf);
 int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 			 const struct phylink_mac_ops *ops);
 void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
+
+static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
+{
+	return enetc_global_rd(hw, ENETC_G_EIPBRR0) & EIPBRR0_REVISION;
+}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index b65da49dd926..ccf86651455c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -336,7 +336,7 @@ int enetc_setup_tc_cbs(struct net_device *ndev, void *type_data)
 	 *
 	 * (enetClockFrequency / portTransmitRate) * 100
 	 */
-	hi_credit_reg = (u32)div_u64((ENETC_CLK * 100ULL) * hi_credit_bit,
+	hi_credit_reg = (u32)div_u64((priv->sysclk_freq * 100ULL) * hi_credit_bit,
 				     port_transmit_rate * 1000000ULL);
 
 	enetc_port_wr(hw, ENETC_PTCCBSR1(tc), hi_credit_reg);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index dfcaac302e24..31e630638090 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -128,6 +128,7 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	si->ndev = ndev;
 
 	priv->msg_enable = (NETIF_MSG_IFUP << 1) - 1;
+	priv->sysclk_freq = si->drvdata->sysclk_freq;
 	ndev->netdev_ops = ndev_ops;
 	enetc_set_ethtool_ops(ndev);
 	ndev->watchdog_timeo = 5 * HZ;
@@ -164,6 +165,11 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 		return dev_err_probe(&pdev->dev, err, "PCI probing failed\n");
 
 	si = pci_get_drvdata(pdev);
+	si->revision = ENETC_REV_1_0;
+	err = enetc_get_driver_data(si);
+	if (err)
+		return dev_err_probe(&pdev->dev, err,
+				     "Could not get VF driver data\n");
 
 	enetc_get_si_caps(si);
 
-- 
2.34.1


