Return-Path: <linux-pci+bounces-30016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07763ADE525
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 10:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EC43B0CFC
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 08:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18A823504B;
	Wed, 18 Jun 2025 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ippkTkhr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238CC21A447;
	Wed, 18 Jun 2025 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750234061; cv=fail; b=U9M9IBx8FuTLj7URzw23aFaPPTd7vNyExYKtZqMGaqfdk6/jxb6Jol52g+ubUwiCheKkZS2dJ5Omar6ppPUloleKIOwAzZEI+EwnBe2ZOOoaEH/7D8TJwrN5+OgmzL7PPteECCipZAjpTNXh6phs4YeKqJmmtx73u8BkTX67R2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750234061; c=relaxed/simple;
	bh=MqNBx3GpKwwhGCgwsznp7Km6aHVanEZgMkA37Ir4yps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FtlBCa+HAO4eluBaytvVosrFhl+b5gBqtfBrpuSYioI0MNZI9Gg0Fb8PmSPPCvOApd6VOecZ4Sp8jz18BHbb44UZjOFGomYLOvZ8Aa5IVXzsQMfNjiO98Nz+zkpx5wUTCCi6yg4ksB2Z5e+zcI1/NQD17dTf+MlU8uagb61BIw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ippkTkhr; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjWa5TWqzoLUW23csaZdyi2zjCODlfKcTzbmx3+vAdtfM0Mr7cLl/3rxAbHsJcOPMEcpYVr6zN6b5ZshTIutCER+KjohTpJ9Z6dR8XVHfY6REEysmvY27lzsOaBENjPPdcNCLWhFgZwZSktXKlsKpDw89j9wyXpOy5c7UcTnaVreJRN7a1WWsJNPQ2O7XHs+pNFHuUERc2x3z5jVuUZy8a+J2K5YBb33EaSpT0gDLlaxf9b/6bAM+dS77RXd6IayNYoVpV63lbV9I5CgsTbV8n+WJa7bPVAaBc5j0bBMOYMxbdUNbdpAREJaQdaiheMViJJlCXPogi55d8I5Wh4a7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqNBx3GpKwwhGCgwsznp7Km6aHVanEZgMkA37Ir4yps=;
 b=nSQMN9uBvpOYOpYeG+CwDnAyH2inmrBZi6uZuAJ9U0HbQG67xWOSr8vdPVNg2SFsp/6d18nHUD43qrraF47BrfeLog99Vb6FKC/BAB4rLJUkGCJJGFMdbLhkSstQm6D6YaIbeLDFWZOecBuImi6wJKl1adFT3VLemDtbLw2CjxhxtUiJf2qce9YDk76fnduo0P60cMWrifD4vQP9VVv0VZEilaiAVosabey/pZXI0QOVz2imEbUXiDX47JqjwFVSYIXSPJ8lmCQYzT9IzuEzXr/9mTdP3ITAiE7fdnxY+hsPQPTTzPvGsIT6+6dHsoGx7rxBL7ithP2sFSS69c8yHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqNBx3GpKwwhGCgwsznp7Km6aHVanEZgMkA37Ir4yps=;
 b=ippkTkhrucgm/L+MuxQQi/sclOF4LkrIVV8apwIqEKhAu8hM2+ojqoDQe34ediY7MPL2g46OrZPpP2kSyN7w+bL9d9BKJgiYqguqVrBtmO+L9wJr0+ITYvaldXxHUWkRIgtNmdOUBlqCmZbSb2lzSF6nRPMe7U6RPSrwvu87Diw=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 08:07:33 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 08:07:33 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cassel@kernel.org"
	<cassel@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: PCI: amd-mdb: Add `reset-gpios`
 property to example device tree
Thread-Topic: [PATCH v2 1/2] dt-bindings: PCI: amd-mdb: Add `reset-gpios`
 property to example device tree
