Return-Path: <linux-pci+bounces-28731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A7CAC958E
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 20:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AC0164EB3
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 18:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA21E7C27;
	Fri, 30 May 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KBFcDlmd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1282E2AF14
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748629128; cv=fail; b=kZCtDUDuuvnSNfpCHSziwFvUWemboZbQVLE+ZGt3+HkBk9eTX7CMFrQE4zv4zRnDjVTBvViHQHfU6CQKdFU/ymlpmTIZcLWN0dCO02i3/N+oy9/X85Wak7H/L/2U/NLvrfju9DlXNHvb574nxE1xxUjeqEkgR59Ygd3uYNikeR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748629128; c=relaxed/simple;
	bh=FGbqdyLCWnC1m8tsSE3dNJ9S1Jt3t+IH2PqNuGifVtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fBrKp9AUwuwNDDthVHPx4/3nZgwrUa96mbtvKHLH3mmAc2R9HwYOLU7YUpnCxH0is+Olon4LIJ6EGdZ92dZENFoOmqdh3QgSArEJzRYZl04/bUWybw85HFqnQ8czdtzp6/2N0Cx2VHp7+W9I7epo6N8LuCmk+KJDGcuHO+mcyZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KBFcDlmd; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQCKxq0m2Xdz5U7Em4BApQlTveMhuAm2oushQYXsScAoioWCBvnfeNGjwwoclVEM3wA7Dnf08EOV/ydv4/Wvv53TJ719nQ9Ia66v3l3GqZ/qLnklKfsdgMYN3+ZREaaO7hwWDKvwkka0oElE6SDqlqGmQLlsPL2Nh9vF6MNvPFLysWquWq7OllWSPAXlnSOqTwUVpv7XjatSDJ9hWMcPkXrnnEBKxtUk7d14IjkjN5q3iXIgwHlQmDs1pNUpQfwwaElx0PDP2ULU95r2PN9JV6pKF0goPCmQz7J05d/gPC17IDUbHJyKx25NFNrwsT/Hwcxj3F8DDZQ+SvjuQBpHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssGO8t8dtozw4w02Rz+f3/4ONS/YWgyAxwrrRAL+oWk=;
 b=ksa2LxGtt35YBcU07+HCrCTHQA9xje5ciqkNVUMK2ly671piMAnh6nSgeB5WiUmL7XzSsJEMMZ2sn4iGuwpwAZskC6b9TuRQrMhcDO+CqsGgiIXAjTY/c2U3x+GaeFpn7N6MKBU6R6KZ4GVsZq/GioaFcHfof5WPxwoBx55acTdj/fldWLOcgXFrtrZpUjVAF668Iet0f2qK4cIro5GjjxNuSWI/4aybs2m3oOERdv5pBtQrzciCEbmF77DBYtnRI1APopnWP79QXYfS2dnnCLklpTMCDVjgK1mlBh/yi8YwtNA3HqFPbYIfoXFw9QKsbOVfk9BM5LrHxAQvhda6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssGO8t8dtozw4w02Rz+f3/4ONS/YWgyAxwrrRAL+oWk=;
 b=KBFcDlmdbWSOX/8A4jRDTWwO7aNMOkje32X84c7/bKAUWyk7lIo2t8n6HOsZ3MSFKC518kkqlj1dG90i7A8VO9Tg11F85e7m+6fnW9tKdEreXDlNsgx1oqXlWijHTk6XbQrg47t5EJMrkIDBEeGWZW3ZFiCznq1tn81dg0DPtfOV6NBp2CFucVFfZ/O4jkWijf/aF+H50gT9pVHnKgbzv3FUkHwJd+XaII7Ab8HrluWY3kxZiu2yCaoTtROsG+jux3SgzOREU6VRa2eS3l3sBRFq7D3JeEtuBzVJcJ3REMpk/aNLmCnkWenNPpFXlwlnpyVu7hAOMUgrref9I+ghfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH8PR12MB7352.namprd12.prod.outlook.com (2603:10b6:510:214::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Fri, 30 May
 2025 18:18:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 18:18:43 +0000
Date: Fri, 30 May 2025 15:18:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250530181842.GU233377@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <20250529143237.GF192531@nvidia.com>
 <yq5a34cmjy6b.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5a34cmjy6b.fsf@kernel.org>
X-ClientProxiedBy: BL1PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH8PR12MB7352:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c86b24-79b2-440b-fbec-08dd9fa6693b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RldCeGdRdXVxUFprRE8xcDhQZFBnVHBIcDF1emhKK2pleXNJNHUvZld0L3JM?=
 =?utf-8?B?bHp2bHhsQmtJQTJNMDdZUFFObHR2Z1lnMHhOSXlMbzl0dWkxSVM1My9ueGsx?=
 =?utf-8?B?NHZpaHczZzUvZTVoWm5vZHNGNUt1cXR4UUlFRWY3VTJLQ3hmQ3FOdnh4ZW5C?=
 =?utf-8?B?Tyt1WHN4S01vVHYwSUxnZjZuYmtwTzY4WlF5SXRvQXBLNDNwY01ZSXp5ZDNB?=
 =?utf-8?B?bVJiSWFCSXltNk1SMTdBUjlCWGtQMm1LSHJHUFpnVGM3cWxURXlaeWhMeFZi?=
 =?utf-8?B?NXdrQkhLT2Zqd2FWYy9oaVZKbEJnVTNSWTJZcCtTU2dlcHFWVWFZalRHZFE1?=
 =?utf-8?B?eFN0RWxtUzczeWo0aTV3ZVF2K3p5eWxEaTZRWjlybUVLcGk2NlU4bzJCemNk?=
 =?utf-8?B?MUNualhreW01bGU2a2VXQlB4M2txWU1mQWt2YmdqZGhRYlVGLzFLZkNsdUNI?=
 =?utf-8?B?Q0Z0YUZOQWVmUFY4UWxSeW5zZjRVYzlmVXBkQTRlalk5OXBTUy8vTnpmbWJ2?=
 =?utf-8?B?ajk1WDBKT01Ob3NGMFptQXBDRGJiMk5tRjJkRmUyb0pOUlNWUkZVRkZoQVdp?=
 =?utf-8?B?dUU5RWxPV0NoNFF0MzhMUVcrdW5VaU15d0JxVnhxTTQrL2RRYWw0NFFjcnZL?=
 =?utf-8?B?c3VGdU5JUTg3QXBxZ29GUjVhZXNieTQweUQyYUQ2OE5qTmVYM0ZIM2FkM3h3?=
 =?utf-8?B?aUFENTZWK3lZQXYwYWRqMXI0V1NLTHhCNWZ1MXdxNmxrKzlGWCtmSVZIQVlN?=
 =?utf-8?B?ZWE3SXRBcWozYXJHeVMyeG84RkpLN2hUSFlhaEZ2Q0NlYU1XRjVMWVVwOE9V?=
 =?utf-8?B?NFE4QUtJZWIwUHJkaUp2am4wRmo5STZMdnFyRnlJL1J5REhqZDlFYVNqRkFx?=
 =?utf-8?B?Skp6MUVRSFVHeVpIWW1DUnRsVnVLdlNYcGdpK3JRcldVbjJMWU9ERG9PSENz?=
 =?utf-8?B?eENJdWVHNGNRbDhZRUVDenpGRko1ZXVDVGhSRkx3UncyeGFGVmFBWE1JZCtM?=
 =?utf-8?B?UUw1MFcyZ2JqSmdxWWxBQmFiMjNLaDliNEpzS0NQclpoZUdUTmdxc0p5OGN4?=
 =?utf-8?B?UDQxd3lxL1pRQWkwU3JleFVCTXAwNHpSaGZOZGFLSUdzbXQ1QVEwT3l3WW5S?=
 =?utf-8?B?Wk1LMGNFVzBiWU1LcWNFVzN4dFR5K3hSTktBMktSYXFnUm5UYU45Vmc2SDdq?=
 =?utf-8?B?MktRb1NhZ0xJRVpxZXp5eDB3QTFGTjlXTmpqVlNYQWpKKzREVnozTFdCYmhz?=
 =?utf-8?B?dFZ3Sm5sSVZHa0lvV1pTcHhSWUVzWFdHenhVTU54YlY4Q0c0VmtUbGNQaDRF?=
 =?utf-8?B?dk5EUmpYMXJJekI4d2JPaGQyTGFSSXdsVlJoVUFWNzlEN3BmZkFrOGRvaU1Y?=
 =?utf-8?B?WmhpNEo0Y0YxV1JYaElvOTFZcy9QSjBTdzBCc0Q2U0dNYVZEa3cwT0VEczdC?=
 =?utf-8?B?QTVSbk5YZ29Camd1V1pROUlmdy9pOU80VjRmQjBYMExHM2UxNWdYVUo2K2FB?=
 =?utf-8?B?VnJFZ1FtM29ZaVd4MkFWcmV4MlV5WjFxWk5EOHFDd3liMjZBWHg2QndVaWhE?=
 =?utf-8?B?blNITS9WUmtIUnVJMDFTTGRWOTJzS1NVVDk3WWU5a0UzazdqcjdhZXlaUzk4?=
 =?utf-8?B?WG9YWU9Pc3BWOEl2NlNNYjFxbi9ubU43MUw5S3BVVVBpc2ZDZGRyZFUxNDJn?=
 =?utf-8?B?TS9jOXVJZm4xd0pNT1Jyd3lYYXB5ellaTFFBNzdhQ1dBSVp0dnEwNmhWVTlH?=
 =?utf-8?B?YlBaclkzL1o1NUJhenVtOEhVQU9reEhwbGtJM3lHZUxURUVTTS9wL2dYVzVw?=
 =?utf-8?B?eUlVSkdpWkl0Z1JGTGNhUEFHTjJwdUFUUWRiYXlDN0xQOTFFVUlUNXdaK2tV?=
 =?utf-8?B?emJMODRKZ2lFWkNSSVhXbHFkSDJOSVJ4dTl0aGhhNDZ4a25rNWpGT2tJNkMz?=
 =?utf-8?Q?Mg7R9OM+6Ho=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MktEUThKMkI4eDcxcVh0QlVXWEQ5UnRwVTlFQmVOdzR1bG5jdDJXWDEwaEJ3?=
 =?utf-8?B?QVBmRzl1T0NuMHNMUzlyZ1dJWFFZUER0dGRYSUNvTlJmM3pENlJHL0x3aTBl?=
 =?utf-8?B?bUwzLzVvZE1TL1U3YnA1ZnhKSU1XVlZJWkdZRE04cHdteWxkSm1pWTRhclY5?=
 =?utf-8?B?ZGtqWXQwdFVETHlXeGFlS2I5Q3lsRlVyVUlYWnVVeSt2QVFsTGZoT0FpSU5R?=
 =?utf-8?B?NnJqUWpWVzFsNUdTTDFWdlRtRUVWcjZ5cjVSSnFGWUdoRyt0MW9RUDc5OTV0?=
 =?utf-8?B?d2FMQlNXSDQ4VU5lUm9KbExZRmhTVzFNUjdGT05tZUVmTlRrL2RQVVZSNU10?=
 =?utf-8?B?VWljeU1rb05tWnJYNEZFTERUeTk2U1FGb2lzc2lPSGxZZG03aTJWNUN0eHVX?=
 =?utf-8?B?a2kzb1R0cTlYSGExeHkxNlVlUDJ1bFZTbktJcUdSZHQ2K1RNVyt1ekJ6KzlW?=
 =?utf-8?B?b2RWWVQ3TUFnS1F6UEorTXhGT01sSWx4QzdWMUx6ekpOelFuaDVneW1wT0x0?=
 =?utf-8?B?MjRURVROaVNubUNQWDg1cmN0L0d6T0l0aDA3N0VmcXJUK3BTd0xuV1dBdTdr?=
 =?utf-8?B?QVBBN3pGTC9iSEowZDVpTE1wL0tIQllEc0NmTDk0blV5c29SbGxody9ncTA0?=
 =?utf-8?B?Vkx6Y2pQa0R6MjN6eGZCeUtOa2s5dVF6dGZaR2srTElBQmcrWTRtMm11c0lm?=
 =?utf-8?B?K0VFbjRUVmJDdHBBcmdpeE1MKzRNWUZGSWU5RWM4a21RV2ZYNlhpa2dBS0JQ?=
 =?utf-8?B?eG9NK2lkbW1vbkxPY05rNyszTjJvU1NFeGRucmUvRGZlSHVPQ0hOcGtHQnBh?=
 =?utf-8?B?cDJmeU0xZFc2OGp3VlJSbURmNHZybThJQjd0WVh3Y0RTTFRFUUkzK01Rc1hI?=
 =?utf-8?B?RlNpeWhOK1NaTmxtbHc1YlRnaHM4WEFDaWhYcm15Z1p5eDlsQkFGSWFCaHhl?=
 =?utf-8?B?cXptaXhzWTdJMUNKeDloeXNmRklEc1VzQ1gxODRCVkRXWC9NRms3VzdoYXdH?=
 =?utf-8?B?eFY5Mlp4UkNYTCs0b0dIY01IdnI1ajBzYjJ2V1F3em5NMFdJcGtOdnZBTVpE?=
 =?utf-8?B?SkxxOHlRbUxyckRLQmVmR2p0RENtQkw2ZDArVkx4dnJiSzVQVTM1bllnbnBY?=
 =?utf-8?B?MVRJSlFzdEg2MHRoNHV3ZGVSUnIydDZmb2RPcTN1YUs1N2VYMWFRK3JGUHRv?=
 =?utf-8?B?VDVkN05sNGhOTTRwQlB1bWNrTUtiOHM4UTFYVGd3RkxOWTR4UDJMVUFoaW53?=
 =?utf-8?B?dUwxa1VndzRhYlBLSEU0cVBFbUhMT0wwTXVBTEcvYmNES3dmM2xMTTdwdTFj?=
 =?utf-8?B?ODVsSVRBWEJxczdTS1BaZGY1Sy8xbGowRWwyVzhsNEk2Q2FIbUZWYTdVbDNn?=
 =?utf-8?B?bWcxZEZiem5nR1NwN3BuamE1dUZiSjk1VFpIUFRxRXUvZUR6b2NrUzE2am52?=
 =?utf-8?B?R2EweEYwVFBDb1JpbWFIc0xJN0JxUWZuUUpwTjlFZlRqTGQzb2t5QTRoYkxI?=
 =?utf-8?B?dnUvaTdsTmhaMVdJM1FNaFYvOXgwZ29JUVVvaDJuOWlBMTNvRE1NYUxtWE1Q?=
 =?utf-8?B?aXJLay9XR1RmaXcxUGF6d2Z6OEhmUzdyakQ1c1BFd2doV3I5OHpRNXQxSHdU?=
 =?utf-8?B?eDVXK2txd1MxVEpyZXFHdmtaZHlxUmc4dVZ4ZWw0bEJiSjJaRTZKOVRrK1Qw?=
 =?utf-8?B?bXBPbWxNcVVaK2t6Qm5IUHJ4NHNlZFZXN3BySDRIQWp6VllET0hQd0VPQWxX?=
 =?utf-8?B?UTVqSThZZUdzMk92d3hLQ1FUdVhLdWFMdEdYQVVWMnJVa2gwNHBpV05lblNH?=
 =?utf-8?B?L1FPY3FYZm5qRGpoeGwwNlo3YlczSFJ5d0R4dmxPZys1Mm5xeVBLeDZLY212?=
 =?utf-8?B?VUZoRTk5dlMydjFhWUxkem5ONnJxS25KeExKd1UvZjhLUzFCOTRscmVtNnBX?=
 =?utf-8?B?dWlITWpGMEJwZnBRVHZSdnRTWDZKb29kWHBtYXd2ZHJycEpleEY2Y25QRVp3?=
 =?utf-8?B?dzZQT1l2Y1ZNZVlqUnRZTS9xMUdYOC9uSm8xZi9hSll0ZWpSMUN2S3ZrTlVh?=
 =?utf-8?B?QStvQ3NQVHdGOEQ4QnF4OU9tU0hubWt5S3hlSlBVWnRVc2NMa0Uva2thOXR0?=
 =?utf-8?Q?Um8PvIWldj+rirBCQhOjHphP6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c86b24-79b2-440b-fbec-08dd9fa6693b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 18:18:43.7223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnFjUZkdEbxEebHrkW+44423GTeOKALBmO6g1BrpZkli0VL57IRwYa/PwHq3tqNH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7352

On Fri, May 30, 2025 at 02:03:00PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Thu, May 29, 2025 at 07:07:56PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >
> >> +static struct mutex *vdev_lock(struct iommufd_vdevice *vdev)
> >> +{
> >> +
> >> +	if (device_lock_interruptible(vdev->dev) != 0)
> >> +		return NULL;
> >> +	return &vdev->dev->mutex;
> >> +}
> >> +DEFINE_FREE(vdev_unlock, struct mutex *, if (_T) mutex_unlock(_T))
> >
> > I know I suggested this, but maybe it would be happier to use a mutex
> > in the viommu?
> >
> > What is the locking model you need for TSM calls here anyhow? Can you
> > concurrently call tsms for vommu creation with bind/unbind or so on?
> >
> 
> Thinking about this more, I guess we likely don’t need a lock here. I
> initially added it to handle vdevice->tsm_bind, but concurrent TSM calls
> are already serialized via tsm_ops_lock.
> 
> Additionally, if tsm_bind is invoked on an already bound TDI, the TSM
> layer handles it gracefully. This suggests that maintaining
> vdevice->tsm_bound is unnecessary.
> 
> Since we're not modifying any vdevice state here, it appears safe to
> remove the vdev_lock() call?

Okay, that's a reasonable answer


> >> +struct iommu_vdevice_id {
> >> +	__u32 size;
> >> +	__u32 vdevice_id;
> >> +} __packed;
> >
> > ???
> > Why is it called vdevice_id?
> > Why is it packed?
> >
> > The struct should be per-ioctl. Does anyone need a TSM specific argument
> > blob for bind?
> 
> For both tsm_bind and tsm_unbind, we need the vdevice id. How do we pass
> that? 

You should have a struct attached to the ioctl, and not packed. Maybe
this is a sign you don't need two ioctls, or maybe you should have two
structs.

What you may really want is a TSM_OPERATION iommufd operation where
bind/unbind are just sub-ops there. It could unify the viommu and
vdevice related TSM ops that will be needed into one ioctl.

I think all the ops will have the same basic format of an id and a
blob of TSM specific information?

Jason

