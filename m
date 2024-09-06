Return-Path: <linux-pci+bounces-12895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E0C96F1E6
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 12:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B901C23907
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 10:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B071C9ED5;
	Fri,  6 Sep 2024 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MrhPwaIZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2770158866;
	Fri,  6 Sep 2024 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619853; cv=fail; b=ImDpbg2Ru8a/MgUVsnwUvfxLoJSAVqTGmWKK+dw4hvDucYvvOvWX90KydKHaFnRzJ2kXugB+J0IqHYtrBia12B+P27++ckuE/nI8GzGDMZHZONkNYGf+sZB46Lc9ISgYOMNCwfsaX6XTadZhLjd0xjarXB5Oa2Z8C++tJKU2cDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619853; c=relaxed/simple;
	bh=PvufcRNTQbsSxqNQU/PZb9OurMvydrAohRvS2Qi80Ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AB5x0vjZNHOcWDSDyKJt3EBTUi2lVNxg0wti0vHp/VaD92GmS6cg90wyZWsSfRLmOEPdOH6fUcHiREy/gVnwRPajV4m83lXxMtf6yHwUZrtgmf44xAiaLs8F0nnMWO+onow1w6m5dwE8PByMtCt2GqKSLIRQWy1sJWkeC0a0xyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MrhPwaIZ; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLUNEcn4o9VsTBCSwW8K6Sj8LFlSRGG5SrIn0g1jRqznlHy3kep0sRV5lBrztzLjCzD0Qlc/6V9N+QWTfNgOaaznPSUU2pSmn1+W+1heUhFszMyP6cB4REN+RR6w024r8Y7I6FJZFRMEoEq28sgDrg6JeRNFdcK528M8g5kOuTOZrMtzJT/I+Ew4fEtaw/M8APzVVBpIMK2TBQH9V/VQgjkJ1Pe/WQBNoDuMUuWl/Kzz6RiBeTZAPQ3JgBONdAuCVYx9eIwlOXhASNeIUGpvVosrD/y+EYKzRGmj42/F0nqnwr3mRJ8xh7nmXwOdqejpO34v+K+MLDYTLjEYP29teQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvufcRNTQbsSxqNQU/PZb9OurMvydrAohRvS2Qi80Ws=;
 b=E3uCN1KIPMH5+BhwNDWFMq4NSPWOUAFTtLkunMRp1yORlqwm0CKlrLb2u9UWVftKNA0KB8Xqk89MN5a6iT8m/DJwfgU7K30ku1PRosrliwEb/bLlw29x2AI+uH6Xzt72FFi2PfEZzW6cpzst6gwid1K42iiFZ1I8wmCRgq1stFF8O69m41xX/fwIkPUTk/Q3eroEiuyF0Zzwo/ITMZDh82nicEnlRvfrKF3oziuvudDh1EQAtXQ/k7mYqkN//YfWBKTvqxT7fDT4Jqn3VEXM+6jc3OaRzSZfxzTJ5qllJ03UUW3WbPw3iX8aCmsp9Nal4Fl34xnyXKo8BeToscV3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvufcRNTQbsSxqNQU/PZb9OurMvydrAohRvS2Qi80Ws=;
 b=MrhPwaIZ1O/jNVUs0YV8/h8olIdEoooqh7iprMRnOcgjr+c/DwpHK51qoT4CGzYChyiUbHNnlL4EgFjRR6tgmL94zUtDDRcsUrWHDS7tBvIATfOcmHUhQ4UiSio3oP0xUcVwOjAo2eEu7EF2K+c8StHjBpBlNndFHNUC7Y+ZbKI=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 10:50:49 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 10:50:48 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "Simek, Michal"
	<michal.simek@amd.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>
