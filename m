Return-Path: <linux-pci+bounces-22346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38756A4427F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 15:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5093AF984
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 14:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3511C26772D;
	Tue, 25 Feb 2025 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rOxyKhAf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771D7260A35;
	Tue, 25 Feb 2025 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493094; cv=fail; b=QSUKT0IOGeh9aBdtdWxOotGVfsw+9cYqSdSZjpBkVZ1V0dIuZy/PcmswVwUHFnwWnrhgqMgfOobwiIG6cdcTodzZOhg8B2JmRqRDjRj3z943cn2RlZ+ZdzSxE51l1KbVvYvieRjUwi+8Oh8VfITRnxCOD6eFLM6zv6LFKLkO8ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493094; c=relaxed/simple;
	bh=f0+kldlS+vkAix/t5/567yHsUoawXV6mK4SHHs6U+Rg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=omBeaZ+WN4YMOOxjIlqaxUUyOfCbEeNxiyIMm4zUT9fjoZRtGflAMV3SKjOMdwyufAFSIJnHpu/iZW4vKj7d0cTCQLG6PFgx+f/rcpoHlbvWf4EaW9RbaL92tCCbmLO53Nl7ScL69yy+ixBAf4uWQK3bfhatcSNda5VCUf5jXpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rOxyKhAf; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgOxN2uyDjkd4afC3tnQ4ZUo6MBML4eTW5xjgE1YJUbYWaWH6AJl8jcQC/8HZyyzxZqWAUBthlhZScDs3C5+zehcpkd3GcgUSGAnColNbWkNomdnM16pf4cydSs+ACmZ4XP8pquEgVufATTdx9yZk0nckgVLM02MD4gB1Knv9rni740OsD7d59YMvH/Ta7a5z8StTVi4T1JRxsjJtdrLLn9OvoNi8OnvhxIZLOxd6EKpuVY1tmfXGg8lVKtWmsmWtqrGIOWabSwIIQCJ/vuGjZFTHTtvv9XhM2fo8V6HZz1zMml2mTphDzVC/DygM+uTL0ObzwPxI22eiMvXrdkn7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0+kldlS+vkAix/t5/567yHsUoawXV6mK4SHHs6U+Rg=;
 b=TB5I3tpAoeYxqhKFXJL5AgICQMYS0HSgxFONTPhcRTJy8QrHzeDEaARh4vnAf1PrS/QkkaEiPLMMefnjh86HY6dihJV4UvZoCLF0RsRo+qD5/fTMNhsUTbY1HX5guX7m0e7wSbrflHJWqc6xNE1jafApnxxev0ZrqRM3/LwPvvcVjvMq6jvO9xioYk6wL/Zjsf8NzesSx0p1Jnx7jjbKeRV5WsrC+U8SFlUvqzUsRtzuqS9vvizOadGOisaP+cowYrV+/iT0EOQ4M45kb27WYDumzXl3X9Qs08QNrvUO0kYcQtEEJc1mCLeS8TGJYRcCMvXs/b+K/51Nf2VZtI1fFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0+kldlS+vkAix/t5/567yHsUoawXV6mK4SHHs6U+Rg=;
 b=rOxyKhAf4wQ95fRLS2tj70nAxdd7c8+6YrLBHttcd/7vuRdi5R/6A7VVt36VGIWFi1Bm8hfsYPglL/9AEj6BrrT/kJAz4X0nAL3NEH1B1pnqbd2zs9S7vqBloAjCbqYXNVyi5tiIZL9hjvwNJ9b1GprmRa20LcACAFxsYqNiHis=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 14:18:07 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8466.015; Tue, 25 Feb 2025
 14:18:07 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>
