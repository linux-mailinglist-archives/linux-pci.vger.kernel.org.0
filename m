Return-Path: <linux-pci+bounces-37380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0126BB2155
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 01:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC1919C2142
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 23:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B9274B59;
	Wed,  1 Oct 2025 23:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EITobubQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E354918;
	Wed,  1 Oct 2025 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759362464; cv=fail; b=Dbxg5+hTRixg6b8opavCpcLUoRD6W0FJl+MKuswPR8kRQjJHgzL1+DJBmRmzL3jhrIPIwziX3l1sowyDiQdvvQ8Gd2Vz1+ghDU5hRnUJZ9xNPfMPSN1d7BgyAVW1pG0iODkov4kKDofwS8hMaSCypKmcOViR18wlumsQjxRHoiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759362464; c=relaxed/simple;
	bh=EFi94AsSPFpLHwoBCvXaeAiPg42davxBpBiFVqOzMbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e9E6DIhmdMtZ+LnOvgmz/eob0Lre7x9gHpKnPcJn/niMJ+RhST5eISkducqMMqHyz5Dpf9iVoXnd1DMuksWb0KSJRys9AyNZCqKjDSp0AbeMLK/PDxTl5XG9XabnD8rEn1dSddIsD6RFvz/cBGXvLdSI4Z1vv+ohGHddf94L4xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EITobubQ; arc=fail smtp.client-ip=40.93.194.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfWA3K93sXPItE+rTZkDzbBtpRkjWzH9rzXSmqdB0xJPYKWJXnd9sTynoxGDsOawAzka8G76zltfaQ/tKITyi4JFcoGn3nf6vJw/izlNcUl7GZEjwx+4aXrL2ACQrlJ5GI7pBqiECCcUsrJ8/ZOrY1i40GoFpCP3fMu5U3Z7xcciUoiAe9m+iOTVLECG2+PTOCZ7dA7T3YOKS2DYVepKD2WBhwcDzACM3Jyper1/BQ4tRBk4IOw1Rkb4PhmlLCCxrFSvUyw/TG3QZ0IIl/w8OCRqsyhc+uDy+gU+61Ti4B2boBYrft65xAS3AjRK6RFmRXzIK0+xhtREWlGI9eHy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFi94AsSPFpLHwoBCvXaeAiPg42davxBpBiFVqOzMbs=;
 b=E3YQuriVH9RQm/vkwyogzU5en2yZA5URC4EIR4ZHuSpJj/ySQOydFEwCSSjRTvDkwXBslro4nhy2vaAOubpu9caqWCPj4mV0Jl1LMe9HENFUgYyrqBUiyiQxaf9zlYn5RpyYdOLYjogmWJHblbhErp/+OZ/qoxH2QwfATk4dgR8O/PYPCkgDL8JiBombusR+ML3EHeM6jQzvnXIrbA/qSfALQelqPdDNx+wTDXD9mlmLc1MaZ9qiL3xy1kgmiOpmLK0e2ZfbLIjo3abGFo3f+qrzl2AfsLk8SIfNG467DYU2c756G+I6pjoJBXa4svqpo5nzc0OZ1sLBkuhz8gNjBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFi94AsSPFpLHwoBCvXaeAiPg42davxBpBiFVqOzMbs=;
 b=EITobubQFqKZkVWBp73xWqiw1IHo1/ZkgBHGskcN2gjHoLGmWkPg8qGNxmICU+wdKJGuFxY577T37vVJxxBQO/o8d3DKoBE/PNAUXZJLnCczlz0jKNoCgnhSp5uFKE1YulgYcMFOFC0vTtZ4MYqCFJYlVKe3dS9xCdhhyRq/U+RYU3JLvK6vxQbfl85Mwa44sjSKMW4KgAbD0CIqfVtB0yoW5/3jC3zJQtz9WiZaCEit1HlF0cSxbodWAZbfTpB8QgrOylaPxuvh3i9of6uNzOlfCJ9Kd/Fb9I4+GHAo9ZH1O7A8MNdGrGVooxzaWmB+337wBRGOg+wpB7njjC2S3Q==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 23:47:37 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 23:47:37 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
