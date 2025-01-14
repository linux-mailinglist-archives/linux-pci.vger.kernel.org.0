Return-Path: <linux-pci+bounces-19791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03884A1157D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D8F3A1A58
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BDA215055;
	Tue, 14 Jan 2025 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JSqpYDMA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCF9213245;
	Tue, 14 Jan 2025 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897663; cv=fail; b=OPo9xGt8yErSTW0Vp4A6BsMNsvX9kEntpuM7gHYCTfo/DbnvT6HQVhJhGeuof/ArixSnu2BQhwEcwVbOIBWvYYOEOyQtOxqIdkM3k6AEZW9XEfxts3tM6s9EMZYN9jZVPYvvGCSAVnmhXVG+MWGaR2sh7qRFYkG6bpvpa2G9T4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897663; c=relaxed/simple;
	bh=r3w8xQcjXmjFkc8RAdheOmHrlgh2u1dx+4cIaQfRgf8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GbV1b94bL5n+WZ4pnsHbCEs5ilza/MpXmmfwvBIoHfXWpqkLm24x72TfOXTvYCVIOwOC5lTAzbKNZxfiSQyK+V4vxNFAGWQ7YthtwAPaCfIurK5/z4GGcTYOU7HX+QN5MDQbHm0+1tpboeA0iiOG/TqJ2R6ruJuSAXsrEkZ6buo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JSqpYDMA; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLOfBmNLRN3GL5uggSRUCcCMLX0xnr6GzjKtBq7Q9EA8bRxd0Tj/acDeeotNIxkxovA9EJerpbbH1YwiK5J5fqM9UVqKVI5X6NxlPS5kt6+YSSU7K3Mjk/iJoKx0muxmX3I8DN0zlq3HHrn0unqG6Pl6lBb9SaFy6ALXjjieFP0aeNja7cWS3P3noeCQxOtdTCkmdjT0Oh2Ph5TgCIBzw99OjCy9Cbcr+B+5qfkLmXq4bz6Y9SuG+jWfPXOL+j0i7okvOBmSeVYgxTntdGGMmrnpPkdzVL1gE8xrec/OnYHgil6Ku7WnLpN9L+GILHaMEGaibCLOutu/HzSFT/NS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QKEurN8UGFsx8TSd120VINIvaf5T0cJ7fRd5ssTAJM=;
 b=JXqIZAhcLGiqdTjVkvc/B6V7NBch6GVmhMGzfQ+wlUPLHp9vYk7JyY2/2j5JuYRnc6DRttiE5RqnbSfq7A5kohPpuGyVdR3qnQmXAxhimtCZbvaaGB09qH2MDZ6+Iq02A8tpp1U3dmByXgbQCAUv5gEM4m6dFOHHd1PTHwi0nZ1jYs/Oz46brRoHjQA7P6+fmwfqSj/bgUaRYgSRBfp9xFPc3qg4EDaTJJj8OpmVLGzfK8wH8JLYDmZrYGe4nZN5b/gQ6PcthvvKUCqDz0zojrGtYDaAFStmUqc+7kzO94vYgf8YnGG4QZcBvRPfIUB7f3GU7Szl1IrJjMrf0qKmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QKEurN8UGFsx8TSd120VINIvaf5T0cJ7fRd5ssTAJM=;
 b=JSqpYDMAa5/9kRYg0NhExAjHOotuTw8C7bSq9EJCVuH0FvHKcnU3eSYLJsKkXasV8VVKE29khVU6YbK+iST3AqorcBX5Aq4/DNvDzuF/tlJKrasvFulH97gQyUg8NXRf2ZZw4TXAjtHIxa2KGDtcEGNueASpTcSwwqEfE+GsvCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 23:34:17 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 23:34:16 +0000
