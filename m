Return-Path: <linux-pci+bounces-22184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8463A41A17
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 11:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4802A1890F71
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 10:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129D924A069;
	Mon, 24 Feb 2025 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uLXQVk+U"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91268194AD5;
	Mon, 24 Feb 2025 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391199; cv=fail; b=a/CxAO7TUdFU5jhSLwZ8paJFhhRqtmXckqbOslkI55oarUODCB8r6ISFbdPqkyOlyDFgnmU0vIne2KJUsTFTd8ygqTqjlSskEPO9qJf78MsW8+uzyRRuvPROZDQvD98Mq7XCWE+CpusWmx2B6sPNarIl7WijUfREsLgpudke/Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391199; c=relaxed/simple;
	bh=iNzmQMljG6w8DORH6ZFLW9UetZwLz6ld2xQWBX5eeaQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m89tPkinOSATIxDJfvYWL5sWi+peWBu5+7fJKP/0Fhj3E2G2tCsEWdHNOlhVcaxUOe3mxnsKvfX2EbHJAYSQvn/bm7hgrMqickkZX3yX5Bo4Fz4qc2QaGQdNLyQBhz5JE2fwMH/KJhtdo0L/4zOAxmxNIu9PI8ZRpKUsEQMWlCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uLXQVk+U; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ntf3OxYr6DcGwQ6zk8jb0L4q1pOfm1ttpMFV8wKaNZeC2jQ6QyULDDA+Tkh2ElrHLIXtvHSW24hun7hfRm78Lnr2bJRZVI7alxuFB+Vj1QP/NsE6GS5GBB9cQJv+uU6ayaHeZ5+H9mqRWpGcgEN/DXlKFCKbwsvUc3wuO///XBHwPp6Wy2a7D+Z2TbuRsLekkS4HiEC4HdjbFIrqOAvA/3c4yU9p/IZKzq9K8H03idCZhCr3igAofrRRWG4QKYOdvtwxRcft24Xh6XN6EWs36fj5gcfqrfKXp2GvneDL0DY/ccWOE7V8sr1NR392YLxnAZjew/xI/Cznok7qjdhPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNzmQMljG6w8DORH6ZFLW9UetZwLz6ld2xQWBX5eeaQ=;
 b=ToN4FqfAlYX+5oz3eft5gCRrA1SXJc8cO0HlU5jsOD18SYJx9AigFA5NaF+ccAl/jPhzVJH4IrA2apT8irUMXvUO+Y9hdbp8oAxhWm8S8YfkQglQ0xMrtr2f1MbvgO7jVVdZ0eP9V1zWHK3OAawI3os4osL5CuybSmAYHmL5+kVnZdx4iYAku4fSsa8iuI6Ig/G0DGy8lChjju/ja4M0cK5ZG+fiVwHv6LXcTOR2al4CZUq+WnHAQgFXFpMjc2k65OQKrhuFDmTfBHuFn4o0/M6idEeUWitpb7L625f28fxz7gTlM5KqqwoLo5UyBr3n4KH1Sb2ffkkgwbdNO8YYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNzmQMljG6w8DORH6ZFLW9UetZwLz6ld2xQWBX5eeaQ=;
 b=uLXQVk+UaXhuXk/EEjG+0k6bijhJMxvnDi9TtEqkKY2d+dhLSGm4EaqK+uXVQWBO8KdBaCRpibWH1z/gpSiThr6N2YS0JL6bxYBsvNeHL6+/kTpBFg4yD3qGGEoUgNNnWW1sptvIdkh/tpz6h2Z+rvfR3umYkWLFe9CpFI1XnPU=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SN7PR12MB8818.namprd12.prod.outlook.com (2603:10b6:806:34b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Mon, 24 Feb
 2025 09:59:47 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8466.015; Mon, 24 Feb 2025
 09:59:47 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>
Subject: RE: [PATCH v14 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Topic: [PATCH v14 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Index: AQHbho4qtT5H5a0jEEuMfrxVGOqvCbNWFmkAgAAhshA=
Date: Mon, 24 Feb 2025 09:59:46 +0000
Message-ID:
 <SN7PR12MB7201A6C8BC5D3F73640A1C968BC02@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250224073117.767210-1-thippeswamy.havalige@amd.com>
 <20250224073117.767210-4-thippeswamy.havalige@amd.com>
 <144202cc-057c-4a7d-852a-27e979284dd2@kernel.org>
In-Reply-To: <144202cc-057c-4a7d-852a-27e979284dd2@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SN7PR12MB8818:EE_
x-ms-office365-filtering-correlation-id: 4ab151be-cf73-44a1-588d-08dd54b9f87c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZENZbllHS0NYSnVQNUpoTkRaamgzTnZ6MzFZTVhWb3A5UmtIZitEOVVIR3VZ?=
 =?utf-8?B?UmRWQmRaZ2o5UlQ4bFprdWpNdVZrTkUveVpDWmMreERPWmNBdWZMQ0RHTk9w?=
 =?utf-8?B?OFBQQUdDcDZoVTRGTUd6Nlo3WjdjVTZ1b0ZMV3JxejFvRHNTeWI5dTZoV0Fm?=
 =?utf-8?B?aWtjc1orWjl6d2ZCQVRiclk2eVF3czhTUFhNOGtvTjdOSGNib0x1dmpkRFBO?=
 =?utf-8?B?dHl6eHVzRTNpV2h4K0p5MTBHWTdyMFAzUzBudE9oRFRDWGxURUZqaGJYYUtR?=
 =?utf-8?B?MHRYQVRuMnJ0Tmo0VzVUODIwNlBTekx6cFJWTDZRakR2MllsZ3U0MWxwbGs4?=
 =?utf-8?B?bnRtYkNYMUR5QngzWnYwY3p2bytpMmhBK3ZsV3RpRDcwUFhxN1VjZkxlR3Bm?=
 =?utf-8?B?VUtveFhsN1crU1ljaGhnc0FzSFNEUXR5RUlBR2t5K2xDb3hUb0ZKN3ZVSHBu?=
 =?utf-8?B?WlZ1d1VLVnhSejdBL2pmOTlIcCtOZlZ0czVrdVl6ZjMrN2NSY0l5UUlPTmpN?=
 =?utf-8?B?VVdrcFVhVEVweExEU3BQMGRvZkw3TW1jNXplU1ZjYlo1cE04N3RIK01KSE5I?=
 =?utf-8?B?QXNQSWR5TjA2ZEd2TE5GUWRBYnA3bDcxakRKY0d5NERyM0hlSXdsaGJJTmVr?=
 =?utf-8?B?Z1h2YXd1OUFlbU1GSFhndy9ya3N3UHhJeFVUaFRlczl1akpWQ1dRNkRaaUVV?=
 =?utf-8?B?R2xCb2lIb0VMUGkzRkFRakFBUSt0amY0bnpKVmI4QnNuSDdyUklpbDN4RGR3?=
 =?utf-8?B?Q2pXR21sS1FqTzN4OEZKSFM1R3lNMnNFTTJyY3hONVIvcDdjSmJsblAzYlVM?=
 =?utf-8?B?S0pseUhLbjNMMWtTSzJmaFdvTHBjdHo2ekdwdlVVc0g4VDd6dEtMVDFVU2RF?=
 =?utf-8?B?OFRwWDB0Uzh2cElSaytZZDNpYS9YNXgrWjV0K3d3cngrSWlBemJuZWZabVMw?=
 =?utf-8?B?c01pNnB6NHREa3J2bWNxWVN4c2ZOWEk5dDhNU0lHYzRRMjZsSTZDc2V6amFx?=
 =?utf-8?B?TjUrYUJyS2pjaGtQVlVjL3dLNkpMSXdIdWJreDJpdGJLTm5zaWpudFNnRHVV?=
 =?utf-8?B?aFJtQVRUK2M0Q0VWOFdQN0hjOS9xeXUvUWk3dUQ5UnZ3ZVhyeHR4THZjblNS?=
 =?utf-8?B?THpmUkxJSXhrWk5nQzBaUzV0Sm9qUEJidnMwZTQ0ZXNGZmlWS29ZL0VzSVVW?=
 =?utf-8?B?Z0VkQ2Z3LzR2MVZGMDlScmFjMTFST2dhVCt4bFpNcXlhU1lWQndyb2FuWjgx?=
 =?utf-8?B?M3Nmc0U4NHZPcmJTMDJyYm9FU0trL1pwbXJDTWw1UExISEVLTENKL0NYUWRB?=
 =?utf-8?B?NEtGMVJoakJOdWkwOCswcmd3OWFrMzFjUGRsNXpqVXJGVkIwUkswMUVyTVNk?=
 =?utf-8?B?cU9JTWU1MVd4SUJmdk1sYXh5Rmg3VCtXK09nRVpxc2lLaVR3K2YrMTN1dGxD?=
 =?utf-8?B?S2VnV0UrM0czQ29qbUF0ZU8vaFdUVm0xVWROZUhjdzg4Y3NqTVhtQ1UvRVRp?=
 =?utf-8?B?ZlQ1blJyanJBRHlPb2xHaDkyY1B2M2RDeC9YcnkrYnpjUDM5ZVlNQ3lybkov?=
 =?utf-8?B?czZiL2xpWjBBejhreWFOWFdEaC9XSU83VkNtTTRaUEV0UmUyYzIzY2M0K0Vk?=
 =?utf-8?B?UENnM2tWN2IrakQzTGdUZGVsaVZqbXE3RFZXdXJDd0xsU0hvTFF6c2pMbzV4?=
 =?utf-8?B?MWZEN1VEakdOMkJIcXE2V01CTzVPNWI1RFN1a005c1hvRi9GckNOam5pVXFE?=
 =?utf-8?B?SHdaOHNUSE4xZnhwcFJRSnUyS2JpRkNHc2IwZndoS3FTMVZLU2Yyci9nWXZP?=
 =?utf-8?B?VE1oNFlwQXl4WWovOWlZT2ZRVnpveGtkMU1UMUpwTE1PN1gyL3JrVFFOUlNS?=
 =?utf-8?B?YjBaVHNLOXlyL1EzRDkwTEQwWkpoNmJrNkdnQlhJeFBwRmgxQXFxNktwOXB4?=
 =?utf-8?Q?AKt4rfInpq6IXZ1WbL0EwfNF3NLrLTB4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZzZ0aTBDN28rdUlaSnhuRTVUOUN5NHZXREpaeTVWdEphWFgxS1QrSHFlUFZw?=
 =?utf-8?B?cS81K0NXc1BVZ1lXb1Q1ZUhlemI0SDU3UFpzZGV5VnByckxxN3dYWndBejRs?=
 =?utf-8?B?NDVrWWNONm5hMWl2MFM2OTdac1lvVXRlblJ2Mmw2bmZaMWJCUngvcGRYYkxx?=
 =?utf-8?B?N1hvcHByd1IzRXlyaGlqWUpvUGpDYmg1V0NhTktHaEtwNDV5djRzTFRzcG1z?=
 =?utf-8?B?UmJtVWtyT0M0WEU3YmJ6NmxDOEUyZVRyeWx4TWRncWh5dmVSS1IrUzkyZEFK?=
 =?utf-8?B?Mm1laFkya2VtYXZUYkpycUpqSGo1ayszOXhjV1ZzckNYckZ2dDB2ZEl1QTZG?=
 =?utf-8?B?czRBbjBFcVdMVXBSUHlIRjR3cFFXWEh3UlJGRnVUK1ZYU2paYmp2aGJjcWdr?=
 =?utf-8?B?SzRDMERBempscERRVkJ4TUpnditkM2dIdlJ0OHBVaCtjK05wMDNDeUgwNWt4?=
 =?utf-8?B?UFZkNVBodU45bkM4R1llcG5lM1hadVlHL0JZTk5nSTBrLzlRb0dUd0xKcGNx?=
 =?utf-8?B?SjJ4RDVHWUtrdEtDdnRiU1NkOG5TYThSSFFrNkxidmwwSUxPdXc3M3AzME11?=
 =?utf-8?B?YWpNN24xbm9JaThyNXpkb21VQ3NPeFVoUFZGdFNHUkhRVENzeXM5Z3ZIL1N0?=
 =?utf-8?B?b2M0U1F2RXJEZWpkYWc1MHJlYXFHbkJOeXZFQzNuVzFmZENtUjJWT0RKUHNw?=
 =?utf-8?B?RzV0OUVXb2x6RGJlbkhSb09aR1p5YWhlMmMzWE0rWXZieFVlcHJXSklzSGxK?=
 =?utf-8?B?bVkvVXJIOVJzdWtrcTVwaUkrMFdlNFZDb3FjaTJNZDE3eXBlN3Rucml5L1ho?=
 =?utf-8?B?T1YxS0p4STcyQmZXeVVGY1BkK3c3N3cwVHNqYVhNWnZNR1VSOUZyNWdkOExM?=
 =?utf-8?B?dXZCeGU3bi9HaXA4NSs1U0ZISFV4Qk03UFNFY1NFVHd0bkdGRDNQdkdGUHN5?=
 =?utf-8?B?SUIzSGRnRE1Nd3B5bmV6ZU5qalBPbDhaUUFNS3ErcjdXdE5PK3VRc3d0SDZE?=
 =?utf-8?B?cno3WUszQXRVdk1RM2U1b2xIT1l2YS9OYWVlOURSeEZJbXBGbEF1TDNQUGFj?=
 =?utf-8?B?VzEzSGFDeTZrMzhTdENpeTZEVFJreUs2SFpqUUV5Vk1MVEpiMmN1LzV2NDdN?=
 =?utf-8?B?Z0NUd2JCa252ZjR1a2RtZnJlaFlnamE0cnp3cm9KbndpSHVHS3JnaVlxQU1n?=
 =?utf-8?B?c25yZW16UVNXNVZIVjNKUm9qQW1wRHRaVUNxdTR3bUNuS2lTQk4xMHROUUN1?=
 =?utf-8?B?RGFWNU9EZk1TWVF4QUJPRkJvNkZrdVBrUUNla0kydE1ZdmF2RWJJcUZUOGEw?=
 =?utf-8?B?NE1vak1EdHN1a1phNE5ORXhNSmFST0NNdzNRVm9ud0xJMDlkUGJ3cVF0b2l5?=
 =?utf-8?B?cVpDbitDUy9TalBoODVOOU5nTCsvZkcyckJlYS9NN1VzUWlpMW9kM3gzSURq?=
 =?utf-8?B?VG5CanNRTitScysrbGwzdFB6SEwyYjZiOFd2a1ZEZWsxVWJVTisxbGFBTkRs?=
 =?utf-8?B?djY4M1k2cG11YU9sKzdQcUZlUncvYkFCOFc1bXF1WFNxNDRGNExoa2o2TTdO?=
 =?utf-8?B?R1dybFZvVU5uTVdsRjZ1MHFBa2hRZkkrTnlTNmVhUEdPMi9Ec3hlZUZDKzNR?=
 =?utf-8?B?OFdRQ21sa3hTYmlISnB1UXdRaXo1K09raC9NU05tR0dLM1hiMnhDWTVEUFBn?=
 =?utf-8?B?TThvOGRQNjJML2kzSVY0SWZvNTVZTVpPaHlZQXR6OHI3L1k2NTBsUlFkK1Jj?=
 =?utf-8?B?K3Fudjl1MGF4Rk5zei9TdWVMMWtJRzB5NW5CZy8wT2xKeFdvdm50QUxxT1Rm?=
 =?utf-8?B?OUlEMGE5RWtGTXlqcVA4QjVBSWJvNEJ6T1lJVlFOckFUb1lqN0NDNmVCZ0Jl?=
 =?utf-8?B?NFA3TUlLQnFzQ2dvZTFRNVBrT28zWWZtVVU0MlZMclp2TlZwQTk5MzFnZUJ1?=
 =?utf-8?B?bytvbDd2dENxbTlheXN6UWNyM2FOajY1Y0IzYzMxQnVmbUJWNGdzaTB6Nmgw?=
 =?utf-8?B?c0w3bU1aR2xybFo2T1Q5UTlvZDlpODd1cS9YcFErQjh3TFZGYzFQRXFOTjZY?=
 =?utf-8?B?WEZiQkZxZHYyNHNVcGJJT3dWNjF6amluVmw5RGwzM2hWK2VSQXZidFBVeGpx?=
 =?utf-8?Q?dsbc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab151be-cf73-44a1-588d-08dd54b9f87c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 09:59:47.0805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4D4ApDsfcmmK5aKwLjYM+VRkzEckMSIt00syCzhbO0YJ1/q4QG1oyfvPhYL/zpIhTT1G92vARNpgcbU00XQV6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8818

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHJldmlld2luZywgV2lsbCByZW1vdmUgaXQg
aW4gbmV4dCBwYXRjaC4NCg0KUmVnYXJkcywNClRoaXBwZXN3YW15IEgNCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9y
Zz4gDQpTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDI0LCAyMDI1IDE6MjggUE0NClRvOiBIYXZhbGln
ZSwgVGhpcHBlc3dhbXkgPHRoaXBwZXN3YW15LmhhdmFsaWdlQGFtZC5jb20+OyBiaGVsZ2Fhc0Bn
b29nbGUuY29tOyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsgbWFuaXZhbm5h
bi5zYWRoYXNpdmFtQGxpbmFyby5vcmc7IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwu
b3JnOyBjb25vcitkdEBrZXJuZWwub3JnDQpDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgR29nYWRhLCBCaGFyYXQgS3Vt
YXIgPGJoYXJhdC5rdW1hci5nb2dhZGFAYW1kLmNvbT47IGppbmdvb2hhbjFAZ21haWwuY29tDQpT
dWJqZWN0OiBSZTogW1BBVENIIHYxNCAzLzNdIFBDSTogYW1kLW1kYjogQWRkIEFNRCBNREIgUm9v
dCBQb3J0IGRyaXZlcg0KDQpPbiAyNC8wMi8yMDI1IDA4OjMxLCBUaGlwcGVzd2FteSBIYXZhbGln
ZSB3cm90ZToNCj4gQWRkIHN1cHBvcnQgZm9yIEFNRCBNREIgKE11bHRpbWVkaWEgRE1BIEJyaWRn
ZSkgSVAgY29yZSBhcyBSb290IFBvcnQuDQo+IA0KPiBUaGUgVmVyc2FsMiBkZXZpY2VzIGluY2x1
ZGUgTURCIE1vZHVsZS4gVGhlIGludGVncmF0ZWQgYmxvY2sgZm9yIE1EQiANCj4gYWxvbmcgd2l0
aCB0aGUgaW50ZWdyYXRlZCBicmlkZ2UgY2FuIGZ1bmN0aW9uIGFzIFBDSWUgUm9vdCBQb3J0IA0K
PiBjb250cm9sbGVyIGF0DQo+IEdlbjUgMzItR2IvcyBvcGVyYXRpb24gcGVyIGxhbmUuDQo+IA0K
PiBCcmlkZ2Ugc3VwcG9ydHMgZXJyb3IgYW5kIGxlZ2FjeSBpbnRlcnJ1cHRzIGFuZCBhcmUgaGFu
ZGxlZCB1c2luZyANCj4gcGxhdGZvcm0gc3BlY2lmaWMgaW50ZXJydXB0IGxpbmUgaW4gVmVyc2Fs
Mi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRoaXBwZXN3YW15IEhhdmFsaWdlIDx0aGlwcGVzd2Ft
eS5oYXZhbGlnZUBhbWQuY29tPg0KPiB8IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8
bGtwQGludGVsLmNvbT4NCj4gfCBDbG9zZXM6DQo+IHwgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
b2Uta2J1aWxkLWFsbC8yMDI1MDIxOTE3NDEueHJWbUVBRzQtbGtwQGludGVsLg0KPiB8IGNvbS8N
ClRhZ3MgbmV2ZXIgc3RhcnQgd2l0aCB8IGFuZCBhcmUgbm90IHdyYXBwZWQuIEJ1dCBhbnl3YXks
IHJvYm90IGRpZCBub3QgcmVwb3J0IHRoaXMgcGF0Y2guIERyb3AgdGhlc2UuDQoNCkJlc3QgcmVn
YXJkcywNCktyenlzenRvZg0K

