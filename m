Return-Path: <linux-pci+bounces-38119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 448DEBDC45C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 05:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD80F4FDB91
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 03:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359192FF663;
	Wed, 15 Oct 2025 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BPbkhxdj"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8D12FF64E;
	Wed, 15 Oct 2025 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497566; cv=fail; b=W1rP5P1MqgU3VAm/GLjwmVm2DM/A5M6rwSCxxYjtz1hZVG7bg1Um0aSlfGaapz0MZQIW8ZSGRBNjLJzFtmw1VfHjRZQZOMiqO8KzNHwNf3l+GMuJfCHU1XoG3dIZzvBfA5TiihLVPPmqb+yJe9Q/s4Qy0dGEgHhxg2VOBrr4lh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497566; c=relaxed/simple;
	bh=oMLvyHCzPnSlGkEL1x4i6V7Wg4iJTktyMru7/TqeGCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cd3tzDqZsBU30z+WImR2hq+viDYBz9RAKzrNSd/fWv+5tVI2OkgqQo3qkbdwHNCPky2ORrWbDC/t0sXjOSXjSOIW4NWOPEaRTSDIQzVI83AlHDn1oWgwIKoWdbLBIoEABYYXwLNspZ93K0omwgxHgUjc/S5Ck5+8wXy//Zya1YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BPbkhxdj; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQdNyZy6+9wUpwSpwygCTGJm56iNFwZXJpKUSEYl/Py7eP7+YhSd8IQRIJMuhGwVprGI2e5mxVmP1oY5MHkuKo0XsxCY2zRha9NoxKFd8aQEKGKj/NLfU9b2Jtx2HQtIz7Acic8rwLabPTeJJeIFpr/MgV+oktGMxb8gy+6/9N+xa2vm/bRbYMBsMjPIJgJrRMJb9urer34lgMxoCttNsFt1ID42FCwNiLfN7WLOrxqz9PiIFb2UjS4D2ahgAKa6e8q23Rl3i8oU+JuqGkURjgknxfJXUR6iSqqKGs3X7kGTISTx0IugjlXpVrWRyhHSDMQd83vgmsZycaf9IaANkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/nxvnSgSIeVbRjm36oX4X/6MVNeweOmJ4ZXYqe5YV8=;
 b=B2M5lpsC20biE+2eOf8y4HyK2r13af+sbOPKeW116bn17b3lYQP7vPnGMp7CBomYyWHUjFoYNCeOsmahOL/xijyUt0rL3KLpdJVb6s9Rle9WmoN1Rm79x8X+27tGvT9bt3REZ9WYTbJnId+6ClXI0GApjyQ8MFsf2SU+F4mTF7NTRlgJcLM0yzTZLpb2iP8dT6sbo6VbfnV1iyMP8Z+Qk92urNVcfEH3d8sZ1l2RzOcuF79E+bB6OJqmznNPElxZH+y2miYJH54eloRt/8wJQCVl990ZUNZV8neFFcVIzncZrp6yKJzdUphYOOA3hzheyvhcrJ6wkRxHocwPpH8zgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/nxvnSgSIeVbRjm36oX4X/6MVNeweOmJ4ZXYqe5YV8=;
 b=BPbkhxdjSNg3Mc79dN1IPUGLYdoyAJX2lcxWeZGKnTjHovefW6ORy1tBUaQJ5B3RrPJBUgxH8jdHpGNdxUkCrUTk9s+ODt1RJ/yDTr3dLKfX6p5Infc3PzTgzTPrUOdUGD1U7Cze2CSg4wc137gLcTZgR+lZJY/xSt8qoMoQxW0AUybJZgv0Up0zMO1yoMaY/m0pAbQ2I2ilP7hc8/zKFZMy4SV2mEADWwpNPZ10rZfwn4h03v0K7JDoVQjtf5isECmfx/npcnO6QWSfTXv4p9SjdetsTHe6dkkAva0Dbg0OuEx62LR4URMJDbNVVXVPoY9tVVmLLHDkjzwGd+PVRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by VI1PR04MB7006.eurprd04.prod.outlook.com (2603:10a6:803:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 15 Oct
 2025 03:06:01 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 03:06:01 +0000
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
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v6 10/11] PCI: imx6: Add CLKREQ# override to enable REFCLK for i.MX95 PCIe
Date: Wed, 15 Oct 2025 11:04:27 +0800
Message-Id: <20251015030428.2980427-11-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DU2PR04MB8840.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|VI1PR04MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: fa104350-8f5a-42a0-d8c2-08de0b97c53d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g7+0dh+6Hff/MUtmxjyCdViRg6HafeXkCcYRNjBq1TC3uh5SHZsBFVYsPjPG?=
 =?us-ascii?Q?TPoC/UV/MXate7+NVVjJxR4Jwdp/lBMDv6zosdaOvvZ2/sKtASmqu19QhxFx?=
 =?us-ascii?Q?hOXqtwMqfhVw0Ny4t5uw2zQBkd5VYUe2vSNgBUikXNGCPsTX2yZYR30I9LqO?=
 =?us-ascii?Q?Qwr+ZpmZpMdjTSRijw3dSsqEcx1NMNwhpUfZth6ojuTtrPoHZF9gPdNIxwZt?=
 =?us-ascii?Q?cH41EMu54ORjHG4dsz1PYCqGz9c7mEsYtmG/Pt0ngbdT8aM7flt1DINOXqOm?=
 =?us-ascii?Q?lSP+dLlq9pPcwFUslijrQG9tW+OhnHB58cWtykjQhhxZIpRGDLbIToz+iHO7?=
 =?us-ascii?Q?Gk+c5ngarOEYWV28BV5+RyoyAjEuE8peojbPkbDtIGs+bzSKsXND74k+SemH?=
 =?us-ascii?Q?T9Yw6cR4bJXRtEPqkvObLImqEZvxalmLPbdKqVJkPgc35JBH/X+Aj4YxfPx8?=
 =?us-ascii?Q?LYVebbKI40A20/9zDVqdEubmdPvGkFY/aeRYWYw+GmqJS2ipXINRSCGd/2vI?=
 =?us-ascii?Q?x0HQuPBklcin9htCyv4s26h+sYA6h4g6ltcRw0KBavAozN84BKbUzPL4Ga7D?=
 =?us-ascii?Q?ShlDTGHHW8aeiNa077oCCrKSjNzfZ7/WkJVoRutZsQBC5tSkeUmOhulPrjPI?=
 =?us-ascii?Q?AwDHw7Cshx/NB4b8zLr/X+T0GE8zCMS25K/GrzEcfLS4g+7vuSS7cgwN6opc?=
 =?us-ascii?Q?krOFDiAEPX9S1nFtBgnCUyB531RjY+uiY3YG3gsFcp0ovtQ2FGcpwHa29/YD?=
 =?us-ascii?Q?ouLjB6aO2ixZ+mSyaXMZKEfTEhOO0QJGFmxy6+37CVsncyioPw4mWC3mvhyp?=
 =?us-ascii?Q?gBj1GQ6m+sjrfOiN/VUCkMg3h2hXZZM4QEX5P5Iq1U8ZI1dfWEaJDRM/3vhJ?=
 =?us-ascii?Q?B0KvbvQcmXTYGgVVQbHYFrFs4AcyPog7OczLJbdVqKbhjFtFAA01WZbxwDYM?=
 =?us-ascii?Q?8Cau3uEm12rKX/4NSs/rB/FBK5m2XysMb0SQVH9gp650x1G9TRowlmrvR/lO?=
 =?us-ascii?Q?X6LJczL2t2VW3sR9wqp1qT8C/QPIWX6YG+FlVACCXLxwgA03OHaJEw312qer?=
 =?us-ascii?Q?sL5RZMJIg13WGJYfgyIpkMcqmT4yALp1MeOdghtsA0Wh4yc8P/NSHUlPQlPn?=
 =?us-ascii?Q?Wk69bZY6BkaDzyJiRFLlGlj4KB9Qs8UrXioBau5GsY9UkPoOX71uYKJPgWPY?=
 =?us-ascii?Q?+9P4DEA9+vra55ZowpFN4zKvIZBB92pMOFWlvX8ikkq73WJGBi3Hq4QzGjlw?=
 =?us-ascii?Q?NSVhuXfZquCUTkyvnYFamSb/jKsmyn8ASyFBj0fdB+jj4D9VynfDRJsfvbZw?=
 =?us-ascii?Q?s/T2pQxfg/8e9RKVfndKajVeIvcC/zAvGlNOqDbOiiYnp7/tn+fHPvTHIfw9?=
 =?us-ascii?Q?T+RQT1RN1+PjLwHIgMX2Ta2vEw/1p9gH+KDQ6ACgOm35tqSAOSIRkThMKZdz?=
 =?us-ascii?Q?9DcOFNiMQNG2/D6hf5Axuh5dqMqsVpykHXr1ewwD5OxPCWisz+TMOfB5zMo1?=
 =?us-ascii?Q?JoBHm380Gyj7JZOcvDtrugYvPjlMZLe/fUPBDzRjUhuGODBSlY1tVPvzjw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5lfqmwcM+OfLalTqJs3U8HxxUI6FWg+KSx/VwkVJyh6uoVc2w6MCZQTvwHu/?=
 =?us-ascii?Q?JXlUp6L3iyaqLwY5/L3DsSDcr3YXhGEOSelsCGp4pjh1tQy8+tg5vlVxgVN2?=
 =?us-ascii?Q?g6yzfzrrRysC59AY197uzzroKX8oG0n4BEoaukeJ6FY7QLS9ysmOPMmIQdvd?=
 =?us-ascii?Q?IsZKK++Yyto0yC6/y6lZA4MiWyvvDR+M03pJV+P7WqZ7pj2KWGLUxEo7Aj+N?=
 =?us-ascii?Q?0J3J+/ymUTzbVZkkL8o28GuTgKORZ11MfwdMyesn19YY8fveCid9DnIKb5Wm?=
 =?us-ascii?Q?Yy/Xg19uw6w09HI+pKHr5FKlTZ3IlTglW6Mlt5v/0bzrob7xw9mhPpsxeloE?=
 =?us-ascii?Q?HVanqYE0AOT/L8KN2VysuwOrCxoj/wXpiQ9vGwDst6qG/Kio3hZw92ttcJKc?=
 =?us-ascii?Q?MXPUjVMgyKiVGajii6oba0vR3a57d7GEUHgoal+haXdrLdSb6dZV6mh1pjx1?=
 =?us-ascii?Q?zeEqwL8jlsuGVsTMnK9v5+H7rbx9TOPvliyQoBgARlYVUpbwSkVuKmPEefea?=
 =?us-ascii?Q?jLLECjQTWQUi/mDHf5Y1nIOG0f2mh08k1btOm0uifVrLNVLRBzhHcDodC7NR?=
 =?us-ascii?Q?BRxsp9iXvWqeuzJNU2/sCbG4fkPLN35hXR1sLJT4zhGQc3ezv0iRHAjGYT48?=
 =?us-ascii?Q?dfs8dIQRfF8dJl+433YsKEHrso4jqQhYtKi/e80eyny+gbtP6aepRp6xhu0K?=
 =?us-ascii?Q?gwh9DLmV6jswV/ghCN0qdEc3NRdQt1g28X4DOVAsLO2zNU0XiseGpkXIlTwo?=
 =?us-ascii?Q?LOdx3802asA412LkraX1Lgb1CNCXeGH3SpGPrRVRUkTnF5O7Dr1hyLftfAPT?=
 =?us-ascii?Q?I3WT2N/CnVG0Hz4dolEgZyylAAX3QAi0h4GhNZXtvLcKymv94sO2ZQI8+OcG?=
 =?us-ascii?Q?PuiviRDNzlK2WzDBh8BedQjcMkegzJ6NOzOsM6vRacbFbxaaZEyqysbf3Swa?=
 =?us-ascii?Q?Gx77P9p4ERRx9O5KfbECdGv+isnkmQJRdzIPbGoDpZlngv5lF9obrNVTCExU?=
 =?us-ascii?Q?10rpgGU0itc1r1B3I/KJbyit73e6adPJuDwuw8vfp+fQXV/Kk3Wz4kF+/DUq?=
 =?us-ascii?Q?HSq11IfjRe7MM12qK9wd0+Yc78K/sWSnZTL3PBQSiaKHx9+sQFqoy6EmPmj5?=
 =?us-ascii?Q?m2Tz/PnJMDoHmq5kF2BTP7g6NHYWJU6ZFT271iIKOMLSX8q+2PGo/215JVF9?=
 =?us-ascii?Q?bMTPATVGSN1ZJe0JHjSq+1vhGbHqAIx1zlaOsFEV779JR70Wx3DDA1YTs6Nh?=
 =?us-ascii?Q?RfcXQHvJfa8alUwT9in6eKib2hwt8xdmMIov+nsZ4OZjuzEwuG2mbtN2DsyK?=
 =?us-ascii?Q?josA+JFp00SC5gyeTx1eQ6oLt9g5uIHm9jgoxF+VSsenP163989x2N9QHToB?=
 =?us-ascii?Q?MUo4havL1w9PSWkd14qJ0vMDQK8HsFwXwwzE2ldy4p3PDHHjReknm2juLNGd?=
 =?us-ascii?Q?6Ux58J9dw6cgd233zcuO4/ddpk2sTzA2q+xiWODcCp29xWdYAfvVtzG+3lLt?=
 =?us-ascii?Q?9sxON+ECkFJsd6wt+QWllJ/YxcjqhNbuVcQMnClOJ8SC3069I2XElIaj+CKc?=
 =?us-ascii?Q?dT6EvRxOWQkc5z05BEuiQIsnlaSf8pFV9EdItzv/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa104350-8f5a-42a0-d8c2-08de0b97c53d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 03:06:01.2481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcS3OPY4KtyXnWRtfGOzZn+u5uZLuKZ4/ZXK7x92qQlf5z4mKbu42bYSfiqHWyJeJiz++MmF+I7XLxaQRpch2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7006

