Return-Path: <linux-pci+bounces-14737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D489A1C44
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7E128B7EA
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9406842056;
	Thu, 17 Oct 2024 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="II/ROzVe"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A56578685;
	Thu, 17 Oct 2024 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152102; cv=fail; b=OUs+DtlLWVKAfFIai/aiv254PZUFY/yMSlyxrC3JNUSW/cqmSXSLPllWsHg/eqjXNPDajBEXtCGixPdKIhZx/LUQH9C5LAS3RlYSCeoUaT+gYhxNScLqBM6MjOZGpy0Yk9xiN7WoVvbiEDbeAafPQJT2oLgxwh52vHVZ43Y3ad8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152102; c=relaxed/simple;
	bh=CWqtf6tlRzj9lwMm54VK2C5B2Vakoy/UMoondq/NMg4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=miynlJsvIiuP8amfOpaRsawcXuuMAGxr3ErA1VM2s+gNZ4DIE5ZcITadX/ztdcyDWWZidCI0qhQMc/SLt2T8Sosf0x6uhN5GrOtp41CjlPOmY0vB5aGT1sBp2rI9jZpdvdHlbYe/LV5TlEGSEJ3sa8JEP9CvueAIEPbVkOFX0nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=II/ROzVe; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k57XjN3mmtrQNES+OpFGBokYp/+zk7Dh3DV+wCaGqsmV+4vQ0Xjylr29AixPtAZlg1hfAIAjryb6rAe9gahpmUgQUMHNK9Bo1nuLSO6uv5Ldp2HVYClzNr4AffoLS6y4wnHKYW4yMqMWEM7cbNkEpokfe80jRG0XRY4Hpd3jfPak2GZ5tV5E88I51Z5/H2Bg8xhQ6fnAxkkXn+VK+Kv3Vasu57zmTfgzcr53O0PW8aP8a1/hAfFShh+RQm2MCaFgfMVaHVEyxh89Ma1rh+zPMXj1z7G9Qm3GJSh53dmFLOJ6vIAhZAo9oOxn+I7SyxLtjS+dKcL4UI2Nl6wI+k5QgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ5eFI3TlIPK91V4g94Us6iRF3wSpBx6MVMbEpeY9vg=;
 b=ip8Du6+/5D7vRmxBC05BdDF5gtDK3fVsSBoigUs+TydsqL7QH3isE6uE8I8+zo1TmcY6Y/GivgWLKulCRYBzdfPxcV7Yz+ROw2eBKw79We82GnmKatdvpcPBcX/Jy5yXmrbsZaHpgAyBSqooqGM4dNVhEe+MZ0GsTfMvSHu1wRplFm93uCuCXTAd+u8n+7YNtBdDojPsi9vjUeLi+io+S/PSVhlWPU0nH2Ms+vAsnSUVtjPqGri5YT/rGp6pSII35AUnDbxur50g+Y2IqR7JW4lFztICp5JoNVJgLjvqtlU/3nTIZscOJYNqqebDf9C7k8CKd4xW16Hv50Vs0HUtOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJ5eFI3TlIPK91V4g94Us6iRF3wSpBx6MVMbEpeY9vg=;
 b=II/ROzVe3IzmI62K4ZFeSZdy5mMDctzhK7CRNzMKpk9UzqmNAW4mq49WQ3zim+22l/OxPy6FK5DnvmnIWB6mFjRm4LF1IWMISw0hr0Xto7M7GjB4sNZ/ObAiVdVqoMzzNq1mZum4L7c+hwmtKoE18ypteHe9FI+uAUM2q3vjS8KlncuuPRHuaZI+3+NADHXG2q6tyohcNCkbapWqDT0DC4n+csALAnn3J7/pnRZ+XztvZe1YA5vyMmIJ3wIwlNfdHGlKFFX9QUIPQ6jSrjX8ey3ZQGE2WJuXEDWHJycivENbzfjZeJttaAJdae080fon5tbf+p4gQ90xuqnDooRDfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:01:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 08:01:34 +0000
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
Subject: [PATCH v3 net-next 00/13] add basic support for i.MX95 NETC
Date: Thu, 17 Oct 2024 15:46:24 +0800
Message-Id: <20241017074637.1265584-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: c02a24cd-76d9-4b1a-e125-08dcee81eac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cSiO/6tHbWLnCXNF4DrRGHGGksSw5eVXqDXrbgimNzBQrv4GsXNVDGtGxLm9?=
 =?us-ascii?Q?Bx6WxMYaqlMH7FiLoLQNyhei5/i0PabCSd83Rk7+uRp0/xW5vM05EYP8wtmz?=
 =?us-ascii?Q?x8+7k+pZsZoVLRdRIigdFVY3iS/TynEyOTHgK97ZUBv/TK0vS9lWMxj1kGLP?=
 =?us-ascii?Q?Oi2hSSjaj2m36kbNkENjrLwGw+c3DGjiAQvBM373vBcXOAsztuVlAnYmxLtu?=
 =?us-ascii?Q?fJ6EFrlyUM2oo0/zYVC3vUv5MON8Yf8um2L2BVnUICgQq8SfcudpxgFDQ3Sv?=
 =?us-ascii?Q?5zqRVrW+zUSPWyXkCdW2bXd06llvJQZg8P5yQhmlr29KDJL4oBRd0M8fxybz?=
 =?us-ascii?Q?xn5/maMveEKmZqj3bS5qhEe+vWrp0ceW7+Yga6zGthvphqcPMQ9jlR3QLdJb?=
 =?us-ascii?Q?UUeLARUqyA290oNillXab3lzbklypEyb3amPp5KxhInFU0/OpxOwFdU3fvJp?=
 =?us-ascii?Q?h0w1MOe1fGyzAco2CTGXzTbkmzLJ9aULmYX7S3fRGIPVYxVdYfT8ZTL4QZp1?=
 =?us-ascii?Q?8IeeZylkMLWJypW6bxZVkB/2qUeoEOrQgzTPHJLa0zDJ7wQyA/WHCmX/UGYL?=
 =?us-ascii?Q?d/Nmd8zwyf9lYaw/YT1sz7F6gFXVKd+rT1DAjHHZEdTT39RBJYUm53yLUE7J?=
 =?us-ascii?Q?z9coqqZkEZzDehAY0v4rauJJHkfdpVX04IR5CWfF1619pyOMNO7IqESWJuuV?=
 =?us-ascii?Q?4HKN/GA5vtrocilQrJrod/H1OzmYze8UATBaNR2TLei81ls3pAihO/7LE6GJ?=
 =?us-ascii?Q?pGZpD8GE6MVTEFfgzR5Welxzekf/i1dijQ9dfZxNBzv33d79ExXXiChJXbWW?=
 =?us-ascii?Q?jJTIn5TLmdSRCrS6qcnGdP7Cd3DGH2cIgrBbmzdx2hO4pGiVdAIaNWdoJoh/?=
 =?us-ascii?Q?wFRaCypBAJFy868hngzUc5Nu5Iq7sjIkoYpKhmVxweY+1T3RNrTVqKBG+lzI?=
 =?us-ascii?Q?M8lVN/E/OdDwigjqjeZbYmPTlHPEXEeZnczkpIOUPV6smI9ErJ9z6nOE0t2D?=
 =?us-ascii?Q?OLkMbbc7WKzdJFL1rXB9WupUc3CVwNhv71g6vUMW1/5KRyAliwXkm3unJ0Ub?=
 =?us-ascii?Q?R7/a28x5GOyHcxXczRUIkjlZY5ff/wGMpVXN4vxfdwhX+DX4VqOkgZdjHMKK?=
 =?us-ascii?Q?4WzZhHybmkrvo+RenVUTuOqH70bYiGM12/BizywJR13wqKTjnJDM26Xf17OE?=
 =?us-ascii?Q?wA18sDU1+IAUdkcbuYHIM9uDLLSKwLpF5ecEEPOEpGYNw/8WWXahAwik/5AX?=
 =?us-ascii?Q?HpjrsLof4K6bAk04B0eeu7bCvB25CGbtgqSMtlaN0nHmsob0yGREZm/HmfqK?=
 =?us-ascii?Q?6JTlJfEc3JqkENNlYtPGrhAXTMo2/ce+fhuEoUwjHv9RJDbr0zDU9dPSMIWp?=
 =?us-ascii?Q?BS/TyJYsQ+g72Hu3ddu92fGSCfiv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xUt0d9Lk+E2tuhyEbQXRpiyJM2f/PAhMKpMjN2nXhVUL+k2HPsKlphQ/pNxp?=
 =?us-ascii?Q?xVtDKDXpEKvxUAUiFg5svRPTKn8ZBhaw41+2l7ygAd1Qtr+YKJFtKQ4DExzx?=
 =?us-ascii?Q?mBeN4rfW2+RXexoRcWcBEfCCvkpnyruSX21aaZvR+o2Tut9X6tRz2FopGzsK?=
 =?us-ascii?Q?nBl9l1r/bAtxT4Jat8vFOw6uhQ0qPSQSRlRtPpSgsTMtutev3DvFkHWdWrHT?=
 =?us-ascii?Q?U84kvBsdPtXFk2jvsaPQWcpE3gz6aKeEBtPYaz+uiFgzaiatqYvuP9eyF3E5?=
 =?us-ascii?Q?lw2rdhCgpXr2i7l2UchMwwXK0mwpp7NZlkexZAfEeV7rbdIN0ucXqnvanaob?=
 =?us-ascii?Q?DUFR+7EtIfd+gT9CY0Ye1TFImEjXlrkMb5b3k/vg9LEUd5T6021lVCZzU3/g?=
 =?us-ascii?Q?r1KNmEKiAuqIVtOb+H8An/PzOqgNDN9eYP+7QLy8pzdbbYAglJfdTcC+IswC?=
 =?us-ascii?Q?uDzNgKNCex4bAisd/iwA/Axpo1ZtkmbvEJ0de9Tfix4S+tWbSOb1cC4oWJjr?=
 =?us-ascii?Q?wSZjWD0NimCUjW5M9TQkMTed1tQLrsSQjfw1groUz3eqpi4vYlqBCn/Z5V2H?=
 =?us-ascii?Q?Lp44Acya5U+Tmqa/R7q2QN9LaWugmABbu1kb+Uo3NYU3duc6TgdECyCPwBxA?=
 =?us-ascii?Q?aerrpFzdchzk1Nso9RMKEl3yJBSwDFcUru09bggnY1Mu5WZ7eDFZF0PyOnvE?=
 =?us-ascii?Q?amX9ywDQcxMCoUhjXpCdguJhLVzqv481USzCWLXAiLXaf5kG41wf9SvE8KoR?=
 =?us-ascii?Q?RIMPePIZHHEfx8cJErH4UEtb5C8hMR3+yzlTXC6csMOgnfFbGsmjfi566LcR?=
 =?us-ascii?Q?ocuWaJaSwDL2v0RnmtdkFQSxqUVoy0g8XV79RjPhlp4De1Lx3Y7m+IVD2Pmd?=
 =?us-ascii?Q?rakklit5rRVHIZ8VhSQIySwB8cW/yN8RO37JLUatJhSYyqaCRJN6v74zyc0B?=
 =?us-ascii?Q?Js4UOhrM6w+sOz719z1eDPVeqcpo33H3iO2yXoF0y3oyUluAW6QAzcupg9u1?=
 =?us-ascii?Q?/EVdaIF50KAnDmDUBLvNi+eULN6eCcyAEHASfQ6ov1eg4H1oicTKlUe6VM6n?=
 =?us-ascii?Q?UvxSYg6cv1tGEDyfn125uW5QZIV7UAW/+VFlc9dKeBECXBLkNKNj6Of5NTaN?=
 =?us-ascii?Q?NjhZImWC8UVuSwZeZWjKqKXl8SlzCUior6/S2H+gm8VyPExxLcjDzuGb2lk8?=
 =?us-ascii?Q?cqffv4eAqruyrcIZw9JJxjjGuCZBBQRKtAC/S4VM8PP0SotIkxwvzS2C3wy3?=
 =?us-ascii?Q?jXV/vmQGzCFiSK2xk0IrDFdAK4HQgwGFgrJtTgJ89JPSoGThntuPqbmTCsqc?=
 =?us-ascii?Q?37A9JeROKRm6SEmI9CEp0DJwQhc4w305HTmRQCThYPLWD/oA7vDrvzkSYjvA?=
 =?us-ascii?Q?uDnId35Ms0IpULids/UOL7mDBlJxB5iIFBKk24EeInVUN9C2S15BEJVEX99H?=
 =?us-ascii?Q?MqULXFJI/KrW4RmZzJTo4fvfSlaMlQe0HaJRxKNLlmL7aW8LgVBDBjIZsaXb?=
 =?us-ascii?Q?vvptJACHXggLw2VTnPIreZwGnZEF4PTiKvaNJ9xM9EXMuWaNHOc14GoyVlU5?=
 =?us-ascii?Q?4dYss2EfHf68YzUDqYVs6zn75QiSeohQa+cFSYg/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02a24cd-76d9-4b1a-e125-08dcee81eac0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:01:33.9811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwSotWNSqChypPuxjttIRUz7WVt+XVzBQuJ9ptyc/G70mbFhUezhd6Ld1n0ESibYrngppHROsyFZxzTCgEStHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

