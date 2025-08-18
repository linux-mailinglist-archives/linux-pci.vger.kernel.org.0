Return-Path: <linux-pci+bounces-34222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1932AB2B0DB
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 20:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC1918880D8
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAB7272E67;
	Mon, 18 Aug 2025 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uuo/pMM5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD01D9663;
	Mon, 18 Aug 2025 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542990; cv=fail; b=asLM1wmERZzhB8Dt+LEOeh6ZA3Hb1vkgCUix3XD8MruJPt3vozSmSvYtOAhcoO91CTmJu7sswzUrrqE5Ufq0KGmXNcISSYudq/9t8CTfTu0+lkT5HGbIUPK8S2QIcLPJyY9gf79pqKkZ8WN7O+OvF7io5cHeN4u2hwZZEtqtqTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542990; c=relaxed/simple;
	bh=pTBTOGmcSByTTSCFzqGE678O0J8u9t98qnYhFY+ZRFQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jocrlnJHH45GkGuN1UR4wribH+gKQQfznxEsk53zTUBvN60ivGh6wEnR6ZkD1gru0dSB8typ9nbxaxNgcSdf8WzerTMekGwglFWbR71r6tL03lIaLmOhb9y4fEosEV6W313hfqABDdSw0JiAajKs3BoYUc4zgoEmuJQ00YyCS+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uuo/pMM5; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S71LCfVvyCMM1wSxIMufNSKE1mHaHkp4HW4orDJ85XN8vVs3UfJQn7UQpq/OLnx3XlP4PgoBkHb3JEEJ6rleB9rvS3zqg1hziGNkwTXc/5wOma4MgBf2Uzxket/RDHx+BeRnHhojTlgKv/8+gw6N0K5v08llhQ+BLfJeNdHbRDebatqFoxqtKS9CZsA1pmSNQ0ikG6LRnpy79PEFpkIkTizX4d2q953kLxPaaXcFxwk4NGd9ndIig/34YJFom7Mfj4gEsy9ZDhz0dVTDpL68cUTP/ra/URCNTgiLyvFpcT2i6BvlEsqZZIeGz9GHbL75bOYOSXcDBNjfofrQDFg82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBTZz04MhNMZF7Yqc8yI9w8lUJcwkGpwu72sXXzKlt4=;
 b=ZAJvqOUcILWPf5kQU1WvBvXQ6uNny/3jDHv5a9MX9I9sAETqa0/TodNgMPpQxg5PTmYLLGHFnnQyVr1o9bk4i+nFTaDEEXFfr/9+9lOinokzxSIg7PyTQqkzx2+oeM5QYo60vpG40cPRvSSoxluFxIxNC/JmvQ8VXBBAalNVg6G0tP3HlMyYaD9VInA8biK5oWSmtGTtsXS80uOZzX1jIAaWgyva8bw2TlPXnsW4SBxcpRQSyoFCRXJ5+GhuH+UEbbH+4cmAKti7FOLkts0IRlCjhOH6EKzyjOZ+Gvz55QycYnj9AUGbnvpIbsUtsO7LVJD5tD2MCcFtMmAVymk3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBTZz04MhNMZF7Yqc8yI9w8lUJcwkGpwu72sXXzKlt4=;
 b=Uuo/pMM5Mn4cmQ10J1x20sFNAl/+SxFFtfZwfbwL0adfqF6KSPx0dIi7K6YAmf0dZC/RmN9h0q1NiKiQC1Kixbyf7sp2fZ5ulllSyGmpv5J/QqzY//v9VsooTR+iL3qQSPoIHDYIIZvQpiC+fDWpPYVTo1zbpLXxlKMpOs7rWWqcKRvBuJg4RxSHJETqTmAX9MRCKtmjbzeJSoPJpEB1lIjJY9HcEI5D2a3PwncKaMvEDe6R84zPz0giBxbulY5JoI6W09hZYmJ98tTYW+kMEmAduORtniAAaXNTHJD/1CbxFz7sxrrMx26JmQNWXrAqzDyRz6wToev5wNQt9xYoSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 18:49:46 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 18:49:46 +0000
