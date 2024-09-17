Return-Path: <linux-pci+bounces-13265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6EA97B021
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 14:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB6F1F24007
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 12:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88615258;
	Tue, 17 Sep 2024 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WiKH+5so"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E222BAEB;
	Tue, 17 Sep 2024 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726576368; cv=fail; b=qtP2K9FcpIglx06BxOYMW+xiBYhFSPn14L+TN9cd9m59kWOjgD6f70nhEL7zqdS7B9eOp0isG1x3fRda1Hcz0LC8ljFiRK8aRH76QzioRJJetOGddfPXE4U6tV1ZY0vrKGJKdTB5pk2QPHljEqcc1iUqdMJIDnmiuSu73udcS3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726576368; c=relaxed/simple;
	bh=7ub69IqjHnhEH6XxbjPqSmO7PBk8H9jUlmnCB+jQiFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IuFrcfHrFyn9fMioylfvlfDeNx6XrD/i/Cqupzimx7TscWTt85t8TU8KuY4vEXc47DKmNzNK/Fsbcbfo/x2QvvE72XpS/1MviSacXpHFZ20cMh9gVtNC4yVIIQFgGKJugdG4ma2tkxkEYSBOpPFo6mPZqJq0wsJV1rRDNQH1gao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WiKH+5so; arc=fail smtp.client-ip=40.107.102.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIH68zwI/EnxId0rpGE14GcSYQr7D5Af65nQwtnftuyMBGa0TDiGpFEALnZpgArMFrYYIOm/vR1N1A0zDqzOj64r+0cJeHKAlbgTCqfO16UM2aiXS8MbGibE6nsLzrcLOuzXYZUuFhG86IFf74/bPHMhbLSwrRx7E7PjIBu3fEsXQ7FTGXg9rlBb1OISSUMFQtjzLlQ2vWm2qOwxufddJSVHNMpyQtRdMvbzawElwcM6YXdK9OBv+R8+hBvmvPwO9ez80FhJhju31w1xb1NjFC7H+zTHB3//xmIa/ksYywSWAyhxtq6byqTreE0QCeI5n/Ti9j6qUUJm51x/lzOBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ub69IqjHnhEH6XxbjPqSmO7PBk8H9jUlmnCB+jQiFw=;
 b=wOcB/f7ZTSk/35F77NB6759sFU8Uw9BWXCy1iUoEZnfUo2TMvMYPCLIki5s/ZpFLp2Fm/15LP4rPS/Hi+Pi7cQXlnYNHrKdi9SwycpJr+xkbdZjFQOohj1FrroNq0e1jAXStktQra2N0FNwMjNY31tj0h335lwYAkKzUG4JQ7/vGRBRrAuYVs4+j90WRrDG+xwvzDlXhg2rlR4Tr1BY4yvH8+MFU0cNsnntAZ/3aP1DznD9Hb4Zoua0/DKUKlevvXtZw+HLtcTnv3KYscU0qLS3ECy+RJ1GuRMLPcn1khewb78r2aEccFUXyDOd+d5D/3TbuhzR8U2XovuXFDmAf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ub69IqjHnhEH6XxbjPqSmO7PBk8H9jUlmnCB+jQiFw=;
 b=WiKH+5soTIbkJM6hUw4RjY5Sc0639TfHJ8tG53jHFA0DiOyuwU3bVLTa1Fi/enCwFyVHdZVySJwMeM6KQyOxy5KCjOqXeFj0dY7QMMu/GHHkCa4rDTvVSpb/3tZtXBY9yFJO01bHe1hZ2noT7iZGkueh0Fitv+hUURnodquFmRo=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 12:32:42 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 12:32:42 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Simek, Michal" <michal.simek@amd.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible
 string for CPM5 controller 1
Thread-Topic: [PATCH v2 1/2] dt-bindings: PCI: xilinx-cpm: Add compatible
 string for CPM5 controller 1
