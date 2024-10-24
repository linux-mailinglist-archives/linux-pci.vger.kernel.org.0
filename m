Return-Path: <linux-pci+bounces-15177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCD59ADD3A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08ED21C20C89
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 07:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1729D19D062;
	Thu, 24 Oct 2024 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fH+FEFCk"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E701B21A4;
	Thu, 24 Oct 2024 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753773; cv=fail; b=fj3qUhuQpW2zqHgA5L5gekwUtdZWB0Fg9N1+Nfq1KN6swjMN2KfoL8Hd/8YeO5ZMfBsjr9vog0h0qMqee7hNNcvFpdqKKgKexwMBtr54jMwwWI2FGqrH4DVNo9XUa8kTKIu583WXsKTAJoroUzM533vJ2AU1D2Fqe+Nfmq96R2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753773; c=relaxed/simple;
	bh=dfiezfPnwfj8kZhHarcT9H1rmttJHrwAW+JAdA0ijjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HtMGPVVyX2as2WsYvt/VAp76wrNPYitUFzOsMWKDDcyo5EdGx/g38ip29F3nXT1jtoMJCIMAC1HW1AEeCcvDpf44uy63kyuA+63M+SPcDUPmKj6MCL9VvVpMUw+iZAMQxOacbazjFPHFdDODL0aS7ECYTFDzgE4uXv0p9tKw1RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fH+FEFCk; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPK9GjXIjhZNvXQpvOgZlSE0ekpZ8taqMMB28xQjcgJWCMTt5+Z7Q/xGkOxfXKf9Mttr/hN4U/z/gMzgXjd3Oq35f6Z7CNJEfzjfuKlhl2e7qFxXuxA+YRaur2nGP60SCyJ+1ahBTD2SuUd0rxnEd3GUnV53iwvCX3OfSnHnWVxiV5g4I1X631ZsqOqkJEOJB4780OU7sJskAb31JZ70+5+VjM/q+lyBeM8ONf+3DvpLfvxasRzWy2vkT2wvOvPIm6xudh/nGboYbuvM2tIVgQmgeuL4xuxek8SLofsQKzacUGyMEbhi1ZeCJpsT0inmdck8OMEAQE/KC2vZbznAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWfM/tVQ77rN+9LWuO2m6Xtk/LNlxj2H3IU+Zbxpv7Q=;
 b=IFahPUem5988cW0BDkjRPHlKLz2RsSYWR3o/mpeKSvfwNyt87AFErEIMqm1AQTb7u8vJgmcf9osgk0sNg2mCFRAWSd/5Q1maIv9oND41flJ8yPqdaS93OmJ5bOmC7fX9eaFWKh56TPKbnx1rSwNInW3S2fwzka88RbO+BttdOgdS6VoccVS6yWt4IM62oZBxBPzIC17EpoYfqDKUHtlhCkL9QZvrH/SFCIa/miUJ+B0Nio+YqI/yXbiRxP4L7cK9xl2XqI+JAlnfr+Qit/tcUjUGEr7LqiMTATi218Gz4AInkKVbr29DRFJtUy6L6hW35BmoAwomXWN0n2fUtrcOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWfM/tVQ77rN+9LWuO2m6Xtk/LNlxj2H3IU+Zbxpv7Q=;
 b=fH+FEFCk6yuFO0CkAOqMhg6p37+hKykcFDI/7eAgF08VkFHNXbq1lM0jZDtbKzB5f6wNcY7BN5I3ZThFS+95UPIx/3P5WF4BnozgxZxByBYcUto8Z3Fi3BFpT9yP6PrEjNudkNxDTdsXHrsHpPhzoeIzRbGZvg2WF+SSgZs9nFYrANY620yal43k6yVn6Ej9QrmopkqYdxE5MAwywKhibarsgSDg253Hmcg+FQKMgvYD0PrrA4Ezm4flRbuLPYZluuJ7ILgKWG54jCjlMrMyuy2d7OuiMyUzzvpP5KWMMg5Bg3QZ4MxW8AGeCwgUD4VZRFdtqtrD7dgN6vexpiAeqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8627.eurprd04.prod.outlook.com (2603:10a6:20b:42a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 07:09:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:09:28 +0000
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
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v5 net-next 08/13] PCI: Add NXP NETC vendor ID and device IDs
Date: Thu, 24 Oct 2024 14:53:23 +0800
Message-Id: <20241024065328.521518-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024065328.521518-1-wei.fang@nxp.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: d52f4834-196f-4b3c-633b-08dcf3facc79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|1800799024|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ePzczA/qE1/PEtK9Oh5H15PgNa59fZwd16+CfUTmH7nkIB44cCVaedYSR4cx?=
 =?us-ascii?Q?08yJxXRl1tzWkSOumlS6XY32Vm+CgPQ+HY8UbzSnRF+mVN/FXczuYDjTeyN1?=
 =?us-ascii?Q?CUukKMKP83lqtt0VjgK/IcJlwcdmu1Z9l4vNltoWVRZxl3mK5AyO+yzTYy5X?=
 =?us-ascii?Q?AXOiIEW7c/T6b3NakiuSo00lZ0vblMyFwz3Tjfo/H/mJTwgeWKPpi3H91fYT?=
 =?us-ascii?Q?l/EneRmjcNQxz4yz04nNbaCo1eRerctdkb0d4n30+YZqcUnEsUPovDGblNhD?=
 =?us-ascii?Q?vI1/0eWIsvthmebtcZ0q00gfAtLvhF0VS+sDkCIokaZaH+1aFUn6dhrgsbAS?=
 =?us-ascii?Q?BnaAUBUC7hV3lpMoHllqJ4obX8QVj/R3x4k3X7BvebZxt4jPYtqIhg0Czq/l?=
 =?us-ascii?Q?7Ja6t2eFYhdQtaUlW8hx3eE3S0+qnd4xXIVf2hu7guyQudIpr8pGkz/WSpEA?=
 =?us-ascii?Q?6w1FHPhmMJF2JpndOKUN3Ud6L9ZG0gZLM0nAXW207xXYzhFsNN199zTwtE9d?=
 =?us-ascii?Q?gRwYjtwK3xHVVSjlsFCfOJ98P+RAsiP8eFhSTE6Qdhw/klbDv/uggqG/PZYN?=
 =?us-ascii?Q?W/yclgUD4d+LzRQBCu19TIsj1p6+9+P6GYEigNp00PgpXwzns+m4SQhpm3Wt?=
 =?us-ascii?Q?oqdd7rj/Hnr3j8ox5ow1r12pjthuec6xjaVPP13yTNKWnMVCQt/XYrd262sg?=
 =?us-ascii?Q?fWEP1zJ4mcA2dkMVmZgaXUPSfJMcgM009/Qg9Xb/6LKEWYbHHiKSDinK8gNw?=
 =?us-ascii?Q?9Kyy5DKqvVzQd5KPwZ+rIRw20yXdGc+gh3T4Mm6RMsvqnDRBCD9ZpKXzuVlI?=
 =?us-ascii?Q?Z1HHYKSFlftYl8jw4rQqoJLPm90OeKMtMour21LLlq0GpWnHGK+drDiUj/ye?=
 =?us-ascii?Q?SieuMEkotKfEiHqr4I3UO17KmWPap6vEPnMStjR1zR+faWdMDFKZWAl2qXC/?=
 =?us-ascii?Q?nzPulVVJ6J/K0EDIuryruIQeCaCFtOkW4kL94gD5n+mHpZShDOC8PMFClPPU?=
 =?us-ascii?Q?mv014OC/T0mwQpVZXOF9lqQb3UHIH+B+VyD94mY/FveFb+VC+d7VS05+iC0G?=
 =?us-ascii?Q?d5n5HYmAjxVVd2zpoMWJQ9vJE+Zu5hc3e4kusgiLJRrOLpNAdLYLlyPTmp8+?=
 =?us-ascii?Q?xxjcYXU+8+dQddsVzUwNr11IrxWryGrjRYdTYQksTfAOuma9tSycr4tTbFPU?=
 =?us-ascii?Q?GTixVzu20g9dunl1uCuM6poma7YfuYdMxS1d1cr9mNNesTTi7bJ3r8wFBuOE?=
 =?us-ascii?Q?HDIslRPYJeptAtKqDPP5gCB3B5HtRSOCnVB/oc5zuftYcCdCWbjaI2IlmkkD?=
 =?us-ascii?Q?k1XJ2QZC0ZwHzb391IYN5v4PT8FLLN7ByQ4nKE74FBn/HiZQMekOKC1QMRQw?=
 =?us-ascii?Q?HRGYdm3/xsmLCZ+j9I4davnzWdRn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(1800799024)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AleHlVW4VpRC2nvMJot23aVOu3a8TsWIccTShELDYFeQYM3/wXUeJrog02uX?=
 =?us-ascii?Q?/l8+mC7zra691IUEeF9dKwMy8IBhrJTe8JMen+qBLRmosOSPI+mOAvcASitg?=
 =?us-ascii?Q?IYxB4+MxnPdshWokaP9ltpj+9ouOLIucsoOM6m1D80rjDdZZehyh41sCezfb?=
 =?us-ascii?Q?4INX7NdGcEgy/NW01FtSrnP3w0OBbce+fiwXoOrPlluPZbF6VE0RiunL6feN?=
 =?us-ascii?Q?chxiCQRYPtI3+P9p2mmfgE4/u5WhdW8HYiGTi/7kAdq3J9bUGSdmf5SgZsZJ?=
 =?us-ascii?Q?fDVB0FgZaGSUwQaAeVcTCXvB8QB5WXWq9HaZ7LzYoe7tbBwxTE018+UwNm8p?=
 =?us-ascii?Q?Rrv6gAtYaZ5ezZqrvO3fWaEOqkmAwBseUNXu5mciRRtoU8ekPWkd4tEhzzxc?=
 =?us-ascii?Q?ist/YRIy/Z5Jwrnb0r1X3hWQVib9hi+G1lEAAgX87cf64lBEagoSzKA8N1Er?=
 =?us-ascii?Q?hKq/OLCE0utFqPWf5HQ79lLhciCq4/p+qFfjO7lu2hgPnZwqQ3TpiFhquqSA?=
 =?us-ascii?Q?bB6bz+OhaDwECGWqJkVh1tqIlNLyp4UPv/Htw9jaIZuhsMokDPOx4q5S7H7w?=
 =?us-ascii?Q?SyGpYJGf2bsoUCi/YCoTaEHQuUaduvmM2EKlVTSac1HS4vYNnRXRuKGGdU41?=
 =?us-ascii?Q?BenGhWS5b+AL2+yyK9SNaBXbbiD/u1GKd+1v9wg9DfP3ksBWcFiemK7u1oon?=
 =?us-ascii?Q?bngRMlfxzB+ECj07n6gvj9Cne+8W+mKaJRXCW/vgrHqRy2az/B/uoM13tgGp?=
 =?us-ascii?Q?Kn0WCv/hBihXpDQPmYGcQCV/MM9tXGBYw0KdWQdq5k6G8AzuRF2KRM6UROlD?=
 =?us-ascii?Q?EvCD1zi7NSXRoXT6MnI+nPmsuw2PuzrXydrgUmwwkOcDFGzDtXf2MUhk+PU3?=
 =?us-ascii?Q?zdMLbsVcCgCjEZEZqbG8rml9CC5VlEe6hgcWFW57TtEEqgO1sU+z/AIS0+Hd?=
 =?us-ascii?Q?Wx2u/NJbPosKQnsivzYXEbTf2aDevAdgsVYx5d1xryu+VRAhDixWXj9uOuQ7?=
 =?us-ascii?Q?agg9q3O5laD8f5KwW9WXSqoVCzyynVVUf/firHBSfJmtr3k1c3UIUmI44TNR?=
 =?us-ascii?Q?aMtCBgsib9M9Lf4d0vOiqXnTbL7s4/tx8brzghJt3prkA/uvIkzvZWuvPbvs?=
 =?us-ascii?Q?sqC2+8PEzOdpWd1NBz9RaZTPV5N/7Ue8B6gp41hABsvPV4X4m2hVBKsX/Wwp?=
 =?us-ascii?Q?xDvrCwS1Yz1fA0X2L1qwP5roUmcQ5Xnoam5bdNZpNAMxTaN9jOGyjy5sqPzz?=
 =?us-ascii?Q?qZnbH6qI4qmJfEGsAkcbDnESPGw2bNCrNZJhuGn9MRBo1j2B++P9RMPJpcKm?=
 =?us-ascii?Q?6jZIAAZ/8GXitH9goz+fvCeyKfUv76fhQyFi0t9HP+b+Ul4KF0J3u5vYGenZ?=
 =?us-ascii?Q?xE63Supc9teRficwt/5yRTbt8uiTnypu0ErEs8IaL8y16LMsaJLuGyHbBC8d?=
 =?us-ascii?Q?ijW8W0gI9TrBvlZTDkQ1GqDMe2SOfyOFkJGkff/f8yCihHNjFggA/hotQF1K?=
 =?us-ascii?Q?BX+ZQijf/Kc//S2CUsgxpK/ExU7bGJiH+GwSWBya+cqFbPTYuMxUlH65FA5t?=
 =?us-ascii?Q?2xzmanMJ1+yeEDw3f7kMThyLkDeNQHlQFRy26l17?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52f4834-196f-4b3c-633b-08dcf3facc79
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:09:28.0720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3g3NXX2ibrfZlpbdRRR2Uwd+aZmE+xm+xS/0e60t+Qn0sigFDIjak9OfGG1V7HC/Ea/OjbtqrrkUlqXRP84CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8627

