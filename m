Return-Path: <linux-pci+bounces-38803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC357BF33A9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 21:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808EC3ABC33
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 19:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEABC2D191C;
	Mon, 20 Oct 2025 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XpHuM1gs"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5373DEAF9;
	Mon, 20 Oct 2025 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988898; cv=fail; b=ZYE1pit2bMpvVyLHu2AgjxQKKY6WPJQ9OXnRysIvK2Q7Kx9yEPZgBQ5lmWJPFJ215YRayEUUlL3jNmVx3wWTflnLzmN7TMyJPI6VHDW5nqUFCohU/7/pt3filQaZPeWD5g2cMYiDc4tsDIerh8Pn7LrV2jKsH39keEVL+XtqBJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988898; c=relaxed/simple;
	bh=eCApuLu4oQbTPYuVahw5SMc6h/O8buspgUe06LXV0BU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bKZoAaEXr6OiHi/1v9VYpJIsCsHMAZqfs22DIoWfVBcrS9niC2fVoNwHkClraPm+STNa/1biTIMGNMrUt1E2CToSKgehnKUBENENWXFvEpQzAJzDf7Z4HVNbt4NSd7MfigYgSsjbp11nApFF/E1Q+Sz84tQ4nu7Q5nQrADyxKx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XpHuM1gs; arc=fail smtp.client-ip=40.93.194.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUR7D3hBpnxB8emlP4U6DjYw4rkmps9f/RFM2+RcjsK+KBEPHjLwkLvsPzQw6MUZ/3Vqny6p8s3Yv7zBiV8GzU230nrJfaRav0eNi7XhWfIob1eN+IE5+FQO/UII9iml3I2iNyF67RDzuXUuEn4ANIeUZI5jCaetP1erALznY5aCbcaNVU5kD5HYAOyTZ1pIC6CjeL/S20eQqULdJhfi02kNNXTs1HuqHmX7EJIXMFrN+yldzBRfbg5FfnSI99xHKEm3YjwkcolVsjFwv7T3C7xGX7PLK5c0R5ezQYI8ivjVSoDdiNorwKY7hTznIssnu1k3sTPMS45rAo3HvW8olA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6OVW7ocIiGBRMFo+yfL6NHImDSHXrJT6f0Lifj90Vc=;
 b=oZrsznDYket1EQCrbuF99f5hTqhI9AMM/fiwXtz5zJZLqR2PFD2HGrUPg8Qdko6LpQKDDtWR9GpTG8PiQdHKsKkkUuzWbwiV+oqPlnJTxVC8+83oFWAbUpQzhfN5qHrPiL1H1Iy7TFUXonfFhfXhI8JZE6Lbb/RyxtEruX4NEg0EQh8W0kpUMbABdCJVv+kdXxTpprLOt713PSiswW4irKbaUD2LqzaYE3yQLqVww0+3/40/ZJBZbW9imTuUX5bLMOhcOOul8DwJ6Js3z28Z/oOzPEYy1sHEYAsRRBZmgWUTqkPJXygbQ9tVnBWXsEnf550weTg13yiHEmK5OCS1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6OVW7ocIiGBRMFo+yfL6NHImDSHXrJT6f0Lifj90Vc=;
 b=XpHuM1gsCvhAJJpzMhqnJtzh9hfoBDC0TsKw02H+pPpdzli8C+N10WJ0s6CaLgAfoAQg9BAWA/XNlSzYvbHsIkMMhKvDNrvkdyj3cE/NTfN79lQnm5CGIcZHDREFx3FKTWhkyy4xkZxGV5LSLTPxI3vU/TyKluyAFEdrnSUNLCImHGb/Yr7ULHh+TnefkpLJGXYVzh9Bm21iEx0uVGX4pP17Ve5T+9h7cOYtI3ghCjjqxpPJQbDJ7D6vFP1nIctE2LLMCVhSt1DnOQlMhscwRkLU5jHevPNI/Ejk+kx44Vq1WOfAhY/E4B4bYh0qN2zEDgjUzWM9nmDl5zuCnnohaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 19:34:49 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 19:34:49 +0000
Message-ID: <191ec502-5873-4108-83fc-5ff6a67f90fa@nvidia.com>
Date: Mon, 20 Oct 2025 12:34:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] rust/io: factor common I/O helpers into Io trait
 and specialize Mmio<SIZE>
To: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org
Cc: dakr@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, cjia@nvidia.com,
 smitra@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, zhiwang@kernel.org,
 acourbot@nvidia.com, joelagnelf@nvidia.com, markus.probst@posteo.de
