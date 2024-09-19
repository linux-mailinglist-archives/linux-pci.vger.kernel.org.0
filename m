Return-Path: <linux-pci+bounces-13303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7208E97CF17
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 00:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCC07B2352A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 22:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690B31B3B1A;
	Thu, 19 Sep 2024 22:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iRhSVeFj"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768421B3B07;
	Thu, 19 Sep 2024 22:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726783444; cv=fail; b=ekFI2isbR4znNpM2Ms0GjoXKVkIu48M1hXObvtsJtVXI1Q+eEqx7bvjsb7SpzPUqPSAxwlYIGA2UoknTtr89+JTGG9ugBlldQPFK6ovCMOCQ+d7MpwQk1bWn4jXDwjbaeG35A0p7ow4C6f5bvmz64r6BIhz9q6jiP9TPIDNZC5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726783444; c=relaxed/simple;
	bh=hy1TcyZt1tLkLZTBron348UchEOYxsk6tKLLRXFnOYI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mChfKOx6y5cpZ61eCmhUHvAVijmIOWwKV1xSaL0qL7eYY6szgsVeLKguxwv7gzqs0SA+voKGPeCGHB5YoZTzTCRC5lwOgkYvsWexiB4w5ldu1FNt7RNaTWbUFPAaDxdoswnUXf7+7XJdIR9c/IKMISe5jkbX2qZDRElo4RJ9LOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iRhSVeFj; arc=fail smtp.client-ip=52.101.65.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwJeMkmW6JPUuazCddIWj+mcRwAiUBaux4mPyw/2pMGFc/K/0+M/jidbl9eBy4IOhKHVA5puwdL7/3pKA+nF4Lv9hoILGXfN7CCLNDO+IDLnBaT0Bp1yvFMCB4LV+ewBOqdMTbmYMMtdOoreRpv6h+rZr1aNeviIRPLG0BphNuYikrqJM8oK47Ewl1nTJ5PelEdCCUAmCGOLCHbiTSWQ1iW0VsKEI4n6RAATc8XcklGeWTMUqUhSy/21pUO7LH/5zQma29C8sqePv/GcIr4dUaex07Qbh+O3KhXBVWERzLp1e/Mr9oYJhAmU297wcUGLGPiY2K2vDaitaZFqmi24xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cj1eQ6gvwTGJ59uGbDoxYJboZ4QoJcJ+RWrASDanqnk=;
 b=AN17CibAQGrO8kxkqgOjDRoaX5WuF9Krri4NVO1kIBS9Y0dj/CKfogeU4TQskzrx3YNajXCUuLR+jG7WCg1UcSurAHRZf/w3EWsMw/yoOuCIAt5yWywPNUpaZCnRDaDMfK3nhib9wtl6BaWF24H2qOpHX2vZ8TKwWkvT22lojOmX8LHRbLO47u3FRVd1PCvkuTyhdPHwLQmKrBBDtW1689zkGxO/mAUj5DLFtxTGAT/L1hBbCRUDOk4hf+VPX1gWNVP8C3J9+8LLEXlh/K3diIuFTUDXFm4LSpBFJH8cmycC2fMmBnEF0g8HLpIlfCrmRkyxLw+LFPTz2ZSi9W9N0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj1eQ6gvwTGJ59uGbDoxYJboZ4QoJcJ+RWrASDanqnk=;
 b=iRhSVeFjB4wpbfXtMJfUH9wJj9IdXh4fgywGu+QGJ7XPbUmy8TKWruhjtdeBVDohqobbqytWPq/3ACsrmghw91iQ/Gckc2HoKN8O9Higntbpqc8WjNZHNOVId1WTO7N0TcmhWkKGU6pGL8aIDxcqPDm7uFZMzhhbUK73Lj3lADJITMq18ow3gXLAv1GcgHpTecuWgK2hrtm/FxHTuZPgBvSfGWV/Q/0OjiLcVeLXL/yl+aX/OHpy8/RMmeN9bs8HGzonmqAKRBOj8Fjn+IRLHI1zB8HFziTE/BQ29aArDvauTveH7vYSZw3BKNe77IFSFldUJcgcjT6b7DC3bUPv1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9849.eurprd04.prod.outlook.com (2603:10a6:150:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 22:03:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 22:03:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 19 Sep 2024 18:03:04 -0400
Subject: [PATCH 4/9] dt-bindings: PCI: snps,dw-pcie-ep: 'addr_space' not
 required if 'ranges' present
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-pcie_ep_range-v1-4-b3e9d62780b7@nxp.com>
References: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
In-Reply-To: <20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726783409; l=2802;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hy1TcyZt1tLkLZTBron348UchEOYxsk6tKLLRXFnOYI=;
 b=QpYsntoNApxAlIq9QhdmcugZiRspuxU4z1FnYxH47cmaGuTKb4rsPZp3DjqBq7Awi4OciPDx4
 7Zoo1tVlItHAfE+z/pR7YCebgEoM+kZrsrNRfMgifybmbUnW/le/ZlC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9849:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1e1faf-4498-4235-6291-08dcd8f6f6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVFKcWJzTEdVWXZiek9QWkFMS1JjVVZxT2RZTTF3b3hSb3NJWnl6QUdOWndW?=
 =?utf-8?B?eUpuMHo3M2ZySzdkM2lGaU1SbjZ1U3dQZEJxVHUwbWxNYVBrQ0tNQkpIL1Vt?=
 =?utf-8?B?YVBMaXVibXA2Y1E0c2F2ZmZhSGdvRzhVbUtJbTlaR01HQUxFTjdlVHpaODBp?=
 =?utf-8?B?V1k4ZWcxdE9xTkpLeTdmTFA3WXNlQ01aWE0yOVRoMHZid0grcFhMbkJ1b0Iy?=
 =?utf-8?B?RzBaeS9XMk45S3BjWTUrRHh2K0R4Z2NyQWFXclRSSmwybVpheS9IMUI1WThT?=
 =?utf-8?B?WFNkUis1dTd2OVdSZkw0Y2hNWFMrclZOVVlzcGVsZk9mdjlpdzdiNGVoMzZn?=
 =?utf-8?B?aEN2N0drM2FXU01uZlN1dXFJK1AxWTBDSUdZbnZqOXZyalh4cUp0SkJzbXly?=
 =?utf-8?B?V1ZUWS9OT1h3S1NIc1o2aGsveTZxdHNES21qQ1NtWmY0NVFMVi9LaUlka1Fq?=
 =?utf-8?B?VXI5b0lQUzdhRWliOVNRaDZidGpsQXA1cUlINjR5bnFibUZkWXhzRmIwNzZh?=
 =?utf-8?B?TmRyVTNoOGtIVFZKeWNETjRFci9DM2xxWnZJZXg0bWIvK0VRR0ZkcEdtb3NV?=
 =?utf-8?B?bWlrL0pZcnplcUVHNC95cTdQcUNya21JSzZ3UlI1ZFFBaWRLbHNtNnl5VERQ?=
 =?utf-8?B?aXcvVjNhdUtaZkEzRk1HZkovamZHSm1TeVVUcVZiZXM3eUNyWnJNVlZ6ZnpI?=
 =?utf-8?B?OFVRblVwVGZWZ0Qyb0Z1UUxjMWpmYk1SUXk2RTlIVThsQXRhOFZuSUZYWEVO?=
 =?utf-8?B?QlNYOXREWm5CWG1Ed2RvYlVYSmxnUWt3WjlXL1FEeUkyaUE2b3dUM1ZjRWNj?=
 =?utf-8?B?c0cyVjJFTVl2M3B3bStudlZVVVo2TUprYXhVdnBhU3lXQUlOamRROEZSZ2xG?=
 =?utf-8?B?Y1NuOEx2d2pOSUdaQzR0ZVlMci9XcXduVjBKUnBqM1BGbDNHU1lIb2NWSGpS?=
 =?utf-8?B?dVFFSXFSNDZHZjRXaWdLWEJpNmJEV3dhdkhucHRiQm5BQ2lkRmx6Ylg5bGE3?=
 =?utf-8?B?RUc1YVBMcnFSZk9DV1dsL0d4ZEpBVHRWWENJbkZMdWFtUFlHV1pORnUvbjkz?=
 =?utf-8?B?MnRDenZ2bVVuNk9sTGpxSm1iaTM2OVp5MnZSb3JybFJPZUJxc0ZjT3o0dEZm?=
 =?utf-8?B?VENQSEwwOGU5S0hsOHBDTERoVHpPczVyL2d3aUVxOGJtbnhTSEkvSHBtQ3lF?=
 =?utf-8?B?eGs2b2JQSjBGYlFKTm9KMjQzTkxhVFpabVJON3RNQXZodDc5ZmprTlpYdDZH?=
 =?utf-8?B?MWlqVkl6VnlyYnp1RlQ3YVBoWFcwanlQVEJOZ2NEOFBDb3dGaTBIMVBDeWJQ?=
 =?utf-8?B?Y052WW5OVU02R09HS3VtRE1xcnlWZm1LSkRUbkNmZTU0cWFna3pkdnN4cDNr?=
 =?utf-8?B?WGt4aU55U0VEeEhIWS9HZ2luRDFIVk55OFZ2aks3Y0ZKcUF3eXFuL0c5YUla?=
 =?utf-8?B?RWJhcVJ1K0Q5N1I3ZDRCWElSWGVhVEFreExFelJxMGs2Q1VBamQrRmFlVXo2?=
 =?utf-8?B?TUgxaVZlb0VQN1pPUWtFbDRDZUY4TktNUnJnUVZCUVc1Q0hBb2trSE1pTFdn?=
 =?utf-8?B?bHJBTVVPL3dKVTBqM2pMZjM5N2puWWEzZ1c2TzZaVTJzZGc5YnRvTlNFTC90?=
 =?utf-8?B?VFZvTEhVZWdtaUpLMXlSNUVKbVBoT2NtWGMyckhMSUk4SnVKREgweUY4aVFX?=
 =?utf-8?B?RjE4c1FGaW5hR1VoK3krTVA3M1ZXL1lSeGhhRUphYStUSWQwbVNNM2tKdzhj?=
 =?utf-8?B?eWlVMjY1blQ4SGRFWUhtNnlMeFFGLzFpVGphM2JBZ1g2TkFOd1UvKzJaSHR1?=
 =?utf-8?B?V041Y2Nsb3cwM2VDNE1qRHVtcUNJTXhYVG41Rm83QU95SVJNTnh1dDhSUURq?=
 =?utf-8?B?bFMzVkRka1J2S0tHNkV2UDRVRzRVZ3hzNFFWa2RqeG1id1kwRWhlWDZSZUZB?=
 =?utf-8?Q?D3ua0Tkb+CI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTYzNkRDUWQrWXE5clo4WHdOU2VicldERU8yd2JjaXpVZTdrVmdMaHpjRG5w?=
 =?utf-8?B?VDNWeVpuUkJTdUNXUFRQUVU0N1JpdUMxOTlMMGpnTGM1UWcyS21WeTRlVDBS?=
 =?utf-8?B?dVJENkc0bDJWMVpJSlAyTWswSkZUMW1NWGdPWm1CWjloZzdwRFBiRFZld3FX?=
 =?utf-8?B?WTR5SXRkN1EycVNaVFBkbmhFYytsdnBsSzVGSUVJOFJMaVNraVR2VVE5Y05B?=
 =?utf-8?B?YlBYWUxWK3pZL3F2SktmQ1pwZU9sZVhqR2s3NjlTMlhwdWk1ZW1uN3liS0xm?=
 =?utf-8?B?K3BXWGcrUTBaQkN5aW10U21TUWMvR0NWU0dPVm0wY3h2cXFBaHZFdHRqelN2?=
 =?utf-8?B?NVllTXpoeGJXTFVUN2NRMjNlWWovRjJiSjJTSVNCYXc0Y0JKS1VlR21XWXFv?=
 =?utf-8?B?anVzZXdPRDhKaHo1bmNtNmlzTTlZbzJya1I1UE9zSUg2SDZZUFhFdm9jTFBG?=
 =?utf-8?B?NG4zMS9GOHNud0czL1pZeG9ocDFWVkJyVmMyRWcxMDRzUlBWRmNBL1ZTWGo2?=
 =?utf-8?B?ZVdvQTQxVXRQajFiNHV1a2tlNDNoKzZTWDNZSEtrV1VJZHUzRFFSMk9vR1hs?=
 =?utf-8?B?dGVqeXNPcUYxVU4yK3IwUUJQS2xYSFJrdUVNTGFmVGpPekNXQVBGbHdjNndK?=
 =?utf-8?B?SCtIU2hrUXM0WXlPMGY1YURTMWVXMzk1OTQ0OHhYMnNCZmpyUVlSWGVzdXR0?=
 =?utf-8?B?SEh2RnpUTUY5WUFFWTZpZktYOXR3bkxmWHExbDRRcWtpb2plMnR1b1dSaXVG?=
 =?utf-8?B?WklkVk1YVHlacUFHSXhRaHAvRkFFeGh4TmQyS3NpVjZaNmdoZTRBUm51dnJW?=
 =?utf-8?B?aWZ3SkNDam5QN0U5V0R6ZkV6dnJ2NjQzdnk2dFpNUlZZa3RNVWFGQ3JIV3BC?=
 =?utf-8?B?TDNIRzhLdGREMWtIcTg3YW02S3BjaVMwcXZiVXArcERpVEhRQ29OOG5EcHN3?=
 =?utf-8?B?b0xKYVhkNUFaUGp0eEpTeXpTSlE1c0JoUUJJRkNlcnN2N0trMFpwWVladkNn?=
 =?utf-8?B?NGoxN01NRWdlaEYyMmVnYWU5VDl2R1EzNFRuMmpkVEpBMU9jWWpyQVp5K2JF?=
 =?utf-8?B?dy9yMzJJYm5UQjVBN2h3YWtjSlljNlYzbDFQTTUyZ0JPRGtTdk9qZ1FhT1Ax?=
 =?utf-8?B?ZXVudFdaOFk1WTlvdjZvYmNzbitxdnBycjF1MmYvYlEvY1JGUXJLenlmNWM3?=
 =?utf-8?B?Y3ZXUEZCREc4RFVZYU9OMDVNeHVqZjFjNkRsY0I4cUxuTUVpa3RRUUp5SEpS?=
 =?utf-8?B?NEtSaWxzNzMyalllUllnZi9FQlIvWE5QUm82NktCYUNQRTR5L2EwWEs1K1BM?=
 =?utf-8?B?U0hDTEhMM3F1cmhua2dhVnRzNCsxamdpeDFQNXZGTW1aT1ZCdzJPdFltR2cx?=
 =?utf-8?B?QmRYdGR2RitKdyt0aVBMUFVKdk1Vb3lFMTZBelR2ZHFhd1ZYY0wrcnQ4WEUv?=
 =?utf-8?B?RGovYWpOWUNUeEszVTJKRTZLdTdueWVDc0tjQzlpcXRNK0tSU3pSQzl3MUhY?=
 =?utf-8?B?SklyRUY1V0U4WUZWb2hPNnhJWUtva0pxMXB0V1JQOFIzU0tyYmkwQzlNZDF6?=
 =?utf-8?B?WWxsTmp5NUZkcm5KQVM4emNNR0drMkZiUzYySkhGQlg5SGNSNUttS1g5UGRj?=
 =?utf-8?B?aCtEZitmUVdPckFtc0RrK3VMMlVtYTVQK2Z4aDRONTlWaXJpdFBxTDd4bVVX?=
 =?utf-8?B?bUtWRGdnTFhseFZxNGJSdTJXa2FJVE5oc2xLWHllOVozbUo5bDJXRm1EVnIv?=
 =?utf-8?B?QXIvM1hYQk1BZHZlcWpNbmV3L2Z2Ym5ZeWZUSExqMU1zU3JUNFVTdVNhQnpF?=
 =?utf-8?B?N0plMG96bHFsY1J3RFAxclFNaGwxaUJydDd4b3pqcXNDS0dlZWkxankveFlo?=
 =?utf-8?B?ZHFhak9oakZoelJKTTBkMENYMWhQMjQvNXJ4emYzMFg5SGdWNE0ycDkxRStt?=
 =?utf-8?B?eTk0TUlzNVpNOEprMzZONXRTaEVoaTQwbVdZZjIwTTN0QkIwVENLbWxyZVBU?=
 =?utf-8?B?N3huUkJYMFdoV25YT1lPZUxiSy84djJ3REhVdHB4cnpzNnM1M254Mm5LKzV3?=
 =?utf-8?B?Z0dCRFg4Y2ZMRXZoaDhLQUlxK1VsYS9ld0hGSDdtZFdOUHkxSEVyVW1kYit6?=
 =?utf-8?Q?AjPSnl46uNPbvqQLek3gKWQHs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1e1faf-4498-4235-6291-08dcd8f6f6d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 22:03:59.5410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHv4fiNAGzb6U45SjkuOcDRy/JYj4TTRVtmZP9jPolbhNXJ3jFVnJr26sAIbLr1Thc8bR4uPKmMbnCgWZTsdOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9849

Do not require 'addr_space' in 'reg-names' when the device uses the
'ranges' property to indicate the outbound address space. This maintains
the same restriction for cases where 'ranges' is absent.

minItems of 'reg' and 'reg-names' change to 1 because only one 'dbi'
register space is required if use 'ranges' describe outbound memory space.

minItems of 'reg' and 'reg-names' in snps,dw-pcie-common.yaml also change
to 1 from 2. It doesn't loss restriction because it is 2 in
snps,dw-pcie.yaml.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/pci/snps,dw-pcie-common.yaml           |  4 ++--
 .../devicetree/bindings/pci/snps,dw-pcie-ep.yaml    | 21 +++++++++++++++++----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index dc05761c5cf93..16d5fe77d117a 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -32,11 +32,11 @@ properties:
       is selected. Note the PCIe CFG-space, PL and Shadow registers are
       specific for each activated function, while the rest of the sub-spaces
       are common for all of them (if there are more than one).
-    minItems: 2
+    minItems: 1
     maxItems: 7
 
   reg-names:
-    minItems: 2
+    minItems: 1
     maxItems: 7
 
   interrupts:
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
index f474b9e3fc7e2..184c519d2b7c6 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
@@ -25,18 +25,33 @@ select:
 allOf:
   - $ref: /schemas/pci/pci-ep.yaml#
   - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
+  - if:
+      not:
+        required:
+          - ranges
+    then:
+      properties:
+        reg:
+          minItems: 2
+        reg-names:
+          minItems: 2
+          allOf:
+            - contains:
+                const: addr_space
 
 properties:
+  ranges: true
+
   reg:
     description:
       DBI, DBI2 reg-spaces and outbound memory window are required for the
       normal controller functioning. iATU memory IO region is also required
       if the space is unrolled (IP-core version >= 4.80a).
-    minItems: 2
+    minItems: 1
     maxItems: 7
 
   reg-names:
-    minItems: 2
+    minItems: 1
     maxItems: 7
     items:
       oneOf:
@@ -106,8 +121,6 @@ properties:
     allOf:
       - contains:
           const: dbi
-      - contains:
-          const: addr_space
 
   interrupts:
     description:

-- 
2.34.1


