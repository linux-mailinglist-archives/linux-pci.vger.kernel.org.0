Return-Path: <linux-pci+bounces-20063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B56F9A1532A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 16:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D551E1674F3
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F04E19992E;
	Fri, 17 Jan 2025 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="epIIGPjx"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD728189F3F;
	Fri, 17 Jan 2025 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129041; cv=fail; b=P+w1gBjM0jk/R01XzCyeRKpEuTXN6zUUiSdDlM/kidIdzdfUUEOON56o4YBnhHkwwC2Ksiuad4cBbFHGsB8t7k45LVtn0FvCF1DjYOoSBD+tIzxX7lE6e4PF8s5+R+a6qrLtBK2XLJ3rxDEzkzNWN/IOrBDKoogMk8jPVgtdGvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129041; c=relaxed/simple;
	bh=/BiGbVRF/fgnu+rU5Nvuq1MVrOgJKAQTNE8gyLm15A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iKyuaprghizqy5EMbPMgCunLjCkHafaVDVich3iUgPZln3Fvhd6onkCmWVdTJJ7tDnNydSQb60BeIRvZsAz7dWNkowKJt0wkllX78Gf6BgLkaHq4YKsXK9UOma4oeYiVtywBdmYvwYRg9dKHF/IiqQ/XGwkzjRQltl/NSZVaZUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=epIIGPjx; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZBNWjc6gdaF4ZSYK8Mx+igCQxct2oJnvQHjIejDEww5aEb9hvrSGZhlnXrbi1T3YAQI0XSpkD3Pi+oQdXXTuGIdcTjbpRzU1/i2Lu03F7e6bLuOelyDf3KIb/T+KiqXA1CQnRToTAoyd8hiRsII3PK7FNluSjrWKUpOJsedQF324qDMK4Q/wzfnHWpWcpttB6fPL6XjaUSjjV1FTcABPi/9qo8WXP51tDnz87BOI1QM/oJU2AqC87EqkZdrVRUtuR+CVtedtiAcUYqw22U/nB0oUnyKMWDJGANJ/gGvI18Y7mIPHAvwxINfgK5vcmI8/5L79G/tDbkN17MIR3C4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/lM8znxHXOlY6wJyzONddSNEi/Vo1JstekSz+pVaJs=;
 b=oPsfJOjZcDuiIvJiL+UFbADV1P5r8fGGyQKzP4FxI5gmuEYzeX022SuHpfOTg1aRWrAcy+ejoURjMDdR7ZmQkiGInjzWK9C0RaAhuff6eENz6PL+fDSVLhTA4gLad9nviS0g7UGSXFEkgEyOdhIisWlbbWNGF9a0EcAMi3JLsCfAz/fI2NpuBP8+bnrW9v2SzXJbuCsg6GnfRIxs18pDux/ChDexJtEnyyw846Ji5rUmcIxljeXVi6B2A2SyyLJE6AgqZreFIBx7uvDVrLdjSA8DbxwkX45mW3XmJmrpGw/QPTYQNGc57F2t1pb6NyHCCD64bxejdrCIsLIZ0aM1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/lM8znxHXOlY6wJyzONddSNEi/Vo1JstekSz+pVaJs=;
 b=epIIGPjxr7DLw5vDqf7fHYKqv6YeDrEsJVc/+r86VKqkVwNYu+AFaEhsqUQirnL3YRaZXfiLM9+fNrg/MPN5diyVVxV5D0nqaPO+TdcL+6Z+sCQF4iPwN3BWv0GsG0xHka7PyZ5sKkuo/u0daRos4Qqt8i6nRiLLtzObhzqiSSQViYbuk4AG2UnpQXEWQktDEaw2nXOFInRx/1HTj79L+InAkusKBtoSdkCKdu+Oq9mAYBblldV4y/WsDS57lh/NunD1Ykp0BCkAJrSM6BKukQaRNjDoQdM1znIDYgnIxlSzXnA7u1/o0fdBd8jQ/fUeD9C0ZX+nees325MTmds4lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 15:50:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 15:50:36 +0000
