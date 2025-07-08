Return-Path: <linux-pci+bounces-31649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BE7AFC0E8
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 04:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C9C1AA6BD7
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 02:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C1C2248AC;
	Tue,  8 Jul 2025 02:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zp2OIvAh"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636E21B908;
	Tue,  8 Jul 2025 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751942226; cv=fail; b=SRB/mVIR2PEF2z849k5+qcZJYpjGQASSXYjTNiGRVxUkoIChNOFJMMBzSeynbSpldoD1KnbvSw2HDByyGr2cI6tdBM2T/5KNJALTseGZL2LDr5zO7LwbDxFKv81GgEQB4ycC3Wjak5GZTTeM5rhuG/ew8B8v2H0kX26frWaT8F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751942226; c=relaxed/simple;
	bh=asG2TwaisE09ZGzukLRpM9xrQZQG6AoQ50KUCi0OcT4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BrhYpctIvgWEXRqIewjBosDpF6c/umeBTph/5zuaGGC2IK/7U9KFeyDT3xNQ9PlCNOQT75tmyTBKekxgsagO3/lv5S6oEuvBDXiDH1jfiwkITCrJ72B0IgnZWG0gUX7OaVeR7fbRjxvCA57W8DPhSB/FYNhRbln4eIn9jKMduLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zp2OIvAh; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWK+Q8bp/RFz51dXIF0Kb5BwNkSInStekLhcKqTc2e2LWlxATGtmzqoryf4wPlrDI+cJD7TJN/FywfLXvTtssOQBjdu0246Z8s1DVLAqilMFeXlwTLA77o1/UZuWki9V1/SvR9f5+ihOwMuLDFe/rf+tElFSX5d2HCnTLjPIemKGMWWkP5K7ug/wkkfLFE031VoFP/rmG5m89LBRWXHX27qWm/JBf60olemeG7J4XUmGvsdtgrMkJrIDIl6xt9j7j9PHBqrQx9aYKEhX/6byGYfS3OYdgr4XZNIJoCB61+A8DAoODiVREmVW6X7Jhc0pdWROI6+OnusVZpHs3n9kCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asG2TwaisE09ZGzukLRpM9xrQZQG6AoQ50KUCi0OcT4=;
 b=ncg5durXf83uNjGPTnWN3jsF3s1g9kcjI5aIe5tztnClyfePb3mJet1ywIldcxp+Dr2CASdpLAP7SKFpddUziyhy/HDswgqcS4RVn3mF2KDG+6yfZPPYqZp1rzDPSVCznXQeT43qsfEtHrypGwWjj19LPrtZFVwMH5eiki0CW0mVXL4t9wME7XgwXBcRnaEGyww11YcJXjbd4T8HO5JXSCDqYuAqaEEggORewjwLfIgj3Ysj+QJQvGmSZX0rgqPBsqb+uUMqQEmrkbQbcuv01TvB3rO2iGtP6ztcKdLDkhQLfg6qCQejVm1YY5xygdc2pB9Vse5WWonsOzCl2BRcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asG2TwaisE09ZGzukLRpM9xrQZQG6AoQ50KUCi0OcT4=;
 b=Zp2OIvAhmPaFtiXpOQ5Hc+PxxeHWPrYN3m6WyZooL1spwwoxVVKb3WBlNZC2+gQ9SPfjufnDKZxcEXGnEPFNz5gFYFe5a6o/eVTg5BmoynoRE50JXFrLorV7gUWQGpg1dESmf9q3ty/MajtrsuWng17X+ZEEfkXZDellqih6A2YPl/XkBklfeLwXYDRiIeXZW2SuSgDdotQyjVbs2xRo4wdZ1+adds5ObVSfXfXdZUkfEZKUdAKIQXpBKm/WixZZGf3113PNoYckCSjH0bXaBbL/zWwY2QMZ37Zx2qHafge0LJHtt2znsziVgjlOj2yRpAg/MGMHQuCB+i2auGY5Og==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS1PR04MB9684.eurprd04.prod.outlook.com (2603:10a6:20b:474::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Tue, 8 Jul
 2025 02:37:00 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 02:37:00 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, Manivannan Sadhasivam
	<mani@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] PCI: imx6: Remove apps_reset toggle in _core_reset
 functions
