Return-Path: <linux-pci+bounces-16910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 544489CF33B
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0B2DB4255D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483FF1D8DE0;
	Fri, 15 Nov 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U/hPpnjM"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2075.outbound.protection.outlook.com [40.107.247.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F61D63F3;
	Fri, 15 Nov 2024 17:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691745; cv=fail; b=Hp0JfJELhYyi+H3ewvBddwam+3A54tjrb6TJ0Z+qy8OtVDnYOmQ7TGogqNkwMAM1M6laKDmJR8wMDjHRZQuxgJQUggd2ZlQPB0npIBd0Vm8DyaKwPu7Ag9VmN1Xf5SCGq1G5nYWM7udWknxHT0nv7FW1loSMtxhL9IwqHsQvvVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691745; c=relaxed/simple;
	bh=Wru2BVOqlmMClWeKKGxwoF38JU/FekZ99t86BX471GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k1PtqtREqafR8qfCe4eg7DsRGwq1M4khddem+Ke1y8eXLdRIYKYLM5wcWj0MHe9/i9zZok63yfkTyKoCWXnOe5qS/HHrXlWnrgW36dv1GwXeQnvaIVp2/NaBZhMF4/rnS7jahjutfokUE06A+GjxzlF9xGi5NQghbPe12p5CqVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U/hPpnjM; arc=fail smtp.client-ip=40.107.247.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yf39qQ+7VFgqViuq63lYzNejfWiqoVctfSKcUFgQifz65Mac3eCLXhDkpZ6S4kJZfbOcMAhNlNAUviN+6Fjqfo4YaIZNTqGPcmFgGo/ss61f8aN6GC2Hes2Rs+MRiANIJ9i6bdr9XxWG+NiJp1+3gbke1u8TkTVlCduwBPSOexk/d0KRnKd2JgCAPcBkG+U7yIWrJScjuFUTuSqQilDwDDFI1oXCE4+9nSgnU42sObr5wGgwW3eHsQ+f9+aQ8gWUdlWR2uLBr1tHvrywDshKPY8XXCrqxnb4DDGdIOydgY55R1IXBPEq1ywNSvZArMec0IxyqDnJybPt2URwLog9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdRE/WqH0pxL8YBeRNRLZGyv3hWogvkfT9xlpzc8T+0=;
 b=ZlwjRO8tCgs0TIdL0F9D32T7qw4ZXcFUA0x+a4VVUa5W7tVtLAJdm85AchBl9ZwqQY2kFZn/J88CZuAWlJJpvG5HlW4Z4moxNssxVqfKiaq0GMsewGOntq6LDCnjy7hscddlx3c5/Ap2G/fxEhEzG5NCiirKomkXBBJ3nifVuCaNlx9Bqj9/jfGUXcKx0kbda4n3O84wqGdsk5dnd8g90r7rR0bG8momAA1dV2vLhDtTgddPxVxZr9BgbddklKrLgmoZfkfk4GMm4xQdt2kVfv4GSt5x9HAilOA0NuDI0LuoF9DKXa1kQuEK7xIQtWogbk6uS51fBX9EypaKk27GAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdRE/WqH0pxL8YBeRNRLZGyv3hWogvkfT9xlpzc8T+0=;
 b=U/hPpnjMy1p1L9LaMiJ8HHM70u2TJVTkBPbSSsJbN8tGDcDc9RPPYS2q64fhoFSbHFKTc1BUGb2pge7HauD/VxC696KO/JOKA4rNqqjnhQNgcM0O2esT3OYw0n8bgPdMBODQtyxQc8gELNYJvseAv0CgzV2iE41jnz9+pfTmoGXOO+lTBPMeLKGG79g7weo42ZftDxJCgB3BDCz1c+lvMWBeqHT4nRxb0TLkAOm7pRwsfm60USD+wZN7KkEyTrc2qfOZlHkFnqc7bqulPyA7o3etblhioE8y8WnJGz9NFV7ZbiEXBvc00y9mRs0F7i3x50OlQQ738p5HvxS/rtl/dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9250.eurprd04.prod.outlook.com (2603:10a6:10:351::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 17:28:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 17:28:59 +0000
Date: Fri, 15 Nov 2024 12:28:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/10] arm64: dts: imx95: Add ref clock for i.MX95 PCIe
Message-ID: <ZzeE0lR8DGG214qq@lizhi-Precision-Tower-5810>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-11-hongxing.zhu@nxp.com>
 <20241115071605.qwy4hfqmrnaknokl@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115071605.qwy4hfqmrnaknokl@thinkpad>
