Return-Path: <linux-pci+bounces-22433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362E1A45EE9
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 13:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856B31884B1E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 12:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEB821C160;
	Wed, 26 Feb 2025 12:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HUCrkptn"
X-Original-To: linux-pci@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01olkn2051.outbound.protection.outlook.com [40.92.53.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBB921E097;
	Wed, 26 Feb 2025 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.53.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572439; cv=fail; b=r4D7ICwoCUuV+D0qNuSX/25h/tSom8iS1NldjmO/+75Ih8yryPMKgPPMXgkALUGr1pZvlTDX6tGh4LQ+tqD/TrLm39h2mpGfn0wWd8eb7ZudWvYu6+9UeB/AhThZc687OLkzrWXNMmj1ugTw9BlMYXTKtuZ46GnEKdn927hyhzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572439; c=relaxed/simple;
	bh=0YP27jwv4+GI5s9tBOfa5G7u7gzG6cFeAt76HnWauTg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NQws6tqwsl9O0asH2TrpFbGqglzEHRZ+89bew3WrcuxPfcdzUFKEv+ku9HGOmKT7OaLositqA/j7ZJVGElRkaJap3qdrfIrRNboIIwleP3ltF7bCNKTnNQtAE+N//GjXBBDi/Xg2gbWBPw/e83D5i7WlzrdX9pdYpPl/f+vR+vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HUCrkptn; arc=fail smtp.client-ip=40.92.53.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJFIcaX3Xj/iZjUTgPIeU9Ef/UiTQ/2+fDsnk1Ogsz9QKgwbcigiuEXzSmBVkBYk0y2pGHioxVC3Vt6r+m3rr6HG9GThcne90ly7H/2AnmnCy1GzQFIdLh8+7BprPsygHqk3/lCVYRAi3uRslzBELI8jy6hJPHoWW1DhqLNY1my8rMyD6pdzkWcmMeUxiBxW4kKOou4RrpuzrR7vuxMrOotds8qONbEdHqRD6bhn0Af0PY7pdkGiBqt0H1t63dyhdRe4TL4pwVjNsSggZwcr8V5Bpir6ZXni1uCtrg70gs4rCYXItt6wNvTJdji9N0PKeumKU87UQF7RY4cpwkNd0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZ1MmjNm+FJaK/HoGxo+7DfSD9fcnJ3Y2/pOwZ/JU2w=;
 b=CJMy8RxGPzzj2W/59QD9rYySThAg2avBEERQhQd1ZTKJ3r53LlTxkZDbVCVvd5lBe3ynYa1erbKUpgeHecKL2NJRjEsTzy5cFfdXJuuSbIcymUwRK/Yxy0D2rn7+E4MB0U7lsBZ4vbkwfUoUX3RumogNWvheESflHr7FSdcPxIa13WCs5R3fQnHzcxV6VsvkoRBuC1P7m8NMkFwlhPLLFGAXlMeCzt+ETfFTZLHlT8agwLDtotVrZZy3GD7dUTw+3AunLtta0SVSbb5QTBBw41gpUOW/IXqBDDoVNb/+MeUuGO7QiDttI1JG5nevDN4f1hgIam3Q1yAax+0EZqxSlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ1MmjNm+FJaK/HoGxo+7DfSD9fcnJ3Y2/pOwZ/JU2w=;
 b=HUCrkptnQqtwdZMIR0+Jj+IaW5NanXa5CjtNFFfdcxq0XjZYsz6DxjkzKkPESAwA0c07m2gRfSA6w4T+RIn1daCR0AUp6vs+xHzsm+S0lQaR940C1J9bZbzEvw4OjR4sQvp/zyh1a2+TDLVpdCA4iTVXmd5PKamCFM8eFl/Z1IEEQRK433belEPnIY1dVE3vfvMXsU1s8ZtJKH5vYbAJt1oNcYCcvR8NBpnSUm/zEr4PniV8v70JSO9e2dTbNC6le00ShSdgUIi4jkbj1Ud0DTETqnsslgracXTEBwXkfJKreMl70d2MVQWvnU+YpDgSoQUXL7db0WMzbVjV7Wifsw==
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 12:20:32 +0000
Received: from SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf]) by SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 ([fe80::653b:3492:9140:d2bf%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 12:20:32 +0000
Message-ID:
 <SEZPR01MB452764342165B17819AAF554A8C22@SEZPR01MB4527.apcprd01.prod.exchangelabs.com>
Date: Wed, 26 Feb 2025 20:20:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] PCI: Fix the issue of failed speed limit lifting
To: Jiwei Sun <sjiwei@163.com>, macro@orcam.me.uk,
 ilpo.jarvinen@linux.intel.com, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 helgaas@kernel.org, lukas@wunner.de, ahuang12@lenovo.com,
 sunjw10@lenovo.com, jiwei.sun.bj@qq.com
References: <20250123055155.22648-1-sjiwei@163.com>
Content-Language: en-US
From: Jiwei Sun <sunjw10@outlook.com>
In-Reply-To: <20250123055155.22648-1-sjiwei@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::11) To SEZPR01MB4527.apcprd01.prod.exchangelabs.com
 (2603:1096:101:76::5)