Thread-Topic: [PATCH v3 1/2] PCI: imx6: Remove apps_reset toggle in
 _core_reset functions
Thread-Index: AQHb3pz+Ja+bDgDxuUqmEsqGv1lew7QQqqoAgABh5oCAFpSZcA==
Date: Tue, 8 Jul 2025 02:37:00 +0000
Message-ID:
 <AS8PR04MB867638BDCA5F47D478F597808C4EA@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250616085742.2684742-1-hongxing.zhu@nxp.com>
 <20250616085742.2684742-2-hongxing.zhu@nxp.com>
 <kjsaipr2xq777dmiv2ac7qzrxw47nevc75j7ryma32vsnyr2le@mrwurn6rgnac>
 <CAJ+vNU3mKiEE86SYFS0aEabkqRKADFDJN0giX73E0cA=GOyhjA@mail.gmail.com>
In-Reply-To:
 <CAJ+vNU3mKiEE86SYFS0aEabkqRKADFDJN0giX73E0cA=GOyhjA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS1PR04MB9684:EE_
x-ms-office365-filtering-correlation-id: 46af7d7e-6055-474e-aace-08ddbdc850b0
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2wwM29rL1BCZCtCRGdnUXRNL1hoZVp0ajZpcWQwOTF3cnFUT3Z2ejdoemN6?=
 =?utf-8?B?OVVCcDluQndOMGxKTzFjK0MwbDl0RW5XRkFrdGxKZFZ4S3ZHTXM1TG1kbHVG?=
 =?utf-8?B?dGdQNXhnVkdwclVtSnE4RHV2RmU3UWlNYXlubHZYSndhTnFKb0lRMHN4TVYr?=
 =?utf-8?B?VEpNMXB6bG41Mmpnb1UxaVIyZ1A0VXlEVjBhNHVNdE8rR2tIY0czZHFlVlFm?=
 =?utf-8?B?eTg3Q0JVOFJEdGNUYXlQSzBVYXRYTWVoNERieHozVVBVVzRocGNJT2lScjI0?=
 =?utf-8?B?RHBCeVBmak5LU0pLbzFlcWY1RXJUOFREaVF1YkZnbjFDTGFlamx0ZjBMbUl6?=
 =?utf-8?B?RWo1RzU1eFl6U2lqeHRrbzQ1c2JHSlJkaGdQWnFNeVJmRjd5WFdTbTJMMGxz?=
 =?utf-8?B?ajBwQ00wYUhhMlVSdGNCMkVtYVl4NDJRTCtlWmNIL29vU1cvWnRacnVHVjQr?=
 =?utf-8?B?R3Zldm10alRwVTlVaHNEeXZ5ZXp3Q0ZuRW8xUzBBeVhaRjBpL0Nnb0NqTzI2?=
 =?utf-8?B?SE4yeEpERVI1ZDIydExCWWk3M2Nkd2hwZVF2TDVheUFKN1B0Qmt5M1RaeWZR?=
 =?utf-8?B?c2E4S2tVYkpBTGlBUm9tU3JwM3JKNi9FczFWeTRQb0lnYlZPcUhUMkZrZkVl?=
 =?utf-8?B?UG9tdDBWVFJQOEd6ZndFSjd3QWZhZHhaNDlmY1Z5VjFRS0Y3SmZmdTFheHVD?=
 =?utf-8?B?UnU5aHBIekJuSmZVWTVFUjJzaFFQZys2RmRpL2NhR1hnb3JVT2ZJTzdEUm9p?=
 =?utf-8?B?bk91c0l0ZS9aZVdvNFVwZWQ5VkF3MHU0SG5tbXVpWjd6L3BKZkQ3MzhvTXFS?=
 =?utf-8?B?N0paVDIvYWovSUNVZkxUVEJ0ekFzNEoxaENFelN3Y0FqcjNPbVRyWmlhMnQx?=
 =?utf-8?B?Q0JtUkdyVlVaYWoxVnNlaFNBYnNPUEVOUkRPQk1Uald0N2JwaUk5TTh1eXN0?=
 =?utf-8?B?QWZtdm9Wb0VRd3E4UkU3dHFnQW1NR20wcHAveTVXRHZsWDRDSzFNUzZnQk55?=
 =?utf-8?B?Um83L0hiaURIeVV2QXRDWkVzL1VCVXViN1Y1S1ZRSGJMNHFzVlZsMVFrVzJj?=
 =?utf-8?B?TVVSb1M0a3JRdzh1SnpBSlFudDJPNytoK0dDdnpGMEltVDd6N21uY0EvK1g5?=
 =?utf-8?B?ZDYweEhsazNXeCtZZi9QWUorV25MYy9DOWFva3Aya3ZyNHBhQVVDMlhoTG9v?=
 =?utf-8?B?dUZhZExwNWV0WTgzRm14YlpCUit0bS9XdHJmOHROSU5oQnMxV0gvTmZXbUF1?=
 =?utf-8?B?dkpxbks4QXBNRS90bTd5R0J6OWZBZEE1TFg2OExqWWtocU5PWjFWVHJ6Z3pN?=
 =?utf-8?B?UG4zVmU2YnpRY3dTYUJobGdUd1FGeUdFRHZZdTdsSFFaUXNhWXhhQ3l5LzhU?=
 =?utf-8?B?b3dKSlVpY2lDUllIUTBUSmhFY0ZhWStGNFAwc2s2dVV6RlE5UVRvVzZvYWdV?=
 =?utf-8?B?YXAvK0EvZDRmdWxPT1BqQUltVjFxTGx2d0FnSTlMV09nVFNBK3lXUjBVTGpm?=
 =?utf-8?B?ejdpYnFGTE9xNUxUTGR1SmJPN2xlU0pGMkFZcXZzemw3VnRPekE1YXdoRWx3?=
 =?utf-8?B?SUhxc2JFT21PVE5uNGhWY2x0R3hVa3A3MUVFc2pVUjI4T1lRVmVlNUwrTDh6?=
 =?utf-8?B?WURHN3F3QXcrM2UxZ040K1gzbGpZWlJwTkwxRHpGRWlaZ2VpUlhpeVYwN1ht?=
 =?utf-8?B?K0R3dzJtNXZVRU9nWXlWOCs4K0tzYWdzUmN3cGo3Y0JqQ3k2WENBeWJyeGpx?=
 =?utf-8?B?T0ZjV0t5Sk1PKzdQNlpETFpjKzF1bWc3Vnk3ZERPWlBWWkgwMjUxZUxyb1Yx?=
 =?utf-8?B?TzE3THJicFZtcnRNSm9tayt1QlV6SFJHamxyQWpaNUxtZHRscktMYndKaE5y?=
 =?utf-8?B?ZlJHOEMzRlpPajZhdHJQckx6VU1vTExkWG50THBXM0tzcHR4eXdmTE44V0FN?=
 =?utf-8?B?bWhqVzRxVGFycWFEeXNhSHVaQ09rd3BlY09hV0ZQZVVjS3Y1RkRSUXQ0eVVU?=
 =?utf-8?B?RXYyTVdKUklRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3BTc2trUGJGZHdncjlOMnBFMnpWQWFrUjNBem5qc0FrMEtjbkhsQzc2UmlT?=
 =?utf-8?B?bTJBU1hxcmhWY084Nm53Z0F4TzdRWGNXNVJ4bGFCcFZ1eWR1SURDVWNWYjA0?=
 =?utf-8?B?S1pUNDgyT0grMGxGL0QxSWhNM0lrTWFHNFJFT2xvT3FOckNvTWdiSTFDMTZx?=
 =?utf-8?B?Z0NTaDhMZ2RhTW0rbndwQVBsZEZZRm5Na3JtREdMNThRb2NlaUNWWUdoOUtN?=
 =?utf-8?B?ekZ0akJKME9ENlMwN2xsMGk0cEtjVzFCQzR0VHlObGZ5d1NhQlFCNWp3VjRC?=
 =?utf-8?B?azcxOXlKSWh4TE05VFZNUnQwMHVPMkxFb1ZiMUtOYkRiTHBhRC8rZ1IwN1kz?=
 =?utf-8?B?Uzkza0FwVHhJK3ZQZ1RheWo1b2srSk5zRFVUeUhpMklTWGR5MUNYYUFOSFAz?=
 =?utf-8?B?UjF2cEJZZkhjUUtHODltRDFWakdTeEIyUkFQTTBtQkNDUzcyUkQydlNUYnZj?=
 =?utf-8?B?K091WWtNMEs5WUE0ZnJSK0ttT2l5R0M1SGJEeEJ1RVoxTzJxcmJKVFhzYWR0?=
 =?utf-8?B?NVdqNGl4cHhvVGltemJ4NTl2eUlaVGkyWit3RjFseDVZZlpaMTM2NjNid0Zs?=
 =?utf-8?B?WFgwcXRFNzZBRU5QczM5bmY4MVR6Y3p3QWRHNE9pZUpRcHhFeTVhVjZwb1da?=
 =?utf-8?B?d3NSY2c3YlRjQ3F2bTg2NTFtRmo0MHVFZjZGVEw2NEx0RVZLNEc3RXgvSllQ?=
 =?utf-8?B?b09id3NncGx6YVNwMjB5Y3JlSnFzSXpoRzNscHZoZ2h5NE1WTURWOCs5dko3?=
 =?utf-8?B?bG5hVG82UWIvZ2JnQnFXNEIzeW9vSmI0VVA0MmVxQVQ2MUZsYmlZOWkvUGdH?=
 =?utf-8?B?NFNHUk5RblllcU9hdWVweUtRS0JYRUFIRDZoQ2lQOWVUZEhXYjVwUWNrUGpp?=
 =?utf-8?B?cXVoVmphdFphK3g3VE9KcFQyL2tPQTlNMk5OVUZhKzcxb1phMUptenhDaUpx?=
 =?utf-8?B?MVRaOURBUVVIRFQyZ1BFdEdGdnhhRGxuQVZ2MVhhS053MzBzNGhnS0RhUnlU?=
 =?utf-8?B?aUVRZXFQK0JJbUQxMm5DbjJybmVxUkE0MmtwV0d6ZllsV2hONDExdGdWMjA3?=
 =?utf-8?B?em40WDBFZTZmRkxKY3FTdnliOHZmYlFsQUNMNWJiUndQQXF0VE5iNnJsVlNx?=
 =?utf-8?B?Q1ZWbnIwbVVML3FCbVFBQkc0L1JPcTBvTHYyUWI4Vk1IZGhJY0dsd1NWOVp3?=
 =?utf-8?B?bkpnbEt3TTJtOU93dFpKdWVZVlBWbjFZYWhhamhXMW1ERGxYdHdKZXRaY0Fm?=
 =?utf-8?B?R3MxWkI0SktHY0IrWE42TjFJVTkvdVdvTUZidVN2SGpPUy9SdFdnNDdsQzA3?=
 =?utf-8?B?SEg2WVI3eHlLdXRhYUpGeGlobG4vSmZHRzB0YW1kMjJJY0V4NnFiT3hTVEJw?=
 =?utf-8?B?d2Y4R3Y0TkhteERjdE4xRTM5WWtDb0t3QzIra1VSSFhtaFVMZG5PVUJZWjR2?=
 =?utf-8?B?bUFTdkhQM09rOTd0NDFaV0lVQ0txakZ5cHVsSlYvbDZBTHZmV3BJMWJhTlR0?=
 =?utf-8?B?T3hTZXl5dUN3TXlIYUlwb21qSDE1eGE4eENUb3J1NUlxUXJZbEU1WU1HT1NN?=
 =?utf-8?B?UG8zbm44RjNpMVd3Mk1qanFqS3FzQVBFSW8wblg4bFp5ejFnYXFySGN6RXZP?=
 =?utf-8?B?akxRSWFyOUh6c3d6TkNtbmdQdE4zeTJRMWljOENycHhlVnRlQXZBUitSU2RL?=
 =?utf-8?B?KzhqTkFnNmlNZzJrRVBBZ295ZVU3TnRIQUhpdzhZRHlhQmNpN3ZZd3FCbWdQ?=
 =?utf-8?B?MnBxRHcxMmFhQVB0VmFhZ2htdTV2R2N3ZGN0UERkb0ExYjhZR2Y0WTc4NCtU?=
 =?utf-8?B?dDZkYTVyNDVYa1JSaTR4VHc2TENCMmlSUGVKZUpFOUMyWC9hSUF5dnhGcGw1?=
 =?utf-8?B?aE1FSGlMOTJ4MkwxQjR2ZWlURmV5VzdhZGJXbGcvbmc2ZDdVYk82MjlTbjQv?=
 =?utf-8?B?emUydjM1Z0FPdEt0WDRFYmgraGthN3dvT0U4VU1MSTdMUVhvdVk5TUkwRkxx?=
 =?utf-8?B?eHlkK3Q3Y25jc2t1Q0J4enJiWVdPbzVnTXBpVHJobnRTUE9RZ3hKbmJZSW1U?=
 =?utf-8?B?dm9WWWZZN1g2Y0I3RTJVZXovK3piY1JVbEhCYkFaQUlpZTdhblhjM1QxVVds?=
 =?utf-8?Q?cmb6uaXAK0c2fLdntpU6mBMMR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46af7d7e-6055-474e-aace-08ddbdc850b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 02:37:00.1117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6zTAc8Py+77ZwW9Sx1JFakhh8QB6NNKYk5ypKLQOB9fqHl58K12uSHXVam1rQvQZ9vm5hsEnvhZR7aT1iEI0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9684

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW0gSGFydmV5IDx0aGFydmV5
QGdhdGV3b3Jrcy5jb20+DQo+IFNlbnQ6IDIwMjXlubQ25pyIMjTml6UgMTozMw0KPiBUbzogTWFu
aXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pQGtlcm5lbC5vcmc+DQo+IENjOiBIb25neGluZyBaaHUg
PGhvbmd4aW5nLnpodUBueHAuY29tPjsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiBs
LnN0YWNoQHBlbmd1dHJvbml4LmRlOyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3aWxjenluc2tp
QGtlcm5lbC5vcmc7DQo+IHJvYmhAa2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgc2hh
d25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1
dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gaW14QGxpc3RzLmxp
bnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYzIDEvMl0gUENJOiBpbXg2OiBSZW1vdmUgYXBwc19yZXNldCB0b2dnbGUgaW4NCj4gX2Nv
cmVfcmVzZXQgZnVuY3Rpb25zDQo+IA0KPiBPbiBNb24sIEp1biAyMywgMjAyNSBhdCA0OjQy4oCv
QU0gTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pQGtlcm5lbC5vcmc+DQo+IHdyb3RlOg0KPiA+
DQo+ID4gT24gTW9uLCBKdW4gMTYsIDIwMjUgYXQgMDQ6NTc6NDFQTSArMDgwMCwgUmljaGFyZCBa
aHUgd3JvdGU6DQo+ID4gPiBhcHBzX3Jlc2V0IGlzIExUU1NNX0VOIG9uIGkuTVg3LCBpLk1YOE1R
LCBpLk1YOE1NIGFuZCBpLk1YOE1QDQo+IHBsYXRmb3Jtcy4NCj4gPiA+IFNpbmNlIHRoZSBhc3Nl
cnRpb24vZGUtYXNzZXJ0aW9uIG9mIGFwcHNfcmVzZXQoTFRTU01fRU4gYml0KSBoYWQNCj4gPiA+
IGJlZW4gd3JhcHBlcmVkIGluIGlteF9wY2llX2x0c3NtX2VuYWJsZSgpIGFuZA0KPiA+ID4gaW14
X3BjaWVfbHRzc21fZGlzYWJsZSgpOw0KPiA+ID4NCj4gPg0KPiA+IFdoYXQgYWJvdXQgb3RoZXIg
aS5NWCBjaGlwc2V0cyBsaWtlIDZRIGFuZCBpdHMgY291c2lucz8gV291bGRuJ3QgdGhpcw0KPiA+
IGNoYW5nZSBhZmZlY3QgdGhlbSBzaW5jZSB0aGV5IHRyZWF0ICdhcHBzX3Jlc2V0JyBkaWZmZXJl
bnRseT8NCj4gPg0KPiA+IC0gTWFuaQ0KDQpIaSBNYW5pOg0KU29ycnkgdG8gcmVwbHkgbGF0ZS4N
Ck9ubHkgaS5NWDdELCBpLk1YOE1RLCBpLk1YOE1NLCBhbmQgaS5NWDhNUCBoYXZlIHRoZSBhcHBz
X3Jlc2V0LiBObyBwcm9ibGVtcw0KYXJlIGZvdW5kIHdpdGggdGhpcyBjaGFuZ2UgaW4gbXkgbG9j
YWwgdGVzdHMgb24gdGhlc2UgZm91ciBwbGF0Zm9ybXMuDQpXaXRoIHRoaXMgY2hhbmdlLCB0aGUg
YXNzZXJ0aW9uL2RlYXNzZXJ0aW9uIG9mIGx0c3NtX2VuIGJpdCBhcmUgdW5pZmllZCBpbnRvDQog
aW14X3BjaWVfbHRzc21fZW5hYmxlKCkgYW5kIGlteF9wY2llX2x0c3NtX2Rpc2FibGUoKSBmdW5j
dGlvbnMsIGFsaWduZWQgd2l0aA0Kb3RoZXIgaS5NWCBwbGF0Zm9ybXMuDQoNCkJlc3QgUmVnYXJk
cw0KUmljaGFyZCBaaHUNCj4gDQo+IEhpIE1haW4sDQo+IA0KPiBUaGlzIHBhdGNoIGVmZmVjdGl2
ZWx5IGJyaW5ncyBiYWNrIHRoZSBiZWhhdmlvciBwcmlvciB0byBjb21taXQNCj4gZWY2MWM3ZDhk
MDMyICgiUENJOiBpbXg2OiBEZWFzc2VydCBhcHBzX3Jlc2V0IGluDQo+IGlteF9wY2llX2RlYXNz
ZXJ0X2NvcmVfcmVzZXQoKSIpIHdoaWNoIGNhdXNlZCB0aGUgb3JpZ2luYWwgcmVncmVzc2lvbnMu
DQo+IA0KPiBUbyBlYXNlIHlvdXIgY29uY2VybnMgSSd2ZSB0ZXN0ZWQgdGhpcyBwYXRjaCBvbiB0
b3Agb2YgdjYuMTYtcmMzIHdpdGggdGhlDQo+IGZvbGxvd2luZyBJTVg2IGJvYXJkcyBJIGhhdmUg
aGVyZSB3aXRoIGFuZCB3aXRob3V0IGEgUENJIGRldmljZQ0KPiBhdHRhY2hlZDoNCj4gaW14NnEt
Z3c1MXh4IC0gbm8gc3dpdGNoDQo+IGlteDZxLWd3NTR4eCAtIHN3aXRjaA0KPiANCj4gSSBvbmx5
IGhhdmUgaW14NnFkbC9pbXg4bW0vaW14OG1wIGJvYXJkcyB0byB0ZXN0IHdpdGguDQo+IA0KPiBG
cm9tIHdoYXQgSSBjYW4gdGVsbCBpdCBkb2Vzbid0IGxvb2sgbGlrZSB0aGUgb3JpZ2luYWwgcGF0
Y2ggdGhhdCBhZGRlZCB0aGUNCj4gJ3N5bW1ldHJpYycgYXBwc19yZXNldCBkZS1hc3NlcnQgd2Fz
IG5lY2Vzc2FyaWx5IHdlbGwgdGVzdGVkLiBJdCBzdGFydGVkIG91dA0KPiBiZWluZyBhZGRlZCBi
ZWNhdXNlIGFzIGZhciBhcyBJIGNhbiB0ZWxsIGl0ICdsb29rZWQnIGxpa2UgdGhlIHJpZ2h0IHRo
aW5nIHRvIGRvIFsxXS4NCj4gWW91IHJlcXVlc3RlZCBjaGFuZ2VzIHRvIHRoZSBjb21taXQgbG9n
IGZvciB3b3JkaW5nIFsyXSxbM10gYnV0IEknbSB1bmNsZWFyDQo+IHRoYXQgYW55b25lIHRlc3Rl
ZCB0aGlzLg0KPg0KSGkgVGltOiANClRoYW5rcyBmb3IgeW91ciBleHBsYWlucyBhbmQgdGVzdHMu
DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiBCZXN0IFJlZ2FyZHMsDQo+IA0KPiBU
aW0NCj4gWzFdDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwcyUzQSUyRiUyRnBhdGNoDQo+IHdvcmsua2VybmVsLm9yZyUyRnByb2plY3Ql
MkZsaW51eC1wY2klMkZwYXRjaCUyRjE3MjcxNDg0NjQtMTQzNDEtNi1naQ0KPiB0LXNlbmQtZW1h
aWwtaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSUyRiZkYXRhPTA1JTdDMDIlN0Nob25neGluZy56aHUN
Cj4gJTQwbnhwLmNvbSU3Q2RhYzYwMjEyYzFjOTRjYjI0ZDc1MDhkZGIyN2MwZjkyJTdDNjg2ZWEx
ZDNiYzJiNGMNCj4gNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzg4NjI5NjgwODE5Njc3
OTUlN0NVbmtub3duJTcNCj4gQ1RXRnBiR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0ls
WWlPaUl3TGpBdU1EQXdNQ0lzSWxBaU9pSg0KPiBYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxk
VUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9OEkNCj4gN3FHSTkyQmZzYkFFUmtuc1Zq
Wk82Y0k1MjdFbnhnaWl3JTJGVmF0STdoNCUzRCZyZXNlcnZlZD0wDQo+IFsyXQ0KPiBodHRwczov
L2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYl
MkZwYXRjaA0KPiB3b3JrLmtlcm5lbC5vcmclMkZwcm9qZWN0JTJGbGludXgtcGNpJTJGcGF0Y2gl
MkYxNzI4OTgxMjEzLTg3NzEtNi1naXQNCj4gLXNlbmQtZW1haWwtaG9uZ3hpbmcuemh1JTQwbnhw
LmNvbSUyRiZkYXRhPTA1JTdDMDIlN0Nob25neGluZy56aHUNCj4gJTQwbnhwLmNvbSU3Q2RhYzYw
MjEyYzFjOTRjYjI0ZDc1MDhkZGIyN2MwZjkyJTdDNjg2ZWExZDNiYzJiNGMNCj4gNmZhOTJjZDk5
YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzg4NjI5NjgwODE5OTM0NjYlN0NVbmtub3duJTcNCj4gQ1RX
RnBiR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3TGpBdU1EQXdNQ0lzSWxB
aU9pSg0KPiBYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0Ml
N0MlN0Mmc2RhdGE9bGgNCj4gRVI4RjlBcGZwZ1FjVkN5TU9CWWhvJTJCWHZscDc5cmU0alg1QzVn
ajFYWSUzRCZyZXNlcnZlZD0wDQo+IFszXQ0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwYXRjaA0KPiB3b3JrLmtlcm5l
bC5vcmclMkZwcm9qZWN0JTJGbGludXgtcGNpJTJGcGF0Y2glMkYyMDI0MTEwMTA3MDYxMC4xMjY3
DQo+IDM5MS02LWhvbmd4aW5nLnpodSU0MG54cC5jb20lMkYmZGF0YT0wNSU3QzAyJTdDaG9uZ3hp
bmcuemh1JTQwbngNCj4gcC5jb20lN0NkYWM2MDIxMmMxYzk0Y2IyNGQ3NTA4ZGRiMjdjMGY5MiU3
QzY4NmVhMWQzYmMyYjRjNmZhOTJjDQo+IGQ5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4ODYyOTY4
MDgyMDA3OTgyJTdDVW5rbm93biU3Q1RXRnANCj4gYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25S
eWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0eg0KPiBNaUlzSWtGT0lqb2lUV0Zw
YkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPWtwNEVxblYNCj4gbGZVc1Zx
NGs5VVYzM0xTcGl3biUyRjJPSmxQenUyUEFwQXR0TnMlM0QmcmVzZXJ2ZWQ9MA0K