Message-ID: <e3df211d-b699-401f-ac00-1715f7a2d15f@amd.com>
Date: Tue, 14 Jan 2025 17:34:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/16] PCI/AER: Enable internal errors for CXL Upstream
 and Downstream Switch Ports
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
 alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-17-terry.bowman@amd.com>
 <6786f2a7b2b7f_186d9b294f7@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6786f2a7b2b7f_186d9b294f7@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0172.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::28) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: f46e96b2-e322-40a9-26a9-08dd34f3f5f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elk2NmYwZTVmaVg0NS9aSXl3ZWdlRGFuVkx5NkNMMnJDbm1vWjB3TE8zVzEw?=
 =?utf-8?B?TUttQnhFR3gwOFV5Y2tUMmVna3RJbjVQcTRXN0VIVE0vZjRkTGptMXVGRjB4?=
 =?utf-8?B?Q2VManBHeFNtRFBzMFNPTDRvSDQwREJSb0g2Q1JTczZCaTczUWVwcisrc1BN?=
 =?utf-8?B?SFowNXB3SFhkUEJLekRsVWRCdU05RVdGbWZWRjZxZXdVSmJxVmt1MDVmOTAw?=
 =?utf-8?B?Mmoyc2tURTdnY3Y0SlgrOUt4MDEraHA4YUhxRWpIYUs1TmtZVDBYSmZ6QnFK?=
 =?utf-8?B?VmNpKzlPRzNaeHJzbHdQY3lLait2anlWU3V3MnhxTGs3cTd0Q3F5bHY5V1Rw?=
 =?utf-8?B?eEtTUkp5dlRCdFFoay8zbnNmUUlWKytycWRMQmdvTjJOc1lrWWJ3RXdnaG9D?=
 =?utf-8?B?c3hsczB1RE9meXJCeDFlUGpzbWFhS0dVdW9NWDBMWjBINXpKWXpTMjk4T1BE?=
 =?utf-8?B?SnBvNkFkSUhpNEJoSVdSR0s1M0wvT21kK3JDNjBTUi9aZ0V0eHNMcEN6U3ly?=
 =?utf-8?B?Z2wwVE9QKzB6SlZnWmNaNEppaFg3dVhPVWtSNG5UNnE2V1ZQZ3hCNWpta21l?=
 =?utf-8?B?eHRCR09oWTZmcUIvV2FCR1l2RG5FL0d6T3ZwUVYreXIvV3VkSUxkZW5Dd1FX?=
 =?utf-8?B?NDBYSjNIWWtXRk5QOUw2U21WRFlZUlROSzRsTzlWQkhVd3dnbTVCekVEY2t0?=
 =?utf-8?B?bHo4b0ROWGJQMWYzRHYvRWFYM1VvWGJHRDJTVEhGTWo2cFJWUWRSS3JwM3Rh?=
 =?utf-8?B?UkZ2R3FBb2VmeWtBaDBFSTgvMndGS3NkYWFoZ0gyYzB6RWtCUG5UL3ZDVFFP?=
 =?utf-8?B?NEF5d1FKVDIzUEJhbEVWYnIxM21ITUFQWk80bDF5U1dodmlvVXpFV082bzFp?=
 =?utf-8?B?dVgxajdyZmNaajNWSlNxSjhtZHE0MlVMQm9SRFFNR2Nta2VsTzdodFMvZ3RL?=
 =?utf-8?B?WDBJQ1QwUSszWkF6UGdtS3JQcXBlcTMrUkJPSGUvWEx3R2lmNWk5VVlzQnpF?=
 =?utf-8?B?OVZ4QU5JOEZEcU42Z2xIbFZWYmxtcXFXMUIvVnNreWRRSkNUdmQzdE9Vcy9O?=
 =?utf-8?B?RENwcTFUMkVmZkc3cXVUUmJLc05lR0FGWFFDekhvcGlHazIraFFQSkYrdWVj?=
 =?utf-8?B?Z1U1bC9SdUdJWHpvNjJEOExpNngxakxFeWJ1aHY2Z1hjTVp6YlR6Z3ZjVHBh?=
 =?utf-8?B?WE9DYUIxdXYzaTFwclJMeVc4Ky9BeWJ0aVFmMjF3TkxzWnlKUGFxQ0ZjSm5T?=
 =?utf-8?B?NDQwOElUeFdiM2hsK1BMWDNUNzd3SE9UZlZLaWtPb2NHL09QNzYrdG1EVkph?=
 =?utf-8?B?d0ZEOFREN3h3NTg5YmEwTVJjTnVIcThIaGFDQnJRNE90MmxrRHBGVnhHVlhy?=
 =?utf-8?B?ZUtRd05rWjUwZ0tCY08xL1ZTQkpsNlVFWkd2U2N6R1BFUUpUanhsb1d2aTRZ?=
 =?utf-8?B?LzFYSGZsd2NPYVprUlkxUURYMEYwSFZ6MVFpNnNyOEh4dThrbFZNZWhMYUNh?=
 =?utf-8?B?RXBteGN6NmNNVnBOQ212R3lJa2RUL1Jjbzk5UEFHaGNtVjZuaEgvOWU5WG9o?=
 =?utf-8?B?bnpVaGYwSlpuQXMrcVc0Q2NHbWYzcWc2NWhnYXo0SDFZUDNZWDgyVkF4NmFX?=
 =?utf-8?B?ckFvT0dmUWpHSkJiUXlXVDlPeklQTmZxcTJ3b09sWnNNTzlCNXF6a3hScmZu?=
 =?utf-8?B?dXdaQkttU1JnOVRja0U0U3YvaDB1eDFoMjdKbWErWWpqRDZtdDRrUFpYZ0Jl?=
 =?utf-8?B?RFlGQ1dlTG15M3dSUjIvb3ZjeXBrYzloRmZLN1Vzc1RUTHJOOG5jbnI1MmJI?=
 =?utf-8?B?QlRJQlJJQ0o0bDlQbDFDc1lJanQwWEk5SWNhQWV3S3JoTDhVSjdnSnlGejRC?=
 =?utf-8?B?WlFQSHluK1paREJVT0lPV2w1R1RtMk1oZm40UXRlaHZjTGZhRy82eVZBU0dS?=
 =?utf-8?Q?shEO9JyBDZw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWdhTHdZaVRnWlcrVVJRUmJYeUdaSkdwTllYcUtTVmV2WS95K2NaMGFmWmpY?=
 =?utf-8?B?cll6aFlTcHBGY2VwOE5Wa05oUXU2bnNJY2VGMWV2QkhXa2VwQ3RkelZPUnVG?=
 =?utf-8?B?NjhtNlBmRjF5eEduaThFZWVlTTRjSjd5aXRTOWlJRms1NCtLUklGNzBnTkNo?=
 =?utf-8?B?aG9CVUpodllBS1gycFpoUDJYL0VKd1pRc1JmdlZRUkRiZXY0QThkTDhKaEpj?=
 =?utf-8?B?bUtJelVUTDV2UmpqWkNYY1FUbEIyUitqQ2xGczRPajEvUkVoRzBibStUdGU5?=
 =?utf-8?B?V2IrTnVoVTM5L3krenlpbzJzbHNtTW1TNUJ5UmRUTHRud2JoM25VRktyR1lK?=
 =?utf-8?B?ek9oQ01sQWFVdUtOcmRXVjFiendjVmdibVVmZk5ISUxqMThjRUovZ2prYzBo?=
 =?utf-8?B?SW55cDlsMHpHKytWUUtHbjZwb1hMQk92enlVSzRNS25ocWdPWGk1akliNHk2?=
 =?utf-8?B?aHk1clNiV2lrNldzdk9tZnAyVEU3L2duK05hVkU2ZHZoV2VLT0dJKzJXbjlW?=
 =?utf-8?B?TkxjQ1VLUHdoQ1E4dmJvNTc2WU1ES2xSQ0QyeFNqMkt2M1FxYlVyamRZSlUw?=
 =?utf-8?B?cFB0TkFoZ1B1MUp5cFNaMzdEcitzQ0MwWEFNWndTMEFDMU9mMlFFdWo0c2Q1?=
 =?utf-8?B?ZzhydU9YcTNzR2xaelArYkdOTjZwcis4aDl0L0tUZjdsaXI4TmhWNW1LVzdR?=
 =?utf-8?B?RVg0L05WLzV3TlZ5bklxTlpDVHBKU3ZSaDFjQ25VUGticlhmYkg4aGhWWmNN?=
 =?utf-8?B?SkFoOG5RSkptODBQelVhMVJadzc4Ly9nQ281T2lQaTQ3UUhyVWtuVi9MS2pD?=
 =?utf-8?B?VXk3bVFMM3RFZ2JOamdEK1I4Z3d6N1pDSjhLNXpBRkswRFkvdjY0ZUYzakM1?=
 =?utf-8?B?cHpRS0FtS1JNYTUxMGdub2lyMHY3V0RWT0dVMC91WGVVTlBiSjVQVFRnOTI1?=
 =?utf-8?B?ZUdsUDM3QzdjbWlBNURubk4wYS9VdlBIbk5idCthQ1dNRmhsRUY4QWpUamdI?=
 =?utf-8?B?cE1ZdFdBSUthS1YxUDdxaUlGcjVwayt6VVdLYnZzeFRqSG5mVituQVU0ODNP?=
 =?utf-8?B?aVR2SklHOVZKYkpFc2ZxWXFUOWloSjRPWlhjeWFzSzR6SXJyWjRQVUFkUGEr?=
 =?utf-8?B?Rkk2SFBiNFNhMS92cjhvMzN5d1ZJNUt6OXJud1g2RXM5a3Nvbmp5cUxiZDg5?=
 =?utf-8?B?WWthNE50UFdGY1Bqc3lmd2ZHSlE4L3BmMEMydm9VQnJyYUo4YkwvUUcyTDlj?=
 =?utf-8?B?cld5YVVaVkJrNHZ4djVGRldxVWlFMUlRMU9qRk4yT0pnK2NoLy9veUdsODVP?=
 =?utf-8?B?T0I2KzdrSUE4Smkvb3FkblBrSlExZnVKeDBvOHJYZG12a2JIdEl1YVI0Ly9L?=
 =?utf-8?B?NkNUdjNFNUloSnkvV0FxcHhqNWY1T0tveW1tMTB1SmhGbGptWThQSEJDYlFp?=
 =?utf-8?B?UTBtcmpab05vNW9sUWY5ZUEzOXM1R0tRYlZkTWZrbVAxZkVMSFFlT0FqcWZo?=
 =?utf-8?B?R0xMYVRlQUJGZVN0SVhmR3RidkUzVHZ5Skl1RlowaXdtcXVVK1dvcysvK0Nj?=
 =?utf-8?B?VmdxK2FBUnVnV09WVTRXMGpveXFSakhxdG10MTZrRHZVZXo5V01mT1Rka20y?=
 =?utf-8?B?dDh5UnRLTml6WnpGd3NIN3lKQUdQWkU1R01KWkFaUTVsdVZlMGkyYXFwUWFj?=
 =?utf-8?B?cHY5YjYwaFhvSi91b0JOZ1NmQlNjVUg3N2kwMVZ6TTNJWkRmTlFxbHZYNzJ0?=
 =?utf-8?B?ZWMyZERRNnhid0xJRVNCQ3lTbytScDA2eFVhMVVITnpDaHphcCs5eGhnd2l1?=
 =?utf-8?B?Ulo1aHpKZHpQck5GdTh5RTNvNmIwelYwOS9PbFJvdFZ5YVc4RmtCQ09uQjRy?=
 =?utf-8?B?UTFZeXlpbEtiOWdhK2J2ZFFOajkyVjVYQmJIVzRCeThHdDhIN1BFVEs4N3ZK?=
 =?utf-8?B?dTNEZUNucFFST0htUXpHRUJ5YkxrOVpaUUlIdDVPYTNqR2ZPQWxJK21WOU5a?=
 =?utf-8?B?MnZvcXVYcXZVMmpuNGVBL3czcDdTNUp1cXJRS1NXbVRhMGdhTnRaUGJQVjJF?=
 =?utf-8?B?dUVuLzE2QzczTDF6T1VmeWZ2VHhZMEgvS3Q5Y1NRbkFHekJtUlRMUTZtMlhl?=
 =?utf-8?Q?/imUS9G5zZUSwzRvgv6atnlg+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46e96b2-e322-40a9-26a9-08dd34f3f5f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:34:16.6856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKIEbyYExiXIs0UXll951mLVQZPhgloAbg0FoC261K12I0AgodiRIGhbu1cx8/xK6mZxEti9QR0D2VKQRtGHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842




