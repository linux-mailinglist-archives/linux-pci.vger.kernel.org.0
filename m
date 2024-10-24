Return-Path: <linux-pci+bounces-15242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5099AF3DB
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 22:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D14282C4C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 20:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE15D22B67B;
	Thu, 24 Oct 2024 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Aw4USNMB"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA3217302;
	Thu, 24 Oct 2024 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802542; cv=fail; b=JmYgw8tC18u0an8m9usVcGoKiB4jpRBATQYW6kyX1nEFEF67mCmbn04cI6QG/DEHCOsiGjgnc1XBwYuOkcfuQDx42AHoky+uxzGotTe7CIHy3yycICXsP+vjnspJHSub+lKGgF+QOuC6d6y8C/n2js6MH8/nM3aLsmBCbepdofA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802542; c=relaxed/simple;
	bh=GsBrY/rr2TGV9C/ufXVpAjG8EooxUe4YBDJ9aZkc+U8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Wpb/SloybnvEkzkhvSj06vv6ss/qfEBE7WPSToZXMs81IYr+Vqdoo0CD+djp8kS32BzFESSlXCxloa4qUXFSoaQqiuWtulaRAfT6FzyDVQWdbwG2OTG/2rBVtyAqqnQciVZt/sbOnJ16u/vpmq19bUb44Pkg7jkisTsiXUjEwfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Aw4USNMB; arc=fail smtp.client-ip=40.107.105.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xExKwUHTn6oZsXwRvMdoP5g6tFY3lG3X7l0RcW/z1UD2lC7dG1lvPl28BEEKtau64lquy2Igx+hHPzkq7k3eUPiqGy2hp+Z0RornioV5Rufcu6FVyBRFhkE31MbpbNFTtxahvUX7eLWb8TBgZi+v2s1+datJ5VdlxXvD4u/YBHVt3/rAWRETR6u4HYqwktaLNXsEFRc97bkwUoGE+boLbhy0QNZ4lB2JEZRP2sx5R+wzaMD6oRdxSFF5Hv8HJO8J47HjJxciz2tLiV9VUx8i5kNKyEhB0zapMwCYoPWd5u2g7TEBBHkqVMP1nUjr07LDw1X+drqmaudPMV+xDr4RkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZEqB5SgGYv/wLtHKqtrS28/MuvXtIH7arWnGnAkSxQ=;
 b=TMpLZgd4wqcziKR01Gnb01GGQHPnCkDE2eYon8t2+9/C//29d7UEjLtEpmvGb80Jm+XsbCTDb0drI4A27g5AMMIT9aEsfv/OphxEKhm+g3ocrBRn8ghVPNNG+68ECWogiAOR2sxI467qi2D8/nbdtcqTAJm61K1Ap5b9vEPCGs2OIfzzMWcm1jYGhymmz1Esuas6dJX4nh8LLwoV1na+WFSR5Gzgx76eD7LzbZnF/5ehXyOLDNLcOm2jZcBYcQzLERWGoIdLNOOso5YH+t/yDXMPZMqK7PvyyWEf5tL+IbQfoJXe4cF8FsVglIKLeGh9c+RsNkLhSBlMjpqgxGZITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZEqB5SgGYv/wLtHKqtrS28/MuvXtIH7arWnGnAkSxQ=;
 b=Aw4USNMB7TKUDptBJ8By0tAsio2H54K6A2agLXSKMjAjnLezJpjfJ9VAScAZtoyayt7c0K7n/LqonB8RFHmbEdftHUbDTJ7QIHiPxnepuOPXmM+qlQXKnzIEa5yc6wDuieu+QMF24ACtbNAoXy5bdZvUN4eQXqHgQzZHzuyGNj8Heh5q5cSIalIPUq0XC9N9lgw0gMsw9ZwDiD7/DX3wg++z7onJKQ63dVoMKdpiXwar1B14gHAYwn1pLjGiPxmkSbGMDhOyUd5QLn3tpI6yLdCNiWwMd5qEhCs9fJGKFn55whcAImSGM/hsZ1Sv/tbzqr3ln+bB7zMCI2Mk+2wBdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 24 Oct
 2024 20:42:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Thu, 24 Oct 2024
 20:42:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 24 Oct 2024 16:41:43 -0400