NXP NETC is a multi-function RCiEP and it contains multiple functions,
such as EMDIO, PTP Timer, ENETC PF and VF. Therefore, add these device
IDs to pci_ids.h.

Below are the device IDs and corresponding drivers.
PCI_DEVICE_ID_NXP2_ENETC_PF: nxp-enetc4
PCI_DEVICE_ID_NXP2_NETC_EMDIO: fsl-enetc-mdio
PCI_DEVICE_ID_NXP2_NETC_TIMER: ptp_netc
PCI_DEVICE_ID_NXP2_ENETC_VF: fsl-enetc-vf

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
v5: no changes
---
 include/linux/pci_ids.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4cf6aaed5f35..acd7ae774913 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1556,6 +1556,13 @@
 #define PCI_DEVICE_ID_PHILIPS_SAA7146	0x7146
 #define PCI_DEVICE_ID_PHILIPS_SAA9730	0x9730
 
+/* NXP has two vendor IDs, the other one is 0x1957 */
+#define PCI_VENDOR_ID_NXP2		PCI_VENDOR_ID_PHILIPS
+#define PCI_DEVICE_ID_NXP2_ENETC_PF	0xe101
+#define PCI_DEVICE_ID_NXP2_NETC_EMDIO	0xee00
+#define PCI_DEVICE_ID_NXP2_NETC_TIMER	0xee02
+#define PCI_DEVICE_ID_NXP2_ENETC_VF	0xef00
+
 #define PCI_VENDOR_ID_EICON		0x1133
 #define PCI_DEVICE_ID_EICON_DIVA20	0xe002
 #define PCI_DEVICE_ID_EICON_DIVA20_U	0xe004
-- 
2.34.1


