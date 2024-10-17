Return-Path: <linux-pci+bounces-14743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7364B9A1C64
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3230B2419D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92EF1D7998;
	Thu, 17 Oct 2024 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fqVgSvoN"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606301D3573;
	Thu, 17 Oct 2024 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152151; cv=fail; b=KbqRetnqHRSpuU3JFiywtw40mbsVVvU3h/d7DSWGID358KcYuC6Bme0jhI+L8O6eqAB+uz/SWv101JPDwTajDHqkP/qdW9yWtpH99WkgpA8qgG/7NxLDSx86M1CIInXAXBQW3e6clHeiYPwEx5EwcufZiIMj+R5D6g1WX/3RZOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152151; c=relaxed/simple;
	bh=kQYiW8HMVYZMIIvsq8vkXqTzt+tGwXnsa1MZYoig9nA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3AN/XO01RkkfWgkmub1bWBi6Ico8LykGv8jdsg3EKmnd5wPY2DTpCIkpw/c5baviiZSMXZWunrajKGtSST1VJiOBITjj7fo1Fn+mC/GBr+J8oZ5dO9mvnDn4bIn+uRYheKD8izLzoi7DCH3mB8630j7uEX3krydVSSoOW3HIo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fqVgSvoN; arc=fail smtp.client-ip=40.107.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RS8NAaNS1gHxvOWhqKSbbns+idFdsT/b3dLaQd4KE59k0AN3/yJ0rsPlWZJh0qUU9erGjC+oSlWyH1AW2W1za0rdrVqmV9a9IC8aX25VnunKlzxae4WJa7T0+5Os++BUYvGjXUIpnSnrry1/b6uV+mNrasefDhhO1fUY4RODy/1oVl/O6b5KLlCXskiwODi1ST94bgN8bvF2XNnB6sQg7A1SJ7SVWhZZjEi4SqxG37RmtOA9VizodeuLie8Dcs3sR8J6SlWONoTm7CLvvMfCdfzZFiFsjoF/zu8FnWTRHHFMmUc0G8td4pcJefLUSzvnY5Ga5f96R/ccFMJOkpBsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ8Bq7uI8+AxLE1v2Z1IRAZ/bMEDOHLQgYtOXjd9j98=;
 b=s6wG47I4eUauvgeK3xcfZlczHjNv+PU3L1rnlJcDWOFoUp/f7rFH6H8uX/mB8IBammzxZIwYdgTM2mbmeyLZQiLqH4/Sa3tHW4gVn/0MQSXSDzmw8NMj4fv0x05QsLi5FkdA+U/0QUOHz+6URfftWn+iJ0fczyXFsdRbUDsKVg3QXJ6tEJ9B7MOTQRyNqd8nBRTWduFFBK/yjzNPzwA2u8LgxE1VTxwgOsAAJAQuFfWG1MIRJ0ohy6Jzoz9umyKPqe5VbJ2FxEXOhNzMnE9cVqXxRJw3pwwkh/vkUbj3U9GsgwbjmiFI5NRQncfe44xlJuxiyaketbJqnntpxyoyCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ8Bq7uI8+AxLE1v2Z1IRAZ/bMEDOHLQgYtOXjd9j98=;
 b=fqVgSvoNqa1jyHUHi0Mdl7fjhOhUn4Y2Gu1GDu/iAKCVXThXx8FcHOfZqa+N3tKFl1fi0CKrY8da25Jxf9EfbsjQkqTZ82ohmauuNDOh1aKKpnk3sPMIw7iwptgFsIij6VOjI0kJyYZc2r/I2w3/3AFdxZZXmqaOYbXEaRJ42R3RB3ZBIw6GtRG2O6wlSdApvKjBjeG3xzjrCRsGZfETMQJYTyhZVE1RtWqjH6w4NUdQetfCfQ6iGz+eg3ZB7WFaLT/icoIxD1ysCC8jxhSa9mzMfv+UgKMZf2xZs4oC5kvQNBZmi7kqchHTSkTSwMBBR/wBWo0jcxEjBhBvRG5KlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:02:23 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 08:02:23 +0000
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
Subject: [PATCH v3 net-next 06/13] net: enetc: build enetc_pf_common.c as a separate module
Date: Thu, 17 Oct 2024 15:46:30 +0800
Message-Id: <20241017074637.1265584-7-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e951ac1c-f208-4a72-9438-08dcee820808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cSfgs6DtwYsXq0HYL3hTR+twZU96mP4HT/BMGXUpqTOUgfr43UCj0rE4xQAo?=
 =?us-ascii?Q?lUbi9s3F55h4eEECjCk+0+W/YuQueKKkD5P0GWFx6IL7bjnFUJ8vOkHMygK7?=
 =?us-ascii?Q?ClU+WqpStC/OvZ+E/SFRqyUWnaYXzD5XkaQF2cOjiZTR1vsoi73OtTRoRKVC?=
 =?us-ascii?Q?CZDapJckpQ3bdB58UhaNNtKKpeTIWQkR/Mslv84JEiNTRl0vKC8ih7JL4Ran?=
 =?us-ascii?Q?/MiW+K+h5WtfqKNCgN7uRwwia1Uw/x0bQL26kW6CVPXymsAJQuwIZm2x6pt2?=
 =?us-ascii?Q?bc2rW48vdq8x+HEcjlUDSsElqbQY6a0Hhkjfj2ZinW2ooe8tnEvc10Dy9FEU?=
 =?us-ascii?Q?03eBwOk2n5d8q1h5pv1sEQFahnUMK4Tw7gi7JKsfMCG2/D1TdwXg0QZHoTtH?=
 =?us-ascii?Q?QrI6DbEZjSHaxQp0lTNEIRdCvM66b2N/zrRXaIEJv5nfRjYrzklRrKTpepjl?=
 =?us-ascii?Q?uiIzQJmVcJXIaX9zkcrk6hkJKH1yy3iyKTFPSmBNlh4E6z9ON1j7jNUmPucM?=
 =?us-ascii?Q?eZcTIQMumWLVtT2DRnpaoWf++D7TU8VMmmbNl1jXrSZJvuijePST//NvJ3ZI?=
 =?us-ascii?Q?J2CRAF2byV9pse/4n7MJACYlU/OZa9LEqddzeWO6jhn9XLlL5nqrWE4I4Bqn?=
 =?us-ascii?Q?kGFxSFnSapCyvshTr3/U03ilLPuZL1m4M5wqbOLbyI/CZixTmQEKkadjsN9A?=
 =?us-ascii?Q?FU8+qVMJgn9saoU898Jcgd8RyZQpadGVxVhOIvpPW3PT1iKDV8JqOdcUCGoE?=
 =?us-ascii?Q?ycG/tCIDq1SDGCBFVV0r9k8FTrpPJ5gogkNLM79vUcL9085pjJeuYdt3U5sy?=
 =?us-ascii?Q?a2mPqEOLYH7tAeVbK5zI1OatqOu4I6uFz2aqcG1YdS4HFzb6gCx1iWP5TowH?=
 =?us-ascii?Q?qrTCsisRt6WUsRicR3EX8Y/HpMtOV+1O4rNAoj+9hHtQoIASC/TsS10+rEWN?=
 =?us-ascii?Q?gymsYL8MgOleKhaHBX62ZyjxGVffMGJ+Ml+RKOxCLtfZlww1JPcBzBWdvPcC?=
 =?us-ascii?Q?X44f570TSkGGZ2azQzaSVobF+w9RaiKsI/wBFClCy5eS9hkZ1lVtxiRQWs2b?=
 =?us-ascii?Q?GExdmT/14w+qrJmdhN/xxRHFaoJSQUz9ELcgFJBSq2Qldi5eRJyGgsVmWopj?=
 =?us-ascii?Q?jkhM/i/f9XIHM5HR+eRo5cz1LGbYedN887LEqrLW9qLvfYUD2eiafNeOXjCx?=
 =?us-ascii?Q?hIh16a/m4xygs2tyG4b/vXq1pseT70gUY32NIJhoC4horBv7dPb+K19k01yr?=
 =?us-ascii?Q?xol40CU3xL6kgY/ujNWcNOTq1Kx2SN5ztd5mzoygMQ+PuATz7vXuOjHwl5Rn?=
 =?us-ascii?Q?++4E3vmFEgWkKDf5MNOGzyAR1mN1YMhGVRMoylBevziHpDcEdjFRYvvI/Z6p?=
 =?us-ascii?Q?4NIY7Gdxnuj/+BwAugyByBeno4iq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H2z/naz31/Qldx70vdVc2X5Ktlg424DZziBM0XIYIR3n/rklA4ZeNmrEP3Nt?=
 =?us-ascii?Q?YBGtkP7/JWYOANPmO2xR6DZQpAtm9QqUwxZGhM6pMuxomDhD1OKouVeQH0yG?=
 =?us-ascii?Q?yeqepbKv01UtiNAQL/oD+oJyNhGf4RlLKzxHGMlLqlZqAsY6EWH2dj52VFaP?=
 =?us-ascii?Q?jmwA4xN8pWrFWknguyBpbGl3ZK2vfCt9qtPHHDhM7yCSpd9v9xU/t6HZAM3y?=
 =?us-ascii?Q?kT8WSciaIX7DTu4sO0NZEm1hqprWPQGFllPEvWT4NVCr7uP1a6iceV+fD3jr?=
 =?us-ascii?Q?7YO458hles5ghf6yuU/F2EkQRlYw/caIKn2rO+rIg3i0Cim159Tt/TgdHucq?=
 =?us-ascii?Q?8YrKSB1U/745dnmqJnr7lRTnO6J25y3zP3EFdw40u1C54+nLRcuLIhN6Bqnv?=
 =?us-ascii?Q?SiIgjab8hYFk292mps64XQJ6IF5jWPWjfmdMzpS+YtwpSjRDz0gIU9Qf9KSb?=
 =?us-ascii?Q?DBV02kvu5teZ5uEBPDmF/zQ/Jq10MWUrlHyfmYoVdGZCiyTlVBcPH7E/S3IF?=
 =?us-ascii?Q?vR1d0apsScx7faiUjuGK9Zq/aJcCP0r4h+5WjM2WfCfh6I9WcZ/9j0Bf0m87?=
 =?us-ascii?Q?1zU4aaX4yhUEgqT711KtNjOkoGtCR0bshqFQhUuWOjkROwxEnO8gSZz2bxnT?=
 =?us-ascii?Q?0VvkPKUdkfEwwhzfal7lNkT4CQmUGJIKUitilqHJ67MhE4VtuQAdA7P+6S+6?=
 =?us-ascii?Q?mNNeHsX1qzQqv4UVc0Bp7lUCKuk82TfnBvMRJRBG7UqoPe4vAmrCdMp+oCB/?=
 =?us-ascii?Q?uGVCGNTyh78nJxuxBjq2DhRoN3qEi5HOKceFYVV3PpwsooigfaxyvYSp8i/e?=
 =?us-ascii?Q?zcYi0JLVej7svxPq2/i/eQ4ehNSkrmmcnH0x5nSHyj64RCMYz59INtXisRFP?=
 =?us-ascii?Q?anndLOQylD2jtcu2nC2opMyYTsmqzANqzK+DL+90eVJasfdXXvJ64W64Sr8Y?=
 =?us-ascii?Q?kHXVAo0VLn0wu7cRMNS8ouB5b2n0Fg7gcNgrgUEQw0ErA+5ZYyM76u1HX5fT?=
 =?us-ascii?Q?ka283FrI1dCpnyRalvUJax67j5XBaDc8SjhdSnRgbmycUwMVltLRjTHOP+Jv?=
 =?us-ascii?Q?JRcIadkOMn3ODsNBlynZeCcmPpAPz+CZIRB+jU4lu5sqvpIXFTMzUk+9aH9x?=
 =?us-ascii?Q?/AFUSdDOFrynVIcMduP+OkBW+mespiw0aS4E5HcL2O4ZF8mnmQRgnyq7g185?=
 =?us-ascii?Q?aq97wW74RtsT2WNCBjTQ4nlhgcVzfGJsu3i5YtdufSwtHG7drAOtYNT0sV2t?=
 =?us-ascii?Q?P+GDIaJDpjlaGoe5a29gZEyRSanjPTV9xm2vjAoEzHhZSmj8A4qmoyrG59yJ?=
 =?us-ascii?Q?KqncSgeEgP4ZJy8W13sB7yAvCS/CR+bqcNB2PjegSj1+dQi/mHF2iFRM+5FE?=
 =?us-ascii?Q?8MpUjy8uVA6AJZuml+xkxQQfr+gDQRp1I8gXEIidwMwvrgvX3UM8uDCYqr8d?=
 =?us-ascii?Q?tKDF8F+GstgCb27T5+HzIwQoGu4oIWJNFycgI6S/D/E7S3919ivpzBXbZ0i6?=
 =?us-ascii?Q?EOkP8w6fn/b5shYNirKIS+iOKWrbEsK9o57rAhj5i7TBzUPi2WQzn28J3wZY?=
 =?us-ascii?Q?95vKSC0T29h1suKaDv1AJmor6Hq1Ba7/xXPWn5mS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e951ac1c-f208-4a72-9438-08dcee820808
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:02:23.0827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMJ+CzLohmigMqGXepsFkCuNLbeig28QGnzPneO/2ozfyJKKA3qrhUO3zXfsyaeMHkSRyLqgDfqEw7mPqKBMlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