Subject: [PATCH v4 1/4] PCI: dwc: ep: Add bus_addr_base for outbound window
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241024-pcie_ep_range-v4-1-08f8dcd4e481@nxp.com>
References: <20241024-pcie_ep_range-v4-0-08f8dcd4e481@nxp.com>
In-Reply-To: <20241024-pcie_ep_range-v4-0-08f8dcd4e481@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729802524; l=6280;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GsBrY/rr2TGV9C/ufXVpAjG8EooxUe4YBDJ9aZkc+U8=;
 b=ovwh5BoEazxQSkess/heM2mtUzNAlTzZAc/9uH+fSvCv/SPD5JyAPhMC9HLfFwlBinBisJRMO
 x1V7/EzLQxnDDtthTziKY2Fyl95BKt58z/edAtVscRq+yEPYD8VG2Th
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 5808ea38-83a8-4067-8006-08dcf46c5926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a05YR2xwYnlwYXNqQ3BydUZYL0RrNFJOdmZjR3RZWUZ2SjFLM3FqcmUvRWVz?=
 =?utf-8?B?NTZBb0F1RDRtZGc4ZFRFUkd0TUJ0N0h0alAzZmk5NSt2THBIRUcwcDBLblJv?=
 =?utf-8?B?Q1hIc0lueHJ3QVFHbVhVbmJKY2Z2ejlEaTdKK0pxN0hyanFZTTR0TVZ3Q29u?=
 =?utf-8?B?NFhHd0tHWGZGUHpTQzZ5WjloS0x3d1Z6UkxyYzVFRGVhbzlBQkgrcVFkMFh4?=
 =?utf-8?B?RnNIdkRxOFZkWW1qMDRPWHlad0NmczVLVFFpd1AvYmxXSFZCNWlCZUNFaWpT?=
 =?utf-8?B?Mjk2dzdOamRETmlQWUNVS2FIVXA4Uy9zKzJwN0Jsa1dEZC9GdEV5cnNMU2pD?=
 =?utf-8?B?Z1pOQkJiMjlpTlEreEZ3VzdKc0U1UTlRNW52b2ZxcFlKcFY4MXBtQWp0a2pn?=
 =?utf-8?B?Z20va0pSTE10dmJ3SEFUSVdBOVNkZm1PMFNHS1FmM3FlSjgvaVpDMTR4cmEv?=
 =?utf-8?B?OUdzdkpVbVo3cmZ1V3VwU2dYMTNFeVV3RGkwd1VycXdVUVNKd2Zhd25yWjFl?=
 =?utf-8?B?cjNxVi95ZytFcTFqRDVSTkRrKzErZjc0Yzk1eitzbzZXUHJSMDE3VnExbTJv?=
 =?utf-8?B?WGF3WC93dXVEem1tSUZJUUkzSEpzOTJVNGtveFdCQjV2c2RIQjVWSjAzczdB?=
 =?utf-8?B?RkdiZkNoWDlMb2N3SjRVcHlKNk56NEMxTytRYTQ0L2xyVnlRMWpqd09EYUF0?=
 =?utf-8?B?YldQSjIzbldNMUNSeHFoWDhxS01LYld1WnNUM2lIT3dDeFhDQ0ZVcDhqaUFX?=
 =?utf-8?B?ek9qUGpxVUhHZVhjM2xyMDJ0ejdFS25RU3ErMDBxQllYeFRrRlJmbGFlL0xy?=
 =?utf-8?B?WHBXak9mQ1VvOFdwWStoWGFRd0IrVUgxMTJlN1ZwNTBFSnByZCttL0h0NCtM?=
 =?utf-8?B?L0E3d1FvbGdEdUU2dTVRTjRhNC9MY3NHNmwyWEd5bzVScS90S3lvaHJBVkVi?=
 =?utf-8?B?OGN0b3JsT29WdU5SUWVuVWNaaTUyMUxUSVZZL3oxU05xb0N6QkxLamFWWkRp?=
 =?utf-8?B?ZVpBOWZPSE1oU2NmWWRCaFYxTnVuQm9aWkd3RVNoOGNXY2F1MkQycUJWd0Fp?=
 =?utf-8?B?R0xjdE1RK2tDQ2hOUmNhWGo3OGZ0bVEyQTk4S1lHWlIxeEVMSEJjRnRQOVJL?=
 =?utf-8?B?S1JCSTNtVk9VWHZIbzlsZVlGdmluM05SWmM0aDZ6Y1FBSlFhRGJ2YStkVURs?=
 =?utf-8?B?YzU0TTV1ZnBWK3hjVXUxTitDSGxQVEorRlNXemZZQ2VpM3k3dUw1SUc1blhh?=
 =?utf-8?B?R3RvTnA1UCszUmJLNXJrMlB3WXA1Mjdka2dvZnovTGR5UEZUcG5Iem9saG5z?=
 =?utf-8?B?NlJIN3BkOEVPRTFtRGxzS29PekhXQlI1M1YyVFkycG10TGphcjFUR3FmK0Vs?=
 =?utf-8?B?RkQzS2dxSWx3N3BWTWJDR1RYZHJaWGMzWm1IcTdpNU9HSWtFcExGT0o4RkdC?=
 =?utf-8?B?bHlrbDdMMG9iQ1FnVkZRTVNnNkJpSTNhNXJiYzhsaXNIQXRTajVaOGl2cXht?=
 =?utf-8?B?RklWTmRHdUwrclJyZUg2WWV5MzlyTmFHeWlxTWFsM0ZGQmFRSEtvL2wzN0h4?=
 =?utf-8?B?bndlNHplV2RyU2F3RUlLbitkcGszSWpRcTYyek1URG0zZFVRRDBRSFVrdDMz?=
 =?utf-8?B?a2RscEQrK0pVV2tiN2loemNvWlRjK3kwb085UVZBcGlkRmMyRUtLVDcwM2ZJ?=
 =?utf-8?B?VkkxUzZac2VScElaOWt4cGxrVVFhR2pnYzh3UTJ1ZTZBTWNpS3RYOTI5VzI3?=
 =?utf-8?B?VHFpblJ2QjZrWGJ3aUh3VEZqTFh6K1hqTWMxblNselpDTE51clQyNWx0elkz?=
 =?utf-8?B?U3FraFVaaTRiZVYvUk1EdzRjRldNM0Ixd1pBaVZrRFRaS2srVUtiVUtCMWN4?=
 =?utf-8?B?L1JjMnI0MkdaS2FKd1JhQlNUNFNIL0NTYis1Tk9pWkk4WGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak02T29LcldxVG1waTF4QTJLYU43a1BHaVd0dnBDeFBtcXVaSXhpV3BWRkJt?=
 =?utf-8?B?YjN1NkFkLzlEeEV3L1FCd0dmaTVIa3llYU1pZDcxMjRJR3BkcnJjeEFwNnRZ?=
 =?utf-8?B?UGtaUmcwMllLZFpEdnhwVUJjMkxJNGUxdnlwaUNERzMrZE52MFVaMW9BRmZM?=
 =?utf-8?B?VmlsRUFMRFJDWkRna2FnREdDMnVWTVF5M2ZFdGZlWjlTWUdKVWFQSnllVEhJ?=
 =?utf-8?B?dS8xMHkwOVNmdlFrWkd5TkZHTE5SUjBURXlDZG53WWtHekd6WmtiR2RrU1lQ?=
 =?utf-8?B?YlV6NkIrTE5JeXZRa0lQdFI3UENFN1kySUlTYllocThZOGJ0YU5NU2RueE1B?=
 =?utf-8?B?WUFhTTVYbWhDOFdrVGhnNmVoYlZ1Y0dJQm96emhYS2ljMVJmYnJzdUxqTUVt?=
 =?utf-8?B?d1EyYUV3Z0tDb3pjOVBWdEJFQk1lV3pUREdHWHRSa3Rvdy94VDhiZktEZHlt?=
 =?utf-8?B?YU00MmcwcjFLZWgyUXBYcVl6Y01VUEt5S3VyNDdIQ1RWUndjYW9JUUpuVkpI?=
 =?utf-8?B?a3pHczRJdEh5M2pMT2QzWm5CUWRJQW50YUltRFdmblJTZVJscG9QdU5pTURV?=
 =?utf-8?B?QUt4MHBNcjJhWEdwMVFsb0NsaWNiUlM0cFkwQm1ZeFVzMGRKV3EwMlozaWIz?=
 =?utf-8?B?MVFaTEZBaHVmc09rRkVMVVVUNzA3YXVrT1JOcVdKNWNLMXA3UGtCRm41ZTNn?=
 =?utf-8?B?OEJJY0l0RTdXckViMkhXUUtNRVpVc1FBMXBqT29qOStDOFJWNXhpc3JzZkdY?=
 =?utf-8?B?Q3F4UFNiQXNPQlJ2R1BUbXdjYW5DclFDQkNRclpvd25XRzQ5cU8vRDJTS3l2?=
 =?utf-8?B?VG14UE9JWXlkS1R5N2FaRHlFRHpGMndFRE9GOWtMOURIcGZpc3BrTXdCU1dz?=
 =?utf-8?B?U1RIS1AvWWhYRkRyeVIzRjhwaGRpY2UxU2Jhc0RFVldCeDJYUnkyY1QyN2pm?=
 =?utf-8?B?enlBakFBbmErMGw2bU5zU2ZXaEhzUStWMUtQT2ZXTXFWeXBxZ3N4UWRuaWVI?=
 =?utf-8?B?QjRDUEVrZ216UkFMOVh0ZzZ5ZzNMbHlLVVVHbVl1WG16THNWZlFZSWZhS2ZB?=
 =?utf-8?B?L1dxQUJ1aVNKTk5nQXdIOU9wVkV5T3dqb05idkpHeVc3cHZpN0lpQzducFI4?=
 =?utf-8?B?ZzFxUTQ0bjJlZzROamxUUDg3R3htbVA0QzYzOVZQZ2hDeS8rV1NSQVpzYjlH?=
 =?utf-8?B?ejA3S3JzRFM5RUlyUDN3U2xHRTVhL0FoNzVIZ2hsTm9VRUhGSGpEaEtyVGVZ?=
 =?utf-8?B?NVBpd3NlRGpOdi9ocjcwMHBxcW5UbDRFOXNLT1lVVHM3bXBaeXVERVZqeEVP?=
 =?utf-8?B?VXlibERlRUpRRW04NmlVQUhteHpLQThPRCthRit3NUdhUzFhK1JDSnZXWCtC?=
 =?utf-8?B?UFpzMWg0SXRjRk1XVUJWMC9YUnhFd09mQWRaYW5nelBuM0Z0VXZGUytNNHVQ?=
 =?utf-8?B?cTRRZDkvNnNYWVZibXVoNFFEWTZ1Ni9hdERJcDhRUzVsZGFTaSswUDRkZW44?=
 =?utf-8?B?ZDNENk8yUXh5OWxDYjlqdkcrNVprc3h4Zi9lWktPZm5Yc1ZjV2Q3RGpLTE5q?=
 =?utf-8?B?WTlONytjalVhNWNnYStaNVBtVktpUHV2N3FreGliTkErU2x6VTdCQ2VVU0dL?=
 =?utf-8?B?QUhnSFM5STJtb25jekhlYVVCZUVGREtTS0wreGQvdlNoUEJlMUsvOEd4SHVj?=
 =?utf-8?B?MUplMTUyY2JBNCt1UndXeWJHUlZXUUZNQlFPZmhxc29CVHJ0Yi9tSlBvV1lq?=
 =?utf-8?B?K0NUamFNTTgydkNDODRnMTR0L0xxbE5FbCtCSnF5eTJkK1VoUG5ja05Fd3Jw?=
 =?utf-8?B?ZTFybG5GVjFsRjdCRk16UE9EaHEyWHlDMjZsMVhvR1VweW9mMEgxYTB3eVVM?=
 =?utf-8?B?RGc3Sm13dFh5S0JFWU94eWNQWGxueGFCdk41VFdkZHBRSVArSXdMK0lHNXJh?=
 =?utf-8?B?dVJqNEtVZFlLYUJGVDZpVkI1cWJZVThQRFpCS2EzTENnRlVENHNkUkY1WjN6?=
 =?utf-8?B?cWVFNTZXNnhRaXkwdXBtRGpuK0lMUlo3WEhzaG5BUDNCS1hLMlVkc0lIUmdo?=
 =?utf-8?B?TzBaUVRmQjZBY0l0N04vZnVJZHZBWU92UWRwdnlTWVBFUDR6VFRWRzdFbHNa?=
 =?utf-8?Q?alb4qUMy+NEN5mnv9f7aZJ3uu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5808ea38-83a8-4067-8006-08dcf46c5926
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 20:42:16.9954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4CFhmwQgPjtm6HpIfBMFVCgSlvykrxv4LHTMEEAdLn8tfbUbWos+eB9Ke+vFrYo9qW1fu7CmdWbZE7O9NJlAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517

                               Endpoint          Root complex
                             ┌───────┐        ┌─────────┐
               ┌─────┐       │ EP    │        │         │      ┌─────┐
               │     │       │ Ctrl  │        │         │      │ CPU │
               │ DDR │       │       │        │ ┌────┐  │      └──┬──┘
               │     │◄──────┼─ATU ◄─┼────────┼─┤BarN│◄─┼─────────┘
               │     │       │       │        │ └────┘  │ Outbound Transfer
               └─────┘       │       │        │         │
                             │       │        │         │
                             │       │        │         │
                             │       │        │         │ Inbound Transfer
                             │       │        │         │      ┌──▼──┐
              ┌───────┐      │       │        │ ┌───────┼─────►│DDR  │
              │       │ outbound Transfer*    │ │       │      └─────┘
   ┌─────┐    │ Bus   ┼─────►│ ATU  ─┬────────┼─┘       │
   │     │    │ Fabric│Bus   │       │ PCI Addr         │
   │ CPU ├───►│       │Addr  │       │ 0xA000_0000      │
   │     │CPU │       │0x8000_0000   │        │         │
   └─────┘Addr└───────┘      │       │        │         │
          0x7000_0000        └───────┘        └─────────┘

