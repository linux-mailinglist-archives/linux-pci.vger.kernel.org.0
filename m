Return-Path: <linux-pci+bounces-12223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B1E95FBD1
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 23:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CE71F22E5B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 21:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0DE19B5BE;
	Mon, 26 Aug 2024 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZWluRMYI"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524CE19B3D8;
	Mon, 26 Aug 2024 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724708368; cv=fail; b=iKt0BkAvbe/C67S5PfshaUOwsILvtsiCQMqOoGDgVrpMfw8pttjJCNmJD493R3ht8MNHB0vtiBbjMubuCDnucRpVk8qOH8Mh5LyElUBNUgsjLi8xXj7yBDjOZTU3t1wy6SRYEZ+hPZNhe9iaMEkgFP1wiBN8y5bIq3K4Umd+/oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724708368; c=relaxed/simple;
	bh=AjysXNLeG6x3ogi+OE70jHz/hnTRUSoNP7AagkRqTZI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=j1T8ysdAMm/mHR9Q/r7mYD4Ejxvk2Jo87mvKIp4YEVwhsB86/LNPPQqfJarSsbQCJTzhdTM4GYRF9AYIXK2cEWRiq7m3LhXeA+ouqSBdVH8XKCreM6DJQcehF0xjBwcKFPIdb7CMvZTMXi4uECldy2o2JQ4GfQrDtPlFaIElGNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZWluRMYI; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reaEXV7ZRfyQjYY/IVJQFaEjr/ljh6m2pPGAKBj7Cg5GRSMD0LWEhZaAFnK8rEYzMNvjLKEkJ7sw0CsfPSM4ZHsOCboqu9zFKlW4B+6Avf4uxh32N0EQeCTMG0jTuvDkrWEpOk1SXEmSM2Jx2EjRAGvFrkkHN27mnPWVjRMETEloiErJPTLoDRgdkzIvWnYj8OeWXYWWRO2gApYbokc/ugZUL4ecGdAOSPowaPuvwM+Zy/mAFz8EFUkQlH1PfuF874NALuuJg5pyzE7SWB9T15AUYD5snLR/2ho/1QtA637vJ3ipIQRACAgoNFfcjKFaLeMmXbGh9cn7a4ZmYypIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lrEbd4dLdss9S4hMp+d8G2DHKyXmEzz8H+XTI4MmeY=;
 b=qHMp1FSaPo54Ri1di+eighdBIGEUaBCdQ7ew0aRyqErCjkMZpmyMCbkTkqmwzhGjj6QmsUQDQ/SGR2E/Zqyz9ZoLjGylDykgEE8y0sJhKYSDofxN+GYz6alqf4NkASeFPjRM/mopFYwhusMTzZ65C+DzdCuXNwUSRSIGbyyU9CHtsE8ceWSYORbVfsGxIp7XED3c2CSDBMz8r0aNtEO0/TRsqholXkiWcRGf5LN47gepXj35OsRDW7ejWjgsr8WPrcxa5E9+x7gDBL3u61rChEuh6+zbrFtHJqkwdeQ9qaXIBHaxu6I5hEbqdVBHA/uC3IJddeBj/pLB85M4GwyCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lrEbd4dLdss9S4hMp+d8G2DHKyXmEzz8H+XTI4MmeY=;
 b=ZWluRMYIYZVfpE88DAkJ11MlPu3IzLm7ppW4Eq3hwTwxA7042wLD/BK1GIAkkDBOX8T65M2BuUKwQd8WR7GnVwUrY5ikosyCpgW/6eSvgKL+J1tYxuHMTG9p6k8pJIChyCQB7M6L+s6eU3Cl0UwaxZzj7Ni9iYap3ebTwskL2tuZlLoArUCNwcmhD0AEMUYrG3zbTkSTCFnzSTqrS50Bi4y2nI64Kv9KCaHUi4fmzMwpEZYWhqkP0bfT2VuuQGHUdgkHvRS3zVBnTtMb484VBAtd6qJ+jPBE8ntJk5k8Ntrtf5N3aeRq6vgiwKfh2nEsbStPNzFz0FXmO5mNMwMFcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9360.eurprd04.prod.outlook.com (2603:10a6:20b:4da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 21:39:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 21:39:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 26 Aug 2024 17:38:32 -0400
Subject: [PATCH 1/3] dt-bindings: PCI: layerscape-pci: Replace
 fsl,lx2160a-pcie with fsl,lx2160ar2-pcie
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-2160r2-v1-1-106340d538d6@nxp.com>
References: <20240826-2160r2-v1-0-106340d538d6@nxp.com>
In-Reply-To: <20240826-2160r2-v1-0-106340d538d6@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Olof Johansson <olof@lixom.net>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724708357; l=1699;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=AjysXNLeG6x3ogi+OE70jHz/hnTRUSoNP7AagkRqTZI=;
 b=T/qPnecjHPYRsgPDsYZmrSI8UYPffonY6AexzwPRee57iAvibKTJ9LPiL71FYk/9uUnORgpKK
 szakPXKvSP8AAAjpRJX+ZJnlG6xFv5Ja8tKUHxAOZHSOYZ5Ld2RW87P
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 757ce329-d257-483c-9279-08dcc6178ddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHVhb3U4clBaK3dOb3Z2RTd1amlFdXp3YldzN0hMNXByeS9UQUU5UEMxdExp?=
 =?utf-8?B?eHVocG56QmhsTmFvSzV6OVRuMzJpLzhzV01RUHBkaVdSYi9NUzFIeFFxR1R6?=
 =?utf-8?B?NFJWWG1pc1NGNHR6OTRialMyRXVEcEtDSUNnWXF5RnlRM2lwMUZvMVVtSTRH?=
 =?utf-8?B?M0piSWJvVWx1aVA1amRxT1ZNM0JsRVNLVU9KNDJtL2tZWkhEUWp5ZW1samNt?=
 =?utf-8?B?cW0weHdBZXFKSlhpa3VJWnJuSFNUMVA1eGp3SDhqUG04aUZtbDVyclp4TlRp?=
 =?utf-8?B?MmdFK0IzVFJFZDVwL0lsRm5jdG1XL05MWVNjRVUzOE83dTVIcXNXUHNwU2dW?=
 =?utf-8?B?QmxoeWJodHY0ZEl0VmJIT2Y0aWVGOUt5clBkQ1VaWVBFWERSZ3BUM3AwVXo1?=
 =?utf-8?B?NHpVK1h6TzlHY1hIaUJKdjdPemtKbWNEMy94WjZuNUtrMTNQSnZrZ3A1eTIz?=
 =?utf-8?B?eUMxckRrK0xpQjFtWDhWMFdOVCtiMmRZelNLbnpvUnJxcXpMMG56WldCVXNH?=
 =?utf-8?B?SlU1K0VlWDBuR0RNY21QaTJNN2dBN3ExZktUYTlINFhDVnovY3oyKzh6UjAy?=
 =?utf-8?B?RWFxcVkwanVsVThMU3JlSGEvcFh4YlEvTjdUdDJxWlVqaTJVMU80cHJjRW1Y?=
 =?utf-8?B?b1pTbmlwcTlPQldBeDdXaWU2RGFZV3VCSkE1OTVhMlM5eFlGbWVhNWhsMmZO?=
 =?utf-8?B?aXpOZWt5RzlJcGxMZFBSUkIwSjl5TEVDdUJ1WExtQmc1NUdubVhYS2QxRERN?=
 =?utf-8?B?bHdlM2Q2dy81WXlseVB2UVdkbk1VdnpneTByYnRNZFJWbStUbE11RnN0N0FX?=
 =?utf-8?B?N1J3WTZNbTdyeW5DdGIxRWpWZHZSZ1NFeUIwbjVyQjBFNnphdE85UTdkNW4r?=
 =?utf-8?B?ZnJKQnlIUHN4Skl0SitWV21oNDdoMG5ZOWw5aTFLREYyK3pBZ005czIvck1M?=
 =?utf-8?B?N1lyS29ETXVrZnpSc2VWeTR0WXZPUHAvTEVJbEF3c3dzeFNDZmdiYm02NkJ5?=
 =?utf-8?B?MENiTnAzWWlmRXlQT29wRmtCckNhTFJ2TkF6enozZWFHOTJMTytLZVpVd2ZT?=
 =?utf-8?B?ZnBHR05RR29MMFdiRHYyWHQyd3hEdk9LZDRReWhzWDJCVHdtUDZFdTlFSldM?=
 =?utf-8?B?UlJaZDlaNDBoZjNJUTlyVVdkSlljN3BGT1dCV0JNUTlYYmdYWDFhcVoyVy8w?=
 =?utf-8?B?VnBGQkdnM2x5SlZiZStHL1Zjb0Vkc0hMTXB3UmpGZW05aWlWU3JqZFFYV2d1?=
 =?utf-8?B?Q3ZDYk5jZm1LVUk5Si95R1BsRFl6S1ZDbkdQd0pWcWgwN3Q2Mm8yYW95UGdi?=
 =?utf-8?B?NnBmNzkxcjZNamZFMGp3ZTRVeVo1bk9tUHh2T0lDVjVEaDJrKzY0b2Z5RXl5?=
 =?utf-8?B?Z04xbkhPRjJEdXErYUVqK0ZmMllRcVNwcXJiWDA3V3BTSytZbDBrbit6RGt2?=
 =?utf-8?B?aVhML2diQTNNZTdlSlM3dkxwRUtEcmcwbDY0THVyc1NyYVNBSC9PWGwvTkJx?=
 =?utf-8?B?NXpob081djJqL2NGK3NCSFl6ek04Z3FGdWlhK3dGa1Njb3VpS3hSVzBPelFh?=
 =?utf-8?B?Rm15aDZoMUtWS2J4MFFMa0d0eTN4RUxCc1IzbHY5akxWTTFWdmU1OHVaVm4v?=
 =?utf-8?B?NnZpTjlzSDZRSXFDUzduYXd0OW1razNVN2xEa3FWZkFxcDZkQ3kvWWRjOUpl?=
 =?utf-8?B?SGVqU0RyYUh2a3pPUG5EOS9oYXJHbStkcWZpME94N2Q0ajdoTVVNS1dTRHZ4?=
 =?utf-8?B?d2lPaEY5YjNmVEpMd3ZVRFFnSXpCZExSZGppdnVaQ092RGtTdmZzUnoyeHk4?=
 =?utf-8?B?VFZ2YXNlZFdpdCtDZDlSZ3Q5UzNHd1dYdGlpZ0J5bmxyR2VoS0Fub0JYMVJ6?=
 =?utf-8?B?eHZQbXBRUGhxUzBMNGZ2WFBEZTJKbkk5Z2MvbFVFWWtuWkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm9Kd0FOT2grT3JHa3FSY25YN2M4R3hHZ1plc1pvYXJ1NTlHbDk5b2V0NWFR?=
 =?utf-8?B?SDFSR0NHcnVpM3NpNDQySmo4dEp0YURjK1h4R3U2Qk00QXlrT1FVc01SaVgz?=
 =?utf-8?B?dnlOM3N5aEF0ekJUbDRDTU1hQ2M3ODk1M2xUMU1aUW9RUUlMZU8yaTArTVQ2?=
 =?utf-8?B?ZUlwQVFMcmxrU2hma1JtTllCWjV2VFZRK0NKYkxoTXk1N1VILzNjUWpNK1N0?=
 =?utf-8?B?aTYzLzRmb0hma3U3aFpXUGR3S0FIbXNONGRHM1VZOS9DVTFGd25SSUdkOC9l?=
 =?utf-8?B?bkdTWnV1OGh4UVZtWkFsalBCSkQxVEYrZjIweHk3L1A4Zkd0Y1VNNmVZRHc0?=
 =?utf-8?B?QXhZS1d0Mm5iejB4aEVqempQUFJMOHUwMmU4WW5oL29FUHRTU1Z5VDJnZWtX?=
 =?utf-8?B?RXU5QlBaeTVvdHF1MGs0REoyRElMdjRsRjlRdUtUNm9KUFpPU2Fxd3JyR0tT?=
 =?utf-8?B?YVdLSVpaNm9yanFib1c3Q25oSmx1Vnp5cTNRM0lVcWN4blZmb05VQ2lVK2pn?=
 =?utf-8?B?a0hrTXRMcW1DdHM1bTZDMWhadktmYm9mekZpUlhwNkZsQW5QSDBtUU1ldW9L?=
 =?utf-8?B?eVZIY2pDL1pUaXpCS25jVGc1eVdxK3E3dnoxVDZkR091eGZEVkovMVlkaWRl?=
 =?utf-8?B?TklmZWtNN2FOYk5udVlKeWFKakJrWFRMNm1nQm5BdENMTkt1MTBpWnE5c0RO?=
 =?utf-8?B?eGFKWW9BazZmc0txcjZLQkl4NVpZOVB3M291OTQveFJqVDJHbndhOGRYSUtB?=
 =?utf-8?B?Q25ETFZzYnZGUE5zNmgycTZ4SC9kbWZxRkNQWVU2RzlQZEJpMTM2aWs5MDFq?=
 =?utf-8?B?SWxOZkJTYUFQOG9VaTlhWXFTNWZKMVVtNlhkTnh4NjhPSkxubTRSTjZnczly?=
 =?utf-8?B?azROZldWUWZNOWNKZW1lOWY2ZXluOW1tL2tYZ3FCTW1nZW9TU294Mk5jdGRP?=
 =?utf-8?B?bmNZQmtsSStZYWpPNjRlNG1VVkJOWG5rNFo2bXNQOXJFMWdNeURSV25pYmlr?=
 =?utf-8?B?YkcwaDhMa0dva3pSRzg2MytIWjFzUHhVelBYS3grNFpSbG5vbzl3VFNsS2dl?=
 =?utf-8?B?TGNmdm42OFV0cWNESTM3dGVmS1doQlBzUnJCd2VDSUkvME5lS0EyTDNvZm9v?=
 =?utf-8?B?blFQK0M4WFJDRzRObHdXTG5RZjhWczhQWFMzOWVNSFEyakppb3JWVHVVTnNC?=
 =?utf-8?B?VTFEdnJDZkNCNk5EZ2MxaHI0WWJjUUxOT0lYQmpnbEpkcUZyTlB6RGt6eUhI?=
 =?utf-8?B?S0VFc0Q2NWNyQ1pFUlZ5VGtwRU9VNWI3YnRTbUVTd3BUc2c2Z0dkTWgybUN3?=
 =?utf-8?B?bWEyL1BnY0ZvZUhMQ0xETWNmUHBKNXROQ2ZCSHBjbDJMbnpxQ2JVL1RGeDNw?=
 =?utf-8?B?aDIzOEhVQmpRajNjYVhxNmM2NFJVQWJ5djdoMUtZcnU4WFhDUDh2OFdMcUdY?=
 =?utf-8?B?RHJ4VTJnL3hjNStyV2c2ZWpmZlhwdlVhRUNwaGdMRVVEU0pBZFV0Z1h3NVBu?=
 =?utf-8?B?bnlpOHVqRHpJT0sydW1WUjAzMjdEN284anZFSDhYbTg1L3NzbFJ6Y0VQMFZh?=
 =?utf-8?B?K3NaNHlOZXZTeWZhM1k2ZnJLSlFDd3dDeTNuNzB0UHZ3UlhJZ0xneDFWTnZr?=
 =?utf-8?B?NFBMNkFPbFRhRFJhaDZFdGxJaU4vUjVObVFBU1l3MWU2eVBGaGk4NzJ6SGxh?=
 =?utf-8?B?K1NSU2FDa2FxVi9COHdPNk1CdVFuOVhkRmpSdnhJYWUydTEzTHdWM1VOSStN?=
 =?utf-8?B?OE51djVNUks5Z2lWbytQRnhjRFo4QXdkMDk1SFdka1B6Y1hpajlGRVFqbVM5?=
 =?utf-8?B?YXBzMzFqTkR1ck1lQnNvUURDaXlCZVNta0ZPQUJzNFE3S3V5cXQ1cnpnYkxs?=
 =?utf-8?B?VHlTbEU3Q0kvVVJqeGE2YUdTakV0eFpRT1dISWdIU1c2MitqbFpRT2xJNXE5?=
 =?utf-8?B?a0Urak1EczhVVTVPRzFnOGlzM3JRTldBSHhYZTd1NVJPdi9rWDFHYWNMMVpI?=
 =?utf-8?B?NkFzVitYUmVMbmk0RVBLWUFlbkZ4NEFOYkxuYzNoT0tmQVZyVHNJVitqQnAx?=
 =?utf-8?B?bmpzTWs3NldDVUFWMHJGUmx4cVV4NDhOd2V2MzJHT05tTWxnZGdpblVFK2Vv?=
 =?utf-8?Q?0GDTO4WM+voeM7nPPj8ApSJLu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 757ce329-d257-483c-9279-08dcc6178ddf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 21:39:24.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8v5K/Zi3nAKW4R4axeLerboqV+kBKIgVzRXvucMrUG3cgXGC677bnHe+M9Ye3F5Yq6y34YjSf0fSVzHwkXD77A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9360

fsl,lx2160a-pcie compatible is used for mobivel according to
Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt

fsl,layerscape-pcie.yaml is used for designware PCIe controller binding. So
change it to fsl,lx2160ar2-pcie and allow fall back to fsl,ls2088a-pcie.

Sort compatible string.

Fixes: 24cd7ecb3886 ("dt-bindings: PCI: layerscape-pci: Convert to YAML format")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/pci/fsl,layerscape-pcie.yaml          | 26 ++++++++++++----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
index 793986c5af7ff..daeab5c0758d1 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
@@ -22,18 +22,20 @@ description:
 
 properties:
   compatible:
-    enum:
-      - fsl,ls1021a-pcie
-      - fsl,ls2080a-pcie
-      - fsl,ls2085a-pcie
-      - fsl,ls2088a-pcie
-      - fsl,ls1088a-pcie
-      - fsl,ls1046a-pcie
-      - fsl,ls1043a-pcie
-      - fsl,ls1012a-pcie
-      - fsl,ls1028a-pcie
-      - fsl,lx2160a-pcie
-
+    oneOf:
+      - enum:
+          - fsl,ls1012a-pcie
+          - fsl,ls1021a-pcie
+          - fsl,ls1028a-pcie
+          - fsl,ls1043a-pcie
+          - fsl,ls1046a-pcie
+          - fsl,ls1088a-pcie
+          - fsl,ls2080a-pcie
+          - fsl,ls2085a-pcie
+          - fsl,ls2088a-pcie
+      - items:
+          - const: fsl,lx2160ar2-pcie
+          - const: fsl,ls2088a-pcie
   reg:
     maxItems: 2
 

-- 
2.34.1


