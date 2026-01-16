Return-Path: <linux-pci+bounces-45060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF5BD332B1
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 16:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69B6F30EB6E5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 15:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F91212549;
	Fri, 16 Jan 2026 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Dgiv0yfu"
X-Original-To: linux-pci@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021120.outbound.protection.outlook.com [52.101.95.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06839337119;
	Fri, 16 Jan 2026 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577037; cv=fail; b=bkcyoQNC7rGE6R7UEGBbv/dqHgDXH9sl+UaYlMJn8bQJSlMRPtk25K8V/CEdblj+WUnZpj3QI9ECJUCLne3g2kxSdCOd4gkLf5irhSRMJX3HxZJaUPBZvJNfYB2o1Tt7nhnFD66FgGNK6vzbpgHMWJ/zIqOCGje2nDLbiNjrmaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577037; c=relaxed/simple;
	bh=lFIx/oRiy6KcSUqLA+Hzi3jkrJ+MdxPW3weufuYVE4c=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=dDcn+HY5kcSfekOWvE+f/PrcnnRsxz6cDmVFV2Q7kWeLFV65F2/7k6ZLlvQlur9dNmlfUFXx4pcHDSnQK7Zy95vDX4KqipR57+Ld+xe7u2GA8tv8IaMsjHMTuDb3ubTaEczG6zMYz0KIu0C89m284d55ivB8sgg/4FbTXZP/5Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Dgiv0yfu; arc=fail smtp.client-ip=52.101.95.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdNAZXo+5bJ/nUKmfK1DQIBLqupBYyNxLXzxvrCnbDB6CC0xQdK8+KcjIaxvcJWv8rELQZ8a5Iy7Nvo8HRDVLm8v4cRBKqplgeK0fEDQnESkpS/H2NRaZ5D9rwFgOJD/xPy5sAjYe/kPcnQIU5enOitc8fdg661QA0/33CIh2CPYHQLcuhkgwy3XmLwzUpDrn0rHYGKQszEWgOMGS+/Y0+O/ezH96rDpCJYDE50SR1kcI2YH6pVXG7DLpXCnOp5o+arZBy4ltiROyrhhSNd6WqFFgSieyJ74PGTJsg0tciyMPaOZCAKcZ8H63LvUgbDZaVXBBjdlB9fPI8pAEh2u2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6aIV+Zbq1KO9QFFCwQdAoLn65sdtYGxCOhlyMDGLjg=;
 b=mjFKqtDNoTroNT2LZ6VBDz/b7TZ6cOiltTflzgk1ozQhC5NdEcxEdPW74M2U010TpCSjZup9uLq+sm46Jygj4WbCYNDHVMIN3yCiUWku7tQx47LIWgXlE7L6WeQdmn5k22dWdwqoNgerOemw8liZFJXkkT41IbFfMMq115UgAlH8Qma5M+EvNfJyJDQOYfjSFtzFVJzIxY+xZsZ8con+U4kTTuP7BljSdhT5zE8s6iWG327MpOGEn79ZzlbxTbtZX5frMcJnmmskZff2L4GlQR7ed1h28nf+CbX5unEft0RiKimG5Wq6L8i4DpSCWa3KqCe9g5lxMriv3v2EhX13iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6aIV+Zbq1KO9QFFCwQdAoLn65sdtYGxCOhlyMDGLjg=;
 b=Dgiv0yfuU05OY3JefnOWG8lju6skzIwVz/m4DtwO3FzbFGQZ03w4Bmy4WBfIMFQHQxkBLsXmmfv6KTragco8LHbXK8tQ3MM5c5M1o4XMjFW7kbx93dobdzRsuompOMYRMnS5CzvTCDXf71ISxsAlodJ8j3v8hk/SEisYgkEjjMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3181.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:161::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 15:23:51 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9520.006; Fri, 16 Jan 2026
 15:23:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Jan 2026 15:23:20 +0000
Message-Id: <DFQ481S2NI1S.3HMMZMYEQ9QP8@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v9 2/5] rust: io: factor common I/O helpers into Io
 trait
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Zhi Wang" <zhiw@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260115212657.399231-1-zhiw@nvidia.com>
 <20260115212657.399231-3-zhiw@nvidia.com> <aWoWntMxyhBc9Unx@google.com>
