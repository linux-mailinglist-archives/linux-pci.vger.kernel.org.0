Return-Path: <linux-pci+bounces-37064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDDDBA1F89
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 01:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FAF1C017F1
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 23:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1F12EDD7D;
	Thu, 25 Sep 2025 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="grIqJ7gQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1BF2ECE9F;
	Thu, 25 Sep 2025 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842892; cv=fail; b=IuOjgUm8hWk20EY94X/3kzzVRZR50zThgCbshRsQFZLTTiAmeX7LX6D9LkprzMf5Vk1HuDs1xye4gg83fIq+sOfuLQ8bye6PSVV0lseF6sDEBXi6twlKD9vzDMUyPSSt3yUCnPkpjRnF1KrodUKPAhGB8T6tgita5AecUbDH7xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842892; c=relaxed/simple;
	bh=JtEu61VSAuzVw/Fkb+u9tcQt+z5j9mxs4SiDMShy5ys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R6nv/3X/WRICtuqt0njW4oB5GPXqezDq58F4FkUuFhGGJvZvlSi53BDaHpwFIATIxDfmnHOIk/z/WwxJYDZMcS5WgVYVcF9+j9HU/VFywZBMEqMROLrStGBI5VQPrKiyEBeXVBRiNEWvOkx2it7BBR02dz3r8WymF46oIR8zdI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=grIqJ7gQ; arc=fail smtp.client-ip=40.107.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LN5qpi710AI9gGjS0KRQBW0xqNml+TpxozwerUkEtDS5bXG86pYSUGFn87ObNEG2PK7uwkX00jO+Kix1nT7FtYhrG8aI5zjf4zvoxcPyDgv+uAnllna/UtmleK1iG5dJxgRNS6zVuee2DyxTwRBACQjs7Ds0Uj1OAK1KpFxzHn+HZTlq9mD6MpDso9EzIiTaIifm3FA5619d+YL68w7uz5TTP7OdNXI4yA/25rsGKdyG+womLr8fEBhw7vw1hoh3Z8r9cZQXFr3FiMLtlDlvlKJqgr47MFfI3CsoYBZrhV2ZRAhdwJxUA501WI6kAYoBdRBgCNYzC5StbaHrBiWOnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+f1UsXO8JjPcILcXawwRprU7tecD4a+PwZ4+RzQCEk=;
 b=hgDSHMl0U0r67ZoVf6/jqhuzP6Sr1GHKO62XQ2mE0nNXpo6rkGkzYK4ZKIty1TD/cByY5TGpmo2o0V7kPT/QkUVsmLVXVVRrSIMTT/HzxKSDigmfLLrOZYlgEC+BSMJBFTBazLvUleXbePZH8f5aH3kcN8xrTYWFYIhcuhFcbt+JvoKHk+r2igguEKTxRLBqFTiOTB4LNt1qvzNB3MRQDUD3ZiiLJ41qiaAt1fF2olY7pJYcehI3jEa+Oo7OukmJ7GrPYSGVZiAAgKgOU4icI8Cv3wWiTw0Wb5+aix94A2YtfCw0W4gGX9laLRXGjwNpdix+oTQQMu0K1D64g5KiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+f1UsXO8JjPcILcXawwRprU7tecD4a+PwZ4+RzQCEk=;
 b=grIqJ7gQsMnQfPCCU4J8i8+OSiRLUlEqYqI4ZNTJIMbg4Ro1jyTHsvfQcam74mSd2tHpUWGft5OQB6btQLmw7FSgl9S0vKn+BpW0vM08B6zHhDP27y28/zEyExqO0s0p2V0ypfKK4mQnppXvX+edp4MKOsekiN23HE5/OUGd/R6AOZaXpy1VzCwPTc2pKRAFt48GjS1wr/GVbAdf/SAxGUO5BAuzZru1yZxB5Z4Iu+DE2hOroh2EEXwDsy2XT71ZABbIpVnt5hKcC6pTsSUQhoKQzSe9VSHZcwU+8Ff7OfICkVC6gnzw1l7vCqDOQodu+EcXf34TdyPxt0cLAmywAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by BN7PPFED9549B84.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Thu, 25 Sep
 2025 23:28:07 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 23:28:05 +0000
