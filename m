Return-Path: <linux-pci+bounces-23758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B11A61476
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 16:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8481B6288C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BD22010EF;
	Fri, 14 Mar 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HkYgNMl1"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCCD201032;
	Fri, 14 Mar 2025 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741964593; cv=fail; b=EKTSOdIHcc47QgHhadgZvLmXu7SQw5nKFFamU65GA+oQ9FDuzAulpYzRUe/51JqDv2GxrKuBRJTwQI3SU3ZLYHi2nundUZAWBn/HuVt3uuv1pG/u+Hj9n8aNSiHMwsXabxpKPm8LzSuYtuS8DlylndWaJ47k+pNH20O2+kKydsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741964593; c=relaxed/simple;
	bh=1u+zne+cUOt9gEvmbldJ+a8k8Y8Sb+ciVHt3Xz65T8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z0lW17ZrleqQ5t7XU2Gh1DMfcTs58uvoOCJHbUgp8Pc+SAD5dGMiC9O6MpD6Lpt7wKO2GoQ9ogBBejTFCrNHn5lGQ5acZoU4qjsgR0ASFnFDKx5etpSwh4LAs4spXzsuHZSLOVP1tpv6rGdluVefzK+V+j/nsYX9/zcdNzWGqWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HkYgNMl1; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8RcFyqJP71O/LRjVeDNRyY0YLVs4B0tabAEnek8cTRkpJoAuMFdYw2/ou+Vokig+pktyzNx6Zo6f4JC2YPFykPVGWK1d+pmLjxhkLjd1KQdmHD4mBaTmc9e9U8q8fooSNfC/jjooEebFTIuLIDjx411FC0rtXjoJz75AkXD6kwvBiwh8NO6IELJdmBr/uFvgwpqpYO+2zjHihcabBqIg2EIXcnHQZG70VvAxQBfgwVlg0vHxY86VdnEK7pBNzTSv4pTiQHwUwhqTtjwO4jUyZKwjxSkZNb84X3O4Z2sz1jJu+QJ5lvyI8TnN9Ox+Nac/P8/RdSt6MKRHEvW4GTa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gAA+4EqlJx0rjxfoA6MFVai1qP84GJtaEiX/bow6Tk=;
 b=kfHFO832ZwqKR5HJJiFjvCeF5dKu1anSHMXOVG0i0G8NwovBdvfILcEsZ0RPGkJDdOU/K9Hp9R+F97KWD/WDBytbpGVNhxXCcPZq8rhBAMNkgBgN5PvZfuMWEmsy16x0WPkummYdGHBtHTNJKr9/S04zkfpTstZNm61JgtfezXpQ+QZd/HpADhcKy5oNHcmpQ1LSxT2RM+KJGLerd9ABL0E9O5bAXuQ98vnNIu9K7M0XPo15jWUrB/exRlZMbQXtGkRuo/A4eZsVQIfh7BMFxGsuWbTKJxBFdUrbKAYMYO85NHRSulyxdtvg2W53LN0ThG7DI54ZBFS0677YPH6Q/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gAA+4EqlJx0rjxfoA6MFVai1qP84GJtaEiX/bow6Tk=;
 b=HkYgNMl1Z6snwO9n/h4X6NYlWtm+2bPPgDx9mMidKpNoOL0nJC1nHfcL7rLoKR2Lsr6xfoHLRNOyYMYSwJKovThO2AHV5ylrwn6Uy+hBNfDuvrDHvG92sT+ZdQtGeZ1Wqow0LXX/IvJcEfXaEVhAsayenYV8jkyzwdM2i3kCckUQh4lAHV6fR+aRLJTqse2SOEdJ9hK3R93JAhc2FqHeAVl6tUWw98pWzuwN/ZqFsofw6oH75q9ecxnfZKOfaKiQ5hXyxG48bYUsZUmQcUdVisbVXBF8qNie/JQl8+hVsGYJDwNMRulKaAoj+3136WBPiOWGD4gowjq2HnNEDSrSew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7290.eurprd04.prod.outlook.com (2603:10a6:102:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Fri, 14 Mar
 2025 15:03:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 15:03:08 +0000
Date: Fri, 14 Mar 2025 11:03:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH PATCH RFC NOT TESTED 1/2] ARM: dts: ti: dra7: Correct
 ranges for PCIe and parent bus nodes
