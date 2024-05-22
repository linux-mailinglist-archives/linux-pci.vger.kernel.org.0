Return-Path: <linux-pci+bounces-7737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FE68CB925
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 04:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDA2282698
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 02:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A1F1DFD0;
	Wed, 22 May 2024 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ghvXUmbI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E40F5234;
	Wed, 22 May 2024 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716346278; cv=fail; b=XfaLbz+kZY4j3ReQ9u9qxcXi2pM3KzaRQzsNpKEAdKJqP7rTVYVDMTuGuWtP0Le0x68vJj5SR5+KHLPdqIj/8pRRk3STQxaQSD6OymySlSgAcR3EteLS5p8AjoiQlyj91qVJXYfhCezCQ+IctVwUsB5uJ1GaJzpt4gzyZ7ZB3nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716346278; c=relaxed/simple;
	bh=oklHi6Y2tDj5S9UBGuuez5gNHidNornASbrS6/G+6NY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NGn5hhiF04Tmv5Po/Li3neYu2YCoHV3clf2YwR+3/12bWhee5y21KJ/jAYNtXOa+KT60N8RyFsO9Yoq+qAxly2ME4UEAytkGt7RGlZxIaCdFe0Oiby3xUg074jEdMdmKahD3sMJRozf1mCI1JBDvumiNudZmzIb0KaI1xNb/OME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ghvXUmbI; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvLGU/rpcJB/5mxM2G6X2+O3jbNmf1sQsaunxL80cadui/AT78R0uVT+/VONZ8JBAddIzkgQ+Eijtcjb7EwE79kWlEHPFJBOUDROXCTIKpytX2I+ZLRaTX1b9t/NDempGrR1d+jMMLnPLOnp9SXE/ofSsdtb2FUnpfb7aimoOrvHiyTHUdNl2ai3YYagxCRxkWUbmC5HV9cNyt+qWpEos83eTlflUXKrhRsern/5Vv4hhED33gCV5gBq2SNw/fBAY7ZldQ7lrohXfa0z9YV0Tmsawe04Vtt0aAaeKN8NqTcEpDdGHChRuvaAbYuz42pBwfEynderJDFG76B7ywlRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oklHi6Y2tDj5S9UBGuuez5gNHidNornASbrS6/G+6NY=;
 b=finmvzk9gAUveY28zeLpn9rzEhAvegfd0JgCQgZEvFN5Os8uUK3pXfyOS3Om5K7CSE+O9B+4GJxADvSKMSjsDsrC3n9zpD0OowrCRbONnYZ8yjd865sUcJDUlhvWW00UW87n0BJxmsj6/myVIH92zRX5ZsjGX4Xuoft98Mygl0z29nueBQK1CzLMMmoo86648I2RE2GI92jS9aULUn/3lsVLQYODbBcSAETkX1CIz4R4ML+YxDN/jxXh23jtLNpW1tQm0emYHb7ESEkVXyvwSTJb6UoVWXP+oNxijoCu95ByHgVxSaSP7K+4XP6k43AAhvX/4Z35n9KALfpQZKnNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oklHi6Y2tDj5S9UBGuuez5gNHidNornASbrS6/G+6NY=;
 b=ghvXUmbI/wKvcnIMMGydbjUrZPbwL5xfoSGsunnipChJVoGOcFNfGA84ib9PGEoa9pCDztvEBBeR6flDmkfpTCTKPMU8Qo2wXFn5ZxWdfQIldHZk0crftNkEPExsQTlL5ajUGoH1AHz5gnHS3zQeI7aWPU2YGhxzvVR/JXhWcrSzOm7Q7esQCfmT/u6+BXBcdSBciROxNvZYoumYminqO0MTvvTV2tsrLs7zHiG8sMB5E89FIICpeTIs2/cAeng8EDHdN/z6wx70cDAOLeOeKOLv2DQJY0hSwJPoxwnYK55OxS4wFphUvJuJya+Y94FblDm/DUw0lDgjVr/X+UxnKw==