References: <20251016210250.15932-1-zhiw@nvidia.com>
 <20251016210250.15932-2-zhiw@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20251016210250.15932-2-zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc4a269-8ea5-453b-1795-08de100fbb50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXVFb0o1RGo4Z2ozeHZjWmRDaEJEaGNTRVRwQk9FVFRpL3dDZmdPZUV2YS9m?=
 =?utf-8?B?SWZpNWVRanJzdi9yVWVsSjJ1QWtjZnZZSE9ZTFV4R3lIbWNSK2NuNUx5Q3dk?=
 =?utf-8?B?Sm8yRVR6a3k1NExhTjFkR0xBTnkzdHQvcHp0Y1Z3SS9NVXF3Nko0ZkN1ZHdI?=
 =?utf-8?B?VllYenlvd0pySU5kd2FJUzB6bEpKaUZkNnBxaWxPUkFyY2hGeVNpdEZDRno0?=
 =?utf-8?B?RGsvNndmbmNmUWVrTHExZm9LM0N3THJjbDErbFI2dHYxYnhVQ0hETEd1NDRX?=
 =?utf-8?B?MDhPN2Z6d3paTktmTjNGVUNqSFdnS2VxT0N0bWpaSnFOaUxwenZOY2ZUT0Fv?=
 =?utf-8?B?RDJ6MGdnNFFRbkVGNitFS1NFa2JxY0ZNbnZHaEZ5QTJSYUNnK1crM1hweHVT?=
 =?utf-8?B?N2N2aWVIQUQwKzdQa1o4dkNpZkw0eVE3cWlZVW8wRnJnaEszb0NRdTZ6Nko2?=
 =?utf-8?B?VjZJeTRNbHFLYWwzUldyTk4wa1E1UWpwRmlWTjBCVGUxQVJGV0cyOUpwU0U2?=
 =?utf-8?B?ZkdySW1ZZUhxMFVRNDl2ZkZ1aVFvWUl6V2U0aVVOMDFzYVpQSWViRldFRjBa?=
 =?utf-8?B?ajRoWFlRYkc5aXB6OHJXMXpNczVQU3BZMFhUY3M2bnYxN29heDhPZk50bGp6?=
 =?utf-8?B?ZlUva3pBZFZpa3JBQVFHTlhRSkRnQkNVTVkrNU1HS0E2eUgzRkx4L2ZvUFNp?=
 =?utf-8?B?dElUbCtKU3I5NzBPTTNVTU5NZU5VNHlRbHNLblViOW1NaVU1T3FWTmdab3ZM?=
 =?utf-8?B?Wk1vUlhSMHZucXFXWnE2Tm85bEE0cVpUU1BCcVhla0ZHOXBTbjVVd0srUEhi?=
 =?utf-8?B?d0ZUck55WDNWWGEvWWtVRVdveGVuUHdkamFXU1RFeGYyd0dCY3BBN253YlRR?=
 =?utf-8?B?UGhHTzlkS0FoeVBTRExTUFNaUVdkeTg5aXJsNE43WTdDRlNBWjdhNUY3ckc1?=
 =?utf-8?B?L0gwc21pUzc3c0YvZjdha0FHQ1k5R1hXdDgrVi9xNk9pNDNJQWtLT0hzdDIx?=
 =?utf-8?B?akxXKzFQQ0J6dXpXM0M1S2FjMkY4Q1c2YXFmQ0VMdklNQ2l2c00xczQwWEJP?=
 =?utf-8?B?ZnMrVWwwMGVySWg1NU9Ba1FRTzhSc3BxdmNwZkZwV21NNkNGR1BPWm9lSitO?=
 =?utf-8?B?VERnUS8xU0VSQWJHbGNVUi9ObEkyTFg5eFRmc2x1Mm5hblROWHBkN2U4cXZl?=
 =?utf-8?B?eTlOM3BPSEp3QXRCVGdTdmZNY2lma1ZrRFIrWXEvRmZPb1RnUmEwQ1ZiMVE5?=
 =?utf-8?B?QXJaKzRwOGllM1RURWNBTkFqNHQ1N2JhWmNQWGNzaVh0Tm81bkpCdExya0sr?=
 =?utf-8?B?TWlGdGZSa09MVGdhWDNDRVo0QVJnQys3bFRoTlhuVWQyYk4veG5LVmtITTds?=
 =?utf-8?B?dG1lV0ZlWUxjYzBsS2FERFZUbi9GNmJaaE5KcE41M3hEazJJeHl4a0gvbWtD?=
 =?utf-8?B?VzNOc0U3dnBFTDk1OE8xd1hYeTJyQkpXek9OS05nZnJvdW82cUwvdnJ0d1VI?=
 =?utf-8?B?aVYycHMxRnNzVjBmdmY1Q0NjQm56a3h4amtReXhBbWl0RGFwQmNYWnhHWlJj?=
 =?utf-8?B?ZFZSN2RxMWg5SHd0TmN0VmZIVlYxc1YyQkNUamdya3FSbHJreGN5U2lyU0Jp?=
 =?utf-8?B?KzJzb1FkcFBPRi92ZE4zNG96VG5OK3FFVlR5TVpHcHVzSjZRMlpJQnZFWWVG?=
 =?utf-8?B?YXZUZFFWWTRSd05RaWhNTHFraUthTU94RGx0NC9IWGw0TUJpUWVHeStSVWdJ?=
 =?utf-8?B?MHB3NWZ6dmVCQmpsMkZKanlobXdoZUdDbmIrSEtjQS9wbEFhM2ZxSTRUdEJU?=
 =?utf-8?B?ZS9jNkVoMUtmbE4yNzBuVDRDZHJRcTVzNzR0NEdKTElqeUxpM2FuN3JObVQy?=
 =?utf-8?B?REIyK242WXZvUThPSDZ4U3hhQXgxeDdtNnJ0bWZ5V202SndVa0RldVRkaVJP?=
 =?utf-8?Q?Axhtc324H+oImVsHCERTdJ/H9DdeTVuf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0E3VUdWRXpZelJTUU54K1NQUnlYQlNXTXJQcFEyZWJNWUsyZUxoY0UzWTRX?=
 =?utf-8?B?elVQaHpmQTg4WUZjYUg5UTJvaG9wYlVSaUszc3ExWXFyT0wrN0svckJzc2Yy?=
 =?utf-8?B?NnhhY1lPWk1HVnI1QWg5TEw1NHE0ZVhGMTRIWkpoM1JlaC9ZSTh6NVRPZElo?=
 =?utf-8?B?Yzhic2haV2Q3MHh1WVcrRHIrYkE4UG1JUGZ3QVlWbXkxRllzZ1NWSlg3L1FG?=
 =?utf-8?B?T1ZSTnQwbVZVcHRzRWVNVjVqTE9wRERjNlBzd09UbVg5TWVIbHl2UzZVeEpT?=
 =?utf-8?B?c0VoN28xTnF2MXB1eU9jZktjVzZ3amdobjNvcEovM3c1MXBnY1pDd0J1b0FC?=
 =?utf-8?B?SEhENFlKTkpnV1NjQ0lKZHJKL3I2cUY3Z0NVRUk2TkRHaFIzY2ZnRkt2L011?=
 =?utf-8?B?YlROUTlzZDYyUVNKUktKSjZ1WTQ4Rmg0d1B3UW1laGJTVmNRcnJ4STJaMEd6?=
 =?utf-8?B?NmdVNEE3NkNzVHBVK0FUMTY2akpDakpFbWlKZ0o1RUZhOFlrU0M3ZWYzOUM4?=
 =?utf-8?B?dXg2RGZpQmdPN2JQQzRiS2Q1WEdBVEVzZkF2eWxxZkw1THdaejBna3FiZ283?=
 =?utf-8?B?Wm9KOFZOOXZIMWhxalB3bVJnUlpmWWFuR1o3eFJuSHo0amRHRFR0UEw3NnlQ?=
 =?utf-8?B?bU9pUXVyc1FrSVFMbmxTR3ZpRGpqTHdTTjIzbE41bE9BK3Rqcy94MXI1K3Q1?=
 =?utf-8?B?QTFmOElYVnBEZnpHaW9nenRNc3lRaTU0N2l2R1ZVMktNdDBqSnVVeEtCZ3Fh?=
 =?utf-8?B?ZkloVzZjVHhlMHhCa0UrYktsNVZVSEx2RVFoMjRGRWNCTjJsRXNTak9HTnZ6?=
 =?utf-8?B?WXMxS0VnY2UyVGt2R0hoT0RVQlhBejgzVmJ1Q3ltdVpQbXZLUFZoVHVzd0VF?=
 =?utf-8?B?ZG4rZzcrMHlZWitrR0lRbERmcnpkck9zZ1RRQzFDaDBiOG9TeXFqTzV6SWo3?=
 =?utf-8?B?bGhRK2QwWk93bHdaUUdkdStRNkdEK0NhM014c3h5NEhmWEM0cEc0Z1NVM2M4?=
 =?utf-8?B?ZDFvL0Z1OUpMblJKa1VjOENTYnRqN3NUN1BhRmh6eUNuRXRSVmhoK2tJNUNF?=
 =?utf-8?B?azNqaGtQNERGR2dpSjBWRVduOFdWMW5KSmNLMWkxbk5tSVp6SzEyV1RBdVI1?=
 =?utf-8?B?NFhhVTYrdXc2eE4zYlFmemhQT2Y4WEZpYVE5c0NYdmhRRmlzZ3pmMkRNOTRD?=
 =?utf-8?B?bjZGa2E2aHlxVjNVSjJUaGVha1VDOHY4aUVIcUhoWnk4RVI1elhSQkd2d0Yy?=
 =?utf-8?B?NTZvM0hEcjhxcklvZnpLU0dlSnFCdnJkcVRERHFwdGplaHBybm0xVVVhVFVE?=
 =?utf-8?B?ZEpnZFltTThJU2N1UWhEK1M4QWFIUlVNVVNYWHZpTS96V1FtTHB4RTJLWFVM?=
 =?utf-8?B?YXRPVzR1RWFtRThUQ3JhVWE5bDhLRm9pUkF5ZWo2N2wxTm1MdVRTMkFjSDhT?=
 =?utf-8?B?RnI4eXZxaTBrNFFlSmg0UStNRWIvR2d5NDQvYnlvYVpNOUkvajRHQWlSYTcr?=
 =?utf-8?B?bFBsYnl0MjJGVTZvU0pHeEtNUncyWkZDKzNHTyt0aEpocTJDcmpBaWUyYmxB?=
 =?utf-8?B?QlM0ZWs1Vnhkd0dzT2pNb2RnTlJSY1ptWHhjREdjYU4xT05vbm5ldzJnRng2?=
 =?utf-8?B?Z2ovYWFwanZVN1JHUmhiUG5WZ1pacndLY1duVlIvOXpvc3R6R2pIekdVRytN?=
 =?utf-8?B?dUhmcmJTZ2FTM0FLRHcrL3VLajlrOGwva00vbjNEcml5QlNXNEVwazJGU1Y0?=
 =?utf-8?B?SkZSSHl1TFQwY3NLV1crN05mTk4yKzhaZWFoTTdEVGJEVUg0bHRZK01jd0Zp?=
 =?utf-8?B?U00vT3VrZUVqY2JmWWNXVnlRLzdHUmRPdGVnRHRQL0d5TktSUkNMVlNhSVZi?=
 =?utf-8?B?SG5JMWNuaEhBN25kQmZzbFRMNXlmTXZtazdFWUJDTVhpRDdHK2U5c2F2VnVt?=
 =?utf-8?B?M3A0Y0tSc01pRmVsandkRStqUFdDb0pXYm9FVlczMEZMeSttalNpdnRGaENU?=
 =?utf-8?B?dHl3UVUwdVRxc3NhUzFKNGVhT21iUzhUODgxNEFVaFJFT0pjQlNBK0lHcUdT?=
 =?utf-8?B?L2NQNjhoY3B6K09iRWFkQzFJQWVKTG1nRGlsQ3E0bFFMNjQ2Y1VFSXNpOGZ6?=
 =?utf-8?Q?QTCx0mGfw3lqcqYLEpFgJNBXc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc4a269-8ea5-453b-1795-08de100fbb50
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 19:34:48.9164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrmT/XvNpHG8YnwlcVej77muFliQNhOfmeBBuYcy0sVqHfXKsRpGywu+vafFEslHOSEfAu7yfEDvdNxbMlYQEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433