Thread-Index: AQHbuOU/72lKYCE0TESPrB2OyPeFPrO/ewkAgEliiVA=
Date: Wed, 18 Jun 2025 08:07:32 +0000
Message-ID:
 <DM4PR12MB615841D65A4A6716DF8A8398CD72A@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250429090046.1512000-1-sai.krishna.musham@amd.com>
 <20250429090046.1512000-2-sai.krishna.musham@amd.com>
 <ph5rby7y3jnu4fnbhiojesu6dsnre63vc4hmsjyasajrvurj6g@g6eo7lvjtuax>
In-Reply-To: <ph5rby7y3jnu4fnbhiojesu6dsnre63vc4hmsjyasajrvurj6g@g6eo7lvjtuax>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-18T08:04:57.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|SJ2PR12MB7941:EE_
x-ms-office365-filtering-correlation-id: b504a785-6421-49aa-c299-08ddae3f2dbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZVU2eUtmQ3Y2T2dXRGdFK1h3WW5uRXIvblczVEE5ZEZ0SDRZS2VvUnhHN05E?=
 =?utf-8?B?TWxNeGVudEVFeEZDSm8zZlpVWmM4Um42aGxBT213dWxiSUd3czZiQUIyVUoz?=
 =?utf-8?B?Z0RlT0NnTndVSGdrQTFKZlFoRGZaenAyNFFHSC90UWdEY0FvSmgrc0FlcEFB?=
 =?utf-8?B?VlFIbFp2OXZFMVVSWnNZbnUxa05QVHA3VS8wSEhUdXpUTGcydjJ2VXpLVFpV?=
 =?utf-8?B?aGNWbVRCUE90MkJWYndmOWlGQ0sycGNmMUtzcVRhRC9xUGcwcXZQb09GWDVw?=
 =?utf-8?B?Qy9BMnFUQUp6U1VrNVRYVUZHeUl6dEs3VlU2eU8wek5yT1VUZS9OL3hHdXNM?=
 =?utf-8?B?cTc4bXVCdm5SUGFFbThzVjdxVzJMc2V3QnVNY3RQTHUwQzV0SVpUcll6Rm80?=
 =?utf-8?B?QitpOTlpTjQxckgzazZueUpWenY4d0Z4SGNUUm5ubXpYVFpGaGQ4Y2RuOFUw?=
 =?utf-8?B?Tk93QlVoR01pMmhLUDVrV3UvekRBUGdwUnRnMTc0K0NSaE1TTU4za3FpMXBy?=
 =?utf-8?B?ZlpUZDFkU3JWb1k5c0Q3d1JJUC93T3ZPNHJIaWJ5WDJXOE1YYmNJVlRudVZl?=
 =?utf-8?B?V1g0SzZoSC9tWkR6UStRd3k4V0VWcDlDUElDQXRsODlSeW0yVXJBRHFkUUNL?=
 =?utf-8?B?L3A3aFFQMUVkckpvOUxTTjZtZ0FzQnFoMVFVSittaTNJQk5YMGVVT3ozeVFO?=
 =?utf-8?B?QTJ4dmpZakp5Q0UxZjZQelVFR3ZYT3pFZEprZ2dJYmVGOWtjMG1BYzZMVnQ4?=
 =?utf-8?B?ejBJQ0dITkFLdkRVVGQzdHlCOHZLMVBYTVhtMUF4enUyTjhpSm5MWmtwbEpo?=
 =?utf-8?B?bUZaS0dHUVBlNnB1YkVITDltOStFdkdTczVycjk0bC9wOVJzN2pBTjVzMnJT?=
 =?utf-8?B?aGxVc3lQektyTXFnMmhaZlcvaXBQMGhxcUNyd1JpcHNEVGZSZjJSMjVUSzNj?=
 =?utf-8?B?RGJ2dmRnN1RaY25vT2FKdXVMY0VXRjRvck1VOHFSVUlxcVo1ZEhaVEd4YWl2?=
 =?utf-8?B?T3Nyek9lVDdpQmc0NVNhcU9JNjQ0eUpBVUNRTTNicDBGdHJham9xQ1d3QTF5?=
 =?utf-8?B?MzFFWm9TWitXdXRVeHAraHRXdW5GZ3FBNHJTL3JralZJaEYxd09iQlVzWXRr?=
 =?utf-8?B?dEwrZjNJVHE1MllTb1FJOUxBa1hPZzQrRVRXWTNBZXptc1hjdmRJVy94b1Vl?=
 =?utf-8?B?SS9DK2FNUkREY0ZQd3hTZS9NQm90QTMwcGJCUDRRRDRvZ2toNHZPV3JoTEt1?=
 =?utf-8?B?d0k2V2JrZG9MSVBkZEJZNmJnTVpjQkNIZjErWnFhUWxqK1ExNlRWNHhjaS80?=
 =?utf-8?B?Y3YvUU9GRkpwQy9Zek12SzFlVHorTGttOTExaDBrMmJ4Yk5GakQ5T1RReHhh?=
 =?utf-8?B?NXJ0dk4rZXIxRmZrdlR3ajlKQzhTU1dCdVFkSDNLdGY4d0t0NkMramNsdVhM?=
 =?utf-8?B?Mm8yUHBmVzgybFZURGV4dWdYaWxJQytXbXgzQjQwOU9zS3lTd3ZsbHk4NHBo?=
 =?utf-8?B?bThjNHd0NWFWODRMcHAwVnBxYkE0b0I2Tks1dHlvN3B2L2t5UFplcjhRamZJ?=
 =?utf-8?B?dThOMUZMYWdoUGY3UDAxS2NTbGx4RDdJQ0d6Tm52RlIwYzR4bE1BVnhTa2xj?=
 =?utf-8?B?Y0tqNEZQbTdmenFpUFZTL1pKWDcvWmU3ejg5a1RYcVp4UWp3bmg1RnFzTzUv?=
 =?utf-8?B?SGtuY0gvZGdvdnQ0UzAzK0Jsa3RKM3NtNnJuMnBnTFNUWlo4VEJxTjljZG9r?=
 =?utf-8?B?Yll6eFNDS1F3Mk1mVDVEOXBQdVo0dVh0MWcwYmpvTFhLZFZpMnFyZ1d0WkZW?=
 =?utf-8?B?R3M0TC8wZWVLa2lsUVdsaENtRXhMOFBxMXNWdStYbkNreUVBU1UwMlRLUith?=
 =?utf-8?B?YmV1MEgvWVJ5bWF1M3hSNnlxNElSUFJjVEJ3c002TU9yUjFvTE5QZmI4bytq?=
 =?utf-8?B?YlpJOHE5SVZRUDZ2QjE3c1diVEQ4SU1hTEpCNzNYeEVwY3FRTHgybXBQVHdP?=
 =?utf-8?Q?wqNY05/u8/T1mZue9nX+96Dqi2T/V8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vk0yRGxTcFROazNBOWwwdjAwRXdDMzc3K2l5L2xFakhqSXBoWFpLaFFIcTZv?=
 =?utf-8?B?UFNZNm13eS8vM0VPTW1JSGN2WjJ5MUwvc1h2OWtyVlMzaS9TSjNSa2s4VXdV?=
 =?utf-8?B?OFNYUTFNUEM1aHNrWjhzK2ExTDNiS3ZWRm14WmJudUtxVXlUNHFucnhhbGlq?=
 =?utf-8?B?RnhueDdlU1VCdjl0MUh2dWsyZkd3YVgxVVpIeG1kSlQ5cEZGOTR4N2Robjl6?=
 =?utf-8?B?TEpNWFJCbDhZRUJ0RE4wdUpCejNzUmVIRU5paCtYem9tRU5pQXgrWWx2My9j?=
 =?utf-8?B?MlUzTTEzTjl5V1FGd1hpYWFzYkx4RXBxZUE5Vm92OXI2NzhCYUd6emZCUStM?=
 =?utf-8?B?S1VSQ0FsSGRvOGlHck11TVhQNk1tZjg3RytxRTlNMm1uYmlNSStDd3VhcFBO?=
 =?utf-8?B?OFhPRG1KOUxkQ3diT25laklZT0xaNXIxbEZTOENGdFM4Kyszcyt3MjFDN2Ev?=
 =?utf-8?B?d0MyekdhMnIycEF1TmFFOFZacFpXNld5dDF0S21ZRjZuVjkwR2gvQWJEOVBm?=
 =?utf-8?B?S0hTWXRYQTUyNVV6ZEx3MUYwYkJYZ2h4RS92RGlhbmx5Q0ovWXZsbjRHdW9o?=
 =?utf-8?B?eDBXOVpmUCs0NVo5N05sYWFiMXFhTlFUT2k1cWNCTC9LTUlDd3NRZ0d5R3du?=
 =?utf-8?B?U1loaU0rQk1RSGJlR0JIVkMzNHRHOEsrMGhuZUU4bm4wSk5CdnVyYjNSaHhB?=
 =?utf-8?B?S2dPSjNqczJicDZJYmhmZ0Y2aTVnSVZzK2kxcGRQRzZTMkxzVjZyVTdRYW1X?=
 =?utf-8?B?b3Vvckg2ZGVCMkFKSzB2WXJRYWVRTW9ENVhkQmFFNmc0ZzB3enl0WjljSXI2?=
 =?utf-8?B?MnlSSWYwcnloSC9CNkU5M0NsNitNUjZiTGhYTXVpNUtxNVhJSHFpaStobEVx?=
 =?utf-8?B?NFRoZ3VRRWs3V0dxdzN4bUhVRnJWMCs3NE9BRVQzUVZvS1B2cThtODRwSDVC?=
 =?utf-8?B?cDVXRGtwbWgyeS9lbnJ0VVp1ellUVldHUlpBYmYxbVREVjFyVXBaWXZidjBV?=
 =?utf-8?B?USs3Y2RaWVJiWEFlcExmVDlIRm5xWnpwNW1xZlpobTE1ZFcvRE9zcCt6VDFE?=
 =?utf-8?B?QnJWbmYrZWw3eUZ0azI3NzhNZldDQWVEUmthSmRIblY1TldnaEdGODlKalBT?=
 =?utf-8?B?UFE2ckw3TlRWZ3pWU1dRWmFHakhKNWxTNWdKQituVC8vbnhRd2dWVS9uK2RN?=
 =?utf-8?B?NVBncXJGcFN2YW5qSkJoR0lGMmhjdWtVR2cyZWw2RW84dE0wYXBHTytXOXdX?=
 =?utf-8?B?QWI5ZVdxTVZtNWZrT2pwS0czRWJ5ZTZXRFRmQlFaQ05hSHJ5TWxoU0JhY1By?=
 =?utf-8?B?YXo0N3p6bEVXM3ZXNmdhOGkvcmFxVmgwYWVTUWtoNWRBZENGaVBEMU84OFhq?=
 =?utf-8?B?SEFXdlorQVJxRGdxbkMyVUVVb0J3RkN4QzhWbUQyVllwcTlFTHIxOHBxc21O?=
 =?utf-8?B?NnVybXZIeWRqUTlyUHFlYmpFdmNkMk1uU0ZJWXhQV256ajRydlFHcldObFNp?=
 =?utf-8?B?TlA4UDl6RTZTNEQ5Vm0wTGM3cUhwZCtkT1RqYWRUVGdhS3ZJWG5SU1FjRXpE?=
 =?utf-8?B?VWVmMHJMVE5Hc1Qzd3ZRbmdHZXFzanQrYWduc2lmTS9rRW4rYWo2cmpYa0g2?=
 =?utf-8?B?M0ZpUnJ3NXRIUmF6elVLNUFua3FVVDhVUmJySTYrNDM4Tlp1clRJdlA2WXgr?=
 =?utf-8?B?bkNxcGc1Vzh4cmFFWEovTWJreEFib2haUEpJdVljRkJlVVlZV21yY0gvVGtJ?=
 =?utf-8?B?RmE2a2RGaW5mUytmRmhJdnBocW1WQjJkUHBBaFRmdExQWEhYelBvUmZpYkN5?=
 =?utf-8?B?TEplN3d5eDF4NkdrcDBuT0lYUTNaSTZLQURNNTNkdUt5U25oYUdsSmNoRWhz?=
 =?utf-8?B?L05aMWhiUDhzUUhVOWkvdjRPSUJ4NmtqZnJicTlxUjZLaU4vS242L2REcWxy?=
 =?utf-8?B?N0dvakpRYXd6d0g3aHdVVDRIUGVqOW44MTV6N3AxeFFvTGdTUlZoQUxadHVl?=
 =?utf-8?B?R1pMK0xTTVgwMDNQbUtHTnlOQ2NoekQ1ampSL3lVUXgvZVJsdzI2Rmp5Mm94?=
 =?utf-8?B?NlUvbWdjVzA4V2dMU2l6OFZaNm14U1BjUW8rNTV5NTU5K3ZPN1pIcm8xYkxv?=
 =?utf-8?Q?G/5o=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b504a785-6421-49aa-c299-08ddae3f2dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 08:07:32.9608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iaIz5sSArBGBdiVMt+Y3s4HeKSbCpZ3eLHmQsdmpwAnHBeyMLKvE6G2nx+FUajv57KLcpEmbg8dvor683UWBsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTWFuaXZhbm5hbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3Jn
