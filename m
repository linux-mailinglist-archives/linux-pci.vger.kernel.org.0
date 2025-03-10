Return-Path: <linux-pci+bounces-23369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 473F1A5A4B1
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B9B168C14
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 20:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CF01E1C3A;
	Mon, 10 Mar 2025 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZG5+PJOr"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013039.outbound.protection.outlook.com [40.107.162.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6211E1A3F;
	Mon, 10 Mar 2025 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637873; cv=fail; b=dyowsaS6a+kt5054p1ya4zF3Lq8d7oe8dw2tUuQQUwPLMgYkh+Js1IEP8ouCx8oq0EtsflpLYOIeGnBJm4vkVM+poL9HKjgEjE1agvTXZRkzILpg4hyMnYD4bHxpfvifH1qe/6DJbeIWl/MDoyYgOgeLE8oZubaGe86VF4IHdjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637873; c=relaxed/simple;
	bh=Xh8NTJ8/MjJBYxblPqiSb5gUEnkYNcUhee7ai6srwCk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=k188VrhcNH/KznInbUrp6kd/VtgmTsfD5c/KPDAiPkLsaryfD2LN01zHxw1+FahEOLuP1VkYiKbXx9f5+qBzyFixakdFTeEbsaxObWKlHy087cEkJBlJ3K6HiDpR1lsETpNFRx+rLjs73GYkdJn7/P1WRS7p7FV6oMxISs+7Pn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZG5+PJOr; arc=fail smtp.client-ip=40.107.162.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfPrMFQEop9zb7KVYNVws4tIlP8G53NCF+h8BF/uifMMaTnmt6oKYFjbU/F1xbYfDqqZK2Y822aWWEqrWth4pOUs80kk4q/jZUpMHdKrsqX8e6bldKYcwL9+SL0QjzbtLaDQ2rFBSfv/PaQiju4BWSs/0SnlQkIYtx3GYNTyzewJf4B54NHk07TLRQQ/AghK0RMDF6NOmCBlkbdm9g6CFC69CnEQL8PkPtOIo2/Gf6s11NXpueFJrarR0hRTi2+FZGx2+mkvvYV4rkHGOC9GI7atnkZwFDSmmxkrOxzhmB0fWUs/5VTCUFsN0VMsqIlnyg0Cf/Gq4HoEUllw/fDFkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cf8HTEJk590jqVX2bISnJi0ALTxRfp/MLYPu40IpQDU=;
 b=q39VauMViZZ+Dwn4o9Rq6Aa/bAqBmmNlP5IDErwgoTIAXfeNcZBo0hohWNNHNFdtanuYrRGww25/QYnjoI1eM12p+Wtl4KeJxw3xIkQrcKxoNxSv7U5VcNf69XNi+XqaSC8FODtOwUSpWBz1F3oEumZAfkBT7XbekpaXyywL4e8vBm/ILOkeAAL4v8lAR1ZgjG+jVL/hj9Blvy6v31hXG1Z64eMslFcYPvwO9xCmHWI0qwIwGYVZs6H2KmMaACepDnD3njm8DWI3m7HX0be/Y72JNGrGFjXsfFMqFFgu5HS0a6wEiqPxgT1c//sxtTP0vXWunM9Fvt/vf6+65fxkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf8HTEJk590jqVX2bISnJi0ALTxRfp/MLYPu40IpQDU=;
 b=ZG5+PJOrXXOLJf3fD6+BEFcGP/5rECKC7fZOJu3EpLONBe5g1E6veJyslLwjGogWURQymmycST2WxYv2OFdHRxX9UE7QdbI55itHoAm9cnphhyOKSnGkVcrFJFVfifvOCRFiTg3S3DLbWBVpb46sM2w7M48foEYAZ1dxg5/Tu8m4KA8gY3wzocnZISfLDMW5eSIHRPtlKZoONyqC80/G57NQwpBtT6SugzloN97/rK5sqtcoeVPwuO1KhBE/oe3q/Hvie7zXmnwVIKgQYN+5SHEOKpV0xvc6uThPbH91ZcnDVZP4xteTw8G8ncEi+YKY4na2V2xE30kH2AY1xEIWCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8261.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 20:17:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 20:17:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 10 Mar 2025 16:16:44 -0400