On 10/16/25 2:02 PM, Zhi Wang wrote:
> The previous Io<SIZE> type combined both the generic I/O access helpers
> and MMIO implementation details in a single struct.
> 
> To establish a cleaner layering between the I/O interface and its concrete
> backends, paving the way for supporting additional I/O mechanisms in the
> future, Io<SIZE> need to be factored.
> 
> Factor the common helpers into a new Io trait, and moves the MMIO-specific
> logic into a dedicated Mmio<SIZE> type implementing that trait. Rename the
> IoRaw to MmioRaw and pdate the bus MMIO implementations to use MmioRaw.
> 
> No functional change intended.
> 
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/gpu/nova-core/regs/macros.rs | 36 +++++------
>  rust/kernel/io.rs                    | 89 +++++++++++++++++-----------
>  rust/kernel/io/mem.rs                | 16 ++---
>  rust/kernel/pci.rs                   | 10 ++--
>  4 files changed, 87 insertions(+), 64 deletions(-)

Hi Zhi,

This fails to build for me. Looking closer, I see that the doctests are
failing, which implies that you must not be building them. 

Can I suggest that you set this, so as to avoid this in the future:

    CONFIG_RUST_KERNEL_DOCTESTS=y

And here is a diff that fixes the build for me, with that config
option set:

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 10a6a1789854..d35cd39e32bf 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -52,11 +52,11 @@ struct Inner<T: Send> {
 /// # Examples
 ///
 /// ```no_run
-/// # use kernel::{bindings, device::{Bound, Device}, devres::Devres, io::{Io, IoRaw}};
+/// # use kernel::{bindings, device::{Bound, Device}, devres::Devres, io::{Mmio, MmioRaw}};
 /// # use core::ops::Deref;
 ///
 /// // See also [`pci::Bar`] for a real example.
-/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
+/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
 ///
 /// impl<const SIZE: usize> IoMem<SIZE> {
 ///     /// # Safety
@@ -71,7 +71,7 @@ struct Inner<T: Send> {
 ///             return Err(ENOMEM);
 ///         }
 ///
-///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
+///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
 ///     }
 /// }
 ///
@@ -83,11 +83,11 @@ struct Inner<T: Send> {
 /// }
 ///
 /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = Io<SIZE>;
+///    type Target = Mmio<SIZE>;
 ///
 ///    fn deref(&self) -> &Self::Target {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { Io::from_raw(&self.0) }
+///         unsafe { Mmio::from_raw(&self.0) }
 ///    }
 /// }
 /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index 613eb25047ef..835599085339 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -37,12 +37,12 @@
 /// # Examples
 ///
 /// ```no_run
-/// use kernel::io::{Io, poll::read_poll_timeout};
+/// use kernel::io::{Mmio, poll::read_poll_timeout};
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result<()> {
+/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result<()> {
 ///     match read_poll_timeout(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),



thanks,
-- 
John Hubbard

> 
> diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
> index 8058e1696df9..c2a6547d58cd 100644
> --- a/drivers/gpu/nova-core/regs/macros.rs
> +++ b/drivers/gpu/nova-core/regs/macros.rs
> @@ -609,7 +609,7 @@ impl $name {
>              /// Read the register from its address in `io`.
>              #[inline(always)]
>              pub(crate) fn read<const SIZE: usize, T>(io: &T) -> Self where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>              {
>                  Self(io.read32($offset))
>              }
> @@ -617,7 +617,7 @@ pub(crate) fn read<const SIZE: usize, T>(io: &T) -> Self where
>              /// Write the value contained in `self` to the register address in `io`.
>              #[inline(always)]
>              pub(crate) fn write<const SIZE: usize, T>(self, io: &T) where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>              {
>                  io.write32(self.0, $offset)
>              }
> @@ -629,7 +629,7 @@ pub(crate) fn alter<const SIZE: usize, T, F>(
>                  io: &T,
>                  f: F,
>              ) where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>                  F: ::core::ops::FnOnce(Self) -> Self,
>              {
>                  let reg = f(Self::read(io));
> @@ -652,7 +652,7 @@ pub(crate) fn read<const SIZE: usize, T, B>(
>                  #[allow(unused_variables)]
>                  base: &B,
>              ) -> Self where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>                  B: crate::regs::macros::RegisterBase<$base>,
>              {
>                  const OFFSET: usize = $name::OFFSET;
> @@ -673,7 +673,7 @@ pub(crate) fn write<const SIZE: usize, T, B>(
>                  #[allow(unused_variables)]
>                  base: &B,
>              ) where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>                  B: crate::regs::macros::RegisterBase<$base>,
>              {
>                  const OFFSET: usize = $name::OFFSET;
> @@ -693,7 +693,7 @@ pub(crate) fn alter<const SIZE: usize, T, B, F>(
>                  base: &B,
>                  f: F,
>              ) where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>                  B: crate::regs::macros::RegisterBase<$base>,
>                  F: ::core::ops::FnOnce(Self) -> Self,
>              {
> @@ -717,7 +717,7 @@ pub(crate) fn read<const SIZE: usize, T>(
>                  io: &T,
>                  idx: usize,
>              ) -> Self where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>              {
>                  build_assert!(idx < Self::SIZE);
>  
> @@ -734,7 +734,7 @@ pub(crate) fn write<const SIZE: usize, T>(
>                  io: &T,
>                  idx: usize
>              ) where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>              {
>                  build_assert!(idx < Self::SIZE);
>  
> @@ -751,7 +751,7 @@ pub(crate) fn alter<const SIZE: usize, T, F>(
>                  idx: usize,
>                  f: F,
>              ) where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>                  F: ::core::ops::FnOnce(Self) -> Self,
>              {
>                  let reg = f(Self::read(io, idx));
> @@ -767,7 +767,7 @@ pub(crate) fn try_read<const SIZE: usize, T>(
>                  io: &T,
>                  idx: usize,
>              ) -> ::kernel::error::Result<Self> where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>              {
>                  if idx < Self::SIZE {
>                      Ok(Self::read(io, idx))
> @@ -786,7 +786,7 @@ pub(crate) fn try_write<const SIZE: usize, T>(
>                  io: &T,
>                  idx: usize,
>              ) -> ::kernel::error::Result where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>              {
>                  if idx < Self::SIZE {
>                      Ok(self.write(io, idx))
> @@ -806,7 +806,7 @@ pub(crate) fn try_alter<const SIZE: usize, T, F>(
>                  idx: usize,
>                  f: F,
>              ) -> ::kernel::error::Result where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>                  F: ::core::ops::FnOnce(Self) -> Self,
>              {
>                  if idx < Self::SIZE {
> @@ -838,7 +838,7 @@ pub(crate) fn read<const SIZE: usize, T, B>(
>                  base: &B,
>                  idx: usize,
>              ) -> Self where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>                  B: crate::regs::macros::RegisterBase<$base>,
>              {
>                  build_assert!(idx < Self::SIZE);
> @@ -860,7 +860,7 @@ pub(crate) fn write<const SIZE: usize, T, B>(
>                  base: &B,
>                  idx: usize
>              ) where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>                  B: crate::regs::macros::RegisterBase<$base>,
>              {
>                  build_assert!(idx < Self::SIZE);
> @@ -881,7 +881,7 @@ pub(crate) fn alter<const SIZE: usize, T, B, F>(
>                  idx: usize,
>                  f: F,
>              ) where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>                  B: crate::regs::macros::RegisterBase<$base>,
>                  F: ::core::ops::FnOnce(Self) -> Self,
>              {
> @@ -900,7 +900,7 @@ pub(crate) fn try_read<const SIZE: usize, T, B>(
>                  base: &B,
>                  idx: usize,
>              ) -> ::kernel::error::Result<Self> where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>                  B: crate::regs::macros::RegisterBase<$base>,
>              {
>                  if idx < Self::SIZE {
> @@ -922,7 +922,7 @@ pub(crate) fn try_write<const SIZE: usize, T, B>(
>                  base: &B,
>                  idx: usize,
>              ) -> ::kernel::error::Result where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>                  B: crate::regs::macros::RegisterBase<$base>,
>              {
>                  if idx < Self::SIZE {
> @@ -945,7 +945,7 @@ pub(crate) fn try_alter<const SIZE: usize, T, B, F>(
>                  idx: usize,
>                  f: F,
>              ) -> ::kernel::error::Result where
> -                T: ::core::ops::Deref<Target = ::kernel::io::Io<SIZE>>,
> +                T: ::core::ops::Deref<Target = ::kernel::io::Mmio<SIZE>>,
>                  B: crate::regs::macros::RegisterBase<$base>,
>                  F: ::core::ops::FnOnce(Self) -> Self,
>              {
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index ee182b0b5452..78413dc7ffcc 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -18,16 +18,16 @@
>  /// By itself, the existence of an instance of this structure does not provide any guarantees that
>  /// the represented MMIO region does exist or is properly mapped.
>  ///
> -/// Instead, the bus specific MMIO implementation must convert this raw representation into an `Io`
> -/// instance providing the actual memory accessors. Only by the conversion into an `Io` structure
> -/// any guarantees are given.
> -pub struct IoRaw<const SIZE: usize = 0> {
> +/// Instead, the bus specific MMIO implementation must convert this raw representation into an
> +/// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
> +/// structure any guarantees are given.
> +pub struct MmioRaw<const SIZE: usize = 0> {
>      addr: usize,
>      maxsize: usize,
>  }
>  
> -impl<const SIZE: usize> IoRaw<SIZE> {
> -    /// Returns a new `IoRaw` instance on success, an error otherwise.
> +impl<const SIZE: usize> MmioRaw<SIZE> {
> +    /// Returns a new `MmioRaw` instance on success, an error otherwise.
>      pub fn new(addr: usize, maxsize: usize) -> Result<Self> {
>          if maxsize < SIZE {
>              return Err(EINVAL);
> @@ -62,11 +62,11 @@ pub fn maxsize(&self) -> usize {
>  /// # Examples
>  ///
>  /// ```no_run
> -/// # use kernel::{bindings, ffi::c_void, io::{Io, IoRaw}};
> +/// # use kernel::{bindings, ffi::c_void, io::{Mmio, MmioRaw}};
>  /// # use core::ops::Deref;
>  ///
>  /// // See also [`pci::Bar`] for a real example.
> -/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
> +/// struct IoMem<const SIZE: usize>(MmioRaw<SIZE>);
>  ///
>  /// impl<const SIZE: usize> IoMem<SIZE> {
>  ///     /// # Safety
> @@ -81,7 +81,7 @@ pub fn maxsize(&self) -> usize {
>  ///             return Err(ENOMEM);
>  ///         }
>  ///
> -///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
> +///         Ok(IoMem(MmioRaw::new(addr as usize, SIZE)?))
>  ///     }
>  /// }
>  ///
> @@ -93,11 +93,11 @@ pub fn maxsize(&self) -> usize {
>  /// }
>  ///
>  /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> -///    type Target = Io<SIZE>;
> +///    type Target = Mmio<SIZE>;
>  ///
>  ///    fn deref(&self) -> &Self::Target {
>  ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
> -///         unsafe { Io::from_raw(&self.0) }
> +///         unsafe { Mmio::from_raw(&self.0) }
>  ///    }
>  /// }
>  ///
> @@ -111,7 +111,7 @@ pub fn maxsize(&self) -> usize {
>  /// # }
>  /// ```
>  #[repr(transparent)]
> -pub struct Io<const SIZE: usize = 0>(IoRaw<SIZE>);
> +pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
>  
>  macro_rules! define_read {
>      ($(#[$attr:meta])* $name:ident, $try_name:ident, $c_fn:ident -> $type_name:ty) => {
> @@ -172,32 +172,24 @@ pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
>      };
>  }
>  
> -impl<const SIZE: usize> Io<SIZE> {
> -    /// Converts an `IoRaw` into an `Io` instance, providing the accessors to the MMIO mapping.
> -    ///
> -    /// # Safety
> -    ///
> -    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
> -    /// `maxsize`.
> -    pub unsafe fn from_raw(raw: &IoRaw<SIZE>) -> &Self {
> -        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
> -        unsafe { &*core::ptr::from_ref(raw).cast() }
> -    }
> -
> +/// Represents a region of I/O space of a fixed size.
> +///
> +/// Provides common helpers for offset validation and address
> +/// calculation on top of a base address and maximum size.
> +///
> +/// Types implementing this trait (e.g. MMIO BARs or PCI config
> +/// regions) can share the same accessors.
> +pub trait Io<const SIZE: usize> {
>      /// Returns the base address of this mapping.
> -    #[inline]
> -    pub fn addr(&self) -> usize {
> -        self.0.addr()
> -    }
> +    fn addr(&self) -> usize;
>  
>      /// Returns the maximum size of this mapping.
> -    #[inline]
> -    pub fn maxsize(&self) -> usize {
> -        self.0.maxsize()
> -    }
> +    fn maxsize(&self) -> usize;
>  
> +    /// Checks whether an access of type `U` at the given `offset`
> +    /// is valid within this region.
>      #[inline]
> -    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> +    fn offset_valid<U>(offset: usize, size: usize) -> bool {
>          let type_size = core::mem::size_of::<U>();
>          if let Some(end) = offset.checked_add(type_size) {
>              end <= size && offset % type_size == 0
> @@ -206,6 +198,8 @@ const fn offset_valid<U>(offset: usize, size: usize) -> bool {
>          }
>      }
>  
> +    /// Returns the absolute I/O address for a given `offset`.
> +    /// Performs runtime bounds checks using [`offset_valid`]
>      #[inline]
>      fn io_addr<U>(&self, offset: usize) -> Result<usize> {
>          if !Self::offset_valid::<U>(offset, self.maxsize()) {
> @@ -217,12 +211,41 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
>          self.addr().checked_add(offset).ok_or(EINVAL)
>      }
>  
> +    /// Returns the absolute I/O address for a given `offset`,
> +    /// performing compile-time bound checks.
>      #[inline]
>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
>          build_assert!(Self::offset_valid::<U>(offset, SIZE));
>  
>          self.addr() + offset
>      }
> +}
> +
> +impl<const SIZE: usize> Io<SIZE> for Mmio<SIZE> {
> +    /// Returns the base address of this mapping.
> +    #[inline]
> +    fn addr(&self) -> usize {
> +        self.0.addr()
> +    }
> +
> +    /// Returns the maximum size of this mapping.
> +    #[inline]
> +    fn maxsize(&self) -> usize {
> +        self.0.maxsize()
> +    }
> +}
> +
> +impl<const SIZE: usize> Mmio<SIZE> {
> +    /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
> +    /// `maxsize`.
> +    pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
> +        // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
> +        unsafe { &*core::ptr::from_ref(raw).cast() }
> +    }
>  
>      define_read!(read8, try_read8, readb -> u8);
>      define_read!(read16, try_read16, readw -> u16);
> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> index 6f99510bfc3a..93cad8539b18 100644
> --- a/rust/kernel/io/mem.rs
> +++ b/rust/kernel/io/mem.rs
> @@ -11,8 +11,8 @@
>  use crate::io;
>  use crate::io::resource::Region;
>  use crate::io::resource::Resource;
> -use crate::io::Io;
> -use crate::io::IoRaw;
> +use crate::io::Mmio;
> +use crate::io::MmioRaw;
>  use crate::prelude::*;
>  
>  /// An IO request for a specific device and resource.
> @@ -195,7 +195,7 @@ pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Self>, Error> +
>  }
>  
>  impl<const SIZE: usize> Deref for ExclusiveIoMem<SIZE> {
> -    type Target = Io<SIZE>;
> +    type Target = Mmio<SIZE>;
>  
>      fn deref(&self) -> &Self::Target {
>          &self.iomem
> @@ -209,10 +209,10 @@ fn deref(&self) -> &Self::Target {
>  ///
>  /// # Invariants
>  ///
> -/// [`IoMem`] always holds an [`IoRaw`] instance that holds a valid pointer to the
> +/// [`IoMem`] always holds an [`MmioRaw`] instance that holds a valid pointer to the
>  /// start of the I/O memory mapped region.
>  pub struct IoMem<const SIZE: usize = 0> {
> -    io: IoRaw<SIZE>,
> +    io: MmioRaw<SIZE>,
>  }
>  
>  impl<const SIZE: usize> IoMem<SIZE> {
> @@ -247,7 +247,7 @@ fn ioremap(resource: &Resource) -> Result<Self> {
>              return Err(ENOMEM);
>          }
>  
> -        let io = IoRaw::new(addr as usize, size)?;
> +        let io = MmioRaw::new(addr as usize, size)?;
>          let io = IoMem { io };
>  
>          Ok(io)
> @@ -270,10 +270,10 @@ fn drop(&mut self) {
>  }
>  
>  impl<const SIZE: usize> Deref for IoMem<SIZE> {
> -    type Target = Io<SIZE>;
> +    type Target = Mmio<SIZE>;
>  
>      fn deref(&self) -> &Self::Target {
>          // SAFETY: Safe as by the invariant of `IoMem`.
> -        unsafe { Io::from_raw(&self.io) }
> +        unsafe { Mmio::from_raw(&self.io) }
>      }
>  }
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 7fcc5f6022c1..77a8eb39ad32 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -10,7 +10,7 @@
>      devres::Devres,
>      driver,
>      error::{from_result, to_result, Result},
> -    io::{Io, IoRaw},
> +    io::{Mmio, MmioRaw},
>      irq::{self, IrqRequest},
>      str::CStr,
>      sync::aref::ARef,
> @@ -313,7 +313,7 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
>  /// memory mapped PCI bar and its size.
>  pub struct Bar<const SIZE: usize = 0> {
>      pdev: ARef<Device>,
> -    io: IoRaw<SIZE>,
> +    io: MmioRaw<SIZE>,
>      num: i32,
>  }
>  
> @@ -349,7 +349,7 @@ fn new(pdev: &Device, num: u32, name: &CStr) -> Result<Self> {
>              return Err(ENOMEM);
>          }
>  
> -        let io = match IoRaw::new(ioptr, len as usize) {
> +        let io = match MmioRaw::new(ioptr, len as usize) {
>              Ok(io) => io,
>              Err(err) => {
>                  // SAFETY:
> @@ -403,11 +403,11 @@ fn drop(&mut self) {
>  }
>  
>  impl<const SIZE: usize> Deref for Bar<SIZE> {
> -    type Target = Io<SIZE>;
> +    type Target = Mmio<SIZE>;
>  
>      fn deref(&self) -> &Self::Target {
>          // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
> -        unsafe { Io::from_raw(&self.io) }
> +        unsafe { Mmio::from_raw(&self.io) }
>      }
>  }
>  