CC: Danilo Krummrich <dakr@kernel.org>, Zhi Wang <zhiw@nvidia.com>, Alistair
 Popple <apopple@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, Timur
 Tabi <ttabi@nvidia.com>, Surath Mitra <smitra@nvidia.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas
	<bhelgaas@google.com>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Topic: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Index:
 AQHcMlaxgAP9KUZ9sEWkb2Bjoc2DFrSscEuAgAAO2gCAAJltAIAAOAwAgACTD4CAAAOvAIAAAkgAgAANNuk=
Date: Wed, 1 Oct 2025 23:47:36 +0000
Message-ID: <1FA2746D-6F73-4D5A-A0DC-803D0563A5D7@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <h6jdcfhhf3wuiwwj3bmqp5ohvy7il6sfyp6iufovdswgoz7vul@gjindki2pyeh>
 <e77bbcda-35a3-4ec6-ac24-316ab34a201a@nvidia.com>
 <DD6X0PXA0VAO.101O3FEAHJUH9@kernel.org>
 <f145fd29-e039-4621-b499-17ab55572ea4@nvidia.com>
 <ae48fad0-d40e-4142-87d0-8205abdf42d6@nvidia.com>
 <DD7CREVYE5L7.2FALGBC35L8CN@kernel.org>
 <e19781f3-1451-4b4d-b4be-c71c9ec8dc63@nvidia.com>
