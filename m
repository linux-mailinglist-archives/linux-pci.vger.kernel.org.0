Return-Path: <linux-pci+bounces-13268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB5897B207
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 17:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06DF288926
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC1A17BEB6;
	Tue, 17 Sep 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1XzzKvSg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB511184114;
	Tue, 17 Sep 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586367; cv=fail; b=BAaoS/C/kF48SkrbClvQJv1uc7d6t1+UgpHARMFMHDevdr8HZ4fKKSdy4TpqZQQfx6KreyRzqWZCWZzGfxxMWUJBn3847qbxiXmgswhbIvLbJ6+ZzX+RN4fhnr1/j/KH8Ts86JtV4nDUcQUEhgKK9P5Z/UBk6XOXxSXmDbHpAkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586367; c=relaxed/simple;
	bh=m55PK+RTZhwUrKw+oea9UCIe2DevLLO84fpltDcL72s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GsraXWIzDu3UpqovSEX8Dnc+PKFataSDCcAGmMoSkk4aVaCgT4ki/S7/ofXdxzxFxvz7tbKR9yh2MH54yuL++rRGECAZKePsQ1a0LDZP0sFw4/7oxQVEyOH3REQTJtik6EjtRNgXuSVSWXEx9biZH7HMMdb/ZqyKqXvE8N4OL8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1XzzKvSg; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSF7M2WFlP1xjz3sbDXn4IfZUJkxhl8HVcLK8r6yDODBLGxtcErT0tKy6p7pyVEIbecPS+zMGHacpjd0xqeW2f/e07TkdUoUBfsYp0xQuIqztkbqrIuwur/UZApoTg0f71i+qFyOiFWzsfI+LnFaj5+x7nLMfBmerTagmf3g5QBSIAAm7AMAsyEPIZsfoH1cIYMwoZgG44s3B19dAIj+eiS+66ig7L/fQB4BFFN8OjOtZlSQjZnhcne3qkGEcBMKLgrUYfia1Q3ssjp/Peo36L/viBMp/bYCdPw2QRsgygt6gfMdDM3FxbFwHWOdsD5NYyWUy8cpfNKldEloFMPBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m55PK+RTZhwUrKw+oea9UCIe2DevLLO84fpltDcL72s=;
 b=knMCxgdRF4ILyKpicIKkquyOhKSwsjGjvxOO+1pBHT7RpYLnOfYanP0PT0rbKsnY9c/CErv7Mv6GFT9E4qhNb/jbf2/FS7BkBOjN4JJSOkZ5tTB2FCuJ+OeVDRA4jdZisJDROgxxtM8FVH1pX+68fb63uoz56iBJENnbVgRvsCM3fYGnafvPLeaGS/JxMCrhK2I3t4OWpLZbqZU/RpjncWKOwIBD6jC1X/tDUIAItf6RNGm98l0Pr48DcuSqBq99t3ZKfh8UczFNwF0hdCIjRxl3zWFdNsml89c0JAtoi5QotyON5D/C7U02ZnRhojUk2/YMPpYH8Zkc7VO7qC20rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m55PK+RTZhwUrKw+oea9UCIe2DevLLO84fpltDcL72s=;
 b=1XzzKvSglaRaRR3lN9FWKa3bbVlqWNuFRHUVp4UW66DANOkU1PMoHLfwXfa1+2tyNLaFJk3Bo8BecOBCa1gHN9EJlbWCO1xdLGmjnNsEQG2/PDaupVmPUAMUKOMJx9mD8YmO22YvOh4bwebt60ogf0ujmEG+5O3scvHbxv4GWrw=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 15:19:21 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 15:19:21 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "robh@kernel.org" <robh@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Simek, Michal" <michal.simek@amd.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>