Message-ID: <d072d771-558d-4939-b046-654ec6318999@nvidia.com>
Date: Thu, 25 Sep 2025 16:28:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rust: pci: display symbolic PCI vendor and class
 names
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
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
References: <20250925013359.414526-1-jhubbard@nvidia.com>
 <DD20C3S0YCK0.25BIXD409WED2@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DD20C3S0YCK0.25BIXD409WED2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::21) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: 73272d4a-d89f-4a19-0b78-08ddfc8b2dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkduSVE0WjZXNFZ4cDg4SjVad3labFRwNC9lMWo1R1hrREhMN2dZazRzQ0VQ?=
 =?utf-8?B?YzNna01kbnYyMFV1dHpGckJOcnl3M3VHY092U3R5MzlTNGV2dmlVMHFIQVEr?=
 =?utf-8?B?eFNvN0tsVE1rOGtJTnlSK0p4R2h2eEd0SzJiWDk5TUs5ZFhPekRYczRBakw2?=
 =?utf-8?B?YnpCOERtNXhTYnlIK3pPRm5PaVRtT3NVUzBSTVh4WWJGOXJsbXJrK1FhQnhY?=
 =?utf-8?B?TW5MbmxBN0hXTlpFdnV0cVpwcW9OTitrbFZGbkZTVGtEUythcDBCemlta1dv?=
 =?utf-8?B?bDl5allCNnJiejR3alVUZ0h4MGJjSE5QWDZDUFkza2lhaGtYMHFHV0t0UVpB?=
 =?utf-8?B?VGJEV2FCOGZhaWNGU2w4dnpBeHd5WEV5cWNRK09WMWg5dm1Jd3lodXBjN0R0?=
 =?utf-8?B?ZXkzYVg2MjBBNVFkY2VZQUFuUFhudktkSmNQaDRwUWVXeUVUaC9tQWFuRmo1?=
 =?utf-8?B?MnpBWitUVXd0bkxGRFg3ZGhheTZCM1JqaFdEU05FaWFPMWtQdk12MUxQREZu?=
 =?utf-8?B?NnZtRTJxU2djbmpOSS9HVzhNcEFpOE1hOElDa1BJRFFQbm9VNXA0QUVHOHVY?=
 =?utf-8?B?ejdCU2lJWjBwNU5xN3lrS0wyR3lIRWkwanJhUnhCZ291U3RYYUtvM3VQSldO?=
 =?utf-8?B?ckxyZFBnakEyT1NmQzZLMGpLVGE3MVRCZUNkNWxHMFZvbE5oaENiTDRkWWp0?=
 =?utf-8?B?VlFGbGdncTFiQmxSWkQvVzFmcDhLZk1Bb3dVN1J6Nkp2UEdhYnEvMnZTM2R1?=
 =?utf-8?B?b0xJS0ZHMjZwY2szVEkrcnNtaHFNNG5sZjJVeUpvQmdYUHoySlBUcW1WdDBk?=
 =?utf-8?B?eG81YmJnQm81V1pzeWZ5VEswVmNybjY1Zm9vS0pBRzh5SkhIRVpwQzJqRElx?=
 =?utf-8?B?UmdvbG1QWEFTMFhiL2p5WUdZRFk4d1dVd1FkQXQ3WnRHc25VUzNwdW9yVVpx?=
 =?utf-8?B?Vm1HaVBYOTArRHN5WkF4N29pZjZQWlRqZHJqMDEyN0ZQNjY4aDRLbi9KVnFi?=
 =?utf-8?B?MENwU0N3V0RRd29ZNldsdE1VYngwVk5xcnpmVklyWGorTXE0aWtXRXgrWC93?=
 =?utf-8?B?Zlk3TWNtL05CQjlwdkcxeURUSTNQdUNCSUVGVGljMlRmWnp1VmhTejhoRCtV?=
 =?utf-8?B?MVJlUTliWXdDRnRZU0dlbVBBc284OVJNakZDbC9ZY2ZsNEFJempxQ3hHaXBK?=
 =?utf-8?B?RUZucXJhOEVDY0RqQkdHUlRIVXVLK05MT3IyRWpDZ1VNTnM4VWZHRFdham9N?=
 =?utf-8?B?VnhRZDhpRVRNR0pQZENnanVxSVpHL3RwU1V3NWVGQnJKWVFoWHlyRkl2cGs2?=
 =?utf-8?B?enZ6ZUE1NmF5SHlHeUpwVjNTbWMxZmR6eEpLUDZrOFg3b1pua1VqT0xDaGJ5?=
 =?utf-8?B?SEpFeEo4dzdVMHNmWUd4dDdJUDYyRnBLSWl0VXdDeFJPNERiUzVnN21YK2Yv?=
 =?utf-8?B?dHp2WHlldjA0RmtScEJGNHdKWDU0bDE3SWV2UWJtTVpPcTFxRlR5bTd3RjhO?=
 =?utf-8?B?eG5QNTZ5dXhRVGhRcWZrWVJ0ZFNOWjRiZC9EMTR1NSsvOTVicEpGQnduamFE?=
 =?utf-8?B?UDdQL3R2K2FsQnZSSVcvNmZ0K296NTJOdnBQdFlKK1JEeVlXNkJXN0pwWFpC?=
 =?utf-8?B?ZHozU2IyeGtocWhKQmFNdDFaaVJMNzlKcUhlQWI0Y2M1TUdBcjJlV3hyLzEz?=
 =?utf-8?B?a2tCWUMxM1hndzZ2dG0zbTZSZmxjSnFITnE0SnZvV0dDMmFxNnplZkhlc0N6?=
 =?utf-8?B?SXJvTUNaQlJkak1DT3BIeStyeXdxRjJ6Uk1xcndRVmxPRlVESTBkdDhuY005?=
 =?utf-8?B?R2NLRWQ0Tk5VK0dEYkdWMFIyUDRJK2NlMGhaV2xFWjhoWmU1eWNlSEZoSjVB?=
 =?utf-8?B?QWV1RmQrQUlxVFNqVHFKbUZMakZUMzkwMXNaQVFlTlEvUStHTWJwRXI3bm9s?=
 =?utf-8?Q?xmLzEm2l0a0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWp2OU5aeDFqdUh5Q0Q5eE5oRzBETFg1MTFSR0VTZ2hWdnlOQnJMUi9BTzJj?=
 =?utf-8?B?UGJtbXBzcU9hNzFEeGdVWklIL2EzcVo0U0xPMlpMYUlCZkV6bjlHcU1XcFoz?=
 =?utf-8?B?dzhBSkVWSTRDa1lsbnM0em9CRlhNN2htU1hYN0VJZzlDdkpHKzJhZG5lZGdL?=
 =?utf-8?B?VlJrNkVrVUNuQUptdFhGcWJNSWp1OG5MU1RDS1IyWlVtc0p0RmU1RFhZUWZi?=
 =?utf-8?B?TzVTMjlEd2hXK1JFbXpmdDM4aUhJbC9yVlowUFdsV0hveDZqaStSOWg5R3ho?=
 =?utf-8?B?NThYQi95Vmh5Wm9XaEdyMnU1ZmU1MTRaUDVxdjRLRGRnTW1QVEFJKzdpQVNs?=
 =?utf-8?B?VGJYb1pzU0d6WE5OdVFFc0dob0hDWlRBcFo5WlJxQ3J0MTRGNUt5d2pFYm5D?=
 =?utf-8?B?ZzB5NExFYmZNQnVtTnZtdzJxczkwQ01KRnRQVXpjS3daRDFWdFdDZ09SbmRj?=
 =?utf-8?B?cmRqTm16Ry92NHdVTW1PeFRxNHY0WmJ1T2MwMzhKOWIrZHkvVU8zL1ZiUjFu?=
 =?utf-8?B?TlJ4REdYdUllTVhqaVN3WjVnUGd4Wjh4aW4weXdkYjdHcUNlSW5BK1k2ZTQ4?=
 =?utf-8?B?T3VFUTBGZXlpYmZvbVpKSVZ6MUszam1sb0tSNFdoOWF3VWxjWGJNRzBvcTA0?=
 =?utf-8?B?YkNPQmpyWGV6QVVJaTVvQmE4Si9JSHB4ZTFqbHpScXVQZFQrR0VJL0ZQRHJL?=
 =?utf-8?B?bFVKcWJhSDgzQnNQTmg0ZllQRCtWbXNNdkdkMTJVeVJDbDVjMnc5ZG9sNGxQ?=
 =?utf-8?B?WVdQMDFWbVVEcmhiZE81eTcxOEE2a3B6UnpnUGt1ZzNYNlpNb2NNY2U1eHh2?=
 =?utf-8?B?aU1RNmRwQUJ2RmJ5NG9VZnVvaVV2NmtORnArNUJ3YVZ2SHFkcmJ0RHhsYjZJ?=
 =?utf-8?B?VFh0N01nSFd3eFRYNnJ5Q0hFWk1YdzVycUEveXRVdWt1TVFacGZyWFBYa25C?=
 =?utf-8?B?MEkxcGR1ZkMweFFuQkEyelJTd2JleGZVSnl4elZKd21nai9Hams2c01pakVR?=
 =?utf-8?B?V3lZWnhsSFZIYmhZWnFTRFF6WTh6UDM2aUZOZzVvVEhiTExLQWtpSnZMNFEz?=
 =?utf-8?B?RGNOMUNVRlAxN0FKZnI1V3dRbkhRSVhXdTI0OXpjei93Wms2WGFBS09lcEdZ?=
 =?utf-8?B?eTNlSnNvMzZFN3NZVUNzcWx2dE14QVNEaGNHTE16REJ3ZWFOTWQrT241WjZ6?=
 =?utf-8?B?aGUra1hRK0tIenpWNXVYQkZLRWR0Vlp6V0xKUTBkaGI5akZVbTZaaSt5N3Bi?=
 =?utf-8?B?cVdSQ1A0YU9CRkZSOHR4NVhhaFEwWlJKWlNSV0dLV1YzcTJCV0MvcmZiZDB4?=
 =?utf-8?B?c3lvL0NGZXFKTlU0LzlCOWpKL25Dd2lOR2kwdStGSGRBcE1qbVBpUDkzemE1?=
 =?utf-8?B?SzliMTlVa0tkczl2YW11cDgvT3pzWnlnUGF4OW4xcEQ3RGFKbDVobHM0U0Vx?=
 =?utf-8?B?TW14eEtMV01DUW5TN3pWNWhRUHROUXgxQWs0WmdzUDBFNVQ5ZkJtUTUvNEUy?=
 =?utf-8?B?d21HYnp2bmJtdVVqcTFpMEMrUkl1NmZUVFZPWUZGdW1DQXl1emZhSDQ2dkVi?=
 =?utf-8?B?aU9zZFNZeFpYT2lEblhidkxrK3JIQjRpSERyeW43S295ZmJjamc2RmpVNFFB?=
 =?utf-8?B?Z2lDS3ZhZmQ3V3lOOS9GNFJ2dXl2citXdkZ5cUsxekV0akIxQkNJSSt0RWli?=
 =?utf-8?B?R1BWRU0xL3d0OEpoa29oWFpQY0dsVkdTVlF1bGdEM1B3bmUyZW1BQTdzYjdn?=
 =?utf-8?B?My8yb2hHaG96TXhyeEpNVWUrWEdhdGRqNWRNTE0xNmVjQStZU0syNmswOUcw?=
 =?utf-8?B?S1o3bVZHQ3gzU3RZejdEOERoVGxFQk0xTGRsV2YycE9oRkxRKzRWRXVOaUhF?=
 =?utf-8?B?VGE0MWhxMXpIdlVsOFBscENqUDBPVWhWbWVNZGZNRXhqNXFjYU5nUTREbjVv?=
 =?utf-8?B?RTgreHVXSTZDQ01QUTh0azJDcTJSSWpEQzcyMEhxeWkxUUd2aUxaTDJSSDRS?=
 =?utf-8?B?TFVsRVVmRytjdFBQV0tlVTFXT0ZrdXYxL3U1OGU2aFY4QUw3NWg5OUNiZ2ZN?=
 =?utf-8?B?Wm5BUG5JRG5FWi9ZMWNQUi9JOG5FU1pIcUZlSnp6Qk9XQ2dmZHltSTRWbERp?=
 =?utf-8?Q?nyg07du31pyKSyKKJLv0dTRDU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73272d4a-d89f-4a19-0b78-08ddfc8b2dbf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 23:28:05.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIrG+j2hVs5BoF9BbFUwbLvLGOwm1ssO2wCnqRz6KlgjqKrEk3drvK8/kJRsMG1zw6D2/aoMMKUIgAo168KK2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84

On 9/25/25 9:04 AM, Danilo Krummrich wrote:
> On Thu Sep 25, 2025 at 3:33 AM CEST, John Hubbard wrote:
>> This applies to:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
> 
> This is an old tree, the new one is:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/

OK, I'll update my setups for that.

> 
>> John Hubbard (2):
> 
> Applied to driver-core-testing, thanks!
> 
>>   rust: pci: display symbolic PCI class names
>>   rust: pci: display symbolic PCI vendor names
> 
>     [ Remove #[inline] for Vendor::fmt(). - Danilo ]

Great, thanks!


--John Hubbard