Add `bus_addr_base` to configure the outbound window address for CPU write.
The bus fabric generally passes the same address to the PCIe EP controller,
but some bus fabrics convert the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000,
Bus fabric convert it to 0x8000_0000. ATU should use bus address
0x8000_0000 as input address and convert to PCI address 0xA000_0000.

Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
the device tree provides this information, preferring a common method.

bus@5f000000 {
	compatible = "simple-bus";
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

	pcie-ep@5f010000 {
		reg = <0x5f010000 0x00010000>,
		      <0x80000000 0x10000000>;
		reg-names = "dbi", "addr_space";
		...
	};
	...
};

'ranges' in bus@5f000000 descript how address convert from CPU address
to bus address.

Use `of_property_read_reg()` to obtain the bus address and set it to the
ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().

Add 'using_dtbus_info' to indicate device tree reflect correctly bus
address translation in case break compatibility.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- change bus_addr_base to u64 to fix 32bit build error
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230328.BTHareG1-lkp@intel.com/

Change from v2 to v3
- Add using_dtbus_info to control if use device tree bus ranges
information.
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 14 +++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h    |  9 +++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 43ba5c6738df1..81b4057befa62 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -9,6 +9,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include "pcie-designware.h"
@@ -294,7 +295,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	atu.func_no = func_no;
 	atu.type = PCIE_ATU_TYPE_MEM;
