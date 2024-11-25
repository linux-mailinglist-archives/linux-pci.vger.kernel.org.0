Return-Path: <linux-pci+bounces-17292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7CC9D8CC9
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 20:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07572879F1
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 19:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228001B86CC;
	Mon, 25 Nov 2024 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cai+JDqN"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011058.outbound.protection.outlook.com [52.101.70.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B1B2F2D;
	Mon, 25 Nov 2024 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732562556; cv=fail; b=VW74cdzHvh19GWMed9pjgMhkif/L6VUihlteTJ4n9E/Eny6JEb18ZrovTx27wJR8q6MSe7WpmBcKtHE2xEFHfi3m4iCNEb/8BV99pYoC/znOdq3CFjBlpB9llNwEayPtWORZ7cgHqUpGclVFzVNJ1bKZPnI8sfzIgvSmCI9719Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732562556; c=relaxed/simple;
	bh=QOXUOOV3aoLvPwtuDWUpJ6VtiZN+nVGP8kyABxD2ShA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J0inVUEoNjYBMSZbpVz8Na5ZMtUyeqY8qGSq0WwYQC3WRucwE+23dPuIvtJGK74pYsRoNL9ACZLUf+tc9eLw4VEpO1pMABvLv8G4XfRpPf32kKa3PAlxFl01R701LM1OxNx4SJLYqAW25FQC15qGEqINmWzGzTfAitCIsaSU/yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cai+JDqN; arc=fail smtp.client-ip=52.101.70.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwtiP54KVp4tVjv1+Q+gIInHoexQjgk9HMQlW25N0HoS1p9unY+L/3INTwfSyiUikCsIRi++Eg5Q85BdIElrnCqdwIMoDe4s0ZiwZ78OKYsuyoEcbqoXgdqlAx+6J6eT+bgGYNtK/ccclKjuza7tbgGmulLmlFeGWZ2miVchNnpZqMo2wmk9uVzZoRhIJOTsB+Nx2ke+ug9slfXEqR22rg41MUwgXtWLMmEp/IJJVoJm46TG/3x6rNIR7UAZm5jY1LzFW3yp22bNDp06YnxRUKllDMYjDOUDFE7ekl8CHH8CG/WvhKcdYd9PF1S1tRMza4Y2jBU7MGJWAOsvGqQ9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DC7j3UP+cPGhE1hptxX2d9WfCyF40TUdwikAuFBESi4=;
 b=x7KtqwWPGMlF6HELMUOM7J9ZUabbi7jHtv/DTPBFSY9X4iS6juVWwhFG3U3h5dIlq6PfmThUOp6nUDa38CTU3YotrYQ0s14KasGEPd/l70npQV9vlC+kzE/wJqtP0F0VypQIxQ697ke++RNAB1gPn1PSJWPctGxbBFqzOMtbyFFTBm6ZDF+e7D3fHu67MzvagARNi+WS8CIjnm+f0TM9G71F/rmTD2lB5m6Q5ZY8bHiQ6iN2wzNC2MsEsBFh0QqRF/Ni4cyRv+EMuf4zasL2cNpVUOQ3vnBnu/qpjgYri5POj8R1Ee3ZNcvrqoafApzqeYirzJkhruL15esZBvvGAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DC7j3UP+cPGhE1hptxX2d9WfCyF40TUdwikAuFBESi4=;
 b=Cai+JDqN9CoscwUmpbcthfZvZjKBfhZC1rBE1nbLxJyPq5e64KRySATfiSdwyzeDxN2cKOuQw087YdNAWVzl/a3TYmmJQRDtuzw+uACelGA0mvLRfciCzFgEyErwdu6v9wsCymkwf3Al+3EJcIXqsyTmwTG2gIEmV4+P8DaNbzePkiCxJjCXue5a8AzOuAo3vozfIUniipZaE1Aqy2Mw4m9ffT1FH1RDRbVAA5KYYMeU6QXFKOHHbwPL/KxboDKjOMN0L2SHvTHH8UwgssLb3RV2sXI8bZVZqiJKCs0SG6kP33t3NKs5y+6gcMvedNhKH/IITuho6OjgNa3p546R2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8103.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 19:22:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 19:22:30 +0000
Date: Mon, 25 Nov 2024 14:22:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org, maz@kernel.org, tglx@linutronix.de,
	jdmason@kudzu.us
