Return-Path: <linux-pci+bounces-34660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908B8B33F27
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 14:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D033F7A7371
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 12:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D692B72639;
	Mon, 25 Aug 2025 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nABiCtNM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4518B12;
	Mon, 25 Aug 2025 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124258; cv=fail; b=ejrt1y1cOWMS6EZ33PvsCzWX7KAsY1oPbbWmAQFQQMM1rHgXpqDJ4lZeNHI/4BtVS2OEe6KpPtPPWSoozRNzNoPgfyrLD1tUvU9p3Akn3LJquf7xa/dFVF8/CRlacat+0znN0K/qPjTKIaaIcL/AJHX2IVpXac0z4Z1WyyVBNq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124258; c=relaxed/simple;
	bh=P+rpuDFqO13V57O0rDYJ+AuE47/3iKtD2MtjNJeH4xA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=i5O57Ko5Ic0eOVhnAeWMGoUAX1eBX42pAV4ICbMzcQpbD24391b7pxGCMt3ZGQ2nfVui79Z//+twlZoQxYTNcqRvul/jXo7oVllkEJH2ejoXOxuqBcE9324NaoN60kjbejyVb4emcWmeTgqGCnYs7rQmvNOU0zvF1YZfP5zCU7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nABiCtNM; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJB2uFYS2+5A31tWHc0tpd4LMatlwxbSDKE1OXmp7nENfow956HaNf0Uwy4UWMwB2A6kzfM+YQorXvC9YosKi85tDnb1FK719zR6h22iXzZTKIguQ8/F6nUB8yQkWxv2ZOXmwpnRY4F/EczDVYkg1dvIPW0LUw+ay9yYF1JNOVSrtqT7oW4WNK+gPdD+E2UMSMxOXG4VRLvVkMWma96++3XkKpgWUe1Lzk3jvbnLXl4y+g2BS1/QqaH8c9hbGyer/Yfn5mHVSwehL2oZBOgrtCX2m1PPwLSGuRxotqiC8iwkpxc0c3QNXharIKkw9qqE+hFcx/8Ie1Rvr9RHVyNUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+s445BdfOYbZ072yjEZ8y0bAb/7I6ffuCGrZDBLIJlk=;
 b=KIjCl5ZDYukIPr53/hPJNTCtrbNjpzTI+SULoLL7BOyz/yyMay7SCkWVjjGujfMC2YwdxmA0BvhYfo0hUKYB5X2oLwnBDMnD7qzotJYG+tcgFDogJpfHY+36dfWvaJ58UXlrQ8XS7P2WjQ2Zwd10GB7TxncqpGjvkwmg7D3nEQ16gu6mEtLdcKtfVGYr6Cs8wnHZWIuolmXM0+gKCVEjSOypqR2z56BcryLE7Zsz2kIoQ5qD9X4KsnHh5nLtY/EV2xrKQMLiwcrm0o7kDdzHcakHL0sGBrr/v1KRNMwIQ4XEujBBRhPby083vWvc2XZbsnbh38O3wX4JiAdXLSOXGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+s445BdfOYbZ072yjEZ8y0bAb/7I6ffuCGrZDBLIJlk=;
 b=nABiCtNMv/K7VIkFA7JkRbwggtqgn9pJ44M2AX9exIlGkQCoaD9GMGV4SosENcgMqjXJh2aHUWJ2mrSAV8ILHzmejjHB55m0qi8Gs15GYu+LBpz/s6dZ516pE/XF3/XtOtw3VKnOZTO55+0cbpcX2n1t7t+kNbD8IAvgkXe//ex9+eLzgl7SSeQPAx+Zy2+FgvYRcunGwxDbOrtXI2r93BA/n65IN3v8FJvCVn86kZPzOppfH0Ml9T5lLVlyL/qxenQuR/kXu0tx5oUoU35MJmtjjPZBStMcb/Q7GVqqD/7VSJEwF1u2NtO6JuW+5WMrJuMkCnuyabkwtbHJZjiDbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 12:17:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 12:17:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Aug 2025 21:17:28 +0900