Subject: [PATCH v10 06/10] PCI: dwc: ep: Add parent_bus_addr for outbound
 window
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250310-pci_fixup_addr-v10-6-409dafc950d1@nxp.com>
References: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
In-Reply-To: <20250310-pci_fixup_addr-v10-0-409dafc950d1@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741637834; l=4499;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Xh8NTJ8/MjJBYxblPqiSb5gUEnkYNcUhee7ai6srwCk=;
 b=ur9dsOmVuDE2T2jNd3+lAw6h3TLhQ5HLU0Po1H2UFPLmiGBO4HXUURndHmj/17kHsLVdLarWp
 rS8WfrBX6n1D0+LZhHdr2jlgkzLPIIuTgaQhYeiNIneqJzvcHStsmy0
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: a29cd4fb-26ef-46ef-d576-08dd6010a0b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUk5SlQ4RmRFRVpucy81RWNmaE9jUElpSEVtWHhQMXFrTEQ5T0cwZzdoTnc5?=
 =?utf-8?B?WFNINE10QXNFZTVXbk1DcHBqemE0WVlGN0Y1Mi9SQ296bUJJbVpsbXlocmJP?=
 =?utf-8?B?VVQ3Y2tFZ1V3bUhOVjBwQnRNNDJzL2FPMTNIMVQ4ZEliQmlhUkxudGxGa1pl?=
 =?utf-8?B?SjErZTNsQnFFU1c2b1RWaU9VWHdsbjNleHNzbkM0UjFZVWVHa3gyeVNoSDQ2?=
 =?utf-8?B?b09KUW1HZk5UTC9Kb2NITHdEZ25iTTBSYm9GclBraXBqUUtpaUpzSDRJYmha?=
 =?utf-8?B?S1h0SUMzeHN0NGxNNjdCNmRzc0ZTOE1KbFhMVzdjUEx1SFJ1UHlmdW1NbXFE?=
 =?utf-8?B?djlOYWtBRWw1c2JTbXZxbklvUlRiamFuN2ttT3pIRWtFVjZhMGZYR2FsZlhS?=
 =?utf-8?B?Ly9sanFucjN0MTVVZVhPVWFvYzlrZDgyNkNXNmtDek9yZEdPc3dOVERnWTRE?=
 =?utf-8?B?YmV2d05nZzRlU01KOTZPWDNaNDhSS2JOb1RZS1hCVnlkMlZBM2hwL29vU1pk?=
 =?utf-8?B?RzZMd2x2TDBJNlFKQUR0LzVGRHRGNUJzWnZWclBxTVExaDdndFRGcFVsMG45?=
 =?utf-8?B?OHEzYi9VVnN2bk1mT2p4OG0vcVZZdVU5bTRSOWg5Sk56Z1p1ZFdBbjBES0Rl?=
 =?utf-8?B?NjBISE8zbVluamJPQWJ6cXgzVi9Qc1JUZzJCem5ySVRPRTZGaVV3K2h1K2lO?=
 =?utf-8?B?Zmo0SHpBbm5pU25RazdJTGF5TldkdWxtdlA1QTZMUE51cm5WVDIzaXRPdzVh?=
 =?utf-8?B?a1ArVXZVYzg2eXdWcE5BYUZUd1pYS3g2Y0RNeDMrM3BYMmgzWkI0dkZ1ZFdO?=
 =?utf-8?B?dHBieGRTT1ZRZUg2TjlxaERKS1cwM3cwUk5hNUhnV211N3lxRE41b2ZFVmxx?=
 =?utf-8?B?bGNVb0NkbXQrSnZSSXkzalBkMmU5Y2ROTTZXVFkzZGsyNFNWcVlEUE1OWjNh?=
 =?utf-8?B?RWZvQjREV0FpU0diRjhjZmZJK01WTnMwd1dlL1JoTC9LQjNVWlRRSGg3RVIy?=
 =?utf-8?B?cGFFMzZMa2NBcHdWbjFqVmI3b2ZGMUl2QjVZM1BDQXpkblBaRysyOE5sS1FH?=
 =?utf-8?B?Y1V5VmMvTk1BVzk3MFllV3M4Uk1FaWlzNEtvUjRTSXV5Rlp5cGpFRjd0NGZV?=
 =?utf-8?B?cWNkaTJVei9QRTRTNzRUaUMrWTZGZGFjcmlmbk1oVG5ySS9CQzFldlRGUlp1?=
 =?utf-8?B?ZE9kdnlUMzhKZU1ZZ2xKWnJ6elJwNHRta0FzZGJHZmFrdlVaK3dKYTFxSHND?=
 =?utf-8?B?cEhWTFVKLy9lYXd1OGd6K1JabDJ1bDIzcGJlOU93eDd2dFBJZUZ0aWRUREJr?=
 =?utf-8?B?bzRYZURpSldSUWRCTUJOVzBKTWlKaWg0WGZMTE5zODJwS3B0Znc2S3RNSTJs?=
 =?utf-8?B?VHArSkxHek44K2RBRnNIQjZpV2FZWHFNdHNqSTE2aDN5K2xMOEwwd0hIN3I4?=
 =?utf-8?B?K2hBRmlMWEloU1lTK1VPWGVla0QvcVNOUUs1V0N4dm1kbklBWTBTeUdrZ041?=
 =?utf-8?B?ZnlSKzYxQklMd0M3RjlLblhOK2xVVXJKcDdOd2VGU1QxVmpJOWtkOWFZQ0JO?=
 =?utf-8?B?UVp2REp5YjVKWHlUUlkxU3BvTDVLOHJlbk9nS296U3EyVmk3dUt2aW9WWnZ6?=
 =?utf-8?B?Q1NGc0s1bis2VmFHb1l1WGFtRlJwRjViMCtKY3JSY3JGa1lTK0RCaFluMjZh?=
 =?utf-8?B?ZWlqRTg5SUxEUmlRR1phaTMzSFFCNkEwcjZhVitaUzZuQ1MycG1ua1RoSzRP?=
 =?utf-8?B?U2lVSk5mcnVyL2V5UGpqalh3T1FNTzFZY0lRU1RjdUxObklGek9nS0t3UEhv?=
 =?utf-8?B?eHZ4cjk5a0pYWWJWcFhOQWZyR0JFeEV2bldvY1VFNUFraUtyb0ZSUlpkaVV2?=
 =?utf-8?B?L0VTRnBtVXF1Zkc5ZFRJK0dUbUZ5REVLa3dGZUR0enNuT3F4SUpwaVJGV0dW?=
 =?utf-8?B?T3oyZmRjSTN0aGkxSFNHSEdVU2pyY1Z6T09xVUhIK1JPaldtMkhJYitsckdn?=
 =?utf-8?B?bG96OGJGckh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2N3OE5nWXJnbmlHVzZLdytTNVU2VDVxOUV0aXZqTWM2U2UrZ0hobVJKUnM1?=
 =?utf-8?B?c3J4Rnl2WEs1SlNHb0JJaGhmR0VIKzl6ZDJxVnRRMEhXMFlvTC9jTk9JZjc4?=
 =?utf-8?B?K2NMN0JhM1hJYU1NRmwzNVdvNWZWQWQ0UVA5cTJ1S1ZsRTBJSGt5VnpNMXh2?=
 =?utf-8?B?QStQbWgveE1JRzdJbk9JbVQ5VVB4VGN4RGpmZG9TY1Q4bEtGNFV2Yk9wclhX?=
 =?utf-8?B?QTlFMS9vUCswMTM3bkJwazFqUXFPVjQrcnJqL04zaW9vSDhEZEJMdDkrYjJH?=
 =?utf-8?B?ZlBVakUrcXRkZm5jNzdsbzdPeUljQWZ2OFcrQUpxRGpMMSsvSXRkQW52aW9h?=
 =?utf-8?B?WXpjVHA3RTN6dHB4RlFHaTVSQ3VJYUpXZTBjdWlMNkFsNkQ2MVQ0VU1DQXlJ?=
 =?utf-8?B?aFFIOWpLWkxuODZqZ0lzNmlGT0wyMFFsOHVMb043VWlReWVEV20yUWt4UXcz?=
 =?utf-8?B?Y0dQY0paYTdLSjlKbllxNjRreW1KSnBYY3BQWHVDYmVsOUVzRVVadG9XME1k?=
 =?utf-8?B?cjB2SmVuRGUrYURMcm01SitmV3hyMzNISmVuaFoxZFpnSzllV0VjaWRQMDJK?=
 =?utf-8?B?RTRNRExubzFCcUhad1N6MVNKVG9xVHVMWVVUWUxndEttSXo5L2ZtUzJqaWhE?=
 =?utf-8?B?T1BPb1o1dFdwcU42QnhacFJBTFVERHBkM3FId1E2cDBxTjJLTVNuVFNxQnFa?=
 =?utf-8?B?M2R6SGZsVHQyL2kwN2Z2SENqMEhOU29EcWx5R1phSzdBeWw0bVdKakJrdmRz?=
 =?utf-8?B?eGU3QVNMWUZmL2prRmxwNnhhZTdmQStIZEx0TVBkMW9PaTN1ZG5LZGd6d0Ju?=
 =?utf-8?B?WXJXUzI5ZTR0WjY4eCtRZmJwNnE2TTN3WlEwZmd2Qkh2dm9PeElZMXp5VHF4?=
 =?utf-8?B?MzV1Vkd1RjdZZWlNNTN5bXZ2anZtNDZFV2drMkhuVXFyZXdxeVNoYzNLc3NJ?=
 =?utf-8?B?c0JBekdRYXJ6c1l0L2ZTbm03SG1TaElHQWMxOUc2ams1UHpnWkFEeFZoUXgz?=
 =?utf-8?B?ekJXVUhCdWJJcTNNeHoySE84WFJ6YTI1ampFTmF6dWxzSHZ3QmlQeHNEVHlP?=
 =?utf-8?B?Q2V2Zis1ejZPczlDUFlNQTZRRjJLRWdkdHhoSUZKWUZlQy9hOUVHc1ZNNnRX?=
 =?utf-8?B?b2c0ZUlOaEthdG9oUDdSbm5lNENvSkJHVmpBamFxb080NFlxczVuT1o1cVNk?=
 =?utf-8?B?S0JhOGM2Qzk3SUJLVExXSFJOd21lNlkzdjQrQXMwUHVra2dibFNxeEJobGkx?=
 =?utf-8?B?OWdtbHh6Sm5NUDhMeWVvbjJia1IyVHJWMWZRVXE5RUk5MVN3cVA2OUxNSHhL?=
 =?utf-8?B?SFZSbkJBUHZqNTRGMEE1L1ZIbTJmcTJiaWt5NXBSRlVHSGI0M2lKK1RRNlgv?=
 =?utf-8?B?N1Erd3ZwL1pkMytlTVYzeTdhNHlkYk53dEl5K0dKVkRKY1BGWmV1NFdxU2c2?=
 =?utf-8?B?b2ZvRkN5WkNYMGZ4amFiSFIvZEFoYkRFaHdqdVdhV0RYVmhSeGxFTFJHT20y?=
 =?utf-8?B?THUrY1pEa3IvblVUeGFqTVlUWVM0TUdFZDJzeEtCemxQclFpSXdtOWh1T1V3?=
 =?utf-8?B?aktPMzdnYjcyRjVQQkErb0pTRks0dTRraDc1cGh5cE1nMjBNcU9CVGo2UlBI?=
 =?utf-8?B?RDBKUEt4ZysrMng0cFpFbVpCYjRqT1pQenVvNnF0OGM4YWFJZGsvNEZZVXZL?=
 =?utf-8?B?U2xzSk1ieFBYUzhJUE9ucCtmbUMwNWpyN3JuMnp2STA0S2l0bjhBclVIMjhH?=
 =?utf-8?B?WC9xZFF1azVWWU5TNmZmN0RML0pDbjI1bFArUFY4cEhYa0FXYi83SzJXbVY4?=
 =?utf-8?B?NWloeVpWU3RlTXRnbUp6SlhVTEthanl6d1R1ZzY0ZW9yYjFEbzErVUQ0WTc4?=
 =?utf-8?B?cFR4d3dZdDdlZ0s1QlRHMjRhbjkwZzEvbndnRzl6U1RXZ1BRaG4yc2xPbHJ2?=
 =?utf-8?B?bnNMYWhDeG56cUNnVjNDVEQ4aE5LWmRicnBMazhycVhtWU45d1NSUkw0UHA4?=
 =?utf-8?B?V0U3L0tQS1VSaWtoaXE0QmErc0l5UzZiWU5SQjNUVVEzWkVnekYzMWg0T3NE?=
 =?utf-8?B?R1dwZTc4aHFOZnpGM0tnTTJJb2FxWjNvc2FVb21oaERIemIrWDUrOENSbml0?=
 =?utf-8?Q?PVh7HDniuap/WMWuS24qMzn0I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29cd4fb-26ef-46ef-d576-08dd6010a0b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:17:48.9724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTnAKkvZDzScI4FQYEZwxrFPFDCNhbeT4opCMRvNrAzbl4wBCTphK45BtX/8LwcA+myqby72E3jXEsNrUpYPsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8261

                   Endpoint
  ┌───────────────────────────────────────────────┐
  │                             pcie-ep@5f010000  │
  │                             ┌────────────────┐│
  │                             │   Endpoint     ││
  │                             │   PCIe         ││
  │                             │   Controller   ││
  │           bus@5f000000      │                ││
  │           ┌──────────┐      │                ││
  │           │          │ Outbound Transfer     ││
  │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
  ││     │    │  Fabric  │Bus   │                ││PCI Addr
  ││ CPU ├───►│          │Addr  │                ││0xA000_0000
  ││     │CPU │          │0x8000_0000            ││
  │└─────┘Addr└──────────┘      │                ││
  │       0x7000_0000           └────────────────┘│
  └───────────────────────────────────────────────┘