Message-ID: <Z9RFJDdnoU+aKwF7@lizhi-Precision-Tower-5810>
References: <20250305-dra-v1-0-8dc6d9a0e1c0@nxp.com>
 <20250305-dra-v1-1-8dc6d9a0e1c0@nxp.com>
 <20250313165311.2fj7aus3pcsg4m2c@thinkpad>
 <20250314064642.fyf3jqylmc6meft7@uda0492258>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314064642.fyf3jqylmc6meft7@uda0492258>
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d3fad2-9c82-4145-48e4-08dd6309545f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NE9OMmFpOGJYOVRjdHcxM3loKzd3Q1VtRnAyamNSZGxvclFINDBIOHp1OExi?=
 =?utf-8?B?QllTSTA2K1pHM2htQnVYN21wdVZ0L2cvUytYMk80dWhad21nNXNoZGxZcmNY?=
 =?utf-8?B?L2dWYjJSUER3b1RZd3dsMkdkSXhIRmhNNDZOaGlwNmZacjkyZzV0cDkxTzRs?=
 =?utf-8?B?WjdMWHU5OVFLcTM3Mm1wZWg0RStsdkpIMVFGN0RIV0xpK2R0MlZyQ3VkZ2RG?=
 =?utf-8?B?ZXdyanh6bkxxenFFbG1XYmdyK0h0eW1Gb3NoVnZwbXo3aUJjYjByeHJadWhs?=
 =?utf-8?B?TTRJaXZhS0N5Z0lXdnN6M21ZV3lvRmJKbHVHWHhoQU1IK2VJVGp4cVBXSU81?=
 =?utf-8?B?clVLY24xTEFKL3NzL1J1SG1Zbm1SYmRaRDB0L2VhRGxzb1R1REdVdk9vaHpz?=
 =?utf-8?B?N2huZ2VqTFltajlLSHJtZjcvTVRDL2YrQ0VnaTl5ZUtvcDl4c3ZRUFMvTGdh?=
 =?utf-8?B?N2lrbG5kUEwwbWFscGhWcm5wbXlRMU1zSXhFN1VuSW4vaU1EOXlzdGtWM3dB?=
 =?utf-8?B?OHZwc0UyVGRqMlJlOVUwU3ZJcThiVGs0NEhacDlwYWFjVUpENnhmUGNISUNz?=
 =?utf-8?B?ak15OGxhcUFObXhSRmp1SFk1aW1JcHlzUVFYQTVBZksrejhYZWY0TDBkREJk?=
 =?utf-8?B?bVRyWm9US3RPb1loR1UzVGF3N2JOakF1eUMrbFgvM01aYWVzbmUxbExMaStE?=
 =?utf-8?B?UTdrTlJpQ2t3TUo5MnZDdjVBUDBUT3VwYWV0cjFPVFNkNjFpVlQ2K01HdlhH?=
 =?utf-8?B?SGRORDYyU2NkTkFUTmVoRXRSRDNvOTJYaE5hV0tWMlF6U01DMTFwV1g5b1Ja?=
 =?utf-8?B?M0puNWxrMW1aOW56Q1A0Vml4U1h5dVM0RWFyKzJNUm1SOUpnNVlzVXc3V2VN?=
 =?utf-8?B?VjI2eHovTjdrd203SDdtd1JrSXV5S2ZjOFhneSszYmpydnVheVJKSWtvYk93?=
 =?utf-8?B?b0p0OVZBaEgwQ3FUc1ZhOWh5eVJvR1NGZkRLT3FCckxUb09NaU1wZVZUMkIv?=
 =?utf-8?B?dnFQUVFtUGpUZ0R0YTBGTjdlQU9yZFQ1QTY3U0F4SE9SVE1WSEx0TnFDYTRt?=
 =?utf-8?B?VWlLVC9GVUxwaUFxWHFLOHRrUEFXRTloT3hyd2cxdXZSWi9aM3c1ZUlRVUdi?=
 =?utf-8?B?VTNON2xsaUYrZDJkeW52VFNYZzB4TzhsbFFrK3gzZ1BBQmVDa3NBU2VsSmQx?=
 =?utf-8?B?THB2WnpDdnI4ZVNLMzBXOCtTV0NLbnYveWlXa3h1djNSZkJEVVBuT1NkVy9k?=
 =?utf-8?B?OWZ5RnI3T1kzcmlaNzkxc05tSkVrSFdyTXpMMU54aVZQdHN6QWFqYjBkVkJk?=
 =?utf-8?B?ZFREVFVTaHJEK2E5b0IzM0V6UXovTDhoNEdkRkFGZkxKRFFWckt3QnBlLzJh?=
 =?utf-8?B?NlN3S1g1RmthUFhuMUVTbTc1VThnVkpCYTAxRkNoL2U3Z3NwL3UzTGd3N24r?=
 =?utf-8?B?VHFWd0NjSDV5bFI0dGpzakJIRFJ5cUdQbEtqcDFGTklnODNLL1hZNlJSZ1Vi?=
 =?utf-8?B?ZjBaejlUdjh6YlhBc2hVR2RhSUR3UXVnNExKWEM0S2U5d0JPQlR6WkhwUjk1?=
 =?utf-8?B?VmxBYWovRnE3QjhPaW9LeEV5dmQxUUxOL1pCYUFENEpYM1lVVU1pYVVzMVI1?=
 =?utf-8?B?THQ4bGxHU3l2ZGxkVkRwZnJwcnRXMTBWOWFpRWVMcDVoVEVCdVFIeWhDU09G?=
 =?utf-8?B?WmkrTEl6bkc4dFJPcUxDWXhCNXF0R04rYm5ZeHQrL3NpUUZsT3J6cHgzbEpX?=
 =?utf-8?B?UEhMN1phUTR0L3RmOVIyWStBUFE1dVJiUGxjd2lMT2NFWjNMYUNEYmtQTnhR?=
 =?utf-8?B?akxhRTV0b0QxanFsUFN2WVVuaHd2aHpGaWtReTNCaUJleVdYOVV0dXZwTSsx?=
 =?utf-8?B?NVRhYUt0a09vMnNJQ0phVjgvNDEreER3MDI0aFQwRDArU0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjdqcHowK0hyWTNmU0gvWllMYnJjT0RUT1dBQXhUQkRNN1FwQVphQW5wM2di?=
 =?utf-8?B?alVmaS9BYUJjeHl3MHVubWxNOHY0NWpFWFovdGVlVXNyeXU4ejV6cVZzK2xi?=
 =?utf-8?B?M1podWJpalFjc3lldjJiTjhsRjluaVlGQWt2bUkzYjkyTGRVZDZSUUVPekRK?=
 =?utf-8?B?V3VKVVNYVUcxbFdtRFhjRlRGSVRUS0hZUnJJdEtMcHlZVlp5SDV1WW1PRkxE?=
 =?utf-8?B?YXVNKzZtcFZ0VTQwbjJ4L2NXM0VPWm5Zbkx2Tis0MGI3a2NaTndZVGE1NEI2?=
 =?utf-8?B?Mks4STNVZnhTTHV5RFNJWjNMTlU3UkN2OG95OVVlRnA1L1A0L3U4T1FXYkxo?=
 =?utf-8?B?R0g1aVNHMU5sNVFlaHBYNTU2bFZwb3FTcmNCL0grQWFidm5aY3hrR2xKT2ZI?=
 =?utf-8?B?bmNQTHJsbWZWOE9uSE9QdksxZkU5aUg2Tit1OFVxN3V2aGF1c0dHVGlrMGpx?=
 =?utf-8?B?S0J2U1gxSHgrcXFlc0J6Z09KWTl5d1RGZ2dmc1NNRzV5OG9uVlNhMTE0ODJS?=
 =?utf-8?B?bEhWaUNDWTVtOUh4bDk3eTRuUy9EcitrSzlKNzlsQ0x2WExzMFJnOGtwTkVm?=
 =?utf-8?B?ZTlhN1JkZlJPejRXcmtRSTZwMnJld2FYQ0o1MzNjQmFEYmwveVEwd3FTbVQ3?=
 =?utf-8?B?OGp2WUxSRWkzUDJKN3lpUDdEQ3k3UklkZ0RTUVFrWFRzTVNYeWE5NzVybVRl?=
 =?utf-8?B?RXR0OXlTYjJwcTloYnhEdmVMeDh0RzgyZ1luMkxaRnk0MDJtR1lnOUZwUXp4?=
 =?utf-8?B?OVJFSmRzMU9DU0I3U2tGd2NiVGEvb2lscXNyOVJ1cm5NSlJpNmZXTFV6TkxN?=
 =?utf-8?B?SVlRSi8yWEVFb1c5bkl0akY3aU51QkxJYnRlSFpGQURLdUxMdm11QnR6YnFk?=
 =?utf-8?B?MzR4QVNyWk40Tlk2bGZFc0xtVkRnYllBcFRMdWxYc3RvVm9xYXcyeGlYRkV1?=
 =?utf-8?B?Tm9WTU1rOHF6QVgvVzNlTmZiUDNEb2dOeUVZd2lzRnVBMkRQNXlEcCtyY24x?=
 =?utf-8?B?cWtLOXVhUEJzY212TWVzS3J5WW85cWg4L3hPM2tIWmZOZGdTQUpNZFFCNTFU?=
 =?utf-8?B?VG1lT1pVWk15eFhSUldtTm5VUXQ1RnRidnhSYWhvZENscnlJUVpOQzZrd05V?=
 =?utf-8?B?NzNZSHRRYXlqcGw4S3BWd05odVBUZFVBcHNmbDhUdUNsZHBCMEFyamFqWDl2?=
 =?utf-8?B?anNTNDB4SFRQaWFTMjBCSzU0MHhDNWdUN1hTbSsvV3IzaHA2dDB0WXpXMS8r?=
 =?utf-8?B?K3h2VjhqeUU0YVNmcmM0S2daajVBZnlyQmsxdEdxck1tSXFTR0RMOGtJVGxy?=
 =?utf-8?B?M2tQU1NQRFlJYW0rc0Ftbk5EaVFmTktsL3Q2MmFaOWx2Tm03MW0rdlRuN3dT?=
 =?utf-8?B?blgzMFkva1YvbjNZMnBJbllqcmZvMUdyMFJDN2dQSkRGRmpEaFVrT3pqNjlP?=
 =?utf-8?B?dTdBZ2I5YXg3TDR5TXZKcjkrRjFnK1pRc1BablVRem1kTEhnamMybDlvY3No?=
 =?utf-8?B?VnhFQXRKMlovMjBVb1p1MVZyN3ZOalVqbFNoNzh4QWNNeStoenB5cXBUa3JL?=
 =?utf-8?B?WlU4b3M3QWkwY3ZIeUR2cjQ1dENFd29oSEEwWncvdGJ0SUtPQVB0aFhUaDQw?=
 =?utf-8?B?VHdsdmsveWR6ZFNyaHVrUjc0eCsyRmdPTzlza3ZobEVDVVB3NC96T3RvUEsr?=
 =?utf-8?B?Y29QSUVHUElxZ2RGSnVUajFTcXYvOStQM3gzRXM4VXNzamV3SUFjQkNpblRV?=
 =?utf-8?B?Yk5ub01wWlEvMWdFNUc3Y2NLdnZva0h2Rk9aTExVTlBPWVdESmFueU5LL0oy?=
 =?utf-8?B?QjFuMkFOTE12S1ZjdFQ2MFpDY1FNOGxyWGdEbmRSQXpEblR1Q2dZcmdCSk5j?=
 =?utf-8?B?cFY0UFVGb0hZb2RhU2N5SStHM2JzdEM5SDNrbG9scHMyeEVJOEJwejBJOXFh?=
 =?utf-8?B?dzJDVSttY0Y0V09qeFM1VkZjb1d0bGkrNytOWHpRMHpLYnQ1RXg0TGp1dzBm?=
 =?utf-8?B?U0w5dWpjRzVMNm1nUmpPdkpHZmlmaXg3WjVzbEc0aGhTV3hKR0kvQXRuZkx4?=
 =?utf-8?B?d2EwendxcndHaE9tT1R2YS9sclBOaHNoNU5JNmRLWnBZRXhJWWMrVXQxeC8w?=
 =?utf-8?Q?KVhWW1Ok29C+JBywOpHIxrZuX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d3fad2-9c82-4145-48e4-08dd6309545f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 15:03:07.9255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3sCcqLSDXmciUAECphHmYMd4+gem2+fSGRJnmMmAPHJjgZTwiyUei0yJ0+y6B07b5aRIZ5I9IU8QwOfMiBX1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7290