Message-ID: <a82172da-a029-4208-b92d-e68320ed31f4@nvidia.com>
Date: Mon, 18 Aug 2025 11:49:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rust: pci: provide access to PCI Class, subclass,
 implementation values
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250818013305.1089446-1-jhubbard@nvidia.com>
 <20250818013305.1089446-2-jhubbard@nvidia.com>
 <DC5JTQ7VHA65.2SNDMXYIKB9GO@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DC5JTQ7VHA65.2SNDMXYIKB9GO@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0015.prod.exchangelabs.com (2603:10b6:a02:80::28)
 To LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: cee786ad-b193-4413-14b0-08ddde880065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWdMUjR6Zi9TejFCbzdpekZ4MlI5U0x6aTRiVDZiRDFpYzJzMFowbmFkOHVK?=
 =?utf-8?B?bXZOMUU1b2xHcEpnRmNHK0NnMGRDa28rY3V6SGc1S3JtM252elAyczBYQmdX?=
 =?utf-8?B?RllHNjJCWGorcEZWYU91K3B6dmZ4MURZQXBQZk5XMDMrTUdyVGtJUFJCenQz?=
 =?utf-8?B?U01qVE5lVytDdHlNc0pXOS9WbHJYOGhWNHZnSC9aT3BXSGk5dkZqcXhwS1Fj?=
 =?utf-8?B?Q044Ukxiai9EeHZIN1JtckVIUTJDMm9uMUZVUERiSU9Wc3JjaGN0bDREMW0v?=
 =?utf-8?B?NXAvSFpJSmNVbE9BYWU1UUdYS2M2RGs1VGFLem1HN2ptR3M5cWVKQTBtWHpu?=
 =?utf-8?B?TlJBZkdwS2RRR1B2a01kdHMxdE1EcUtoK3Fxc01DN3hRMU5lczBYT2NoRFox?=
 =?utf-8?B?VmJPWnJYZEl5ZlVJclN4NDZCaFZaTUlEWkc5VHNqRjNRR3JZOHJDRVU5emRX?=
 =?utf-8?B?bExjMFl6dEJZdzQ1YlZQNXB6N1RQWURsL1dwR3NDQnFNVnI4bVNYeitVd0xw?=
 =?utf-8?B?bHRYMWpQUkFyY08yb1VrbXhvVHlvR3JtMDN3N1VybWw4RkFsZWgwNCs5OVlJ?=
 =?utf-8?B?Q0RuZ3VzYWUzSVpKT3R0cC9jVnplakMyZ21EVXFiZGs0RlVLMkNLU3EvVWNN?=
 =?utf-8?B?Q3o5bWN4MUM2amxMSkw2Ni9MNW1yVGVCeW8rZHdiRDBzdjlGQmdQaDM4L2Nj?=
 =?utf-8?B?VUxMZ0Rmc3NCTnVOdzBFU1RIVWswTGVya2JOSExLbFFFSFhvQzhIK01YS293?=
 =?utf-8?B?b1lERU5NYTI5UkppWEtINVZaMVJOT2l3Mk85bVhGaGdzcXk4a005aUVQZENn?=
 =?utf-8?B?K0VEazVza2lHOTEyUWErRGJnd0wrYi9jN1NjTGI3V3BsS0Q5TVkrVDI2SCtE?=
 =?utf-8?B?OXFsb1JUcGlrSU1sQ1FGVW15K3J4dnVoYWVqSUdVVW1ibE9CNWxCYWNScmQx?=
 =?utf-8?B?R1BZYytqalA4ODRya3ovWHQ4ZEtJdGlNK3owai9uUnJsYnB1aklCeWdobjZp?=
 =?utf-8?B?dTU1L1htVnk5bzNKQ2djRXlnTlJya0xnb0pWWWFvU1hvYUFwYUVCVm1IK3Ay?=
 =?utf-8?B?R2dTZmI3c01LRERNaUZDN1habFdRZXYrQ2R2SnV2TnlKMEQ4MmJCNHRmdDVO?=
 =?utf-8?B?bVlmWjBQZ2I3V21iZnBvYm1wOWR6MkhqeWtYU2Jkd3d0cjNkSER1dVQ5NTVO?=
 =?utf-8?B?RXFVV21TTENTMGZEOXVXZGJkTWNDQzV0TGV6UVVMVENpUGkzNXN3M1RzUzVp?=
 =?utf-8?B?YVVVNnpIWDlCRGVId1AwL0F6SmxPTXBXOFRsWnJmS3pqVTlGWFlIeXNyN2Zi?=
 =?utf-8?B?aGZQYzRENnhYNEd4K0Z4d2pvT2VSUUsyd1VWSDdjK1F2TXE4T2hCMWgycmRI?=
 =?utf-8?B?TU10Rkx1aUlmZzhzS2pHbHJwTUxxOU9YM1dKYlY1TXhNNkJVWU1naWlLZ1BC?=
 =?utf-8?B?ZzZ3UTlqZkt6eTFrWUJNb0xxOWdzL0RadXc1OEJ5S0h5N2FiU0hoYUt5aEZq?=
 =?utf-8?B?SWYxckdpS1J3QlJ0R25CSi9Wb3hHdmtaWlUwK1ZTLzFhck5id1dtSkNXcjc3?=
 =?utf-8?B?SU93R1ZXL2EwaDJCNkFZY2ZiUS9yZ05yNUNYaGxIOGdzdEVwSjZQWTkyT0hF?=
 =?utf-8?B?ZnArVzRINU9vbWFjM0U4dFJlcjVzQ0lyT01EZFBzK3RkeE82NE01VjRseE1E?=
 =?utf-8?B?aXZxQ0NKS1podTgzT3QvZ0pORDRrNjR3UE05ZWRMS2NsRzhvS29wcDVpRGxq?=
 =?utf-8?B?U1p0K1FiU01aZStoYXlnMVhOY0xRV09KeDdQUzhIQ3BvbjhYem5vS3JkWVhO?=
 =?utf-8?B?SkhkL3p3SDhYZGs1YWtZL3dIZ2FXeW0wUzBMRUU0T2MzZmxLTEdhdm9sTTJu?=
 =?utf-8?B?c2l2YUk2cS9kZ2NUWkFxRENCUSsvL1hxRGZHZTZDRHNRT05UVExibHgyVkow?=
 =?utf-8?Q?PloQVwOD7+c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDZud1BhdWR6dkxBQTh1RTRqRTc3djJBSHZteGFEZUdSUlJLdTEwWE55YWhR?=
 =?utf-8?B?aGdscTgvVFR3Q0lYNTZWN1VkV2NXWDg1MEZsUEhYME5HSUhiS21jSEFNZlNv?=
 =?utf-8?B?WEpyNi96cUJ4S21KSVR1Ukh0R2dQMy9ZTmM5dGJScVFXVWY4WUhiZnhrNnVX?=
 =?utf-8?B?ZWduMmI0bGg2Y2pBUVIvTUl5dGV0ZzRxWGpBREJaWDN4N0h1R0t2NjNCU2dG?=
 =?utf-8?B?Y2NLZ1doR3JrVm50MlVpdzNQSk03cTB1RjlYN1FMcEMvN0d6eVY1Y2ZXV3Fr?=
 =?utf-8?B?MHdwUVBTUTluMXJaYm4zODJJWEk0aG9JNnhIbGFUNnRDWTdjb3VCbHhqK1Fs?=
 =?utf-8?B?SG54c1NjTjU5UytLK002RndvWWhQT1Z0LzhtZ0hLQUc1Z1J3Zmk5dkNtc1BZ?=
 =?utf-8?B?MXh2ZnZmcDFGNVh6QWJ3MjRlY0RXd2psT0xIR3lNQmJGelJPZEhYbCtrRDMv?=
 =?utf-8?B?LytDYUFYUWdHdCtnZldubEUzeDk1SHdRbDRzN01SQUExVnY2UUJTYysyQjc3?=
 =?utf-8?B?ZTk0L2ZqeU5xVkJRalYzK2hxVkRvWjdYNDB6bUJsQVhHTk9IeWZ4d2RMKzJN?=
 =?utf-8?B?elZSY1gzV2VKR0dtNldUM2pDZ2h3a1BFRm4vTU1PdXJ0Ylg5TlhQangwb2Fp?=
 =?utf-8?B?SElJVG5zTWVBR1NETUdtM05GVkxmelJYNDVRM0lMTVdJUkZkZGk1OUlvZnBr?=
 =?utf-8?B?STM5NzBnZE1kZ1ZZUUcxTnZjVHN0OVdGOE1QZWRwRTBDVk0xbXVQZTJNV3Bl?=
 =?utf-8?B?aS8vT0ZEZnBJYXZ1OVdQZkNqSUJIcUhveGZGajVmOWh1eU56cDZrcXV4M2or?=
 =?utf-8?B?ay8wSTJvZXNFQzBSWmdOREYvZG43K1IwSjRtVFhNanVYaGh5M05mRmVFWUxW?=
 =?utf-8?B?SEFpWGFweEdaYTlDZHNsaE5uWTNpSm5aODhwYnE2TUJzNzk1RC9ZREdnM0x1?=
 =?utf-8?B?ZVppZU9tUis3UHBXUXdDU3BtMkx3dHlVK0R3SUtCcmVHY1l0ZTk2bnhlbmU5?=
 =?utf-8?B?UjNDYjJYeVM5Q1ludDgxMndvaXM1VjM2RTRjV3JkNGRlcm5FWVFSbGVEMVBs?=
 =?utf-8?B?anpJcmFwTlMxVXNvZHdEOUduVlBCSEhwNnN3MzQ4TlVXUjhVK1ZoeTVDRnBy?=
 =?utf-8?B?WnhsYmdUbE04NlJwWVRTRVNZNzNPRlBlRmtXbXFUTzZ4U1Vmc01CN3RkaURu?=
 =?utf-8?B?YnNabE4zQ3UxOFdFSzhjS3l0RVZvcFFLUUNCMjdSRFZzaUUxVE0xTHBtV3hC?=
 =?utf-8?B?SXc5ZDRRRXY2VWlLd3phZzBJR1c0RER4clV4M0lRYTRmekFhTmg2cmpDZEhF?=
 =?utf-8?B?ZmJuVmdYVityOVQ4Um1ZWUNXMW5JQm56RUFobC9PeG50NE9ZQk1ZUGVpVmVW?=
 =?utf-8?B?R2J4a21lRnFOM3BLN3haS3AzZkdOZDRwaFEyLzRrZDdZdDJta1Z1U0NoK3lJ?=
 =?utf-8?B?VEZhc2xCRnJzSHREL1kxaWJoSDdZRFUwbXJOcExhWkd0NWM4dDRWTThYOVFk?=
 =?utf-8?B?RWJNREFTSWdIMWZldGluQnRIQzlsSE9pSnJzeFBPdGVweXRwV3ZoWDJGNm5q?=
 =?utf-8?B?ak1SV2ZzYStXRWFrNGkzN1BqaGNWV0NNeC9ld3c1MnNJY29ZelFYbWpOU0Yv?=
 =?utf-8?B?RnpUcVNJRUNoQytLeEJHd1RpRHVuVG9JeW1LcTBzaUgzaXk4MkdmK2xQQ21M?=
 =?utf-8?B?cHl5OWpFUTl0N1dLbW4wc0g3TmIzZW9KY0RqdmVTV2s2dDhIcmhsTi9VUFE0?=
 =?utf-8?B?T0FOOHJOZGVXb2RUK1VWN05uS0tlRGtDWjhmK0FzQVVwMjBaYXJWTnNjMzYx?=
 =?utf-8?B?TXhtK2FvamtHaFVVZEhPaTVRZSt1ZVBLQklBSlQ2U0hmaWpMV1B0andKZU95?=
 =?utf-8?B?QTQ0Zk5sMFVrc010cnhaQVg2YXZuaTJ3d3FsaFc4WFk1VTB1RThoZjcrUmNh?=
 =?utf-8?B?WkgwSUUzcEVmeXo2Q0NOSmJYRVpVV3hqNzJRLytwK2JaUEl3UHFSQVIwbUFl?=
 =?utf-8?B?MUFEcGJnMkhSTGhrcXRmalR2VkhHWEFMaEo0UXUyNmhGdUNxVjN4UGV0QVBm?=
 =?utf-8?B?SkR1dkJWWmsxLzIxaVhoYngxR1dMMnc5dUtYQmM2Q1g1UjVEYWFPUHh0QWdo?=
 =?utf-8?Q?Pv0sFiE67bspSl9WZT+h5sEza?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee786ad-b193-4413-14b0-08ddde880065
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:49:46.1864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUlZisgMddTmeSPJlamikfPoLzGSPGlv/wZwPuuPDHmcHZo633TTrke5VbsHQ1QnewekQgNtPyngpJl8Fs0eAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506