In-Reply-To: <e19781f3-1451-4b4d-b4be-c71c9ec8dc63@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|IA0PR12MB8325:EE_
x-ms-office365-filtering-correlation-id: 485eccdb-5f99-4456-d6cb-08de0144e67b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZFovY2EyT1JOYUVTQm5raVp3VEJYMHVEVklqblBsQ3VxUlJkYkxTSklGbkRM?=
 =?utf-8?B?Ni9KV21Idkk3MTRJdzRDSWtic1gzSXlxVDY5NExYaFErRFBkM3Z5N2ppZWYx?=
 =?utf-8?B?UUlFOE8xQlFWbmprQlB4ZEhrZkpPSllVbWtCVk92YXBEbWd4Tm1GclNtSnJ5?=
 =?utf-8?B?MnhSRjAzUWdNZndwZ0t5Y0FYM0pFQTRvNFNmbldBYm9JNkdnWStLOWF0Qmlr?=
 =?utf-8?B?bmNpMWdwTk1kTHJ6T2o5dVlNWjJXNFhWeTdBdnJ6d04vZHB3ZFRsMFBuRTJ1?=
 =?utf-8?B?ckk2S3dsekVPajdtMmdVUy92RHlMMnRHOXhuWmt5VFozTFpEdzMvUHJPS0pP?=
 =?utf-8?B?S2ducG1ZdER1anNMcFBnYktOT055d0gxT2FqOG1RWEc0T2JtZ2dVb0Y3Uy9V?=
 =?utf-8?B?YWVENUlDay9zeGtKUXMrMCtHM3FSNFBVSVJYcXVWZlF1dUVvelZsNVJQMzV3?=
 =?utf-8?B?SXdxTTdqSGova2FKQVB6SENRdm95LzZRQWdHWFJHV3NGeUJoWHhOOXY1aGwz?=
 =?utf-8?B?UW91angrWWRPT1Vwa1U1ZUZORmFUa2MzL2xiRnR6V0NPKzlSSmZFOEpKek9Q?=
 =?utf-8?B?WHJoSDk1U1dySjh3bzhpQVozYW9KZlRJU0dEaWk4aE5paW1FUnNDdGsrcy9J?=
 =?utf-8?B?ZUhyb0dDb0RJTUNVZjBYbXQrWVRXa2svbDZxYkNsdUpEVkJLdkwxVlF0ek9a?=
 =?utf-8?B?N0ZtN2FJNFYwOStvNC9EUFZHOThhRTBiM0Q1UW9oQUZNOHl2b0c3bzVRVzF2?=
 =?utf-8?B?eGY1OG1GNlhsSUl1Nmsrc3NmMG1rMjRDZUhHUEl3V1VvT3ROSytPMmkwTG5t?=
 =?utf-8?B?K1BHZSswZnN2bHFRYlB3Tnc0YzErRllSejJ4Z3VNdm90WWtvNjczMVd6cUxL?=
 =?utf-8?B?Mk55bG5sL1U5NzVhckVkckdtbDJxc3lrd2lTZ1F5TDFUS05XNWozZW1yVVls?=
 =?utf-8?B?NlZpSXN6M1pZS1Y2Y0g5bjdLMEtHazYzclcrUGl6YnRRY0NBT2k0emVHeUNq?=
 =?utf-8?B?SkxHUzBQWEpRRlZlU0hPWUtaejVZWHIzMVlBTFQwNDJLZitBQk0xRHFyOWx1?=
 =?utf-8?B?SWxWOCtjRTZ5M3hwUXVvR1hBMGp4aVZndG5UVkk1Nm4zMWZONi8rUDl0c05K?=
 =?utf-8?B?K1Y0WEV5UHFMREtJSkk0QUhhTWNaazgyVE82bVRXOEZGV2FzUEIzamR3V2Ey?=
 =?utf-8?B?bEhDSTlPMlhQbnVzQktreFVzVHMwRGRDaVU1NVlkS0RoUVpLNS9uQmVONjNV?=
 =?utf-8?B?REZFYmZSbHFVeGdMQVJzandxWnE2NmRRUzdtMTJlU0laU0NvU2NMTEw3Vyts?=
 =?utf-8?B?VFBVeTJqdThGQ1RicDUrSXVPUWNFSkZGWDcxbjk4WDkxMUVMemU1YnV3VEc2?=
 =?utf-8?B?S0MyclhjMC8yQnB5NUpySW1BRUhqc2FHeU95U25UcWordGpOZ1psV3hZV0dy?=
 =?utf-8?B?bC9uSmcrMmkrejhGUlBjeTJtakl3d2pRdnZnZzhzY0NpcUlxVFU1YXFOdHFS?=
 =?utf-8?B?d05qRUlzaDZhZThiSDJWRHZPV2dWUzhVOVhjdEI2cDY2MG1qb1RYanZIcm1h?=
 =?utf-8?B?RlBXcjdJeVd4aTVhalFJTVYzVjhoM0tCOTVaZmNsUGJNMnZ5K3NnbEVqWXVV?=
 =?utf-8?B?bXZMVTZrMzloL24wODN1c0poYjlYREY1MFFKSjJHL3ZSRTdmL1RJS0ROcG1p?=
 =?utf-8?B?ekwzR2p5Y3FRWEEvRkRNWUVwWlRSaHVnT1lSbHo3R3FlRzlGNC9KTTlWUVc5?=
 =?utf-8?B?bXVvZlliMExKcU9IUHE2eTZsUHNmUFYvbnZ4SlZONnJrdVFxa3NBSHROVjBU?=
 =?utf-8?B?d0l5WDg4R1gycDd4TWRBN0J5YVBsZGpma1d1OWJjbGdJWU16TjVRY0VwWVov?=
 =?utf-8?B?dGs4MUNjWVVnZG1oZEhQNkEzN2FwVVRETU5BSFAyb3c1aG5GbWIrT1o4Ujh4?=
 =?utf-8?B?N1dTN1hQc0RSVS9UNStDMmx4Z1RrcUFXOWJjYU9lRTFhOGZBbEU4TklhekZJ?=
 =?utf-8?B?RkpsTU93T3RMU1dJVEc1OVpVOEZSMTYrRDRhLzkvK0JObmc3OUh0dGdMUlFq?=
 =?utf-8?Q?HdO7U7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWJsZG96M1k4dTFQYmRwdnlqUkhZT0tCK0VTb0NBcSt4YXd2RWo3b2RHMU44?=
 =?utf-8?B?M3k0b05hclBTS3dEQUdIdnd0REdkTFJBc0dyRmRqekpzdW1sMUJ4SFFlVVpa?=
 =?utf-8?B?OXJCc0h0UEl6TFA0cXVVWTNpdWtwalN5VWVDMmdRRW5ra1BFT2ZDVDhRQVJ1?=
 =?utf-8?B?NjBNVEVuV1J0ZnNVY2dmZnE3TVk1WXpkR2k1a3QwZG95ZzBZYmZWQU9xUkdL?=
 =?utf-8?B?K3d4cFoyMUVqaGNFVG1WSldvb1ZCYzdlTmlpbDh2SzJ1cU5GQnBVYThaTTh3?=
 =?utf-8?B?TWJpNU1KMHN1cVIwWjRLRWJwNk1OaEJVWGlTZnlhU3lpbEpzSlB5cnNqL3V4?=
 =?utf-8?B?THg0OHNreGdITXlCNmc1U0NoL2ZNK0ttbmJQcmtiby92U3lQK0RRTGpsa01v?=
 =?utf-8?B?aStCckkrVXN0T09WQnBFOXVnWmw3b1FiSnQ4Z3dYWU5TQ1pWZU5zb0FmeXdw?=
 =?utf-8?B?U01IWkxYSEgyYWFGK3dPY0R3V2kvdUg3eXEyclZuMTBRSnUrbUF1R2ZqWGlD?=
 =?utf-8?B?VkdXdjgzNmdtcHZad3ZDT090MjE3OFJ5RmhxTXdtWnRXYkpGa1VLOElTaHNT?=
 =?utf-8?B?dVpNOGIrOVlBckFXK2hFVXI2ampraWNYK1dkVlQ5YXhLZEtHazJub0xoaGdU?=
 =?utf-8?B?RVFYRDRlbXhqVnROQzZHeHB2QnordzFDc3BLTEtOZVk5czJFNUJ0dUc1blMv?=
 =?utf-8?B?anV6YXRIb2ZobjVKQkxnQ3duaFJLS21yd3ZYMmN2U2tiLzdldFk1dERDQ3JT?=
 =?utf-8?B?a2FyMHNZU3NUeVdSdEpibklZd3d3Z3JkcitnR2lsYk9qZHJvbDlLQjNMYmtn?=
 =?utf-8?B?Njk1L0JJL3VYNm50MEEwU3hWSTdnWktscklrdTZ1VVZKSWhDUXpZcCtPSU1C?=
 =?utf-8?B?VExzUm5lWEdST2FwWGFpd0xadS8xZ3RXWkFNRzM2blQwSHNTZzFicVc5c3cr?=
 =?utf-8?B?VzMyaVkyZlFwQ0kxUDRGZjVTM1REUnVueVg5bWlqbGlkVnZOSE1yUkQ1Nk9I?=
 =?utf-8?B?eVZVY0Y3L3lLQVB4TEJUOGF0elhaK2U3YkhRQ2ExdmlZeGx2MG5ld0ZxSnZ4?=
 =?utf-8?B?S3E0elhtUjBvLytBV20wVGtOME9HYmpKb3hTSnNwUkhUM2tCYzBkcDRISkN3?=
 =?utf-8?B?a2lsd2VUcHhENEdobzJDOW4yRE0wRURlTmZ5RnBmdEFGMTQwL3Ywd3p4NEN2?=
 =?utf-8?B?OWpTUVNHa2xVTUhjYUh1Yi82ZWJUSDVySUJVYTZrMUZzN1JlZG03dUJtMWZ1?=
 =?utf-8?B?d3BOTFE0YzcxY20xT3JIYk05WTBWd083L2V3UXJ4VFJsN2ZNVnZURE16NS9V?=
 =?utf-8?B?ZCt5dCtUeHBkZ040d05EUllIMGQ5ZUtySENCSjRhejdRdnN4LzYwcGZEV3dL?=
 =?utf-8?B?cWI2bE1TUGo5cUQzVmp0MWVNbFAwS2xzSkZrZ0pkTmhqa29mNWVJaW5oaGZu?=
 =?utf-8?B?N2JaeDd5cmp3ZVRHaGVkK3VLSHE4NFVranFScVdTTGczTnc2YnB3ZlRZTHpX?=
 =?utf-8?B?cU1GSkVzcFhUMlNxUVhmWDVGd0dRMGFBTHNwcjNrMkY2UHhrN2tBR2RiTmly?=
 =?utf-8?B?b0NiYzRYSmJHRmY1cWx3VG5WZmhuMXFUN0J4WERLNk1aWVhnZ3M1dTJocFBH?=
 =?utf-8?B?VURSNm9yT3NJMnlOUXN0VSttTU9TQnp0R29ybURiUW9sOGg2aTB6azlXR01v?=
 =?utf-8?B?WkthWkZVdHhxN0tpTzBITm1uTWcxUlg5THpYTngycmN5ZGhuN05OK1dXRHlP?=
 =?utf-8?B?blNCdEw5Q3pwSU56S2gwTnR1eDdYUVdEWXRveWJvNU1NdjJieElQUzFiUDNQ?=
 =?utf-8?B?ZEozNWYrUFJCdG45M0dYZ0FITFpiUVJDWjdDa0RoMlA3MVBrUFl0OStTQ0g5?=
 =?utf-8?B?VTlUME1BcmlZYUVINXd3VFRGc3JzUHkwUmJ6Zit1cHBGek1iaUltMnFGbnlW?=
 =?utf-8?B?Mk5ZcENwN0hSaEpPYzZoWGx6TEJHTFZqd2pYS09CUEF1YlRkVTBRZ2xNOWVH?=
 =?utf-8?B?NzJpNUQ0THBXdGUvalprV3oxMTFTakNDVGFWUlpEeHNrSEM1SGxhaDYyNnNN?=
 =?utf-8?B?Wk5GdFNSbkJCMGRqTXdHN2dhS29HOU02R3EwL2N2UzJNbnJ0TFhyOW54a2Rs?=
 =?utf-8?Q?VD3/u8DWjR9pG6OZOoWaTYWBz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485eccdb-5f99-4456-d6cb-08de0144e67b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 23:47:36.8853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8nVxCsB3S0xIKrHCdPK9mYEcKx08u05//j0Kxj/PfQJVZW8LS5ZucQDnlQ+AjbdNfU5bZae0iQgBpiSapziOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325

