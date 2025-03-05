Return-Path: <linux-pci+bounces-22985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F80A50479
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 17:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C473A495E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060FB1991DB;
	Wed,  5 Mar 2025 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F4kSvBA9"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612319883C;
	Wed,  5 Mar 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191650; cv=fail; b=QU81n53W7o3Z2i1EqBl4+pdyGZzvGa/dQ6dsOF+rTzCsw/lWvxTbdwuQiIo8skSjFpja3cJrmaNrPwOU0/elQrhKN5cPYBvkR/Gps90Bvmlue7wlUfjIO+uHQFkEMdl5FbWQjqVNezEn74FlFlXWpLKrwh0NHkcVoz5Xp6vl7ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191650; c=relaxed/simple;
	bh=3QIzc8WTNujMOXv5K1kYaiq4ezn8ZEepEvWT7U3Cc70=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ls32xxZcNHIlEae/X1EzJf363RzhufH/cEnESEIWTP2y+S0oY391pbKCRyssZy2dKDP7WjO51Psd4lPUEjzMwwbMrk+8aAk1uKJBo/QOMon5ubinWz7RqdwDaRiBE/rcVGmLbS0m8E96pzBz6mm4OfImXog/GaF2kqjjKkSm7ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F4kSvBA9; arc=fail smtp.client-ip=52.101.70.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SruyA2E7UDkP43w4VrQzQzpyFdv8lnSj4Xmh/ipYNojgKrMekPViNWVvn2d4X6O6nGW3XyM8PJoYorxqlEhxDT7AdlIjLRgjRMOA07Jgo6AY7PY0lSw4pTQbe0S2JbUqst+dzwzOvwyNGPYkP7LI8BC/CczAJEuWKsj/ReulebCsx5JafcTPu4i/7nodKjxy6Slb0wp6CNBRgO6iM+jhMmVsCx/K63zmiKrFVbQnJeMQ3hupNqxZ1Nq7GO9EyipRuNupuw8cU7MBsXGrk2xVOuK3HIEa10sScxe04fgJqLqPiwBs9Tj7ncSVN/PvFTeqR3M9yZGlJ/s4w7aRiOYOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfT/Q/5DdN/YXK8m/U1ThkSwFdsp/fnT2K3YASq2D8U=;
 b=PY8xj4B4oeFJPADTzWeu7y2Wg8eNEMWEd7uJH6I3rRx5xBj05BC+sFvucxlyTVSo8a6FJpUqq7h1ONtFNxvl82g1n2BHEpcuBlLD4bnioekgiLD0BA04Okw90Ge0lpeeFaMWlIfgeqt57P3HV0BUxS21+DiH9INuTHsOfxDpO5+8KTXE/u4Du24GFj2MAn03VHAl7WNvGA+OnLTd3lk7PkcaGTU4T8zBDleRh4/jzE6PGBmBoHBIlqpNLm1X8PlhzYlpfYSZX4EhJ84BUhgg/vTGcj3ZXxrHE7AoOh+iIOrGOjgGra681wwqN2HFhtBKwRXASeAoIoUK62GL+3jKYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfT/Q/5DdN/YXK8m/U1ThkSwFdsp/fnT2K3YASq2D8U=;
 b=F4kSvBA9gfo/V7dCST0Ojn/nqLD6SrOinSxkvjVc1TenOU+d9pC1ouwanrXnfuRLQrvkmFDGS+dDbT7bd7fUdhV2Vw8+fPOIxK5QjntKvQhC4qu96OrrPw3tmT/osvweR2OhHYsctCM7pBmtkLF8iq1udkXT80AQC7YInG45f8e2kKA1eObXg7wUyHaOj/SCvt8qkCWEHl87/MxmpGxZ6eFOTui8m+iYGIfgN50zE6qi+KiuFnCvImDA7WZkvsHPsFTDobUlrI0j3C7FtkF2AglM5IhxfzBmURFLApjLXSyjtuNLEMoyNuPI/XBFM1yswFT0ScC8P0inVkmkuhn43Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DUZPR04MB10039.eurprd04.prod.outlook.com (2603:10a6:10:4d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 16:20:46 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 16:20:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 05 Mar 2025 11:20:22 -0500
Subject: [PATCH PATCH RFC NOT TESTED 1/2] ARM: dts: ti: dra7: Correct
 ranges for PCIe and parent bus nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250305-dra-v1-1-8dc6d9a0e1c0@nxp.com>
References: <20250305-dra-v1-0-8dc6d9a0e1c0@nxp.com>
In-Reply-To: <20250305-dra-v1-0-8dc6d9a0e1c0@nxp.com>
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741191638; l=3360;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3QIzc8WTNujMOXv5K1kYaiq4ezn8ZEepEvWT7U3Cc70=;
 b=cPtESDjyV2SR//RApO4tblNVPsYp4T+gUmuKLsS3/lMgRNhOc+0vP2FQa/xl5p1MS7xFQ/507
 BwNgIcQl4vkDrclq/KcNcJGqzYRqJlDD65FdIybmgUgTHhj92l/K2xC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0153.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::8) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DUZPR04MB10039:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c0614c-d9aa-4db0-e75e-08dd5c01af7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1hlUllRak9UKzAySitoUzJOMVVDR2h4ZHJFeXpJaHVxcWdEZnB1VVVYY1I2?=
 =?utf-8?B?N08zbTc4TDFwRGRjbnVwallsODB3U0ZXSEtaZEoyeWJ5RWVFQVlTbnJlNHFi?=
 =?utf-8?B?VHNEVnpFbzc5cGFvZUtidU9PN2NGMlB4dndGUk04SGtMS0IweHhYekdtQ3BB?=
 =?utf-8?B?MzdZMk5USG1PNGxsVE15VkZlUm9wcUlFeGFNUTROOTIwV0xtOGlFU0V3ZGhB?=
 =?utf-8?B?YjdmNHRXeEZDSGdGNjN5UmVpSVU5emlyVnJRSWxzTVUxQ0xTRk5TOXJNVzdU?=
 =?utf-8?B?VFNZU2RoZFJ0SmxOWjZuYTlDQUFidHovV3FDMWxES3dkZkhHMU9laFFkR05Q?=
 =?utf-8?B?a0hJREZ3VUdobzdJL05zcit1aDJiZ3NrMzhVNDhHQVErQlp3eUJCaFZHalh2?=
 =?utf-8?B?NkZWSlludXRFd2o4dlRYMEZoeVNpQ2doNWc0blM2UUd6OTRqSWZidzVmUEZr?=
 =?utf-8?B?L0hEemtFWnpjaVhWbnozQ3Z3VTl5QWE1bGYzalN3aVhyV3pYS1B3RWRybnJz?=
 =?utf-8?B?aGxua1BlVWNlQ2xPanhmMVN6dWtTVjF2emYyY1FhbklTRUdjbHl2Y3FCMHFo?=
 =?utf-8?B?bXBMdklaRXMzV014SW9PeFg1Z2xQaTlkcVcvbitHek9uaG9pVDN3RkorRVp6?=
 =?utf-8?B?VUE1Z1EvbDZpRC9zdS9KUWRmc2sxSVUyTzJwUklrVTh1bnBGR2dOekNUcW5J?=
 =?utf-8?B?T05LL0M2Z25nZnJ4TyszZVpleEI1KzYwY0NjT1dyRmlLTEtuSHVzakkyTVU4?=
 =?utf-8?B?VkxQZkZLY1RBZmtNMkgzVE9zcWMzeEw0a1NEOW1abzVTU1g4eGladnpWNW5O?=
 =?utf-8?B?Z3BSNDFzNndlb1dnWDJHVUR3K0tkMzRvRjVhampTYzEzQ21FR3ZSNHVxRjFT?=
 =?utf-8?B?UVRBTzNmQm85bGhSVFJoeW9WT3JQRDliRWp1djQ3SW5Ga0RUcjFEMTBqTGpp?=
 =?utf-8?B?SWhQL25FUEx1ME9qTVJRQ01nVkEvaUlyYWxJWW1nY3NWSVhHYXZzUFNCQnRV?=
 =?utf-8?B?V0pvQmR6Q0JnQjZINkdZQzdzT2F6ems4a3dnYW11TzB3clZFWXdUVUZGRWdR?=
 =?utf-8?B?OVZzVHFxNGN3WlROZDNiMFptQ2NjZHpXMmNnV2pSSjNoUHZDWUhPa0NlTDZF?=
 =?utf-8?B?dm5QdWxnQjNFS1ZReHgzQm1PU0xQdkwvYU1hOHIycThvbVcxY01valpYUklW?=
 =?utf-8?B?M1lRWWYrcGdOeFYxV09HT3doUC9ncGwyVHpjdkFvWStRU0t3Slh6bGRVVEJX?=
 =?utf-8?B?UUwvQURrL3MvcnBQRFdZa0NIMiswaDJMUXlVbUlNVlVwOEJUYzZCL2VXcmYr?=
 =?utf-8?B?dHlSOVpad2JpUVU1YW0ycm84TDBXTUtNRnVUWG1JaEprMDVwcm5Ccy8xSnhD?=
 =?utf-8?B?T081UmpOYTcwc1gzc3RrcGxZQm90U2M3T2hCdDJsUS9vWldvbWl0ZU9ya1pQ?=
 =?utf-8?B?aVJYbGkxZnRleGVxRy9vcTRSdzJoUmd1QXhRem4rM2hWRmdPeUlOTFZCZW42?=
 =?utf-8?B?dDRtbHcxSmp4NHVabEdBZ0VnNllUemtmYm82cDMybVNYY1R3Z016T2t2MlJy?=
 =?utf-8?B?TnJDOTJMWVVHcCtJWklOOVo3RmpCOTVIVzQ3anc5VTVaSTJ6ZE4rRGNlV2tx?=
 =?utf-8?B?d0VkSzVKb0lNRTJlQVlIVXJUdXBjSnMyMnQydW9pa1FzN0l2KzMwQU85K0Jr?=
 =?utf-8?B?cnZLZkVMR05KZHhQbE5GUkxGWU1ZeHdTc0FCSE91VStlbzlOdEMyUk9KRWYv?=
 =?utf-8?B?emRXWDMzNlJ2VTFUWDJSSS9uQ3pRRFZCQ0JnNUpaejNxZHIzYUQrOVBMd3Ay?=
 =?utf-8?B?ZXBnOGVReklGRDRIMWVTT2xiei94emQzaWNZaTBXaytlYnM5Uy9jVU1TWXFW?=
 =?utf-8?B?WEpUNFJOV0hFL2xtWWwvNjBJYVFiZkhucXljQlcwWlNnNjZFeVdsUDhUbjkz?=
 =?utf-8?Q?dq338NpLxkJY0D8JfQaw+RCo63z5snxr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmZWM25BL2dEYkVZbWVIT2o1ZDVLOW15dlRNS3dGcnB0a1lpamw3VUZoamYr?=
 =?utf-8?B?MGR5Z0xBQXZrUGhqUHdIRVc2QVMwbmE1TjhvQVBwZC8zcHpLZEU3cUlKcG5S?=
 =?utf-8?B?UHJwSUhVdWdSaVlhaGwyR1FPRk1sdTdrSWxrWnE3TG9SK21iT1VBOUhTTUNJ?=
 =?utf-8?B?Nmg0K3l4Z0VsYjVadzdzRU0vcVozZldQKzNjOFpJM1ZJeUc0WXNOOXBnbWpk?=
 =?utf-8?B?dVJydkx2RGRmYm9sSHBGSjBCR3p6VVFva1RZK0JycjFLK3huV3BOSGlVRjBZ?=
 =?utf-8?B?K3ozQjR6OG5weDBJQ0FCeHFWSllpSlg5VHZsK0lmQUtsTlZ3cXBEU1NqOGxP?=
 =?utf-8?B?Tm9Bcm81d2FST2xIQlB0QlNieDJBNmhmY3FZNjNMbWxpa0xvYlVGalAxTUVQ?=
 =?utf-8?B?QitiNGswQzlVTGE1ZzVPQzRRTUs1dm1vT3Bkb0VJTkdFTTFJVWNuc1ozQ3Nl?=
 =?utf-8?B?OHBvaW1CVWpLamtuL1VzdTk1VXBsOThNZ2hkd2tockthdm1BemZlMXNjM2x6?=
 =?utf-8?B?OUx2Y09kNWVESkdVcitKWG1rVS9ONWkyaVc0QXJENlBWM3lackFQcytIOUY3?=
 =?utf-8?B?ejhXOGpjblp1dTFlcWtYSWJmTWZkRjJ6R2NYT1hIenY4dVY0c0c3SWU4WVdQ?=
 =?utf-8?B?V1ZWUlBwMzIyTlZhb0JlRlVMdmhzU3RzMS9seE5kTDdYZTlENTFKb3EyYWE2?=
 =?utf-8?B?bkNBNTdqTG45cG1YV3gxWncxcnJaT0tTZDdndnp5bDAwRFVTS0k5bzFieVIw?=
 =?utf-8?B?cVlVN0pRb3ZTUGs0ZTRBVy9NcWhYdHpjL2xFR04xNms0SEFhMEJuZUQvZFp5?=
 =?utf-8?B?R05LQll0SWxHQ2hiY25uV3JTUzhQcTlEeE1Fd0NSSGdpMGcvTGtGMUtZSlR6?=
 =?utf-8?B?VHBuTEhKMmJHUStjdU52RW1Jd01YM1BRa3hTcmhJQm1NUkRYKzViaFVId2t2?=
 =?utf-8?B?S1BwR1ZDems3bnAwK2xhQ1BrQmFaTmNzVFFXdzBxeGwyZTdUMktldTZ3dysr?=
 =?utf-8?B?dW1XZlZXR21BaE5JZXg4cnczWG9YUXpGdTNlSFdkOXhnWjZ4bzhjeTI5TTRK?=
 =?utf-8?B?eDZwQXYrZTdXMndhMzVUcFJUdW9GcVNoVGR5NGxYMzdBQjVTbE5oWGQ3em94?=
 =?utf-8?B?OGZaUjd5ZXB2MEE0OGVJb0NzWVVYVllpa3BJaTd4MktaZmpzcFRJS21IVGd1?=
 =?utf-8?B?bTlPSlhpMDg0ZmZRc1FjZjJLNk5XVVBkdkVNVFlvb0lEcyt6dlcrN3Zoc2xC?=
 =?utf-8?B?ZXhZZlBsTUNNSEtiUHlJazllSVZQQnBHeVZhb29jRVNsb1hMOU9wcWVMMEFC?=
 =?utf-8?B?OGFjNDZWM3cxbnVTelQ3OE4xbjVvRndBSDNOdGlxNFBLeUFFU01vY3VVdG16?=
 =?utf-8?B?anRST3ducFArWTJZT2czbHAwd1lMRWZXYWFPMm1YR0w2RURjK0M3VFArLzM4?=
 =?utf-8?B?MUNFNWkyd1h5OXpxS05tRTFqK282bzBTb0RscHlMcGxtU0JCcTczMGZ4bXlY?=
 =?utf-8?B?WDBRN00rK2Y0ZDVmMHZWYlZQTDRzMktQTFBpUzhld3BHa0NSYXFldmZpQkJa?=
 =?utf-8?B?dUFFSHYzRXowQ1VlM0RPb09EQW5QWmVIaGIrckJhbzhHdm5lT3NCeC8xRCtV?=
 =?utf-8?B?SzI3UUVQNW1XZUJWb3kwQWo5UXFmWDYwRStlZmNwWGtlTElOdzlUb3dxZHJ3?=
 =?utf-8?B?YnNNaDBweHVaMXZUdFVid1Y4SzJhY0FDV05yOXVjNStNTHczUVpSK3Y1cTFu?=
 =?utf-8?B?QjlQdWlDY3NlRFBURnhMRmpIcEQ3UTVBYVMycFpGbEMzVG93ZUl4c0lwekpJ?=
 =?utf-8?B?RUFWbkFDUnFsbzBlUGJPYnl1Nlg5ejRrMjcyNGFZeFZsMGJEeG12dDR5MVFp?=
 =?utf-8?B?R1JFOFZidldENEtoQTBSN25zZlF2K0FQSWNXeFB2bzBXUHhYaFI4RUFUbFIx?=
 =?utf-8?B?R2ZhYVlaaU1vU1B0RzluOUF6dzZxR1gyd0h2anVQNUpYdnRoL2ZlZVRuYmdn?=
 =?utf-8?B?ZE8vZ3BoN1Z5VkRHc3hhT3pRY0kwT25vWTFtdWtqMHI1LzBGb0gwNzRrYXRK?=
 =?utf-8?B?b2oxeTlwQlpHcFNXd1Rnei9sSXRWckhmYURiMDEyS0V6c0pvbjhoc094bHZj?=
 =?utf-8?Q?J8GQK8lY8huyanoJ2CFzDf0d8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c0614c-d9aa-4db0-e75e-08dd5c01af7e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 16:20:46.6707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSMfXmimBRdipcv/+XeTwQhi9sFL/fM5roK76NnGYHUAhq4bDWCcJKMZKHQFCZYeOn+y8Pg0Hm6S8Qbe8sTXkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10039

