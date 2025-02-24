Return-Path: <linux-pci+bounces-22157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB275A41641
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 08:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14071188FA0C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E623F262;
	Mon, 24 Feb 2025 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yseYxlOk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4585B204C17;
	Mon, 24 Feb 2025 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740382195; cv=fail; b=jnqitPzR+CEY1hWvBbbTegM10ueoYHa76iGD81SUTx/9HFDekBSRr0vH9W4cGI/76rxRZ0T/SkBJ2cFLkFLNdfRfqalr1CSOZkFa0xNH0Gjl8SCRNJIewWxTB8ozSYh8kGvofk50Wo6jnfMzOQqjKU0nXfKU01UHXNh4EdNOJss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740382195; c=relaxed/simple;
	bh=7wMeGidCfK0UrG1WHZPJxN0Qs5CB4UL7Llm4e8m8y3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bXn0qnyyOQzQzHffwjpL7AvtVeC4s/vkSUnHowxk3hrwHUbCONkiInF7bWWX4zGNtR67zuh1GIBtKc+p5GuHJxEZz2wdUtaLKtLIMmbXFHMjz3GnyGOXslZ43rYxz6MPz2nbTSvpt6rmHl4UveitCHSPNsLFUSejXT/jzayY7RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yseYxlOk; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouf6yLf9wanagGqb0K0lspxQLQkcn6xPMd3c5Wj5CgLnx1bbwLK4FltHB1St8EvXQgRZzhRss0bq7w9e61QnAIUo6FJAyJ/6Gk1l+A/Hli2hGgP3zlOapYd+SOuxWRQhp6Nr9VoxXwmr813lhhsNTywiWdaHWlcWeyJY0XCF8JGDI76IRZYW+5eTJUohES2qBkcBqxoQKZcL9SaUr1KmTnLorEOptVv+4RfO/EecGu2DYDc0WuS4wya45K30aT1/tBdH7p9ey4WBzGLN1C1Uf2Qd/ZhJMGiKPMXfGIrUNt8OgkUZs8VUkE13B0L9Mrl6fiD5TfQkZLE7lEWMEeWTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wMeGidCfK0UrG1WHZPJxN0Qs5CB4UL7Llm4e8m8y3U=;
 b=DIJya2ikk0PkaXuJhMa1VVc5+NxsEXS+XXtnAEJOc0AL1EoViT5DLxJwtXor1Y48Ue69QZpXwG7VmX6xJaaHIJyQ0Kyx3wW3afqNnp0hhVIb525Jozawe/T0Oxx8U/WvDZrAnRsO6+beg3Jh+JgxGAQgH3jE05CGGcS4hEPWn+lYVJHdspl3ZOPGO+OuDDNpfFMqwYTLXhssTRYondQxccAP1f+8wRiDCbQnpZkIvXtinPQkTvpfBfmyUHegyFm1OhnbUtvEsj+INJX/HuzCJ3RpDK3+WpIR6ZWvxFD2KrPB/QHf/dMm0MHVVdFYnAjqsaHHMKPUnRL1x2Ux8xELhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wMeGidCfK0UrG1WHZPJxN0Qs5CB4UL7Llm4e8m8y3U=;
 b=yseYxlOkJFTtlJO1x5Be0xRoT1HpLLEDlhYPtGFkkhPFtJlcJLOesH1aKCnXCkc+0LscsDKUx6HVtYQ872K14IUYaecEEditUATR1pe8RZo1jpEcwurQyy9G5naeBqi5DmWUxnVJgDcwOGDXi1TQlHPIzpd+Ypjvh+om3jp1mD4=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Mon, 24 Feb
 2025 07:29:47 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 07:29:46 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v3 2/2] PCI: xilinx-cpm: Add support for Versal Net CPM5NC
 Root Port controller
Thread-Topic: [PATCH v3 2/2] PCI: xilinx-cpm: Add support for Versal Net
 CPM5NC Root Port controller