Date: Fri, 17 Jan 2025 10:50:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v8 2/7] PCI: dwc: Use devicetree 'ranges' property to get
 rid of cpu_addr_fixup() callback
Message-ID: <Z4p8QqvWPOhab/XQ@lizhi-Precision-Tower-5810>
References: <20241119-pci_fixup_addr-v8-2-c4bfa5193288@nxp.com>
 <20250116231358.GA616783@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250116231358.GA616783@bhelgaas>
X-ClientProxiedBy: SJ0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: d0989532-4621-49fc-250d-08dd370eaeda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVhPdExUMllldXNjN0FhRDE4Zlk3VjZGOWE0ODgzVWpPMXJLcEtPZDAyMmtm?=
 =?utf-8?B?eTFtRjRvdlE2cHJYT3lXVnFCMHpWcW51RzJVcjhpcFBhYzNya3BLeEJvbVJn?=
 =?utf-8?B?d0JhTEx4OUY1SWhDdlVGdFo4WWdRVHoyNlBwTDFpcTZ4dzljUDBMT0IvNkVm?=
 =?utf-8?B?RU91dERPd29hOXdoYjFCdEgrT3NTV3FmbTdUckdRb0F6VFVRM24xU0RFQmlD?=
 =?utf-8?B?clh3bkROVnMwMDVpN3hoeTcyRlROL1NJc2wrVmt3ekczL05kQ0NUUFhUcHN5?=
 =?utf-8?B?VDhsZURYVWlIYm14eWQ5U0hoalFkNlF2aVl3eVZNK1pNdzdUNXMxQ1hIa3FZ?=
 =?utf-8?B?L0ZsY0NkRVdWYms4a3U3alUyZGNWL1pPaEpZNXlkWjlGQ0o4S2tleW1maUJP?=
 =?utf-8?B?VWVqaTRmVzZlREphMWF1MVUxZzd3MzRuRWtjRXJWWnJiRWVaYWt5UEFDR1ND?=
 =?utf-8?B?bCswRGtKTlpRaXAyQjkrQW02My9DSTZJSmZ5QjhEOXhFZ3BNV21Gd2FBbjZp?=
 =?utf-8?B?ZHpNSGRqaEJlMlJ2ZkJlUDZ4ZVh6dlhDbC9HYU10aU9DczFqUkw4QlY2d081?=
 =?utf-8?B?WUtGRktrcWMveUZWZHEzMXRhTEhpWWllb1pLZlJBMG5IVngvYlExTzNndWdW?=
 =?utf-8?B?Y1h4dGxCU0w0T0pFbitpOFBST2xSa3lqV2w5YWVFNVU1UEVUYXVPMTZyRnlL?=
 =?utf-8?B?UEE5REoyekM2Ykh4Y1pEV1VMZ2RlVnVTMWxYS1NrcGNna1lmOWV5T1lXN2lw?=
 =?utf-8?B?MnlQOUsrSG1zYWtkOVRONlJGa09LOGtRUnBUU2J3WUsyNTN1dEtBK3l3b3h5?=
 =?utf-8?B?cDdkYlZMR2tNU3plM3dqWEIrL0kwYWduaTlodmgzQzZML1RML2M2bXhmVElj?=
 =?utf-8?B?N1JGK2VlQlZwb1A0SGJWMmFqTHkrbHlsRXRpMGJ0eU0zWmdaOGZmb0V3cnZl?=
 =?utf-8?B?Znp4cjl5YUk4Vk1wOFFKVHQwbWVkVFZ1eFJqT09PR29saXhKQWxMdjlDVlZP?=
 =?utf-8?B?VFIwZnlUajRTL2x5MWNRc2txanJrejBqcmN1bG5IWkF4YVpVTWJhQWE4clBs?=
 =?utf-8?B?bXRWZkRFLzl0SzN2dHBuelRPdEJ2UTlOeHdHMHUzNlNxMEttWlM3Wk0za2tZ?=
 =?utf-8?B?VUVvaTYvaXVOazBPV2xIdzZDMVJCNjViMVB3VnRQQ3pIRWM3TTUyaXQ4YnZZ?=
 =?utf-8?B?ZktoOEJtcFNiT01VM3lOeXNBbWd5SWdmcHl6UllEOEtvUjhWRm9GRFQ1MVM4?=
 =?utf-8?B?enpESlRzb0x0YURZb3dJaXlLSFE1TnZNYmQ3SWZqV1BEWGpGOVlsc1NUTEgr?=
 =?utf-8?B?amtobmxxTEY2azk1TUZnd0FDbkkrcHZQN21ZT1l3aGw1c1ZkVTRZbjZSN0Vr?=
 =?utf-8?B?SnJ2NUpFc3NHeHpWTVJncCtMdTNLOHcwZ3pxUEcvZis4cGVMYjNTdkpvRVpo?=
 =?utf-8?B?TjdFcDFTUHpqc1NRYk9rSGVBWjQwRjMveXBIL0FuNDVoZnJUK0Q1RmgyVEVQ?=
 =?utf-8?B?R3J6M25nTCtUZUZjVlk4Uk9iaFNobXA2MkYzTDIvVGoyTEJZeU43eTFXOHNa?=
 =?utf-8?B?SmVOb1B4dDhsNldCNTZ2TDFTVGg1M21nOHpINkwySWFxekNkSnNuS0VrMnNJ?=
 =?utf-8?B?S29RTkdqcW13K1pzUWR5YjBOZ0JnUFRVYXhyU2UwSUp0N1VlRGx3QTZ3Y0lu?=
 =?utf-8?B?QjRQQy9Ha3YwUWFIQ3dDdFB6SktBbmRUT2JycmtKSjBpZ2c2Tmp4RGRrVUg3?=
 =?utf-8?B?ZkJVd2tkN3F0ck1Fd3lzY2V5UXRSQ25VZ1NORWtVeXRaNXg0d2tVMHMyMVk2?=
 =?utf-8?B?L1dZamZWOUkvUEhDNjFVOXpQWE00UlFmdFAyc2doL2tsdzhuMkZWVWtyVi95?=
 =?utf-8?B?MU9ETkE2Mi9PcSs3VlpCYTErdStEVGFCMkgxVmFNS0FrVXU4eFlDalBKV3dL?=
 =?utf-8?Q?se2701OhvO633YT7EvdwLP9P4Dg7KinH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bERhbVBCRk5WM3o4WWREbXZjOUpyU25FMjQwZzlJRU1qR0tRVFgvSUxUUHpk?=
 =?utf-8?B?N1Rubmo0SmkzT05SbG40UG82SVE0Q2ZYYS9jOER4YzZDb3VhdngrZ2ZXeXA3?=
 =?utf-8?B?dyszYjgvSnp3M3JlRUNrdGRiMzVrZkpYVFAxM013aERsbW5FODFNR0ZwMStm?=
 =?utf-8?B?VTRzb0dQM08welhQdkFUYXk3ZlJxQW5CYzV4c3pLM0NSSmF2WmtvZkFPQzl0?=
 =?utf-8?B?R1RURDJDSjNmVUNaMG80alBBeFoyOVQyMXZqeUh1dnZycjlUNnFxZURtakxZ?=
 =?utf-8?B?WFAzVXBwaURGUnZqMmhEai9MdGlaMnVPRHI1ZlRXY3hjQzl1VUF2TzVqTHI3?=
 =?utf-8?B?c0RqRGkyVkJ1d3ZodEFnbTVoSnc0NWVsVjlVbitEUEJqQXZCemIxc0EzbHBl?=
 =?utf-8?B?YkQvcXRVVzdkNDlMaytjVkVmVW5oY3hzd0NUaFRBcXpOZTZ4SGVQa3c3NnQ0?=
 =?utf-8?B?dTVOaDJvanQyYy9hVnlScy9kTzM0YWVEcC9jLzA2aXlxSExVb0diN2N6WGFt?=
 =?utf-8?B?UTZpQVhQdHR2NGRmNTdDNkd5ODJoZi9qQmV3Q1dIOEx6aE1kMzI3MVdHMk5Q?=
 =?utf-8?B?Wm5iOG1DcjZyZHpwRHZxaDVYZ3grZHV5OGUvS0k0MEd0Y1RyUmpYdlhpVXUy?=
 =?utf-8?B?WEk3emQzRzZ4N011cU9RZmlXd0VKTStWT3pPSG9oRlhNd1d1Vk5OejBrYjNH?=
 =?utf-8?B?dUxRUTZkbWJtZGJ0SEd2OXd5czFQajlBSEgvKzQzdC9HaWlVK0ozQmNsVnhi?=
 =?utf-8?B?QnFQdGFsR1dXUzVkRHFPdUlxdTZLUXpKdDBVNjUrMWthWFVSdnNZK2ZmY2JD?=
 =?utf-8?B?THo4bmM2MnlaSEJTZjFXdGl1WVRXOXJUS0piekp2Vzh6NkhkdVdETG10My9m?=
 =?utf-8?B?NVZFQzE4NlExT3MydlZiVzVMMDYzMkpsQ2dPU0RKaGh6T3VvaFdhWFhGNnl3?=
 =?utf-8?B?SEZNTnMwem1FalFUbEJmd1Vvb3dVZkxvRm5EbWxvNmFhWFVqdG5zdktQbXhM?=
 =?utf-8?B?YjQ1dEtqUkFVV21vVkJSVHplZnY2MEwwamdsVzNNNFdYVmNYTzZtTDBMelcv?=
 =?utf-8?B?bWZNdWkvTC9wbnpsMWNINEJnOU1UdDBLSzllVzJ3ZGFmdXBIcmNRazZEcTM0?=
 =?utf-8?B?R253Q1JUaWg3VzBhRUN4T2lhNlVsZFZsY29UR1NnUVZEa0RHcjgwbmdjNUVK?=
 =?utf-8?B?VUQ1WlcrcWk3UFllSzVBVXZ5bzF5WXNRWm0vajRUczZhZDQ1eGRuOEVKVDZJ?=
 =?utf-8?B?R0hiYnVLaXowb2tCbU5xT2RDclhhWk44SC9XbHV3V0J6RHJlN1FUV2FVUjFN?=
 =?utf-8?B?UmpEeFd4N1pQTGpQYS9NdFlxb0lRdEd2TEVINTdWVWphOXBEWmpBQWZiMmRK?=
 =?utf-8?B?RXlFbm9peU5TVG1Wc0pmN1hxYWZNOGRQNDVVbTFjdzVXZXpEMzJIdDZlK3Fo?=
 =?utf-8?B?T0NHR2NjRlFXdnE0bnpBK3JKNlE4MEJQbHJSYlpPaFRWUUw5cVNycHEvZXVK?=
 =?utf-8?B?eFlhRm00d2FHZS83UnRiQ0lUREhoRmNWa1p6OEwvSHRXOVdoc3NLR3RDSW5K?=
 =?utf-8?B?dlBzWmNod0xvR2hwbmhyTVFuS3JRbDdBOW91SFlwd0NJd1VReE1XQW45cGtt?=
 =?utf-8?B?ZGg5L09teVY4RDBFc1lBaG1lcXVDNFBWbWhIdjgwUm45SXJMTXFqYm1uY2hh?=
 =?utf-8?B?eXZpM2FLTWFQNnVkYytkN0lWa0RTZzVsYkZDSW5kbDV5RDFqaitJaXNkOXp2?=
 =?utf-8?B?c0dnSnpzcjV3cTdZb1Z5Ukp4OEN2SXJVcnRKenhlcDNNNFNUVUdMTC8xQjll?=
 =?utf-8?B?TzhlT0UrMDlxeERwQmZrc25RVVNBYm1uVFhid085blJieDZyZEE4Ty9pMmo1?=
 =?utf-8?B?eHIrOGZ4Y08reGlPa0JVa2lPOHVhMkl0UC9oZ2dDckR6emdtWkJyOXovaW9r?=
 =?utf-8?B?Y2kvWUZ6RXRQM2pMbEtKdTdRaGowSGlqTDRLd0s5V0FyWmtNNkFkV3QyeG1L?=
 =?utf-8?B?QzB0ZXVSZVozTnY0bCtuR3BWemFRSzA3cHova1NVWlJ6R1dHbDZjMmJJSFNX?=
 =?utf-8?B?TjE2VDFUSisrQXFvMUsxWVplQnMvbGU4VkFuNXlwRmJ0c3VmQkN5L3NBZUxR?=
 =?utf-8?Q?ecHXSUF6h6Yu/iZsXlYdH8zsU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0989532-4621-49fc-250d-08dd370eaeda
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 15:50:36.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66cN1LDjyZZ2P7HN//MvLRyLef9ENif+gjJf6FXm1fXTLlr5wgmk2borFLEiakylIT6BrhqTrn4GHK6RYHY0AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