Received: from MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 02:51:12 +0000
Received: from MN0PR12MB6053.namprd12.prod.outlook.com
 ([fe80::3613:eed0:83aa:6997]) by MN0PR12MB6053.namprd12.prod.outlook.com
 ([fe80::3613:eed0:83aa:6997%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 02:51:11 +0000
From: Vikram Sethi <vsethi@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Aslot
	<os.vaslot@gmail.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>
CC: "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lukas@wunner.de"
	<lukas@wunner.de>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	Vidya Sagar <vidyas@nvidia.com>
Subject: RE: [PATCH v2 2/3] PCI: Create new reset method to force SBR for CXL
Thread-Topic: [PATCH v2 2/3] PCI: Create new reset method to force SBR for CXL
Thread-Index: AQHaq6U5ct/dCUiEIU6bQKWDlfCL1bGh/WOAgAAo7wCAAAzDAIAAVNFw
Date: Wed, 22 May 2024 02:51:11 +0000
Message-ID:
 <MN0PR12MB6053B7D06D63421382977913BDEB2@MN0PR12MB6053.namprd12.prod.outlook.com>
References: <E1AAAE3F-E059-4C57-BC23-6B436A39430A@gmail.com>
 <664ce3e1a25fe_e8be29431@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <CY5PR12MB60607B123B05AF10568ED5EDBDEA2@CY5PR12MB6060.namprd12.prod.outlook.com>
 <664d10ebeb537_e8be29494@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:
 <664d10ebeb537_e8be29494@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6053:EE_|SA3PR12MB9199:EE_
x-ms-office365-filtering-correlation-id: 0dfeb51f-056a-444a-257a-08dc7a0a0a34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?UjZNbngrdzc3N0lwNFpTZUFqcFVQbzdqTDBWYmg3ZXBvUkJjWTdOMTZCV0FP?=
 =?utf-8?B?NHg5MFVXMHkvcWdhM3MvQmVacVBCTlZuQjgwYzJZK0l0cFFoZm5HNXNMVlRl?=
 =?utf-8?B?aWhVczFHSjJhb1VqZldVWVlCMEhJREszRkVHMmY3cUZ4cmptRXd0ZWlTY1Jt?=
 =?utf-8?B?YzhpSzV6Ynk0a21SS2FIUyszdHJrMXprb3d3VmV0Wk9uQU4zUklhcmkzcElL?=
 =?utf-8?B?ZW53YU5CUXhMRitiTXBLdmg4TWZ5dVl6U1doL2tiWENPTEs5MlRFOXplY0xR?=
 =?utf-8?B?c25CU3dqQmEzMGF2KzBXNmtadGIzdUZjZGF3UzZlNnEremVBT3BZSVFJQkJW?=
 =?utf-8?B?VnI2UlA3QXZXRnd1d3ZkdDhNYUtFVTRFWm00WG14YlFnMXc1TjY5TXVnYi9p?=
 =?utf-8?B?emJIRHFoTDAzRGxmbm5kckJHWjAyM2YxN2pEUVhHTGdBVmZvSlJMMkhCUUh1?=
 =?utf-8?B?cUJsL3lrSXQvYmd2eFdyVUhUcFdlalVkQUNJd2ZRRUVtY0FJSSsvVEZIK1BC?=
 =?utf-8?B?d1BUcWRqZURpak50dUFPNUFpMzJlQy9vYS9rY2JwSjJBZFN6Ylo2Ni9pdnVV?=
 =?utf-8?B?KzZvS2Z3UXVoMmhUK1NYb3NwdFFwNThBbUdyU2d2S0tlUEtsYkszTU5pOGNP?=
 =?utf-8?B?eUJITE5pZ1lCOVUxQW5yZmNuNi9jSEJsTDEzRng1K2cvTUI3N2FSNGhhbEtN?=
 =?utf-8?B?QmFLcmpoS1Nwak5ENXpUcWJveU9vRmtmVThxNnhRSU93NnRSbXc5RWppSHpH?=
 =?utf-8?B?VTVkQWxqNXZwRmEyeHhhbmRXdUcyblRwQkNBbE1Cc0lEeGVxb0ZKeWxvbXVI?=
 =?utf-8?B?Y1R2Z052ZHpUT2FKYjZJbHU4anJ1cTJEV0x5Unh0RnJOalZOTUpkT0J3UENE?=
 =?utf-8?B?SjNQNHplNitOcEdWYVMzY0JrYzVKS1JYbXJ5eDh6MEUyNUZkbkNESk9jeE43?=
 =?utf-8?B?cFYxN3RsMUtDcE5LanR2Q0ZlY0JCcnJFZUlxSHVsQ3Uvb29ZckQrQjBNQXll?=
 =?utf-8?B?VnVTR0E3MGF1UnlnaStKQUJndHVKckhCNDR4T1paWTBjOHRHWGJMdnd3TFVn?=
 =?utf-8?B?Q2NTUWdUNVBSaHBqSWxVNlhLcXZycWFXdS9JM0U2MUc1a0NkbnRoM0ZqVXFp?=
 =?utf-8?B?NVdVV2ZsS3JkMHZHVDIvSWNtdW9wMngxNmV5K0oveDUwazZkbnU3NUY4Zlhw?=
 =?utf-8?B?MzFxWmRkcFE4cHdPaEpSZEJqMjV1K1B0LzZ3WnRpNEh6SlArV3l2d2c2Vklp?=
 =?utf-8?B?UEJtNEhMY3YrNXVoNlBMWW9NVFZMT0MxcGdzSWZubHZicDVvRmE2Q1JQUzQ5?=
 =?utf-8?B?bkdjVXJPMlZZTTQ0d0hLZzh5d1RDdXdmZWJZaWxpeFAzL3IwbHRhOExMTTU3?=
 =?utf-8?B?ZEtrMmYwSUJ2UTJqL21NdGd2N0pVdEtqQ0YxQVZobkcxcEJJcGZDRmUvejFG?=
 =?utf-8?B?NnVkUTVnSHpJNUpjSWZ1dnBBSmRRMW9hMkVBRTNjRS9oM1dmQk9POFJOaVVH?=
 =?utf-8?B?bjFHWjQxWjMvZHVUeWhJRnpQNndDOGhIcEw4N3U1Vmg1U1V2eDZmeklsUVRS?=
 =?utf-8?B?RVRGc1M4emE1RDkzUnE1TUxNWUtPYVlscDd6KzdSbUVBRmVYWlFPb1ovdW5w?=
 =?utf-8?B?MVN4cW9wNy9vaEUyUlZzQTR5THNMOHlYbENNQThnRXVnd0tWcUpmOVhJWitY?=
 =?utf-8?B?V3ZaYXZsK3JPOXN6MTgwbWZXZ0J0M1BzY2NYMkV5MzF2U2k2ZU4xdXIraFdY?=
 =?utf-8?B?ZXg2M1FkRU8wNHpsa0g1cHdmSlNyQndMR2lkbGNSYnEwVC8rd3Vyc1FOOHAv?=
 =?utf-8?B?TUtueWhDUDgyVm5KNElnZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6053.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3VlVkkzOVQzUW83eWNzV2lJOWk2clB2SFNXUlNDVTJuS29RTlNhVnlpdk9v?=
 =?utf-8?B?R2JlN1RURlY4T0hWWnA3RDV1ZU9yRzQwKzJsdnNMK2RCcjkwZHdwZ1VVbGFz?=
 =?utf-8?B?UFZOM2c3NTVHSTZ5SjV1RkdFV2FKTGI5RGMvS3RGbjFybFVRNHYvY2JEQXpI?=
 =?utf-8?B?Ym1nUkFiWFdSKzZmdDk2TWs0c2E0a1labVlUWjVMOElqaGhEaHpYd0piOHJD?=
 =?utf-8?B?N3VROUdNZnJlVjhaNmZoTEFkVFBGcFlHeWRVcElwVTkvTzVCSlpKRjd4d2h1?=
 =?utf-8?B?Ymp3MStNSFBFU2FjSHd3QStrYUYzMFdxRjJHZUpseVVwVTV5WFNMMVlkQUZt?=
 =?utf-8?B?d1BsYUJ5Y0Z0YWxDN3g4d3lMMUZrdjZHaVJvVWpTTzdiR05kaGFKUzgvSEtG?=
 =?utf-8?B?N2NTMzZ0M1Z3M09EZTVweUFJSGNLWWZTWjVOTWQwM1plZ3E2ZW0xV1F2K2ZW?=
 =?utf-8?B?VXRvMGFCK3BNcDVxYzBEM3lmUjZLS3ZLM05OWCttM0ZMcE03c3REN0JaNHhv?=
 =?utf-8?B?dko5U0ZCeUdxY3VnUllWZzQ5TnNTaitLQWYxWHpFRlI1aTZhOEJpdnNHNmww?=
 =?utf-8?B?cyt2ZXlYazhveVIxaXExL1lNWFFEdTFTOS9lY3ZqN0I1KzFtd3UxaGRtRHRW?=
 =?utf-8?B?YW96cmRKRUFhWWNFcVJQcG40MkgyeHFTYzlWWVF2cWN1ejhVSEV4V0t5Qm9D?=
 =?utf-8?B?UmJMekI2VHA0MzRVdVBPbWdQV3d3bUM1NHpDaDZqSE11NVo1RUpxUGk5RTkv?=
 =?utf-8?B?a0tDamxMTlB4MFJwTVgyT3RLNnBncU9tc01RT2NKMk1CR1Z0TjFrclRLeC9C?=
 =?utf-8?B?eUU3aXRJczhWcFBBR1NjN2pTZE1pRVFDbEtuWldxbW40UEhaVWhsU3BNd3VR?=
 =?utf-8?B?OXRxQmk3STBCU2tNRnQ1SnBqc01jT2llbkQvcnNJYVhjWmZaSVNmeUNmZWQ1?=
 =?utf-8?B?MWpGYTAxR25SK3N6TlpCV2JBUzVWMzdCNGFCdWNOUTN6LytNMCtqK25DdnVC?=
 =?utf-8?B?cjNBYVFwaHY4SUZXTjA2ZUtsRnp2Uy84QXNTeUZyVkErbVRBYWJRV3JBRys4?=
 =?utf-8?B?U3U1Wi9CUmRYUGhldjFsQlFaZGx2M0NpRFc0Mzdad0NzQlBQRHNjTllxS1hh?=
 =?utf-8?B?eTk4QXU1WGFuM1BZMWpHVmE0cy91SkIvZTVLZktZM3ZHcUs5a2lYdlRZRXV3?=
 =?utf-8?B?bTdaL1NBdkFuUTYxN09acmFoYnB3ZTNoMjcwZkM3dXlEV0E2RzFEYlFWVWxM?=
 =?utf-8?B?VDJlWjNWb3BXdlI3MmlxcHN4V3l2eGx3S3FObGNqT2JRa0NtdGxFOEJUZEw4?=
 =?utf-8?B?RjVkZTUvd3p4TUpEaGtkcVBJWDhwR012SmEwSW85SWFnWVJZNVdHT0FYRlNv?=
 =?utf-8?B?VjZEaEkva0syamkxb1VCaGp0cE8xL1d4aW5Tdlpha1JmeFJUQWlPcC82bGN3?=
 =?utf-8?B?aTgzT1MzR2JxUGxFYmV0SUlReFdpUVEvdnhHNVByTk9VNDNEc2R1R2wzTGMx?=
 =?utf-8?B?dlZkWTBDQ1Y5d1ArVk5YdmxOMW5LU2VnakpMbjNBNTdPbDJpbFpvZjIwQVhH?=
 =?utf-8?B?Vzd6UmE0K1BXMEhtOVFsejcxWk5DT0NZa1NKRmhWUlJoUTNJaldNT1lnakw2?=
 =?utf-8?B?TW8wWkNLelJLaUc3akgwZHhoTHpKbnR5b2FkR05WZ2NxWTF2bGQwWVV1TWM0?=
 =?utf-8?B?Vy9aS1hHcGcxOEFYME5DTHBER2t0b0VCLzJPVVFzUndnTGUyK2lHNDJCa2lj?=
 =?utf-8?B?RDVyVG1NRTZBOXMzMFF0cnR6T3N0dWZsaWQxTjlqazJkMlNaL3hBWG5KMUZT?=
 =?utf-8?B?Tk9vTU5HUkVGTHlHZFYxeW5ZRHVsS3lubzV0elZpc3A2VXVCT2Fva2JLNDZC?=
 =?utf-8?B?S3NFY3IvM0xkait3KzFDVGZWakQ2dE8wRHBYQW42b3UvM1hkMWQ1aVU0NWRV?=
 =?utf-8?B?bzNhOXlmY3doUG51MkkyZHFHc1kwUHczMTZkK0kyRktCRDE2VXlLYWRQVGcx?=
 =?utf-8?B?VEpORmJzTS84TWJqZXpKM1dBUUM1MGVpdEVaTHpDYTh1MFF1YklpL2ZrTGNu?=
 =?utf-8?B?RWJ3NjJiMFAxVlZDVUdTdDJxMmlvZnNNNlJFQ2pUN00xWERObEQreHdUVWJ4?=
 =?utf-8?Q?9oJc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6053.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfeb51f-056a-444a-257a-08dc7a0a0a34
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 02:51:11.8630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vj2E9WgWErZd7EFPRh+Xwb1+vRDxaiHo5oOVWWbfl+gemZlf+LHMU/HYHConVWny4X27f0LA6OeJZSBXm/CmOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIFdpbGxpYW1zIDxk
YW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyMSwgMjAyNCA0
OjI0IFBNDQo+IFRvOiBWaWtyYW0gU2V0aGkgPHZzZXRoaUBudmlkaWEuY29tPjsgRGFuIFdpbGxp
YW1zDQo+IDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+OyBWaXNoYWwgQXNsb3QgPG9zLnZhc2xv
dEBnbWFpbC5jb20+Ow0KPiBkYXZlLmppYW5nQGludGVsLmNvbQ0KPiBDYzogSm9uYXRoYW4uQ2Ft
ZXJvbkBodWF3ZWkuY29tOyBhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbTsNCj4gYmhlbGdhYXNA
Z29vZ2xlLmNvbTsgZGF2ZUBzdGdvbGFicy5uZXQ7IGlyYS53ZWlueUBpbnRlbC5jb207IGxpbnV4
LQ0KPiBjeGxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsdWth
c0B3dW5uZXIuZGU7DQo+IHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbTsgVmlrcmFtIFNldGhpIDx2
aWtyYW1zZXRoaUBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjIgMi8zXSBQQ0k6
IENyZWF0ZSBuZXcgcmVzZXQgbWV0aG9kIHRvIGZvcmNlIFNCUiBmb3IgQ1hMDQo+IA0KPiANCj4g
VmlrcmFtIFNldGhpIHdyb3RlOg0KPiA+IEhpIERhbiwNCj4gPg0KPiA+ID4gVmlzaGFsIEFzbG90
IHdyb3RlOg0KPiA+ID4gPiBIaSwNCj4gPiA+ID4NCj4gPiA+ID4gRm9yIFQyIGFuZCBUMyBwZXJz
aXN0ZW50IG1lbW9yeSBkZXZpY2VzLCB3b3VsZG7igJl0IHdlIGFsc28gbmVlZCBhDQo+ID4gPiA+
IHdheSB0byB0cmlnZ2VyIGRldmljZSBjYWNoZSBmbHVzaCBhbmQgdGhlbiBkaXNhYmxlIG91dCBv
Zg0KPiA+ID4gPiBjeGxfcmVlc3RfYnVzX2Z1bmN0aW9uKCk/DQo+ID4gPiA+DQo+ID4gPiA+IENY
TCBTcGVjIDMuMSAoQXVnIOKAmTIzKSwgU2VjdGlvbiA5LjMgd2hpY2ggcmVmZXJzIHRvIHN5c3Rl
bSByZXNldA0KPiA+ID4gPiBmbG93IGhhcyBSRVNFVFBSRVAgVkRNcyB0byB0cmlnZ2VyIGRldmlj
ZSBjYWNoZSBmbHVzaCwgcHV0IG1lbW9yeQ0KPiA+ID4gPiBpbiBzYWZlIHN0YXRlLCBldGMuIFRo
ZXNlIGRldmljZXMgd291bGQgYmVuZWZpdCBmcm9tIHRoaXMgaW4gY2FzZQ0KPiA+ID4gPiBvZiBT
QlIgYXMgd2VsbCwgYnV0IGl0IGlzIHJvb3QgcG9ydCBzcGVjaWZpYyBzbyBtYXkgYmUgYW4gQUNQ
SQ0KPiA+ID4gPiBtZXRob2QgY291bGQgYmUgaW52b2x2ZWQgb3V0IG9mIGN4bF9yZXNldF9idXNf
ZnVuY3Rpb24oKT8NCj4gPiA+DQo+ID4gPiBJbiBzaG9ydCwgbm8sIE9TIGluaXRpYXRlZCBkZXZp
Y2UtY2FjaGUtZmx1c2ggaXMgbm90IGluZGljYXRlZCwgbm9yDQo+ID4gPiBwb3NzaWJsZSAoR1BG
IGhhcyBubyBtZWNoYW5pc20gZm9yIHN5c3RlbS1zb2Z0d2FyZSB0cmlnZ2VyKSBmb3IgdGhpcyBj
YXNlLg0KPiA+ID4NCj4gPiA+IFNwZWNpZmljYWxseSB0aGF0IHNlY3Rpb24gc3RhdGVzOg0KPiA+
ID4NCj4gPiA+ICIuLi5pdCBpcyBleHBlY3RlZCB0aGF0IHRoZSBDWEwgZGV2aWNlcyBhcmUgYWxy
ZWFkeSBpbiBhbiBJbmFjdGl2ZQ0KPiA+ID4gU3RhdGUgd2l0aCB0aGVpciBjb250ZXh0cyBmbHVz
aGVkIHRvIHRoZSBzeXN0ZW0gbWVtb3J5IG9yDQo+ID4gPiBDWEwtYXR0YWNoZWQgbWVtb3J5IGJl
Zm9yZSB0aGUgcGxhdGZvcm0gcmVzZXQgZmxvdyBpcyB0cmlnZ2VyZWQiDQo+ID4gPg0KPiA+ID4g
Li4uc28gaWYgcmVzZXQgaXMgdHJpZ2dlcmVkIHdoaWxlIHRoZSBkZXZpY2UgaXMgbWFwcGVkIGFu
ZCBhY3RpdmUNCj4gPiA+IHRoZW4gdGhlIGFkbWluaXN0cmF0b3IgZ2V0cyB0byBrZWVwIGFsbCB0
aGUgcGllY2VzLiBUaGlzIFNCUg0KPiA+ID4gZW5hYmxpbmcgaXMgYWxsIGFib3V0IG1ha2luZyBz
dXJlIHRoZSBrZXJuZWwgbG9nIHJlZmxlY3RzIHdoZW4gdGhlDQo+ID4gPiBhZG1pbmlzdHJhdG9y
IG1lc3NlZCB1cCBhbmQgdHJpZ2dlcmVkIHJlc2V0IHdoaWxlIHRoZSBkZXZpY2UgaGFkIGFjdGl2
ZQ0KPiBkZWNvZGVycy4NCj4gPg0KPiA+IEZvciBhIC5jYWNoZSBjYXBhYmxlIGRldmljZSwgc2hv
dWxkbid0IHRoZSBrZXJuZWwgYmUgd3JpdGluZyB0byB0aGUNCj4gPiBkZXZpY2UgQ1hMIENvbnRy
b2wyIHJlZ2lzdGVyICIgSW5pdGlhdGUgY2FjaGUgd3JpdGViYWNrIGFuZA0KPiA+IEludmFsaWRh
dGlvbiIsIGFzIHBhcnQgb2YgdGhlICJPUyBvcmNoZXN0cmF0ZWQgcmVzZXQgZmxvdyI/DQo+IA0K
PiBGb3IgYSBDWEwuY2FjaGUgY2FwYWJsZSBpbml0aWF0b3IsIHNpbmNlIHRoZXJlIGlzIG5vIGdl
bmVyaWMgZHJpdmVyIG1vZGVsIGZvcg0KPiB0aGF0IEkgd291bGQgZXhwZWN0IHRoYXQgcmVzcG9u
c2liaWxpdHkgdG8gZmFsbCB0byBlbmRwb2ludCBkcml2ZXJzIHRvIGltcGxlbWVudA0KPiBpbiB0
aGVpciByZXNldF9wcmVwYXJlIGNhbGxiYWNrcy4gT3RoZXJ3aXNlIEkgd291bGQgZXhwZWN0IHRo
ZSBkZXZpY2UgdG8gYmUNCj4gYWxyZWFkeSAiSW5hY3RpdmUiIHByaW9yIHRvIHJlc2V0Lg0KPg0K
DQpJdCBjb3VsZCBjZXJ0YWlubHkgYmUgZG9uZSB0aGF0IHdheSwgYnV0IGFsc28gc2VlbXMgbGlr
ZSBjb21tb24gZnVuY3Rpb25hbGl0eSwgc28gd291bGRuJ3QgaXQgYmUgYmV0dGVyIHRvIGhhbmRs
ZSB0aGF0IGluIHRoZSAiY29yZS9idXMiIGRyaXZlciwgcmF0aGVyIHRoYW4gZWFjaCBlbmRwb2lu
dCBkcml2ZXIgdG8gYmUgYml0IGJhbmdpbmcgc3RhbmRhcmQgcmVnaXN0ZXJzIGZvciBzdGFuZGFy
ZGl6ZWQgcmVzZXRzPyBQZXJoYXBzIG1pbmltYWxseSBzb21lIGV4cG9ydGVkIGZ1bmN0aW9ucyB0
aGF0IGNvdWxkIGJlIGNhbGxlZCBieSBlbmRwb2ludCBkcml2ZXJzLiANCg0KQW5vdGhlciB0aGlu
ZyBJJ3ZlIGJlZW4gdGhpbmtpbmcgYWJvdXQgcmVjZW50bHkgaXMgd2hhdCB0aGUgcmVzcG9uc2li
aWxpdGllcyBvZiB0aGUgQ1hMIGNvcmUvYnVzIGRyaXZlciBhcmUgYXJvdW5kIHRoZSBlcXVpdmFs
ZW50IG9mIFBDSWUgQnVzIG1hc3RlcmluZyBlbmFibGUgKEJNRSkgYW5kIHNodXRkb3duL2tleGVj
IHBhdGhzIGZvciBDWEwuY2FjaGUuIEl0J3MgYmVlbiBhIHdoaWxlIHNpbmNlIEkgbG9va2VkIGF0
IHRoYXQgY29kZSwgYnV0IElJUkMgZm9yIFBDSWUsIFJvb3QgUG9ydCBCTUUgZ2V0cyBjbGVhcmVk
IGFzIHBhcnQgb2Ygc2h1dGRvd24va2V4ZWMgcGF0aHMuIFRoaXMgY2FuIHByZXZlbnQgY3Jhc2hl
cyBkdWUgdG8gZXJyYW50IERNQSBpbiBzaHV0ZG93bi9rZXhlYyBmbG93cywgZXZlbiBpZiB0aGUg
ZW5kcG9pbnQgZHJpdmVyIGRpZG4ndCBkaXNhYmxlIGl0cyBvd24gQk1FIGluIGl0cyBzaHV0ZG93
biBjYWxsYmFjay4gQSBDWEwgaG9zdCBicmlkZ2Ugd291bGQgbmVlZCB0byBkaXNhYmxlIGJvdGgg
Qk1FIGZvciBDWEwuSU8sIGFuZCBhbHNvIENYTC5jYWNoZSBmb3IgLmNhY2hlIGNhcGFibGUgZGV2
aWNlcy4gVW5mb3J0dW5hdGVseSwgdGhlIG5hbWluZyBhbmQgY29udHJvbCBvZiB0aGUgIi5jYWNo
ZSBkaXNhYmxlIiBpcyBhIGJpdCBjb252b2x1dGVkIG9uIHRoZSBDWEwgaG9zdCBicmlkZ2Ugc2lk
ZSBhbmQgZG9lc24ndCBtYXRjaCB0aGUgZW5kcG9pbnQgcmVnaXN0ZXIgbmFtaW5nLiBUaGUgQ1hM
ICJSb290IFBvcnQgbiBzZWN1cml0eSBwb2xpY3kiIHJlZ2lzdGVyIGluIHRoZSBDWEwgRXh0ZW5k
ZWQgU2VjdXJpdHkgY2FwYWJpbGl0eSBzdHJ1Y3R1cmUgYWxsb3dzIGZvciBzZXR0aW5nIHRoZSBE
ZXZpY2UgdHJ1c3QgTGV2ZWwgPTIgd2hpY2ggcmVzdWx0cyBpbiBDWEwuY2FjaGUgcmVxdWVzdHMg
YmVpbmcgYWJvcnRlZCBieSB0aGUgaG9zdCwgd2hpY2ggaXMgcm91Z2hseSBlcXVpdmFsZW50IHRv
IFJQIEJNRSBkaXNhYmxlIG9uIHRoZSBQQ0llL0NYTC5JTyBzaWRlLg0KRG8geW91IGFncmVlIHRo
aXMgaXMgc29tZXRoaW5nIHRoZSBjb3JlL2J1cyBkcml2ZXIgbXVzdCBkbyBzaW5jZSBpdCBpcyBj
b250cm9sbGluZyB0aGUgaG9zdCBicmlkZ2UvUlAgcmVnaXN0ZXJzIGFuZCB0aGUgaG9zdCBtdXN0
IHByb3RlY3QgaXRzZWxmIGFnYWluc3QgZXJyYW50IERNQSBmcm9tIGRldmljZXM/DQpUaGVyZSBt
YXkgYmUgb3RoZXIgc2ltaWxhciB1c2VjYXNlcy4gSnVzdCB0aG91Z2h0IEknZCBicmluZyBpdCB1
cCwgdGhhdCBvbmUgY2FuJ3QgcHVyZWx5IHRoaW5rIG9mIC5jYWNoZSBhcyBhbiBlbmRwb2ludCBk
cml2ZXIgdGhpbmcgd2l0aCBubyBzZXJ2aWNlcyBwcm92aWRlZCBieSB0aGUgY29yZS4gSSBjYW4g
Y2VydGFpbmx5IHNlZSB0aGUgcG9pbnQgdGhhdCBlbmRwb2ludCBkcml2ZXJzIG11c3Qgb3JjaGVz
dHJhdGUgdGhlaXIgb3duIHN0YW5kYXJkIGNvbnRyb2xzIGJ5IGNhbGxpbmcgY29tbW9uIGV4cG9y
dGVkIHNlcnZpY2VzIHByb3ZpZGVkIGJ5IGEgY29tbW9uIGxheWVyIGluIHRoZWlyIG93biBjYWxs
YmFja3MsIHdoaWNoIGNvdWxkIGluY2x1ZGUgZGV2aWNlIHNpZGUgLmNhY2hlIGRpc2FibGUgYW5k
IEJNRSBkaXNhYmxlIGFzIHBhcnQgb2YgYm90aCBzaHV0ZG93biBhbmQgcmVzZXRfcHJlcGFyZSBj
YWxsYmFja3MuDQoNCj4gPiBDWEwgcmVzZXQsIHRoZSBsaW5rIGlzIGdvaW5nIGRvd24gaW4gU0JS
IGNhc2UsIHNvIHRoZSBkZXZpY2UgaGFzIG5vDQo+ID4gY2hhbmNlIG9mIGRvaW5nIHRoZSB3cml0
ZWJhY2sgb2YgZGlydHkgc3lzdGVtIG1lbW9yeSBsaW5lcyBpdCBob2xkcy4NCj4gDQo+IEZvciBz
dXByaXNlIHJlc2V0LCBzdXJlLCBidXQgZHJpdmVycyBjYW4gYWx3YXlzIHRyYXAgcmVzZXRfcHJl
cGFyZS4NCj4gDQo+ID4gSGVuY2UgT1MgbXVzdCBkbyBpdCBwcmlvciB0byB0aGUgU0JSIGlzc3Vh
bmNlLg0KPiANCj4gIk9TIiBpcyBvbmUgb2YgdXNlcnNwYWNlIGRldmljZSBpZGxpbmcsIGFjY2Vs
ZXJhdG9yIGRyaXZlciwgb3IgUENJIGNvcmUuDQo+IEkgdGhpbmsgaWYgdXNlcnNwYWNlIGZhaWxz
IHRvIGlkbGUgdGhlIGRldmljZSwgdGhlbiBpdCBpcyB1cCB0byB0aGUgYWNjZWxlcmF0b3INCj4g
ZHJpdmVyIHRvIGhhbmRsZSByZXNldCB3aGlsZSB0aGUgZGV2aWNlIGlzIG5vdCBpZGxlLCB0aGUg
UENJIGNvcmUgc2hvdWxkIGxpa2VseQ0KPiBub3QgYmUgYnVyZGVuZGVkIHdpdGggdGhpcyBwZXIt
ZGV2aWNlIC8gb3B0aW9uYWwgQ1hMLWlzbSBhcm91bmQgcmVzZXQuDQo+IA0KPiA+IHRoYXQgdGhl
IG9ubHkgJ3N1cHBvcnRlZCcvd29ya2FibGUgU0JSIGZvciBzdWNoIGEgZGV2aWNlIHdvdWxkIGlu
Y2x1ZGUNCj4gPiBwcmV2aW91c2x5IG9mZmxpbmluZyBpdHMgbWVtb3J5IGFuZCB1bmxvYWRpbmcg
aXRzIGRyaXZlciwgYW5kIHBhcnQgb2YNCj4gPiB0aGF0IHN0ZXAgd291bGQgYmUgZHJpdmVyIGNv
ZGUgZG9pbmcgdGhlIGRldmljZSBjYWNoZSBXQitpbnZhbGlkYXRlPw0KPiANCj4gVGhhdCBjZXJ0
YWlubHkgaXMgdGhlIGV4cGVjdGF0aW9uIGZvciBDWEwtbWVtb3J5LWV4cGFuZGVycywgc28gd2hl
bg0KPiBhY2NlbGVyYXRvciBkcml2ZXJzIGFycml2ZSB0aGV5IG5lZWQgdG8gY29uc2lkZXIgdGhh
dCB0aGlzIHdpbGwgbm90IGJlIGRvbmUNCj4gYXV0b21hdGljYWxseSBvbiB0aGVpciBiZWhhbGYu
DQo+IA0KPiA+IEkgdGhpbmsgdGhhdCBhZGRpdGlvbmFsbHksIGtlcm5lbCBzaG91bGQgYWxzbyBi
ZSBkb2luZyBhIGhvc3QgY2FjaGUNCj4gPiBmbHVzaCBoZXJlIHRvIFdCK2ludmFsaWRhdGUgZGly
dHkgRGV2aWNlIG93bmVkL2hvbWVkIGxpbmVzIGNhY2hlZCBpbg0KPiA+IHRoZSBob3N0IENQVSwg
dG8gaGFuZGxlIHRoZSBwcmV2aW91c2x5IGRpc2N1c3NlZCBzY2VuYXJpbyBvZiBkZXZpY2UNCj4g
PiBzbm9vcCBmaWx0ZXIgYmVpbmcgcmVzZXQgYXMgcGFydCBvZiByZXNldCwgYnV0IG5vdCBleHBl
Y3RpbmcgZnV0dXJlDQo+ID4gV0JzIGZyb20gaG9zdCwgYW5kIHJhaXNpbmcgZXJyb3JzIGlmIHRo
YXQgd2VyZSB0byBoYXBwZW4uDQo+IA0KPiBBZ2FpbiB0aGF0IGlzIGFuIGFjY2VsZXJhdG9yIHNw
ZWNpZmljIHJlc3BvbnNpYmlsaXR5IGluIG15IG1pbmQsIGFuZCBpZGVhbGx5IHRoZQ0KPiBkZXZp
Y2UgaGFuZGxlcyB0aGlzIHdpdGggaXRzIG93biBiYWNrLWludmFsaWRhdGUgZ2l2ZW4gdGhlIGRp
ZmZpY3VsdGllcyBvZg0KPiB3aWVsZGluZyBpbnN0cnVjdGlvbnMgbGlrZSB3YmludmQgKG9uIHg4
NiBhdCBsZWFzdCkuDQo=

