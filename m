Return-Path: <linux-pci+bounces-34224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A15B2B119
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 21:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4AA1965261
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 19:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386293451AD;
	Mon, 18 Aug 2025 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VtC4nKt1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841473451A5;
	Mon, 18 Aug 2025 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543593; cv=fail; b=PJ/NEy1kjLf1fm8jo4EjcqStgiYnkTA8klEY7O2TYwpuWP0gZm+pOZM8p2cYxe/Ul/X4bHMDYsYj/hhSRSFZPKiWQHOHA8+3KiZZeOnaujNNRtrw0RiDQUSZK+b9W/jPZMhhy0QnM0V+SRMdk2zce+aNpy+rWhtc4JBFb5I9Q9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543593; c=relaxed/simple;
	bh=wMHmD/pPv1kfDEef2ZgOyWdpC5HaVJH5bm96JvQNl2M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iK0fP8R5zKlklYzaMKUK864Mv/plbCaFiZzliMPwelpVBH5g3KNGZgahDDdOQmGc1TG/l8lZvkS6ZIqXTDM0dlzRkwwzpWenfMvU6XewqUDJMvEpyj31FmfpYnO77DlLiOZSQxv00yJcJluGiQ/xmDtmY9tBirRAXn6+WGC8LJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VtC4nKt1; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPLGZ+swURGPXzhpIlnMWKKmJxV/Nz4GsHMvivILGX5gCVvRJi3znMwXQVQm5aYET2W0zZI9saWg4NZsyh9EZOluXn6xEANmvSWGEqKwjW1r+6qT7xNqnXFEtTFyeic6bqQ03ciwi7SKdq+izyySyernDfUJ4ggZIawM+iXeikzSH/32WFvyl6oQyILo3uQCmL5LH8hkXgkxGdlll0WBFnZ4JJeJBi+d5qrPmqY1XxnXfX9B2pgA34qfgTCGNGWPsLB+APlJ7O1HpIs38ErsG25XeRSb621JaX0Jgic7DDRAfhqlFgEo8G7uSV7wp0ySY4OKi6e21OIWdk7uwnKYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddiJg0znRtTjv8mSJUQYjwuhkQVN2YIG5y7KbFwVLyQ=;
 b=jt3yyg1JzpqyQsPaQo62p3Od6wGdmsSnbYV7fHbfKYcy0CGa2seejAeteSMl9Y89V1CZPX88lEj8V4viUbrqbw3rdPz1/lSHr8/ArfmRzdsG2PC1KQaTJ/OhG8DufhAnTuMKn26yvWIdtb9HW+nIV49dRsJGnLAHpVnplj46sCnv1pEZVdV9kLLFYz3fo/DM+QYpzzLOlyEo0dG12qPZU5Dc8jmJ9cPJvX/eCrGzK4BWf6Klf7Wl0h2xR42QurXj+p3m9s7ayo+RE/OX/d+Ec68S4bT5Ed0y/h7TxJupzOSjrh5f2PMwtD/v8HZlUs1Gx8ePb0JEdWw6tWoSeA8+Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddiJg0znRtTjv8mSJUQYjwuhkQVN2YIG5y7KbFwVLyQ=;
 b=VtC4nKt1Pnn/cgt2gucYVFkuDpLqbYHhlyeSIkAt888GtRRZ6JmTXqUTg/7sRgKAsqfGGe90kzBl0TF6UKCbEE+7+ho3W77fjTDdyOkYObVqKQqzHkCeBZK1Xjg0fJcziS9aZ7xb7oVBajYaLgE/4yUvYG1pPFS/7pJQ4266LEp25Iia9LVAMO3mEGMaQAiz3Rc4aYMqaFtraE4jiGlSle/IcbxuzA3lCgFdRC5U4Z1rS/T2m6IUfv7z+FPvp2rjygO7l52NNJ8faCRBUalwoYmcTSlI5NCV01djVDYeOfsXJz9aAe/m1ttIG25NuegbuPeJD4OnxAyme1uvhav+qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 18:59:49 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 18:59:49 +0000
