Return-Path: <linux-pci+bounces-24508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27974A6D751
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDD61893545
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 09:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7215925D915;
	Mon, 24 Mar 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JyLx4e83"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F90525D902;
	Mon, 24 Mar 2025 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808584; cv=fail; b=EcU2RY0ilQL2gbtA4c2jDyKm5dwhTKMf4dDeYjopBkPkxvrTT10kGS1g7fyUsWbwZca6G6sKNI/VuZwg48OL8/F3WDDE7lCmV1Rt9o1UcfkvrRgF2dFYpKAZ9CLIIkPAAJaer4VnpU3iDdh9fF59UAagemg/HcHwV+7G5yxRmmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808584; c=relaxed/simple;
	bh=ozvwvA3e1jmazxY/B3FLl3XX2HqI6DuATa4QxT8ZmJw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sSCdYUMjbf7Tw73ZL3dPhhLlHovKWci98GcGCqq0ct4bRcWQ3dckNh5vbvjs+sKUxAkP9g9RNkn4n3YzaDI5RbCA/7i8B1+aPntGgp+0Vz38Kkv1+lFx9HhGu3bhYO03kPkC1FDyiq1JkCIgAywYXmWAS42VkLBs/miKxdIxg4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JyLx4e83; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUueoOwFODpCwVTjSwoWFIRYLKW5EaZ/QjfPr1XTcOAMDVnse4LJx1ERw2Y+SzTN2GLs65W9uybcY5nw+ZR667u1vFluOS6UOhWlPix29I0zOeRs5nSBsSpdbLq8uDfAbba1PD8pbSeHCed8R4ZDmzZ/vxxqx3YNEA5PtWNU32wZrHEWqianHHTogMF50chVphNuZQIvW1iv9Vv5t7TzWJgD4bXNkP4IUOOeVQ3kGnEUhtIPWFEdXfy9iYTrinuVEnUD75Sp03H4mb3rEssv00l+JJIDGE36pfPvNsI6twLlBDXgtf6BYX0VyxHDurAdn/UvD8s8AIDWo+AHff2qCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozvwvA3e1jmazxY/B3FLl3XX2HqI6DuATa4QxT8ZmJw=;
 b=sU82cRVrFMUbnqmrO10EHhIPTBABG795eoLqqjBshstipz5Fl1FMYLFXW6Dlo2u+vet03bUKAg0T+doXZhKv/jWaOlsQge2Kg866cnUhTFK1bbJjMukVzLB6FEAc8Zyu09okpY7XRu7s+Xm/iWKNHMJM/i+ScOSakcIEzUpaUEPbX7bdRRyfIomw1lq1rcgxg5TxE/9HdPulFSPLFj/cY/t3Veafa/Vr5QjhLRxGX2+hTPLnzVtfQfAd7zSiNRciYrb39TRxTWPoZW4EcrhZoQ3aZvp4auxI813HgpPYYHmO9el8BhLtGmAIQbZvTcNGcBizFid+cdu3XuojB6TX0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozvwvA3e1jmazxY/B3FLl3XX2HqI6DuATa4QxT8ZmJw=;
 b=JyLx4e83NI7uXFUN0EjO0IzKJFzxOKtNQLkwZkX1FnzweuApQj5YwVoDpyn6El7SGZDVv75xGh6yr43r70TBwipfd49+Y4WeAsDBX2gWXFdHy3spfyOWyNoAqnZQpg697V7es58orql6QFWMXIDmtog1K9s+JYtP9yT9eEAsT24=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Mon, 24 Mar 2025 09:29:39 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:29:39 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Subject: RE: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Thread-Topic: [PATCH v4 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Thread-Index: AQHbl+f03GMFHiD8wkOYgVY3KrOC+7N9kEOAgAR8aSA=
Date: Mon, 24 Mar 2025 09:29:39 +0000
Message-ID:
 <DM4PR12MB61581827F4D90B4A23EA7401CDA42@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250318092648.2298280-1-sai.krishna.musham@amd.com>
 <20250318092648.2298280-3-sai.krishna.musham@amd.com>
 <20250321125201.2r6zcxwkivt7t6s3@thinkpad>
In-Reply-To: <20250321125201.2r6zcxwkivt7t6s3@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=63706507-2215-4979-aeff-7596b93ae04a;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-24T09:22:19Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|DS0PR12MB7972:EE_
x-ms-office365-filtering-correlation-id: d28f9718-c00c-4429-7c2f-08dd6ab66699
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGJBVW52c3FkODlVbTFTMEtWR0MxdzhVcE9aZklvc0ZoK0VhcVdTT2NyYTg2?=
 =?utf-8?B?bkJqYXUrRXA3cXdrRlRoam0vbXd2Z1dUTlJiaUY2YU1tbU5RTEk4VnU3UThZ?=
 =?utf-8?B?UGZYYWtQbUdUMENSaWRIYzNGS0lVeTBReitxUDZiV0hlT01wVXExZkZ6Z09Y?=
 =?utf-8?B?WDg2S3R5RjBEb1FaNS8yRm02am5PKzJpSUdUN3VZRFBsSHFQKzVKSzZOUXo5?=
 =?utf-8?B?TzkvUzl4aU1vS2tVck5JWElRbDBOZnNWbmh6Y3RIRzNkRDg3VXBPa2RNcUdl?=
 =?utf-8?B?L3hNQWozVElvaG9kNE05b1lZS3RYWXZvQzE1eVVWSGVqOXFHZ2tTN2Z6YUZD?=
 =?utf-8?B?WEk3S3dFSHBrb0lrZS9XbnhWZC8rSUlNU2VKNnY1M0tVbVJ1UlBEdGUrYUVL?=
 =?utf-8?B?SDhLa3VpeWJ6bFk1QkI2b1l5a3pSdDZRMUZJQXVIQi9oMWRLZkJFNDIzK1dx?=
 =?utf-8?B?aU00Y0YxNTZ5aGtjTGljL2cvaFRqbTk2cGpablJ6emVRd1NCRHllREdFek5F?=
 =?utf-8?B?TnNtYW5rMjE2M1NGV0sxMFdOeXJnUnBITEhueW01Q0ZkVHlyVDB1MEE0OXpp?=
 =?utf-8?B?bzRoOE1SKzUvckpqQlRrL21WRVh1SEYzNDdJeC9oenVYcEJnZUE1cXJFOE00?=
 =?utf-8?B?TUJhL1phK0tPZzlJUGVWWS9MY1cxbU5Kd2pVTlN3bFZJWVJ6OE1rczdSamJU?=
 =?utf-8?B?Q3dpNWZYR1A5bFZTSWNzQVNFUWlrOXRJWmVWS29mbkt0UFNxZ3RJR0NJZFdK?=
 =?utf-8?B?UThMTWpFWitTV0dWUFZ4aFNrTTRiam8rSUVjYks0cGtISDBVYmMvZThzTjdZ?=
 =?utf-8?B?cDlXRmtIdzhnSVpSeW9Ha0p5UERFb0VzamFuL1ZQd2U5ZjVBcmtaaEd6V0NY?=
 =?utf-8?B?SXpOdmVOQlc4N3IzRzVWeUhFKy85NzViWUxhWndsMUxnb1dFbWtmazdCdVRR?=
 =?utf-8?B?NHBUejFlWkFFRzdSVUVOYXpnbGtwYkF6ams3QlFyWGt6ZEpMQ3FGSWR3SGRp?=
 =?utf-8?B?VWVjNWxkS1JyMFpGck9VanpKWm52aVFlN2hpWWVBT1hSWkM1dFdzYW9QYUNB?=
 =?utf-8?B?RjNxcUt5cjhVWlJFcFgwQnRwMWJsc25UNjhOWkVBei9JcVNRWXF4RW5tNVlQ?=
 =?utf-8?B?elZTTXdCVzd0a3hEVk5NWXl3VDJkUjlEdW5QRVNBOXVhWENZUnQwN3VIVk9V?=
 =?utf-8?B?bGY4WnJsZDNjWkoyT3NNYmkyV2lRZmxnNHM1MzU4dWdVS09PS2lTZk5vT3ZV?=
 =?utf-8?B?aHBmZjBIK3VvMk5WZkx4YWFrQnlXRzBha3NTaERGUVNYc25kWWRsME1oSUJU?=
 =?utf-8?B?QW5aUjkzU1lyZFR5N29KTStvVm4yKzRYYW8vakZoNm1PeFU0QmtnUXd2N0JY?=
 =?utf-8?B?dXJDb0ZWclYwdktwcWxJZHFkK2xJKytteVZHWUlXM3krdytwZjNjcGpqYlFt?=
 =?utf-8?B?WXJDbVVuaU1ZNnBZWEp4YjVIZmszTEdEZkMvUU05enhoRUZ3dTIxcTNBMVRh?=
 =?utf-8?B?RXk1MG1NTDYwcWpzQVFwMVNmVlRIUzZxU2FKY3gxc3c4Ukh0VE94enlzbFVo?=
 =?utf-8?B?bGFHTk5MTzBwN0svT0x6azBkWEdhQlpSS0dZY0locFo0Y1FRaHJhM254bWtG?=
 =?utf-8?B?Q2cyaWtaM0NWNmFkbHN0K1BzOEpuSE90bEZkRWl2VENBM0NKYmVCcnJQQ1N5?=
 =?utf-8?B?djk0RUdZOXJQVjl1UVRRUEFNSkJ6SlY5WTU0SlB6OW10MjcxUURFcm5WUFla?=
 =?utf-8?B?dTM5M0JJNkt6U0RINnZSVUVIOEc1c3d5QzBDS3ZDV1pTRWtzSWhNZk1LSzdM?=
 =?utf-8?B?YjhuTTJ2MmRKT0hkZEZXZEE4eUg2MUIrVmhIYndQWlJhVHFLeHM0QUdidWha?=
 =?utf-8?B?RDU0dnloZjBaSGVSOXlYOGY5ZDM2b0RSV29WWE16WlNVTGlRejF2TlBEYnpP?=
 =?utf-8?Q?PiMokzIExp3ejCpLTiqSpmto7bqVrHBT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXNEMlBFRVZtTi9seGF4dzR4Z1l0UE1RN2t6UEZ0TFozRkFyMmxUVTVLb0hL?=
 =?utf-8?B?dTBUOWpzdFEvTnNERTR0VkdLNmZDVk9OUUFMUWxvVjBZbU1CKzJ6SjZ6bTdQ?=
 =?utf-8?B?ZlljRlVidGVmQTZ2dmFuekRLRkUvdGVJTE5hck5sSEdoaDJrV2pTVGRBY0NF?=
 =?utf-8?B?Y0k0R2tERmJpSXdCalg5Ly94MDhid1hyVzZwRjhZaGIyMXIrYTFveGw3ak0z?=
 =?utf-8?B?Mks3YzNaWmV5V1BoSVB0L0Uvbm4yRkJrTDVMUXk5dDV0RHlHU3hxMmdDeW5D?=
 =?utf-8?B?ZTR1NE5XTDNqMEU5N0dZZlhkYklCcGlOdXkwZkt4c3o2a01scjhBc2gvNVk1?=
 =?utf-8?B?Nno3ejdFWmZGeGNHK0lZa0ozRTByT09BYXBacko3clZFUFlsWnQ4clhFSUl0?=
 =?utf-8?B?K1cyTEJWYTFCNUpxaUxDVTlkUk5ac1k4eGV4ZGxNclcwZGtPSWV1RmNPalZs?=
 =?utf-8?B?MW5sT2l1U1ZKa09kRUhZdlBDV3ZDQXppNERzZW9VQ2pFNDZnM2crd2EzN3Q2?=
 =?utf-8?B?eDRxS2E2bFVLVlgwYXBoeU9GWnVDSTlQU1Z0dzA2YzhCTC9DOE5qTGxLVlpx?=
 =?utf-8?B?M0RlV2JpUVJGUUt5QUJMSFJvQkIxekFDUjM2dHQ4Q09pUGVIb1c0LzhxNi9C?=
 =?utf-8?B?bWRnd3VTYlBic2k1WWVKa2xMM1FMY2ZYQWxadFpyd0h4bUJURnZ3Vm5EUFN4?=
 =?utf-8?B?bE9MeGhSd041UkR0Uk1EcVdLajZPTmtxMW9vS0dJMlV1aHFiQ2tucEtscWN1?=
 =?utf-8?B?U2NuRDhjbVpGNXJQNjFNOHdZd0FwUFkwWk1DK0RVS05hcTI0TzJYcFBBNG9M?=
 =?utf-8?B?bkJ2MEZYVkpaUnVua3lJV1NmWE5sMEhHM0RMbWVNTFJBYzU1VTkwaXZaNEg4?=
 =?utf-8?B?dlZwQXcvS0E1dHpiekFPLy9ZdDc4UzY4MHdRMEczc0xTakJrdXNuT3BHWDJG?=
 =?utf-8?B?VThCK3JHVGNCa1FQelE0WHJxRXFzaStkSFRqUk1YbFExNHFmVTRJbnhLUWF4?=
 =?utf-8?B?UVFxelR6TkpXMHB1WVBwVnIwQjE5VGFZalNEK0FBMUFzR2V4NG1FZ3FxbXFj?=
 =?utf-8?B?UUtuR1Z5TVl0bVFSK1NPTGQveVRXUGQ4VmFwbHVJOTdGVjcwWDJJWVJjSFh0?=
 =?utf-8?B?TFZuWjVGT0JQMjF2MVUrcENUMWNndjhCQVI4UWN6eEVybE5xV2xXQm40TExS?=
 =?utf-8?B?TE9SWGV0MnN0VXByK2pSTE1jZFkyVlhxczE1TkFlRm5qNk5UWXhnR24yVlE3?=
 =?utf-8?B?WlUzcjljMjAxMTB6NVJ0MkxVSG43VTdsSlp1Y1ZyWUhTdlN3ZXJYb21SSkJi?=
 =?utf-8?B?UHVpQkJCSElhS3dxb09jRUs2V0lNS21pUHJ2bC95ZGl2ejRwYmJ3VFpuT3lB?=
 =?utf-8?B?Y1JUYk5JWGF1dnNrbWlNMHAzMFRNWEc5RU55ekhjY0ZDbnB0WVdhRFByQWMz?=
 =?utf-8?B?bVZwTExjN3NBSVBrWjdYVUk0MkdFdno0ME9tUThPVjJmOWgwdkExQTJkMWdu?=
 =?utf-8?B?VU9WQ1gxbGdwZU9ZTGlIN0ZJT2VweHo2ZTJ3UElSYjRUelQ2bkNraEh0Z2FG?=
 =?utf-8?B?VWFUS2MyZTlyeklES1pYNHkvb1hkeFFramU0THVEWndzMUM5MUxmdVY2ZlFT?=
 =?utf-8?B?dVllR3podVhOMXJ2N29lWnJBb1lOazFPRHFuTVIzYzE1UlBma2VzcWFFcGEz?=
 =?utf-8?B?cFlXZGFwU2xNaFpRaUlwQVdQYlVJMTgzT3J0WVNVUTJ4bkl3RWw4MVdzZ3Fj?=
 =?utf-8?B?WFJsd0trMWhPaVJaUlVHVCtCeDUvQkswNDNIZy9Xc0VnU21nOHhsRlhzTGU1?=
 =?utf-8?B?UEtBRTRTS1VUcHgvSnpsL2NHaWo4TndVcmtsV2RZcWVOZGN6eUhIN2hGVnFl?=
 =?utf-8?B?Y2lxTWVSazFOTC9Yb3JlQUFFUlVKb1JsSGtnYkNTVUVpeTY1d2tIVElSKys3?=
 =?utf-8?B?YXkzUWJBTk5WNFNIaFRqcktzNGZPbUgxQkFyU0xRcVU0TGVlbVd2YVlCVVlk?=
 =?utf-8?B?TGFjMWFXZmQzVVNaNTB3anByemtVT0tjSE9DY0JCVnJrekd1OUkyS3JncE5X?=
 =?utf-8?B?Mmw3dGVTWkpKMTFFNURjUXFjM1NCTXJjMzJiRTQ2VG5tUGZnYXY4YkJXNHpH?=
 =?utf-8?Q?rfGg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d28f9718-c00c-4429-7c2f-08dd6ab66699
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 09:29:39.3933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tax7UB8pWEmjDZpr3uuVwGwJe3tzF6rQG/c/5Xe4/0TuLZPlddw0HbF0U84eZ3JuY/nVxglD6bKGTSB3HYuuzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTWFuaSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5p
dmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBT
ZW50OiBGcmlkYXksIE1hcmNoIDIxLCAyMDI1IDY6MjIgUE0NCj4gVG86IE11c2hhbSwgU2FpIEty
aXNobmEgPHNhaS5rcmlzaG5hLm11c2hhbUBhbWQuY29tPg0KPiBDYzogYmhlbGdhYXNAZ29vZ2xl
LmNvbTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd0BsaW51eC5jb207IHJvYmhAa2VybmVsLm9y
ZzsNCj4ga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBjYXNzZWxAa2Vy
bmVsLm9yZzsgbGludXgtDQo+IHBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBTaW1laywgTWljaGFs
IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IEdvZ2FkYSwgQmhhcmF0IEt1bWFyDQo+IDxiaGFyYXQu
a3VtYXIuZ29nYWRhQGFtZC5jb20+OyBIYXZhbGlnZSwgVGhpcHBlc3dhbXkNCj4gPHRoaXBwZXN3
YW15LmhhdmFsaWdlQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMi8yXSBQQ0k6
IHhpbGlueC1jcG06IEFkZCBzdXBwb3J0IGZvciBQQ0llIFJQIFBFUlNUIw0KPiBzaWduYWwNCj4N
Cj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3Vy
Y2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNr
aW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBUdWUsIE1hciAxOCwgMjAyNSBh
dCAwMjo1Njo0OFBNICswNTMwLCBTYWkgS3Jpc2huYSBNdXNoYW0gd3JvdGU6DQo+ID4gQWRkIFBD
SWUgSVAgcmVzZXQgYWxvbmcgd2l0aCBHUElPLWJhc2VkIGNvbnRyb2wgZm9yIHRoZSBQQ0llIFJv
b3QgUG9ydA0KPiA+IFBFUlNUIyBzaWduYWwuIFN5bmNocm9uaXppbmcgdGhlIFBDSWUgSVAgcmVz
ZXQgd2l0aCB0aGUgUEVSU1QjDQo+ID4gc2lnbmFsJ3MgYXNzZXJ0aW9uIGFuZCBkZWFzc2VydGlv
biBhdm9pZHMgTGluayBUcmFpbmluZyBmYWlsdXJlcy4NCj4gPg0KPiA+IEFkZCBjbGVhciBmaXJl
d2FsbCBhZnRlciBMaW5rIHJlc2V0IGZvciBDUE01TkMuDQo+ID4NCj4gPiBBZGFwdCB0byB1c2Ug
R1BJTyBmcmFtZXdvcmsgYW5kIG1ha2UgcmVzZXQgb3B0aW9uYWwgdG8gbWFpbnRhaW4NCj4gPiBi
YWNrd2FyZCBjb21wYXRpYmlsaXR5IHdpdGggZXhpc3RpbmcgRFRCcy4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFNhaSBLcmlzaG5hIE11c2hhbSA8c2FpLmtyaXNobmEubXVzaGFtQGFtZC5jb20+
DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBmb3IgdjQ6DQo+ID4gLSBBZGQgUENJZSBQRVJTVCMgc3Vw
cG9ydCBmb3IgQ1BNNU5DLg0KPiA+IC0gQWRkIFBDSWUgSVAgcmVzZXQgYWxvbmcgd2l0aCBQRVJT
VCMgdG8gYXZvaWQgTGluayBUcmFpbmluZyBFcnJvcnMuDQo+ID4gLSBSZW1vdmUgUENJRV9UX1BW
UEVSTF9NUyBkZWZpbmUgYW5kIFBDSUVfVF9SUlNfUkVBRFlfTVMgYWZ0ZXINCj4gPiAgIFBFUlNU
IyBkZWFzc2VydC4NCj4gPiAtIE1vdmUgUENJZSBQRVJTVCMgYXNzZXJ0IGFuZCBkZWFzc2VydCBs
b2dpYyB0bw0KPiA+ICAgeGlsaW54X2NwbV9wY2llX2luaXRfcG9ydCgpIGJlZm9yZSBjcG1fcGNp
ZV9saW5rX3VwKCksIHNpbmNlDQo+ID4gICBJbnRlcnJ1cHRzIGVuYWJsZSBhbmQgUENJZSBSUCBi
cmlkZ2UgZW5hYmxlIHNob3VsZCBiZSBkb25lIGFmdGVyDQo+ID4gICBMaW5rIHVwLg0KPiA+IC0g
VXBkYXRlIGNvbW1pdCBtZXNzYWdlLg0KPiA+DQo+ID4gQ2hhbmdlcyBmb3IgdjM6DQo+ID4gLSBV
c2UgUENJRV9UX1BWUEVSTF9NUyBkZWZpbmUuDQo+ID4NCj4gPiBDaGFuZ2VzIGZvciB2MjoNCj4g
PiAtIE1ha2UgdGhlIHJlcXVlc3QgR1BJTyBvcHRpb25hbC4NCj4gPiAtIENvcnJlY3QgdGhlIHJl
c2V0IHNlcXVlbmNlIGFzIHBlciBQRVJTVCMNCj4gPiAtIFVwZGF0ZSBjb21taXQgbWVzc2FnZQ0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LWNwbS5jIHwg
NjYNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDY1
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUteGlsaW54LWNwbS5jDQo+ID4gYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL3BjaWUteGlsaW54LWNwbS5jDQo+ID4gaW5kZXggZDBhYjE4N2Q5MTdmLi5mZDFm
ZWUyZjYxNGIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLXhp
bGlueC1jcG0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS14aWxpbngt
Y3BtLmMNCj4gPiBAQCAtNiw2ICs2LDggQEANCj4gPiAgICovDQo+ID4NCj4gPiAgI2luY2x1ZGUg
PGxpbnV4L2JpdGZpZWxkLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiA+ICsj
aW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvaW50
ZXJydXB0Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9pcnEuaD4NCj4gPiAgI2luY2x1ZGUgPGxp
bnV4L2lycWNoaXAuaD4NCj4gPiBAQCAtMjEsNiArMjMsMTMgQEANCj4gPiAgI2luY2x1ZGUgInBj
aWUteGlsaW54LWNvbW1vbi5oIg0KPiA+DQo+ID4gIC8qIFJlZ2lzdGVyIGRlZmluaXRpb25zICov
DQo+ID4gKyNkZWZpbmUgWElMSU5YX0NQTV9QQ0lFMF9SU1QgICAgICAgICAweDAwMDAwMzA4DQo+
ID4gKyNkZWZpbmUgWElMSU5YX0NQTTVfUENJRTBfUlNUICAgICAgICAgICAgICAgIDB4MDAwMDAz
MTgNCj4gPiArI2RlZmluZSBYSUxJTlhfQ1BNNV9QQ0lFMV9SU1QgICAgICAgICAgICAgICAgMHgw
MDAwMDMxQw0KPiA+ICsjZGVmaW5lIFhJTElOWF9DUE01TkNfUENJRTBfUlNUICAgICAgICAgICAg
ICAweDAwMDAwMzI0DQo+ID4gKw0KPiA+ICsjZGVmaW5lIFhJTElOWF9DUE01TkNfUENJRTBfRlcg
ICAgICAgICAgICAgICAweDAwMDAxMTQwDQo+ID4gKw0KPiA+ICAjZGVmaW5lIFhJTElOWF9DUE1f
UENJRV9SRUdfSURSICAgICAgICAgICAgICAweDAwMDAwRTEwDQo+ID4gICNkZWZpbmUgWElMSU5Y
X0NQTV9QQ0lFX1JFR19JTVIgICAgICAgICAgICAgIDB4MDAwMDBFMTQNCj4gPiAgI2RlZmluZSBY
SUxJTlhfQ1BNX1BDSUVfUkVHX1BTQ1IgICAgIDB4MDAwMDBFMUMNCj4gPiBAQCAtOTksNiArMTA4
LDcgQEAgc3RydWN0IHhpbGlueF9jcG1fdmFyaWFudCB7DQo+ID4gICAgICAgdTMyIGlyX3N0YXR1
czsNCj4gPiAgICAgICB1MzIgaXJfZW5hYmxlOw0KPiA+ICAgICAgIHUzMiBpcl9taXNjX3ZhbHVl
Ow0KPiA+ICsgICAgIHUzMiBjcG1fcGNpZV9yc3Q7DQo+ID4gIH07DQo+ID4NCj4gPiAgLyoqDQo+
ID4gQEAgLTEwNiw2ICsxMTYsOCBAQCBzdHJ1Y3QgeGlsaW54X2NwbV92YXJpYW50IHsNCj4gPiAg
ICogQGRldjogRGV2aWNlIHBvaW50ZXINCj4gPiAgICogQHJlZ19iYXNlOiBCcmlkZ2UgUmVnaXN0
ZXIgQmFzZQ0KPiA+ICAgKiBAY3BtX2Jhc2U6IENQTSBTeXN0ZW0gTGV2ZWwgQ29udHJvbCBhbmQg
U3RhdHVzIFJlZ2lzdGVyKFNMQ1IpIEJhc2UNCj4gPiArICogQGNyeF9iYXNlOiBDUE0gQ2xvY2sg
YW5kIFJlc2V0IENvbnRyb2wgUmVnaXN0ZXJzIEJhc2UNCj4gPiArICogQGNwbTVuY19iYXNlOiBD
UE01TkMgQ29udHJvbCBhbmQgU3RhdHVzIFJlZ2lzdGVycyBCYXNlDQo+ID4gICAqIEBpbnR4X2Rv
bWFpbjogTGVnYWN5IElSUSBkb21haW4gcG9pbnRlcg0KPiA+ICAgKiBAY3BtX2RvbWFpbjogQ1BN
IElSUSBkb21haW4gcG9pbnRlcg0KPiA+ICAgKiBAY2ZnOiBIb2xkcyBtYXBwaW5ncyBvZiBjb25m
aWcgc3BhY2Ugd2luZG93IEBAIC0xMTgsNiArMTMwLDggQEANCj4gPiBzdHJ1Y3QgeGlsaW54X2Nw
bV9wY2llIHsNCj4gPiAgICAgICBzdHJ1Y3QgZGV2aWNlICAgICAgICAgICAgICAgICAgICpkZXY7
DQo+ID4gICAgICAgdm9pZCBfX2lvbWVtICAgICAgICAgICAgICAgICAgICAqcmVnX2Jhc2U7DQo+
ID4gICAgICAgdm9pZCBfX2lvbWVtICAgICAgICAgICAgICAgICAgICAqY3BtX2Jhc2U7DQo+ID4g
KyAgICAgdm9pZCBfX2lvbWVtICAgICAgICAgICAgICAgICAgICAqY3J4X2Jhc2U7DQo+ID4gKyAg
ICAgdm9pZCBfX2lvbWVtICAgICAgICAgICAgICAgICAgICAqY3BtNW5jX2Jhc2U7DQo+ID4gICAg
ICAgc3RydWN0IGlycV9kb21haW4gICAgICAgICAgICAgICAqaW50eF9kb21haW47DQo+ID4gICAg
ICAgc3RydWN0IGlycV9kb21haW4gICAgICAgICAgICAgICAqY3BtX2RvbWFpbjsNCj4gPiAgICAg
ICBzdHJ1Y3QgcGNpX2NvbmZpZ193aW5kb3cgICAgICAgICpjZmc7DQo+ID4gQEAgLTQ3OCw5ICs0
OTIsNDIgQEAgc3RhdGljIGludCB4aWxpbnhfY3BtX3NldHVwX2lycShzdHJ1Y3QNCj4gPiB4aWxp
bnhfY3BtX3BjaWUgKnBvcnQpICBzdGF0aWMgdm9pZCB4aWxpbnhfY3BtX3BjaWVfaW5pdF9wb3J0
KHN0cnVjdA0KPiA+IHhpbGlueF9jcG1fcGNpZSAqcG9ydCkgIHsNCj4gPiAgICAgICBjb25zdCBz
dHJ1Y3QgeGlsaW54X2NwbV92YXJpYW50ICp2YXJpYW50ID0gcG9ydC0+dmFyaWFudDsNCj4gPiAr
ICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwb3J0LT5kZXY7DQo+ID4gKyAgICAgc3RydWN0IGdw
aW9fZGVzYyAqcmVzZXRfZ3BpbzsNCj4gPiArDQo+ID4gKyAgICAgLyogUmVxdWVzdCB0aGUgR1BJ
TyBmb3IgUENJZSByZXNldCBzaWduYWwgKi8NCj4gPiArICAgICByZXNldF9ncGlvID0gZGV2bV9n
cGlvZF9nZXRfb3B0aW9uYWwoZGV2LCAicmVzZXQiLCBHUElPRF9PVVRfSElHSCk7DQo+ID4gKyAg
ICAgaWYgKElTX0VSUihyZXNldF9ncGlvKSkgew0KPiA+ICsgICAgICAgICAgICAgZGV2X2Vycihk
ZXYsICJGYWlsZWQgdG8gcmVxdWVzdCByZXNldCBHUElPXG4iKTsNCj4gPiArICAgICAgICAgICAg
IHJldHVybjsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIC8qIEFzc2VydCB0aGUgcmVz
ZXQgc2lnbmFsICovDQo+ID4gKyAgICAgZ3Bpb2Rfc2V0X3ZhbHVlKHJlc2V0X2dwaW8sIDEpOw0K
PiA+DQo+ID4gLSAgICAgaWYgKHZhcmlhbnQtPnZlcnNpb24gPT0gQ1BNNU5DX0hPU1QpDQo+ID4g
KyAgICAgLyogQXNzZXJ0IHRoZSBQQ0llIElQIHJlc2V0ICovDQo+ID4gKyAgICAgd3JpdGVsX3Jl
bGF4ZWQoMHgxLCBwb3J0LT5jcnhfYmFzZSArIHZhcmlhbnQtPmNwbV9wY2llX3JzdCk7DQo+ID4g
Kw0KPiA+ICsgICAgIC8qIENvbnRyb2xsZXIgc3BlY2lmaWMgZGVsYXkgKi8NCj4gPiArICAgICB1
ZGVsYXkoNTApOw0KPiA+ICsNCj4gPiArICAgICAvKiBEZWFzc2VydCB0aGUgUENJZSBJUCByZXNl
dCAqLw0KPiA+ICsgICAgIHdyaXRlbF9yZWxheGVkKDB4MCwgcG9ydC0+Y3J4X2Jhc2UgKyB2YXJp
YW50LT5jcG1fcGNpZV9yc3QpOw0KPiA+ICsNCj4gPiArICAgICAvKiBEZWFzc2VydCB0aGUgcmVz
ZXQgc2lnbmFsICovDQo+ID4gKyAgICAgZ3Bpb2Rfc2V0X3ZhbHVlKHJlc2V0X2dwaW8sIDApOw0K
PiA+ICsgICAgIG1kZWxheShQQ0lFX1RfUlJTX1JFQURZX01TKTsNCj4gPiArDQo+ID4gKyAgICAg
aWYgKHZhcmlhbnQtPnZlcnNpb24gPT0gQ1BNNU5DX0hPU1QpIHsNCj4gPiArICAgICAgICAgICAg
IC8qIENsZWFyIEZpcmV3YWxsICovDQo+DQo+IE9uIHRvcCBvZiBLcnprJ3MgcmV2aWV3Og0KPg0K
PiBXaGF0IGRvZXMgdGhpcyAnZmlyZXdhbGwnIG1lYW4/IENsZWFybHksIG5vdCBzb21ldGhpbmcg
ZGVmaW5lZCBpbiB0aGUgUENJZSBzcGVjLg0KPiBBbHNvLCB5b3UgbWFkZSBpdCBpbmRlcGVuZGVu
dCBvZiBQRVJTVCMgbGluZS4gU28gaXMgaXQgcmVhbGx5IG5lZWRlZCBmb3IgcGxhdGZvcm1zDQo+
IG5vdCBzdXBwb3J0aW5nIFBFUlNUIz8NCj4NCj4gLSBNYW5pDQo+DQo+IC0tDQo+IOCuruCuo+Cu
v+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg0KRmlyZXdhbGwg
aXMgaW50ZXJuYWwgdG8gQ1BNNU5DIElQLCBpdCBpcyBhc3NlcnRlZCB3aGVuIHRoZSBQQ0llIExp
bmsgZ29lcyBET1dOIGFuZCB0aGVuIHdpbGwgbm90IGFsbG93IGZ1cnRoZXIgUENJZSB0cmFuc2Fj
dGlvbnMuIFNvLCBmaXJld2FsbCBtb2RlIHNob3VsZCBiZSBjbGVhcmVkIGFmdGVyIHRoZSBQRVJT
VCMgc2VxdWVuY2UuDQotIFNhaSBLcmlzaG5hDQo=