Pg0KPiBTZW50OiBGcmlkYXksIE1heSAyLCAyMDI1IDg6NTUgUE0NCj4gVG86IE11c2hhbSwgU2Fp
IEtyaXNobmEgPHNhaS5rcmlzaG5hLm11c2hhbUBhbWQuY29tPg0KPiBDYzogYmhlbGdhYXNAZ29v
Z2xlLmNvbTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd0BsaW51eC5jb207IHJvYmhAa2VybmVs
Lm9yZzsNCj4ga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBjYXNzZWxA
a2VybmVsLm9yZzsgbGludXgtDQo+IHBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBTaW1laywgTWlj
aGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEdvZ2FkYSwgQmhhcmF0IEt1bWFyDQo+IDxiaGFy
YXQua3VtYXIuZ29nYWRhQGFtZC5jb20+OyBIYXZhbGlnZSwgVGhpcHBlc3dhbXkNCj4gPHRoaXBw
ZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8yXSBk
dC1iaW5kaW5nczogUENJOiBhbWQtbWRiOiBBZGQgYHJlc2V0LWdwaW9zYCBwcm9wZXJ0eQ0KPiB0
byBleGFtcGxlIGRldmljZSB0cmVlDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5h
dGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBv
cGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4N
Cj4gT24gVHVlLCBBcHIgMjksIDIwMjUgYXQgMDI6MzA6NDVQTSArMDUzMCwgU2FpIEtyaXNobmEg
TXVzaGFtIHdyb3RlOg0KPiA+IEFkZCBgcmVzZXQtZ3Bpb3NgIHByb3BlcnR5IHRvIHRoZSBleGFt
cGxlIGRldmljZSB0cmVlIG5vZGUgZm9yDQo+ID4gR1BJTy1iYXNlZCBoYW5kbGluZyBvZiB0aGUg
UENJZSBSb290IFBvcnQgKFJQKSBQRVJTVCMgc2lnbmFsLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogU2FpIEtyaXNobmEgTXVzaGFtIDxzYWkua3Jpc2huYS5tdXNoYW1AYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0gVXBkYXRlIGNvbW1pdCBtZXNzYWdlDQo+ID4g
LS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvYW1kLHZlcnNh
bDItbWRiLWhvc3QueWFtbCB8IDINCj4gPiArKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGNpL2FtZCx2ZXJzYWwyLW1kYi1ob3N0LnlhbWwNCj4gPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvYW1kLHZlcnNhbDItbWRiLWhvc3QueWFt
bA0KPiA+IGluZGV4IDQzZGMyNTg1YzIzNy4uZTYxMTdkMzI2Mjc5IDEwMDY0NA0KPiA+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvYW1kLHZlcnNhbDItbWRiLWhv
c3QueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
YW1kLHZlcnNhbDItbWRiLWhvc3QueWFtbA0KPiA+IEBAIC04Nyw2ICs4Nyw3IEBAIGV4YW1wbGVz
Og0KPiA+ICAgIC0gfA0KPiA+ICAgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1j
b250cm9sbGVyL2FybS1naWMuaD4NCj4gPiAgICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRl
cnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9n
cGlvL2dwaW8uaD4NCj4gPg0KPiA+ICAgICAgc29jIHsNCj4gPiAgICAgICAgICAjYWRkcmVzcy1j
ZWxscyA9IDwyPjsNCj4gPiBAQCAtMTEyLDYgKzExMyw3IEBAIGV4YW1wbGVzOg0KPiA+ICAgICAg
ICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPiAgICAgICAgICAgICAgI2ludGVycnVwdC1j
ZWxscyA9IDwxPjsNCj4gPiAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAicGNpIjsNCj4gPiAr
ICAgICAgICAgICAgcmVzZXQtZ3Bpb3MgPSA8JnRjYTY0MTZfdTM3IDcgR1BJT19BQ1RJVkVfTE9X
PjsNCj4NCj4gWW91IHNob3VsZCBtb3ZlIHRoaXMgcHJvcGVydHkgdG8gdGhlIFBDSSBicmlkZ2Ug
bm9kZSB3aGVyZSBpdCBiZWxvbmdzIHRvLiBXZQ0KPiBpZGVudGlmaWVkIHRoaXMgaXNzdWUgb2Yg
c3R1ZmZpbmcgYnJpZGdlIHNwZWNpZmljIHByb3BlcnRpZXMgdG8gdGhlIGNvbnRyb2xsZXIgbm9k
ZQ0KPiByZWNlbnRseSAoeWVhaCB2ZXJ5IGxhdGUgdGhvdWdoKSwgYnV0IHNpbmNlIHRoaXMgY29u
dHJvbGxlciBkb2Vzbid0IGhhdmUgYW55IGJyaWRnZQ0KPiBzcGVjaWZpYyBwcm9wZXJ0aWVzIHRp
bGwgbm93LCBJJ2QgbGlrZSBpdCB0byBkbyB0aGUgcmlnaHQgdGhpbmcuDQo+DQo+IFNvIHBsZWFz
ZSByZWZlciB0aGUgU1RNMzIgc2VyZWllcyBvbiBob3cgdG8gZG8gaXQgWzFdWzJdLiBPbiB0aGUg
ZHJpdmVyIHNpZGUsIHlvdQ0KPiBzcGVjaWZpY2FsbHkgbmVlZCB0byBpbXBsZW1lbnQgYW4gZXF1
aXZhbGVudCBvZiBzdG0zMl9wY2llX3BhcnNlX3BvcnQoKSBpbiB0aGF0DQo+IHBhdGNoIHRoYXQg
cGFyc2VzIHRoZSBicmlkZ2Ugbm9kZShzKSBmb3IgdGhlc2UgcHJvcGVydGllcy4NCj4NCj4gLSBN
YW5pDQo+DQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvMjAyNTA0MjMw
OTAxMTkuNDAwMzcwMC0yLQ0KPiBjaHJpc3RpYW4uYnJ1ZWxAZm9zcy5zdC5jb20vDQo+IFsyXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvMjAyNTA0MjMwOTAxMTkuNDAwMzcwMC0z
LQ0KPiBjaHJpc3RpYW4uYnJ1ZWxAZm9zcy5zdC5jb20vDQo+DQoNClRoYW5rcyBmb3IgdGhlIHJl
ZmVyZW5jZSwgSSBoYXZlIG1vdmVkIHJlc2V0LWdwaW9zIHRvIFBDSSBicmlkZ2Ugbm9kZSwgd2ls
bCBzZW5kDQppdCBpbiBuZXh0IHBhdGNoLg0KDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCu
o+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg0KUmVnYXJkcywNClNhaSBLcmlzaG5h
DQo=