In-Reply-To: <aWoWntMxyhBc9Unx@google.com>
X-ClientProxiedBy: LO4P302CA0018.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3181:EE_
X-MS-Office365-Filtering-Correlation-Id: d798aeea-7130-4ca4-e439-08de551340db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk1uL05yM2VhejJ3QmlZcjNkdzJLdHhIZktQbkp6WG9yWWtkcVN6RXQySEYy?=
 =?utf-8?B?V0IwUEQvU1BBU0ZsWDRkMW0vT1YwenZHVFBqdWd5NTZIOW5RdlpBTitpd3ll?=
 =?utf-8?B?NkU5MHRQZWNJMHhLalZpQ1U4My8rTnh2bUorRGtlZTN6UHRzcHI5Q2hxNUps?=
 =?utf-8?B?WU1NZFlOcTdLR3BHRktPeDMydkxrLzcwS3ZhL1Z3ekpzOTNlOHFhRG1JRFFz?=
 =?utf-8?B?dnFva0tlNEFTMnN1NzFEeHRaOUY0Z2pEc0NUZ01rM0pDKzRObHUzSUMremVr?=
 =?utf-8?B?UkdBTVd6MW1jVFJpVklGTldCS04reWdVMFZHV1JsQjNPamN2MjZONWdzQzVO?=
 =?utf-8?B?aU5YTmFCejh5dXpDbVNFb05JYWlyUVFIYVh0N2JmMko5UnkxSnloN2RqQXdI?=
 =?utf-8?B?cCtyNXhTTlJYYmhuejNzTnAzdkNlenEwb05rQVNZdXJQbXppSmxLekFWMFA4?=
 =?utf-8?B?bEIvdVNWVENleWQ3bFc5dWtoVHFtK2g3QVJ2dFZNQ2hJNy84bG5UV1lWT2hJ?=
 =?utf-8?B?Z09rT0QvR292ajNTYWNzUFFDbWR0UHdVMzh5ZmJ6SmtyNk5hemYrNFFKOWZW?=
 =?utf-8?B?WUpvTDhSYnF3TGplVzBQSGc3K01LVzUwTkczS0lFVmZydHpmWSt5aXR4U2Zi?=
 =?utf-8?B?NWl0dE9xbGU0UmhtUW9uNGdhNE5QS0dQWkk4bHoyckRDMURJZ09Zam1PTWRt?=
 =?utf-8?B?bkJqb1VKMEUweGs1WVlPWVJOb3J3dXV5eGg4RmRZWXQ0b092UzgvSURVVC9V?=
 =?utf-8?B?N2FXT2lIbGNlaUlZcVE5VWsxampqQmx5b0xCMkY2dnN5cVFLVVdLZW9EVUha?=
 =?utf-8?B?MkZIOUdYc1pLZjFyaGNoOHdaV2RYTTJaOCtzdzVQUGlRMU9uWnFxd1A4cVR4?=
 =?utf-8?B?WW5FejBuaWVzTVNjZ1RyTlE1NTZwUDgyUTR3eUxEVFI5MFAxMVVhbzhOT1VZ?=
 =?utf-8?B?V1ZjZHN4VjJzbk5oNHhweFVpV0J2TmkwZ0VDcnBUNDlyUXU1L1N2c1ZmTXZ0?=
 =?utf-8?B?OUZtbURJUWRJRlh2VDU3YUpGSmNNdkpxT1oxbzlaZXgzM0FERHBoWm9HendN?=
 =?utf-8?B?UFd4VUhpOHlyYnN5L2tQRXNMUGZuRVh5TjhudnBXR0JRcVRESkxHZW5Vc3lB?=
 =?utf-8?B?NU9TdllsZUJHdk5LcDE3S3J2ZXdRbzBPbUVlbGg1UU5iQkMwUTB6bExrOU1V?=
 =?utf-8?B?ejlGYmphT3YvNFlERDhtOVBtalZFNzUxeXdPdE5PMCtkTEJlL3dIVzQ0QUEv?=
 =?utf-8?B?YXkxZGExZDhjbGFMUmFoa2JRTDFEV1lPUk5iT2p6QTFDRTdXc05qVDJYTFcv?=
 =?utf-8?B?clJsMkVSUFE5RC9oOWludTBOK1pOL3Y2S1R6QnZtOFVQQXNQWWg5c1IzY3A0?=
 =?utf-8?B?SlJsQm9VRUQ3S2REelJaVzMzREhyT3F5YVF1alZyKzhuc1cyeUtjektEeTFW?=
 =?utf-8?B?WEhPd0MyMittRDV3a3dqK1ZYZ3F0VUtlNFBUZmxvd3VKamtxbGY1bUZaTWMw?=
 =?utf-8?B?cURuZXJvcFZlMUZ2SjNEMkR2Z21ILzJZRFhNaXNMTmRUUGx3ZHRBK2xSUHIy?=
 =?utf-8?B?QjdIaHROOXhoMnZOZW1DRHRwRHRUa1hmWW4rT3NzamJ0S0JaU1hmNkRGT09G?=
 =?utf-8?B?cjFFWkxMUFFKZmp5WmNvUG4yT3RaLzRDZy9TL2pGeW9oelExbVIyUU50Z3Vi?=
 =?utf-8?B?ZS9lZ0YycGs1NkxmNTFCVThlVml0ZE9jamlEbDNoQzNQSzlpdTJUY20rRzhD?=
 =?utf-8?B?ckgxVHZZYUNyQU13bmlOVmVmN3RxYWh3T0dYT2I3eFFQQnEvYzlwbTZpOUNl?=
 =?utf-8?B?WFdHamRtNHlvUVhuTG85VDkvQnlFQ3YwVmlHdlFqemtHY21Rc3BNQVVhZkZX?=
 =?utf-8?B?SXBQY1E5ZjhVSThnaGJ3UGhzMllUTC9hUm1wL1RURXZoSXhrdzRnQzhNbW1t?=
 =?utf-8?B?UVNiOExpeFlJQkc2dFo4bWsvRk84QTRFRkd0T1FIYUFYYUEwbFcxWUVQYlB0?=
 =?utf-8?B?djBvNXQvV3VZeWZTeTVJRi9oYlBETklYRGJsMHdwQkNTRWMvZVEyRjU0dkFt?=
 =?utf-8?B?dFZ1Qis4MWFhOXFtVGFjS0NHRHhkNTVlOTZDMmU1bDIxY1BCOWh0ODc3Vllu?=
 =?utf-8?Q?oDac=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZklFTVV1Yzk0dXhMMnNaUEo1Sm5KTzdqRlM3T0tlNm1hUGYvUGY3OHo3QjRZ?=
 =?utf-8?B?Sk91Qjd3NzZNeXMyVGFEaGpuVGpkUUllcW9mUWRSN0VvK1BGRWF4MWYzckND?=
 =?utf-8?B?WGVMSjRVTU9iYlpERzRpNlNBd3lhaEU3YkRTL1V5c3J6cmVLT3Vjejd5ck5R?=
 =?utf-8?B?MzN3TW5TR3V4NlhRci9uQ2Y1VnprRnR1c2lmOGVaTTkxT3FsVUtpSys5Vit0?=
 =?utf-8?B?bXRiaW13U2NHeEhEbGNsRTRBaVROclc5dGhYR1NRVlVjbmN2NHE4Q2xtM2ZV?=
 =?utf-8?B?ZnJKamFhOVc5cWkxWFZ6MEZOUSsrZ0E1Tk1ucDNPV0tIZ3EvR3Bta1Axc2lH?=
 =?utf-8?B?MXMyeVljL3hBaWRoQnpXWGF4aFJwdXFuRHg2NmRVSGM0U1dsTFk0NVFLVldm?=
 =?utf-8?B?WWdxRHp1M0YxQjlDZnNwOEw4ZGRZNDkxM0taZUVHQysydW1QOVpJNitjQ3Qy?=
 =?utf-8?B?R21oTmRGZnhVWTd0Wk5LVkp2aklIT21zV1g3b3lwMlU5dW9KbjllL2RzTEhQ?=
 =?utf-8?B?SWJ1N2l0V3h4ZXhYbWZIdnlsTWlqWjQ3Unc3dWVrU2JGNUEwU1ZJTjlHWlhK?=
 =?utf-8?B?VFJaR1dIbHdaUGFHcHpwWVM4K1BKUEVBUS83Mk4vZFVqYlBaUnRQZHowVjlG?=
 =?utf-8?B?emhMc01XRGZ3YXpjWVZ2MlZXK1pkUFA0d2s5THNvNW5mdUxzdTNtZldRWTl4?=
 =?utf-8?B?MXFBL2dIVVNHNkNIRXB6bGozU21SR2NSNU9zYXBHT1kvM3dkaktTZ3RIMUVs?=
 =?utf-8?B?RzVtaFlDWTBObzZqVUNoNlVZWk1CSVFOWWJnZGtxOEhMMmY1dVpQeHdVc2l1?=
 =?utf-8?B?bENIb2lZRkM4WmxNL2VNVjVOYjNLZy9KcFZ2THNSMk5xNi9HMHlxVmgyYm0x?=
 =?utf-8?B?RkM1WThqbDRSY3NLUktScGsvUTV3K2RMczdRWkdkVmJ4QklVQ1JjcU5qN0do?=
 =?utf-8?B?TTQ2aGlZdnRJS21mQVcyTGtxNy9oL2tWVkE3ZDd3M21KaFF5YktPSVVWRUVX?=
 =?utf-8?B?VVFQUHhRSVppMzEyV3JiMnA2ejZXZXpmYnhoS0svUDBsenI1YU11ck5tazJC?=
 =?utf-8?B?RVJMQm9DemFNUG1tTmRFeFNITlFtcHVNZ0ZhRkFmdmh1WmlsR1hkQjVkV0t1?=
 =?utf-8?B?akpBQlJtYWl6VFpvcGRiOURyR2Rjc01wcHRoYkdFZjNLTWErNWlzaUFRbTJ1?=
 =?utf-8?B?UWVjNE5uK2FqWkZESWk0aW5tcVY0aGF0dHdLWjc0Y3BDU1dVVWNVV2pxbTho?=
 =?utf-8?B?cVlJa3UxMlA2bU5Ga2Z0YTdjRDhua2lKcXloM1ZIbHlzR05ra1UwRkVHb0JM?=
 =?utf-8?B?ejlxclBocW1MTm9EZ3dXSFhheFZKS2tFdkZqeENqdE9sbDd3UFRqWGsyVnIr?=
 =?utf-8?B?bEZGUVpnZktyaWNBbmRpY3Z2T1o1Q3dBYXc5N0Q1aE1XWTEyQ2ZpQjJJbVAv?=
 =?utf-8?B?bjJvZnB2endTNGZTbGliWTFHalNPazQyUExxYXNHR2FZK2pOZG50dU9ERm1k?=
 =?utf-8?B?T3FDWUdqVytiMVlVU2I5dXBSL29Qb2tDSVBjV1pLd3Y0dlo3WlhIN3JiQWh6?=
 =?utf-8?B?Ym9HR0RlcjZqeW1SRE5Tdys4VForc1cxLytvMytKZTZGYVNkZEd6WGo4RHVR?=
 =?utf-8?B?WFBWcE84ZHduaTdQRTV1elU2NTJHTDRoZ2dhNkRhUEZHVHlnSTJYM1dIRUZK?=
 =?utf-8?B?TlFBSVdoVHUrVktSbzJ0bUhIMUY4TVRoejljL0xBUWw5c29EN2ZRMmFKV2hH?=
 =?utf-8?B?dEhsRFRya2lCTXN4bG5DaHMwVSthZEpZaGxmcVgvRFdkeDAvNjZMcklOazJv?=
 =?utf-8?B?dk1GdEU1a0dDY2dWVUZhaW1aMFR1dEdnSGd4c1BJTXpGU2xGdjBQM0pZenV0?=
 =?utf-8?B?RVRZNHNCdnZjOXFyWEdpMWZ3VTQzVTc3aFJoZ1NFS2ljK2ZjNGUyZS90R09W?=
 =?utf-8?B?MVQyektFMnYyZ3pobjUrTUFaTUdMckxIQzhhR3JBbnQ5eENpZEZNNjJ2c0pR?=
 =?utf-8?B?Y3lSL05DTU40SXc0U3NJeTlwYnl1dTEvL2pVajh0MkhzcytmUEJxMm8zeGV2?=
 =?utf-8?B?UmJpUE9RZVQrdUF5STFjTE5kN0NyVGlMSjlhZy9KdXpNQzNUMUJQZXUzb2dq?=
 =?utf-8?B?dlhlaHc4NzNPdWc2VEFacm13WUxKTkhQWTZVQ2RMZCtpbnBoQmZvdTYrdG1m?=
 =?utf-8?B?TDA1ckJybkdnRG82dFVnZzN2WCsyVzZ4VkNjL3lqc2VYSm5oL0k0cGJVYm55?=
 =?utf-8?B?aURkWnpvQzl0RFV6Z29nL0JXbEZQaGc5VS9reC94ampyR3ZhOXhiSmJ0YXFz?=
 =?utf-8?B?NUtPaWZ3UFppeDNTd1FQSVVTdG1YMHYwQy9YWGwzSlRkREwydjF0Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d798aeea-7130-4ca4-e439-08de551340db
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 15:23:51.4985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQXrml1nIvuUBVXDRaHRXLvDrujTvUregstrXH+h9EYsrg5ws7jrlBbox+4qTUf8Doy0ps7DjPXDjJcfDqx0+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3181