Message-ID: <b9728ddd-58ca-499b-8f15-925573377c21@nvidia.com>
Date: Mon, 18 Aug 2025 11:59:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] rust: pci: provide access to PCI Vendor values
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
References: <20250818013305.1089446-1-jhubbard@nvidia.com>
 <20250818013305.1089446-4-jhubbard@nvidia.com>
 <DC5OKZHPTDWC.L6YD327Z0WJN@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DC5OKZHPTDWC.L6YD327Z0WJN@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0190.namprd05.prod.outlook.com
 (2603:10b6:a03:330::15) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 3adb119c-024d-4aeb-eb6b-08ddde8967d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3JUZUZGcnhZY2kwNk45eXYrT2kzWnhCSklPNktNRm54Q0x0Q1JrMTMrNkFs?=
 =?utf-8?B?ai9FWkgwcmdFMms3LzlaOUFoclBSTEVybUpXdVZoTFBMUlJ5OTZxcWMrMTdP?=
 =?utf-8?B?aWN3QzFtVkJWUHNHTWxjRk8wcHB5WDdIVGtBTHVnVDBlVTE2WFNOSVJkUHEr?=
 =?utf-8?B?MkFwbDJNTFNnM2JrUE1nbVZTSjZ2dTVEYnJrNnAwYldBMXowZ0dEQkwwanNJ?=
 =?utf-8?B?a094VWJvU2hac0tnWlNpN1l5UUVvQ0VDbGxjdnZHSVl4Mmlwd2FlSGVOamw0?=
 =?utf-8?B?Q0xBbytRVDFWdS9pdFExUUg5RENYK0kyem5adlBUU1JoTUYxZlcrandidWVr?=
 =?utf-8?B?Nm04WDc3ajhkSEVLV09welJENjhLdmJrQUl0Z2ZwVXpoaDJ5Ym1tS0lyV2Fm?=
 =?utf-8?B?enZFd0VNaTR3SlJkVGJsdFh3QVRCWlp1MHFqRFBUcWwyYXNycWNhMkJhUDlM?=
 =?utf-8?B?Qk03aFpqSGxON0UwOEhRTUhSUGJsL1JwQUhrNzJjSTlPNUx6c1kwL2ZyOE85?=
 =?utf-8?B?ZHkwb1NWTVBDS0RJUHZCdWJ0RXd6S05HQm12aGoxNFNxL1drWThxai8vZEZD?=
 =?utf-8?B?THovSmtLVnpicGZVbXkrb3dVa3ovb0tKYzFDSmdWMzlhTFZWWURRak0yK2tk?=
 =?utf-8?B?TEhERjRtdENyenVMNnRwRFVqL2kyL0UwVDRmMnRuVlRIMlMremEvaWx0UDVR?=
 =?utf-8?B?bWtVM09RRTJvUHc4SGpWaDdTZkJuNTVxWWFNd1hqcXExUVd2cUpDbXFxVlE3?=
 =?utf-8?B?dzNPd2RMTjZmZExrOE5ISHFOQnlOVkVLMmRQb05jY0dHUThCVUxnN3ZIZXE4?=
 =?utf-8?B?NEhaRkQwTzV1QUs5R2NFZE4vTVc4YXF1VGwyaDlPSldtUXB2Q1BNeWJFWEJK?=
 =?utf-8?B?VnB5RllMaUpaeXdkb1pEd3NNZUpTRzRuR1cxNGpta3VHMmFvZGpOT2JlN3ZV?=
 =?utf-8?B?blJMdkhLT2F0ZnE0aEhrY012M2g3OGczYmRscFdwdWdLYUduQWdlZEhKWjZp?=
 =?utf-8?B?dVhia1Zqb29jZEsyaTEvV1RlOXl6bVRyWmI4S1hFVHMrSEkzR0V1VDliMFNv?=
 =?utf-8?B?YS83TmM3ZkswMEcybFBKTnloR0RzSnRaYXZMQlBCL2dxNURjZWRBUTlCK3RV?=
 =?utf-8?B?S2FmSFY1bDVxeTJGcThpTFhYTG1lNFp0djUrekRaMzdKbjNMZzhLa2ZvZlhq?=
 =?utf-8?B?d0d0bHNwUDNqSTd0eE5XaWJiakhGMk5DUHJRMmIxdEpqczF5UGNpTmJ4clEw?=
 =?utf-8?B?UDNtaW9MdkhReGcvaFN2VGU3UWYzUVlMQ25aYU81OGd0RXdZOGl0V3d5R01q?=
 =?utf-8?B?NnpjRzl1bC85emFJVks3NThmd0drRWhOb1VmR3pXVGwwSldKTzM2eTZkNm9k?=
 =?utf-8?B?UmVMUm9MY3paUjFpR1UyTVgzTGM2SmRiSWQreTJ6K3FZbE81bExzTFNMdWxz?=
 =?utf-8?B?UklVcXVsY2FDZVpUaUtJcDc1RFVSZTdHWXgzY3d5MUo3STVQdnFjSmZtS2Uw?=
 =?utf-8?B?SGR1T2xvUS90TnZteGV2V0VhT2d3UVQrM3pyQVRpL0cwZG10cHEzdHZYYldX?=
 =?utf-8?B?Q2NQdlFjcVNxVm9HeXYydHoxTEFvcjNrNDQ3NlZ5UHQ0MHJ6U0hMOE1jelFx?=
 =?utf-8?B?WVE2R3luZVNEamxEMXh4QzJ0cExyRFhCOFNaOU56LzdjaC9VWis5OHVQNElh?=
 =?utf-8?B?Q1hjQjFSRGhtZjVuY2RzSHdDa1h5aE94UWg0S3JBMGhkSGZHVlMxN0t3L1JB?=
 =?utf-8?B?emZnZGRrbTFSRnVFcjRvSVdDSnNjUmkwWHF1TjNXV1gwc0VENGxwbnVXZjlM?=
 =?utf-8?B?QU9tem1KOFdDekkzenFkQnhnLzBkSE9IWHlmeEZHaVlZT25RaUtpZ2pBdGR2?=
 =?utf-8?B?MzR4KzAwdEdxcWlWYWZxc1NlMjJQeGNhcXpLc0ROS0pjdXczWlVWRVY5eTNF?=
 =?utf-8?Q?wty3h14hIJE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1lzNWZvV1J4MThKU29YaGJMSU9ESnoxR2d1WEQwZVdnaEZXaW8zSGEwdm5X?=
 =?utf-8?B?dW1TNjZTUXp4NXNhQVc0M1V4dHB0eG1YRGFRYVVDZzQ0T1hmam1JSkM3RG9x?=
 =?utf-8?B?VUFhYzlMR1JEZjRQdC85Z2RRNHdCWm90SWpORFdId2hpL3pGTkc0VkVubnB2?=
 =?utf-8?B?S2ROdXZQT2sxUktRelpWWjFpZTNLUWtzckR0QThOU1dQTnBtOElFUmJES0Ur?=
 =?utf-8?B?T0o0dElRUUZXS3E1ZmZFYlcrcDZ2UVlhMk9xdjdGWmtmRkFhWG0xbzNvaVg0?=
 =?utf-8?B?czF3MGltc3lJM3g1YkhJWlA5NS8wT2dTb3JuVGVYU2RHUlZpUENNaUpLZW5M?=
 =?utf-8?B?Si9wb2tCejBOV21ySlYxMi9EV3NOWXU5VzRDTC9UVTNCNFpNUGk2Vklaa0cx?=
 =?utf-8?B?VEtVZkxMSTNvT3k2TWk1UzlNaE5FUzJHcW5NV0QxcWpPWGhTZzRYTks2Uys0?=
 =?utf-8?B?Y3NrNnAvd0JXc3lhNWx2V2t6dmdrV1dQb3FzdmVNdUF2RllPdDIzS1JHZUVk?=
 =?utf-8?B?MmwyN1Zkd1hOMDQ3aHlObzVER1k1c29TV2g3V0dZdHFnZTFQd2cwVVF2Vk1z?=
 =?utf-8?B?NUJqV3VFREd1bVZKYjduTEpCaGtzVTVuZkliQThoMTJISWhIejdUR3JYYTd0?=
 =?utf-8?B?MmRVeVZ6WUlXSnFFSmtoSGpBejg1SDc1TGhoanVQNlpSODQyWHNqRHEyZmgz?=
 =?utf-8?B?WTBSWFNEaWdWajZSWUo3eSthbmloNXc1MDJvQ25JaGdtM01TdzVQczhvaldO?=
 =?utf-8?B?OXNGM0xVdmdJN0NuVFZ4cDZ4U0V2Nk9WbWd3UTNab3VJM043ei81VG0vVG42?=
 =?utf-8?B?eDZuM2lxc3IvcmtRbmRCWTNhR3EzVEUvOU80dHJMTFg5anBQamlPRVRTdFgr?=
 =?utf-8?B?VDAxQTRNbndEUzlyeGtkY2NjNEVOanhlcStRcEdSWWg2RGFWV0QzU3EzOHV4?=
 =?utf-8?B?TjhiOWR4VnRZY2ZvSXg2alNDaW55bTcrK1lVaDMzWENtU2Z1cVNsdUxKVjNN?=
 =?utf-8?B?dTh0WFkvRVZzOUhlc2FSZmZnREx3KytodmhVZDdYR0VzN0FGT1YvV0tOZTZx?=
 =?utf-8?B?QlJpVHVrQzlHOHB5S1RlcGFtUHphL3dnakZLUWE3ZjFjUXhuaG1BVUp1T28x?=
 =?utf-8?B?UHpjR014VTBKZzUyTHd6TWxpa002MHgzVHBEeDB5WlphOER4UDhUUjNvYUNJ?=
 =?utf-8?B?WVZ2eHZubHJ0M2tHZjFxNUVZYlZWd012bDN1a3czSU1IdzlFYmF4WTdTNWtx?=
 =?utf-8?B?THlxaGlneGFHU1lDYzg3azhwRTMya2pvdXQzOEZIZ2ZRMU1yQWErRkFkMTli?=
 =?utf-8?B?bWx0TTNMczViQlVVTWdiQUd3elo0OWM3ejJGb3ZBcmZIYnVKa3NsWnlBN0ZI?=
 =?utf-8?B?dVFDY0x2U1lES2FLSysxa1RlTndhV2NERkdCbFphbXNvNlRRMWhRenMzdUdF?=
 =?utf-8?B?NFJVN056cGY3YWt1OE5sa1ora2xudTAzSEpYWmRZbHoyM2hkYUpEekEvMHB0?=
 =?utf-8?B?cUFBeEdRdUdmckVCUE10bW9NWUIxL3pQZ2N3UVp6NDkyOHBMQ3lHekIyelhm?=
 =?utf-8?B?WTFIdDNub1h3UmhlQ1dJMW5IbHErcGloTk0rQjN2dU1HRnNyZnpjVVg2d01q?=
 =?utf-8?B?NjVxaXVuejY0TkRhdTZpL01YOThacVR5dVBaRXV2UkgrdHU1T1pFQVBYVThN?=
 =?utf-8?B?ZjJnRGdsd29jMW8wOWJKNGtyM01vYmJCRGN1K1FraFFlYUJrZVg4OWtIS1Yr?=
 =?utf-8?B?UnFzTUtIektMb3BpNm1VRjgzc3JmVGFnNzYwYmNOYWpMU1lyRVovaXpYUkJo?=
 =?utf-8?B?NUwwTWFZQ0FTQm84cW1GOUZhWisrTzlTK0lVS05iSlF4Y2c4VkEvVGJudmFt?=
 =?utf-8?B?d2toUEdmeUsrR05hRHc4ejJvQkNGWG0wRnRieUJKN2I2aGhLVFhwcTJReGJF?=
 =?utf-8?B?UGhqem1sZVhxTUFvemFJWUJjcVdxUWVnU0taaVFIUWRJaDNnanZKVUx3eUh6?=
 =?utf-8?B?cC95VERyWmROejFjTTJtWWJ2V29kU0F0MW5Ka0hYaGk4Uis5Z0FjZ0RBc1N5?=
 =?utf-8?B?VzQya3Y3eG90TURaOTJnWVVNL21PV0F0Y1pwNFN2dVpBZTVDaWhhYWZTRDVr?=
 =?utf-8?Q?72mtZ0uG6ke2OGB+XgEjcuR//?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adb119c-024d-4aeb-eb6b-08ddde8967d8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 18:59:49.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rk4WUIJkkUy1U+kvBJUgPaQw1veEk9fT7jtQiwXVDBPovTV/tOY3K6RRX7l9IjONOp7/rZs2h+xp0ZGK72P++A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661

