Return-Path: <linux-pci+bounces-13025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F6B974964
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 06:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0381F26ABB
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 04:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCE94D8D0;
	Wed, 11 Sep 2024 04:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ztqmg2FO"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E04AEF7;
	Wed, 11 Sep 2024 04:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726030460; cv=fail; b=LJGeJF+n7rpZhOSSGKZAfsl7rs3OzGpdWDVg0tT2VDL9RFS7gFZ0qgyJjaaWTIC+nrQrhvXfeMnsmEiKICxVtTiFNccwqaVhIsk2YL4zscCScY0wM2ah80vEf9Rlef2h2PX4eCLfhzQUCRzeDDa/GOOF3vF6VlM99B5X4cOBJ2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726030460; c=relaxed/simple;
	bh=I3pGJm4xcmeaA0l6QxVL6XDNjdmLVh+r2DTFzRGNfYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EWn5y5uqxDYzDnsqyfUKnc9jfwWM4h8hRUAhXPoRI6+RryA/MU5mJZooSRXm3UlRvtnB04IkU6ldGl/aiiojRaSKu16OdDz1cERI434r2NDMAwTxqsc1dgZTDHumHPxL0xuBMuhkJ454GeetXC1Oe50iRKquXLZmRKe0PkMtRy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ztqmg2FO; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcaCgn1lq/hNsvhhMd61TyupLf0HME/4G/LxsXNp8CrLhUe6ekREuUWMqaPxCcGTiGh7t2WsGAB1/AbBogD/rZtx+mjJSy5xW5Tssa6LIMbTkHEjgFRanuP8JyeHDSdnZDYK+Em0qBr3Dol7Bd1SUvPyA+BTmW2BiCNxw0jQtI080k3F/XO+3XCs6gk91Bvb7R2yQ1CD8/7EsKWKUTr//745eD6PFTjs3uInaVjyzSiWvPBg8/40Pq/5MdYYQyDIXhEefsf7zXwU4CvnqegPOGLU3iOvZdIiDcKMItS0D6l5KrMIU1HqiI2OACdZ0gqzlXJ6/qjKD3xZIr/6g2Uizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3pGJm4xcmeaA0l6QxVL6XDNjdmLVh+r2DTFzRGNfYM=;
 b=LH06pGw8ztvOTsNyEKTWfgQgo1/+I08dZzOtY8DKja9FYtHNKat/q95DCgOP/HH9gvDgA4FQFsFoQFnmiVYzCF7Ap6is2qSPv4NvbK9qPZrjeCUAC9e3Bsg4Hl54qRR2oy9XgJadorVP2rLSY514AI8STzUmDsGoZw2z0u7yN/5st6RT1tCL+0pbw7wAtTkRWbzCxg4eAE7fZU4Z1iZLIL8MR9t8d1nRvuaUrCIcUGU5a4sQ3eh5+O2QlWoWRSXhIzcZBpQ+ZIh1xnRgAx/yIsrCheVmiHVdOXpc8tB+59owwi6lXoJE248Xue1JpyQUUVprLcRU8HFvb9Aq/KXNuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3pGJm4xcmeaA0l6QxVL6XDNjdmLVh+r2DTFzRGNfYM=;
 b=ztqmg2FOpG5/vAKOYeiJSpbIW00dTOM2OoqvprRAYVMTg0JMJ5yYAAPl0QNGLoo+Wz0dIiSkviEPCD4gwnZhXKmqTRaMUXqI2bOSSYRJCEvFPCmWWaKrFKi3eg0MzU4+C8EIZHVSRV7kSY4lBt6MYAUig5y3kU2tPWF52O9I8xA=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Wed, 11 Sep
 2024 04:54:14 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 04:54:13 +0000
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
Thread-Index:
 AQHbAD+qs/ZP6ddUUkqwXrFBAjDnM7JKhZSAgAAMnRCAAAE/gIAAAH/wgAAZkQCAB11PwA==