Subject: RE: [PATCH v14 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Topic: [PATCH v14 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Index: AQHbho4qtT5H5a0jEEuMfrxVGOqvCbNWMFkAgAAaaHCAACOUgIABo1zw
Date: Tue, 25 Feb 2025 14:18:07 +0000
Message-ID:
 <SN7PR12MB720119A1E4F99A463758DF8A8BC32@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250224073117.767210-1-thippeswamy.havalige@amd.com>
 <20250224073117.767210-4-thippeswamy.havalige@amd.com>
 <20250224093024.q4vx2lygrc2swu3h@thinkpad>
 <SN7PR12MB720127D150CABEECA4A436358BC02@SN7PR12MB7201.namprd12.prod.outlook.com>
 <20250224131215.slcrh3czyl27zhya@thinkpad>
In-Reply-To: <20250224131215.slcrh3czyl27zhya@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bcf4dae9-c2fa-4551-af3e-c2f7a0c3124d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-25T14:13:11Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DM4PR12MB6614:EE_
x-ms-office365-filtering-correlation-id: 7c4c544d-77d9-4484-4f4a-08dd55a739ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UkQ4cTVYcmhJUjVQc0c0SjBWM292TDhUS2pFZmMyak1McnJGWUVzbzFVSHZN?=
 =?utf-8?B?VFVMRHZ1bk1raU9qWjFxWXN0bExpTHRvZUNLNDk3Z2d6WEtMeDQxT3QyaXZv?=
 =?utf-8?B?dHRHQm9Qa1h4WThHbHFmdTgwV0tFbnpMRTY2ZWJOdUdxOXNsNUlYZ0loMDBZ?=
 =?utf-8?B?NmtSclFXblIxb0NjVFNmV1N3bEd1Q3JkYXpaMHJta0lueDhub0p3bXN4VUt5?=
 =?utf-8?B?WEpia1ZEUGtkTFVtQkZMb1FIRjJGMmNZTHhqdkdFZ1pXVXZKRTRPdi9KeE56?=
 =?utf-8?B?T25nNkphSDN5NExIV2FrRTBYdE5BeFNoYU52TVhEcHZ0RnI2bE1aQXFoZTBn?=
 =?utf-8?B?UUtLNlhvZ3VEMjJvaGpoa3RaekVGVUFxUnlnSHFOakl6TVFFNER4UlNyMWVZ?=
 =?utf-8?B?eHZLMWliMEJobjhaWmZ4SlZzQWZreTBqSWtnQ05MTXNSUktCR3NhTGw3cG5y?=
 =?utf-8?B?OXNXQndsdHVUNUhvT1h2MCtscHBMb3JBWDBMWUV5WWdaeEFFWGZVaUtaenpn?=
 =?utf-8?B?MXZiaDVTVGRnWGowUHo3UE1RQ3NGWmlEbFZuanltaVcvQ0xHRUJ0U01PcUts?=
 =?utf-8?B?RU1OU3o1dG11dTRSQ1VIQWUzNW1OaTh4M0hJcTdZWDgvZDhpT0dweGVyRTVj?=
 =?utf-8?B?cDMyeURQOGw3dkZUalR1dm5oc1hNRVgxNFd2UlRMZ1hCdzZXdUFpNmdScnVQ?=
 =?utf-8?B?VW5uSW41Wjh4aE80aVhPNkZDZUJMZGNId1cwTC8wMXVWWHBBQkpRWks3OXlJ?=
 =?utf-8?B?V3dETjdSaE1oMndwRFRVaFJlQ09hS0FsZnF6QW9lL2ZwQi83MlBKNmR5M1ND?=
 =?utf-8?B?bzZiSDQ3R1F4VEJGRnBhMFc0QUdQQUNOcG1OOEVDN2dpR1BTM1NER3dFYldT?=
 =?utf-8?B?bm9CMldFYndHNFlmWGcyV3phSjI1OWs3SWY4U2haSUtKZEtFQ0pZS28vUTVv?=
 =?utf-8?B?TnJRQUtjQ0s4djNpckxDUlhPZGh0NnkyWU00TG1zZHVualpkUWNCT2lwZXBw?=
 =?utf-8?B?dDNKN29aY3U4cmhjZHJpZTQ0NWhLdG1UY3ZrM1BCbVpiVENZeFpxeTNSQ1pI?=
 =?utf-8?B?enpic0F5TlM1WC8yYVhhMFVDdFRiSExab092MlBFR2JvVTFzVng0UWZQS3dN?=
 =?utf-8?B?Tzk4Y0dZdkVvbUtHZDAzajAwajMvQU1xWHphbFQyeGZpTWtXU0lyZXgzTmV6?=
 =?utf-8?B?aWJ2YTFISm1wZjNVZno5QUVLTGFOYXZpM29jb3BZZ0Ywc0dldENRVnZtcS9t?=
 =?utf-8?B?S29kV3Azb2ZpeGI3RFFlSHhSQ1crbUI0WUVkdFRMdVVhejI1TjJrTTJhcUh2?=
 =?utf-8?B?bjlXSGJnaThSTExOeVZ3cTF1TVJKeGFtWUoreXhDMEgvc3R1RE5vcWg1S2t4?=
 =?utf-8?B?Ym5NTmpVR3g3SDJtVm1WcTVCZUVLOEZ5N1NPV0FwbXBjRG5wU1FvaWRONE5S?=
 =?utf-8?B?RlJpVXViR2NaejBsZTFyMGtBVEVhS05QbGxqazV2ZjZHcVpoUm13Z0RUalRR?=
 =?utf-8?B?YTA5RVRDNndlU3JoOHV1WG1wc2xoMlBxd3k5NGQ5WDdHZXZ4Mjdvb2I4T2lm?=
 =?utf-8?B?akVpSVo5OXphTUVNamxCNUxROGRnbjNKdk4rMzdYMEpBVHlpRzV0Z1ZzYmVX?=
 =?utf-8?B?THRVcUhUWTlyak5LMmJucitZeUFubW1XdlJrVmczN3BmK09WbDhWMjVHTU5p?=
 =?utf-8?B?QUhYcWFWbm94a2txMXcveUdSOXRNaFpnek0yTStRUmRkNnp0QzB3NW9aUTdn?=
 =?utf-8?B?aUEwR2ovWTlLWXovNDh4OGJKYXZTYTRFbFcrVUVVSDdzaTJpbXdjNWRETzA5?=
 =?utf-8?B?b3BhV3BKcFo4aVNLY3JWL0w2S1NHL3p3TTJFK2ljb045bmVNQUI1VkhacHJq?=
 =?utf-8?B?dmdMYmRRU0tKRHVuL2t0djBMVWhETGVmZFVmR0tLcTN3eTIxcFVHMDJYWWxy?=
 =?utf-8?Q?FmqFIiwDhEN45glFbJ25hATTM3LBVmwW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0FsRDdjVnRnNlJybk9DeFQ5UUhqVHNBQkxnN0szb3g1Y21uTnFvMmZpRVlt?=
 =?utf-8?B?TGE2NENhN21nekY4VzlIOFRYZ0NpaWN6V2hMQ3pQYytBbDNjR0xkVjlDRHNZ?=
 =?utf-8?B?c0tyUDZ1ZXZNaXlpZHVNbGtISTFKaVhMUkxvalRKejQwcjQzRDV3Ni9vWWZr?=
 =?utf-8?B?a0dGaXJTeFV3UVY0LzlYdnVNdTIzUnJTcmQwc2pjNnlMY25XYXFnd2hlSUlo?=
 =?utf-8?B?Z2N6U0hyZm1keDRGMFRyQ1paamUrQXZQaFJDekNrbWNhK1lUSUF6UWlmR2Mr?=
 =?utf-8?B?eU1oUzczcFFsQ0U5T1kzSGJncTZVQTNCQTBHZzRWQTBnY01WbkphTjQwNmJy?=
 =?utf-8?B?T2Q5QzE4NDliamNoZ2FDOWNmQUlhSXhqWWJJRDRLb2FmYW1qY0RMaXNtOXRs?=
 =?utf-8?B?bDB5Y2xBNUIwdmJic3JFaW5Qa3JBSWhabXltejRhM2dhRkFGVEU5WnBVdm1y?=
 =?utf-8?B?d2NKZnpSeUxoS0l5U3gyMU45bFUrMUdIYUlNSDlqTEQ0b0hNM0s0Y3VLQ0Y4?=
 =?utf-8?B?WjJHMzlVbllaV1hBVWhJeEprUkRhKys1cHNQVGFXWHRTaE9mZmk1SEkxM0I5?=
 =?utf-8?B?Zm52YkdQV0R1Y1cyTVdDRVVEc0IwTk5vRjZvdWpFdzBFTzU5cEloRFMrejNx?=
 =?utf-8?B?eTZXVlMyZExRRWI1cHVXblV2M0p6bUVzTTVFNXhMajRleXdSUFJUaUovMjJY?=
 =?utf-8?B?aTB5akIzRFQ1YWMwM0ZoRXh5aWlRc2hndWxoeWxPRmw1YjJmQVZLY2ltb1Vh?=
 =?utf-8?B?RWtVWUVSV0hFSzIyWlAydk12emVRVEhOWW1RK0xXNm9rU0R2V25udG9BVDgy?=
 =?utf-8?B?RE5YTDlOQVdpQmdNNkZ2eU1zcnQ5UUNNc2piWVNsaFI4UlNma1A2OGJiTFFX?=
 =?utf-8?B?NjdlbzFURjlhcTc1VThSUEQ4N1h1S0hlaTZkZ0UzaysreVhaempHazBKQ0dx?=
 =?utf-8?B?cEhidk1vd2FBS292WHY3d2IvWHdlMStpQW1NMmtSWVhZY0pTa0ttVHpBUWxH?=
 =?utf-8?B?bFhFUjFWcXhNVUlnekZxOWE1K3NDUmlVNld2R0RnNDgwbkJTbVRiMEh2QWs2?=
 =?utf-8?B?bGVuU0I0b09ROVpISkxXa2dVeG9CMHo5RkZZWjBmcGNqRmlISzlGellzZkNF?=
 =?utf-8?B?UnpZZkxZN1QzOE9sOVJNTjdPenFzUlpzVVdEdXV3WFE4cllZRmYveGdrSU5l?=
 =?utf-8?B?L2NtTDFPTkk2d0hBVERyKytZOHVsU2hwMVJBNnFXUENaWWQ2NXZXcFV0bzd0?=
 =?utf-8?B?TzJ5S3JYUEhQNk05eDhOSDRsN2hNMm9Rc0NHcXdYTFg2aVhPMFRDWXFLRndF?=
 =?utf-8?B?TWpWcEdRd045dGRMOFdUVlhXUFpTV1JRM3hrblhTQXZZTjJBelZKRzBZckln?=
 =?utf-8?B?UVlMQlI3aXpyblh4ZUMyNVBDanVHZFpZbEVISGNTcE5oYWRyNS9DUzk2enQ0?=
 =?utf-8?B?UklzNGN0UnU0ZFZRcW5Ib1N1ZTFqSTVRK1V6NUJWNEFjT1FUcEMvQm1HM2xM?=
 =?utf-8?B?V01YWEZGeWFSWGNPWGVVMDhQN01JeFFMcWUrKzlMdW1ySHgybWxWQ0RIc1lW?=
 =?utf-8?B?cnQ0STdlV0ZLWEpvb2srNnFka1JQSWxBYTJRSE01c2pzWmJvOHdDckh1U0JK?=
 =?utf-8?B?NFpuaWhmYVcydUlJalVTK05pVDhHZU5hTEN4bDlXUkozcFQ0Zlc3bExrTTY0?=
 =?utf-8?B?amtES2N2Q29Wa3RWanhLOXI4WHFjV1Z6d1ZYaVczM2NRSDkwaWxmRjRVYVNp?=
 =?utf-8?B?OU52WjZpdVVjQ24ySjZvblBaU2IybStXT3laYVppRndaWjNVR1BCQzdnSHVp?=
 =?utf-8?B?a0p1YnhDeXRJRkNMckhyWC85bFhWYUgwdm1tTzJPS2d1NTl2K0VBenlFZEhk?=
 =?utf-8?B?MDREeVpOU0MvRysyR1p0cE1jbUQzZm1GWlhwWG05UFdLYlJwbGI2WkdiMmkx?=
 =?utf-8?B?emh0UlNzMjVCL0F3UWdlTlpiREFIdmtUWDBGamlzMUZCdzlwS1NIOExSK3dG?=
 =?utf-8?B?eGRCN3p0Sjh2eEFKbnJWWjJjazFWNFRvalRNbm9xVFo4d1dXVjlDMTR6YzV2?=
 =?utf-8?B?R21aRmJOR0VkY2o0TlIyMi9sTll3ekNaSG41TFQvL3ltcW5HamQ0S3ArOFJy?=
 =?utf-8?Q?mR9c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4c544d-77d9-4484-4f4a-08dd55a739ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 14:18:07.5681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJq0Qp0HtMEG7QASSprrVB2bIIm6DghZ/RraRtHZu3FOZ1U+6+T9OFrups/+suF/LD7GDeVhhqsoxwfKOj4vdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgTWFuaSwNCg0KWy4uLl0NCj4NCj4gPiA+ICsgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJ
WkUoaW50cl9jYXVzZSk7IGkrKykgew0KPiA+ID4gKyAgICAgICAgIGlmICghaW50cl9jYXVzZVtp
XS5zdHIpDQo+ID4gPiArICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPiA+ICsgICAgICAg
ICBpcnEgPSBpcnFfY3JlYXRlX21hcHBpbmcocGNpZS0+bWRiX2RvbWFpbiwgaSk7DQo+ID4gPiAr
ICAgICAgICAgaWYgKCFpcnEpIHsNCj4gPiA+ICsgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2
LCAiRmFpbGVkIHRvIG1hcCBtZGIgZG9tYWluDQo+IGludGVycnVwdFxuIik7DQo+ID4gPiArICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiA+ICsgICAgICAgICB9DQo+ID4gPiAr
ICAgICAgICAgZXJyID0gZGV2bV9yZXF1ZXN0X2lycShkZXYsIGlycSwNCj4gYW1kX21kYl9wY2ll
X2ludHJfaGFuZGxlciwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElS
UUZfU0hBUkVEIHwgSVJRRl9OT19USFJFQUQsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpbnRyX2NhdXNlW2ldLnN5bSwgcGNpZSk7DQo+ID4NCj4gPiBBcmVuJ3QgdGhl
c2UgSVJRcyBqdXN0IHBhcnQgb2YgYSBzaW5nbGUgSVJRPyBJJ20gd29uZGVyaW5nIHdoeSBkbyB5
b3UgbmVlZA0KPiB0byByZXByZXNlbnQgdGhlbSBpbmRpdmlkdWFsbHkgaW5zdGVhZCBvZiBoYXZp
bmcgYSBzaW5nbGUgSVJRIGhhbmRsZXIuDQo+ID4NCj4gPiBCdHcsIHlvdSBhcmUgbm90IGRpc3Bv
c2luZyB0aGVzZSBJUlFzIGFueXdoZXJlLiBFc3BlY2lhbGx5IGluIGVycm9yIHBhdGhzLg0KPiA+
IFRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nLiBUaGlzIGNvZGUgaXMgYmFzZWQgb24gdGhlIHdvcmsg
YXV0aG9yZWQgYnkgTWFyYw0KPiBaeW5naWVyIGFuZCBCam9ybiBkdXJpbmcgdGhlIGRldmVsb3Bt
ZW50IG9mIG91ciBDUE0gZHJpdmVycywgYW5kIGl0IGZvbGxvd3MNCj4gdGhlIHNhbWUgZGVzaWdu
IHByaW5jaXBsZXMuIFRoZSBpbmRpdmlkdWFsIElSUSBoYW5kbGluZyBpcyBjb25zaXN0ZW50IHdp
dGggdGhhdA0KPiBhcHByb2FjaC4NCj4gPiBGb3IgcmVmZXJlbmNlLCB5b3UgY2FuIHJldmlldyB0
aGUgZHJpdmVyIGhlcmU6IHBjaWUteGlsaW54LWNwbS5jLiBBbGwgb2YgeW91cg0KPiBjb21tZW50
cyBoYXZlIGJlZW4gaW5jb3Jwb3JhdGVkIGludG8gdGhpcyBkcml2ZXIgYXMgcmVxdWVzdGVkLg0K
PiA+DQo+DQo+IE9rIGZvciB0aGUgc2VwYXJhdGUgSVJRIHF1ZXN0aW9uLiBCdXQgeW91IHN0aWxs
IG5lZWQgdG8gZGlzcG9zZSB0aGUgSVJRcyBpbg0KPiBlcnJvciBwYXRoLg0KSGVyZSBub25lIG9m
IHRoZSBkcml2ZXJzIGFyZSBkaXNwb3NpbmcgZXhwbGljaXRseSBpbiB0aGUgZXJyb3IgcGF0aCBl
eHBsaWNpdGx5LiBJIG9ubHkNClNlZSBWTUQgZHJpdmVyIGlzIGZyZWVpbmcgaXQgdXAgZXhwbGlj
aXRseSBpbiBzdXNwZW5kIHBhdGggc28gdGhhdCBkcml2ZXIgY2FuIHJlZ2lzdGVyIGlycQ0KSGFu
ZGxlciBpbiB0aGUgcmVzdW1lLiBNYXkgSSBrbm93IHRoZSByZWFzb24gZm9yIGV4cGxpY2l0bHkg
bmVlZCBmb3IgZGlzcG9zaW5nIGhlcmUuDQo+DQo+ID4gPiArICAgICAgICAgaWYgKGVycikgew0K
PiA+ID4gKyAgICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJGYWlsZWQgdG8gcmVxdWVzdCBJ
UlEgJWRcbiIsIGlycSk7DQo+ID4gPiArICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+
ID4gKyAgICAgICAgIH0NCj4gPiA+ICsgfQ0KPiA+ID4gKw0KPiA+ID4gKyBwY2llLT5pbnR4X2ly
cSA9IGlycV9jcmVhdGVfbWFwcGluZyhwY2llLT5tZGJfZG9tYWluLA0KPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBTURfTURCX1BDSUVfSU5UUl9JTlRYKTsNCj4g
PiA+ICsgaWYgKCFwY2llLT5pbnR4X2lycSkgew0KPiA+ID4gKyAgICAgICAgIGRldl9lcnIoZGV2
LCAiRmFpbGVkIHRvIG1hcCBJTlR4IGludGVycnVwdFxuIik7DQo+ID4gPiArICAgICAgICAgcmV0
dXJuIC1FTlhJTzsNCj4gPiA+ICsgfQ0KPiA+ID4gKw0KPiA+ID4gKyBlcnIgPSBkZXZtX3JlcXVl
c3RfaXJxKGRldiwgcGNpZS0+aW50eF9pcnEsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgZHdfcGNpZV9ycF9pbnR4X2Zsb3csDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
SVJRRl9TSEFSRUQgfCBJUlFGX05PX1RIUkVBRCwgTlVMTCwgcGNpZSk7DQo+ID4gPiArIGlmIChl
cnIpIHsNCj4gPiA+ICsgICAgICAgICBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byByZXF1ZXN0IElO
VHggSVJRICVkXG4iLCBpcnEpOw0KPiA+ID4gKyAgICAgICAgIHJldHVybiBlcnI7DQo+ID4gPiAr
IH0NCj4gPiA+ICsNCj4gPiA+ICsgLyogUGx1ZyB0aGUgbWFpbiBldmVudCBoYW5kbGVyICovDQo+
ID4gPiArIGVyciA9IGRldm1fcmVxdWVzdF9pcnEoZGV2LCBwcC0+aXJxLCBhbWRfbWRiX3BjaWVf
ZXZlbnRfZmxvdywNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICBJUlFGX1NIQVJFRCB8
IElSUUZfTk9fVEhSRUFELCAiYW1kX21kYg0KPiBwY2llX2lycSIsDQo+ID4NCj4gPiBXaHkgaXMg
dGhpcyBhIFNIQVJFRCBJUlE/DQo+ID4gVGhhbmsgeW91IGZvciByZXZpZXdpbmcuIFRoZSBJUlEg
aXMgc2hhcmVkIGJlY2F1c2UgYWxsIHRoZSBldmVudHMsIGVycm9ycywNCj4gYW5kIElOVHggaW50
ZXJydXB0cyBhcmUgcm91dGVkIHRocm91Z2ggdGhlIHNhbWUgSVJRIGxpbmUsIHNvIG11bHRpcGxl
DQo+IGhhbmRsZXJzIG5lZWQgdG8gYmUgYWJsZSB0byByZXNwb25kIHRvIHRoZSBzYW1lIGludGVy
cnVwdC4NCj4NCj4gSUlVQywgeW91IGhhdmUgYSBzaW5nbGUgaGFuZGxlciBmb3IgdGhpcyBJUlEg
YW5kIHRoYXQgaGFuZGxlciBpcyBpbnZva2luZyBvdGhlcg0KPiBoYW5kbGVycyAoZm9yIGV2ZW50
cywgSU5UeCBldGMuLi4pLiBTbyBJIGRvbid0IHNlZSBob3cgdGhpcyBJUlEgaXMgc2hhcmVkLg0K
Pg0KPiBTaGFyZWQgSVJRIGlzIG9ubHkgcmVxdWlyZWQgaWYgbXVsdGlwbGUgaGFuZGxlcnMgYXJl
IHNoYXJpbmcgdGhlIHNhbWUgSVJRIGxpbmUuDQo+IEJ1dCB0aGF0IGlzIG5vdCB0aGUgY2FzZSBo
ZXJlIGFmYWljcy4NCi0gSSBoYXZlIHZlcmlmaWVkIHRoaXMgaW4gbXkgZHJpdmVyIGl0IHdvcmtz
IHdpdGhvdXQgc2hhcmVkIGludGVycnVwdCBsaW5lLiBUaGFua3MgZm9yIHJldmlld2luZy4NCj4N
Cj4gLSBNYW5pDQo+DQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTg
rr7grprgrr/grrXgrq7gr40NCg==