Use 'ranges' property in DT to configure the iATU outbound window address.
The bus fabric generally passes the same address to the PCIe EP controller,
but some bus fabrics map the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000, Bus
fabric map it to 0x8000_0000. ATU should use bus address 0x8000_0000 as
input address and map to PCI address 0xA000_0000 (dynamic alloc and assign
from pci device driver in host side).

Previously, 'cpu_addr_fixup()' was used to handle address conversion. Now,
the device tree provides this information, preferring a common method.

bus@5f000000 {
	compatible = "simple-bus";
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

	pcie-ep@5f010000 {
		reg = <0x80000000 0x10000000>;
		reg-names ="addr_space";
		...
	};
	...
};

'ranges' in bus@5f000000 descript how address map from CPU address to bus
address.

Use `of_property_read_reg()` to obtain the bus address and set it to the
ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().

Use reg-name "addr_space" to detect parent_bus_addr_offset.

Just set parent_bus_offset, but doesn't use it, so no functional change
intended yet.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v9 to v10
- drop mani's review tag because big change.
- call help funciton dw_pcie_init_parent_bus_offset().

Change from v8 to v9
- change bus_addr_base to parent_bus_addr
- fix dw_pcie_find_index() address compare, which cause atu allocate
failure when run many time test.

Change from v7 to v8
- Add Mani's reviewedby tag
- s/convert/map in commit message
- update comments for of_property_read_reg()
- use 'use_parent_dt_ranges'

Change from v6 to v7
- none

Change from v5 to v6
- update diagram
- Add comments for of_property_read_reg()
- Remove unrelated 0x5f00_0000 in commit message

Change from v3 to v4
- change parent_bus_addr to u64 to fix 32bit build error
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230328.BTHareG1-lkp@intel.com/

Change from v2 to v3
- Add using_dtbus_info to control if use device tree bus ranges
information.
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 80ac2f9e88eb5..d69d76c150d92 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -915,6 +915,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->phys_base = res->start;
 	ep->addr_size = resource_size(res);
 
+	/*
+	 * artpec6_pcie_cpu_addr_fixup() use ep->phys_base. so call
+	 * dw_pcie_init_parent_bus_offset after init ep->phys_base.
+	 */
+	ret = dw_pcie_init_parent_bus_offset(pci, "addr_space", ep->phys_base);
+	if (ret)
+		return ret;
+
 	if (ep->ops->pre_init)
 		ep->ops->pre_init(ep);
 

-- 
2.34.1


