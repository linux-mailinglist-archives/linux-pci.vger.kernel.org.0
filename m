Return-Path: <linux-pci+bounces-41551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B15E4C6C0A0
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 00:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7145D4EEBEA
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 23:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0422E22A3;
	Tue, 18 Nov 2025 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TXcd16Jj"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D5303A3B;
	Tue, 18 Nov 2025 23:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763509449; cv=fail; b=K1Uc5IObe/aiqWLhyfTi+HnG0EOlh2BWQfU4FCSgll4AglHkmemjCdmUlkgMwEMM6Hko3433cq8kuMRDJOBEcfMA2DMUlSfeKo8pqB5Kwj3486qgg87x7PvI18ZlbCwfNv1sYCaOmETpqAbtZYAjEqD86r1lLrVEFCdmSnSbuvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763509449; c=relaxed/simple;
	bh=A8Ux1TaKhmQHLgnuU0CPhfMb9wcQLT3C3oUaD7ucMSM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=avxkZCei9Yc8g1ln46FmzLs4QWefIy72CBFyWdspYUNsMrp/2cIpRgYTrIPATz3JtHbaAIunPOVdCSEw7B1LJlMH1rRmrzEZlPfnVWRYzjT3CUCB5UQ5/NLQJ9Z2zUDkxSSIkTmDJRgb0VRu9fTmEzM3ebUn5xIXDUzsaEdWVvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TXcd16Jj; arc=fail smtp.client-ip=52.101.56.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5ZljpddVGseLVAMaxbS74hlzu/PFJ7t2DkwNHMuyGTK7DC/EF+bZNilCgE0SXJG4gRqTQnw/CfiiE9cdUZNCRSZyjFv6Lx2cUPK6qBrj+bdkPoQlSiljxgb6aU5y9ehsYArxo/XvXwMOg+vnXaFzlnnKMr1fjDt+UK8nk3ONx3cB8xOU0LmcnvBYygQRTq065EGMj3xxXKCDr8YMVWCLk2nS44vJNMMvAoFyZkAWE0j6EjUzOLP4HbZx6Unnhx/ZqiEzBoqL8+MxCzBKB82syD4RU9aEErPOV3/BF+V/sZY0FSJL/vUOXCE3ypYRPFyu2aP1SAd78AZygzOIvfD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2+AxySp4id9eSSqPXB7l0eOIrGdDSU5/+6EE2tkfGo=;
 b=QDf4YqKkDcVPZYBoAFru/LabKT0si0OfMS9bII3H6VdqgytGlZ/csUp6YZ+PzYWQz6/ZVoJHyfF+WwpdfkEQYpJP88zaeMMYVgk79hBn21Ftik4CGhnxZDW24k2SmWblTKuQvrvS52vyiOJGST5tB28yrSLSNwnNIaNVPVWmNL0meL9j+91tjqnt/UAGFVSINyZ/COSb3VL74OwHZhVB2DZ9DyL79ab+wbC1SwjjTxT3C2HsXw4AeLTEmOWXCcWMsxtGgSpWVXM6CZTiWAfalXco4lakV4h7AhiR4WZRROv5OgCBYQiUg+sjl5RHWzCIdws3zjPV/lC7317J4K5t+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2+AxySp4id9eSSqPXB7l0eOIrGdDSU5/+6EE2tkfGo=;
 b=TXcd16Jji6ThdYzMmb1kuRbcwPeZaLGbz7bvw9QiH6CACUo0dTl/kC10+yqi3gPJlTcGxgAfMAUvSMsuqc4VvTIJuvSlEsY13glpgNvxCWemcddM4m7u8YIRfN9Xp5FfAUkntTpd/piHh8cyotgP2O/9rvdkN25vJD/k0Xly9zrWLIqN/fza1zeNARmC5vYZGZIX2pG9Fmgugzye71TGTX7PZxDHnEu6g3cJaY3sv0mVs3AtNUK3/yQaHDLj20Wzjtm253hoVHXLuBo9LBPFHQJTwZYPomWoRnkwWjoFoIKdn16CLegpcBoFd1daQAAF4d0E3VfxE3ONsk8pZF1CUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.10; Tue, 18 Nov 2025 23:44:01 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 23:44:01 +0000
Message-ID: <dbb5ff04-83be-4caf-b7c2-4360b39959e5@nvidia.com>
Date: Tue, 18 Nov 2025 15:43:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 RESEND 4/7] rust: io: factor common I/O helpers into Io
 trait
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Zhi Wang <zhiw@nvidia.com>,
 rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, markus.probst@posteo.de,
 helgaas@kernel.org, cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 acourbot@nvidia.com, joelagnelf@nvidia.com, zhiwang@kernel.org