Compile enetc_pf_common.c as a standalone module to allow shared usage
between ENETC v1 and v4 PF drivers. Add struct enetc_pf_ops to register
different hardware operation interfaces for both ENETC v1 and v4 PF
drivers.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
This patch is separated from v1 patch 5 ("net: enetc: add enetc-pf-common
driver support"), only the changes to compile enetc_pf_common.c into a
separated driver are kept.
v3 changes:
Refactor the commit message.
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  9 ++++
 drivers/net/ethernet/freescale/enetc/Makefile |  5 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 26 ++++++++--
 .../net/ethernet/freescale/enetc/enetc_pf.h   | 21 ++++++--
 .../freescale/enetc/enetc_pf_common.c         | 50 ++++++++++++++++---
 5 files changed, 96 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 51d80ea959d4..fdd3ecbd1dbf 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -7,6 +7,14 @@ config FSL_ENETC_CORE
 
 	  If compiled as module (M), the module name is fsl-enetc-core.
 
+config NXP_ENETC_PF_COMMON
+	tristate "ENETC PF common functionality driver"
+	help
+	  This module supports common functionality between drivers of
+	  different versions of NXP ENETC PF controllers.
+
+	  If compiled as module (M), the module name is nxp-enetc-pf-common.
+
 config FSL_ENETC
 	tristate "ENETC PF driver"
 	depends on PCI_MSI
@@ -14,6 +22,7 @@ config FSL_ENETC
 	select FSL_ENETC_CORE
 	select FSL_ENETC_IERB
 	select FSL_ENETC_MDIO
+	select NXP_ENETC_PF_COMMON
 	select PHYLINK
 	select PCS_LYNX
 	select DIMLIB
diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 39675e9ff39d..b81ca462e358 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -3,8 +3,11 @@
 obj-$(CONFIG_FSL_ENETC_CORE) += fsl-enetc-core.o
 fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
 
+obj-$(CONFIG_NXP_ENETC_PF_COMMON) += nxp-enetc-pf-common.o
+nxp-enetc-pf-common-y := enetc_pf_common.o
+
 obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
-fsl-enetc-y := enetc_pf.o enetc_pf_common.o
+fsl-enetc-y := enetc_pf.o
 fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
 fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 3cdd149056f9..7522316ddfea 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -11,7 +11,7 @@
 
 #define ENETC_DRV_NAME_STR "ENETC PF driver"
 
-void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
+static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 {
 	u32 upper = __raw_readl(hw->port + ENETC_PSIPMAR0(si));
 	u16 lower = __raw_readw(hw->port + ENETC_PSIPMAR1(si));
@@ -20,8 +20,8 @@ void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 	put_unaligned_le16(lower, addr + 4);
 }
 
-void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
-				   const u8 *addr)
+static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
+					  const u8 *addr)
 {
 	u32 upper = get_unaligned_le32(addr);
 	u16 lower = get_unaligned_le16(addr + 4);
@@ -30,6 +30,17 @@ void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
 	__raw_writew(lower, hw->port + ENETC_PSIPMAR1(si));
 }
 