Subject: Re: [PATCH v8 3/6] PCI: endpoint: Add pci_epf_align_addr() helper
 for address alignment
Message-ID: <Z0TOb0ErwuGQwF8G@lizhi-Precision-Tower-5810>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
 <20241116-ep-msi-v8-3-6f1f68ffd1bb@nxp.com>
 <20241124073239.5yl5zsmrrcrhmibh@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241124073239.5yl5zsmrrcrhmibh@thinkpad>
X-ClientProxiedBy: PH7P221CA0070.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 80db821e-857f-4dc2-d12d-08dd0d86813f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEp4c2dDaFVjQTVTT0JJRlAya1JiWGhMMlVHSmk0b1duSjduT3E4czgwdncr?=
 =?utf-8?B?aFB3U1B2SjQ1WjVnNFNIdjlIYmx1RzhmK0lGQlJ5aWdaNW12SUZWWEJ3eTVN?=
 =?utf-8?B?S2VFcGtMMnhRZmNBQ1N3UlJhYjhlTHhScHpaazZjcElpZ3BvYittSU9Md243?=
 =?utf-8?B?T2k2NDc5b3J0c0d5b0xlT0VGSGlXWkpodThyRlpjMno1MllUc3RKcHZ6YTU5?=
 =?utf-8?B?VFJTUlpJN1ZoRGNCQk1EMWpMNlV3MFVzbk1nemY0eVBxK3RyNFN1aTZHYUp5?=
 =?utf-8?B?dFEyUm1KUlFKNkJxZGZYeXNlNzJ1VWw4emVpOEpMUk5tN2NFV2Q1NEFXdXFF?=
 =?utf-8?B?YmdLVVN6bnd6TVVNdjNXcUkwbW9sRkZXeUZwOERMbVZvN21KRC91QWlyZEVP?=
 =?utf-8?B?Sm5PYVBLajZsWlVjVU1DNWNwMmFXdXQ2TTljVFlsa1JZU1pPbzlxSjY0Y0cr?=
 =?utf-8?B?amQ1SmhRczJUeVJrUm5JRU03aEdyQU1wSUxPMnZ5RkVCOGpWeUpTSlYySnVT?=
 =?utf-8?B?TlZTb3FHV2FZOHpzbSsrUW0rb2JEa25DTEhWcmIvc3QxWnlOQURXNk1pVTc5?=
 =?utf-8?B?emdIbTdncmRtdmtpcFBoMzhsUXgvMndFdFBiVzBWdldhdGtpOUN6d3M1bVlL?=
 =?utf-8?B?cU4rcVRPbkYvY3RZNzFRUkNzT3JrVzIzQkUyNW9CS3NQc2ZPR0FpdmFWSytw?=
 =?utf-8?B?bFhoT3dlV1RxMkFHdG9GQzBBakppU0RNNjQwVmFVVDR6UDF3MFFKbE9YSmZj?=
 =?utf-8?B?c3lnMlkxN3Jjd3MrZy9LSnI4TE9oeG1VQklGQ3BYVURIZ3c2NERZZm1mWkNQ?=
 =?utf-8?B?M2EyeGhpYy9BV2NKVmg1amRFK1NyS05MZ0hlUXUzYWdWdVZjK0dOUk9yTVJP?=
 =?utf-8?B?Y05MenJNSG92ZEtIYXZNcDFlTC9NNnpaRmlZSEhSMGp6WjczcDV3M2kwVDlk?=
 =?utf-8?B?QW1pWm51VmdYaDgvMSt4aG1udmpkSzcwV3dzZ3Fzb3RyZUo2OWRjZnZZQWs3?=
 =?utf-8?B?c29OUms0Wk8wYjczUnVVV2JCZ0pFcGpPc2RwdmNKY3M4ang5QUM1czVUQU5Y?=
 =?utf-8?B?SUVKZFMrUmFYQUdvOElYdEkvRWs3ZVhxTVVSaHdQL21zZisvY29yZ1NJV0Ji?=
 =?utf-8?B?N09RM2xhZ0xMbmxUeUs0OUptVG04NDZUd20wU3F5eXFkT25nUTVnVUZ6dEU5?=
 =?utf-8?B?bkVLR3d3WDg0L2tQQWtFcHUyMWNsSHpyWGtXQmF5TkpkNHZXM0JlMmJveUdQ?=
 =?utf-8?B?Wm93OFRBY0RjUFpFRWhPVE9wVStUR3dwMEtTSUtqZmFqMmlOT3Y3VitVVk5J?=
 =?utf-8?B?dEgwTE5wb1l4UjBWanBaTlZSbktBdnA4bFRXWjM1VFVRUzJURmlEc2VFc2l2?=
 =?utf-8?B?NEhadU1GeEc5bFhZYWJLelFNTDBIMm1pZTFONXJjTHRCcWU3d1hHN0s2TzNz?=
 =?utf-8?B?blBtQ3BFWHNuM25pSjhtQTRIUk9JcW8zRUxnekZhVTZ2NHlsdGFGeUk3bTJv?=
 =?utf-8?B?U3d0SFlSR0ZZTTQyR01oOWM5SW5ZUy9sVStCWmtxUjJ1aDgxWStzcmRDdk9q?=
 =?utf-8?B?TmozZHVhcWY1N3JCWGxrRTZhdFVhOVYxTUxDVHhUbk9wNUtDRW1CYUNGaFl1?=
 =?utf-8?B?TSt4QlRkR0NTVElGd3ZzZFh0ak5nbEYwcG96MGhXRVFVODR3czJRa25jUDhY?=
 =?utf-8?B?bS9ZR2k5RWI3RmhyVHhDMDhIekNwZmhKR3BMdTNKZXQycHhJM0VBT3k3QjhM?=
 =?utf-8?B?NERuclNUT0RIejJTOVh4Y1EwelJhSnNod2tXaFRQNXc3RnpqR1dxYURMdkJI?=
 =?utf-8?B?U1phdFVmSWZDa0pLYURkd200QUtkOGxpSWNKVHNaR0ZrWGpCUUV0a3RyV1hK?=
 =?utf-8?B?Y0Rha1lXaSs3U1NLbm1ua2w3a290WUJzcGp5bVREWSs2M3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFgzMjFZWHZzOVptMkhrd0ZoaTBnNVFUOEw0akJOZzFHVkI1aHFMeXkrMG9z?=
 =?utf-8?B?ZGtNMWc4NmZUYlUvWmVHZTk2R04wUCtmOXc5RXVkdXpGdGo2aExCUzFmZHBh?=
 =?utf-8?B?c2tLbi82Nzl1NEl0V3JMQW1waGN1RUdCQlJGVTIxdGJiUTd5TlhnR01mUHl3?=
 =?utf-8?B?UUFiMmpJTFc0U2t3S0NVc0JxM0pUdytzMU5JbFVXZ09kSGZZOGpqU2Q5WThI?=
 =?utf-8?B?MXlkazV0aGQ3UGQyS2RvTFJLcUZnWnp5elh0U21vYzBYN3IrSmdzUDB1WDht?=
 =?utf-8?B?bFNXQUJWMERBaWpGamtONFFleG0yUGcxUTJ2azBIZ2Nwb1NuZW1NVEtBb0xh?=
 =?utf-8?B?a3kvYm1JUEhWcWVDem1lSkFTU1VvdlRUcjNDM2oyMzBFODNCbC90VU5GQk93?=
 =?utf-8?B?L004MlRtM1JYc3Q3TW9LZVNtQ0ViMmpjVXpXSENhek5JbnpLL3NpbUFGM1Ez?=
 =?utf-8?B?dEZYUnVPYWRHdW9HbTV4Y0RMbXYrM3NzeklJWUJzNXNFZ3ZZeFE0M1ArTWFD?=
 =?utf-8?B?SE5mVlUzSXRJV2RGQU1ZbWI5SFVGbWFCRUlweXY0L3Z1SzEzU0J3VnRqdGRk?=
 =?utf-8?B?amNVYVFNaVhEUi93TDVPS1RQeU1FN3ZpMjBrazA0L0RqUktnSnFxRDMvZFA1?=
 =?utf-8?B?UWpYWitQV3NKL1Y3dHR4cHRMTVR1U2dzTXF5cUJyYTRIVW9LUkJLcWJxcVBN?=
 =?utf-8?B?Z2R0NHlpS0hqRStjemlNR21YTE0xRGJuQlJUN2dxcEJpcUlyOEhzdVdUcUZU?=
 =?utf-8?B?VGptdVhLRG8xRm1qSDd3UlBOemJDY0JJZTR4eFI3R1VINU56Nk5pTEhhVGpm?=
 =?utf-8?B?NWZUYVBVRzl0UVlYT2NMNWlhR0hoSkhhSHFjYjVYODZueE9pZGtuMEo2TEFa?=
 =?utf-8?B?cHltYzA2eXlPdTRtdjVpZEpSbDZtVVVpbWI2RVRMVUNKckdYSDBPczZnMUNp?=
 =?utf-8?B?dE1hNEZGaTZLRVRJZWVBZlN3UWRaN056cEJ1V0RIRmhVSlBlYXlWUGNzdUlJ?=
 =?utf-8?B?ZGh4SDlnME5wMHhaNmIycHVKZnFzZGxhTHBDR3RJUG51VE5RaVJFYTcxcVp0?=
 =?utf-8?B?aXJ4T3lBU3BrRHovcWNxazZlV3VrR3RIOXRMNDJnTWRGc3dtWHdGNkxCUWIz?=
 =?utf-8?B?QmdrWldpb3lyamxuaHlESHFycUxpRHBxd3NnaGxwbVl1eklpQXpnOTZUcW14?=
 =?utf-8?B?eTcyejBHYkFjRU9KRGdOdTBKUUdiTjhpcW9TSXh4T2xMWUNNbXBtNUtEWHA3?=
 =?utf-8?B?My9GY29sZkFBbG84SStnRkJ4cWVYNHVOSDh5bjBHckFxaG55eWxySzUwUFFM?=
 =?utf-8?B?TnFKakM0cXhUQ1V3SFE3a283ME1FYlJJcmhQSmVXZXdzWVNUNWdiRVZIcjR4?=
 =?utf-8?B?SzQ1Q3ZHWTlTekpKdWkyWlpoWG9EdHpJTCs4cm93b1pXNnhrOFI2a2pFVUFz?=
 =?utf-8?B?T2s3cC8vZ1Z0V2hWU3FsaHdrSU5wS3V5NEJQLyt3VEJPc0pkZDNyeGpTekR3?=
 =?utf-8?B?aTNZTXpVNUcrd3QwRGhFWjZkaEtPUTQwVjF5N0ZreXlOTlpwQng5NmdKcllo?=
 =?utf-8?B?cC94cmFzUldJamdSN2I0R3lHUklpeFM0aW9NTmdtVkF1dUtPeWZobDYvYi96?=
 =?utf-8?B?OFV5Vk5FZzY2TlhIQlJ4c2x3TGphM0xCWndaa2p1VzRPTlN2M0dGaE5ocW92?=
 =?utf-8?B?ZUYvUnBmRXMvQUg5ME04RUhjSWhGTmVqb0QyT1NIVi81QXhZcXREbnNxZFRE?=
 =?utf-8?B?MVlyMmZaRWZLU0ljejB6Qzhyd0N0VGozRHhzbWhKVkdabElZZTF6R3pTdy9T?=
 =?utf-8?B?Q0ZLczhLMkcwTmpMYlFPSlFyTFBJejdUSU9qSkR2Wi9odHdNV1ZCYjlSU3F0?=
 =?utf-8?B?Vk9zckswcDRQcE0vQ0NYZ3BGaktLSUJ6MVVud3ViaWkxRUtGei94NUpxQ1BS?=
 =?utf-8?B?c1VaMWUwR0k4V3ZFL2VLYlpIci8wOHFNZE9FUEZpWGZSdVBnbXNyc0FZTGR5?=
 =?utf-8?B?MzE5cmEzdGFvN21FN3R4K21Vb0Y3K1RBbWRndzV3RW9ySmJxZk54U0tOVGNu?=
 =?utf-8?B?TnUzaFdpYXJaM25Va2ZnaTdUc1p6dFUvQzBtVytoS2VzL1V5SkQ2MkFiYTJU?=
 =?utf-8?Q?uH8Th8M2Xidd4pj/0v7gcV3Nh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80db821e-857f-4dc2-d12d-08dd0d86813f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 19:22:30.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXezno+8Ch8Al2QSNITJABynmrqheXfCTp//2vfPVBCgXSq7lhg7PlIQo0IToy0xkYLtj6yje17V39Hd+MkATA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8103