References: <20251110204119.18351-1-zhiw@nvidia.com>
 <20251110204119.18351-5-zhiw@nvidia.com> <aRcnd_nSflxnALQ9@google.com>
 <7b30a8a5-ec0b-4cc6-9e9a-2ff2b42ca3cf@nvidia.com>
 <DEC4TSQBTESW.28F17X9GHCIU7@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DEC4TSQBTESW.28F17X9GHCIU7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 8089e16b-7bf4-4f4d-eb51-08de26fc599d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1dZeFZFdUVWbUI5Nk1DTVl0YzBXYjZETlRBUE8vZk5ZM1lZYmF5QlhjVmlB?=
 =?utf-8?B?bnBLTjJod1I0QThoMTNGU3VycWFyK3FmMSszNGZaK1V0ZFo2Rm9zdDU1SjZ4?=
 =?utf-8?B?TEJYWVZlZ0dkOU8zZ2RNZlI4b3AyRmhvRFk0QWFDeTRhb25HV0lneU5qcW9B?=
 =?utf-8?B?MnZvYXkzYzZKWG0wYjdtMlJwYjNuWlNlcmxRaW85N3FXMHVWSjhCTkV2Nzc0?=
 =?utf-8?B?aWM3VjNYNmhhZnQwQlFZTC9QQXNoT1QvVVQ5czVhQWcva1Z0dnNla1hXS01L?=
 =?utf-8?B?cGpMaXgxajhWNUZ5TUFxK01xMVJFZ3ZTSVR4ZkVOZTFrelpRTUpRVW9KSEh5?=
 =?utf-8?B?Nk9UR205U25tUWVUKzZUZHphK1lCczdPVnJuUnlZQWRaVlVTNVdQR2JpMTYx?=
 =?utf-8?B?Vm5SWWJ2b2ZSa281ZGM0WEp3bHZ6TWdQMks0MzA5b1YxOFNhVWI3TVdFazFZ?=
 =?utf-8?B?bjZGdXEwMFdZM1ZrVTlWSUVqSUdzUzRGa2dpSkl2Sis3OFhxRXdHdGkvZDFl?=
 =?utf-8?B?a29VWUZjZzVqRy81Y2hpMGw3dWJMaVltZGNGbG5lOGZmVkFGWTFobnRta3ph?=
 =?utf-8?B?clJxK0ZFMG9BSWlsbHBkQW1ZMldDZWduMC9oQVVXVzNUQWl2THJHbm9yL1BB?=
 =?utf-8?B?dlVSMWhsRjBVZzBVc1lvSTlBcWRwbXRMZCtxS3dhTExHT3FxTGRYdU5VaTg0?=
 =?utf-8?B?dVFwZ1BDTzRGVzhHbnZxaVc5YjdWSlRQbCt2TUFOMGhCR0dPOFJERXl1ZzF1?=
 =?utf-8?B?YjMvd3c5SGQvNTNmd0ZwM0R1WUZVNkorc2tRdUNVMHNWejkvN2MwcE1OTEk4?=
 =?utf-8?B?bWd2b1d0bDhTeG5WWUc1SWE5ZDlzWWtQNDAyQXY4b0trWVFsQ3NMRTF1MkVv?=
 =?utf-8?B?M3lzdWtRMlhGcmU2K3NVWDFTVGw4d3lBdUQ1aC9BcXF6Um1ReERTN0o1ZG5l?=
 =?utf-8?B?MWUrWGkzR2xwTTNrL3hYczNVQTRKV1dzbHoxbG5rMU42cDlMenpCS0lTR1hk?=
 =?utf-8?B?em1abXk5WHFqTllkcjBtdUVDc3VFWUMvMElGR2M5OVlkcEpHT2NDaC9mT2Yz?=
 =?utf-8?B?L1hSOWtOOVVOQytjeDdoYUV0VlpXRlB2MzRoRXlwbTNWSWRuR2U1eFJ3bk9u?=
 =?utf-8?B?N1RXRU5vbzlXN09jWUR2bkhkOThxcWVQckJPZWNVQWJxZmpMdUpMa1hVbXd3?=
 =?utf-8?B?NE9mdUl2SmVoaXpmbEV6T0xxUjdsS0xVYk5LZHllRnlDYVowQ1Zoa2JzU0hC?=
 =?utf-8?B?Z3VGVHVsNTM0Z3hEczFSbFliR0l3TndDdWVwWXUxVUR5dEhPTlBpbTRueUx0?=
 =?utf-8?B?NTN5NGYvaitxOHlLb3puNkNLamRHUnFoVWtDRnV3TG0vR250UWhZekRuU0Jw?=
 =?utf-8?B?RDh2ZmZuMVRSemxwYUxIYzBJbTJrSzB5bjFKaXNpSERhK29RWVpXMlJZZjZF?=
 =?utf-8?B?dE8xQTlkbSsrM2h3RndIMTRWSmhmMzZNUkxtbGFseHcxc2g4UnJmbXU2MU5F?=
 =?utf-8?B?VVBRcUpyZ0w2WkwvNG0xRVo5RWw4RDB5cnlxVlB2WWc3MUo2ZW1HNzBwL3hE?=
 =?utf-8?B?VkU3RmpXOEx2TG40SStlSGh2YzU5OWcwK3U4cHNQVFJiRndoN1oxWTg3eDhY?=
 =?utf-8?B?N1V4aTh2QVhFSURvV2ZidGJMTTZwZHYzWTVjdk9icmErWDlwaC9LVFF4b3FH?=
 =?utf-8?B?MllKWE5vajU1WWN6N05HanoycVd5SzRZN2NZZHJ1ZDNSMk9HeEQ5S1RjRWtP?=
 =?utf-8?B?OVdmdHNRY0V4Vm55Qzlrb0h5Y2M1V2xDYVNnMklVdzh2bmZ0eWV1UGltcHZl?=
 =?utf-8?B?R3ZhRWg0RFRjcnZZN0l4bnlBakJIdHRQZlQxTkZraElhd1lBREptQ3MrQzhl?=
 =?utf-8?B?Q1ltN0VsaGRlbVlQdHBmZVErcEgyajdBOUkvNmFGVm43VWdKQUYwZzVhd1Vw?=
 =?utf-8?Q?xp9bLaMEEJbD2eXLhWEBmKy9gHaWhsq9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MytxM29teTRwVGk1WHg3cGZjQzJWcnB2U3dsMkV1VmwrQUJCcDlYMGpwTGpt?=
 =?utf-8?B?NTdiRXZUN3pBMkMyRUVOVCs4ak9uZElpTmQyQUxUaXk4R1ltYnBsK0ZDREx1?=
 =?utf-8?B?WUgxMFJsa2lISVJWVVl5RE14dkhuR1VGWis0QVZ4MU1sSU51VTZPUWU2WXBp?=
 =?utf-8?B?elI5VW5LVCt5L2N0U1g5c216Y0syZ2wwTGpudmE4bTZwUTl4NzhpYks2cFh5?=
 =?utf-8?B?Skh5YmZ1QkUxMHFLWW1vVDB3c0pMeHdXYWtvbDFlQjM4TEs0Zk4zMFZmZjVE?=
 =?utf-8?B?eDRhRGhQQW82VVRKbldOdkN4aUJkWGF5Qy84eFNnTlNlRWQ3MGhJanI4a1hn?=
 =?utf-8?B?V09GTTRLZ0ZlZHhEZGo1a0hsQXJuQnpDZFlvZFdscVUxd1hVTkpQb3d5azdC?=
 =?utf-8?B?SWdhYWxKTDM2eHBCUjhMcGdEOW8ybmVPVnVUQlJ3WkwwMkdzY3NRNDBlclNK?=
 =?utf-8?B?Z0ozZkxqeUw0azV2VkxrMDIrS1hLZzloMmhNTGtMMXpaWmtCOVA0OFpjeHBO?=
 =?utf-8?B?c0U2cDVGMnlnbFUzYWJvL01RUisxdW5uS3ZhUWt1dVczNFRrYjNPOFI2aXpX?=
 =?utf-8?B?cFg3eFlQVkRDbzVEWm05NlV5MnI5cTYwdW5GanZrVUVTZDNNaEJMY0hxU0N2?=
 =?utf-8?B?TzhHcXNyOTVBa1lmcGcyc0h1QWRKWVRzbEVyajJpcENIaVRxdFRBZGRtcGpB?=
 =?utf-8?B?ZkJId1NYcFNLSFAxRVVzbVNEZlhRSm5iT24xeXN2OHVoZ1ozckwzZFM2ekxR?=
 =?utf-8?B?WDMydks1QjROTTVMNkNjUzhzVUtGMldjc2prL0pIREswYVg5MWMybFFiQnNo?=
 =?utf-8?B?RzdQaGFzclVlVkl4TkxDSTdaVGpHdHVESE5lLzdZcFBRVitIQm02ckVnUWZR?=
 =?utf-8?B?Tjl5MlJqTStMNTFtLytWckNJSmJCUWFva0tWaFhLTkdneWprTTFKUlhWVEZT?=
 =?utf-8?B?U01ZZkpoRXhhUDFuNTVlVW1iZ2Vaa2wrSXdaZ0RqNDRjc3YwNXUvUGsrMHIy?=
 =?utf-8?B?M3pDVWJtMEhTYlVpS3FiVHBGSzhhaStscVJmNC8rdyt0UCsvSnhoYjl5MzV2?=
 =?utf-8?B?NnFobkNFTGp5UHpoN3k4UFcrMjhKSlIvRHAzWGZxVnUvLzVqNnVCamFodFo5?=
 =?utf-8?B?ZGZlTDNFZlNhcWNGQzNqd3pSUU95MHA3VGw5cXpKVU9rLzFneWxUU1Rwa09Z?=
 =?utf-8?B?K0JiWVluR2tJaUN0cm1MWk9uZHR3M3czN0trajFMdlZUOHhFaXdwcjVNK3Rv?=
 =?utf-8?B?K2d2YlNKUWU0UEZIMzIvMkRIQ2hGdHVoanpBR3pVZmtrSkpSbm1BVXZSTFBB?=
 =?utf-8?B?dDhmbUozODRSUkt1d1lGaEl6NGZ2UDBUKzVnTWU4YXNIWVhNRlpJa1NaWE0y?=
 =?utf-8?B?alhRemFFem5VTlYvZEg2b2JjZzJkN21paWV2TUx0ZDNzOTBPZTlOSWlYOWxz?=
 =?utf-8?B?ZVdWZjJXUFkvN2d5SWd6aENvZmtSMmR2M0N2a3NsNnh0TVhyY01BdTdZSVpt?=
 =?utf-8?B?cGZtRDh5ajhXTGdUTkRrZm4rN004QW96WkwvQW1NY2w1TEZ2a3M5NytoR0Mr?=
 =?utf-8?B?UXpKY2h3d1FRS2k5d3pwOENPZEJaMTBwSUcxaHdsY2ZoLzQrMU5vK24weUxT?=
 =?utf-8?B?UTJZTmRtMnJ4QytMYWxHQ3JRNkg5TEs0SUk2dml4RjI2c3FWcTFKcEN0NjV5?=
 =?utf-8?B?ZzVtV0srOHlqZkpoc0hoOU85NTIxTXROMXlVMk43M3piY1c1NEdpa09aenEv?=
 =?utf-8?B?cU5oWWpvaTYzd25vTVJ5cEhSd3Zla1VRZ2hIZHhGRXVQN0VscVk0OU0rNEYz?=
 =?utf-8?B?azhXNU11ZGlLNC8zbDlJN2NBK2FUMHdCVDdzYkM0RGtDakI1MW1BOUxYRldr?=
 =?utf-8?B?aWNJRFM1RHZ0TWlLajA5SzlSWjhxUXU3V0l5bEJueW43b05TWXRsem9oT3R0?=
 =?utf-8?B?aTZFSzJkRkRIMS83YW1DWFo2alkvNVo5RFFTK1NwTnhKVjNLV1pyc3pJTitO?=
 =?utf-8?B?cGoxc3BOaVhTbEVJYm1OdUdJcU1JV3NaZEdXZG9mQ0FtQzN5VE15enZXSkhP?=
 =?utf-8?B?NncwM2N0eE5nMkIzakRQTW80djI3bVBLOTBueHNMWW9CV3p4WnJacEFHa2Fh?=
 =?utf-8?Q?70WYOZJszbWNgvidlbXSM2fMM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8089e16b-7bf4-4f4d-eb51-08de26fc599d
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 23:44:01.2506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCaDzJL8KD2Jf1zMiNCI3lxBldK8Z7CjeMWnaKPe6FbW0gcTzSKo3HtuyABIOouRUttfpqPRghQZnYLjkxddpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740

On 11/18/25 1:18 PM, Danilo Krummrich wrote:
> On Tue Nov 18, 2025 at 11:44 AM NZDT, John Hubbard wrote:
...
>> Other IO subsystems can also get IO errors, too.
>>
>> I wonder if we should just provide IoFallible? (It could check for the
>> 0xFFFF_FFFF case, for example, which is helpful to simplify the caller.)
> 
> For some registers this could be an expected value, plus a device can fall off
> the bus during a read was well, leaving you with broken data.
> 
> I don't think trying to make all I/O operations fallible is the way to go, it's
> just unreliable to detect in the generic layer. Instead, drivers should perform
> a plausibility check on the read values (which they have to do anyways).

OK, I feel more comfortable with the approach now, thanks.

In return, I'll resist making jokes about calling it IoMostlyFallible.
You're welcome. haha :)


thanks,
-- 
John Hubbard