X-Microsoft-Original-Message-ID:
 <9d6440de-1909-4629-9798-1965b0799efe@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR01MB4527:EE_|SEZPR01MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4a47ba-efad-4b08-bc22-08dd565ff6e0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|7042599007|6090799003|19110799003|8060799006|15080799006|461199028|3412199025|4302099013|440099028|10035399004|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmpaK1RiYnlZbTRCYWttNmV3eGJNZFFlcWhPd2dubU52QzhMc2ZqTjJPY3Vs?=
 =?utf-8?B?VVJnMmNHV1BmVHQwRGc1cUIxc1BXKzQ2TEFydVdONFp2ZE1OSmNpQmJiK0Nj?=
 =?utf-8?B?aVlyb0E3dHVwYjhZMThNbXpjZUJ1Q0dUT21yZXUwR09vSnhIbDUrSnRubTdP?=
 =?utf-8?B?Y2kzZERybGhvVXNSejVsWjY4OVFGMHJYNlIvaUt0YmRJWHFQdU9JaVZnRHo2?=
 =?utf-8?B?a2o1SVhleUh5dDlnL0tKM1ZBSytTRHZBV2M4akRmMVhpZTNSWWhpQUFrbHpy?=
 =?utf-8?B?QjRHWjVvZDBxbkJ0Z0lCMWVMdWxGT0ZaN242bTZKSXpVM0FkZVBLMngwTWtU?=
 =?utf-8?B?TDJ1cmh3ZDhQMXhxbW9VaGdsMjFDYjI4Sm92UTJJaEl1K08yanFvUm1ld1p6?=
 =?utf-8?B?dFRuS3RLTDZHbzROY3RHQTZBR1V0K3dIZzNIUVRHay85U3EyK3B0MDBPOTFw?=
 =?utf-8?B?a0ZSUzlUcm1TODJaWGRGc3VBcVU4ZHFCWTl6eWtpN04veWk0aHplekZubm81?=
 =?utf-8?B?UmE3SzhxSWVmWitiUy9sOU91VUltcE5rZWdBVWdiaW5kNXZBVzBaUG50SmRF?=
 =?utf-8?B?YVBDZUZpaXJ0czNUMG01QU42VUo3Y0FlbnFZdE9UeS82VVRJSlltUmE2eDFt?=
 =?utf-8?B?czJiZVBXSzFlUGNCd2NQQVhTQ2VhZmFLZy9Edk5KVVFUSjNxNVBJRzVsdEZQ?=
 =?utf-8?B?VVdXK1hKNzkvQ1MxUm1ZclFhUko2NkJUMTNhYVR4VlBFemMrTFhlWTRNVUU4?=
 =?utf-8?B?TjlkUlNvMWJDTWgvTXIxTFFUTG1UTldURUNJTFlESm44dDFBVHZlK2dIUEgw?=
 =?utf-8?B?OXpub2tYOXgxVmIrR1ZVTXBHUWhOQllpMW9hQWRwMTRwOWRaQ2Y0OWM4ZTFv?=
 =?utf-8?B?bzdGZTN3cTZmS2kyeHVsdVdDQkVGK2tYbkJQTFVaNDZSeUp2VUZBVnJsdTND?=
 =?utf-8?B?VDR2T1VqSVlFb042emxnQUU1Zk5RdzMrOUFwbzBuV1BMRlczbnN5T0lvKzJ6?=
 =?utf-8?B?UmdSRGVPcStKbll0WUoxY09ESnB3WUtzMXVyV1BKVG9ScnRlN29kWWhZVzNR?=
 =?utf-8?B?cldwR3JYZzdvbFU2alVXZTJkOWRuaFNRcSt0bFpPckZwamx4QXhnWTRQMWlI?=
 =?utf-8?B?VE9HQUZVaWpOeVBrNE9LZXhuRStGdWpySVhyckJkQjZVcU85LzI0bGx1RGlL?=
 =?utf-8?B?NzJ0eG5vQzZVOFVoZlppdXFBL08yRDhiYVlxMUVJQ3ViSTgraFJDSmdsUjRF?=
 =?utf-8?B?NjlCMWdLUHZzUisyemt4WHZiTjUyck96YTdQVWI3KzZhOXhLNEpXY2dqMlEx?=
 =?utf-8?B?RWEvaXVodUMzSG5PdlJYM0hxS2FoWGU2NVRPQVdWQkZXVnRSakliMFBtNEg2?=
 =?utf-8?B?ck1UY1lmRHYxNzhNWEVhb0wwcG9za1pubjFCRkFnYVZsZEdrSGk1WWN2WHQ2?=
 =?utf-8?B?b1ViekpMcUFDY21Ma2lMdmNnT0NpMEZQdVpZUjhGajNCRGlhZjFqUS85QldD?=
 =?utf-8?B?WEZFd3JEK3JoYUJSMVVKeGNkanlSeHdzYnZBMEtzVG1KRFF6VkVDanpwekN2?=
 =?utf-8?B?dFhyVG1OWmVtYWxpSmNKUmhnaHgxNTV4eURSWjQ3NGhCSzRKK2ZIOFRBLy9h?=
 =?utf-8?B?bjdsS1VNaWtVSGwrMVAwVjM1MlY5UTh3Skp5SkMrbWxPamtRL1Q2WG1YUGl1?=
 =?utf-8?B?SGliWklPTVlvMFc1eDk3OTJnOXBhZnQyRjFzNmxTektvVkFnODBCTHhRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2pqSkVjTklVTFJjY0Y2SzdtNk9IUFoxcmEzbGg5dVQ5RDljQSsxMTJKYjB6?=
 =?utf-8?B?YmFYWlc0UEV0UFBLTlZwa0FZMmdtdlg4L0QvSjE3QlExcGY5dzRwdDYyNXFX?=
 =?utf-8?B?MWJjWWlKOGc0RTZjZjZrbVBWSk9rL1QrSWJaTmc3WGpFN0lRT2Y4TkpaUkRC?=
 =?utf-8?B?RHE0VFNRWUdSZDljUlQ1eG1oOUpKOWQrSnFJaG1abWlwaTd0SU9JTDFaRTJu?=
 =?utf-8?B?MUdTV1hHWThRcU1DTVFpN1o5Q2IrR3J6Qy9GeXEvS1JxNm93RHVvYWc2QWdH?=
 =?utf-8?B?Qm9hL1dISzhPdVMyRmMyUm5odjBUeFZYbEplSGEyS05ua0JIcWVvbXFjUVhY?=
 =?utf-8?B?bEVwVW9pTTZNNjdDZi9vOHBJTWh4WThWOTN1ZFFJS2Z0bnNabXNzN1RFTUNG?=
 =?utf-8?B?NDMxSlE4SGJhS1BueHplWTRJZUpnRnlFUjJxTExjUjVnV0VPMS9EV1pxTm82?=
 =?utf-8?B?czU0RnBieTJSRyt6czZpTkVHVTczdzhvaFIxWjhLWEp1TEJhdXBYSWlOZ01J?=
 =?utf-8?B?Y2hZSTRnL0VIN3hOZ0VIcmJFTnpvaEQyeXo3UUVKbTlEM3FlaWNmcjEwT0J0?=
 =?utf-8?B?K3JFalBpNFdOUjNLTmZFNXNGVUQrbVIyMVFLQ09qWHhpUUtiay9MTWxITTVG?=
 =?utf-8?B?K2RWaTN2Z2c3RVQyQWMyRzh6ZXFFblhtdlFyT1RhaHdsejVNcUYrN2FyTnhy?=
 =?utf-8?B?c3YwRlMwOGFIM0ZDRG5zandlT002Zi8vWUVQRUd4U252WnQ5WFQramlEcGZk?=
 =?utf-8?B?WEIyemhnY0ZYaFJDVUgveU0zMkF0cFpKSWxLTUFJRUNsQnJPZ1JXU0ZiKzhG?=
 =?utf-8?B?UDlONG9FK3FralUwV3NDT3BlSVJiRXNIQlZPc2I5TmpwTVY5dEpvUWdtL2d0?=
 =?utf-8?B?aExMc08xanJ5VTdkZUErNldrbGVieHNldUMrRnNlMVp3Y0REZi8rdXJvTkUr?=
 =?utf-8?B?aElMQm1YMW41ZHBLOFE5b2pEQnFQRlJFNFluM2JEalpNbXpiYytGNGtWRzI0?=
 =?utf-8?B?Z09Mb2dqMFM4bDhqaW1pNmhXZjQ3WlF1d1A0QmJmWDh2T3dTZHcrOEpwYmVL?=
 =?utf-8?B?S1FFREJGNHFIYUk4bFJqK3JPOGZrWTZFQVg5WmxvVUxxSGd6R2EvamtMd2p5?=
 =?utf-8?B?VzlPT1h0cmprRWtQb1NQVnE5K2h3ZVMrYXlBZDJJM3JYenlzbG5Ia3UyeFJS?=
 =?utf-8?B?ZUtQY3NwYVE1TkR4Y0NlaXdYZmwwNmNtYkNZY29tMFJnY3F6NWJ1cUdqbVYr?=
 =?utf-8?B?bGZBT2ZaSDRZZHNqdkdNdTFoaHY2cTFkQktnUFBvMU12aWMzSUVZWXZFV0Zl?=
 =?utf-8?B?SzI5M01KV0MwWE9ULzcvemFlTi9tV2JPOTlaRVFza0FaRnRRTERvQjFvZm4z?=
 =?utf-8?B?Q1RHdjJHdUhEcjlaUjZ6anlPb2RPamFpdEJsQlBCTmFSdXE2bzRTRTVnTGFO?=
 =?utf-8?B?VlNCeVErend1bVpjUHFyTGlZZTlrdHlmcU5XVlZJWW1LVGdlWGRPTjQyTE9I?=
 =?utf-8?B?NjA2bU1zUTVvT0RuN1g4bk54RnVBMTVFaXpuVFREOWNTMUxVZWlDalUxSUU0?=
 =?utf-8?B?cSs5YWIzYkxZVlhxNWZDQ3Y5TUZiWHh3R1FDempSWm9OY20xYnZYTkxadDlr?=
 =?utf-8?B?MnFXSkx1OVVPVlUxaG5tYW44Z2hNTkgwWjZlZGJ5L2VSR2NsNUlEQ0JJVXRN?=
 =?utf-8?B?bEplQ2NwQ2ZBSGM0Q3pYazFqU29ESnd0Vnd2MUJEV0pkQTJBQXI1WVJXbi9n?=
 =?utf-8?Q?G88YD4JqgqCadJeLGU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4a47ba-efad-4b08-bc22-08dd565ff6e0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4527.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 12:20:32.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080