X-ClientProxiedBy: BY3PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:217::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d61a0d-0fd6-4c6f-f39b-08dd059afd3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzV1Z2xtTmhvQ1loanVGTy83Um1OSnF2ZXFOQUUzRnN5aHBUeXlidUxvWFha?=
 =?utf-8?B?emVoZ1JDRDdLVkthRWwxYkxmOFBrVE1jb3BlSEtPb0IwTERPbStaZ3JId2pw?=
 =?utf-8?B?TmkvbXJRMEdYRXl2NDc3VDRtSUJCVm41Tisvc20xWnBYT3hHLzI0TGY2NWN1?=
 =?utf-8?B?Y2g5SWVtR2dpMjRuVEdETWNKQ2llME5WSHllU0pDVzRqS3FQR29DYWcxMXVm?=
 =?utf-8?B?NUU5emJzK2JqcFZtMmJ1ZzRRRmJ0Y1Zhc0tURGdlRlhHekw1dzg2elo1QjJE?=
 =?utf-8?B?VVQyQnluRzY1YjNJUFpIdkxwWTJCTGphTFA5VkJSWGN2ZTdDQXIxSWt5UWw0?=
 =?utf-8?B?eVBBdFVBUnNPRjZ5TEZCT0JCYkg4RGluWkpkeHlqSGJQU29oZUFRcURDYmJ5?=
 =?utf-8?B?T2c5L3N5SWVvL2dDQlR5OHdYZk5MWjREWXZqZTFFK3JjRERPSm00K1FGRXcw?=
 =?utf-8?B?NzAwaUdJL2pKejRhcktyckJueUtTWGd0OG1Ec0p0VU5MS29vcmg1ZFFXVjJN?=
 =?utf-8?B?S0VyRWhWSk1TVTJ4VVBqaDRESHl4NGt2aGl6TVJTQTJyT254WG1WWnM3Q1Ax?=
 =?utf-8?B?NkV4MU5vWkpnYkEyUU9MMmkxd2R0elQvRHRObVBnS3ZNT1BCRU5jVjZWVVZO?=
 =?utf-8?B?Q0IrcUlvQlE1RVVqbUlDdHBRRWtYWnZBakxZeGNvczY5a0pNQVFESEdUSGZs?=
 =?utf-8?B?K0poa3dHMUl2c3pTR3hpKzlVMkdrNkJFV0M1a2NZaHhUNVFNWVEwckpKQldx?=
 =?utf-8?B?enRYUGt6MHMyWUtzeEcyanpTNlFHNjZEaDQwekZidEtsaWp0NUpSRk1sSGVE?=
 =?utf-8?B?WllpSjhENWFBR1AxOHpsRk41cXcvaGE4UWdPNlhyTEpTUTdJRWt6dkZrbk1L?=
 =?utf-8?B?SjNzNWYzQTRob1IrRXRLQUg3WTZMelUrQ2lwWGl5anUyNVVlKzh4ekhjbmlp?=
 =?utf-8?B?eWNQSGJPOFQwTk5oem1JcHBVRWlWUW5qbG9Rbkkzc05WcTBoS2ZvOUhvQXZa?=
 =?utf-8?B?aldZOWdxUjV2UTRGSXhSRGp3aHlxandNZVJhREEvekdVSTlYc2NMZmZYZnhm?=
 =?utf-8?B?cUhoL0ZTZDIzbWNHMzhmdHpibDJja0pzQytSTnIwSk5LUFZEelFXTC9HQ0Rq?=
 =?utf-8?B?d2hZelR5dkZrVlVNUzhqSVJiaFZPZ251MTM4TUVyd3p0Y2FpTkFXSmNsLzRT?=
 =?utf-8?B?dHNGQlY3czdaT2hkajAycmFSVkhSUE5zcmRrM2Zldkl0U0VNSEs2REYvRkYz?=
 =?utf-8?B?bFAzdkpuZGRPcTdGQnF4TFpqWnJ3UVNvekpoblNFc0N3NEZsd0lObjRqdnNk?=
 =?utf-8?B?aDMxanQvMWYvNjhGSWJKSFhPa1FScjJ0MVpoNndhVXFqdTdRaHJQcDB5VkVM?=
 =?utf-8?B?c3ZwajBUa2NqMm5XRXNjblBQQkJnK05YTE5HM1RhMHVEanZBU213TXM5M21O?=
 =?utf-8?B?MG4xc1lxZGZMYWVsRmNLb01MV0V5QlRCRW5oNGNza29XQWU4ZVA3S0ZpOW00?=
 =?utf-8?B?RWRIYitYTndRSHZzQ2Jyelk2OXdWbDRPWndYZzJCUCtkaGIvbVZUa3diTnZu?=
 =?utf-8?B?K0JmTTByVjZ2YkdTMVBNWDBOYjg1RGRYanRvT0txTFRWOUNJVnlSbG83bkx6?=
 =?utf-8?B?T25Cam5iN3lvdit6RFNNcFpjVlVnMTRQLzBVV2RoZUtka0hXd2hkUUpiblE1?=
 =?utf-8?B?ZU9tKzJvZ1g5VksyZHdvLy83OC9mNWx5RStEMGRCbXhmTDdIcjF5SUltVHFR?=
 =?utf-8?B?OWVld2NZdWNmQmpRYWlIQmxkQ1NVN3ZCdjhJdXFkeFBQSUlXV0RXSzZkRHgy?=
 =?utf-8?Q?xTzQ+LexGAO/BjRbc+34yebrs76FxPQ8NmFOo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU5NbExZY3dUQklzTVFUbS9oOVhSK3I4dmlOa00rKzlKVFJTYkFBa1FDZm1j?=
 =?utf-8?B?ZWkyMUc4VXJaT0Q4TmdnSzVxcE5Sdm1oQnZxS2c0YURNVmJSN3hQMjYxK2Ji?=
 =?utf-8?B?OGVsY3phQ0pFUUJiSXVHNWVndDBLSE9uY2h6ajZGaVpLNUt3cDlQV3lwc0sz?=
 =?utf-8?B?blArYlNCYW5NTldJUmFqMTBsNlBnQ3BZbTNtNkduVVdhOUI0b1JyVjJmZmxk?=
 =?utf-8?B?RktCSmZoQ1lhK29iOHB6RzM4aDZ5QVF1cEN5MXE5MWs3YUpvNVVjVm1xUVFH?=
 =?utf-8?B?UTNndGdPMHZnVUgwRXhseEV5ZTYyWStWUEVsQzBBd25nQVduS2xBNFZVT3Vk?=
 =?utf-8?B?YllGb1lqSVRrWlYxVEkyelBNMUkybUx5NUNDeW1nZ3dkc2NuZUU0MDVoQXFq?=
 =?utf-8?B?Y1JZY3RpTDdQZHRzU2NLRTYrN29vQnFPTHVRc2J4TDJJcjlLbzNhcGxUdkdV?=
 =?utf-8?B?dHZEKzdMWHRtaFNTbWMvMkZWa2ZwWE02WWlBM3JKV3M5MmdRdmJpQXpLdkJh?=
 =?utf-8?B?RTQ2dENKdXdRdVQ3ME1jS0ovR3N1QittSzhuQ2dGMEwyWW5GMGJIQmUvY2Jy?=
 =?utf-8?B?RDZHR3FoTzlmVmgvV3AyTW4zYXFRZTFOdXIvOEFDeE9VVlN3NW1UdnhKbjMr?=
 =?utf-8?B?NnJlUTFKZ0RDMTVKditLMlgzaHlzbWpzd005SjgwTTVQbzY4TkZGY2lLdWFu?=
 =?utf-8?B?RTZFWFoxbTFaU0tSVGs0WjVGdEdTOGUrVFN3MGJUSW5NRGVnbkV1TnFLR0Ur?=
 =?utf-8?B?Wk85UDFxdXRqcW9rSE80aXlvN05BMFJSR3dUK3lFRU43OTZ4dXZ6MHE1Slpr?=
 =?utf-8?B?MENnSkRpTm1TeTVJVkJTVHMxVWhZLzVROWE5RnZQdVZNVks0U05FR050aVF6?=
 =?utf-8?B?TC9CNDFxMndlNEd2VnMxOEVqZmZ2U0YxMURlS2xqTCt3NVk3cmNoMFZYQk9Q?=
 =?utf-8?B?Tm1YNVB1VUloVnBJRnVkbStBV2dJaENnWElKUDUrMTM2b1VHNGRJbUJLelhQ?=
 =?utf-8?B?U1RLOHJVL2hicTd1eG9PQ0RlYXZFUW15ejhtSkRWK1VHand2RHEvb2pDUXln?=
 =?utf-8?B?cG82Mzg4MzZWRDZoamdpL2ZiQ3U1Sk9PRFZSOVBWNWExVTNmNzhIdkZvbTV4?=
 =?utf-8?B?Q3kwNHduelFnQk5xZ0hjb01hbk5oYnBnSGYrRkFrMlZxL01tUURGYlhWTGZN?=
 =?utf-8?B?ZFdWWVFKSUhvcW9GeHRvV3Y3d3ZpUHBWdkluR25DZHBlMHNJS0hjTWpmN3ps?=
 =?utf-8?B?QzhXaVJNYVBzOCtqMno2czNpenZVdUYxZ0ZaaTVHZ00ydTFPWkNlVTBLU01E?=
 =?utf-8?B?emRJYzFRNktPODVCR2Z6K3NNZC8zK1hINjQ1aSs2SHpLNS9pV2lkQ2o0Q1Nm?=
 =?utf-8?B?UU9GTDduQ3FlRmtaN1B0WVhNRzNJK0ZaU2hYYy9YWm5BUlNQOUVWWHdqcFdJ?=
 =?utf-8?B?VWptU2dMemU1L3B5NDE0ZFZDamRQT2k0c3pZRW9YUmp3S2p2dHE5N0dkWk1j?=
 =?utf-8?B?bVMxSHF5L2lDSlFjTzNSUDk1VjNvVUs4RTNSVW0ra0N6WHV6a3JWdkl6NVhM?=
 =?utf-8?B?ZDRpdXhzT2VvVGVYMmhaSDBkY0RzZDI3NlRiTkxJenVpR2lIdEhkNDNla2E1?=
 =?utf-8?B?dnBTKzdkM0w5NXQvVGRDeE8yczJYSkVZMG03U1luaFRrSlVoSFNoSmNxTVpl?=
 =?utf-8?B?bTZkdnpCNDRsekhjOXozZXNNTDF2bmFOSFZwQ1VNak5JdmJhVXFSQWxQKzVT?=
 =?utf-8?B?T0kyMElGVDVtRlZtUU9NeW5rZG1TZHhoTmlPNzRNcW90MUFrSG5yVnZUSDRu?=
 =?utf-8?B?bFBCUjArcDRVZERuZUU0Z2JNQ0R5eTJEUmQ1UEJGL1N4OVZGU0VoTmxTWGtP?=
 =?utf-8?B?U3JLMjhUMVVUM3ptQWdxY3lra3BaRW81c3E4NnVWNUYvb2pXc0c5K2w4NXNW?=
 =?utf-8?B?M2h3VmZYV1RrVThobDNsUlMwN2QxUVpTdTVHejFDWGF5Vk0yWmJtZm1YYmIv?=
 =?utf-8?B?ZXpPT0w0L2Rxdis5UEZKVHF4YlJKeDEwZWZmU3NXM2k2elpPbjFKM3V2cmFM?=
 =?utf-8?B?QnpLeHlOZlBQWlFQNi9MWGpkeWtndlZFRDlvNUt2ZUowc2hGTXJpQStLN1hQ?=
 =?utf-8?Q?29/2rDVEbMyU7X/pw2fFisPOj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d61a0d-0fd6-4c6f-f39b-08dd059afd3f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 17:28:58.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lUvwOyBujn5yAuxZLgfWfezuM1h+Yzh57hyPtNg5tuw/cDfxD81yPILPDBr9ua66QD1toR7tPwHQNtjgSUuKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9250