The CLKREQ# is an open drain, active low signal that is driven low by
the card to request reference clock. It's an optional signal added in
PCIe CEM r4.0, sec 2. Thus, this signal wouldn't be driven low if it's
reserved.

On i.MX95 EVK board, the PCIe slot connected to the second PCIe
controller is one standard PCIe slot. The default voltage of CLKREQ# is
not active low, and may not be driven to active low due to the potential
scenario listed above (e.x INTEL e1000e network card).

Since the reference clock controlled by CLKREQ# is required by i.MX95
PCIe host too. To make sure this clock is ready even when the CLKREQ#
isn't driven low by the card(e.x the scenario described above), force
CLKREQ# override active low for i.MX95 PCIe host to enable reference
clock.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a60fe7c337e08..aa5a4900d0eb6 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -52,6 +52,8 @@
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
 #define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
+#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
 #define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
 
 #define IMX95_PE0_GEN_CTRL_1			0x1050
@@ -711,6 +713,22 @@ static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 	return 0;
 }
 
+static void  imx95_pcie_clkreq_override(struct imx_pcie *imx_pcie, bool enable)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_EN,
+			   enable ? IMX95_PCIE_CLKREQ_OVERRIDE_EN : 0);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
+			   enable ? IMX95_PCIE_CLKREQ_OVERRIDE_VAL : 0);
+}
+
+static int imx95_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+{
+	imx95_pcie_clkreq_override(imx_pcie, enable);
+	return 0;
+}
+
 static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 {
 	struct dw_pcie *pci = imx_pcie->pci;
@@ -1918,6 +1936,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
+		.enable_ref_clk = imx95_pcie_enable_ref_clk,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
@@ -1974,6 +1993,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.core_reset = imx95_pcie_core_reset,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
 		.epc_features = &imx95_pcie_epc_features,
+		.enable_ref_clk = imx95_pcie_enable_ref_clk,
 		.mode = DW_PCIE_EP_TYPE,
 	},
 };
-- 
2.37.1