This is first time that the NETC IP is applied on i.MX MPU platform.
Its revision has been upgraded to 4.1, which is very different from
the NETC of LS1028A (its revision is 1.0). Therefore, some existing
drivers of NETC devices in the Linux kernel are not compatible with
the current hardware. For example, the fsl-enetc driver is used to
drive the ENETC PF of LS1028A, but for i.MX95 ENETC PF, its registers
and tables configuration are very different from those of LS1028A,
and only the station interface (SI) part remains basically the same.
For the SI part, Vladimir has separated the fsl-enetc-core driver, so
we can reuse this driver on i.MX95. However, for other parts of PF,
the fsl-enetc driver cannot be reused, so the nxp-enetc4 driver is
added to support revision 4.1 and later.

During the development process, we found that the two PF drivers have
some interfaces with basically the same logic, and the only difference
is the hardware configuration. So in order to reuse these interfaces
and reduce code redundancy, we extracted these interfaces and compiled
them into a separate nxp-enetc-pf-common driver for use by the two PF
drivers.

In addition, we have developed the nxp-netc-blk-ctrl driver, which
is used to control three blocks, namely Integrated Endpoint Register
Block (IERB), Privileged Register Block (PRB) and NETCMIX block. The
IERB contains registers that are used for pre-boot initialization,
debug, and non-customer configuration. The PRB controls global reset
and global error handling for NETC. The NETCMIX block is mainly used
to set MII protocol and PCS protocol of the links, it also contains
settings for some other functions.