Date: Wed, 11 Sep 2024 04:54:13 +0000
Message-ID:
 <SN7PR12MB7201112E057B779EFCAB4E898B9B2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20240906093148.830452-1-thippesw@amd.com>
 <20240906093148.830452-2-thippesw@amd.com>
 <e985a9d4-b398-4290-a4b9-08999c6a9f71@kernel.org>
 <SN7PR12MB7201F82C9BC29ACEE7E209028B9E2@SN7PR12MB7201.namprd12.prod.outlook.com>
 <7ebc9676-d66c-4d82-902b-e824bcb2c921@kernel.org>
 <SN7PR12MB7201E4EB5370AFFE8FCAB56A8B9E2@SN7PR12MB7201.namprd12.prod.outlook.com>
 <958c52de-e77d-451c-93e9-e87373f4ae50@kernel.org>
In-Reply-To: <958c52de-e77d-451c-93e9-e87373f4ae50@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|CH3PR12MB9456:EE_
x-ms-office365-filtering-correlation-id: d3455763-4f99-4cc9-939d-08dcd21dc86c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFRhTTdweEp0QXo2b3M3Y20vSFVCaCtPVTdmczVYVU9KY1pYc3BidzhhajNo?=
 =?utf-8?B?clhzbmNRaUU5dVF6RHpWSndTTjBHSGFWWXFkN05UMmZYbFFmZThzdFhyRVJr?=
 =?utf-8?B?aWRLblBXem5MYzFaWThvTTJsMHJlQkswNks0L2lhZXJHOVpXeHQyMWlSUUgy?=
 =?utf-8?B?a0Izb3lETjJGclVlVXBCaTIybXB5VFhpTzA0TzFTVDhsMVBsczV6TGxuamhV?=
 =?utf-8?B?QXJmcVhVK1lVb09ES0dCa2U3Y3lDVzYxNStHR09naWMwYmpROElDL29vdU8y?=
 =?utf-8?B?d1BDcENVREkzK2ZDZXUwMENUZXo2U0FuTDZXL2EyZHpkMENYZHR1bjhyV3BL?=
 =?utf-8?B?MkVqZllhd3liQmZwdUxZb1BFRytvdmo1NGIwem84SGlqVEpSS0FUbkt4eUhX?=
 =?utf-8?B?VnpoNUMzUzgralFEZjV5cEY0K05jc2xuTkNPZ2Y2a0tzVjNBN1RxOGRhSmRl?=
 =?utf-8?B?NjVEN0YyN1RZOU13c3h0anQ3NzlFdUVWQWJwTkVYTWlaak5ReVJDbExmd2FQ?=
 =?utf-8?B?dHhXWmo1VmFoSzAwTTgrczk0Wk1VaXh5SElZVkJrT3grZExCZ2lBeFZKaVU2?=
 =?utf-8?B?K0R4ZTdQSE1lbjd6RVNqdjV1bTRRa3JPME5YVWY5RlVWR3ZjYU9wVHpzd2Rv?=
 =?utf-8?B?b0hmeFBTNjRhY3h6WjBmNFRiOVQxWHp0VUptekNrQW03eS9EYjFVSy9EeGU3?=
 =?utf-8?B?K1RwKzdSUVg3cmNTdUZubitqbk4rN0kxYlhMRElaVkpyRmpQbDBjRU1uUitP?=
 =?utf-8?B?S1hzK3JIRUY5VzZHV3FRS3ZES3BoUmRST1U4Q1pOMWJySHIwWmFpbFMrOVpV?=
 =?utf-8?B?WU5ZaCtEN054OS9vNGh4NDVWdGJRSFZ5azl6MUhzTEpkQVVrL2dkSlI1VHd3?=
 =?utf-8?B?NU9mSUx2TE1wQjhqMEtHNmhESFAvSzA4U0d6U1Qwc0toamJHTFMxYTVKZjQ3?=
 =?utf-8?B?ZWgvL1V5MWV5VlJUeHhMTVpsSkZ6NkRVSVYwZXgrSE9UZUZjcm1xWkhKN3FP?=
 =?utf-8?B?NGxqTjF3bGtmRXRSR1I1UWhUZXNEYmNSTUZLU1ZuUFZOWk9uVnBoOEZLZ3Vz?=
 =?utf-8?B?ZnhUU25IczF2Mi84SmN6VkprMStNcDR0S1BmRkp4SlVNRHRwa3A3UHVQUVBT?=
 =?utf-8?B?ZWwvUnlpVnJGQVY3bmxVSDN5Y2FOc2ZDRTg0Wk81V1FZd2M0cXcvSlRqdHJs?=
 =?utf-8?B?S09xVFlKN3dsNy9McEdSR28wZjZqVVhNWXlORFdPT1RBLzRjOWYrcEs3aFlZ?=
 =?utf-8?B?YnJwZEMzeDJ4eFNhZlFkb2FBZlJXOEhYaVNFSFJSR1NVdWRleHo0OXEwYVZO?=
 =?utf-8?B?ckVqRjlRb3JoNmRNSkpDWkZjelJNZG9idGNvT09mN2ErOVE3dnluRUtTeFZq?=
 =?utf-8?B?Tkc3RXR2QTR4YkpucnlkYlptZEpKSURSZFhKK2MzcDRvb2svT1NyeTVhYXd6?=
 =?utf-8?B?dVo0dFF6NCtKQ0ZhNjZFckV6bUFQMm1VOEhlb1d1ampwWXNORjF6UFZXdzI5?=
 =?utf-8?B?YzRsWlhwQTFwNEtZUWRZbUs3U0F2NElWazNYcktIM2VlK3h2cUF5UGx6TWZt?=
 =?utf-8?B?bS9tK0lSSzhONGVUNVhhTmhQcVNWSm1BdkVjKzVvcnZyMExHOW5vSjU0TTJj?=
 =?utf-8?B?YXk4eFlxQWZpT0NIOWw4MHc3cHFFb0xQakkvVkYxYngzSzBzaWg5SjFoaHNz?=
 =?utf-8?B?ekUwdktPN3VtS2UzbnRManRSQkdya2JUSVhhbG5ja25vcWNaOUFHUnpLM1Ey?=
 =?utf-8?B?WWR4WEJkRUVEV0xMaFdPUWVIMnVQY2Y3U0NrbnVjMi9QQmFsSitvc2hkaURa?=
 =?utf-8?B?YlBxaFZPRjhGSGlzQUNaa2tYMlkzcXdkZDJSWnd2SDN6eGRiOTRPc0QxRXNh?=
 =?utf-8?B?ODhRYk9HWkg0SjJ6UFJCRVhJcERwbWFDenpEQURXMEFBenBLVUdWN2Z0RzJV?=
 =?utf-8?Q?Z9cOa3QPO8U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDFJOUFBZG9RU1JGMDRqdld6Y241eDdCU0JlVmo0a2FOOWRGRCtSbVZyOFNw?=
 =?utf-8?B?TFlIU1piQno1VlJzNUNMWmxwN2tMSjRPcHRja3BmVjFrNjRoNjI5VUl1Y0xa?=
 =?utf-8?B?VmxZUjlxQzJ6ejJTNDlqeXdIUkJLbXFHcE1HYWZqOHgrV3g3UHQwZkwzbHdx?=
 =?utf-8?B?dENDUDJzamlReUhwM3piU213OU1IOW1Bdk1sRFFaMXFQa09FMGtmWEJlbjlU?=
 =?utf-8?B?LzJLc29EQTNoL3JOTWFwL1pKdVkrbnoweExNNVV3L3E1WG52ZTdMUFFLM0NJ?=
 =?utf-8?B?Nk5Oems1WUc3cisrV3RRNjVCUitKR01wOUVBNzUvNnRzbm4wVWpVUnd1Z1pF?=
 =?utf-8?B?blYxL0JXOENjSmVZRTNTQW9oL25pYXZRQjU5YnFuZW4xelg3T0VlSVREbXF0?=
 =?utf-8?B?dVVXV0VPb2dwU2tyaVQvM2h1V0ZqVlZDdVRyOERSMVRQL2srSmpDR3UvaVpT?=
 =?utf-8?B?M3BuNnc1dEljVUJ3bnQxQXBPRElWUlJ0bTQ2cEIreEFYZGdIcXV0bmV2SHlX?=
 =?utf-8?B?QTNSOCtIWjcyTm1JbGVFb0ZiQTdDeE5HQVhsSzFwSzRtZnZLRm8rTnFKVXdI?=
 =?utf-8?B?R1dvL1p6RUZ3Mm42OUVabG9rYnJXYkZIb1ZKNDVkVVpMSzZ3ZExtY3BUdENw?=
 =?utf-8?B?ZzhodU5CQ3dxSHpZL1pKelEvWEpIMTdlY2lYMnZtam5sR3Y3VWN5MzF1WCtm?=
 =?utf-8?B?MzY5aWkrN2ZiTmFNcW41QW14MGY0YW9kc2tZaTdFRHIzQkg1UnM1UkNvVUw1?=
 =?utf-8?B?UXF5VzZMd1hOOGRjbk1LQnVLcStLcjJGZlg4YTJGVncyQmk1WUQ5NS8zdmlJ?=
 =?utf-8?B?eHdOTjlSSjVyK3pBdEI1MWFDaXJHMnVwNDc1R29idnpOSGRhYzJ2UkZNa1NN?=
 =?utf-8?B?UktySUNyeXlzYVhOZzhNUDVvTXJJRW5FcVlqWU05Ny9CMFF3YXd5bE50cWFr?=
 =?utf-8?B?b3VLS2NKK2ZRbGlBMFZ3bmk1aGZjUmtkVmpNemQ0RTArVXk4M1JXL0RJbGk0?=
 =?utf-8?B?QlJRUnk4V3l0Zmt4S0JhN0FoN3pLN05FWjlxWDh6TDF0NHJ4TzNlRGx5TGpJ?=
 =?utf-8?B?dHZJcWcwS1BPQ3JDNHZza1ZORis1TEdWKzJvMytkUjU2L3hWdHg5bk5uYWtJ?=
 =?utf-8?B?TGE0U0hXNmJ0bEc1UHVwemMyYmc1cGxYTGQwTlU1bmk2Sk1zcDkzMmJXeW80?=
 =?utf-8?B?RGFQd09PbTltVnRsWUo1Q1EyZHpQa1RPM3lESzdCanp1NTZ2bGN2NUpHZzFX?=
 =?utf-8?B?ZHVnWlhsaFY3TDJlcyt2STJhaG55V1hCcmp0b3paV2JUczdwOGF1bHpFV1pC?=
 =?utf-8?B?Y2Q1emkrdk93bCtjeWlTSXV2bkRBdW1tUFdzOTViaFhFaWRTQ2h4YjdmeVNL?=
 =?utf-8?B?MVEwNTVUMURFQmVFWTkrL0hQQ0JGa0p0YUFKRnBtcVYza2Rza3ZCalhTUE5C?=
 =?utf-8?B?ZmMxaEl1N3hyWkQ1SkE4UzRKcnExSWhBTkQrRkZ6NWlmczN4dUJjUDFqWFRr?=
 =?utf-8?B?NUVTQXd4aDNlcFZGSzRWaEFhQ2E5Ti9DMzlMQmFiZTFQQWNLSStUbm1iUVFr?=
 =?utf-8?B?NENXVWZUYXhjR1UvYm1rdnBxZ2NBc0lHSUJPSnJRdmdjZzRJekxFMFBGdk0y?=
 =?utf-8?B?czBvZ2VmbFRqZnN2RkpscmRrUHBNRUpQMDQvVk81am9yeHBRRkxVTVE1dEpv?=
 =?utf-8?B?K3BHNmJMenZWbkZFQmIyT3hRRmhMR05EQXhtazkwT0J2d3FJYmZHUGRWcG1l?=
 =?utf-8?B?ZzdCSGZOK0hhbmNUcUlYLzRDNTRCamh2MDYzQXhNYnR6LzFLNWo3NGdyWlJv?=
 =?utf-8?B?RUdhVEdSYjZNY2YvNHlNSkhucDQ3UkdLc3NtOUhHSmhGL05RYlFWamMzVVpY?=
 =?utf-8?B?cWlYOGhJVVN3dzNYdnlkY2Nncmp1Y2haS2QvUEUrRkRIYnRUWG1JZmw3MCtB?=
 =?utf-8?B?ckNIcU5kK05FSzNaRDVOaVErWXBpOUszVTNXOU1YUzRVWFBkQmRWY3c2NjRt?=
 =?utf-8?B?RHdna3FuWTlhS2JiRWZ4U0lZeWdDVVkxWHZyRXhjSFJraGVqUHdiOXpvVTh1?=
 =?utf-8?B?RG94clkvbXZVV2l1a2dlRDJlRzQxeWk4N2NuNFd5cXkxUlpmRVhoVWNxazNU?=
 =?utf-8?Q?V3Wc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3455763-4f99-4cc9-939d-08dcd21dc86c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 04:54:13.7723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igLSnVVa42DyoYHtQrkVfUGPRppbjX5F81O9OK2IC888SaGLjaAjEqjzp75gQNnvHM3geTRzxD+14ubOSY5G/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogRnJpZGF5LCBTZXB0