Thread-Index: AQHbgQ2AaHkh28uBDkKj7of8FdlNDrNWE8eAgAAD0RA=
Date: Mon, 24 Feb 2025 07:29:46 +0000
Message-ID:
 <SN7PR12MB7201F2C8E4056F50E860C9038BC02@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250217072713.635643-1-thippeswamy.havalige@amd.com>
 <20250217072713.635643-3-thippeswamy.havalige@amd.com>
 <20250224070845.6ocpyblzxk7cviro@thinkpad>
In-Reply-To: <20250224070845.6ocpyblzxk7cviro@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=83dcf521-8b9b-41e7-b3d9-99487b84312b;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-24T07:22:24Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|PH8PR12MB6865:EE_
x-ms-office365-filtering-correlation-id: c6522d99-354d-4ed5-adcb-08dd54a503e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WndNdk5DczVicU5rRlJHTFEzQnZ5dUNtc2RXVUNQWFVSOHkyR1lSOHlheTc1?=
 =?utf-8?B?YXNCcHNlVndvVFJjVmFnZVdRanpnN0xOeExIMGNoYmdOK2ZkL0E0dCs4dnR2?=
 =?utf-8?B?UkcrTzR5cml5ajZXNVRQM0hEaXY4aC9sdTNESVRmQVBGL1VhNTRCUmZBdG52?=
 =?utf-8?B?MEZ1WGlpc3NjNVhoTWVjT2hTYXYydit5ME5EUzJQOVpxZ2ZMLzNSMnNackZv?=
 =?utf-8?B?eHI1UkppbUliZ2lZLzc0TENnQjhLb2dTb0VhR1Y0KzZzaENDQ0pTTW4rWG9w?=
 =?utf-8?B?YmNuaWlteGNaemZZZjRPOG1PdU1pUFkwRWxhOUdacEpQRG1tc2xDM1dndTRQ?=
 =?utf-8?B?SC9WWGVUVWZzeGtIYnlBaFhMbXUxMTBiTWJMTFVCczFCWU5vdWxLditqU2pk?=
 =?utf-8?B?SjJ1bkU2TFFKL2FJSzVCR0wwTzEwTE41d09TeWJMWlVpRkUvUTJPdG1yWXI5?=
 =?utf-8?B?dWZtVGkzSVpFcVM4RWhwZk9OMDc4Q3A2Z2RqMmd1QUpVczhyRVVBY3J5OG1r?=
 =?utf-8?B?K2tlYWMvOTFYTzV0Q0xyV0xGVGtad3Ivdzd5UDU1ck9HalQ0SGxqT0lWVWtu?=
 =?utf-8?B?dDFDU2NHaEtEMWljSmx1UEVmeitOSFQ4SllBY3lLeG9EQmNMSStOQ3VmU3Rv?=
 =?utf-8?B?eVZYYllocHVkejBoY205OVVSM0hoeGVVQzF6Ukc4amVqNy8wM3NNZzA2Z1kz?=
 =?utf-8?B?MG91aGdjU0MzWWpUNFdwN1VVTTdVVThpUHN2NUUwR01WUHZRQ2pPT1FYVVlh?=
 =?utf-8?B?MVovbUltdGFTbGpXTmdSb08zc05aWHVXY0FVYjVDR3B5c3RmL1B4TmphcW5l?=
 =?utf-8?B?TWRBdmRXbHZrSU1MN25jRUVnNjFaK2dzcWNlWWNZMjE5SnNKMEE5N3lnamlL?=
 =?utf-8?B?YXZHMnJjc2Y3cHB3RVJRVWE0Z0pZdkV5Ym01eklmZkpIWEZzQXJOOUIrLytj?=
 =?utf-8?B?dlorbXludVNCZ2Fha2xyanpLdHJvZ0xIWHpDcmN3Z0RIWkZuV2dJUkFtZUl1?=
 =?utf-8?B?TllCbUZZTEM5dS9uTGl0WXVBSzBBNnZYaHdycnBOV0pyU1hXZythRnhnVDFB?=
 =?utf-8?B?Yk9pdUt6SHNLZDI1ODdGa3JINmlpcUx6azZwdEUrN0tVTFVMaVB4MER6OGRY?=
 =?utf-8?B?bkFtblBNYVBra2t5S1ZvWjdGL0NYVTJnbDVMRVlhajcxS01ES1N4MndXSk5D?=
 =?utf-8?B?Y1VxRjRSNmRlZ1k3VTJtekZNbGZrZXBmSEJITHJvZ1lSWVdjSlNaUVl0OUlJ?=
 =?utf-8?B?SUdPWlphRC83andvOVVrYm84VUh3dUFqYTI2M3VwTmV1VC83OG5sK2ZaYkl4?=
 =?utf-8?B?SkRUSWx0VGMyYnd1U2I1aHVLU1hYTHJGMnNwSS9VaVlIRUFvT09DNHFZT2d5?=
 =?utf-8?B?NkZ2czRsM2Y5WURXaVJPTnllS0NVclYxWms1MHMvNkk1eDZ4ZS8xQnNGSTJZ?=
 =?utf-8?B?VjBhelNpWmVPeUNucnZsY2JHeFdSQzEvd1FtSEhBbWVyTzJFaEhkRnRKOEM4?=
 =?utf-8?B?WFUvN21xdjlyd3JPbHBPYnUwREFPWHhNUjVsRzJSdlI0dXlmazJIQW5SK2lB?=
 =?utf-8?B?bno2a0JJZjVPQlk5cGRTNWg0V1NrbEJzc3drdHJmL3FWcm53NkdwcDBzUGRi?=
 =?utf-8?B?RkxtY2ZFTDJzWkNrQXlKK0VtdVdVT0JyRXpBOFN1bDF6R0piSVpYUld1Rkpy?=
 =?utf-8?B?M3NnLzNYSENNaHRFODRYdjNaR3ozNzRDTXJEOFhUbytLQWZ2azdSbTFLTjQ0?=
 =?utf-8?B?WEZFeXF1VjRPdmFmT0NNUExTbWVVRVVVeWxrdUc2M0RqSmxVYld6UHlKOEg5?=
 =?utf-8?B?ZkpjNURhWnZZbHAxY1JoY0FzMUVMODN3Y1d1dWc0VXg2MGUreHNDa1JVUk1T?=
 =?utf-8?B?eDFEd3czeVg2N25yQXJOekJuOVdKRWVINFN2cERTZWs5KzM3S3VWWFdkTzVl?=
 =?utf-8?Q?xs9Fn0La+3Cyn60NLdfUNhdDMagLI1CT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTMzM1dHTWl0OHNoMUJiZENoT2haQ3dwaVpPRk5ZK05UVW0yalFBeTRpaS9j?=
 =?utf-8?B?TTBqWlk0RVZ6SGhqRFZKWUM1UTRORE1aT3ozYTI0V0dRcGJjY3Fsd2VpeHVu?=
 =?utf-8?B?dHcrR3ZxdGpuUTlzbGRtRE9PSzFOOFdhT1NrY1krdW9Pa1l1cHoxNHA3NklZ?=
 =?utf-8?B?Y2cwT1pkN25iK0JyeUFuL3dOU2lBUGVKY2tHd3BFUkVkVFdNTVk2cExxekNZ?=
 =?utf-8?B?WUZTNDFoY2NMb1F6cnB4b2JKbGptRmFSeENBaUxrWTJkQVNKb21mN3JjMC80?=
 =?utf-8?B?RDhCQzRsZGQwcHJObExjLzd5Y244aFFmeDA1N2Y2RWtoYXlSU3RqanFwcC8w?=
 =?utf-8?B?cTRKd25DWHV2NWllYzdid3BHTmlCWnYvalVHUFBwWEV6T3prZ2g4M1IweDRo?=
 =?utf-8?B?V0hFd2FHOE9xQUdPa1ZjWFNubkVFMXg3SkZFVWl0Zm8ySlRUUENDMmwyejFu?=
 =?utf-8?B?YnpHWmU2d1A4dHNZNzZUMERxTUE5SFBKNE9jTXNTMEYwWmsxcEVCTnZBK0pu?=
 =?utf-8?B?Q05DK1ZyZXFNc1hZNmJ1c0N1Mmdhdm5Ld1pxZEpkQzFtTzZiUXR4bGNQQ0Rt?=
 =?utf-8?B?NkRRRkJXMmdFSEdURGgzQTZmUnQwaWpEcjhWd2JkaVdmbk1zY0JMWlpMNVNp?=
 =?utf-8?B?SjM0ZHZ0ajliRmo1cjIvVVZsVExzR1BHZ2NjaVA3SnRsS2tUWGh4TEdqZEZ1?=
 =?utf-8?B?OWJ1cDdVeDl4eEZXSmxTV1lTVWd2OUs1MmNXeE1KYzhMOW9nZWpzb3BDblEv?=
 =?utf-8?B?TXFCUHl0TmxQMTlYTWtScHZybll0OUEzYUs4ODdtc1FTU2lTUWxNWXJlYXhS?=
 =?utf-8?B?S1IyRFJMOTE4empjY0V1eko2ZzhiT09vdnBhNVl0SjRyYWMrQjhhTE95ekpH?=
 =?utf-8?B?NFpRQ3h3SXNLQWRuMG1CSWl0cXlSbXZHYkdXU1NCWnlJQUE5ZXo0ZVYzeU9I?=
 =?utf-8?B?LzRpV0g4N1RrZ2Frb1R4Q1Y2cWd1SXVrTnRrNUMxWjAvZkVrYnZ5L1kwY2ht?=
 =?utf-8?B?b2ljaXUwZXFHeW4zZXJiM2tNQStQSWZXQnpSd2c0MDVXdVFlUVpoOHhZQVF0?=
 =?utf-8?B?bjJ6YXB1NW1YaDJQUGxJa0U0REF2ZzM5K0RaN2Y0aEZSaHNTYno2ODNUVHpS?=
 =?utf-8?B?dFRZN3J1NzF5UWIyTmdJWTB4eE5tTlhpMjRreU5aSHNKK1lsdnArMzBqMWRQ?=
 =?utf-8?B?ZUMxQWZ1VGRQYnNPVmx4dHZ3UXZjbUg4OU1oOWl5VlBNMkhRUzBlaGROTGxj?=
 =?utf-8?B?cjY4akNLNjRsNVh5OXcrVEJVaUZKdEpZZlFDcm5PTDZaQ094RDFaR1ZtdllR?=
 =?utf-8?B?dUo3YVNvaGZQbFUydmlVWTE2QTdQcmE1NkFxZnJ1ODBLQ0lTME15a2ozNWtJ?=
 =?utf-8?B?MER6RmsvdXpIaVFMT2plN0FBcTUxU3AyNzU2bGd3YnVxYXlnS1I5WHpjakls?=
 =?utf-8?B?QWl3YWdKdHpjVlFxaWpkd0phKzlsSzhHNG1kbHVGQlhWV1ZMWGphNllwMllS?=
 =?utf-8?B?UmNieHNTM2IwQ0t1SHdWSkpsUzVZa0hmaDRtN2lyeFo3NHg2U2NlY1RCU3hi?=
 =?utf-8?B?NlhEdnl1RDF5bElOSWVTNGJIZit3djRzN1VJOUwya2ZWblkvWitoZUsyREg4?=
 =?utf-8?B?L2QvSEVJY1FNK2kwYmRISXVjaVBDN2x2b2diUUhTNHdxVTA3M3FaSHF5VGpy?=
 =?utf-8?B?clYxb1pCWXhyOTlEanFWUDMvWFNXM2VTdjNpRGV0NXU5UzlaTU5zMjJ3WEVW?=
 =?utf-8?B?Y0xVNURxNHB3djZsb3J4WWFrRFk1d0ppdWI4a2ZrNEpGM3hmL0s3emJraThm?=
 =?utf-8?B?YVB4UDlZSnpxWGIzNWM5MVFpZS93NElrVzVkRGtSRzZEYXFEYWNtUXdrSGdF?=
 =?utf-8?B?b3FjRHl5bTY0WWRlT1g2OUZQNVVoNE9La3lXcjJ5NHlMOGZsbnRkdkxSL09M?=
 =?utf-8?B?TmpWSndkdElZRWkyT2duUmZQUndTb29kME5lYkc1T2h4N3lFM0YrdnhSMGFW?=
 =?utf-8?B?VkhiWnRBbHpLc3RMaEZqcmx0cXU5TTJUN05rRUttKzdQUFF5R01LS0k3cG5w?=
 =?utf-8?B?M1JjeVE3UHRWVkRJdkREa2ovUi9KTXdMNDArck9neFJXMGwxWVFGYVpOMVY0?=
 =?utf-8?Q?mMco=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6522d99-354d-4ed5-adcb-08dd54a503e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 07:29:46.7970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qrrHpoxus73uKmQFKaIk2qPKq0/zKa/+vg1aOV0h3YLGgjK+4hW0NSzX6WfHcQACSKyUD50HNojviZ6BRBq2KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTWFuaSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5p
dmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBT
ZW50OiBNb25kYXksIEZlYnJ1YXJ5IDI0LCAyMDI1IDEyOjM5IFBNDQo+IFRvOiBIYXZhbGlnZSwg
VGhpcHBlc3dhbXkgPHRoaXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+DQo+IENjOiBiaGVsZ2Fh
c0Bnb29nbGUuY29tOyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsNCj4gcm9i
aEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGxp
bnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5z
aW1la0BhbWQuY29tPjsgR29nYWRhLA0KPiBCaGFyYXQgS3VtYXIgPGJoYXJhdC5rdW1hci5nb2dh
ZGFAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzJdIFBDSTogeGlsaW54LWNw
bTogQWRkIHN1cHBvcnQgZm9yIFZlcnNhbCBOZXQNCj4gQ1BNNU5DIFJvb3QgUG9ydCBjb250cm9s
bGVyDQo+DQo+IE9uIE1vbiwgRmViIDE3LCAyMDI1IGF0IDEyOjU3OjEzUE0gKzA1MzAsIFRoaXBw
ZXN3YW15IEhhdmFsaWdlIHdyb3RlOg0KPiA+IFRoZSBWZXJzYWwgTmV0IEFDQVAgKEFkYXB0aXZl
IENvbXB1dGUgQWNjZWxlcmF0aW9uIFBsYXRmb3JtKSBkZXZpY2VzDQo+ID4gaW5jb3Jwb3JhdGUg
dGhlIENvaGVyZW5jeSBhbmQgUENJZSBHZW41IE1vZHVsZSwgc3BlY2lmaWNhbGx5IHRoZQ0KPg0K
PiBXaGF0IGRvIHlvdSBtZWFuIGJ5ICdDb2hlcmVuY3knIGhlcmU/IENhY2hlIGNvaGVyZW5jeT8N
Ci0gVGhhbmsgeW91IGZvciByZXZpZXdpbmcsIEhlcmUgQ29oZXJlbmN5IGlzIGFib3V0IENDSVgv
Q1hMIGJ1dCBJIGRvbid0DQpUaGluayB0aGlzIHNob3VsZCBiZSBtZW50aW9uZWQgaGVyZS4NCj4N
Cj4gPiBOZXh0LUdlbmVyYXRpb24gQ29tcGFjdCBNb2R1bGUgKENQTTVOQykuDQo+ID4NCj4gPiBU
aGUgaW50ZWdyYXRlZCBDUE01TkMgYmxvY2ssIGFsb25nIHdpdGggdGhlIGJ1aWx0LWluIGJyaWRn
ZSwgY2FuDQo+ID4gZnVuY3Rpb24gYXMgYSBQQ0llIFJvb3QgUG9ydCAmIHN1cHBvcnRzIHRoZSBQ
Q0llIEdlbjUgcHJvdG9jb2wgd2l0aA0KPiA+IGRhdGEgdHJhbnNmZXIgcmF0ZXMgb2YgdXAgdG8g
MzIgR1QvcywgY2FwYWJsZSBvZiBzdXBwb3J0aW5nIHVwIHRvIGENCj4gPiB4MTYgbGFuZS13aWR0
aCBjb25maWd1cmF0aW9uLg0KPiA+DQo+ID4gQnJpZGdlIGVycm9ycyBhcmUgbWFuYWdlZCB1c2lu
ZyBhIHNwZWNpZmljIGludGVycnVwdCBsaW5lIGRlc2lnbmVkIGZvcg0KPiA+IENQTTVOLiBJbnR4
IGludGVycnVwdCBzdXBwb3J0IGlzIG5vdCBhdmFpbGFibGUuDQo+DQo+IElOVHgNCi0gVGhhbmtz
IGZvciByZXZpZXdpbmcsIEkgbGwgdXBkYXRlIHRoaXMgaW4gbmV4dCBwYXRjaC4NCj4NCj4gPg0K
PiA+IEN1cnJlbnRseSBpbiB0aGlzIGNvbW1pdCBwbGF0Zm9ybSBzcGVjaWZpYyBCcmlkZ2UgZXJy
b3JzIHN1cHBvcnQgaXMNCj4gPiBub3QgYWRkZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBU
aGlwcGVzd2FteSBIYXZhbGlnZSA8dGhpcHBlc3dhbXkuaGF2YWxpZ2VAYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0gVXBkYXRlIGNvbW1pdCBtZXNzYWdlLg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LWNwbS5jIHwgNDgN
Cj4gPiArKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMyIGlu
c2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14aWxpbngtY3BtLmMNCj4gPiBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS14aWxpbngtY3BtLmMNCj4gPiBpbmRleCA4MWU4YmZhZTUzZDAuLjliMjQx
YzY2NWYwYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGls
aW54LWNwbS5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXhpbGlueC1j
cG0uYw0KPiA+IEBAIC04NCw2ICs4NCw3IEBAIGVudW0geGlsaW54X2NwbV92ZXJzaW9uIHsNCj4g
PiAgICAgQ1BNLA0KPiA+ICAgICBDUE01LA0KPiA+ICAgICBDUE01X0hPU1QxLA0KPiA+ICsgICBD
UE01TkNfSE9TVCwNCj4gPiAgfTsNCj4gPg0KPiA+ICAvKioNCj4gPiBAQCAtNDc4LDYgKzQ3OSw5
IEBAIHN0YXRpYyB2b2lkIHhpbGlueF9jcG1fcGNpZV9pbml0X3BvcnQoc3RydWN0DQo+ID4geGls
aW54X2NwbV9wY2llICpwb3J0KSAgew0KPiA+ICAgICBjb25zdCBzdHJ1Y3QgeGlsaW54X2NwbV92
YXJpYW50ICp2YXJpYW50ID0gcG9ydC0+dmFyaWFudDsNCj4gPg0KPiA+ICsgICBpZiAodmFyaWFu
dC0+dmVyc2lvbiAhPSBDUE01TkNfSE9TVCkNCj4gPiArICAgICAgICAgICByZXR1cm47DQo+ID4g
Kw0KPiA+ICAgICBpZiAoY3BtX3BjaWVfbGlua191cChwb3J0KSkNCj4gPiAgICAgICAgICAgICBk
ZXZfaW5mbyhwb3J0LT5kZXYsICJQQ0llIExpbmsgaXMgVVBcbiIpOw0KPiA+ICAgICBlbHNlDQo+
ID4gQEAgLTQ5MywxOCArNDk3LDE2IEBAIHN0YXRpYyB2b2lkIHhpbGlueF9jcG1fcGNpZV9pbml0
X3BvcnQoc3RydWN0DQo+IHhpbGlueF9jcG1fcGNpZSAqcG9ydCkNCj4gPiAgICAgICAgICAgICAg
ICBYSUxJTlhfQ1BNX1BDSUVfUkVHX0lEUik7DQo+ID4NCj4gPiAgICAgLyoNCj4gPiAtICAgICog
WElMSU5YX0NQTV9QQ0lFX01JU0NfSVJfRU5BQkxFIHJlZ2lzdGVyIGlzIG1hcHBlZCB0bw0KPiA+
IC0gICAgKiBDUE0gU0xDUiBibG9jay4NCj4gPiArICAgICogWElMSU5YX0NQTV9QQ0lFX01JU0Nf
SVJfRU5BQkxFIHJlZ2lzdGVyIGlzIG1hcHBlZCB0byBDUE0NCj4gU0xDUiBibG9jay4NCj4NCj4g
U3B1cmlvdXMgY2hhbmdlLg0KLSBUaGFuayB5b3UgZm9yIHJldmlld2luZy4gVGhlc2UgY29tbWVu
dHMgd2VyZSBtYWRlIGluIHRoZSB2MiBwYXRjaCwgYW5kIEkgaGF2ZSBhZGRyZXNzZWQgdGhlbSBp
biB0aGlzIHZlcnNpb24uDQpMbCByZW1vdmUgdGhpcyBjaGFuZ2VzIGluIG5leHQgcGF0Y2guDQo+
DQo+ID4gICAgICAqLw0KPiA+ICAgICB3cml0ZWwodmFyaWFudC0+aXJfbWlzY192YWx1ZSwNCj4g
PiAgICAgICAgICAgIHBvcnQtPmNwbV9iYXNlICsgWElMSU5YX0NQTV9QQ0lFX01JU0NfSVJfRU5B
QkxFKTsNCj4gPg0KPiA+IC0gICBpZiAodmFyaWFudC0+aXJfZW5hYmxlKSB7DQo+ID4gKyAgIGlm
ICh2YXJpYW50LT5pcl9lbmFibGUpDQo+ID4gICAgICAgICAgICAgd3JpdGVsKFhJTElOWF9DUE1f
UENJRV9JUl9MT0NBTCwNCj4gPiAgICAgICAgICAgICAgICAgICAgcG9ydC0+Y3BtX2Jhc2UgKyB2
YXJpYW50LT5pcl9lbmFibGUpOw0KPiA+IC0gICB9DQo+DQo+IFNhbWUgaGVyZS4gWW91IHNob3Vs
ZCBub3QgZG8gdGhlc2Uga2luZCBvZiB0aGUgY2xlYW51cHMgaW4gdGhpcyBwYXRjaCBhcyB0aGlz
DQo+IHBhdGNoIGlzIHN1cHBvc2VkIHRvIGFkZCBvbmx5IENQTTVOQyBzdXBwb3J0Lg0KLSBUaGFu
ayB5b3UgZm9yIHJldmlld2luZy4gVGhlc2UgY29tbWVudHMgd2VyZSBtYWRlIGluIHRoZSB2MiBw
YXRjaCwgYW5kIEkgaGF2ZSBhZGRyZXNzZWQgdGhlbSBpbiB0aGlzIHZlcnNpb24uDQpMbCByZW1v
dmUgdGhpcyBjaGFuZ2VzIGluIG5leHQgcGF0Y2guDQo+ID4NCj4gPiAtICAgLyogU2V0IEJyaWRn
ZSBlbmFibGUgYml0ICovDQo+ID4gKyAgICAgICAgICAgLyogU2V0IEJyaWRnZSBlbmFibGUgYml0
ICovDQpUaGFuayB5b3UgZm9yIHJldmlld2luZy4gTGwgdXBkYXRlIHRoaXMgaW4gbmV4dCBwYXRj
aC4NCj4NCj4gU2FtZSBoZXJlLg0KPg0KPiBSZXN0IExHVE0hDQo+DQo+IC0gTWFuaQ0KPg0KPiAt
LQ0KPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+N
DQo=