Subject: RE: [PATCH v2 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port controller 1
Thread-Topic: [PATCH v2 2/2] PCI: xilinx-cpm: Add support for Versal CPM5 Root
 Port controller 1
Thread-Index: AQHbCFbMVBji6yKxYEmEehu/VsZDMbJcFqWAgAABnFA=
Date: Tue, 17 Sep 2024 15:19:20 +0000
Message-ID:
 <SN7PR12MB72019C41DACA4DC17930CF868B612@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20240916163748.2223815-1-thippesw@amd.com>
 <20240917150959.3fsytm4xguoit2xd@thinkpad>
In-Reply-To: <20240917150959.3fsytm4xguoit2xd@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DS0PR12MB8017:EE_
x-ms-office365-filtering-correlation-id: b42ca77e-14fb-402d-62a0-08dcd72c1aed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWkxdnNKRmZybWUyV0Z3a2pmWUh4U050Zkt4VHQ3REtSaExsZ25JTU8xdlM1?=
 =?utf-8?B?TnU0ZEN2Ti9ZK1hieDd4Q0lrdlAzY2RwZzl2UVhseWE2K3l6T1puS1ZlMGtP?=
 =?utf-8?B?cEpkcytVMkRDcWhyNVY3V1VtMDg4LzF2YnlPOSttUUVaZGp1YWMxOXAwaUxr?=
 =?utf-8?B?a2dsU2doYjdrL2NuUWJKWk1VR3R6NG1wVTN6LzVudGRoYmNUZWRXQ2s5K1VS?=
 =?utf-8?B?R0I2bUNSc29BcU85WWtzSVpZSmhDeW41V1huRFExZWRhRGtwU2g1cVZWTWQ3?=
 =?utf-8?B?cUREWVNhcjZBR25CbmhTVUloTjNSZm42elJLNXhNZ3E0RXE4WW5KcldxditP?=
 =?utf-8?B?Y1hjMElVVG56ZUJyL3B1b3VLWmd5TnMxdjVMTXFCNUNITG1EL3JBdUxpaXJL?=
 =?utf-8?B?cWtzbGRBMzRUTFlPU2V5MmRRalNycS81MllYK2lpM3g4NWVDSnlTS0NneFlB?=
 =?utf-8?B?RmUvY0FGcXdpS000OW5jQXljSFppS0g1S2ljSGl3RzlBditGNE9WY1Z0NG81?=
 =?utf-8?B?U2hFRm1aTi9ROFJVL0FhYmU2a3ArVWYrR3FWakg4Tld4K3JEM0ZQVDFISW1T?=
 =?utf-8?B?UHI5OXBWdmg4cGYvS2N2Y2pHYlpsVXkrTURxS1l0RUpEMHZ5KzVkNGJsTG8y?=
 =?utf-8?B?cDlBK3Q5dHhjNTdMdkhPdDA0QThZbTVrVGpnN2tjWjVVaUFzY2ZpZlFNVzBS?=
 =?utf-8?B?eit0QWNjV0xlc1laUlR4SUEvWmF4TU9Zdks3dDRJUFhmMGZxMGVFNWFxVGQ0?=
 =?utf-8?B?VUNaRXYxRW9TazVhTVI3SXl1a1NqTXdUcElIaWd6cUpjdXRyTnRWUFpwdEVs?=
 =?utf-8?B?YVlIcDRENGlEMk5sR0xrM1JCRzRHZVFEUmFoYXRXUGZqUnlZWXhmV3RkcEtn?=
 =?utf-8?B?QjZiWE9KdFNIY25scVFpWFJXaWtrWG55L3drMjM3NkUxbjZtejdENFY5dTdR?=
 =?utf-8?B?UVZFUTh4UHhvTG55TW5wdm5MNWlKRmtadUlNVGtQVTlBTXQ5K0VTVnhlUTFL?=
 =?utf-8?B?aEE5cm1qQU9mSEltU2FoMHUzY3daM2pYWXFXM2wrZkgrWkdsdGpJQkhjV0FP?=
 =?utf-8?B?YUZFS0p1L2VzTlMrbThmTkVXa3hEU0hiOWJ1c0NNdldUQ1ZhSzBucnNvcnpN?=
 =?utf-8?B?dlRtSWVSV2ZTejI5UWcyM3ZEVFlkUG1KZy95UkpRR3FTM3lpZzZsb1ZYRnNO?=
 =?utf-8?B?eUZ0RmloMTROdTJuQXltNVFDSHRMR0lkZklBcEtBanZ4VTJLdzVkV2VUYVZo?=
 =?utf-8?B?bHRNUy8yV1VlcmJ4Ti8vYmNkUzd3OU9uNmNnU1lMbDlJL0RpQ1BTZlVYL1Zn?=
 =?utf-8?B?eGxTekZya1o1SzRDTVF0UW03Z2lnWFd6T0lacUdBd295RnBBeHFBSm9mREpu?=
 =?utf-8?B?MTEvSEtaTmE0NmVIblBIbXJ5ZDhYcnYxVjloSk5zenRjMU9hZW11WEE4TG5w?=
 =?utf-8?B?OHg1YTRxTXRocy8zNzJsdXJ5VzZ5dGF3YUpKV2VSYVBSeUN3NWgvUkFTT2R3?=
 =?utf-8?B?NUNZenFDMGtSUXFnMDVpWTdQQUNsUDdDWnNucy9YTjVPYm9KZG84Mk5HN3dw?=
 =?utf-8?B?VytTc0xzTFQ0TjJSSHpPbVhQdFcxVUpKYlNxbXZLVE5TTXRUUkRZTmxLM0tG?=
 =?utf-8?B?dlc2U1NUN2JHVmQ1N1kvckR4aEVQNUtTbG1ZODlhc25QbVZXZEFjRStxL3dY?=
 =?utf-8?B?aDVzTHZHVUdkSTNuNFY0Q1ZQSDJ6MWtJY2d5TFd4S2V0OE9RY2VxeENUK3dk?=
 =?utf-8?B?NVBXeWNkV0JKQ3l0ME9Ya1F4MGgxZUNvd04xVzZKK1VyV0NNQkFWeUZaNGFh?=
 =?utf-8?B?Qm9TcG1xbTJNdUVRakFXb05Ma21VVnRIbm9TbWEvdTZwY0t1SzV0emQ1b2ZE?=
 =?utf-8?B?cmdMZDFnMm1laGVrVkF2VjlOcndUTnd5b05jZ04zNW9yTEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlpwQkhsQ2I0dTB2WTcvdFZERkUvaWczZWkzQVVmQllLVEVWcnRhaGdET3Vj?=
 =?utf-8?B?QThiWUZCRld5ZEJRUVRVQ3FkZExsSEZNZCs3VS9MYkFUWTlTZm14SDN5TTY5?=
 =?utf-8?B?SnN6T21XRjFMNXo2VVBlWE5VbUc2czlXdG5vZnpVRnFsMUNTTWh5aFpQNG15?=
 =?utf-8?B?VXB5a2JVL1BzVENqRlFZQndVWUZhZ2tPemNRMUxhTlBJcmRBcmFMVmpSMlYw?=
 =?utf-8?B?QUJMQkZ0aTdQNzREQ0M4RVUzdTRNWGtiTjg0N1JqcUhsYXI2bVl5ZyttSHRV?=
 =?utf-8?B?R2hTL21DS0M3bFRseUdjZnYzWjBvb0E2dUtUemh2RCtyUjRHOXNSQi90SEFY?=
 =?utf-8?B?Q01sbkJZTzRsL1hobWlPQ291VlgxSnF1UmZQUUtGcDhqSlNzWDVxUnE2cHVY?=
 =?utf-8?B?M2hTZWZsYUNKaGhNc1JVMDZRWHNDZDZlMFBYRkFkWHUwZDEvb09OcjVBUE12?=
 =?utf-8?B?aUowTXRZTDU2REwvQ3NIQ0xSMXBMK0lyTjA4TEdBaVRjZXVJNzZzSUhTY3Aw?=
 =?utf-8?B?UHpmOWVINXNJVEk2TWZDTytPZzREdVlzclhNc1AvbktvY0NtSDdWZXBQSndp?=
 =?utf-8?B?Z1oyVmtpVXlMZmE1Uyt1Mjd6eStsbGFNVUhDOGM4dEZBYitWM2R2bTFiMjJN?=
 =?utf-8?B?S05NU25HNVAzMmcyRjF2bkRLMEk3Kyt2UHc1T2p3VzFwYUxFUzVUYml1RlRx?=
 =?utf-8?B?SFNZdUY1VkZLVzNtcVZOc01nTkZyUWVhSmdsMElObUtlTjRiUW41SmpJTjE0?=
 =?utf-8?B?cFJkWE9wUzhuSlQ2ZlhZMll1eVN3c3JvWVpTT3Q2bEpMUkNXdDF3b3B0MFVx?=
 =?utf-8?B?QzVjSGZPcnJKZUdYMzRoZ2ZGWENJbGVneDB2RHhac3VEUk0vMXM0Uk5xbEtx?=
 =?utf-8?B?Sk1CbVJITGppMGZkemFqRFlTRmRrWmxNYnZycUVZdisyaDZJUjBUc2lCYUs0?=
 =?utf-8?B?RG0xTEVmdGcvaFB5aHpLUzRMMUJMR2Fvdy8xMG1rYTdTUkRKd1lIem1QbE1T?=
 =?utf-8?B?bmV6UURDSjMrRkpZOHIzSjV4Z0crV1hzSVZKZWNGR2xSbWhoaUZtSkt4QldW?=
 =?utf-8?B?Ui9YaVFOOWtaQkNWY3JqNVA1M3hWdnRpS1dyNDdpc013emkwdTZYVUV5Tmly?=
 =?utf-8?B?N1FES3hvRy93cDZ4bnVrQmRRL0dCT0taelR1TlFRQ05CbTBJaXdQaW9VZ2cw?=
 =?utf-8?B?N2FLWjVPK2phUGtXUFVRYWJzcWFOZmNYcms1cXhmMEVvUlNoVG11djlDMWhC?=
 =?utf-8?B?YTZ3cHYvcllvOTNHRXo5NnpWRWZYUCtOK3lGdHhuWWNETEdFakg5dVhBWHVq?=
 =?utf-8?B?YTJiTEtVTUhHcklaVE9rRUpDeCtoVmdiQVdWTzJXMlFrcXFIVmMvVnFPVVl5?=
 =?utf-8?B?aU03aDE4LzY4cGpnazZNeDFROVFXS1l1RXNRVnFlL0w5bUpMQThDblB2dDZu?=
 =?utf-8?B?anh2Y3doWHJoRElOR05qUDduc0xLQ1VZUjVKb1hpZlZ0QzBjWVByeHkvZVdh?=
 =?utf-8?B?ZjBTemhTWk0relMzOXFzMnpmeGtiY0ZJUW1nYUpDUzlXWVg4cXFmbHpKbmlH?=
 =?utf-8?B?Ukwrc0liOEhOYk5uNVdBMTEzMXBUS3FDa1BBd21vYWF4V2tUWFdkaHhPWEhl?=
 =?utf-8?B?NC84b3drNWZIaUdITVI2YzdPdXR2UUxJV3NkL3pDL3YxUFRvMlJHOFBTUGpL?=
 =?utf-8?B?NkpwSUlWbk5YZHJIRjM1RVIveGRPMEhtdElZajNsenByMnplNTRTNHhGUm9n?=
 =?utf-8?B?R0UyTHk4Q3ZOdFoxdk51V3RtYVRuc0htS0pabXhuRm1GRXhVU2ZNLzdOS1Ux?=
 =?utf-8?B?VmUrdFBEQ0xMNXRBck5uUHcxRzk4YjMzelp4bTNka3pQWmErTXFnc2hla2Er?=
 =?utf-8?B?NEh6cVdqQlZrbnBXUTRHdHVXcitSd3lsVW5nSlMvSHpOWkwyV3ZveCt1Mndw?=
 =?utf-8?B?Qk5uVjlzQWxyNnN0ZFZBdlpld1I4Mmx0cUFLWXZueSszbG1RN2NLU0tqMmJR?=
 =?utf-8?B?elBFdzhXTFl0R0tjTXc1MndBcEg5OEltYSt6bWwzRXVOakZLcDhURjVHdEp4?=
 =?utf-8?B?WlNleFRJc3JIS29MWkphclM0K2N2cmJjNEk3SzNlSjlHMUwrVlJ6N0IwTHk0?=
 =?utf-8?Q?Xmn4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b42ca77e-14fb-402d-62a0-08dcd72c1aed
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 15:19:20.9907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SD3S7bY+11Qq7EwLaWO/tdn0Vh5yIAV0Ilo3tC0OlgbstWdqVqf0tTMmgPM1hVf/7UxohXH8BCmUYmyYaPIVdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017

SGkgTWFuaXZhbm5hbiBTYWRoYXNpdmFtLA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5h
cm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTcsIDIwMjQgODo0MCBQTQ0KPiBU
bzogSGF2YWxpZ2UsIFRoaXBwZXN3YW15IDx0aGlwcGVzd2FteS5oYXZhbGlnZUBhbWQuY29tPg0K
PiBDYzogcm9iaEBrZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBiaGVsZ2Fh
c0Bnb29nbGUuY29tOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9y
K2R0QGtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBHb2dhZGEsIEJoYXJh
dCBLdW1hcg0KPiA8YmhhcmF0Lmt1bWFyLmdvZ2FkYUBhbWQuY29tPjsgU2ltZWssIE1pY2hhbCA8
bWljaGFsLnNpbWVrQGFtZC5jb20+Ow0KPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4
LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gUENJOiB4aWxpbngtY3BtOiBBZGQg
c3VwcG9ydCBmb3IgVmVyc2FsIENQTTUgUm9vdA0KPiBQb3J0IGNvbnRyb2xsZXIgMQ0KPiANCj4g
T24gTW9uLCBTZXAgMTYsIDIwMjQgYXQgMTA6MDc6NDhQTSArMDUzMCwgVGhpcHBlc3dhbXkgSGF2
YWxpZ2Ugd3JvdGU6DQo+IA0KPiBGb3Igc29tZSByZWFzb24sIHRoaXMgcGF0Y2ggaXMgbm90IHRo
cmVhZGVkIGFuZCBub3QgcGFydCBvZiB0aGUgc2VyaWVzOg0KPiBbUEFUQ0ggdjIgMC8yXSBBZGQg
c3VwcG9ydCBmb3IgQ1BNNSBjb250cm9sbGVyIDENCj4gDQo+ID4gVGhpcyBwYXRjaCBhZGRzIHN1
cHBvcnQgZm9yIHRoZSBYaWxpbnggVmVyc2FsIENQTTUgUm9vdCBQb3J0IENvbnRyb2xsZXIgMS4N
Cj4gDQo+IHMvcGF0Y2gvY29tbWl0DQo+IA0KPiBPbmNlIHRoaXMgcGF0Y2ggZ2V0cyBtZXJnZWQs
IGl0IHdpbGwgYmVjb21lIGEgY29tbWl0Lg0KVGhhbmtzIGZvciByZXZpZXcsIHdpbGwgdXBkYXRl
IHRoaXMgaW4gbmV4dCBwYXRjaC4NCj4gDQo+ID4gVGhlIGtleSBkaWZmZXJlbmNlIGJldHdlZW4g
Q29udHJvbGxlciAwIGFuZCBDb250cm9sbGVyIDEgbGllcyBpbiB0aGUNCj4gPiBwbGF0Zm9ybS1z
cGVjaWZpYyBlcnJvciBpbnRlcnJ1cHQgYml0cywgd2hpY2ggYXJlIGxvY2F0ZWQgYXQgZGlmZmVy
ZW50DQo+ID4gcmVnaXN0ZXIgb2Zmc2V0cy4NCj4gPg0KPiA+IFRvIGhhbmRsZSB0aGVzZSBkaWZm
ZXJlbmNlcywgYSB2YXJpYW50IHN0cnVjdHVyZSBpcyBpbnRyb2R1Y2VkIHRoYXQNCj4gPiBob2xk
cyB0aGUgZm9sbG93aW5nIHBsYXRmb3JtLXNwZWNpZmljIGRldGFpbHM6DQo+ID4NCj4gDQo+IFRo
ZSB2YXJpYW50IHN0cnVjdHVyZSBpcyBhbHJlYWR5IHByZXNlbnQgaW4gdGhlIGRyaXZlci4gSGVu
Y2Ugbm90IGludHJvZHVjZWQgaW4gKnRoaXMqDQo+IHBhdGNoLg0KVGhhbmtzIGZvciByZXZpZXcs
IHdpbGwgdXBkYXRlIHRoaXMgaW4gbmV4dCBwYXRjaC4NCg0KPiA+IC0gSW50ZXJydXB0IHN0YXR1
cyByZWdpc3RlciBvZmZzZXQgKGlyX3N0YXR1cykNCj4gPiAtIEludGVycnVwdCBlbmFibGUgcmVn
aXN0ZXIgb2Zmc2V0IChpcl9lbmFibGUpDQo+ID4gLSBNaXNjZWxsYW5lb3VzIGludGVycnVwdCB2
YWx1ZXMgKGlyX21pc2NfdmFsdWUpDQo+ID4NCj4gPiBUaGUgZHJpdmVyIGRpZmZlcmVudGlhdGVz
IGJldHdlZW4gQ29udHJvbGxlciAwIGFuZCBDb250cm9sbGVyIDEgdXNpbmcNCj4gPiB0aGUgY29t
cGF0aWJsZSBzdHJpbmcgaW4gdGhlIGRldmljZSB0cmVlLiBUaGlzIGVuc3VyZXMgdGhhdCB0aGUN
Cj4gPiBhcHByb3ByaWF0ZSByZWdpc3RlciBvZmZzZXRzIGFyZSB1c2VkIGZvciBlYWNoIGNvbnRy
b2xsZXIsIGFsbG93aW5nDQo+ID4gZm9yIGNvcnJlY3QgaGFuZGxpbmcgb2YgcGxhdGZvcm0tc3Bl
Y2lmaWMgaW50ZXJydXB0cyBhbmQgaW5pdGlhbGl6YXRpb24uDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBUaGlwcGVzd2FteSBIYXZhbGlnZSA8dGhpcHBlc3dAYW1kLmNvbT4NCj4gPiAtLS0NCj4g
PiBjaGFuZ2VzIGluIHYyOg0KPiA+IC0tLS0tLS0tLS0tLS0tDQo+ID4gMS4gSW50cm9kdWNlZCBu
ZXcgY29uc3RhbnRzIGZvciBDb250cm9sbGVyIDEuDQo+ID4gMi4gRXh0ZW5kZWQgdGhlIHhpbGlu
eF9jcG1fdmFyaWFudCBzdHJ1Y3R1cmUgdG8gc3VwcG9ydA0KPiA+IAlhLiBpcl9zdGF0dXMsDQo+
ID4gCWIuIGlyX2VuYWJsZSwgYW5kDQo+ID4gCWMuIGlyX21pc2NfdmFsdWUgZm9yIGRpZmZlcmVu
dCBjb250cm9sbGVycy4NCj4gPiAzLiBVcGRhdGVkIElSUSBoYW5kbGluZyBhbmQgaW5pdGlhbGl6
YXRpb24gdG8gdXNlIHRoZSB2YXJpYW50IHN0cnVjdHVyZS4NCj4gPiA0LiBBZGRlZCBhIG5ldyBk
ZXZpY2UgdHJlZSBtYXRjaCBlbnRyeSBmb3IgQ29udHJvbGxlciAxLg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LWNwbS5jIHwgNDcNCj4gPiArKysrKysr
KysrKysrKysrKystLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyks
IDExIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS14aWxpbngtY3BtLmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
ZS14aWxpbngtY3BtLmMNCj4gPiBpbmRleCBhMGY1ZTFkNjdiMDQuLmI3ODNmZmYyN2M5ZCAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LWNwbS5jDQo+
ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXhpbGlueC1jcG0uYw0KPiA+IEBA
IC0zMCwxMSArMzAsMTQgQEANCj4gPiAgI2RlZmluZSBYSUxJTlhfQ1BNX1BDSUVfUkVHX0lEUk5f
TUFTSwkweDAwMDAwRTNDDQo+ID4gICNkZWZpbmUgWElMSU5YX0NQTV9QQ0lFX01JU0NfSVJfU1RB
VFVTCTB4MDAwMDAzNDANCj4gPiAgI2RlZmluZSBYSUxJTlhfQ1BNX1BDSUVfTUlTQ19JUl9FTkFC
TEUJMHgwMDAwMDM0OA0KPiA+IC0jZGVmaW5lIFhJTElOWF9DUE1fUENJRV9NSVNDX0lSX0xPQ0FM
CUJJVCgxKQ0KPiA+ICsjZGVmaW5lIFhJTElOWF9DUE1fUENJRTBfTUlTQ19JUl9MT0NBTAlCSVQo
MSkNCj4gPiArI2RlZmluZSBYSUxJTlhfQ1BNX1BDSUUxX01JU0NfSVJfTE9DQUwJQklUKDIpDQo+
ID4NCj4gPiAtI2RlZmluZSBYSUxJTlhfQ1BNX1BDSUVfSVJfU1RBVFVTICAgICAgIDB4MDAwMDAy
QTANCj4gPiAtI2RlZmluZSBYSUxJTlhfQ1BNX1BDSUVfSVJfRU5BQkxFICAgICAgIDB4MDAwMDAy
QTgNCj4gPiAtI2RlZmluZSBYSUxJTlhfQ1BNX1BDSUVfSVJfTE9DQUwgICAgICAgIEJJVCgwKQ0K
PiA+ICsjZGVmaW5lIFhJTElOWF9DUE1fUENJRTBfSVJfU1RBVFVTCTB4MDAwMDAyQTANCj4gPiAr
I2RlZmluZSBYSUxJTlhfQ1BNX1BDSUUxX0lSX1NUQVRVUwkweDAwMDAwMkI0DQo+ID4gKyNkZWZp
bmUgWElMSU5YX0NQTV9QQ0lFMF9JUl9FTkFCTEUJMHgwMDAwMDJBOA0KPiA+ICsjZGVmaW5lIFhJ
TElOWF9DUE1fUENJRTFfSVJfRU5BQkxFCTB4MDAwMDAyQkMNCj4gPiArI2RlZmluZSBYSUxJTlhf
Q1BNX1BDSUVfSVJfTE9DQUwJQklUKDApDQo+ID4NCj4gPiAgI2RlZmluZSBJTVIoeCkgQklUKFhJ
TElOWF9QQ0lFX0lOVFJfICMjeCkNCj4gPg0KPiA+IEBAIC04MCw2ICs4Myw3IEBADQo+ID4gIGVu
dW0geGlsaW54X2NwbV92ZXJzaW9uIHsNCj4gPiAgCUNQTSwNCj4gPiAgCUNQTTUsDQo+ID4gKwlD
UE01X0hPU1QxLA0KPiA+ICB9Ow0KPiA+DQo+ID4gIC8qKg0KPiA+IEBAIC04OCw2ICs5Miw5IEBA
IGVudW0geGlsaW54X2NwbV92ZXJzaW9uIHsNCj4gPiAgICovDQo+ID4gIHN0cnVjdCB4aWxpbnhf
Y3BtX3ZhcmlhbnQgew0KPiA+ICAJZW51bSB4aWxpbnhfY3BtX3ZlcnNpb24gdmVyc2lvbjsNCj4g
PiArCXUzMiBpcl9zdGF0dXM7DQo+ID4gKwl1MzIgaXJfZW5hYmxlOw0KPiA+ICsJdTMyIGlyX21p
c2NfdmFsdWU7DQo+IA0KPiBLZG9jIGNvbW1lbnRzIG1pc3NpbmcgZm9yIHRoZXNlIG1lbWJlcnMu
DQpUaGFua3MgZm9yIHJldmlldywgd2lsbCB1cGRhdGUgdGhpcyBpbiBuZXh0IHBhdGNoLg0KPiAN
Cj4gPiAgfTsNCj4gPg0KPiA+ICAvKioNCj4gPiBAQCAtMjY5LDYgKzI3Niw3IEBAIHN0YXRpYyB2
b2lkIHhpbGlueF9jcG1fcGNpZV9ldmVudF9mbG93KHN0cnVjdA0KPiA+IGlycV9kZXNjICpkZXNj
KSAgew0KPiA+ICAJc3RydWN0IHhpbGlueF9jcG1fcGNpZSAqcG9ydCA9IGlycV9kZXNjX2dldF9o
YW5kbGVyX2RhdGEoZGVzYyk7DQo+ID4gIAlzdHJ1Y3QgaXJxX2NoaXAgKmNoaXAgPSBpcnFfZGVz
Y19nZXRfY2hpcChkZXNjKTsNCj4gPiArCWNvbnN0IHN0cnVjdCB4aWxpbnhfY3BtX3ZhcmlhbnQg
KnZhcmlhbnQgPSBwb3J0LT52YXJpYW50Ow0KPiA+ICAJdW5zaWduZWQgbG9uZyB2YWw7DQo+ID4g
IAlpbnQgaTsNCj4gPg0KPiA+IEBAIC0yNzksMTEgKzI4NywxMSBAQCBzdGF0aWMgdm9pZCB4aWxp
bnhfY3BtX3BjaWVfZXZlbnRfZmxvdyhzdHJ1Y3QgaXJxX2Rlc2MNCj4gKmRlc2MpDQo+ID4gIAkJ
Z2VuZXJpY19oYW5kbGVfZG9tYWluX2lycShwb3J0LT5jcG1fZG9tYWluLCBpKTsNCj4gPiAgCXBj
aWVfd3JpdGUocG9ydCwgdmFsLCBYSUxJTlhfQ1BNX1BDSUVfUkVHX0lEUik7DQo+ID4NCj4gPiAt
CWlmIChwb3J0LT52YXJpYW50LT52ZXJzaW9uID09IENQTTUpIHsNCj4gPiAtCQl2YWwgPSByZWFk
bF9yZWxheGVkKHBvcnQtPmNwbV9iYXNlICsNCj4gWElMSU5YX0NQTV9QQ0lFX0lSX1NUQVRVUyk7
DQo+ID4gKwlpZiAodmFyaWFudC0+aXJfc3RhdHVzKSB7DQo+ID4gKwkJdmFsID0gcmVhZGxfcmVs
YXhlZChwb3J0LT5jcG1fYmFzZSArIHZhcmlhbnQtPmlyX3N0YXR1cyk7DQo+ID4gIAkJaWYgKHZh
bCkNCj4gPiAgCQkJd3JpdGVsX3JlbGF4ZWQodmFsLCBwb3J0LT5jcG1fYmFzZSArDQo+ID4gLQkJ
CQkJICAgIFhJTElOWF9DUE1fUENJRV9JUl9TVEFUVVMpOw0KPiA+ICsJCQkJICAgICAgIHZhcmlh
bnQtPmlyX3N0YXR1cyk7DQo+ID4gIAl9DQo+ID4NCj4gPiAgCS8qDQo+ID4gQEAgLTQ2NSw2ICs0
NzMsOCBAQCBzdGF0aWMgaW50IHhpbGlueF9jcG1fc2V0dXBfaXJxKHN0cnVjdCB4aWxpbnhfY3Bt
X3BjaWUNCj4gKnBvcnQpDQo+ID4gICAqLw0KPiA+ICBzdGF0aWMgdm9pZCB4aWxpbnhfY3BtX3Bj
aWVfaW5pdF9wb3J0KHN0cnVjdCB4aWxpbnhfY3BtX3BjaWUgKnBvcnQpDQo+ID4gew0KPiA+ICsJ
Y29uc3Qgc3RydWN0IHhpbGlueF9jcG1fdmFyaWFudCAqdmFyaWFudCA9IHBvcnQtPnZhcmlhbnQ7
DQo+ID4gKw0KPiA+ICAJaWYgKGNwbV9wY2llX2xpbmtfdXAocG9ydCkpDQo+ID4gIAkJZGV2X2lu
Zm8ocG9ydC0+ZGV2LCAiUENJZSBMaW5rIGlzIFVQXG4iKTsNCj4gPiAgCWVsc2UNCj4gPiBAQCAt
NDgzLDE1ICs0OTMsMTUgQEAgc3RhdGljIHZvaWQgeGlsaW54X2NwbV9wY2llX2luaXRfcG9ydChz
dHJ1Y3QNCj4geGlsaW54X2NwbV9wY2llICpwb3J0KQ0KPiA+ICAJICogWElMSU5YX0NQTV9QQ0lF
X01JU0NfSVJfRU5BQkxFIHJlZ2lzdGVyIGlzIG1hcHBlZCB0bw0KPiA+ICAJICogQ1BNIFNMQ1Ig
YmxvY2suDQo+ID4gIAkgKi8NCj4gPiAtCXdyaXRlbChYSUxJTlhfQ1BNX1BDSUVfTUlTQ19JUl9M
T0NBTCwNCj4gPiArCXdyaXRlbCh2YXJpYW50LT5pcl9taXNjX3ZhbHVlLA0KPiA+ICAJICAgICAg
IHBvcnQtPmNwbV9iYXNlICsgWElMSU5YX0NQTV9QQ0lFX01JU0NfSVJfRU5BQkxFKTsNCj4gPg0K
PiA+IC0JaWYgKHBvcnQtPnZhcmlhbnQtPnZlcnNpb24gPT0gQ1BNNSkgew0KPiA+ICsJaWYgKHZh
cmlhbnQtPmlyX2VuYWJsZSkgew0KPiA+ICAJCXdyaXRlbChYSUxJTlhfQ1BNX1BDSUVfSVJfTE9D
QUwsDQo+ID4gLQkJICAgICAgIHBvcnQtPmNwbV9iYXNlICsgWElMSU5YX0NQTV9QQ0lFX0lSX0VO
QUJMRSk7DQo+ID4gKwkJICAgICAgIHBvcnQtPmNwbV9iYXNlICsgdmFyaWFudC0+aXJfZW5hYmxl
KTsNCj4gPiAgCX0NCj4gPg0KPiA+IC0JLyogRW5hYmxlIHRoZSBCcmlkZ2UgZW5hYmxlIGJpdCAq
Lw0KPiA+ICsJLyogU2V0IEJyaWRnZSBlbmFibGUgYml0ICovDQo+IA0KPiBUaGlzIGNoYW5nZXMg
ZG9lc24ndCBiZWxvbmcgdG8gdGhpcyBwYXRjaC4NClRoYW5rcyBmb3IgcmV2aWV3LCB3aWxsIHVw
ZGF0ZSB0aGlzIGluIG5leHQgcGF0Y2guDQo+IA0KPiA+ICAJcGNpZV93cml0ZShwb3J0LCBwY2ll
X3JlYWQocG9ydCwgWElMSU5YX0NQTV9QQ0lFX1JFR19SUFNDKSB8DQo+ID4gIAkJICAgWElMSU5Y
X0NQTV9QQ0lFX1JFR19SUFNDX0JFTiwNCj4gPiAgCQkgICBYSUxJTlhfQ1BNX1BDSUVfUkVHX1JQ
U0MpOw0KPiA+IEBAIC02MDksMTAgKzYxOSwyMSBAQCBzdGF0aWMgaW50IHhpbGlueF9jcG1fcGNp
ZV9wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4NCj4gPiAgc3Rh
dGljIGNvbnN0IHN0cnVjdCB4aWxpbnhfY3BtX3ZhcmlhbnQgY3BtX2hvc3QgPSB7DQo+ID4gIAku
dmVyc2lvbiA9IENQTSwNCj4gPiArCS5pcl9taXNjX3ZhbHVlID0gWElMSU5YX0NQTV9QQ0lFMF9N
SVNDX0lSX0xPQ0FMLA0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgeGls
aW54X2NwbV92YXJpYW50IGNwbTVfaG9zdCA9IHsNCj4gPiAgCS52ZXJzaW9uID0gQ1BNNSwNCj4g
PiArCS5pcl9taXNjX3ZhbHVlID0gWElMSU5YX0NQTV9QQ0lFMF9NSVNDX0lSX0xPQ0FMLA0KPiA+
ICsJLmlyX3N0YXR1cyA9IFhJTElOWF9DUE1fUENJRTBfSVJfU1RBVFVTLA0KPiA+ICsJLmlyX2Vu
YWJsZSA9IFhJTElOWF9DUE1fUENJRTBfSVJfRU5BQkxFLCB9Ow0KPiA+ICsNCj4gPiArc3RhdGlj
IGNvbnN0IHN0cnVjdCB4aWxpbnhfY3BtX3ZhcmlhbnQgY3BtNV9ob3N0MSA9IHsNCj4gPiArCS52
ZXJzaW9uID0gQ1BNNV9IT1NUMSwNCj4gPiArCS5pcl9taXNjX3ZhbHVlID0gWElMSU5YX0NQTV9Q
Q0lFMV9NSVNDX0lSX0xPQ0FMLA0KPiA+ICsJLmlyX3N0YXR1cyA9IFhJTElOWF9DUE1fUENJRTFf
SVJfU1RBVFVTLA0KPiA+ICsJLmlyX2VuYWJsZSA9IFhJTElOWF9DUE1fUENJRTFfSVJfRU5BQkxF
LA0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHhp
bGlueF9jcG1fcGNpZV9vZl9tYXRjaFtdID0geyBAQA0KPiA+IC02MjQsNiArNjQ1LDEwIEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHhpbGlueF9jcG1fcGNpZV9vZl9tYXRjaFtd
DQo+ID0gew0KPiA+ICAJCS5jb21wYXRpYmxlID0gInhsbngsdmVyc2FsLWNwbTUtaG9zdCIsDQo+
ID4gIAkJLmRhdGEgPSAmY3BtNV9ob3N0LA0KPiA+ICAJfSwNCj4gPiArCXsNCj4gPiArCQkuY29t
cGF0aWJsZSA9ICJ4bG54LHZlcnNhbC1jcG01LWhvc3QxLTEiLA0KPiANCj4gVGhpcyBkb2Vzbid0
IGxvb2sgbGlrZSBhIHZhbGlkIGNvbXBhdGlibGUgbmFtZS4gUGxlYXNlIHVzZSB0aGUgY29tcGF0
aWJsZSBhcyBwZXINCj4gdGhlIElQIHZlcnNpb24uDQpUaGFua3MsIEhlcmUgd2UgZG9uJ3QgaGF2
ZSBhbnkgSVAgdmVyc2lvbmluZyBmb3IgQ1BNNSwgc28gSSBsbCBtYWtlIGNvbXBhdGlibGUgc3Ry
aW5nIGFzIHhsbngsdmVyc2FsLWNwbTUtaG9zdDEgYXMgdXBkYXRlZCB0byBLcnp5c3p0b2YgS296
bG93c2tpLiANCj4gDQo+IC0gTWFuaQ0KPiANCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+Cv
jeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