On 1/14/2025 5:26 PM, Ira Weiny wrote:
> Terry Bowman wrote:
>> The AER service driver enables PCIe Uncorrectable Internal Errors (UIE) and
>> Correctable Internal errors (CIE) for CXL Root Ports. The UIE and CIE are
>> used in reporting CXL Protocol Errors. The same UIE/CIE enablement is
>> needed for CXL Upstream Switch Ports and CXL Downstream Switch Ports
>> inorder to notify the associated Root Port and OS.[1]
>>
>> Export the AER service driver's pci_aer_unmask_internal_errors() function
>> to CXL namespace.
>>
>> Remove the function's dependency on the CONFIG_PCIEAER_CXL kernel config
>> because it is now an exported function.
> This seems wrong to me.  As of this patch CXL_PCI requires PCIEAER_CXL for
> the AER code to handle the errors which were just enabled.
>
> To keep PCIEAER_CXL optional pci_aer_unmask_internal_errors() should be
> stubbed out in aer.h if !CONFIG_PCIEAER_CXL.
>
> Ira

Bjorn (I believe in v1 or v2) directed me to remove pci_aer_unmask_internal_errors() dependency on PCIEAER_CXL because it is now exported. He wants the behavior for other users (and subsystems) to be consistent with/without the PCIEAER_CXL setting.

