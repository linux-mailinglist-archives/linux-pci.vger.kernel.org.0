Return-Path: <linux-pci+bounces-17718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0619E4906
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 00:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D286818823D9
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2524420D502;
	Wed,  4 Dec 2024 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f62oKsyT"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2082.outbound.protection.outlook.com [40.107.249.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2564720D4F1;
	Wed,  4 Dec 2024 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354796; cv=fail; b=QdLZ2iHbmO1rLy2BuUCRz73gnDKJZg8N4BqQdo4IQU6ekpyoJbmetgFSWkHEgW3wZEt/vTN1cMk54aH/4PYuR74ueeCLqmujjax3oHOxDUF8rOruJCYnSdAzfqgGYoudfJkPDI+ycGh4vdPCDxWqG0WRiYTJ/kIislf/QWY4yNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354796; c=relaxed/simple;
	bh=qzdj+nRdFv5Cm2vKc30lduKze81AuWoXfq4Swx2tuik=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Wq5hjoOas1TZcs/4RSiMClTdQq9xvNJ+v6+dzI5kerSKv1LDOzE8yz5UNlI9R035f0rokVUjvvlU2vvAR8HRKGM7LJqRah6LSjdz4R/E/OGzav8cqDJXXoI5vleW8DMaCJIqQTu345PWJ9mwI8I+nTYSgKSQQZQj2kdd6mn7imU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f62oKsyT; arc=fail smtp.client-ip=40.107.249.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZgVPnYiRS6TX+s41qr/sUOcnRwpCo2yRRYQSwqXGsuLBaX5UsMcSuNp7XK6i+IslaNENg4D6HRZQtI/RiPDRJa7dqElnxuXcXPIob1M1UBGE2iRNKV41CuiYazcVucMcJXuV1wyiSsX7E62b3mLSl3RYZ/3HNrYlHS97ND1Yap20uBTUJYYdnv2Kt7lMPLWlcETHmQhzFBDS7hem5vXZIEET7HX3xroFTgPBZF6aQiJLXBFOMkU1olayyE6N67zRCDkdw9cFBcCzO2MCRguRz6V36gVUT67GVJzR9S+ICMVOTVjdY4OnZRKT09XC9Nn836KO/AA/Yv4JlCiPpK7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a/cK/pYlQ0BGc5w9UFnxXw6jPGYAo0/YzxPKdtiIWw=;
 b=cHz7jZoD917t01rXgMwF/0wBVaGJH8Wedknh/zq9NxUW/vvQOe3YKK9FWK+1UPsh36Jym4ZZ4VandsbXUOmHyX704rExzn1X3YgEzNcNF8568VLp+e8a3cWr9WYdwEqxdIAk8k45DVUHwXA9JduX993Sfzo3OzMEvoZQIWaig7MeSmLy8Ml2wiVLIFlvTX3QaX9GIW6kxBpdFMuu4zErMmQ+Yzn4MzsAEINwJI4/8+sNSvHVBpodcCf5n7+AkU7ytexY0EnGVg0wQLQWFE9iyGyE0ETJIZY9uEgrcH/jScqA2wAA4BW3dd5lzPTZtI2AU0q+HEU5s41lmo0BaHJ1Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a/cK/pYlQ0BGc5w9UFnxXw6jPGYAo0/YzxPKdtiIWw=;
 b=f62oKsyTC1thk6ahi1q2cf2VchblHJzf30q3ros7cRWU7+EV7CS9+u0tc/wwz0n6CZrLNmWfJOItMrz4JugVMSFc0/rpgL9AIvvO6RZ9DPtTx6TrPF5e0FSh8NXnMBNfzgwvClugzDHYeuNxqL1hhOaNRoKVNWPgY2JQeUmz6YDhv3dSQd/gkRTZMUg360juLhbkxhk/XGpismtL8kMZdkzq5vKLO84d0sj8e/+EoqqAr59QIbqmmbfrAqzKOS8tLVyEYEMNwMcFn8XB2wxPnowqRRhzP87/a9AIa33s0jcRFptyu1OOuDqx8QoadMFWyM5hKJ6nTjra6wxOhOQEnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11006.eurprd04.prod.outlook.com (2603:10a6:10:58a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 23:26:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 23:26:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 04 Dec 2024 18:25:54 -0500
Subject: [PATCH v10 4/7] PCI: endpoint: Add pci_epf_align_inbound_addr()
 helper for address alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-ep-msi-v10-4-87c378dbcd6d@nxp.com>
References: <20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com>
In-Reply-To: <20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733354769; l=3395;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qzdj+nRdFv5Cm2vKc30lduKze81AuWoXfq4Swx2tuik=;
 b=wmMgIa+byA4MKLIBaG/jM1vYCoDGfvaZW4tFZTjxycmT36AxTmpPrHFX7UNoGgyhEq1+UowaH
 LIWeZ4vsIHaDprF0TxJT9qWZu2IrRm8/GLT50gV8D36ReijDXJ3qlg0
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11006:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7e50ed-3ae9-44f1-b032-08dd14bb15e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnIwME4ybUw5bUlMSTYwTERQS1hkT0RHUUtsRXVIOGxGMVVCeFpHWmtJOHRr?=
 =?utf-8?B?czdsRjc4S3Z4QVFTRm44YW9rQ1B5ZTRQRDJMUkZnVmFwZWxQeVByUlA4aHpC?=
 =?utf-8?B?cllBVkdZVHdoM2YwSFJ2bzhnZ2FHWTdUQWZoL0dJeXNUMVlUa2ZabTdsMUM5?=
 =?utf-8?B?d2pDQjhUR1hFbjNJNVVMd3JNM09LOFlITkxNUFRTVTJHck9wOW9RRitBMjg0?=
 =?utf-8?B?YWlZc09uSXFGM05naS9ZK05oSHZPNWQvR3F3c1NyVDZHeld4VUZ1aG1TQ0tH?=
 =?utf-8?B?andRYnljTEJ2L0RxVHZmdjlyMEMrOWh6SjF0NHg5d01nYXZQcDRRNFNGRlFm?=
 =?utf-8?B?bmE5dytFRW1FaHZRdmgwVTNPWkg3NDVBN1AzNHVKREhCakFHTE1FYmxsM3pm?=
 =?utf-8?B?eU1PTk81Mi90cHljeFdkRkdwYzZZd2FSUjB5TDBLL0NPTmhGQlZXZnZDTHFD?=
 =?utf-8?B?TCtmZEp0bzNpbWJFSHI2bGlVU281OTdOaXdNd0FVbmp4Qm05eWNJOTdmR2ll?=
 =?utf-8?B?eVlNZDNtM1JCc3hiQWpNeTB4ekNjeUYydWlrZ3locmRlUVAyczF3ZjNEM2h0?=
 =?utf-8?B?QUpab3plQ3BGRkRlU2dobUMzNVA3OSt3azhTVTVyMU00Mml6d0FZTUJtYlBH?=
 =?utf-8?B?Uy9JSDFSdC9uZXN4NjVyM1dPam9EVlUxZDFCOHU5V3k2bzBUNXRlNWdyUUky?=
 =?utf-8?B?WEsxQVA3c2hPOExkNnVFbHhIMUgvY1JQMW5KRjRkU0cya1ovVDBZeDZVaUpk?=
 =?utf-8?B?N0lyZjd4VVBEaG40ZUx3S3VmclAxT09KZ09UM2NvMTIrb1Rhcm5QNE5yTEli?=
 =?utf-8?B?Vzljc3EwSTRTZTN4a0dzVWUyckprTkxJUElWSHErUGtqWU85UDhIaVBGOGN2?=
 =?utf-8?B?aVJYdExPb3ZpVEFDb1JsQXZKb09vTEQyVTdsY1FvSUNicjFXbmtxS3ByUVZj?=
 =?utf-8?B?YVlFVU9EeklmTktyTkpyVHpyUURHWXk2RzVnSVVCTWFKQzdxc21naGRVbWlK?=
 =?utf-8?B?aHJaa1gydGdkZU5PcjcvM3FlRmhudkdVYm8xNTloL0o2SHRBTEc2Y2JIRnVP?=
 =?utf-8?B?Qk5MWUtSZjJqN3lHNUhUREtNeDJhblB2V3RickczNW5EVjRETmJaZEVHTXdy?=
 =?utf-8?B?dVJCb0pPNi8rY0hhVGVHODdDcXZkWFR3djNmWENLZkZlVXB3Mmh6NFA3TnZm?=
 =?utf-8?B?REl1Uk12Y2hNK0d4VTg0U3p5Nk1CWDVuSmQySk5qVTRJS1lUUnluZGttVGdR?=
 =?utf-8?B?d1Zza0VOVTdGZkc4Nk9BM0FPdWFaNDR3QlpsMGd1Rmljdzd1ZUpEaHhGNStR?=
 =?utf-8?B?Sy9ySk5HeEQ2eDNhV0U2RVM3SVdkU1p5SHdZVFQzOU9Sb0xaZnpQTmpMUklv?=
 =?utf-8?B?SG5DZGJlOXR4aDkwVnA4YUlnMUNjQVljdHcvNXN1U01qdFFPekNkSm82SCtk?=
 =?utf-8?B?amlXM2dTb2FNZlBvbUNHQlduVlVmYUR5UUM3QWpqUnY4bTFmTkZaeUYrMzU1?=
 =?utf-8?B?M016bE1zUlA3TkRvYlZoZHd6RXdGaFpSL2tNSjg4Z3Rhby9oWWdRMjN1cU5F?=
 =?utf-8?B?MzI4aFhucFN0N21QZ0xBa1RGU3crNjZabjVGb2tmamhvS0JKTGdmRHA3bmQx?=
 =?utf-8?B?RjROck0yLzZnR3F0RGNzQzVwSG44V0ZXdHdUVTRKMG9WU1I3ZndzajZ3Ny9P?=
 =?utf-8?B?Ylh3NWRJMHY3VGFSTUpFbW85WDdrSVFOd3JMNzZKZFJWQ2tjdUFTOGJCMFN3?=
 =?utf-8?B?YTdpYVZnYm9mRzFwMHFqQzNTQmlvUjRPNHNwdmQ2T0ljd3JDcStEeDh1cnV1?=
 =?utf-8?B?aGt5UUZVaFNaVG04QjAzYlMzQkZ5SU9Hb0pqNm5ITDg1SDNZanYzc0NHMEJJ?=
 =?utf-8?B?ek91MzB4OTZTNWFHanlQUHRRTHMyODY3OUZjbXB2Uzc2TGJzd2JFZ05xZTlr?=
 =?utf-8?Q?CBj+k3ebzvM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGg5RzJleEQ0OXNCQjZGNkIvcTByS29kRGZCRjRQOHVCWTBDb2NOcCtrYTlV?=
 =?utf-8?B?eUJnWkhYVmVtYjk0dFRPTWRGakJVZW1pcjF1UG1VbkwvQTl6VVVDd1BaSzg2?=
 =?utf-8?B?V3RReXQzRHZZS1FPcVZJZWE4Ri9mTTlBWTlsWTBqZkFSbXVrRTRRSkMwdE41?=
 =?utf-8?B?SWhKak0wWS82dFBDRnNyMEt6UzREOEFwemhpeWRBSXRUN1VhUE1DYU8yM0NI?=
 =?utf-8?B?RjVLTUtJWWxYRGJGdDZlUmtVb0JFWDlDdXJOZmNYcjBiMUlvRmVtNGVGcXlw?=
 =?utf-8?B?azl3WTNFYWpvUFE0djQvTEFDS054bTYrRDl3WUV1bHVPbmhJQy9mYVBGT3lo?=
 =?utf-8?B?M0luTGhVemxGaWpoNlIrdzF1eWl0T3lOa3R2TzNyNGcvUnY5VEZyRVJqZWNw?=
 =?utf-8?B?UEVya2gyT1ZGQThXOVFqN1U5MGpSeGpIUTVhTVBNcTBYZkJNeFk4b2lnRVpW?=
 =?utf-8?B?Yjk0cFVyc0ZHRDlpb1dvbGdsVitWb1BQa0RSQTkwL0hwZlNIY2k4b2FBcnVl?=
 =?utf-8?B?cEN1UUd3R04yWndBcUNMV0l0Qlo0a3FkWU8xUFlTQnF3L0dldjhXd1JMUStJ?=
 =?utf-8?B?SSs3dW84U0JNNWxUOG9KRnNwdGxiUm9OcHhGT1FxR2M4RmpUTXJlVjZDZ1Zo?=
 =?utf-8?B?d1JabEVQY21pYnE4TXY4NFBEa3ZqSjJST29URk52cGxOYkgvWU1MS0h0cjdT?=
 =?utf-8?B?cjNqSlVqaVZSSlpjVDZWeDhjS2ZPTzhBbUpvZElzTytJVEY3b0ZxejVhdWVs?=
 =?utf-8?B?OUVBQlA2K3VBaHRPV3RUU3loQWk0S1ludjJUcGtGVytkZS9yT2NNUUsyY0hr?=
 =?utf-8?B?NlNlUGM2ei9heVU0MnYybysxUlN5SXBPRDl0aDhXNzlUMHdiQUU3YzVScUcx?=
 =?utf-8?B?cGhFbms5TjhIeERTNTVBL08yUjV1MUNyMDRLd2ltcEdkTWlzNEE1dEhKZXFi?=
 =?utf-8?B?VmRvU25wTTdTcm9PeUx4YUplQ2s5Y0U5aFpaOTJoZi9RREZ1RmdoT0kxMjE5?=
 =?utf-8?B?K1NZSEMrblM3cUNDYjNWbmkxejJwNStjYVpHUTh0dWp4a1VOZUJzTGlXVzFT?=
 =?utf-8?B?ZVNVTjEvbUFLdjdhQkMvbXNSZERCdWNrOTYvVzd2Z09VdDNwaHdaWmQxVkNL?=
 =?utf-8?B?dVRoZE1CQlBzVlV5bUYwbEJYYVd2a2k4eU5ueEhIdkdMbW1LdTgzZERoNEk2?=
 =?utf-8?B?UkI1S0M5OE9QZUtoZEkzUXR3VWEyZW1lWGtVSE93Vjd1YmRERW5VOUNMRlJ3?=
 =?utf-8?B?V1lBcERWdGlWUUVsV3JEMTR0ZDM3RC8xSkIxZmJMMCtSWjJsOUw3TTJKQjU4?=
 =?utf-8?B?SVNWVTV0MFFXMFEzZmU3bUdRM3dnSXM3UjVlUTQ0YTJkcHRqY0xUcTlOTWx3?=
 =?utf-8?B?TzhIN05CNHhNK1NTU00vS3dDZ2M3aGdNcEpHWGpKcFhMdHJXYzBIMmRIelhM?=
 =?utf-8?B?d3JpVTVuc0JlY2oyc3JiSmt2VzRNU0FjSkM4RUFkV0tyb0xUamYxUld3SW02?=
 =?utf-8?B?clpTY2tzRFlGWE5jTTRNamhLSzFiSFdUamUxdnNQT2hDMkpVWDVadVlyK3BC?=
 =?utf-8?B?L2RxZlpFRE0yVGFRYVM0UVZrbExpUHF1MFc5cjBHVUtBZVlUY3U4TktMRUVs?=
 =?utf-8?B?aUF1SjFTdmloM2I5UTBCWGUyZ2crQ051Y080YTcrVUYyaks5bG9nT1F6bkk0?=
 =?utf-8?B?WWlSbDB2RGFNMWlBNDFsZWRWbFFGL1U5Um52a3JyN0RtUG9ZMWlxNkZYNnJR?=
 =?utf-8?B?Qk1vL0FmbVo3ajlPY1NtTlkxampRVjUvQ0szYnBTaW9QaVQ0a2pRb0NKaXl1?=
 =?utf-8?B?bU9PdXFaTWliUzB3Q21SUzZkc040eFAyRE5xdHQ3RGs0THB3d1ZMMWx1VTQ5?=
 =?utf-8?B?ZzlSemJwRC9GZGNlT3dPS01vMlY4TU1DcWs2Mm40eHBtOG9ueFFyZHF5MXc0?=
 =?utf-8?B?ZXhWZUNzazhEVmJkR21Nck9CNzhUWTBhRlJjbFFyUUNHMzlKazNDZ0sxcnly?=
 =?utf-8?B?eDRkRzV3NVh0TENybUxmSEErNkM2NCsya1FIVG15TjNwRjBFYTFqNnZUM0tD?=
 =?utf-8?B?K2pjR3F1dHBHVi9rdVNEbytMdmNScE9kR0U1TVR0QVNXQ1JuTE52Y1BhdGVn?=
 =?utf-8?Q?CpFx9TcPDtJV8BOfPNv14qB94?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7e50ed-3ae9-44f1-b032-08dd14bb15e8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 23:26:31.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOb1dcFfzBpxo1jkUeY5hveA/RxReeDTJbqmfPUJI/oxcTkNwu+RC/oS+ijZX/1fy601NbTSf0kQltn+eYKhFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11006

Introduce the helper function pci_epf_align_inbound_addr() to adjust
addresses according to PCI BAR alignment requirements, converting addresses
into base and offset values.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change form v9 to v10
- none

change from v8 to v9
- pci_epf_align_inbound_addr(), base and off must be not NULL
- rm pci_epf_align_inbound_addr_lo_hi()

change from v7 to v8
- change name to pci_epf_align_inbound_addr()
- update comment said only need for memory, which not allocated by
pci_epf_alloc_space().

change from v6 to v7
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 44 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 8fa2797d4169a..d7a80f9c1e661 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -464,6 +464,50 @@ struct pci_epf *pci_epf_create(const char *name)
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
+/**
+ * pci_epf_align_inbound_addr() - Get base address and offset that match BAR's
+ *			  alignment requirement
+ * @epf: the EPF device
+ * @addr: the address of the memory
+ * @bar: the BAR number corresponding to map addr
+ * @base: return base address, which match BAR's alignment requirement.
+ * @off: return offset.
+ *
+ * Helper function to convert input 'addr' to base and offset, which match
+ * BAR's alignment requirement.
+ *
+ * The pci_epf_alloc_space() function already accounts for alignment. This is
+ * primarily intended for use with other memory regions not allocated by
+ * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
+ * address for a platform MSI controller.
+ */
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, u64 *base, size_t *off)
+{
+	const struct pci_epc_features *epc_features;
+	u64 align;
+
+	if (!base || !off)
+		return -EINVAL;
+
+	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features) {
+		dev_err(&epf->dev, "epc_features not implemented\n");
+		return -EOPNOTSUPP;
+	}
+
+	align = epc_features->align;
+	align = align ? align : 128;
+	if (epc_features->bar[bar].type == BAR_FIXED)
+		align = max(epc_features->bar[bar].fixed_size, align);
+
+	*base = round_down(addr, align);
+	*off = addr & (align - 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_align_inbound_addr);
+
 static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 5374e6515ffa0..2847d195433bf 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -238,6 +238,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
+
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, u64 *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);

-- 
2.34.1