On Thu, Jan 16, 2025 at 05:13:58PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 19, 2024 at 02:44:20PM -0500, Frank Li wrote:
> > parent_bus_addr in struct of_range can indicate address information just
> > ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> > input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> > map. See below diagram:
> >
> >             ┌─────────┐                    ┌────────────┐
> >  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
> >  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
> >  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
> >   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> > 0x7ff8_0000─┼───┘  │  │             │   │  │            │
> >             │      │  │             │   │  │            │   PCI Addr
> > 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
> >             │         │             │      │            │    0
> > 0x7000_0000─┼────────►├─────────┐   │      │            │
> >             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
> >              BUS Fabric         │          │            │    0
> >                                 │          │            │
> >                                 └──────────► MemSpace  ─┼────────────►
> >                         IA: 0x8000_0000    │            │  0x8000_0000
> >                                            └────────────┘
> >
> > bus@5f000000 {
> > 	compatible = "simple-bus";
> > 	#address-cells = <1>;
> > 	#size-cells = <1>;
> > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> >
> > 	pcie@5f010000 {
> > 		compatible = "fsl,imx8q-pcie";
> > 		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> > 		reg-names = "dbi", "config";
> > 		#address-cells = <3>;
> > 		#size-cells = <2>;
> > 		device_type = "pci";
> > 		bus-range = <0x00 0xff>;
> > 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> > 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> > 	...
> > 	};
> > };
> >
> > Term internal address (IA) here means the address just before PCIe
> > controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
> > be removed.
>
> > @@ -730,9 +779,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >
> >  		atu.index = i;
> >  		atu.type = PCIE_ATU_TYPE_MEM;
> > -		atu.cpu_addr = entry->res->start;
> > +		parent_bus_addr = entry->res->start;
> >  		atu.pci_addr = entry->res->start - entry->offset;
> >
> > +		ret = dw_pcie_get_parent_addr(pci, entry->res->start, &parent_bus_addr);
> > +		if (ret)
> > +			return ret;
> > +
> > +		atu.cpu_addr = parent_bus_addr;
>
> Here you set atu.cpu_addr to the intermediate bus address instead
> of the CPU physical address before calling
> dw_pcie_prog_outbound_atu().
>
> But what about other callers of dw_pcie_prog_outbound_atu()?  Don't
> all of them need to use the intermediate bus address?

EP side change in follow patches. RC side only here call
dw_pcie_prog_outbound_atu()

>
> Maybe struct dw_pcie_ob_atu_cfg.cpu_addr should be renamed since it is
> not necessarily a CPU physical address?

Yes, we can improve it later.

>
> > +	if (pci->ops && pci->ops->cpu_addr_fixup) {
> > +		/*
> > +		 * If the parent 'ranges' property in DT correctly describes
> > +		 * the address translation, cpu_addr_fixup() callback is not
> > +		 * needed.
> > +		 */
> > +		dev_warn_once(pci->dev, "cpu_addr_fixup() usage detected. Please fix DT!\n");
> > +	}
>
> I kinda wish this warning were in a separate patch because it will be
> a little cleaner if we ever want to revert or remove the warning.

I don't think it is possible to only revert one print warning patch in
future. I think only two path: one revert whole solution, the other is fix
all dts and remove whole cpu_addr_fixup.

Frank