On Fri Jan 16, 2026 at 10:44 AM GMT, Alice Ryhl wrote:
> On Thu, Jan 15, 2026 at 11:26:46PM +0200, Zhi Wang wrote:
>> The previous Io<SIZE> type combined both the generic I/O access helpers
>> and MMIO implementation details in a single struct.
>>=20
>> To establish a cleaner layering between the I/O interface and its concre=
te
>> backends, paving the way for supporting additional I/O mechanisms in the
>> future, Io<SIZE> need to be factored.
>>=20
>> Factor the common helpers into new {Io, Io64} traits, and move the
>> MMIO-specific logic into a dedicated Mmio<SIZE> type implementing that
>> trait. Rename the IoRaw to MmioRaw and update the bus MMIO implementatio=
ns
>> to use MmioRaw.
>>=20
>> No functional change intended.
>>=20
>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>> Cc: Alice Ryhl <aliceryhl@google.com>
>> Cc: Bjorn Helgaas <helgaas@kernel.org>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>
>> +pub trait IoBase {
>> +pub trait IoKnownSize: IoBase {
>> +pub trait Io: IoBase {
>> +pub trait IoKnownSize64: IoKnownSize {
>> +pub trait Io64: Io {
>
> The following combinations are possible:
>
> 1. IoBase
> 2. IoBase + Io
> 3. IoBase + IoKnownSize
> 4. IoBase + Io + IoKnownSize
> 5. IoBase + Io + Io64
> 6. IoBase + Io + Io64 + IoKnownSize
> 7. IoBase + IoKnownSize + IoKnownSize64
> 8. IoBase + Io + IoKnownSize + IoKnownSize64
> 9. IoBase + Io + IoKnownSize + Io64 + IoKnownSize64
>
> I'm not sure all of them make sense. I can't see a scenario where I
> would pick 1, 3, 6, 7, or 8.
>
> How about this trait hierachy? I believe I suggested something along
> these lines before.
>
> pub trait Io {
> pub trait Io64: Io {
> pub trait IoKnownSize: Io {
>
> With these traits, these scenarios are possible:
>
> 1. Io
> 2. Io + Io64
> 3. Io + IoKnownSize
> 4. Io + Io64 + IoKnownSize
>
> which seems to be the actual set of cases we care about.
>
> Note that IoKnownSize can have methods that only apply when Io64 is
> implemented:
>
> trait IoKnownSize: Io {
>     /// Infallible 8-bit read with compile-time bounds check.
>     fn read8(&self, offset: usize) -> u8;
>
>     /// Infallible 64-bit read with compile-time bounds check.
>     fn read64(&self, offset: usize) -> u64
>     where
>     	Self: Io64;
> }

I like this.

I wonder if we can keep all methods on `Io` trait. And then have marker tra=
it to
represent capability on performing Io access.

Something like:

trait IoCapable<T> {}

trait Io {
     fn read8(&self, offset: usize) -> u8 where Self: IoCapable<u8>;
     fn read16(&self, offset: usize) -> u16 where Self: IoCapable<u16>;
     fn read32(&self, offset: usize) -> u32 where Self: IoCapable<u32>;
     fn read64(&self, offset: usize) -> u64 where Self: IoCapable<u64>;
}

Then you have a single (non-marker) trait and not a hierachy of them.

Best,
Gary