On Fri, Mar 14, 2025 at 12:16:42PM +0530, Siddharth Vadapalli wrote:
> On Thu, Mar 13, 2025 at 10:23:11PM +0530, Manivannan Sadhasivam wrote:
>
> Hello Mani,
>
> > On Wed, Mar 05, 2025 at 11:20:22AM -0500, Frank Li wrote:
> >
> > If you want a specific patch to be tested, you can add [PATCH RFT] tag.C
> >
> > > According to code in drivers/pci/controller/dwc/pci-dra7xx.c
> > >
> > > dra7xx_pcie_cpu_addr_fixup()
> > > {
> > > 	return cpu_addr & DRA7XX_CPU_TO_BUS_ADDR;  //0x0FFFFFFF
> > > }
> > >
> > > PCI parent bus trim high 4 bits address to 0. Correct ranges in
> > > target-module@51000000 to algin hardware behavior, which translate PCIe
> > > outbound address 0..0x0fff_ffff to 0x2000_0000..0x2fff_ffff.
> > >
> > > Set 'config' and 'addr_space' reg values to 0.
> > > Change parent bus address of downstream I/O and non-prefetchable memory to
> > > 0.
> > >
> > > Ensure no functional impact on the final address translation result.
> > >
> > > Prepare for the removal of the driver’s cpu_addr_fixup().
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  arch/arm/boot/dts/ti/omap/dra7.dtsi | 18 +++++++++---------
> > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/ti/omap/dra7.dtsi b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > > index b709703f6c0d4..9213fdd25330b 100644
> > > --- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > > +++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
> > > @@ -196,7 +196,7 @@ axi0: target-module@51000000 {
> > >  			#size-cells = <1>;
> > >  			#address-cells = <1>;
> > >  			ranges = <0x51000000 0x51000000 0x3000>,
> > > -				 <0x20000000 0x20000000 0x10000000>;
> > > +				 <0x00000000 0x20000000 0x10000000>;
> >
> > I'm not able to interpret this properly. So this essentially means that the
> > parent address 0x20000000 is mapped to child address 0x00000000. And the child
> > address is same for other controller as well.
> >
> > Also, the cpu_addr_fixup() is doing the same by masking out the upper 4 bits. I
> > tried looking into the DRA7 TRM, but it says (ECAM_Param_Base_Addr +
> > 0x20000000) where ECAM_Param_Base_Addr = 0x0000_0000 to 0x0FFF_F000.
> >
> > I couldn't relate TRM with the cpu_addr_fixup() callback. Can someone from TI
> > shed light on this?
>
> A "git blame" on the line being modified in dra7.dtsi gives the
> following commit:
> https://github.com/torvalds/linux/commit/c761028ef5e2
> prior to which the ranges is exactly the same as the one being added by
> this patch.

Okay, original one correct reflect hardware behavior.

>
> The cpu_addr_fixup() function was introduced by the following commit:
> https://github.com/torvalds/linux/commit/2ed6cc71e6f7
> with the reason described in
> Section 24.9.4.3.2 PCIe Controller Slave Port
> of the T.R.M. at:
> https://www.ti.com/lit/ug/spruic2d/spruic2d.pdf
> ---------------------------------------------------------------------------
> NOTE:
> The PCIe controller remains fully functional, and able to send transactions
> to, for example, anywhere within the 64-bit PCIe memory space, with the
> appropriate remapping of the 28-bit address by the outbound address
> translation unit (iATU). The limitation is that the total size of addressed
> PCIe regions (in config, memory, IO spaces) must be less than 2^28 bytes.
> ---------------------------------------------------------------------------
>
> The entire sequence is:
> 0) dra7.dtsi had ranges which match the ranges in the current patch.
> 1) cpu_addr_fixup() was added by
> https://github.com/torvalds/linux/commit/2ed6cc71e6f7
> 2) ranges was updated to <0x20000000 0x20000000 0x10000000> by:
> https://github.com/torvalds/linux/commit/c761028ef5e2