According to code in drivers/pci/controller/dwc/pci-dra7xx.c

dra7xx_pcie_cpu_addr_fixup()
{
	return cpu_addr & DRA7XX_CPU_TO_BUS_ADDR;  //0x0FFFFFFF
}

PCI parent bus trim high 4 bits address to 0. Correct ranges in
target-module@51000000 to algin hardware behavior, which translate PCIe
outbound address 0..0x0fff_ffff to 0x2000_0000..0x2fff_ffff.

Set 'config' and 'addr_space' reg values to 0.
Change parent bus address of downstream I/O and non-prefetchable memory to
0.

Ensure no functional impact on the final address translation result.

Prepare for the removal of the driver’s cpu_addr_fixup().

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/ti/omap/dra7.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dra7.dtsi b/arch/arm/boot/dts/ti/omap/dra7.dtsi
index b709703f6c0d4..9213fdd25330b 100644
--- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
@@ -196,7 +196,7 @@ axi0: target-module@51000000 {
 			#size-cells = <1>;
 			#address-cells = <1>;
 			ranges = <0x51000000 0x51000000 0x3000>,
-				 <0x20000000 0x20000000 0x10000000>;
+				 <0x00000000 0x20000000 0x10000000>;
 			dma-ranges;
 			/**
 			 * To enable PCI endpoint mode, disable the pcie1_rc
@@ -205,14 +205,14 @@ axi0: target-module@51000000 {
 			pcie1_rc: pcie@51000000 {
 				reg = <0x51000000 0x2000>,
 				      <0x51002000 0x14c>,
-				      <0x20001000 0x2000>;
+				      <0x00001000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
 				interrupts = <0 232 0x4>, <0 233 0x4>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				device_type = "pci";
-				ranges = <0x81000000 0 0x00000000 0x20003000 0 0x00010000>,
-					 <0x82000000 0 0x20013000 0x20013000 0 0x0ffed000>;
+				ranges = <0x81000000 0 0x00000000 0x00003000 0 0x00010000>,
+					 <0x82000000 0 0x20013000 0x00013000 0 0x0ffed000>;
 				bus-range = <0x00 0xff>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
@@ -238,7 +238,7 @@ pcie1_ep: pcie_ep@51000000 {
 				reg = <0x51000000 0x28>,
 				      <0x51002000 0x14c>,
 				      <0x51001000 0x28>,
-				      <0x20001000 0x10000000>;
+				      <0x00001000 0x10000000>;
 				reg-names = "ep_dbics", "ti_conf", "ep_dbics2", "addr_space";
 				interrupts = <0 232 0x4>;
 				num-lanes = <1>;
@@ -270,20 +270,20 @@ axi1: target-module@51800000 {
 			#size-cells = <1>;
 			#address-cells = <1>;
 			ranges = <0x51800000 0x51800000 0x3000>,
-				 <0x30000000 0x30000000 0x10000000>;
+				 <0x00000000 0x30000000 0x10000000>;
 			dma-ranges;
 			status = "disabled";
 			pcie2_rc: pcie@51800000 {
 				reg = <0x51800000 0x2000>,
 				      <0x51802000 0x14c>,
-				      <0x30001000 0x2000>;
+				      <0x00001000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
 				interrupts = <0 355 0x4>, <0 356 0x4>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				device_type = "pci";
-				ranges = <0x81000000 0 0x00000000 0x30003000 0 0x00010000>,
-					 <0x82000000 0 0x30013000 0x30013000 0 0x0ffed000>;
+				ranges = <0x81000000 0 0x00000000 0x00003000 0 0x00010000>,
+					 <0x82000000 0 0x30013000 0x00013000 0 0x0ffed000>;
 				bus-range = <0x00 0xff>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;

-- 
2.34.1