Regards,
Terry

>> Call pci_aer_unmask_internal_errors() during RAS initialization in:
>> cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().
>>
>> [1] PCIe Base Spec r6.2-1.0, 6.2.3.2.2 Masking Individual Errors
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>  drivers/cxl/core/pci.c | 2 ++
>>  drivers/pci/pcie/aer.c | 5 +++--
>>  include/linux/aer.h    | 1 +
>>  3 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 9c162120f0fe..c62329cd9a87 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -895,6 +895,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>  
>>  	cxl_assign_port_error_handlers(pdev);
>>  	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
>> +	pci_aer_unmask_internal_errors(pdev);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
>>  
>> @@ -935,6 +936,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>  	}
>>  	cxl_assign_port_error_handlers(pdev);
>>  	devm_add_action_or_reset(&port->dev, cxl_clear_port_error_handlers, pdev);
>> +	pci_aer_unmask_internal_errors(pdev);
>>  	put_device(&port->dev);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 68e957459008..e6aaa3bd84f0 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -950,7 +950,6 @@ static bool is_internal_error(struct aer_err_info *info)
>>  	return info->status & PCI_ERR_UNC_INTN;
>>  }
>>  
>> -#ifdef CONFIG_PCIEAER_CXL
>>  /**
>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>   * @dev: pointer to the pcie_dev data structure
>> @@ -961,7 +960,7 @@ static bool is_internal_error(struct aer_err_info *info)
>>   * Note: AER must be enabled and supported by the device which must be
>>   * checked in advance, e.g. with pcie_aer_is_native().
>>   */
>> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>  {
>>  	int aer = dev->aer_cap;
>>  	u32 mask;
>> @@ -974,7 +973,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>>  	mask &= ~PCI_ERR_COR_INTERNAL;
>>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>>  }
>> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
>>  
>> +#ifdef CONFIG_PCIEAER_CXL
>>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>>  {
>>  	/*
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 4b97f38f3fcf..093293f9f12b 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -55,5 +55,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>  int cper_severity_to_aer(int cper_severity);
>>  void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>>  		       int severity, struct aer_capability_regs *aer_regs);
>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>>  #endif //_AER_H_
>>  
>> -- 
>> 2.34.1
>>
>


