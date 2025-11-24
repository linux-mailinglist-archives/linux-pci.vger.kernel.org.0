Return-Path: <linux-pci+bounces-41945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8FEC80DBC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 14:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 17F1E3462AD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4F030B533;
	Mon, 24 Nov 2025 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pXjpLpJ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DCC13790B;
	Mon, 24 Nov 2025 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992422; cv=fail; b=gplOLAfiOiYqQ1sl7/gCfZE46j+7DcTtfxTa1V2XkJR3isE1CoAbWZwxSJMoi62dMvvLggbK/8EzPLyBnGrQuS4Vf+iBpgLRL3QRJSa6WlsDDnSjT0nLRsnAGA3ndICgSFyPc35jCZhDbjqETTrmgXVdbnYqPNPWy8mcIZYrgsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992422; c=relaxed/simple;
	bh=aUWdBClmjX6r1wLT/fUuVYIo37ByEocSMWQLbRYODBU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=rWcjVfmo1tc+wKk9bLUv2vXGnzGpcQh6E69G5scdhcWjBCxulbwG+2KUdsT5VjP+yVdTb9XicjXrMunTBOiwT5zATcvyUBZTiICdg2HmR3opff/MZFpme+5rHOdjLjH5Qeh2n6YOCsS5msgsS92I75ofelW/+65abnIKmQxYs3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pXjpLpJ5; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzFUOsCshNO/fhDmj0j6fzGHT+1xwRnAROAGnI6R7bCRjtPtFMn4kiQEQoyTZIB6IccdVyG36nsLT1CLcNbdT36OTG6CHEz8b5TnXtYL4xVQ+TT3g4/DEo9IOhWOGRqQ3vCcxFQyoX4brRa/iiciE9wYj8XJA0bTPggrvNqLgLLooAy1dqx+JOwGtLjBBdh+74H0603+87cpc5sanmLj0fvVDaHCBBC0ZYbhPDbk9YW13sAfQPn4aEfHxnUUpRb6ekXZfJ8JhnEifJPqbiYsoA+VJdOHlIL81IWi23Qvae23BNm8EYucGIB4eQpvZgDHu8H1JZUJ8EcLUxAXWIJ+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUWdBClmjX6r1wLT/fUuVYIo37ByEocSMWQLbRYODBU=;
 b=E9INQlHfmHt2bzFXYMCDu7rlTKz6CJwNbIUqkaU/vpW/BfpldNgDLyDimW/sDaTdRzrvZJPtFXOapdyiLOt6TUsQIQmokcP5Sj+hwHz6wIYk8tOfm6QADX0gBWcbvVy+dlwSCM0Lr/tS7zbfVnrcbnfGRta44H58ovr3sI2xz8mzvlzJNWBsqxCDMFaex5PlbDK4PcLxu3U5nTOZyPFxiQ/EnL17LaxIVbxnSK7MdXDojZk6aa7YMJjwtiKNz5qGjvdKH3hmEHlj1zspeI0zhRmMJji0wrS3R41wYOCTQzm0xs2aHe08WTCzECjp2p0F3l+XlxSu14H2V8Di+ceWwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUWdBClmjX6r1wLT/fUuVYIo37ByEocSMWQLbRYODBU=;
 b=pXjpLpJ5Q2cmLnExdESrNpLhWxV72ECJgUob2OZ5hU6fqeScnNzrpU+V0ITS9ZukGf6mpqaxHzA2UObDQLOgn8CmBdbwwqoqndui8Ky0M3vgNtaArUtKH/4LqRh+cxmPIBLuqtOYpPtIm0Aa0q8KFZR2SndW6/QJOQtOGesybmnrY7jQfXN/2AFE6CIrcIG1cnjsLnJYBE76NxM0Lli++69O0F/qja/GAagoJb3mlV3IjUf5fn4u12For2bUkA0Ycp6+nlWXS23K6HYIsrMRkAb7Okx7mQEP3OXeqbfrdyElNezCzfZyraIYfcqgCmJt1M2Hs8MjQlm/WDtu+211ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ0PR12MB8140.namprd12.prod.outlook.com (2603:10b6:a03:4e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 13:53:37 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 13:53:37 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Nov 2025 22:53:34 +0900
Message-Id: <DEGZ4G00CVTI.VAQH4O4HEXGF@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io
 trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119112117.116979-1-zhiw@nvidia.com>
 <20251119112117.116979-4-zhiw@nvidia.com> <aSB1Hcqr6W7EEjjK@google.com>
 <20251124120846.267078e5.zhiw@nvidia.com> <aSQxeSX0q4Z_jaAu@google.com>
 <20251124153218.7694b78a.zhiw@nvidia.com>
In-Reply-To: <20251124153218.7694b78a.zhiw@nvidia.com>
X-ClientProxiedBy: TYCP286CA0195.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ0PR12MB8140:EE_
X-MS-Office365-Filtering-Correlation-Id: 640d050b-fdc7-4a2a-a25b-08de2b60de06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWg3YkIvektwMS9TSFlMNXRYdXBHdFVxMDdWRGhGdVRXQm41TWMrSzZJTVpv?=
 =?utf-8?B?WVpGei95LzhKL1hCZDA1cDljZjhISTZwNzQ5M2RuR2tmNXQzQnBYOVBMaGpP?=
 =?utf-8?B?eURoZHR5ODNob1N5VFprbG1GUXdXUEFMNUtsMEs1VU84SlhxSWk3dGJoWk5z?=
 =?utf-8?B?N1FFM3BBT1hQSldnc0FEZXlvMCtBa29jQTNDV2dOVjZvWkE3VlFSRVFRY09Z?=
 =?utf-8?B?cWs3akl5TjgxS1JxNGovNnNkb3hFdFZOaC9RSGh4QkVJUmFoNUJkV3ZVYXlT?=
 =?utf-8?B?aWVZQStRUytoMnZ5SGZLOWpTVDRZbmlqOVZoMWgxUHFGSDFzQzRrRGVaRTZt?=
 =?utf-8?B?WHg1ZzRIbk5zYWRLZld0eFNSZDM3aGliN0U1MGlVVS9YRGJ4Z1lIUUFxVlJY?=
 =?utf-8?B?cUo1MnJhVllQdkJ0OGJaSUNjQjhjUHFRNHVUMzlUNHp0cjl1dEFMTDhqcmhO?=
 =?utf-8?B?RE9KTzNTd1NkU0RtZGJkY1dOQmpXbVNaTjg4VXBqZW5nVFpCQ1VzWGJYZU4w?=
 =?utf-8?B?UHFOSm40STk0SGxMMjdBdTdaSnBrSk8rT3l6RnFkR1I2aVZjODNNdU0rN2M0?=
 =?utf-8?B?TDVvaktlUE1aZy9JQVpqOU0vYk9qaW1tdzQybzRCd2djZWQwcVFZQTk2akwy?=
 =?utf-8?B?dVgwL1gzYVVMR2N6V0Q4SWI4N0FocUtiRVVXcGhrUEVpL3ptVmI5MDJvUGU0?=
 =?utf-8?B?RGVROGNnbXQ0NVc1eHY4TEJtT3ZLd3JSUGVQOW9aTGFqK2ptekJEU2t4MDVq?=
 =?utf-8?B?QS8wb2Q4cjMyWWFIOXhyOUFvSHV2VnovdUIxbndTNHJLQ3IrdS9uZmlYQVV4?=
 =?utf-8?B?NFpkY3RrM1I5OGtPZHl4K1UzYVNqVGRCd3JzdWNsQno5QXRxcTZ1S0NWSWdZ?=
 =?utf-8?B?QlYvczFMSGg3d0NYUWhsY3U1QlBFMk5mU0QreUhnREZtT2dNUmpDeGhzdERq?=
 =?utf-8?B?dmZId2x4QkU0Y1RCR3BTMmUzQmxIeVI1TjlHM01WSGJuTm9nS0NDVHNqMTdk?=
 =?utf-8?B?cFh4eDdPK0hmUzI4ekpyUGhtc0VUQm53aytLbDg1Zk9JcUxwamNUN0dySTBi?=
 =?utf-8?B?UGQ2N2FnbDhhbllmUzZTbHlBMTB5U1ZBazJVallkbmorRk1XeDc1Wi9hSm5x?=
 =?utf-8?B?ckJFaDh1YnZjTC9MZHptYnNQMDdPYTlJckJZM3VQTGtvUFBmRk81aC84a2xu?=
 =?utf-8?B?RDEyWlY2N2NhMEhxOXl2V0VWMDVQeTQwRDBIRlN5MU80N2Vwc2FGclhEZXNK?=
 =?utf-8?B?V1I5azQzZTM3TXNXdlpmMGRWWjlyUjdlMVpoWWZyUkFMTTdsaTF4WjgxeG83?=
 =?utf-8?B?UUhTOS9oRnZaTWNVWHlqYmFkeHdDV0pkZWc2Wko1T2xadHJJRnZiUWIvMkVR?=
 =?utf-8?B?WFNHSEJPUlQ5QW5iMnE4YmovQnlwcGdkZ0xzVkQ3OS9EWDQwSURxRFVwb0JX?=
 =?utf-8?B?M0gxMVBIZ1FkRHJQL2RrNExvMTFrOEt0SXJKNjJTWTdnTzBFeVVoYUtUNnUx?=
 =?utf-8?B?UTRJaTQ1ZXg4eldmRkNZdWY4U2Fxd2tDWmF1QjgvdnE3QnFCend6Z1ZwT0ti?=
 =?utf-8?B?eGZwMG53T1lNanQ3UFlqdlJtYnVxcXdUbXQzaVBMY3Y4OXNvZDZzdWNmS1lr?=
 =?utf-8?B?aDF6WWZyL2p4RzRTUXZSbTVONlVxeThTVFF1WURxQ0ZSajNRNDNjSmwyTjYv?=
 =?utf-8?B?dC9PVFd4Q05OaFN1ZFVibzdmRDZId3JXc1l2bkl5czBXOEJiSlMrL2Yxb1Jn?=
 =?utf-8?B?WVJwc2NQWjVyU3ZHaFJLT3BaR2o0dXF2Ti9vcUNmN1RRUENWdmRLREZJN1Ro?=
 =?utf-8?B?UXVuOVhFcTVtSGZCNlFseThGTk41U3V1YkdBNHFwY0R4dUhwQTloakgvL0o1?=
 =?utf-8?B?aHgwb1BjQi8xUmJUNXV1WEp2UjRObmlSQTU1R0JMUVdGaXZZTlA4UHRqTks5?=
 =?utf-8?Q?lV6d6T4RnFN+euq8dwOu+3HDlDHuMYNW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFNJeXpzUWQxQlRrMFlwd1NtM1M1STZCRGdKQlBsdUpFZVg2cFVpNWxXcy9a?=
 =?utf-8?B?Qm40aFRWbVBER2FINUZ4aG9iejhEVW40R0E5NHd1Qmx0eTdsbTRXc0F4bmFM?=
 =?utf-8?B?M2NsdXNWSFJFeVhoRkJWVmY0QUFVMHByVVRkMVBPek9Wd3kzNGl5a2U0ZlRw?=
 =?utf-8?B?WU5FcEVmZVlGaFdRK1Qwb3JVR0pVcGJNbVJrTzVXL2F3Wk5odWJyL2ppU2wz?=
 =?utf-8?B?ZnBSWnE2cENqNlA3dENlZjZvZ0NOY0N1WHFoZFZzSmkycE45MzQwcnAwNjRG?=
 =?utf-8?B?dzh4RFBFQUxRa3dFNHNMWWt4VGRnbSsreXFLOTBFSjVORWxVakdESndyWTdX?=
 =?utf-8?B?R1JnVzZKaGtxMGhxT0tOWWV4akxMZS9vZk44bkEwV1ZOYit5UkpBbzZUWmFS?=
 =?utf-8?B?RURZM2t4UWY3UVI1MU9ERUR6YjQ2WkZSN0dwSjY0RlR5Q3NjWjVrVWs4Unk4?=
 =?utf-8?B?cGZkSEpOaE5rTFVPZVlVb1JHcTc5NWVReTNJRjFhOTg2MHVVdzd2U1k5Q2Fj?=
 =?utf-8?B?SnFTM20wU2pXLzMvQ3ZPYWpkL1hLUXl5REV2OU4xclhGZSthUVI0WEVDRG12?=
 =?utf-8?B?MXpjMGNDNFJmcjArSXcvSkZJcG1pYWxNV0pFMDREaFRZVEwyNGFBZ3NCWTND?=
 =?utf-8?B?RVFxaFlUNTRBYmVQamJ5UHVrbW5lWXpRVWRwSFFvK2JUQzB1eHF2NmdFM3gw?=
 =?utf-8?B?dFBPRXpkSHRvUGhRUmh3ZXRPMzlKemhzbmM5aHBEbjNxSHNiNHlSbDJkdjZh?=
 =?utf-8?B?Z2ZIQXhKV2EvSWMzeWNVKzlGVWplYVVhek9FN2VJeWp1WTFEaklmdlNBQnpT?=
 =?utf-8?B?bHZOMDYyN3pQWGZhRWVSR1hHdlRWSUtPcVVVT2FVWEJQQVV6aGZPVHFQY3ow?=
 =?utf-8?B?WlFiRVk2bUxlKzduNnhjUXJYL2d3OHpTNlNIRU9QWlhEdndBbHlDQ3FIWXZs?=
 =?utf-8?B?Y2pGUXFBT3V6SGVvZTlSQ05OaE1Ea1QvZ2FtaUhwb2sxK1F5OEpkUVRuWms4?=
 =?utf-8?B?cDV0bVUra1lta2dBVXFReE1PRS9ybVJFbllEbDc0eVExQ0grTGlKalFWb0pq?=
 =?utf-8?B?YzlZWUtPRXdKdkErUUNOamNmcGhpMzR6TVhFVEpzK2NscXN2Rkp4TWsvTFgx?=
 =?utf-8?B?czErMDlIM0dVS0RLQmQvcDQ4aUZQNXRhbGk1cGhwTERqaVJVSm9mQXlsaUxs?=
 =?utf-8?B?cmtSZnRDbDJJaktVS0pLOGJFSmZET2JUMUFOMzVPY3FjaEN2czZ6TGdubC9U?=
 =?utf-8?B?WGhhME4xODRjWWxLVEhqQ1JWN1pkNCsybWhkTDYvajlYNm5IaDBFMlNLK1RL?=
 =?utf-8?B?ZEhDeGhMdjF2TXMzbEtsWjlVMXgvNUV3bVl4K2thV0wwNmF4N01RWkxTVi9o?=
 =?utf-8?B?Sm91SWdoRnM0eDRVbGhiL1M1ZTVOc2VwTFdwMGVxQ25rVEJUMHcyZVhVTkF6?=
 =?utf-8?B?S1ptZzNKdm5GdS9ZbmVoTVFvS01oNExEWWFmQnNyaVRVZkZIRXR3T04rbVJw?=
 =?utf-8?B?UCsrMzhtVFlTWTZvTXR5NWZNWU12Q1BFb3NZYmZLeEhON0llZTJieW1ZZk5q?=
 =?utf-8?B?a1Z6NU51Yjk2Y3VmSVJNV1N6OTE1dUVobGh3YWd3d1QrSUQvbkl0bjlOVjZY?=
 =?utf-8?B?b21FcTV1akJKSkV4dXFzWmlUTVoyTTZFQTR0VjZncjlBb25ycUxacU5CUDAv?=
 =?utf-8?B?UG1vMllkUWY0WFAvUXMxMFl4WXQzaE5NZDRWaHl2clc1dWFETXA0YVlFTitU?=
 =?utf-8?B?UjBESlJmbUxIa08vODFEbkhyOWJIK2hscHZGU0I4ai96VWs5RDlwNCtGTGQ1?=
 =?utf-8?B?MlF5dkVqNjA3T3hRV2FOVldrTXRWd20yL3ZUOExCY0YwTHBHbmdQbnJKVi9W?=
 =?utf-8?B?NVlNQitFb1FSNjRsejlmamtXenRDUm45UVJubzM3MmpNWVgxWnNnTGdTTUNK?=
 =?utf-8?B?YzRSS1JJT1dqbUpCaWxRMGdQL2g4Y0JRS1hQMWhFQ1hPYWJGeU5zdm9FS2Q0?=
 =?utf-8?B?Qml4cWVUMm84aVgvdGdET1BUTGhRYWpIR3AvVll5Sk03OWQ4L3EzVERUaC94?=
 =?utf-8?B?cUU5dGZUNW9hZ3ZMTjBjTGJ4aXdHNkNpRWlVS0syOGdQcFJoVFZvYjlydjhI?=
 =?utf-8?B?NVVCQVN1S3RQSzBIV2d4Wk83dnBCYlJwQmNZSEgwa2RGVHR4UDFrd2c2b3BN?=
 =?utf-8?Q?xTgzpnU87f0HGfAvc+wKJUqeLyY2gIkHTvjAYBtWowvK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640d050b-fdc7-4a2a-a25b-08de2b60de06
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 13:53:37.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geCopI+728EPNVVf6mKRkcfXrfadDTCZWHLhksa2kfWcnpHbkh9oQ1px7sebeJYg6TmYR/zjTSeKR+qSLFwkPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8140

On Mon Nov 24, 2025 at 10:32 PM JST, Zhi Wang wrote:
<snip>
>> But there is another problem: Bounded only supports the case where the
>> bound is a power of two, so I don't think it's usable here. You can
>> have Io regions whose size is not a power of two.
>
> Any suggestion on this? :) Should I implement something like
> BoundedOffset? Also would like to hear some inputs from Danilo as well.

Bounded integers were written with bitfields in mind and that is
reflected in the current implementation, but provided one can devise a
way to check for upper and lower bounds that is simple and works for
both signed and unsigned ints, there should be little standing in the
way of making it more granular and accepting any valid range as the
bounds constraint.

If this proves useful here and we can keep things simple for the
bitfield use-case, then making them more flexible is definitely an
option! :)