Message-Id: <DCBI3A82MOFN.3R7O7I6U6D7LN@nvidia.com>
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
Subject: Re: [PATCH v6 1/5] rust: pci: provide access to PCI Class and
 Class-related items
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250822020354.357406-1-jhubbard@nvidia.com>
 <20250822020354.357406-2-jhubbard@nvidia.com>
In-Reply-To: <20250822020354.357406-2-jhubbard@nvidia.com>
X-ClientProxiedBy: TYCP301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f4e7837-ed0d-4f29-0ef1-08dde3d15d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3I0VWx4VzZXY3U5bVBOT0RwblYyc0FOWXNwdkUwSGlLZXdHWVpCTmljZk1x?=
 =?utf-8?B?b0hLaThKV0VvZXV3YTc0K2EzTFdPbDNXU0ZiRU1UTDltMXl2YzQ0bFgzNTd6?=
 =?utf-8?B?aWE2ci9SRVFqeldQL0Z5V01OcFZkVlpES3Zmek9oaWh3djBxM2VJWDRvdFZt?=
 =?utf-8?B?UXg0RGkyQk4yVzAvUXBEVEJTVFMrUkVGcDFjMjlIenQ3c2VFeXZtenljNFh2?=
 =?utf-8?B?WlhrWXN3Nlp3UFVBZjZmZE03RDZkNWI4VlJFVjNybmZzV2JoUjF0U21KUFBt?=
 =?utf-8?B?YnRNTTc1anpLbGhqR1hIUk91UjNTS1RsWit3ZzRTa1J5YTdGRytDZm9QeC85?=
 =?utf-8?B?d3R6VmtHZXh4VW1tdUJRR2VFQ0dCc2lkZHBvS3RXdGFNdnFhVnlQVE92Q1gw?=
 =?utf-8?B?cm5YeHI4NVY5UlJIcThzcmlDS0poZWw3MzloMmw0QWdoQ2Y5OU9TdzhVbld4?=
 =?utf-8?B?MFR4d3NLUjMxYkQwdDlpaHR5WnFiWGVRMlFrTmkrTEhINU9kOEg1UnVOemls?=
 =?utf-8?B?YWFETHFET1FidThnSXN0OUlDT0tyTTBLdmxhcG9mdjJXaEd2YkVTelI5TFhw?=
 =?utf-8?B?RHNSL2tpeHltR25TNUNLS0xGWXB1ZU5OQ1pxVFFlZ012bTg5Tk1QZ3NRekt4?=
 =?utf-8?B?c252bEFKZHRHa2VnRWlBTlljTlk3K2FUcWk5RjVMYTVZMFpXZllvM2lIa2wx?=
 =?utf-8?B?L1NWVWV0cUNNaS8xZVpHQnlHMTk4L2RucFIwYi9JejJqVnhQMlI3dUEvdGIv?=
 =?utf-8?B?d25uazhGTlM4TTlLSWRtcFgxOGcxM251YnRjUi83TmgwK3lXcXR5cE0wanRl?=
 =?utf-8?B?QXFsV3o2bzlEL3YrZUlSMFFBRXF1UXpnZ0JVekRRK0hQS0diQ0hwTi9NVnZt?=
 =?utf-8?B?UjUrSVM0VUp3MGUwNjAwYzg3V0ZGV2NNb0h6aEN6b0hNdmJtQnYrd2FtRUdn?=
 =?utf-8?B?Q0E0dm8rbkthbmt1UXIxOEl2ZVh2bStQZXJadTc3SXJZR0IvYkg1ZyswT0xh?=
 =?utf-8?B?ZUFpc0pKR2ppYkRpTGlhMWdhNU8xVkV4ZWlBcVVZOWNmTFFvbWpUaFdHMjJ6?=
 =?utf-8?B?V0VqcktZZE5wTk1UeFhkQWdtMlQwK3NFUUFROTgrMEVxc3UzZ09ISlR2SE1r?=
 =?utf-8?B?ZEV3NEl5WWsvUlRCSmRIOE0vWStnT3Z0bDd0bTdEcno5YXV3cktsdW01a2dq?=
 =?utf-8?B?MWJlZ2gzK3RBYzZjYkN2TFRQSjArZUF1bG92eFprc01oOGQ1WUp3ME5nQTFD?=
 =?utf-8?B?bStkVlh1bDFXUVlkWEo2ek9NVEVlaEp0MjZKT1pCOHR0blVnQS9HS3h2ek56?=
 =?utf-8?B?SEcyRmU3U2gyZis3ZEJTWm5GN0xEVWR4KzBwZUMwYUZxOWk5N0xlVmNSUkJj?=
 =?utf-8?B?R1pNOERLeGZLZzR4K24yUWdNY0JJVUt5dHBnVzJyOVBNYUVUdWlzT3JLQmpw?=
 =?utf-8?B?SE45MXFpNHpiYVE4dkJOSGZFR1JNcXJQbHZWdVVGdnczMkcrMXY2ZzJidEk3?=
 =?utf-8?B?TUNmMUd3ZGMvMTd3OS8zcUFTK29UWllVV2tCdlU1MUxaK0VqRUVwOXdzcGd5?=
 =?utf-8?B?V1pob1dFczJ0OHh6WjlIWWRQN2tPM2p1VjRlV2I4SENLQnZQZzdvOVNGOWM0?=
 =?utf-8?B?cnN2bFZQcWRQVXhUbVNIaFNhdFN1aDdjd2pQQmQ3VXdSSFBCQ1Jja29zdmQz?=
 =?utf-8?B?Q2ZJUHVvdC91Mm5NZWJ5RUdoelYrdjF3Yis0cE15Q1l3dmsvSnFaVFhUcTFl?=
 =?utf-8?B?U1JoMzc2YjM3cG11dFJJakxOSG11ZU94VzJvUDF6UmpYSDdQVWFrdlg1RzEy?=
 =?utf-8?B?TkxyYU8wN2dUR0dZVUw1WnlwMTRXOVBTTGx2RWZYa3F5R09MemkvTDZUdlJp?=
 =?utf-8?B?eUtqZU56b1V4LysxU2JpcjFBbjl2c0tZb3ppNCtLRnVGS29ha2dVN3dnSGRL?=
 =?utf-8?Q?RftKHmH0h1I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2M5ak1qQmkvdGc0clZGQXpRdHJJRVlNZXJUMjFEaGJQV2xpaEltNGlQNHBV?=
 =?utf-8?B?ajhsTUNaQTg2d1FkUENVWDlITlFvMGNzYmtQbEZPb0NpNkVjOTBRekVZUnlR?=
 =?utf-8?B?aUZSUlNPRXdtZlpKN0JpZ1p3ckR1RGNKZzR0OC9oYmpKeit3Z3FWOG5wQzdy?=
 =?utf-8?B?QnpVSXZVaUhRd2k0dlYrbXN4YVJiQ3dkdU1xVk81WUt4UHlwZ0RubUR5Rmk4?=
 =?utf-8?B?dDNJRmlxVFpRL3hBeUUvUWM0dy9DT0kyNzc5Q1VyL2RpbTNXQ1FOV1VLZWVr?=
 =?utf-8?B?MXlKQldWRjczclUwK0RHS1YxVVVYMFNDTHhwbXpobDlCRkw2Z2R1K205d0Iv?=
 =?utf-8?B?ckVPK0ZzUHlHeVNYNGxieWpNN1EvblFqZFJjTzJNMUo4TmREdVJtMVowNXA4?=
 =?utf-8?B?MXJueVJKbEx5T0hFSXExVVZ4dDB6azlMeHRjMmdUeUdRQlk1NzlWNC9jc2d5?=
 =?utf-8?B?QUZROExSVVBxT2hHb1lUeTBiSkd2WWJnMXpXRHFSSXZiajIzNW9sNXZNQlE3?=
 =?utf-8?B?MTBRa1VvRXEyM1VSNDFScHgvc0tDbWl0U08rbnVONEpqOTRNejNROFJmaHZN?=
 =?utf-8?B?TXl1OGZCcEp4bU11R0hzTzJiZzFBeTBodVpodnd1Vnp4TUp4WXpDYVBOdkdN?=
 =?utf-8?B?MldhM1BtVExZQnN6b1RaTlk0cDFXUUJORERGWUN5Q1FlYWpVeUVYSloyaFFQ?=
 =?utf-8?B?SWFnRUFBdjRJL3IyeEZFUmFPMVpiVXhrVU44SjQxV2dLd2dVUjV0Y3JZYlhU?=
 =?utf-8?B?c3M0S0F5cEI4N3RqV3YzdHh5WFZ2RHVJVmVGWFFCK09EVDJGY2NwR3FXVWJF?=
 =?utf-8?B?WDlaOHRsc050R1h3M0szWTlIRURSc1laWTFLVjJqbVJESERMTGdTeGZMRGZF?=
 =?utf-8?B?UmttNHZjZWNURkNBMnREbGZDcW9Rb1NKVWdSWWkrOTY5VnhLSzByTWlmOU8w?=
 =?utf-8?B?U2VzVitZdGt4Z1dEWmRlWkhPMXp0N0NXZWcxRGRHbmd3ZHNFNXJDL2NUb3J5?=
 =?utf-8?B?ejBKWTVNbUZKOGo5a3ErMzNhRTlmQ0FVcHB5YW40K3NzdDU5M3A1N3lBdkNm?=
 =?utf-8?B?b252U1lTRzlzTWdWb2JZRkkyelBubUtobGJHVStXNVo5UEdidFFBVkhVRkJn?=
 =?utf-8?B?YTlNd2NPU3FOVWpoc0EweTNXeDRxcFhCRFNUSW83dE5DMTNycWVpOG9Bc3BU?=
 =?utf-8?B?TVg5NVZzL1lOanBoUTRFUHF1blA4Q3l6eVd6V2NoVy9YVTRBOWR6RGRmbFpQ?=
 =?utf-8?B?aEcvWDFiT1lPTXF4NzhISjd2LzlHcFFqK25qVzk4N1ZQOFY1NlNOWjRrKzlU?=
 =?utf-8?B?dVVqNVZCRXAxUUErTFFsQ0JTUExtUWZ0TEJIZXlLcERyNm81L1ZpZncwbjY2?=
 =?utf-8?B?SWpUMFFwc1J1NmtQTjlaQ3dVWURSNHBqS2t5UDFua05wYlIvaktIZTczTTdw?=
 =?utf-8?B?OW9qdjJDZnlsY2VVZTIwUHlnZnU0QUYxbEl5M1BpUlVXZjEwbjN0VVQzNkNj?=
 =?utf-8?B?Y3gxRDllN1gzc0h5OTdENi9iZldoaW5pNkozMkpRenRnOCtJcjR4ZnJvOE1z?=
 =?utf-8?B?YUJZYTVPRUEvZGwrNU1FS25KNGFzb08rK0djUGJVd0tJbkF6OWcyNzFUYkQ3?=
 =?utf-8?B?RlNoaG0xcld6bkdjUDVSZXpIOW1IcjVvWUJlZ3ViNEp6L0tOTFJkM3BzUjMr?=
 =?utf-8?B?RUxwbDZ3V0RRSFI4NDVvZXczRDRJdGl2R0dMRlEzM284ZjI2TFo0ZXM1L1RZ?=
 =?utf-8?B?ODRYYUtDdzZoQ2FiYlExRjhEYjB5OUxpMXJ1Tk5BRlBVVHpxdDVaSEpVN2wy?=
 =?utf-8?B?Mi9ZUVlGUkR1dWJFUGdmZmlaOHBhaUxQb1d6VVJsMDBDZGVqN3YxUUVNZXhi?=
 =?utf-8?B?UUlTQlhtWlFHdlQ5V09MUHpNSDBJS2N2S0sxeEJPSGJZY2RIQ09kMWpVYk8w?=
 =?utf-8?B?TWpzTTdxOGw0cldLNGN2MHN4SXdMQWp5NUlvRGVhTFZmaW1SS0VTLzdQaU5B?=
 =?utf-8?B?bXAvV0ZQbVNRcjdacHdxSnNCNGRDZXBEZHducGdiWHYxaUdLMlJFd2pzTUMv?=
 =?utf-8?B?V0FnVytRUGNPM3R4UVdQRnp1bURsYWdkYStlalE0YjUyc3lML3NTUU1YSndp?=
 =?utf-8?B?ZERFbTNrazh3NGhMUWQ1Z09kUzJYRGZPQzdnejZqRmQrV08vSWs4RDRCNXE2?=
 =?utf-8?Q?4s6+DodGl4b67M6dJzHyFr2nl1bLItOzq3A0HpEjx9M8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f4e7837-ed0d-4f29-0ef1-08dde3d15d42
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 12:17:31.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUA/MGZiFGgUK1OlARuDxX55ob7EDapmBwL0xniT8wLf3AKZqA+fCzOBZ9+sllxLycyM/Fpcdd3smoE9aFf5uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074