Subject: RE: [PATCH 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible string
 for CPM5 controller-1.
Thread-Topic: [PATCH 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible string
 for CPM5 controller-1.
Thread-Index: AQHbAD+qs/ZP6ddUUkqwXrFBAjDnM7JKhZSAgAAMnRCAAAE/gIAAAH/w
Date: Fri, 6 Sep 2024 10:50:48 +0000
Message-ID:
 <SN7PR12MB7201E4EB5370AFFE8FCAB56A8B9E2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20240906093148.830452-1-thippesw@amd.com>
 <20240906093148.830452-2-thippesw@amd.com>
 <e985a9d4-b398-4290-a4b9-08999c6a9f71@kernel.org>
 <SN7PR12MB7201F82C9BC29ACEE7E209028B9E2@SN7PR12MB7201.namprd12.prod.outlook.com>
 <7ebc9676-d66c-4d82-902b-e824bcb2c921@kernel.org>
In-Reply-To: <7ebc9676-d66c-4d82-902b-e824bcb2c921@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SJ2PR12MB8874:EE_
x-ms-office365-filtering-correlation-id: 86409cfb-14ac-4d8d-86d7-08dcce61c4da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXl3Q1RYS01GSHZ6WE1ZWHA2VEMwZFBRZzBmYzZiOUVzNmF4RXFBODhmUEcx?=
 =?utf-8?B?OFIwT1ArREJFQTZ2V2kvZEVjZUM1dHhDT3ZvSll1L0tSZFlyVTNwT1hhODQ2?=
 =?utf-8?B?Q1Y5Q3RDZDkzNGNhRWVIc1V3Mi9RRzNUU3IycVlMSWxLeVNTbWc3LzZtK2w2?=
 =?utf-8?B?YmxOZklXaDBOUXlTbVVRNk1LdytHSDNwcUd6T25qNWtTOEljdkN3YVQ3TkhL?=
 =?utf-8?B?Tml0d045UGx4Q1FmUy94akppT09HbDI2Mml5cWdDZ3NyZkk3R2p0TEhvMDk2?=
 =?utf-8?B?aFZ6UWVacXllMTdVNzU1L1grZnZVYlZ3bi9uMkFaU21XaHVOWGFMWXVOdU8x?=
 =?utf-8?B?NHBDMTBacDRFTU1NRFBJMmpLTE5LdExES01hNDJNOTMvd0tZRkZ3RWo3Vmwv?=
 =?utf-8?B?R2RLQnFwVFBJa0xVMFpQZE9nak9YUjJaaUg1KzIvOW9icDJIV0dEb2V4ZytH?=
 =?utf-8?B?MW1RRGJHZEk2Y1Y4ZkxDdGx2V3NzVm9IcG1JTzZTYzRsSHpzZXdxdmtOaG8y?=
 =?utf-8?B?cHhTdTR1TWZ0azRwVk9zM2Jod1Q2a1NaVnl0Sm1MaDBqRE5IZWZsV00zK0dH?=
 =?utf-8?B?a1hmM3pMQkF5Qzk0WjZBcDUxUFhLNm52RlhiaFpKZDdKZkREZlhlUldKaHdZ?=
 =?utf-8?B?MGU0OUNVVGZKeDA1MFp3T0hlTTNyVUhSWWVsM2lWZDkwVkhHR2o4QmMyV0ty?=
 =?utf-8?B?YmJITVJFVTFmSC82QUdlb2VOelBlK0FhNTNNb3hna0RNVk1vMmNMM01CcGp6?=
 =?utf-8?B?UXpmT1JMZGNWMzhrZ3pKakpYc0R1bnV5WXM3QzFXMmYrM3EzOGk2SUt6WTl4?=
 =?utf-8?B?UWVNRXIwUTZjSUp6UmhPbjZYUXRsYmxTbmY4UE9kcG1FRWp5NXg4WXE2NkRM?=
 =?utf-8?B?Q2lvcjBPMk5wUkVKT3NhV3J5Wlc5YXlkR0xmSTZSWm5ablhzRTRKRDc5TTVv?=
 =?utf-8?B?YTNvY2ZTMTlkbWUrOWJ0bmxTdVRhMTMrQU1YS3dyamlKa3R4dDJRbThtNjFY?=
 =?utf-8?B?QWxoSEtDeWx0empMRlBreFlheStHZTh1aUkwVjJiKzBXRUpqZTgxOUc1NENm?=
 =?utf-8?B?UXhRVlJqMmZZZk5mNFFYbkEva3F6eC8wYXc0TC9uRnBWajJ3Tmh2Y05XTWZr?=
 =?utf-8?B?WXBycnpRWW9ZOG1FQ0JkRVllalpFQ1d6eWdtYStEN2VnVFl4UWtzU0pQMEN4?=
 =?utf-8?B?VnFyalNBRG9zOXBxRTgzVWVIVFY2T0RCbEhXQjgyTnlEVklNZkVRb0NRQTZH?=
 =?utf-8?B?SEFoS0tDclIyelpkc1ZWMTUxdk1ubHhqelRacnJ1WWxMcmU4cG9sVFdyL0t1?=
 =?utf-8?B?VnVCajFyaHFsdCtrU1pPSDhEd0tqQUk3ejlBeHRkUVhNWmZINlFZb21hMkhS?=
 =?utf-8?B?RVpyc3VFUHJ0enVFaHppZGdwenhhVTdWMlpPVEc4Nm9TZzZKTGVieHFiUUJT?=
 =?utf-8?B?Z3E4R25rbzdGK2FtcDZPakkySDUyUTBUem0weEdPTDM4cktWRExEVmtiNzJL?=
 =?utf-8?B?dTNvK2VCazJoVktoS0VRYnhHdGlYK2FEK0pEUTgrR2U3ZGxObGhEYXlFTU44?=
 =?utf-8?B?TWVNQmZKMzlvRHhWMDdCa3RwdUhwMGFvTHJhV2x0YkxhVisyd3BXOUlzTDBW?=
 =?utf-8?B?ejJHdE5Jb2hYR293bjdiT0dPT3U5UTJGNjZCbmZkRmhNTDJmcG9TVVdiTjI0?=
 =?utf-8?B?bldEaEZnSW5DQytXU1RacWNaV1NtczdBRkdhaXFJWG5oWVVydkVUY1dXeGpX?=
 =?utf-8?B?aFBrNStuazN3aUxrTGR5bDVaMFdwMjRSaU01RUVoMmFITWtRblZrTHFEcjZI?=
 =?utf-8?B?QWcya2VNRWl0QVEvc2llb0xkNDFRc002UVlkVGtHTEZ3a0w3NG5wK294aXU3?=
 =?utf-8?B?b01xMlZxZEszL3BoSTVxYnRFZG5NYjBVTDZYZ3lnZmx0V2pEdVRWZHNUYmY2?=
 =?utf-8?Q?RBznIYbHk3g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1UwWklqRE01ZEtxWVlLL2dMbngveWNiZ3o4dGhQSUNHUERpQ1I5UmYwK3li?=
 =?utf-8?B?VERYSlRxcThkZmdxQWEzNXBqT0dQTVpHRDBlYmtZcG10dm5KN3ZvMTBoMytQ?=
 =?utf-8?B?ZXpQWGVROFAzcHRUV2xjSkdqbUhjM2VtaVowaGtrdTdQUHAwaHNNdTVRdTNC?=
 =?utf-8?B?bmhZTG92VlE5R3cwSTA5Vk04YVIvaTZ0RGhxSWdOVzdMdTRWQnNXTjVGa0NS?=
 =?utf-8?B?Ty91cmJ5bXQ5NVF4NkpkL25TT3B2Ly90ZXZXbjZsUDU2c3EydWhUdWNUTnFT?=
 =?utf-8?B?anVlUjk1N2J6a1RYMFZPVTltQTl1SHFqTHN3MW1QZWZtTER0UC9acWVEeU51?=
 =?utf-8?B?aW5ZcVVrWnlCNnhGdnNybElaUXdycUhNeC9qZERVU2dNd1dYakZub1dtU2dY?=
 =?utf-8?B?Znp4bXV3bUg2Vnh1Q0xjOVZ1TmlYcGF6Yy9YSFhyeDlIVG9TWUEyR0xzUEVy?=
 =?utf-8?B?cXpCT0ZRbVpKYkRybUFJMXNta3lDcFIvL1VHbmo0bEdQbzRPRnFMdGk1WHR3?=
 =?utf-8?B?T0NyMUc1cXIxdmxEamJIUHZBRTA5ZStZOW1EODJPY2hQQkFaR1loU2dqcFFI?=
 =?utf-8?B?d3FwMXY4L0FUMW0yMWRldjMvS245K0MySW5GYlRsNkpqcmYwb3hIbVpyYVZu?=
 =?utf-8?B?MmdOOWU4VWRVSVdNK3JlMHIxRDBMMG5xckovS05jM3V0SlRWcGZpUE4zckxG?=
 =?utf-8?B?bU1yMFZETWRNTTE1RUcxNWVFL0pvd0dLWEFkOS96RXpqZE5ZM1VKQUFUaUQv?=
 =?utf-8?B?alg3Vk4rRWlPWjBrVDJ2TTNpekk2L2d0WXNIQytvSFN6QWg4RFhUUHZhbTlq?=
 =?utf-8?B?YlVwU0VlNGw2eVlSK0l5bEdxWFlhenpaVVZsR0tFdGRueUxjTHFDa2xOR2pj?=
 =?utf-8?B?dlBkK1BPUXdmb01mZXlMUk1RdExpQmM5b3lic0Nlam1OTmVzblluMDlUNnNY?=
 =?utf-8?B?WTl5V2JweUJlYVdYOXRRKzg5SEF0UWtYQ3JqRkg0NkpuWGhtdE9jcUpCVEwy?=
 =?utf-8?B?RjZNOXI0ZnIxbGt1ZDZWK0pGcnN5YzNaTTMzbmpQMGltU3ZlcUYxNFAvZzZu?=
 =?utf-8?B?aXJBNG1JNmhWLzAvQStwbmFscVplUUxPUUR5ZWVINDMzaHhFYkQ3aWVlc3ZC?=
 =?utf-8?B?WXREVmRQS2lTc1hPM2pseXhEZnl6eVdZUzN4VnoyRmJmdm52MUNGVUg0aGZQ?=
 =?utf-8?B?OWpoalo4RVQyNTZkOWprbTYyaXhQd0M0Q3dNNTV6RUlGQW1tZG5XSUZQbXNJ?=
 =?utf-8?B?T0x6RHVTcmpZNzlwN0FlWHhTeGJHNEtMM2ZpV2hRdzdtUjBaTEdNM0Q1Y0VM?=
 =?utf-8?B?WDFTY3ZiYjhrZTBXdE14YXRVenR0Nm5NSnRydldJdE1nazZiQmpMbnN1MzVx?=
 =?utf-8?B?NTZOblpFZ2JVREdXeDl5OThQc2NHQ25FME9DTzNWNkNCMzU2VEhVRnNVQ1BW?=
 =?utf-8?B?bGRlSWI2ak1vY2Jxc3doNFRSVWRucUlFMnpwaU9xQkVRZmxXb21ZNlh5Y29r?=
 =?utf-8?B?dHkvNHh3VlhxL0EvODlBcEFkOURuQ20wQWEvckdXVGt5UWd6QnVCRkZ6RDEz?=
 =?utf-8?B?Si9hNzR0ZEp6YkxtbWFhWGtBS2JOUUxQbFJ0NEhQbnQ4YUVxdnhNY0c3b05E?=
 =?utf-8?B?Nk9neGNISnVSeGd2RitxTHBLSldibm40TDhuRDhQMS9PRUtjOFI5Rzc3QUpF?=
 =?utf-8?B?THJjSnN5b3M5WDBHL1NzZ1U5N2pVK2J0bTJyYnVwdEg3VHhtVE8rUHZHN1Iy?=
 =?utf-8?B?SEpnRUJQQzFjSzRZZlVsWTNLY2JVWVUzd04xVkRmb1ZKN3NyRVcvUWlpbnRn?=
 =?utf-8?B?cGhzd2hza0haQTI3KzF6dnVkL3hia2E5NEVzZXQzT244R2RzQ2F3YXIxa2dn?=
 =?utf-8?B?SVlyTDNFQ3hqUlh3Y2liL3hLV0NKVm5nZFFldkZ1T0RPdmpwdUVUZ0hVY0lo?=
 =?utf-8?B?UFN5MEw4RHd3Q1ZDemkxalVRKzREcUZXcVFmaVB2K0oya3ZaanJXWGR0dG9h?=
 =?utf-8?B?d25uaUNKbHUvL0JIbTVtQTlxZWtnMkdZNERnMjVrYUk4cFVTMzBuNmtiNllt?=
 =?utf-8?B?WGR5RC9KMGlDaDh5aG9XYnFnRmZnSjhmYjFGOUhWb3gxVHlkNkRaME81N3BY?=
 =?utf-8?Q?xjXs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 86409cfb-14ac-4d8d-86d7-08dcce61c4da
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 10:50:48.8946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLsQ5hnsz1mx8VX60CcKfqxR43AJVEiHgXAsZBBmtkpEEzTeD3ppdl02WeUrbUQQkKJxGuZmUckRZ+Vd0J2N1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBTZXB0
ZW1iZXIgNiwgMjAyNCA0OjE2IFBNDQo+IFRvOiBIYXZhbGlnZSwgVGhpcHBlc3dhbXkgPHRoaXBw
ZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+Ow0KPiBtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJv
Lm9yZzsgcm9iaEBrZXJuZWwub3JnOyBsaW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9yZzsgYmhl
bGdhYXNAZ29vZ2xlLmNvbTsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga3J6aytkdEBrZXJuZWwub3JnOyBj
b25vcitkdEBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogR29n
YWRhLCBCaGFyYXQgS3VtYXIgPGJoYXJhdC5rdW1hci5nb2dhZGFAYW1kLmNvbT47IFNpbWVrLA0K
PiBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBr
d0BsaW51eC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBQQ0k6
IHhpbGlueC1jcG06IEFkZCBjb21wYXRpYmxlIHN0cmluZw0KPiBmb3IgQ1BNNSBjb250cm9sbGVy
LTEuDQo+IA0KPiBPbiAwNi8wOS8yMDI0IDEyOjQzLCBIYXZhbGlnZSwgVGhpcHBlc3dhbXkgd3Jv
dGU6DQo+ID4gSGkgS3J6eXN6dG9mDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiA+
PiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciA2LCAyMDI0IDM6MjYgUE0NCj4gPj4gVG86IEhhdmFs
aWdlLCBUaGlwcGVzd2FteSA8dGhpcHBlc3dhbXkuaGF2YWxpZ2VAYW1kLmNvbT47DQo+ID4+IG1h
bml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnOyByb2JoQGtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiA+PiBwY2lAdmdlci5rZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsaW51eC1hcm0t
DQo+ID4+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOw0KPiA+PiBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+ID4+IENjOiBHb2dhZGEsIEJoYXJhdCBLdW1hciA8
YmhhcmF0Lmt1bWFyLmdvZ2FkYUBhbWQuY29tPjsgU2ltZWssDQo+IE1pY2hhbA0KPiA+PiA8bWlj
aGFsLnNpbWVrQGFtZC5jb20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbQ0K
PiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IFBDSTogeGlsaW54LWNw
bTogQWRkIGNvbXBhdGlibGUNCj4gPj4gc3RyaW5nIGZvciBDUE01IGNvbnRyb2xsZXItMS4NCj4g
Pj4NCj4gPj4gT24gMDYvMDkvMjAyNCAxMTozMSwgVGhpcHBlc3dhbXkgSGF2YWxpZ2Ugd3JvdGU6
DQo+ID4+PiBUaGUgWGlsaW54IFZlcnNhbCBwcmVtaXVtIHNlcmllcyBoYXMgQ1BNNSBibG9jayB3
aGljaCBzdXBwb3J0cyB0d28NCj4gPj4+IHR5cGVBIFJvb3QgUG9ydCBjb250cm9sbGVyIGZ1bmN0
aW9uYWxpdHkgYXQgR2VuNSBzcGVlZC4NCj4gPj4+DQo+ID4+PiBBZGQgY29tcGF0aWJsZSBzdHJp
bmcgdG8gZGlzdGluZ3Vpc2ggYmV0d2VlbiB0d28gQ1BNNSByb290cG9ydA0KPiA+PiBjb250cm9s
bGVyMS4NCj4gPj4NCj4gPj4gU3ViamVjdHMgTkVWRVIgZW5kIHdpdGggZnVsbCBzdG9wcy4NCj4g
PiBUaGFua3MsIFVwZGF0ZSBpbiB0aGUgbmV4dCBwYXRjaCBzZXJpZXMuDQo+ID4+Pg0KPiA+Pj4g
RXJyb3IgaW50ZXJydXB0IHJlZ2lzdGVyIGFuZCBiaXRzIGZvciBib3RoIHRoZSBjb250cm9sbGVy
cyBhcmUgYXQNCj4gPj4+IGRpZmZlcmVudC4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBU
aGlwcGVzd2FteSBIYXZhbGlnZSA8dGhpcHBlc3dAYW1kLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4g
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0u
eWFtbCB8IDEgKw0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+Pj4N
Cj4gPj4+IGRpZmYgLS1naXQNCj4gPj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS94aWxpbngtdmVyc2FsLWNwbS55YW1sDQo+ID4+PiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbA0KPiA+Pj4gaW5kZXgg
OTg5ZmIwZmEyNTc3Li5iNjNhNzU5ZWMyZDcgMTAwNjQ0DQo+ID4+PiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3hpbGlueC12ZXJzYWwtY3BtLnlhbWwNCj4gPj4+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNh
bC1jcG0ueWFtbA0KPiA+Pj4gQEAgLTE3LDYgKzE3LDcgQEAgcHJvcGVydGllczoNCj4gPj4+ICAg
ICAgZW51bToNCj4gPj4+ICAgICAgICAtIHhsbngsdmVyc2FsLWNwbS1ob3N0LTEuMDANCj4gPj4+
ICAgICAgICAtIHhsbngsdmVyc2FsLWNwbTUtaG9zdA0KPiA+Pj4gKyAgICAgIC0geGxueCx2ZXJz
YWwtY3BtNS1ob3N0MQ0KPiA+Pg0KPiA+PiBUaGF0J3MgcG9vciBuYW1pbmcuICItMS4wMCIgYW5k
IG5vdyAiMSIuIEdldCB5b3VyIG5hbWluZyByZWFzb25hYmxlLi4uDQo+ID4gSGVyZSAxLjAwIHJl
cHJlc2VudHMgdGhlIElQIHZlcnNpb25pbmcgYW5kIGhvc3QxIHJlcHJlc2VudHMgY29udHJvbGxl
ci0xLg0KPiANCj4gSSB1bmRlcnN0YW5kIGJ1dCB5b3UgcmVwZWF0aW5nIHRoZSBzYW1lIGlzIG5v
dCBoZWxwaW5nLiBNYWtlIGl0IGJldHRlciBhbmQNCj4gbmV4dCB0aW1lIHVwc3RyZWFtICJob3N0
MS0xIiBjb21wYXRpYmxlLg0KPiANCj4gTnVtYmVyIG9mIHBvcnRzLCBCVFcsIGNvbWVzIGZyb20g
cG9ydHMsIHJpZ2h0PyBTbyBubyBuZWVkIGZvciB0aGUNCj4gY29tcGF0aWJsZS4NCg0KVG8gZGlm
ZmVyZW50aWF0ZSBiZXR3ZWVuIHRoZSByZWdpc3RlcnMgZm9yIENvbnRyb2xsZXItMCBhbmQgQ29u
dHJvbGxlci0xLCBJIGFtIHV0aWxpemluZyBhIGNvbXBhdGlibGUgc3RyaW5nIGluIHRoZSBkcml2
ZXIuIFRoaXMgYXBwcm9hY2ggZW5hYmxlcyB0aGUgZHJpdmVyIHRvIGlkZW50aWZ5IGFuZCBtYW5h
Z2UgdGhlIHJlZ2lzdGVycyBhc3NvY2lhdGVkIHdpdGggZWFjaCBjb250cm9sbGVyIGJhc2VkIG9u
IHRoZSBzcGVjaWZpZWQgY29tcGF0aWJsZSBzdHJpbmcuDQoNCg0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0KUmVnYXJkcywNClRoaXBwZXN3YW15IEgNCg==