On 8/18/25 9:06 AM, Danilo Krummrich wrote:
> On Mon Aug 18, 2025 at 3:33 AM CEST, John Hubbard wrote:
>> +            /// Create a `Vendor` from the raw vendor ID value, or `None` if the value doesn't
>> +            /// match any known vendor.
>> +            pub fn from_u32(value: u32) -> Option<Self> {
>> +                match value {
>> +                    $(x if x == Self::$variant.0 => Some(Self::$variant),)+
>> +                    _ => None,
>> +                }
>> +            }
> 
> Same here, I think this should be `impl TryFrom<u32> for Vendor`.

OK. 

> 
>> +
>> +            /// Get the raw 16-bit vendor ID value.
>> +            pub const fn as_u32(self) -> u32 {
>> +                self.0
>> +            }
>> +        }
>> +    };
>> +}
> 
>>  /// An adapter for the registration of PCI drivers.
>>  pub struct Adapter<T: Driver>(T);
>>  
>> @@ -335,9 +656,9 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
>>      ///
>>      /// This is more targeted than [`DeviceId::from_class`]: in addition to matching by Vendor, it
>>      /// also matches the PCI Class (up to the entire 24 bits, depending on the mask).
>> -    pub const fn from_class_and_vendor(class: Class, class_mask: u32, vendor: u32) -> Self {
>> +    pub const fn from_class_and_vendor(class: Class, class_mask: u32, vendor: Vendor) -> Self {
>>          Self(bindings::pci_device_id {
>> -            vendor,
>> +            vendor: vendor.as_u32(),
>>              device: DeviceId::PCI_ANY_ID,
>>              subvendor: DeviceId::PCI_ANY_ID,
>>              subdevice: DeviceId::PCI_ANY_ID,
>> @@ -396,7 +717,7 @@ macro_rules! pci_device_table {
>>  ///     <MyDriver as pci::Driver>::IdInfo,
>>  ///     [
>>  ///         (
>> -///             pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, bindings::PCI_ANY_ID as u32),
>> +///             pci::DeviceId::from_id(pci::Vendor::REDHAT.as_u32(), bindings::PCI_ANY_ID as u32),
> 
> We should change DeviceId::from_id() to consume a pci::Vendor value directly.

Interesting. OK.

Thanks for the review!

thanks,
-- 
John Hubbard


