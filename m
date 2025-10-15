Return-Path: <linux-pci+bounces-38111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CB0BDC414
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 05:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C5E18A2FE1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 03:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C8D288517;
	Wed, 15 Oct 2025 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GJjgf7iv"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EF72BE632;
	Wed, 15 Oct 2025 03:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760497518; cv=fail; b=MFIrP2Nhge2OZ0PP4xlKW7h9KWLH056VvE/SLLfdvD3pBQpTZ3YeTQ5DTrTZ+GIyBlsfzM0FF3lULzW4XCZezbN4Q6GuZ3LOH+vXsmKzvGtyU58aGvE444Vyw0vyTIG0nohJfY4vxf8ND+2ITL5phtWysqzPdBdhEEZ327LOTmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760497518; c=relaxed/simple;
	bh=KaiRrvxLMu20wi0cQTJlkLkUybIwlpCfQF8A661aGKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=npMU0wHY00vDj0znyAPLjXdF9jTPPDDx8wFVMN7fSUM/EZehyJNtaiDXD32zHyopQ0bFRD4wrcLDkk4bf+Nwy2RoK+T7HApT38UstTYrWeQ7H+WeW7al9wI88YQdO0YEQphSGWANLoNMPB9e1wpTcMONu3uDfjWbRo6YOV3IDgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GJjgf7iv; arc=fail smtp.client-ip=40.107.162.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLiqoSip2EPZ/AuMx/ANQWg66J9yVSyT5x8J21UMXdWF6duMlRxBARI+x2U29ioPcAF9qDFVFnm6xFFPU8bJatVE2yg79VdSVrnxJvFpWoCTvDX7cSJa0Cn2kYxVlfSLoCitZw0aB30bnb8krsWAYN72Dg+bwE44VIpFAiRFJtXy8YxaqDkGAHEU8P4eI8fwDxPscQ0mmSxbYoDWreuZD5jwi/pdFBuRoMzU2REDJx7OOmAP4rdZC4NY3Ggox/TNbz7jnvd0C8GCBmBJek87SMgPPfUDi5O5oLaOIfpJ6l5EO3RkBRjlCwqQzXrn2Zujs3Z3Sxs4YWXi0UN/3wkShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psQRIcBjSh/LCDX3lElxD2KgYKi3D1VCa0eLrYhjGYk=;
 b=rAA1pjmzase6A7AzvCDDAmaP/WO+M26d93m3wCXCL4njLYGjUqfg8B//tpDYfDdhl1RVmGNYaOe7LnOwfwzoKKJzcHOxRBjjj/FrBiaZRGo51jptkrJ6g3AoaX1Ndjv8zirpwFIyXzpkSndqwoOimlL5mSMyZGmUYHnFPllpDpniTkkz0EF1zp1ZPfofvDWKB3V4XAm6LI7vs9LcS6KzRPSnePZMY8c7tVZgmhpB6CNK4rGdb5gicSfID0ljihEplIEk6lmh/N6GBs8KSeSMXYXcgfgGecK+z1YvT4PQmgWQSlgTDzJ3FnwtrVtqlq6pH0RS7Nf+MbmxJBl0QopIhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psQRIcBjSh/LCDX3lElxD2KgYKi3D1VCa0eLrYhjGYk=;
 b=GJjgf7ivScbFgn9kJ9vc8zzfjkSaR5NkR9vdAIZefT/5+HDBJ3AxTKPffRFa3SV75IsUa3FhjKLAM7LO71RUFlHR0zDTJMpDXQhOH3Yoqi3CG41hEuNBuUWgyYzhO2HJy8mHS1CmpmGVnwtKcWQUfjHGRRAVeKEqFVsUicBzmeuvjAWjhA78QpCbmP2lPBzXHS95I6l55GMpLIb2V6v/cmkrO3h3hpYi4Jj4FtUUZAai93cBmkUtU14ypJTV4YG+FLVwhWd6wxlsdfA4JqQ0kLB9MkJMQMJb3R47wpgEo0HiexzSp6CpTMmqCp2z8VZHTrCfIj7dxpR1LrtMzgeR5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by DU2PR04MB9521.eurprd04.prod.outlook.com (2603:10a6:10:2f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 03:05:14 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 03:05:13 +0000
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
Subject: [PATCH v6 02/11] arm64: dts: imx95-19x19-evk: Add supports-clkreq property to PCIe M.2 port
Date: Wed, 15 Oct 2025 11:04:19 +0800
Message-Id: <20251015030428.2980427-3-hongxing.zhu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8840:EE_|DU2PR04MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 24489467-d2f0-4dea-6b2e-08de0b97a904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GOVhlYEbXbrNXwAIi0tjAZONnBTDEG/BHX5V/F8pYSSSQV5GNdGKjmeQemrI?=
 =?us-ascii?Q?WyAVc8mfs7szjwxSseyK0eT/cxyaOTEqJdlfvYJhukARDVJcJZOlUsfdYjEV?=
 =?us-ascii?Q?hylIN3Y6S5DOhjLh9aktz2AEhqL+vxcUQU2g4xeOXVRSJ2/MmNCvyl+bqZBc?=
 =?us-ascii?Q?T1jahbq4gDz+wUAYq8to0jtYjI+BMkywJ5ODkMdklwrg0bv3qT7EohXVlMrK?=
 =?us-ascii?Q?69FIrk7PbzdfhMKjhimaF4Ulomy6+jumenwXOy/lZUaU+CO/Wxn1YIhHe2XP?=
 =?us-ascii?Q?0bIztGHqdLhwWFWr+O4GfWyPrlHraYYSgQMSY/DFQPGuZSPu6/6HZDyO6a5K?=
 =?us-ascii?Q?yxugY9+jewvrrCQ7lECgNLu0eHWJzmRIfMlXuUGoos90RyWiFSm5putWcdG4?=
 =?us-ascii?Q?UKe2PeW0U4NIm8TCXbubCfczPUD4fxmto2KezgSfqWBwHAFnw++G+GVSuim3?=
 =?us-ascii?Q?UfPWAI3CYYiZS0bVsGFkopw9IFKb1B5BmfK+GhOvG0FDVTOslDPp631JLoCe?=
 =?us-ascii?Q?hmhSUBjj2fyIzPl2enggbidBx1JVyKq+x6eMMN1k4HtKtSQVgsNVPjmJf6E0?=
 =?us-ascii?Q?kBiPUT9IWtr/vVaPrsSLXFiFtQ/rEtzsm6XDjvDVZqSvwVNqzLWQSZvFi+8+?=
 =?us-ascii?Q?RzfNmVHlkVS5vSVc3OLhMVf3E8u12B3dy89wXXiCOU0/Mhtba7GZCatL4zw3?=
 =?us-ascii?Q?jLhy05SvYWgXcv3ol+bAuik5ySju1Qf1AVAJoPBtINYEaL8b4PPXKPg0lptt?=
 =?us-ascii?Q?tSu/9k/UgWBZpbnXpHl66iXSmyca5OYCuEvZBAhLOx+TCtCL98O5oGey8rmz?=
 =?us-ascii?Q?ax+PVZsxfqsNQqHmXtBWcDg66MuOrvlM9qPcx5u9x2nhsjld/atmcs3vmXG2?=
 =?us-ascii?Q?o5UU6skxOptNffH6aNfCVxESV9mbVUmNUyKXwn25nB1BemUOhh5SJjFU/ijz?=
 =?us-ascii?Q?C7Ug2eJfsvZo4oAXosDEyMggiBjGZAYFuZRvXqV3FzvdOp5zOuJgGmlwlNvd?=
 =?us-ascii?Q?xckR6f5/R8DtTqHiEG98VDbDNxSZnQhqvJhtmw8Mcfe5IqSgYzv5KmWiWJtL?=
 =?us-ascii?Q?8IEIbPkyMw5zdm05XKtTHTNusIayvaMaG3Vl9Bn5wtDljajfrbwj0w0LRCEL?=
 =?us-ascii?Q?Qk+5yRBOBzCcwlWdYnBHzNDjqanfznbltYY2yFuq+nWbCnXv+fjaTkEWo36+?=
 =?us-ascii?Q?jXWpSxnbfN812qwtyJBCfKCtrPCLcD/M8MdTDC59Oa7rzWpsicE5eJfrxhax?=
 =?us-ascii?Q?rU+0XWyud+KOiMMGaBMItckzeeKkPqBUYRXgg9lkddwg3HL1NMLSbqiQR455?=
 =?us-ascii?Q?4B2vcOcusj8Mu+50VlMdxCLXX6XlR0c1AHaJ8p99bp+gfqAvZcVqdXwa+6i7?=
 =?us-ascii?Q?sYJiKK7121WEv7HkFh4MOYKrk4cmOb4U6JAkQqNleNrszSP9C5PlI/qjzFV/?=
 =?us-ascii?Q?YcgMSTuOLeSbdLhYhO9F17FruG5DfgpRKojLAHpBjot7xHjLuuPNLoNV8vg8?=
 =?us-ascii?Q?QRycNdrIUOntNiKxODnndMhiBZinUNkrLqxiiVghi9ufuZQLvOJiDmC0Iw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nfMVgBg8EH8SqhZA2S53WIVxCHhMBfW7ScF70UE2xI/cE984MeifZC81zYPy?=
 =?us-ascii?Q?+XmfSco5SYYLPs5QME+Ts/I+epGvs8hafhVGrIsPVti/tTUV+n1DfnvylZRk?=
 =?us-ascii?Q?MMOlkfPFs5zKh0C9R+Eo4TNloGxebMXoDCBIq27SMQVs4IxTkJc+D1bSQUv9?=
 =?us-ascii?Q?Bh8eHsMsno6Bm7Rb4qCcDE/io4Y05kzIBT2j5okY3e947byJua2XE8RBZNOT?=
 =?us-ascii?Q?xObPSQxERD4FUqtoH0jBwOwL79Dk7qNoIWiBbV3C7Y8L1whbSA41K/YTXix/?=
 =?us-ascii?Q?7mcr+/GIZjvrXQSRRGIlpQrHaxFKQvIUqR/4txypE/n3nv4N2swM4Iq+LvJL?=
 =?us-ascii?Q?pcYPz3kobqFQ5BIhFJClLr+JGiC+YukaFXFVHY11LPc2YmiOAq2X6SbhYMRA?=
 =?us-ascii?Q?QJDZu69uCAznpZ6CWGSg2iyHRjoNknkNbmsx4YEqSA5nrJwX4J5xdeio1ySJ?=
 =?us-ascii?Q?mWOOlIrI4x8On1FFleODQ4B9w/wHuLmADxAhMECUaN5XnSLrOnvSwq7G8uMz?=
 =?us-ascii?Q?ZbfwyRf+5NV04PHDpn5SxGO1KYjj2joM1S6REvfENiQv17N0ZERXg4orNhyC?=
 =?us-ascii?Q?PYtdv31RwThDfUA/i4Y0rqK2o6G/mJN1brpvpyghYVYK4vrSa7yzemfpGgRa?=
 =?us-ascii?Q?0Wuppxb2BW8mZzJItnH8gE1TQXQY2hCuLiaLz6nZabg71FUhBYPrK8BRHFEU?=
 =?us-ascii?Q?G4dnjSvNCrJcQmM9/ZA6FXE1Tsq90FGYEp4qZqcxG4fvMu//7C8dIecsnbZZ?=
 =?us-ascii?Q?8SzSuxk2//ZU1sLzCXRMnnjeAay+sY0/otOBvm6SyGbOO9Ock8zcRoLBuRMG?=
 =?us-ascii?Q?giczEHghjJ9yXkXAKOBPe+JMZT+YqMSjzovaU1ylB21d4QeQBF0KmGOmw3hi?=
 =?us-ascii?Q?3o/0g2PLpBbP5zLhi0UyixlxK+nXzQnvKAHf3qlrbLery5NjPOHqitDs15g6?=
 =?us-ascii?Q?Km49YjbRO+zcbHvqCM4cMkcugPofe6qSUkHGGh7Z9wSEr1vNZ3BsNJL0/ZGr?=
 =?us-ascii?Q?RJASRx2xX/cwCTFes8s38tX4jQ9APvJGbIufrvTb2ZMgsz4RRjTNr2HHGDdv?=
 =?us-ascii?Q?8+2ibh73G7FK86ORpRVkQIRAVyu7lOiCohGRv3kibPwds0f1HRYMmiAIolQg?=
 =?us-ascii?Q?RipArRV+BtATB+GxzLx0VVmm/mESJrxu0S/LSOlVmCuGd5Twm7uHuoK/g9i4?=
 =?us-ascii?Q?JvIzfDQpDomVwlC+P0HLozH8eB+y8/ZbvS+tMuIOqPWYutgZuSKslXZT7ghC?=
 =?us-ascii?Q?y3djlbk1JQ12DCQ9WquxJ7MjjUSn+hIG+3oT+z0rUIxG7z2faak1+y6IOLHV?=
 =?us-ascii?Q?4a1XtI2NtYn1965tRh75N7ylPGq+BZ0h+ja3YtIn91WF1LUttIVY4MKH+NLV?=
 =?us-ascii?Q?7Y7Tw8Jmih1u93wHvYtAWV4mYKRdNk5gdhPMsCIhewDm4yqezsE08dyyi8NK?=
 =?us-ascii?Q?t3CVLMU1eXhp/P5AkwbF3vH2BRLGYOIcA7+2ePMRbP/v/En3W67LvK7DAk59?=
 =?us-ascii?Q?7Qz0udKTMTriQASHHLSEBSUKiCTU+lbah+z8a4w7R0hPhIPcjArXGJG1njC4?=
 =?us-ascii?Q?EXAAd8kNX2MN5GS+ZQRFRHzs7IA1l45zYaReCNoa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24489467-d2f0-4dea-6b2e-08de0b97a904
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 03:05:13.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtqTmZR7Yny8AZQYG8QG7FrVSBV4oxfDKnXsDaO+R6YrpByCJzINpAu6vLNlrhWAQMzrlaSzrPvvXk0pneXvng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9521

According to PCIe r6.1, sec 5.5.1.

The following rules define how the L1.1 and L1.2 substates are entered:
Both the Upstream and Downstream Ports must monitor the logical state of
the CLKREQ# signal.

Typical implement is using open drain, which connect RC's clkreq# to
EP's clkreq# together and pull up clkreq#.

imx95-19x19-evk matches this requirement, so add supports-clkreq to
allow PCIe device enter ASPM L1 Sub-State.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 9f968feccef67..0f470d3eb9af4 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -542,6 +542,7 @@ &pcie0 {
 	pinctrl-names = "default";
 	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
+	supports-clkreq;
 	status = "okay";
 };
 
-- 
2.37.1