On 8/18/25 5:23 AM, Alexandre Courbot wrote:
> On Mon Aug 18, 2025 at 10:33 AM JST, John Hubbard wrote:
...
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> index 887ee611b553..9caa1d342d52 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
>> @@ -23,6 +23,179 @@
>>  };
>>  use kernel::prelude::*;
>>  
>> +macro_rules! define_all_pci_classes {
>> +    (
>> +        $($variant:ident = $binding:expr,)+
>> +    ) => {
>> +        /// Converts a PCI class constant to 24-bit format.
>> +        ///
>> +        /// Many device drivers use only the upper 16 bits (base class and subclass), but some
>> +        /// use the full 24 bits. In order to support both cases, store the class code as a 24-bit
>> +        /// value, where 16-bit values are shifted up 8 bits.
>> +        const fn to_24bit_class(val: u32) -> u32 {
>> +            if val > 0xFFFF { val } else { val << 8 }
>> +        }
> 
> This convenience function doesn't look like it needs to be defined
> inside the macro.
> 
>> +
>> +        /// PCI device class codes.
>> +        ///
>> +        /// Each entry contains the full 24-bit PCI class code (base class in bits 23-16, subclass
>> +        /// in bits 15-8, programming interface in bits 7-0).
>> +        ///
>> +        #[derive(Debug, Clone, Copy, PartialEq, Eq)]
>> +        #[repr(transparent)]
>> +        pub struct Class(u32);
> 
> Same for this struct.
> 
>> +
>> +        impl Class {
>> +            $(
>> +                #[allow(missing_docs)]
>> +                pub const $variant: Self = Self(to_24bit_class($binding));
>> +            )+
> 
> This obviously needs to be part of the macro...
> 
>> +
>> +            /// Match the full class code.
>> +            pub const MASK_FULL: u32 = 0xffffff;
>> +
>> +            /// Match the upper 16 bits of the class code (base class and subclass only).
>> +            pub const MASK_CLASS_SUBCLASS: u32 = 0xffff00;
> 
> But these two definitions (and `as_u32` below) can again be part of
> their own impl block outside of it.
> 
>> +
>> +            /// Create a `Class` from the raw class code value, or `None` if the value doesn't
>> +            /// match any known class.
>> +            pub fn from_u32(value: u32) -> Option<Self> {
>> +                match value {
>> +                    $(x if x == Self::$variant.0 => Some(Self::$variant),)+
>> +                    _ => None,
>> +                }
>> +            }
>> +
>> +            /// Get the raw 24-bit class code value.
>> +            pub const fn as_u32(self) -> u32 {
>> +                self.0
>> +            }
>> +        }
> 
> So I believe that if you move the declarations that do not depend on the
> macro parameters outside of if, the macro's body could be limited to the
> following:
> 
>        impl Class {
>            $(
>                #[allow(missing_docs)]
>                pub const $variant: Self = Self(to_24bit_class($binding));
>            )+
> 
>            /// Create a `Class` from the raw class code value, or `None` if the value doesn't
>            /// match any known class.
>            pub fn from_u32(value: u32) -> Option<Self> {
>                match value {
>                    $(x if x == Self::$variant.0 => Some(Self::$variant),)+
>                    _ => None,
>                }
>            }
> 
> Shorter macros are generally considered better. :)

All of the above comments make sense, I'll make those changes. Thanks for the
review!

thanks,
-- 
John Hubbard