On Fri, Nov 15, 2024 at 12:46:05PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 01, 2024 at 03:06:10PM +0800, Richard Zhu wrote:
> > Add ref clock for i.MX95 PCIe here, when the internal PLL is used as
> > PCIe reference clock.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx95.dtsi | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > index 03661e76550f..5cb504b5f851 100644
> > --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > @@ -1473,6 +1473,14 @@ smmu: iommu@490d0000 {
> >  			};
> >  		};
> >
> > +		hsio_blk_ctl: syscon@4c0100c0 {
> > +			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
> > +			reg = <0x0 0x4c0100c0 0x0 0x4>;
> > +			#clock-cells = <1>;
> > +			clocks = <&dummy>;
>
> What does this 'dummy' clock do? Looks like it doesn't have a frequency at all.
> Is bootloader updating it? But the name looks wierd.

dummy clock is not used for this instance, which needn't at all. Leave here
just keep compatible with the other instance.

Some instance of "nxp,imx95-hsio-blk-ctl" required input clocks. but this
one is not, so put dummy here.

Frank
>
> - Mani
>
> > +			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
> > +		};
> > +
> >  		pcie0: pcie@4c300000 {
> >  			compatible = "fsl,imx95-pcie";
> >  			reg = <0 0x4c300000 0 0x10000>,
> > @@ -1500,8 +1508,9 @@ pcie0: pcie@4c300000 {
> >  			clocks = <&scmi_clk IMX95_CLK_HSIO>,
> >  				 <&scmi_clk IMX95_CLK_HSIOPLL>,
> >  				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> > -				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> > -			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> > +				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
> > +				 <&hsio_blk_ctl 0>;
> > +			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
> >  			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> >  					 <&scmi_clk IMX95_CLK_HSIOPLL>,
> >  					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> > @@ -1528,8 +1537,9 @@ pcie0_ep: pcie-ep@4c300000 {
> >  			clocks = <&scmi_clk IMX95_CLK_HSIO>,
> >  				 <&scmi_clk IMX95_CLK_HSIOPLL>,
> >  				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> > -				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> > -			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> > +				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
> > +				 <&hsio_blk_ctl 0>;
> > +			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
> >  			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> >  					 <&scmi_clk IMX95_CLK_HSIOPLL>,
> >  					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> > --
> > 2.37.1
> >
>
> --
> மணிவண்ணன் சதாசிவம்