+static struct phylink_pcs *enetc_pf_create_pcs(struct enetc_pf *pf,
+					       struct mii_bus *bus)
+{
+	return lynx_pcs_create_mdiodev(bus, 0);
+}
+
+static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
+{
+	lynx_pcs_destroy(pcs);
+}
+
 static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
 {
 	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
@@ -970,6 +981,14 @@ static void enetc_psi_destroy(struct pci_dev *pdev)
 	enetc_pci_remove(pdev);
 }
 
+static const struct enetc_pf_ops enetc_pf_ops = {
+	.set_si_primary_mac = enetc_pf_set_primary_mac_addr,
+	.get_si_primary_mac = enetc_pf_get_primary_mac_addr,
+	.create_pcs = enetc_pf_create_pcs,
+	.destroy_pcs = enetc_pf_destroy_pcs,
+	.enable_psfp = enetc_psfp_enable,
+};
+
 static int enetc_pf_probe(struct pci_dev *pdev,
 			  const struct pci_device_id *ent)
 {
@@ -997,6 +1016,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	pf = enetc_si_priv(si);
 	pf->si = si;
 	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
+	enetc_pf_ops_register(pf, &enetc_pf_ops);
 
 	err = enetc_setup_mac_addresses(node, pf);
 	if (err)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 92a26b09cf57..39db9d5c2e50 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -28,6 +28,16 @@ struct enetc_vf_state {
 	enum enetc_vf_flags flags;
 };
 
+struct enetc_pf;
+
+struct enetc_pf_ops {
+	void (*set_si_primary_mac)(struct enetc_hw *hw, int si, const u8 *addr);
+	void (*get_si_primary_mac)(struct enetc_hw *hw, int si, u8 *addr);
+	struct phylink_pcs *(*create_pcs)(struct enetc_pf *pf, struct mii_bus *bus);
+	void (*destroy_pcs)(struct phylink_pcs *pcs);
+	int (*enable_psfp)(struct enetc_ndev_priv *priv);
+};
+
 struct enetc_pf {
 	struct enetc_si *si;
 	int num_vfs; /* number of active VFs, after sriov_init */
@@ -50,6 +60,8 @@ struct enetc_pf {
 
 	phy_interface_t if_mode;
 	struct phylink_config phylink_config;
+
+	const struct enetc_pf_ops *ops;
 };
 
 #define phylink_to_enetc_pf(config) \
@@ -59,9 +71,6 @@ int enetc_msg_psi_init(struct enetc_pf *pf);
 void enetc_msg_psi_free(struct enetc_pf *pf);
 void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
 
-void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr);
-void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
-				   const u8 *addr);
 int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
 int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