---
v1 Link: https://lore.kernel.org/imx/20241009095116.147412-1-wei.fang@nxp.com/
v2 Link: https://lore.kernel.org/imx/20241015125841.1075560-1-wei.fang@nxp.com/
---

Clark Wang (2):
  net: enetc: extract enetc_int_vector_init/destroy() from
    enetc_alloc_msix()
  net: enetc: optimize the allocation of tx_bdr

Vladimir Oltean (1):
  net: enetc: remove ERR050089 workaround for i.MX95

Wei Fang (10):
  dt-bindings: net: add compatible string for i.MX95 EMDIO
  dt-bindings: net: add i.MX95 ENETC support
  dt-bindings: net: add bindings for NETC blocks control
  net: enetc: add initial netc-blk-ctrl driver support
  net: enetc: extract common ENETC PF parts for LS1028A and i.MX95
    platforms
  net: enetc: build enetc_pf_common.c as a separate module
  PCI: Add NXP NETC vendor ID and device IDs
  net: enetc: add i.MX95 EMDIO support
  net: enetc: add preliminary support for i.MX95 ENETC PF
  MAINTAINERS: update ENETC driver files and maintainers

 .../bindings/net/fsl,enetc-mdio.yaml          |  11 +-
 .../devicetree/bindings/net/fsl,enetc.yaml    |  22 +-
 .../bindings/net/nxp,netc-blk-ctrl.yaml       | 105 +++
 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/freescale/enetc/Kconfig  |  40 +
 drivers/net/ethernet/freescale/enetc/Makefile |   9 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 220 ++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  19 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  | 153 ++++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 753 ++++++++++++++++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  68 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  46 +-
 .../ethernet/freescale/enetc/enetc_pci_mdio.c |  21 +
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 303 +------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  37 +
 .../freescale/enetc/enetc_pf_common.c         | 337 ++++++++
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 440 ++++++++++
 include/linux/fsl/netc_global.h               |  19 +
 include/linux/pci_ids.h                       |   7 +
 19 files changed, 2208 insertions(+), 409 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_hw.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_pf.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
 create mode 100644 include/linux/fsl/netc_global.h

-- 
2.34.1


