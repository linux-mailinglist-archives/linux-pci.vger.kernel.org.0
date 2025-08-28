Return-Path: <linux-pci+bounces-35015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EEEB39EDE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 15:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5108A03000
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19331278E7C;
	Thu, 28 Aug 2025 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZF7BC+fs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B3311956;
	Thu, 28 Aug 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387654; cv=fail; b=egmh+Qu3MZtDGx378uLI5sEwZucju8KFN8PWXEZaBZnTXc9d9TJG5dVnDEAkrBXqGqQSfnWVx8zQCwP1p2bvh1O13uSfmo3gIsliGLuGrWeWwYeV9QsDzC5ETb8JBt7hWlsgH/k1Zm2zjpZfFiYlwAcaIOAQJ3pEqh9sCD1YcAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387654; c=relaxed/simple;
	bh=ahKQ2IzOnuBznkyk9phoKIwW/MKwqsv+Jir0FY225k0=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=Uw08VDjSVtz7EJaAEYQR+Eg2A3XBLfFCb8erDzrMxC9RkA5wa+KCL0chpvklAvAlYdqs3mYPZTKprDMFL+HVLOOIYckV6Fnqf6OxBlFl0YNBl31jLonDApv3TkM/+elzo7oN8ATb4b0HhcVUWucTm9MGmLHGjmQxidlrkvXmGI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZF7BC+fs; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHrx7HwNP6k2dKcbltcve6sL1xCRv0F32jcZucEvYXx3Xlh7qaKXxmGIVsM+SC9d8VmbJ9sl/+kfglDX2afQuZmRzlMXfzagRECc5MZZz2RkiCkzAqhUo2hxLq0hVsHUXPl3ac6eNNXwpQBYxzOhDgxmbXwYbz3BJyViD2VWD/0B6aNMwni+YfFuBN5ivxH6EMCoFDyeQUC8RbSiRi00FYsVEZSu/7h+sHNg8Ykz/kJCcYFTUchAUmU/BAzadaIPfB4pLLBIt5wiYobVNpj+Eg4CsWWV0nYC52S22NpLssxtkNxQKzHU0OMi4GO+3V5rNmbxGhdDQI+t6CPj1+jS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hn1RqVbd5A80yUwXM2k7pu1W6s2oqMOpLDXKb8ouRck=;
 b=tslH2NnmvOzD29sF3NY7eSD28sGen+R0LLVkwJ8miyYGgpqWke34A3fg8Xced5IGo+QSL09s02SKRmczk8JlYIBhWzz1YaqwWSXMoTcBsKlNHWAb62TWgOewAqjztupP9iLamCLI0Z3PRKKPXwtStAf/P8GabEQrFXMsA7uajTODJpHPRHcabnvdFkJ/LRrwRChEarIl65rFJG2vitXmYNSmRuEyR8c0YEQOc77+Hel+LrM5dMJodP0bXVSBHvC12gmG0rd/0mqQqM7iD91AhCNvlBKpsP07sofW6ni5h9gr2lGe6UlFCct5+HeLyU1/6RyvEM1Ilfeh2Su7+vkmoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn1RqVbd5A80yUwXM2k7pu1W6s2oqMOpLDXKb8ouRck=;
 b=ZF7BC+fsMYibXfE06aU2QzTjS85enbdAEbqvZimayGVhRC/KJR4r/+0dUdi3TLn5Eddm1qSX00zslrm0M9UcjLRV1I1v2gpIevugibYB7f2ZiCzMD0Yzo8kIQWolrRwICZfZxrMeQ30/hpwzFCGrXHIxKAqvc7Shy+VItgANXYvdesfr4fCDNmjGGEY1oEsfyqueI1YEoq5+t2/OzsMTopNbgvb6BN1XCf2tRWKQ9wrru80xil2kUaWjeOFRyMw+c+hsn7cJ3ZSz+ayyzUXXuWmms61746bnpreIcBKzzOzfV8ucePsEBfTGO4BN8jdMiEyuMR6WDilBG0jCCVpS2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 13:27:24 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 13:27:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Aug 2025 22:27:21 +0900