ZW1iZXIgNiwgMjAyNCA1OjQ5IFBNDQo+IFRvOiBIYXZhbGlnZSwgVGhpcHBlc3dhbXkgPHRoaXBw
ZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+Ow0KPiBtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJv
Lm9yZzsgcm9iaEBrZXJuZWwub3JnOyBsaW51eC0NCj4gcGNpQHZnZXIua2VybmVsLm9yZzsgYmhl
bGdhYXNAZ29vZ2xlLmNvbTsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga3J6aytkdEBrZXJuZWwub3JnOyBj
b25vcitkdEBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogR29n
YWRhLCBCaGFyYXQgS3VtYXIgPGJoYXJhdC5rdW1hci5nb2dhZGFAYW1kLmNvbT47IFNpbWVrLA0K
PiBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBr
d0BsaW51eC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBQQ0k6
IHhpbGlueC1jcG06IEFkZCBjb21wYXRpYmxlIHN0cmluZw0KPiBmb3IgQ1BNNSBjb250cm9sbGVy
LTEuDQo+IA0KPiBPbiAwNi8wOS8yMDI0IDEyOjUwLCBIYXZhbGlnZSwgVGhpcHBlc3dhbXkgd3Jv
dGU6DQo+ID4gSGkgS3J6eXN6dG9mLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4g
Pj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgNiwgMjAyNCA0OjE2IFBNDQo+ID4+IFRvOiBIYXZh
bGlnZSwgVGhpcHBlc3dhbXkgPHRoaXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+Ow0KPiA+PiBt
YW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZzsgcm9iaEBrZXJuZWwub3JnOyBsaW51eC0N
Cj4gPj4gcGNpQHZnZXIua2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbGludXgtYXJt
LQ0KPiA+PiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gPj4ga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiA+PiBDYzogR29nYWRhLCBCaGFyYXQgS3VtYXIg
PGJoYXJhdC5rdW1hci5nb2dhZGFAYW1kLmNvbT47IFNpbWVrLA0KPiA+PiBNaWNoYWwgPG1pY2hh
bC5zaW1la0BhbWQuY29tPjsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd0BsaW51eC5jb20NCj4g
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBQQ0k6IHhpbGlueC1jcG06
IEFkZCBjb21wYXRpYmxlDQo+IHN0cmluZw0KPiA+PiBmb3IgQ1BNNSBjb250cm9sbGVyLTEuDQo+
ID4+DQo+ID4+IE9uIDA2LzA5LzIwMjQgMTI6NDMsIEhhdmFsaWdlLCBUaGlwcGVzd2FteSB3cm90
ZToNCj4gPj4+IEhpIEtyenlzenRvZg0KPiA+Pj4NCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+Pj4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9y
Zz4NCj4gPj4+PiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciA2LCAyMDI0IDM6MjYgUE0NCj4gPj4+
PiBUbzogSGF2YWxpZ2UsIFRoaXBwZXN3YW15IDx0aGlwcGVzd2FteS5oYXZhbGlnZUBhbWQuY29t
PjsNCj4gPj4+PiBtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZzsgcm9iaEBrZXJuZWwu
b3JnOyBsaW51eC0NCj4gPj4+PiBwY2lAdmdlci5rZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUu
Y29tOyBsaW51eC1hcm0tDQo+ID4+Pj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+Pj4ga3J6aytkdEBrZXJuZWwub3JnOyBjb25v
citkdEBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiA+Pj4+IENjOiBH
b2dhZGEsIEJoYXJhdCBLdW1hciA8YmhhcmF0Lmt1bWFyLmdvZ2FkYUBhbWQuY29tPjsgU2ltZWss
DQo+ID4+IE1pY2hhbA0KPiA+Pj4+IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IGxwaWVyYWxpc2lA
a2VybmVsLm9yZzsga3dAbGludXguY29tDQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJd
IGR0LWJpbmRpbmdzOiBQQ0k6IHhpbGlueC1jcG06IEFkZCBjb21wYXRpYmxlDQo+ID4+Pj4gc3Ry
aW5nIGZvciBDUE01IGNvbnRyb2xsZXItMS4NCj4gPj4+Pg0KPiA+Pj4+IE9uIDA2LzA5LzIwMjQg
MTE6MzEsIFRoaXBwZXN3YW15IEhhdmFsaWdlIHdyb3RlOg0KPiA+Pj4+PiBUaGUgWGlsaW54IFZl
cnNhbCBwcmVtaXVtIHNlcmllcyBoYXMgQ1BNNSBibG9jayB3aGljaCBzdXBwb3J0cyB0d28NCj4g
Pj4+Pj4gdHlwZUEgUm9vdCBQb3J0IGNvbnRyb2xsZXIgZnVuY3Rpb25hbGl0eSBhdCBHZW41IHNw
ZWVkLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBBZGQgY29tcGF0aWJsZSBzdHJpbmcgdG8gZGlzdGluZ3Vp
c2ggYmV0d2VlbiB0d28gQ1BNNSByb290cG9ydA0KPiA+Pj4+IGNvbnRyb2xsZXIxLg0KPiA+Pj4+
DQo+ID4+Pj4gU3ViamVjdHMgTkVWRVIgZW5kIHdpdGggZnVsbCBzdG9wcy4NCj4gPj4+IFRoYW5r
cywgVXBkYXRlIGluIHRoZSBuZXh0IHBhdGNoIHNlcmllcy4NCj4gPj4+Pj4NCj4gPj4+Pj4gRXJy
b3IgaW50ZXJydXB0IHJlZ2lzdGVyIGFuZCBiaXRzIGZvciBib3RoIHRoZSBjb250cm9sbGVycyBh
cmUgYXQNCj4gPj4+Pj4gZGlmZmVyZW50Lg0KPiA+Pj4+Pg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5
OiBUaGlwcGVzd2FteSBIYXZhbGlnZSA8dGhpcHBlc3dAYW1kLmNvbT4NCj4gPj4+Pj4gLS0tDQo+
ID4+Pj4+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3hpbGlueC12ZXJz
YWwtY3BtLnlhbWwgfCAxICsNCj4gPj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KPiA+Pj4+Pg0KPiA+Pj4+PiBkaWZmIC0tZ2l0DQo+ID4+Pj4+IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS94aWxpbngtdmVyc2FsLWNwbS55YW1sDQo+ID4+Pj4+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS94aWxpbngtdmVyc2FsLWNwbS55
YW1sDQo+ID4+Pj4+IGluZGV4IDk4OWZiMGZhMjU3Ny4uYjYzYTc1OWVjMmQ3IDEwMDY0NA0KPiA+
Pj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3hpbGlueC12
ZXJzYWwtY3BtLnlhbWwNCj4gPj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BjaS94aWxpbngtdmVyc2FsLWNwbS55YW1sDQo+ID4+Pj4+IEBAIC0xNyw2ICsxNyw3
IEBAIHByb3BlcnRpZXM6DQo+ID4+Pj4+ICAgICAgZW51bToNCj4gPj4+Pj4gICAgICAgIC0geGxu
eCx2ZXJzYWwtY3BtLWhvc3QtMS4wMA0KPiA+Pj4+PiAgICAgICAgLSB4bG54LHZlcnNhbC1jcG01
LWhvc3QNCj4gPj4+Pj4gKyAgICAgIC0geGxueCx2ZXJzYWwtY3BtNS1ob3N0MQ0KPiA+Pj4+DQo+
ID4+Pj4gVGhhdCdzIHBvb3IgbmFtaW5nLiAiLTEuMDAiIGFuZCBub3cgIjEiLiBHZXQgeW91ciBu
YW1pbmcNCj4gcmVhc29uYWJsZS4uLg0KPiA+Pj4gSGVyZSAxLjAwIHJlcHJlc2VudHMgdGhlIElQ
IHZlcnNpb25pbmcgYW5kIGhvc3QxIHJlcHJlc2VudHMgY29udHJvbGxlci0NCj4gMS4NCj4gPj4N
Cj4gPj4gSSB1bmRlcnN0YW5kIGJ1dCB5b3UgcmVwZWF0aW5nIHRoZSBzYW1lIGlzIG5vdCBoZWxw
aW5nLiBNYWtlIGl0IGJldHRlcg0KPiBhbmQNCj4gPj4gbmV4dCB0aW1lIHVwc3RyZWFtICJob3N0
MS0xIiBjb21wYXRpYmxlLg0KPiA+Pg0KPiA+PiBOdW1iZXIgb2YgcG9ydHMsIEJUVywgY29tZXMg
ZnJvbSBwb3J0cywgcmlnaHQ/IFNvIG5vIG5lZWQgZm9yIHRoZQ0KPiA+PiBjb21wYXRpYmxlLg0K
PiA+DQo+ID4gVG8gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIHRoZSByZWdpc3RlcnMgZm9yIENvbnRy
b2xsZXItMCBhbmQgQ29udHJvbGxlci0xLCBJDQo+IGFtIHV0aWxpemluZyBhIGNvbXBhdGlibGUg
c3RyaW5nIGluIHRoZSBkcml2ZXIuIFRoaXMgYXBwcm9hY2ggZW5hYmxlcyB0aGUNCj4gZHJpdmVy
IHRvIGlkZW50aWZ5IGFuZCBtYW5hZ2UgdGhlIHJlZ2lzdGVycyBhc3NvY2lhdGVkIHdpdGggZWFj
aCBjb250cm9sbGVyDQo+IGJhc2VkIG9uIHRoZSBzcGVjaWZpZWQgY29tcGF0aWJsZSBzdHJpbmcu
DQo+ID4NCj4gDQo+IFBsZWFzZSBkb24ndCBzdGF0ZSB0aGUgb2J2aW91cy4uLiBJIGtub3cgaG93
IExpbnV4IGtlcm5lbCB3b3Jrcy4gQnV0DQo+IG1heWJlIEkgd2Fzbid0IGNsZWFyIC0gZG8geW91
IGhhdmUgcG9ydHMgcHJvcGVydHkgdGhlcmU/IEkgZ3Vlc3Mgbm90LCBhcw0KPiBpdCBpcyBQQ0ku
DQo+IA0KPiBXaGF0IEkgY2xhaW0gaGVyZSwgaXMgdGhhdCB5b3UgaGF2ZSBleGFjdGx5IHRoZSBz
YW1lIGhhcmR3YXJlLiBTYW1lDQo+IGhhcmR3YXJlLCBzYW1lIGNvbXBhdGlibGUuDQoNCg0KQXBv
bG9naWVzIGZvciB0aGUgbWlzdW5kZXJzdGFuZGluZy4gWW91J3JlIGNvcnJlY3TigJR0aGUgcG9y
dHMgcHJvcGVydHkgaXMgbm90IGFwcGxpY2FibGUNCnRvIFBDSSBkZXZpY2VzLg0KQmFzZWQgb24g
Qmpvcm4ncyBpbnB1dCwgSSdsbCBmb2xsb3cgdGhlIHJlY29tbWVuZGVkIHByb2Nlc3MgZm9yIGhh
bmRsaW5nIHRoaXMgc2NlbmFyaW8uDQpUaGFuayB5b3UgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLg0K
DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