On Sun, Nov 24, 2024 at 01:02:39PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Nov 16, 2024 at 09:40:43AM -0500, Frank Li wrote:
> > Introduce the helper function pci_epf_align_addr() to adjust addresses
>
> pci_epf_align_inbound_addr()?
>
> > according to PCI BAR alignment requirements, converting addresses into base
> > and offset values.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change from v7 to v8
> > - change name to pci_epf_align_inbound_addr()
> > - update comment said only need for memory, which not allocated by
> > pci_epf_alloc_space().
> >
> > change from v6 to v7
> > - new patch
> > ---
> >  drivers/pci/endpoint/pci-epf-core.c | 45 +++++++++++++++++++++++++++++++++++++
> >  include/linux/pci-epf.h             | 14 ++++++++++++
> >  2 files changed, 59 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > index 8fa2797d4169a..4dfc218ebe20b 100644
> > --- a/drivers/pci/endpoint/pci-epf-core.c
> > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > @@ -464,6 +464,51 @@ struct pci_epf *pci_epf_create(const char *name)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epf_create);
> >
> > +/**
> > + * pci_epf_align_inbound_addr() - Get base address and offset that match bar's
>
> BAR's
>
> > + *			  alignment requirement
> > + * @epf: the EPF device
> > + * @addr: the address of the memory
> > + * @bar: the BAR number corresponding to map addr
> > + * @base: return base address, which match BAR's alignment requirement, nothing
> > + *	  return if NULL
>
> Below, you are updating 'base' only if it is not NULL. Why would anyone call
> this API with 'base' and 'offset' set to NULL?

Some time, they may just want one of two.

>
> > + * @off: return offset, nothing return if NULL
> > + *
> > + * Helper function to convert input 'addr' to base and offset, which match
> > + * BAR's alignment requirement.
> > + *
> > + * The pci_epf_alloc_space() function already accounts for alignment. This is
> > + * primarily intended for use with other memory regions not allocated by
> > + * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
> > + * address for a platform MSI controller.
> > + */
> > +int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
> > +			       u64 addr, u64 *base, size_t *off)
> > +{
> > +	const struct pci_epc_features *epc_features;
> > +	u64 align;
> > +
> > +	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
> > +	if (!epc_features) {
> > +		dev_err(&epf->dev, "epc_features not implemented\n");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	align = epc_features->align;
> > +	align = align ? align : 128;
> > +	if (epc_features->bar[bar].type == BAR_FIXED)
> > +		align = max(epc_features->bar[bar].fixed_size, align);
> > +
> > +	if (base)
> > +		*base = round_down(addr, align);
> > +
> > +	if (off)
> > +		*off = addr & (align - 1);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epf_align_inbound_addr);
> > +
> >  static void pci_epf_dev_release(struct device *dev)
> >  {
> >  	struct pci_epf *epf = to_pci_epf(dev);
> > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > index 5374e6515ffa0..eff73ccb5e702 100644
> > --- a/include/linux/pci-epf.h
> > +++ b/include/linux/pci-epf.h
> > @@ -238,6 +238,20 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> >  			  enum pci_epc_interface_type type);
> >  void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
> >  			enum pci_epc_interface_type type);
> > +
> > +int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
> > +			       u64 addr, u64 *base, size_t *off);
> > +static inline int pci_epf_align_inbound_addr_lo_hi(struct pci_epf *epf, enum pci_barno bar,
> > +						   u32 low, u32 high, u64 *base, size_t *off)
>
> Why can't you just use pci_epf_align_inbound_addr() directly? Or the caller
> could pass u64 address directly.


msi message sperate low32 and high32.  (h << 32 | low) is quite easy to
cause build warning.  it should be ((u64) h << 32) | low. Avoid copy this
logic code at many EPF places.

Frank

>
> - Mani
>
> > +{
> > +	u64 addr = high;
> > +
> > +	addr <<= 32;
> > +	addr |= low;
> > +
> > +	return pci_epf_align_inbound_addr(epf, bar, addr, base, off);
> > +}
> > +
> >  int pci_epf_bind(struct pci_epf *epf);
> >  void pci_epf_unbind(struct pci_epf *epf);
> >  int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
> >
> > --
> > 2.34.1
> >
>
> --
> மணிவண்ணன் சதாசிவம்