Thread-Index: AQHbCFXtUZb8Q9ud1EezUwBnkv/Z3LJbzfaAgAAb1/A=
Date: Tue, 17 Sep 2024 12:32:42 +0000
Message-ID:
 <SN7PR12MB72013ED0B8074DC832E6234C8B612@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20240916163124.2223468-1-thippesw@amd.com>
 <20240916163124.2223468-2-thippesw@amd.com>
 <tqte5pxvuhkqwr7gaxblx6orprd74qyw5ekrx53blbbygtrgpn@3uprlzf5otou>
In-Reply-To: <tqte5pxvuhkqwr7gaxblx6orprd74qyw5ekrx53blbbygtrgpn@3uprlzf5otou>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|LV2PR12MB5726:EE_
x-ms-office365-filtering-correlation-id: e21a7ef1-f0d7-43aa-baa2-08dcd714d379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1VBRnIwaXRYeGZNaFllZUFyYWJYeEdUYjhvREY4dm4zTjBpODRZTVYzZy81?=
 =?utf-8?B?RjJaVlIzRU9rTWJXaWVQUWZhNjdsb2syOFRpVmNSczc2c1BwdHVGVEozUjJ6?=
 =?utf-8?B?MjhhUUZKU2NFWEt0aDM3VHlBOFNFZ0gxQUVNK2VFMlFMR0VmdDBsTFpKK0Vw?=
 =?utf-8?B?U1dWRDhSRlhZSnArVDMyQ0FUMTNtbkNRbUdNbjBpUE1xTmVPaHM3N3Z3d0E5?=
 =?utf-8?B?MW8reGNSM0FjZm8wb0t1ZjRiRjVQdmwzVmk0OEhrQ0EwNTRKN2Z3RERNMC9p?=
 =?utf-8?B?Z1IyQWNKU2EvNnhKRU5NTzc1NmNrWWhvYnU5Y1ZSbHdFcFEralc3QlZOa2pT?=
 =?utf-8?B?WUMzTE84ZVdKTDFXSXMzWWdvbkVlKzJkMjdVTjlUZktxbTYrVFdkY3Z6Z0tS?=
 =?utf-8?B?MThhTnRtcDk1bkdUTjRZUXZDZk9ScnVhQ1dYR2JjNmFiTEJweEhkQkdIbmJP?=
 =?utf-8?B?SWlpVzQwT1RqUmVkNkYrUW5iamt5ZElyZXNJbFBPMTJjTVdOM1FVM2doc2kw?=
 =?utf-8?B?T0grVDZ1U21yL3pZb3NNRTltMXQzajdxb01WZnZKWU1pVmRwVnl4Q05lcHZn?=
 =?utf-8?B?cmFmSjRhWlcyb0FkWjBKUGd3WFV0OWVPTFFPdHJaQUhZbWlzczlOcUtoUnRC?=
 =?utf-8?B?NDQzbWZtYWxyT1MvbzVHSUQvTGhGZ3NMR0hmSzlSQUlPelBhWW1QeU1xa0Js?=
 =?utf-8?B?RnVoajN1Z29jZ0I4alR3SHhFelhCeDFUS0VQZlA3SnZNQmZ1c0F3TGdGVUs4?=
 =?utf-8?B?UE96ay9jVXQ4VDluWGJGdDFmTmxHcHhVTUFpRVFCbmZ4clE3eVgrK0dPZWN0?=
 =?utf-8?B?aGVTaUpJTzBrMThiUXI4WVVrLzBpRW9sNjQ2NzBoNi93emlnR3ZVRjZPenIw?=
 =?utf-8?B?UUhtdHNTK3dEVWRNbFR6MEhhcDJPRWFUVWlueUluWEx1SSttZnNiaEhLV3BS?=
 =?utf-8?B?V3YxMzNsamNnS0wrajJCZGVUSjBIS2hJOFd2VThJL2Y1NXZ1K1RtVDdOU0Zz?=
 =?utf-8?B?QTNIaVduYkZmdUYxaXZHNWwvd01ieXNwQjhDdlk5UEY1TTZwWWMvd2ZoYXNB?=
 =?utf-8?B?U1ZraUVRVWE1WE1TaG5tejZUUzJvd3dkSDhDYUI4NGJaM2RUMEYwKzVWcXIx?=
 =?utf-8?B?dWp4aGg4WlhSdDlvbXAzUGlEd3BFT1NyYk8rTUlFYy80SXZKRnBKczVlbkQ0?=
 =?utf-8?B?WnJheHNmTTRVbWFucG1JNXhsV0pkc0NQdnFRMGpMbXJaZUR3WXZJUStiNHBx?=
 =?utf-8?B?VkdyNVdxU2tGcFdkVnpzTEFDMjVXWmpCVlBvR3BDc1BkcXJ4ZVRTTnM1TXQz?=
 =?utf-8?B?a21KMURQVm1WcjNYQklRazRuUGpTUlRpQ1FPQXIxQWcyb2dCekJEMVlMUkFu?=
 =?utf-8?B?NGNhWkNxdEkxVzhQVE5vbitRN1pWUHdRRWNEcFhiS0Rtc3dzd2tiUVpGRFZm?=
 =?utf-8?B?QkdvWDNiSjErSk9ZUkV0dEJxMWtDMUhCRlRpdStCQk1YUnVXQ0xDOTcwTVVr?=
 =?utf-8?B?VnhPUGlXSkxBMG9hN1dMM05ndEZrWTYyMWw4dnR3TzlpMHVUZEhkTFhDaDFa?=
 =?utf-8?B?dmw5VGZNSGFuTHh5aXE1QzJ3VG5PbFNEYTlRVm1hcHJ6M3VEbVdxMjY0WUlh?=
 =?utf-8?B?SVlzb0FYT3NuWGkxQWtZRnM5cFA3LzdKSlA5MjkyVG13dG9rcnExaWcwOGtM?=
 =?utf-8?B?OHJEaElNZnE3eEVXbHp1QjhhRkQ1K2xReXJQVlRzWHQ5NmJscUNHbXpUb3Fm?=
 =?utf-8?B?SHl1OVppam1mUjFUNnlXVFFjS0RHcGJqUjU3RHdIVW13NWtwZC9lYk44c1ZQ?=
 =?utf-8?B?cWRzdHBzV3U4NndHMGh5RndpVjM0b0dWSWErZDRvOTNFWUNBWkE0TS9IaVE3?=
 =?utf-8?B?SXI1S1ROS3FvSE5aY01RaGZUbk42QUpBdmJ1NzQvZ2huamc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?enVzT1R6Nnp4dkxWelFwbkdlM0NYSzN3ellrZjlwNzdQV2M0bzdxRnBaVFdK?=
 =?utf-8?B?MDdGQm1qOUxXZ2wwblc2b1ZGdEVsdXlrWFE0NWt5S1pqUDZ0NDVFMTNYYlJI?=
 =?utf-8?B?VXhudXpUV0lXaWhTL0FWQkpxdFc4VFAvNDJiaExXT0J6RVE3elZEZ3poNzk3?=
 =?utf-8?B?NnM0OThpK3IzWDRPQW1ZWlNWaGZSdkVXRWs3a1htd1lkUE9URDJHNkIxajRJ?=
 =?utf-8?B?YUE1bGZ3bm1MZXkwNHFGTFJzWXVwUVNhSkIxTzdyajROUlB1ZHQ0WUtrYnI2?=
 =?utf-8?B?Mk1wSThSS2dHODc3Q2VpUG1vbk14RVNFR1dHcXhxdm91Zm1LY3p2L2xqOG9Y?=
 =?utf-8?B?akVmV3lhUzBLKytPK1R3VjN2SGluM2xlOTVjWEZ5dzVVV1dadzQ0U2RSOTE2?=
 =?utf-8?B?VHlQU3pFZWdRaWFEMkNvV1NHcWdJU00vL21vNG40OVFtaDZBSThSVG9XMmZ1?=
 =?utf-8?B?NTFuV040STMrVFh4UXVvRnFqdWRlNm1Ka2Y4V01Ya2s4Um4wTWg4TWdidEs5?=
 =?utf-8?B?NVpwTDN4SDdmNFpOVHpYRUpZZFVjMlhybVA3TFF1dG5CMDR5bDF4Z1lmVUVm?=
 =?utf-8?B?ekxpOUx1cTN1d21XVHFlcEZsRVVyNkZKUDNIaGh0Y3NJUVFZUTFsSWJPYysz?=
 =?utf-8?B?RGdlQWlnVG00RDhjSmJxcEdxbFJmTjNjbXIyMjlVWEs0dWgwK2NzMzFSd2JG?=
 =?utf-8?B?czgrL2k1am9hdjRsTVZKQWlaSGdCRHhVcU82NXVyeTVKTG1vY0hrV0l6bUhh?=
 =?utf-8?B?UTVtYWx3MitIZnNZUVZEc0lPOGZKVFN6d0U4aXdkTUI1a1VkOURtbnpQU1Rv?=
 =?utf-8?B?eTMvZVlxSkRTNFBIQzBubVY4eGRqL3RDUDJCSU1QTzVHbkR0cm1QaGs0TzNp?=
 =?utf-8?B?M3k2MmpkcHI3QUh2QXBNZlNhTVZ6cWN5aXhWTkwvYmFhL0RFMER3TlJnTnYx?=
 =?utf-8?B?RHJsUkJlbVYrV3JhNUlNTmViTUJFb01MMUVBNXY0UU9sSFc3ZFZhOEVSejVy?=
 =?utf-8?B?WlZycjJJR1NnTW5NRlhNR0ErUU1xQkJhVXM3U2FPa0JrWmt6aEFLWjlWKzhG?=
 =?utf-8?B?cjdnWERFYjFQcWhma2JlTFVJYTBVdlpLRnZxVC9jVUZqblFpKzl5b0d5Q3g4?=
 =?utf-8?B?VEFFbUUrQlZGeUVIclY5S2dpVFN0VTVoWkxCZm9WV0JHZ01keHNoQjhqR1p6?=
 =?utf-8?B?cDU1ekQvaGJUNTRoc3FGTnAwTk1VK2tzWkJYMllGMzlUSjljQk1NN3ZGWHVX?=
 =?utf-8?B?UERCSmFPaHpoakE0dHR0dlcyQi9WRlNLL2NGN0NPMG81L0I1ZzRYcm8rVHE5?=
 =?utf-8?B?T2Y3bTZXQXltbUNDOXYyeE0vM3h2dm9GRXY5ZjQxVjd3ZDFmaGlNdlNTL0c1?=
 =?utf-8?B?UmtudmNndEYwWm1ZNlBUQko2WGVraEw4dW5nSTdLdGdiV0VYcU5GS2V5OUlk?=
 =?utf-8?B?aDZCS3VxTFVBZXNPMmZnaWZNUkRvcFBoUzkvZDNDQjdkWDU2WDFpQzVCdy9D?=
 =?utf-8?B?ODg1QjVDZFBzclZCT2dRTHRqeklUUGN1SzFRcmllWm8zZFhLZUh2L2ZFTytu?=
 =?utf-8?B?WVpZT1Y3aEJhUHZJVFlNZEhzOCtlcUF4YTlRM1N3ODdwRjVwVWFFdnZ6NTJB?=
 =?utf-8?B?ZG9VSHBCcXZ4YUZOZVgvZ2ptd2NuV3ZRa3JIMkI1OU5DYXdJdS9hRzB3eGQy?=
 =?utf-8?B?R3VYcmQ2UXhuVGgwZnh1NGlIeGNJTm10elRqekJLd3JLUm1mQy95OVFFYUZM?=
 =?utf-8?B?Y0dXcWU4RHlZenM2ODIzZ0RjU2tLSWFFbnhySjhWVk1hVGU0SWZVelN4OSt5?=
 =?utf-8?B?Q1lVTUtNaHFLbHIzUVVYNnVwM01HaEgyMTV0VkNNSjJ3UjhzakhNVTB0NThU?=
 =?utf-8?B?S3grdFZEYnp0ZGFpSDEzTEwraElic3JmTkF4SXdWQzVMOEpaVFE5RXZJbTlT?=
 =?utf-8?B?M3FOZzUxcDliU29BMENzU2pPWjV1MFg3UnlPN0hzdUFzWjMzUFFyUHA2ZVpk?=
 =?utf-8?B?dXZXTlBYSUE0TFNTUXJ6UDE5dzBnYTU0czM5Sys0YzZsQ25ua1E3eEUvZ2xP?=
 =?utf-8?B?NEpzaDNmbUVzNkh3RXJSN2FzMExBYjQ2MXZ4YTBPUENtNExtaE5VLzVnV2Vn?=
 =?utf-8?Q?V4pk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e21a7ef1-f0d7-43aa-baa2-08dcd714d379
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 12:32:42.6625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wyC/6ljl3etlNSeLidgSLphpxrl6cCNefD6sN2VkiYmm4XXsU4KexAjKc+5tOxm39s/byO+7IYLX64qrwnQkfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgU2Vw
dGVtYmVyIDE3LCAyMDI0IDQ6MjAgUE0NCj4gVG86IEhhdmFsaWdlLCBUaGlwcGVzd2FteSA8dGhp
cHBlc3dhbXkuaGF2YWxpZ2VAYW1kLmNvbT4NCj4gQ2M6IG1hbml2YW5uYW4uc2FkaGFzaXZhbUBs
aW5hcm8ub3JnOyByb2JoQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3Jn
OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsg
Y29ub3IrZHRAa2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IEdvZ2Fk
YSwgQmhhcmF0IEt1bWFyDQo+IDxiaGFyYXQua3VtYXIuZ29nYWRhQGFtZC5jb20+OyBTaW1laywg
TWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsg
a3dAbGludXguY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8yXSBkdC1iaW5kaW5nczog
UENJOiB4aWxpbngtY3BtOiBBZGQgY29tcGF0aWJsZSBzdHJpbmcgZm9yDQo+IENQTTUgY29udHJv
bGxlciAxDQo+IA0KPiBPbiBNb24sIFNlcCAxNiwgMjAyNCBhdCAxMDowMToyM1BNICswNTMwLCBU
aGlwcGVzd2FteSBIYXZhbGlnZSB3cm90ZToNCj4gPiBUaGUgWGlsaW54IFZlcnNhbCBQcmVtaXVt
IHNlcmllcyBpbmNsdWRlcyB0aGUgQ1BNNSBibG9jaywgd2hpY2gNCj4gPiBzdXBwb3J0cyB0d28g
VHlwZS1BIFJvb3QgUG9ydCBjb250cm9sbGVycyBvcGVyYXRpbmcgYXQgR2VuNSBzcGVlZC4NCj4g
Pg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBhIGNvbXBhdGlibGUgc3RyaW5nIHRvIGRpc3Rpbmd1aXNo
IGJldHdlZW4gdGhlIHR3bw0KPiA+IENQTTUgUm9vdCBQb3J0IGNvbnRyb2xsZXJzLiBUaGUgZXJy
b3IgaW50ZXJydXB0IHJlZ2lzdGVycyBhbmQNCj4gPiBjb3JyZXNwb25kaW5nIGJpdHMgZm9yIENv
bnRyb2xsZXIgMCBhbmQgQ29udHJvbGxlciAxIGFyZSBsb2NhdGVkIGF0DQo+ID4gZGlmZmVyZW50
IG9mZnNldHMsIG1ha2luZyBpdCBuZWNlc3NhcnkgdG8gZGlmZmVyZW50aWF0ZSB0aGVtLg0KPiA+
DQo+ID4gQnkgdXNpbmcgdGhlIG5ldyBjb21wYXRpYmxlIHN0cmluZywgdGhlIGRyaXZlciBjYW4g
cHJvcGVybHkgaGFuZGxlDQo+ID4gdGhlc2UgcGxhdGZvcm0tc3BlY2lmaWMgZGlmZmVyZW5jZXMg
YmV0d2VlbiB0aGUgY29udHJvbGxlcnMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaGlwcGVz
d2FteSBIYXZhbGlnZSA8dGhpcHBlc3dAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiBjaGFuZ2VzIGlu
IHYyOg0KPiA+IC0tLS0tLS0tLS0tLS0tDQo+ID4gTW9kaWZ5IGNvbXBhdGlibGUgc3RyaW5nIHRv
IGRpZmZlcmVudGlhdGUgY29udHJvbGxlciAwIGFuZCBjb250cm9sbGVyDQo+ID4gMQ0KPiA+IC0t
LQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3hpbGlueC12ZXJz
YWwtY3BtLnlhbWwgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGNpL3hpbGlueC12ZXJzYWwtY3BtLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbA0KPiA+IGluZGV4IDk4OWZi
MGZhMjU3Ny4uMzc4MzA3NTY2MWUyIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFtbA0KPiA+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kveGlsaW54LXZlcnNhbC1jcG0ueWFt
bA0KPiA+IEBAIC0xNyw2ICsxNyw3IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICBlbnVtOg0KPiA+
ICAgICAgICAtIHhsbngsdmVyc2FsLWNwbS1ob3N0LTEuMDANCj4gPiAgICAgICAgLSB4bG54LHZl
cnNhbC1jcG01LWhvc3QNCj4gPiArICAgICAgLSB4bG54LHZlcnNhbC1jcG01LWhvc3QxLTENCj4g
DQo+IEhtLCBJIHRob3VnaHQgbXkgaXJvbnkgd2FzIG9idmlvdXMsIGJ1dCBpdCBzZWVtcyB3YXMg
bm90LiBBcG9sb2dpZXMuDQo+ICIxLTEiLCAiMS0yIiwgIjEtMS0xIiBvciAiMS0xLjAwLTEiIGFy
ZSBhbGwgcG9vciBjaG9pY2VzLg0KPiANCj4gSSB3YXMgd2FpdGluZyBmb3Igc29tZSByZWFzb25h
YmxlIG5hbWUgaWRlYSwgYmVjYXVzZSBpdCBpcyB5b3Ugd2hvIGtub3dzIHRoZQ0KPiBoYXJkd2Fy
ZSBhbmQgaGFzIGRhdGFzaGVldC4NCj4gDQo+IEkgZ3Vlc3MgaWYgSSBoYXZlIHRvIGNvbWUgdXAg
d2l0aCBuYW1lIHRoZW4gImhvc3QxIiB3YXMgYmV0dGVyLiBPciAiY3BtNS0xLWhvc3QiLg0KPiBE
dW5ubywgYWxsIHRoZXNlIG5hbWVzICI1IiBpbiAiY3BtNSIgYW5kICItMS4wMCIgaW4gSVAgdmVy
c2lvbiBhcmUgcmFuZG9tbHkNCj4gY29uc3RydWN0ZWQuDQoNCkhlcmUsIENQTTUgaW5kaWNhdGVz
IGdlbjUgUm9vdCBQb3J0IGFuZCBob3N0MSBpbmRpY2F0ZXMgY29udHJvbGxlciAxLg0KU28sIExl
dCBtZSByZXNlbmQgcGF0Y2ggd2l0aCBjb21wYXRpYmxlIHN0cmluZyBhcyAieGxueCx2ZXJzYWwt
Y3BtNS1ob3N0MSIgaXQgbG9va3MgZmluZS4NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5
c3p0b2YNCg0K