On 1/23/25 13:51, Jiwei Sun wrote:
> From: Jiwei Sun <sunjw10@lenovo.com>
> 
> Since commit de9a6c8d5dbf ("PCI/bwctrl: Add pcie_set_target_speed() to set
> PCIe Link Speed"), there are two potential issues in the function
> pcie_failed_link_retrain().
> 
> (1) The macro PCIE_LNKCTL2_TLS2SPEED() and PCIE_LNKCAP_SLS2SPEED() just
> use the link speed field of the registers. However, there are many other
> different function fields in the Link Control 2 Register or the Link
> Capabilities Register. If the register value is directly used by the two
> macros, it may cause getting an error link speed value (PCI_SPEED_UNKNOWN).
> 
> (2) In the pcie_failed_link_retrain(), the local variable lnkctl2 is not
> changed after reading from PCI_EXP_LNKCTL2. It might cause that the
> removing 2.5GT/s downstream link speed restriction codes are not executed.
> 
> In order to avoid the above-mentioned potential issues, only keep link
> speed field of the two registers before using and reread the Link Control 2
> Register before using.
> 
> This series focuses on the first patch of the original series [1]. The
> second one of the original series will submitted via the other single
> patch.
> 
> [1] https://lore.kernel.org/linux-pci/tencent_DD9CBE5B44210B43A04EF8DAF52506A08509@qq.com/
> ---
> v4 changes:
>  - rename the variable name in the macro
> 
> v3 changes:
>  - add fix tag in the commit messages of first patch
>  - add an empty line after the local variable definition in the macro
>  - adjust the position of reading the Link Control 2 register in the code
> 
> v2 changes:
>  - divide the two issues into different patches
>  - get fixed inside the macros
> 
> Jiwei Sun (2):
>   PCI: Fix the wrong reading of register fields
>   PCI: Adjust the position of reading the Link Control 2 register
> 
>  drivers/pci/pci.h    | 32 +++++++++++++++++++-------------
>  drivers/pci/quirks.c |  6 ++++--
>  2 files changed, 23 insertions(+), 15 deletions(-)
> 

Gentle ping.

Thanks,
Regards,
Jiwei