@@ -71,3 +80,9 @@ void enetc_mdiobus_destroy(struct enetc_pf *pf);
 int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 			 const struct phylink_mac_ops *ops);
 void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
+
+static inline void enetc_pf_ops_register(struct enetc_pf *pf,
+					 const struct enetc_pf_ops *ops)
+{
+	pf->ops = ops;
+}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index bce81a4f6f88..94690ed92e3f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -8,19 +8,37 @@
 
 #include "enetc_pf.h"
 
+static int enetc_set_si_hw_addr(struct enetc_pf *pf, int si, u8 *mac_addr)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+
+	if (pf->ops->set_si_primary_mac)
+		pf->ops->set_si_primary_mac(hw, si, mac_addr);
+	else
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct sockaddr *saddr = addr;
+	int err;
 
 	if (!is_valid_ether_addr(saddr->sa_data))
 		return -EADDRNOTAVAIL;
 
+	err = enetc_set_si_hw_addr(pf, 0, saddr->sa_data);
+	if (err)
+		return err;
+
 	eth_hw_addr_set(ndev, saddr->sa_data);
-	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_pf_set_mac_addr);
 
 static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
 				   int si)
@@ -38,8 +56,8 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
 	}
 
 	/* (2) bootloader supplied MAC address */
-	if (is_zero_ether_addr(mac_addr))
-		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
+	if (is_zero_ether_addr(mac_addr) && pf->ops->get_si_primary_mac)
+		pf->ops->get_si_primary_mac(hw, si, mac_addr);
 
 	/* (3) choose a random one */
 	if (is_zero_ether_addr(mac_addr)) {
@@ -48,7 +66,9 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
 			 si, mac_addr);
 	}
 