-	atu.cpu_addr = addr;
+	atu.cpu_addr = addr - ep->phys_base + ep->bus_addr_base;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
 	ret = dw_pcie_ep_outbound_atu(ep, &atu);
@@ -861,6 +862,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
+	int index;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -873,6 +875,16 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -EINVAL;
 
 	ep->phys_base = res->start;
+	ep->bus_addr_base = ep->phys_base;
+
+	if (pci->using_dtbus_info) {
+		index = of_property_match_string(np, "reg-names", "addr_space");
+		if (index < 0)
+			return -EINVAL;
+
+		of_property_read_reg(np, index, &ep->bus_addr_base, NULL);
+	}
+
 	ep->addr_size = resource_size(res);
 
 	if (ep->ops->pre_init)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35aa..f10b533b04f77 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -410,6 +410,7 @@ struct dw_pcie_ep {
 	struct list_head	func_list;
 	const struct dw_pcie_ep_ops *ops;
 	phys_addr_t		phys_base;
+	u64			bus_addr_base;
 	size_t			addr_size;
 	size_t			page_size;
 	u8			bar_to_atu[PCI_STD_NUM_BARS];
@@ -463,6 +464,14 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	/*
+	 * Use device tree 'ranges' property of bus node instead using
+	 * cpu_addr_fixup(). Some old platform dts 'ranges' in bus node may not
+	 * reflect real hardware's behavior. In case break these platform back
+	 * compatibility, add below flags. Set it true if dts already correct
+	 * indicate bus fabric address convert.
+	 */
+	bool			using_dtbus_info;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)

-- 
2.34.1