Actually this patch is not necessary, with cpu_addr_fixup(), it should
work with/without c761028ef5e2 change because it just the use CPU physical
address, the finial result is exact same.

> 3) ranges is being changed back to its original state of "0)" above.
>
> cpu_addr_fixup() was introduced to remove the following:
> 	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
> 	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
> 	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
> 	pp->cfg1_base &= DRA7XX_CPU_TO_BUS_ADDR;
> in dra7xx_pcie_host_init(). The reason for the above is mentioned in the
> "NOTE" as:
> ---------------------------------------------------------------------------
> The limitation is that the total size of addressed PCIe regions
> (in config, memory, IO spaces) must be less than 2^28 bytes.
> ---------------------------------------------------------------------------
>

That is functional equal.

> I am not sure if Frank is accounting for all of this in the current patch
> as well as the dependent patch series associated with removing
> cpu_addr_fixup().

I have not track back the history. I think before
https://github.com/torvalds/linux/commit/c761028ef5e2 is correct reflect
hardware behavor. axi@0 trim down 4 bits before send to PCI controller.

The commit message of c761028ef5e2

"In order to update pcie to probe with ti-sysc and genpd, let's update the
pcie ranges to not use address 0 for 0x20000000 and 0x30000000. The range
for 0 is typically used for child devices as the offset from the module
base. In the following patches, we will update pcie to probe with ti-sysc,
and the patches become a bit confusing to read compared to other similar
modules unless we update the ranges first. So let's just use the full
addresses for ranges for the 0x20000000 and 0x30000000 ranges."

I think maybe only ti's bus fabric do address translation at that time, and
DT team and dwc pci driver never consider that before. Now more vendor bus
fabric do address translation. So needn't every platform driver consider it
but it require DTB reflect hardware behavor correctly.

We may revert patch c761028ef5e2 firstly, after some time later, we can
cleanup cpu_addr_fixup().

It will be wondful, if someone help test it.

Frank
>
> Regarding testing the series, I unfortunately don't have the hardware so
> I cannot test it.
>
> Regards,
> Siddharth.