DQoNCj4gT24gT2N0IDEsIDIwMjUsIGF0IDc6MDDigK9QTSwgSm9obiBIdWJiYXJkIDxqaHViYmFy
ZEBudmlkaWEuY29tPiB3cm90ZToNCj4gDQo+IO+7v09uIDEwLzEvMjUgMzo1MiBQTSwgRGFuaWxv
IEtydW1tcmljaCB3cm90ZToNCj4+PiBPbiBUaHUgT2N0IDIsIDIwMjUgYXQgMTI6MzggQU0gQ0VT
VCwgSm9obiBIdWJiYXJkIHdyb3RlOg0KPj4+IE9uIDEwLzEvMjUgNjo1MiBBTSwgWmhpIFdhbmcg
d3JvdGU6DQo+Pj4+IE9uIDEuMTAuMjAyNSAxMy4zMiwgRGFuaWxvIEtydW1tcmljaCB3cm90ZToN
Cj4+Pj4+IE9uIFdlZCBPY3QgMSwgMjAyNSBhdCAzOjIyIEFNIENFU1QsIEpvaG4gSHViYmFyZCB3
cm90ZToNCj4+Pj4+PiBPbiA5LzMwLzI1IDU6MjkgUE0sIEFsaXN0YWlyIFBvcHBsZSB3cm90ZToN
Cj4+Pj4+Pj4gT24gMjAyNS0xMC0wMSBhdCAwODowNyArMTAwMCwgSm9obiBIdWJiYXJkIDxqaHVi
YmFyZEBudmlkaWEuY29tPiB3cm90ZS4uLg0KPj4+IC4uLg0KPj4+IEFzIEkgbWVudGlvbmVkIGlu
IHRoZSBvdGhlciBmb3JrIG9mIHRoaXMgdGhyZWFkLCBJIGRvIHRoaW5rIHRoaXMgaXMNCj4+PiBh
IGdvb2Qgc3RhcnQuIFNvIHVubGVzcyBzb21lb25lIGRpc2FncmVlcywgSSdkIGxpa2UgdG8gZ28g
d2l0aCB0aGlzDQo+Pj4gc2VyaWVzIChwZXJoYXBzIHdpdGggYmV0dGVyIHdvcmRpbmcgaW4gdGhl
IGNvbW1pdCBtZXNzYWdlcywgYW5kIG1heWJlDQo+Pj4gYSBiZXR0ZXIgY29tbWVudCBhYm92ZSB0
aGUgcHJvYmUoKSBmYWlsdXJlIHJldHVybikgZm9yIG5vdy4NCj4+IA0KPj4gSW5kaWNhdGluZyB3
aGV0aGVyIHRoZSBkcml2ZXIgc3VwcG9ydHMgVkZzIHRocm91Z2ggYSBib29sZWFuIGluIHN0cnVj
dA0KPj4gcGNpX2RyaXZlciBpcyBhYm91dCB0aGUgc2FtZSBlZmZvcnQgKHdlbGwsIG1heWJlIHNs
aWdodGx5IG1vcmUpLCBidXQgc29sdmVzIHRoZQ0KPj4gcHJvYmxlbSBpbiBhIGNsZWFuZXIgd2F5
IHNpbmNlIGl0IGF2b2lkcyBwcm9iZSgpIGJlaW5nIGNhbGxlZCBpbiB0aGUgZmlyc3QNCj4+IHBs
YWNlLiBPdGhlciBleGlzdGluZyBkcml2ZXJzIGJlbmVmaXQgZnJvbSB0aGF0IGFzIHdlbGwuDQo+
IA0KPiBZZXMsIHRoYXQgaXMgY2xlYW5lciwgYW5kIGxpa2UgeW91IHNheSwgbmVhcmx5IGFzIGVh
c3kuDQo+IA0KPj4gDQo+PiBGb3JnZXQgYWJvdXQgdGhlIFNSLUlPViBSRkMgSSB3YXMgdGFsa2lu
ZyBhYm91dDsgSSByZWFsbHkganVzdCBpbnRlbmRlZCB0byBvZmZlcg0KPj4gdG8gdGFrZSBjYXJl
IG9mIHRoYXQuIDopDQo+IA0KPiBJIGNhbiBzZW5kIG91dCBhIHYyIHdpdGggdGhhdCAiUENJIGRy
aXZlciBib29sOiBzdXBwb3J0cyBWRnMiIGFwcHJvYWNoLA0KPiBnbGFkIHRvIGRvIHRoYXQuDQoN
CkhlcmUgaXMgbXkgb3BpbmlvbiBhbmQgY29ycmVjdCBtZSBpZiBJIG1pc3NlZCBzb21ldGhpbmc6
DQoNCkl0IGZlZWxzIHByZW1hdHVyZSB0byByZW1vdmUgdGhlIG9wdGlvbiBvZiBub3ZhLWNvcmUg
YmluZGluZyB0byBhIFZGLCBzaW5jZSBvdGhlciBvcHRpb25zIHRvIGRpc2FibGUgYXV0byBwcm9i
aW5nIGRvIGV4aXN0IGFzIEphc29uIHBvaW50ZWQgb3V0Lg0KDQpUYWtpbmcgYSBwYXJhbGxlbCB3
aXRoIFZGSU8gcGFzcyB0aHJvdWdoIGZvciBpbnN0YW5jZSwgdGhlIHVzZXIgYWxyZWFkeSBoYXMg
dG8gZG8gc29tZSBkaWxpZ2VuY2UgbGlrZSBwcmV2ZW50aW5nIGRyaXZlcnMgZnJvbSBiaW5kaW5n
IGFuZCB0aGVuIG1ha2luZyB2ZmlvLXBjaSBiaW5kIHRvIHRoZSBkZXZpY2UgSURzLiBUaGlzIGNh
c2UgaXMgc2ltaWxhciB0aG91Z2ggc2xpZ2h0bHkgZGlmZmVyZW50LCBidXQgVkZJTyBzZXR1cCBy
ZXF1aXJlcyBzb21lIGNvbmZpZ3VyYXRpb24gYW55d2F5IHNvIHdpbGwgaXQgcmVhbGx5IGltcHJv
dmUgYW55dGhpbmc/DQoNCkkgcXVpZXRseSBzdWdnZXN0IGhvbGRpbmcgb24gdGlsbCB0aGVyZSBp
cyBhIHJlYWwgbmVlZCBvciB3ZSBhcmUgc3VyZSBub3ZhIGNhbm5vdCBiaW5kIHRvLCBvciBvcGVy
YXRlIG9uIGEgVkYuIFRoaXMgbWlnaHQgYWxzbyBjbG9zZSB0aGUgZG9vciB0byBzYXkgYW55IGZ1
dHVyZSB0ZXN0aW5nIHdlIG1heSBkbyBieSBiaW5kaW5nIHRvIGEgVkYgZm9yIGluc3RhbmNlICh5
ZXMgd2UgY2FuIGRlbGV0ZSBhIHN0YXRlbWVudCBidXQuLikuDQoNCkp1c3QgbXkgc3VnZ2VzdGlv
biwgYnV0IEkgZG8gbm90IHN0cm9uZ2x5IG9wcG9zZSBlaXRoZXIuDQoNCnRoYW5rcywNCg0KLSBK
b2VsDQoNCj4gDQo+IA0KPiB0aGFua3MsDQo+IC0tDQo+IEpvaG4gSHViYmFyZA0KPiANCg==