Message-Id: <DCE3GFGMZ01P.267QJWUCG4JMQ@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <nouveau@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>
Subject: Re: [PATCH v7 0/6] rust, nova-core: PCI Class, Vendor support
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250826231224.1241349-1-jhubbard@nvidia.com>
In-Reply-To: <20250826231224.1241349-1-jhubbard@nvidia.com>
X-ClientProxiedBy: TYCP286CA0349.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d07c13-7377-420e-f41f-08dde636a004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEdyS2RjSldjM2J1amk5MjBXaGU0amhpc2ppc2w0OG5tZlZlU2NSVkdZVitW?=
 =?utf-8?B?UjRFYmhHVllJa3k0RFBtNXhHbUt2RWlRbVJFN3A3TEZEcXZBYTUvYWIxMDJ1?=
 =?utf-8?B?QXJUcHdnalBlS21wamhUVFZXcStScWRUbStYdHZoT3ZqOTFLSTNoaVpGMmlz?=
 =?utf-8?B?SzRQbjVtU2JPTUZZR3BET29JcDBpaTJtaHdNcjRLcXkwZDU2NEtpQUE0MjQv?=
 =?utf-8?B?b1dBZ2ZoaVQ2L0Q3M1QwVm56YzcyR2xHblZWMVlLMzFSamRYTzk1Y0hNdzdK?=
 =?utf-8?B?cmZCNUpkQWF1OFdIcHZIVnpqMjFCc2hoUjYweUIwYVZtS21PaERLZHFEb2JY?=
 =?utf-8?B?ZVVNenpQZ1RxQ2c4bmUyT0ZJRlZmL09ydGFZM3JsU011U09zRWg3cUczdStW?=
 =?utf-8?B?UXRyUzVSNzlmMzloZXA4cUNkOVlkcWVreVBVVUp3R2M2RnBmcUxNN2R1ZWo2?=
 =?utf-8?B?TVlRUUNsb2RaalNENTcvUTBra3NXNjdsVHVLVkU3c2xWdDg5aWpZek1Fb2M5?=
 =?utf-8?B?MW9MdzRvcWM1c04yeHYwREhlaFNnbGJvdzRLN0xWSGVVRk5sMUUwV3BHTisz?=
 =?utf-8?B?Ny9Ic01SRnhsT3pzTld4aHM3dHZsUVZ0SlNaK0xacm5OR3RzU2J6TXBhcDVl?=
 =?utf-8?B?d2NwdTZneXdUMVNyNjFyTGVhZkJiUGhQVmZDOWxTdXRsSGU3RVY4M2VqY2Np?=
 =?utf-8?B?Tlp1ZWp0dTZVWFJ1MFQ4eDF6R0RIVVc5Q0p0OGRERXhDRjJIMlZFeUxLKzRj?=
 =?utf-8?B?OHVhVnlvVWp2Zkc5R0ptbjV5dnpUaDN3M29uRE5iSDd1dzk5RFlXazB4UGRR?=
 =?utf-8?B?cmhkMVVDWG1CU0tQeFB1a09tdXNIV0s3MFNET2JzdGhXOFhzejdEVmpzNHBv?=
 =?utf-8?B?RmdwRjFuR3NBRzVyeVh1OFVpQUNzRXpsbEw5MHNtQVU1ZVFCSVZZa3cxYzY3?=
 =?utf-8?B?VDR5dzQwQnQ1U3ZFZW5wZFI4SENURkRxQ1dzV2d4RnRHZy9VeTltWWxBejJt?=
 =?utf-8?B?WE1SU3ZDS0hWNC9KMlRqOFVVeHdQRi9oUW02WjZkZ3QyRWVsanFLNXBSaWlB?=
 =?utf-8?B?SDZjQ25uTzB2TDBiYmNPODg3R3EyTXpSeU81bGJ2dmVvSVRIcU1MaGJkM2ZK?=
 =?utf-8?B?dWcwYlRXV3h6VGZCNWJRWTRBMzRkR0xPZ2tZdjBpSW5UbUF2VkV4ZVZMMmhj?=
 =?utf-8?B?NTVreG42VFpJenFxUXlvZlZJVmVPYUlMaFBGb2pMOHRrUFZaQXUxZ2hmTzFa?=
 =?utf-8?B?VkxVUXJlZyt4bnlTSTQ3L2tWWWNwR0pwYlN5YStFNld2bnNOeGp5NkpWK29v?=
 =?utf-8?B?SUl5VGtPSEZ1U05KVFk4UXhDYWVTUnNQR04wckJGVlg2eU1MMlNEN2ROdVNr?=
 =?utf-8?B?cW1yUVQ1MXIxekY3aU1LejJHd0Q2L2s5QlN3dG5PREU0dG1wQ1pxWXd5TzFk?=
 =?utf-8?B?bUhOcElmQis2REx1ZDBkRlFoNDhqTXExa2RXa2F6SnFyRTNMdWM1YnBacTVw?=
 =?utf-8?B?R0JVeHdiakNacmpEdWFYWHUzalNtTm45dm1QaUdnaW5qbjYrRkNCRERseXoy?=
 =?utf-8?B?ejRHZXdLK25XWVBPS1hCaGhvWmM0L3c4OGM3djJPNGpZSksxc3Fqd2sxTmZB?=
 =?utf-8?B?djlRWXI3RU1JdjZZZXFRQU1MUjk4WndvRmlYamg0KzVMQTNMelFPdjR1aXdi?=
 =?utf-8?B?Z3l5RHZLbHg4MC9teHk5RDBUbHh4U2xEdzA0M0V5TDF2ZDIxdDdCaEdRYnJF?=
 =?utf-8?B?YzIzT3RZQzg3bDhUS0lJcE9qZE5aN2RaQjhkNlN5UmhFZVBGMXZaMkpCMkhi?=
 =?utf-8?B?QVhvK016NjgvQjVBYllKb1pTYkJTTG1WR2VENWdCTGVqcjFjZ3EzZkdFRXBr?=
 =?utf-8?B?WGRrTG44V0VmVEsybDhPV09BQlZMUkgvem5aaWJuK0k1NDdrZGZqTUs1NDhO?=
 =?utf-8?Q?43zRpOOBWyY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWxQNDR1ZVpMUlA3WFBEQ01iNzhzQktwcWY0QUFuRnRrN0VLUHAxSnpRYk9S?=
 =?utf-8?B?T0VMUjM3ZmVzZlRtRWxQV0cyUTFGQ1FJZlEyY3RteVg5VjNuczdsRyt4elV4?=
 =?utf-8?B?TTJHWXhmZGFmazZGWG1EQ2tLNW5aR2FzQXd6SWlRT2dzUFRWZy9DS1JhOWJH?=
 =?utf-8?B?ZnFqUVpoT3U3OVBtRTVZVW5ERkpGRmRJL01oMmNtclFwMzFMTTVrYmllK2R4?=
 =?utf-8?B?UHoveUoycVBrY0duVWp5YTcxNUNhd08xZ0JRaFFDaGUvVG56bFo2RTJZVHUv?=
 =?utf-8?B?VFVOL1Z2SWJTZk5rZzRWVVAzN1JXd3NUMytZUjY3eU53YnRWQlRub2xKeklK?=
 =?utf-8?B?anQ2WU00ZlhRd0lpRmVwVFZjZXQ2b205MCtncXZtOTI2TFcrd252a0M3b00v?=
 =?utf-8?B?cUh6UXJEdytIWUZSaUZMbGYrN3FuUVdvaWxKODBPQlFzOExXa0cwckVMME9m?=
 =?utf-8?B?TWpWM3J6cURJc0NLR3Q3VVlZNkwyTXFQVTB5MTRRaVRnYXhoaW4zZFFPWXl4?=
 =?utf-8?B?c1RJUmxRbTVLWDE4eXdJaWFBc2h0cW5USGJnb2dpVU1aVW10eDFHckhSUEdn?=
 =?utf-8?B?UFdBV1QrVzVpQ0ZBRGdCZDJKSkZ3bjhRbHRWbFlBb2hEUmY2VXBZUmJlUDVn?=
 =?utf-8?B?WHhTVlRkUThnVm1EaVUxQlJDMEZLY1J5bWNTQ0dNdUdrRzRWZVlXV1ZkV3BQ?=
 =?utf-8?B?d2VCVHBucVN4WnMzMUlKNVQ5NnBFa1A5eWNzUHBqbUsxbUdzWjlVU01KS1I0?=
 =?utf-8?B?Q0dBNDB2R0RCWEtzQVVwT0JYREFKNHRIR0xTVExsY0UyaGtqOXJBK3UxbU1P?=
 =?utf-8?B?VHZpZGlDSG5zbjV6TjVZcEdBbHROV3dIZ2hJd0lTSWpOU2lLditrNzRDSzVV?=
 =?utf-8?B?UnlYWW1vWnp1UC9JcTlWbndNL1pLNTErSE1NS1Q4M2VNQlBaMmJ6a3lRQUg3?=
 =?utf-8?B?SDlWRUx5dnZsTVVxZEpiOHZ2QUtXK2xKdndiOUpIQ2E3NnhxMkZoTm02MWlj?=
 =?utf-8?B?LzhjNTEzNGJtWk1XNmhMcWNKVXJDUjArRG5jS3Awdjl1eUwyS2s1MnYxQmtm?=
 =?utf-8?B?TnVlcGxqN3RPYnRrSHU5VS9CRkJCWE5zcGxoaU4xRXd3aEZQSWVNRVFneE95?=
 =?utf-8?B?Yml2TGIzOFplU0U4SUhBaUpzRGYvQ0FhbHJzSzMvNGhGZVNYZDNXN25MTUda?=
 =?utf-8?B?Ri9rTGJxU29JQzR4bGpWK2tOMVAyQ09HRFlCRjlmUkJtT0J3OVlGdUdYS1FJ?=
 =?utf-8?B?bXppbGRhOWtNUGxsdjhjaFVvTVBFWmt3YVhPMkVrSFZjaGkwWGVJYldsYXI3?=
 =?utf-8?B?d3FYbGYwbVFPR0QwbFp3eDM0VmxhVktYYUpmSVY1UUdBbExSd2RCSisyQytP?=
 =?utf-8?B?ek4xNkN6OTJ0S3lMLzdERWdvMlM4L1laRWZaWkM5QmxYMk5PVnF4QVdzNEVv?=
 =?utf-8?B?R2xtOHZBT0FhY2hnelAxanRZbHhyWm0vdkk0VVdWbnMrWldPRm0zN21QVnhQ?=
 =?utf-8?B?QVNodnRhaE1OeGJLMkJ0bGgveXRrNEtGREdhUFg5R05abk0rWGhWSkRBTldL?=
 =?utf-8?B?L3JtdWdnZERMSFRuU2FnQm5JQ1ZURzkvQnE3LzQzZUtNKzEvbTVMU0ZPcWVr?=
 =?utf-8?B?RkorR2Q3Ky94ZUpWa1ZmTEFkVmlrN1NMalVlM0JCRVdvWWRSVVRMZmF3T1da?=
 =?utf-8?B?NnJLRjRZN0U5QXZCajFqcjEyZ25vK1NDVnpUcHFkUUZLUllHZ0dpckhqNlFr?=
 =?utf-8?B?WWZIazU0NzdWaEthL2UraTR4Q0pibUdHV1FZODFDL0ptUEIzaDJxMnlHdzBp?=
 =?utf-8?B?V1NaWitldmVodmFzZXNuYjFTazFCSmFHWDRoQ1E2U2ZhNzJpVWxWVzNoTkVY?=
 =?utf-8?B?UlZQeEdsWXFhV1NqQkplSFBSY1B1L3dUTzZPd3VQMEE2NTZQRmRCRThLT3Jy?=
 =?utf-8?B?VlQzRUNWZ0VlTGMrM3ZUQUVOSEk5em55S1BwdXpHZXNhSGNLbUY0RHYxcEtX?=
 =?utf-8?B?Z1F6M2ticTRaV05PbTRTdWpscUdyZHpXaXZPQjJIckZ2VjVyRG9RU0FuSWhS?=
 =?utf-8?B?R1RQRi9UTDR0dy9vNlVEZGlwMFZIL0hEQ290R2ZPNVFuVmpGRXppZEVEVE9o?=
 =?utf-8?B?U1phT2hnNjZNVHJuQlpkM1lhNVdvMm1KYldOL2lpclArQTVWR2V4OU4vTFBh?=
 =?utf-8?Q?fL49nv9QkvmJuYuzT/w6MUOlrItYbrGt6hofglC+gFnQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d07c13-7377-420e-f41f-08dde636a004
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 13:27:24.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvXpJgXGqe1q/iLCcNe6Hk+9FAEH7oWDJ9NnVbuivPDHyEjudvqyVdYr6WrIyQ1wPl5S5U+Cf42Aa8ELqjJ9YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359

On Wed Aug 27, 2025 at 8:12 AM JST, John Hubbard wrote:
> Changes since v6:
>
> * Applied changes from Danilo's and Alex's and Elle's reviews (thanks!):
>     * Rebased onto driver-core-next, which is here:
>           https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-c=
ore.git
>     * Changed pci::Vendor to be a u16, instead of a u32.
>     * Inlined all of the tiniest functions.
>     * Changed from Class/Vendor new(), to from_raw().
>     * Made from_raw() only accessible to super, which in this case is
>       the pci module.
>     * Restored infallible operations. That causes Alex's request for the
>       following reasonable behavior to work once again:
>
>           from_raw(0x10de).as_raw() =3D=3D 0x10de
>
>     * Added a new patch, to inline the remaining PCI operations. This
>       provides consistent inline choices throughout pci.rs.

I am far from a PCI expert, but regardless of bus considerations the
code appears to make sense to me (particularly since it removes some
uses of the `bindings` module!). Thus, and FWIW,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