Hi John,

On Fri Aug 22, 2025 at 11:03 AM JST, John Hubbard wrote:
> Allow callers to write Class::STORAGE_SCSI instead of
> bindings::PCI_CLASS_STORAGE_SCSI, for example.
>
> New APIs:
>     Class::STORAGE_SCSI, Class::NETWORK_ETHERNET, etc.
>     Class::as_raw()
>     Class: From<u32> for Class
>     ClassMask: Full, ClassSubclass
>     Device::pci_class()
>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Elle Rhumsaa <elle@weathered-steel.dev>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Just one question about the 16 and 24 bit representations below.

<snip>
> +macro_rules! define_all_pci_classes {
> +    (
> +        $($variant:ident =3D $binding:expr,)+
> +    ) =3D> {
> +
> +        impl Class {
> +            $(
> +                #[allow(missing_docs)]
> +                pub const $variant: Self =3D Self(Self::to_24bit_class($=
binding));
> +            )+
> +        }
> +
> +        /// Convert a raw 24-bit class code value to a `Class`.
> +        impl From<u32> for Class {
> +            fn from(value: u32) -> Self {
> +                match value {
> +                    $(x if x =3D=3D Self::$variant.0 =3D> Self::$variant=
,)+
> +                    _ =3D> Self::UNKNOWN,
> +                }
> +            }

Should we normalize `value` to 24 bits (i.e. call `to_24bit_class`)
before doing the match? The constants we compare against are all
normalized, but if we pass a 16-bit class to this method the result will
be `UNKNOWN`, unless I missed something.

Being able to store a class as either a 16-bit or 24-bit representation
in the same type also opens the door to bugs, which we can avoid if we
always normalize to 24-bit and make the class/subclass representation
accessible through a convenience method only.

> +        }
> +    };
> +}
> +
> +/// Once constructed, a `Class` contains a valid PCI Class code.
> +impl Class {
> +    /// Create a new Class from a raw 24-bit class code.
> +    pub fn new(class_code: u32) -> Self {
> +        Self::from(class_code)
> +    }

Do we need a `new` method when the `From` implementation does exactly
the same thing and has the same signature?