-	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
+	err = enetc_set_si_hw_addr(pf, si, mac_addr);
+	if (err)
+		return err;
 
 	return 0;
 }
@@ -70,11 +90,13 @@ int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_setup_mac_addresses);
 
 void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			   const struct net_device_ops *ndev_ops)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(si);
 
 	SET_NETDEV_DEV(ndev, &si->pdev->dev);
 	priv->ndev = ndev;
@@ -107,7 +129,8 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
 			     NETDEV_XDP_ACT_NDO_XMIT_SG;
 
-	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
+	if (si->hw_features & ENETC_SI_F_PSFP && pf->ops->enable_psfp &&
+	    !pf->ops->enable_psfp(priv)) {
 		priv->active_offloads |= ENETC_F_QCI;
 		ndev->features |= NETIF_F_HW_TC;
 		ndev->hw_features |= NETIF_F_HW_TC;
@@ -116,6 +139,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	/* pick up primary MAC address from SI */
 	enetc_load_primary_mac_addr(&si->hw, ndev);
 }
+EXPORT_SYMBOL_GPL(enetc_pf_netdev_setup);
 
 static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
 {
@@ -162,6 +186,9 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 	struct mii_bus *bus;
 	int err;
 
+	if (!pf->ops->create_pcs)
+		return -EOPNOTSUPP;
+
 	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
 	if (!bus)
 		return -ENOMEM;
@@ -184,7 +211,7 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 		goto free_mdio_bus;
 	}
 
-	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
+	phylink_pcs = pf->ops->create_pcs(pf, bus);
 	if (IS_ERR(phylink_pcs)) {
 		err = PTR_ERR(phylink_pcs);
 		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
@@ -205,8 +232,8 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 
 static void enetc_imdio_remove(struct enetc_pf *pf)
 {
-	if (pf->pcs)
-		lynx_pcs_destroy(pf->pcs);
+	if (pf->pcs && pf->ops->destroy_pcs)
+		pf->ops->destroy_pcs(pf->pcs);
 
 	if (pf->imdio) {
 		mdiobus_unregister(pf->imdio);
@@ -246,12 +273,14 @@ int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_mdiobus_create);
 
 void enetc_mdiobus_destroy(struct enetc_pf *pf)
 {
 	enetc_mdio_remove(pf);
 	enetc_imdio_remove(pf);
 }
+EXPORT_SYMBOL_GPL(enetc_mdiobus_destroy);
 
 int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 			 const struct phylink_mac_ops *ops)
@@ -288,8 +317,13 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(enetc_phylink_create);
 
 void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
 {
 	phylink_destroy(priv->phylink);
 }
+EXPORT_SYMBOL_GPL(enetc_phylink_destroy);
+
+MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1


