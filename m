Return-Path: <linux-pci+bounces-25342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C87A7CE46
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 15:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D15F3A9206
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B402C218EA7;
	Sun,  6 Apr 2025 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lp2qTS5J"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B941A08B5;
	Sun,  6 Apr 2025 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743947904; cv=fail; b=GlZRE0sV/TVdbR6mzYp5162xCSEw23k07wd1LNvEZF4XMjWUnpy8sCBdIAUC8sEfNbwikDD7DNrp8tKcGYAWaX2EOKjgjCrCMCdt6eIqic/xvdImy0D3y9Uxcj+NF/GdvOjC6TZEZhqMFod818SqQADsvq3Tg9AdsDmwOq1YOKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743947904; c=relaxed/simple;
	bh=ucZiUIFzFHtM7RLa3Hsp08S5EinSCnbRjtMN5tajZYw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jLXMTaO7j82etwQyBP7qIImOGoriG/5fXBtF+Ay3sJoL48LoujmVfo5CHmB0NoBoCCvXqOGLxUQ7idf9P+K2hMeeYLZ2oTZgaXL79JQA5+a/Hn41sI6nCbUoeCHG1CMMkmIQrxLTzWY3x0qhLMA/x3cGHfpJ70Glstfkt1IUd1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lp2qTS5J; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTyQY7UBlvbU84dq/N1/QA5TtGlsXACYdbJQmSw5Rk604kIySWn9wtXhm8CfM2c7KIVbW7TdEFgKFNGDEJvr9exztQcNbgbAtsCn0Eh6ZMQTH0x47ZFCRvnVfKPKqC/7AdgOFt6J944oYrT8YOchQmT1Uokdg4bHgo4tAePX2buwZA0ITu2Na784xPEAeAniWjeANCrii5fZ27hjH9E3B4htfrjOKe5LO6vS/aYDg8mRkriTPxN0SEkW0BCImYz1bBV7oJKwKZ4CCnBYjKat6gcAZw92CTLNClWFV/VWMtkdfGY1JtgyDcWEhXIfJIIkSoba6B4Q3bcnJ04527ybEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5MN3HWmSQuOXuX1vCTx8g/qxmfz5F+BSh+LWvoGJh8=;
 b=WxRiq9E1Dp1hPquGIPRVOXtR8I7aUGC4/nFI6SUJXv5DRxfGFaVg2XSdn+Py9M4P0iuIFWFhfaGQ4j93AlPhjBuwbB9sUTYns5l16KMeP+37xasbSTK57HzpLdNEecb6Sgt0t3CqIUpZSFqAsVqJljOuSg3Z6k06QdqFAOyq01GzRAd6U43ikzaZhlBZbq8gwJphkvX4Y1S5O4cimZIGoaDzfs6itEMfaeL8ElVdbceU7AARHaxIqvfa2vpiT1i/wNGV85j+9CJykPLzdPGDCsb7VtBZuu+U+IKZX8AZddEW9tZ1yLh7JaRr/bHjGFxkQ3we9sUcBgpaAvdn99nLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5MN3HWmSQuOXuX1vCTx8g/qxmfz5F+BSh+LWvoGJh8=;
 b=Lp2qTS5JoHQlrYSR2NNXh1NXSUok5Mf16cGtrezEnVKfmc1IvUKqoJOfrICUVdk5UQazEqurW40GMEGJG1kG3uvEsJvqNtoFCJHC6XrMOdBrrz5QWDYe/5Bwj3Djjp86osQEdoExl7hukHRYYsbK/9T9nQn5Rgvr558pvcv8PFSJPN0BBunuL+Jg8LDhJA+v18ioRX9tfpT1a4VXa293tVY1IGAYEZEJp5XyXl6Wf3JvzTSDdTroyytbZFoQn5zVVbPN9gRsTwBy9iOFbTjEj8PfiVMq6/eTCAPArLD4C1UddPWCwkUiSnpTGmsXst8QvudyM5BkPdw3ExOgY/M9vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Sun, 6 Apr
 2025 13:58:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8606.029; Sun, 6 Apr 2025
 13:58:21 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 06 Apr 2025 22:58:15 +0900
Subject: [PATCH v3 1/2] rust/revocable: add try_access_with() convenience
 method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250406-try_with-v3-1-c0947842e768@nvidia.com>
References: <20250406-try_with-v3-0-c0947842e768@nvidia.com>
In-Reply-To: <20250406-try_with-v3-0-c0947842e768@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Danilo Krummrich <dakr@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TYCP286CA0363.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ee8c69-d18d-4565-54a8-08dd7513171f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3IxNENBM2crbkJGMVlmN3duM2EraFZnNllQN3Yrcmc1YUxwV0hIM2l6UUxr?=
 =?utf-8?B?NHYveHJxTnVGcVYzdkJIK1BEYTlPc0tGWWRJYkloMGMybFVQYWJzNFh0Szkw?=
 =?utf-8?B?VEdHZ1dad0orSWsxVC9HZFNaUXNGUDl1NWlLbTNrL0dYR3ExcFdBenVBNUIw?=
 =?utf-8?B?ZTAya1g4L3VrbkYzeVZnT1NvN0E2Y2cxUjhLMTAzVDVDR0RsMDZBVTJ4SWk1?=
 =?utf-8?B?TkxnOEthWFJDMmI4R21MK2R1ZUl3Yy9iS2pGUUM4ZGhRcWFjWXB3RUtPdDlz?=
 =?utf-8?B?cjFNL2xTdkxYU3I5SHRmQ2ZibHFndTB6dHBlTnZPRlF3MUhzcHVsL3Q5ZVI0?=
 =?utf-8?B?bnpXeEo1VVcxQnd5ZWFOcFk5ZGF1bDlwN0o3UklVRFFlbTVjREJwb1o2d0tz?=
 =?utf-8?B?WTRBam52Zkw3dVIxTW83cDRsMFhDU3cwUkc1eXJFaWZROEpCRFZzV2ZncVZB?=
 =?utf-8?B?cEdWNnhGUFFDYUNJK21rbXRNU0lQNVZoWVNBaXYwWFhlRldJeUN3NUk2SEx2?=
 =?utf-8?B?RTk3YVlNV1VFb09NbEZDc21QV0FaNGg0c3gyR242R3ZIck9ydFZNbGQ0LzFC?=
 =?utf-8?B?ZzNGY2VSbFFnUE1RaXFJL3huUitrQm4rY25RQlYxMVZxUmMzcXN6aTFLWkVi?=
 =?utf-8?B?eGZEMDRQQm9nNlVZMjRtSFdhdEpKbCt2dWRCRmQvc3FYdklsdnJlNTczUVBZ?=
 =?utf-8?B?ZjlBNVBLME9yWVJtQkpmK1M0dW5EdFk0TmdtNDJKZ29GWkRUN2ZVRGp1V1NI?=
 =?utf-8?B?TmptVUVwcTZaQUtpVHBpY0dvTlp3ZVdGa3ZpOG9SdldINDNTb1FOZDhVQ25w?=
 =?utf-8?B?Zyt5TzBBOEtHS0pDWlF2MHNybURla29EWlg2cml0RE1XLy9VWTZTWVV1Lzcv?=
 =?utf-8?B?UUpzVGE3ZS82ZXhnRCtFbmdiQVhxL0plNHRWcDdzUC94SkVqZndwOTV6UExl?=
 =?utf-8?B?eFhIR3pkTTZuYnRCY3F1UHp2dytJL1JsWTVSZ0pNclJUY0VEcWRCRzdyVnYr?=
 =?utf-8?B?ZlVjSTA4ckhWOGRJY0pPR2dMMEpGSlFzcFVlaE95Vk85SENZTU84Rjd4eTdY?=
 =?utf-8?B?RGpFU2M2WGc3TzlpMG1rVGV3a2FtVUt4cEpPczNmVm5TdlJqOFA4QWFabG04?=
 =?utf-8?B?dG43a0VpZDN5c1EzY0lJcGhBYzc4VVF1SU9iQmZBK2RGeEFSRkFPaDVkY3BW?=
 =?utf-8?B?eDdQazU1SXVsT2dyN3FxVzk1Wk0xZG9BcHI3YXZFMDNlRzhZK1RrbUdGajNm?=
 =?utf-8?B?Wkk2b25lamI1RHBOUklsbUgza3FKSDYxWVRpbzE3SndpUnBCcldBcmp6UkVU?=
 =?utf-8?B?cGs0RHRKTE9hSVVrRGQxeVR1V3Zad0lRcEtoSkIwRFV6OVYrdzQwN3o0T0Q0?=
 =?utf-8?B?UnRGc1JJdWxub2Jld2Q0Z2I1WmZYaHdrcG1BL1RpSHRUNEVyWHpaNEV2dDZz?=
 =?utf-8?B?RG9jQndSSHpOanZ5Mi8xQzA2L1pWOEw1TUZKcFV5SVB2aCtWTXBoVld0OVhU?=
 =?utf-8?B?ejNRTEQyL3l4dlNKNDNEVTRqMmNNVGxkeHN2ZXB3dG9IRlk5Y3lKMWFtNzVE?=
 =?utf-8?B?R2Z1T1FXY2ZtTGUvOEE4ZGZCUW9xWFA0S3B1SmVJNEtDL0V3anM3LzFuTTgz?=
 =?utf-8?B?T1RWVUNscjhaY1FpWDY0b2NXTWFtZGxJWm52Ny9XM0VUVGIrMHU5bjRadkdK?=
 =?utf-8?B?ZnJTQ0RjdVRlc2dlS3BTUysrdWY4ZmFpYkJQaU9YYTRvZEdCSkU1enREb3hh?=
 =?utf-8?B?U016emVBUzQ4eW9jWUJRMW1Eb2ZEMmhwMEFOOGF6aTBDNWlxVjY3Y05BQWl3?=
 =?utf-8?B?b1p2Q21NVlVlOG1wWHBoWS9mQWp3VjRyVm5VRzJheGZzUlFkaEtjSkczVnZK?=
 =?utf-8?B?UnRjL25XUFE0MlVWWDNBbkc4WDlieGl2UTZQRG1ZL3owZFZueHk4WG5NSGFJ?=
 =?utf-8?Q?Fyvyc3iaC6U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEJzQ25tUHhhMVg0dnlkbkN2TmRBUlRFOGtEQmZjNUhsR3BkSFQ3SUZnUXpi?=
 =?utf-8?B?V0FaNW1GNjd6ZkFwdHl5SHZZeGZHN2RReVZObVUza2ZaUE42RGUvQnVNZjlm?=
 =?utf-8?B?RVJVQXJJNWJHWWpIMnBZTGpWVTEzT2RwY0kyN0I3SzNJbllydGtkaWgrdjEx?=
 =?utf-8?B?eTVxeUFyQ0xLcmRudWsvbk15YTgxSFNHZ1dDTEx0Z0x1N0NPR20rNE5iZWE0?=
 =?utf-8?B?MGUyS2QzYUZNdXNJSlk0UjF5VnJKRnZ3OWRkZjVFZGxWYVlkK3E2VXRENmRj?=
 =?utf-8?B?cXR0NVh4UFMwQXdSMTVDc21nQ3luRHk4a1dZekpSY0lzOEo1SC9sWS9zQUNv?=
 =?utf-8?B?cGtVRDFmdXNlRkcxWkkwV0cyN2p3aUZ4Y0d4NExucVFTT0Ztb2h4ZE5RTW1C?=
 =?utf-8?B?dkVvYmtyK00xZlpIb293eUdnZW9ETHFVbCtpbzBzN0dNSUg5WXNkMHQ4QlF4?=
 =?utf-8?B?STdNcU81RlVmN0JqWUtIZEpyK3J0YnJKRnBjaWdKY0dJVyt5VWNkNTAzZlh1?=
 =?utf-8?B?V1c4MnhzUG1KdXAvT0RXSGlGd0hnSHJIbElkb2FBSDcrdEpLaXpXQU1CMzNR?=
 =?utf-8?B?bkFaVnVEVU54Zko5QVNMTXEvZFR4N1VHVWNXR3lhYUxLQ0tOTHRRZFJoRXBH?=
 =?utf-8?B?ZGF6cTFSZjloUk9wWWhKQ1VJQTcrMUlWOVVWTXl5MXJoL2NRdDFoUkwvZURV?=
 =?utf-8?B?KzhRb3AzalFkVHNvQmpDdnROVE5EZ2xrQ01SZFU3dy9BQmNhTlIwOUNmNk9i?=
 =?utf-8?B?VXNnVUl1RGtsbXJnazd1V0xweVRld3AvQmR6Yk1rY0drbGR0V2lmcDFPN0NU?=
 =?utf-8?B?MWZKdDhnMjA3RVY5WkZsTHdyYWxpbzdpNDQ0M3JBQW9aTm8rU0t6QjRLNFZD?=
 =?utf-8?B?aU15S1NYTEZDRXNIUDBJUlNOT1VTWXUwZlVEdWRIMitoZWRRT0VnZWJBbUZT?=
 =?utf-8?B?UkpQOXhKMFJaNWhqVVBmNDgveWlKNDcycTBnejZIOW5mYitOZWpWZ1IzMHlR?=
 =?utf-8?B?RWhyYWxESVlYNnJjeENRZ0JQY0xXeEw0SXBpQm4rWG8zTktWVUlFaWpMcGVy?=
 =?utf-8?B?MENBaVc3S3JVRnlLdU01VGdkeFlTNTZjVDRkcTVlSWI4eW94VkM3WGhVdzVj?=
 =?utf-8?B?aW8wb3Z6dzdpYWFiU0xPdUh6RFg3OWNVNkFqb0tjZWY1bE9RRUo4QlJocE5l?=
 =?utf-8?B?MjJrYVVVL2N5Z09lSmNncURjK052cXBiMVJHMnM0TDdLWWtBR3hEVEliVElS?=
 =?utf-8?B?K0tYOGU0S0NtdEpJVmxHR2xFZy9xWVJkbjhWOFZma3ZIU3FDejdNUFZUMXJw?=
 =?utf-8?B?WWE3U0Yrb2RMOTM4cUJOZDZScmo1bk5iSkQ2MDZzY200NFk1ZUZVbS9YQ01O?=
 =?utf-8?B?ekRhb3V1SGgyU1RFbHNRd0hwdklpS29nNUNLTHZRanZoUElOSDR5a3FOQ0s3?=
 =?utf-8?B?NzUwaFRKZlFhUlBVYjE2NVlxSDV0K2NhR0hjTHJJZ3NPdFFuS0VlSTF6eElP?=
 =?utf-8?B?cHloNXlYNDhoazRwMXhuL0xWUHo0K1k2ZU9pb1FXV1Ruc3NZZGNKV0ZwL3pT?=
 =?utf-8?B?dlVKQTdwK0graGtsY2MxTm9ZYXdIV0hBSjVPSWx5bjZVU2tOYWtKVC94RDk1?=
 =?utf-8?B?QjRFZmRiUnBtYXcxVGVzNXJJQUlPRjlyb1BJSU1SMVRXRHpiTVB3VDRwV1pX?=
 =?utf-8?B?clVBVUtaQVFPYXE3VkJvZEpGWWttT016dlVBcmQyMmkyNS9oejFxZThnTkRk?=
 =?utf-8?B?WEhqMzJGNGFwT09sYzBJdWpPbFA1Tjk1WHBvdWdJdVNVUkdrM3AyUmllSXpR?=
 =?utf-8?B?WXNCdVkzbFRDdlMyQ1hVVEkvQ09FWG9mSUUzK0RxSUVqMkJORW1hYkVyWU0v?=
 =?utf-8?B?cHNqUm51dDV3czdpY2ZpWDBPd3NocXlNVmR5VVhuaCttZzVsNnBmdGZWSGpw?=
 =?utf-8?B?YlpEZmJ0Z1gxaW8vTTNnaXlqbVArOGpyWFY0TUJ5dnowU1MyZVo4MWVkVGUv?=
 =?utf-8?B?N1BwL1VKU0tBTUdLY0ZLZ1JUU3FnWDhuVmFWZ1E4cVRBajBxS3ZSUEhkMSsr?=
 =?utf-8?B?Yi9hVG51UUw0MXpEeEllWVpFU3pvZHVkR0Z3SU9RUG9QaUJ0ekhwRkhrNkE5?=
 =?utf-8?B?MFJ2TkU2ZlJ1cjNKdEhJUHNkN2RZVHErR3hGVkxGZFR0NGtueVYzMS9CTTVH?=
 =?utf-8?Q?UXhUqlJu1fBf3fOChUgf3w7eyd+PHALAmzcLv5ylOlfz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ee8c69-d18d-4565-54a8-08dd7513171f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2025 13:58:21.0200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5bOjRWBiIySd25xV0vEyTRNtK2e6A7bSkxJgQGnI7mQvjhjtqgntVX8OCa37aUqLIy4OwZUJoU6gSWXmAYKNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403

Revocable::try_access() returns a guard through which the wrapped object
can be accessed. Code that can sleep is not allowed while the guard is
held; thus, it is common for the caller to explicitly drop it before
running sleepable code, e.g:

    let b = bar.try_access()?;
    let reg = b.readl(...);

    // Don't forget this or things could go wrong!
    drop(b);

    something_that_might_sleep();

    let b = bar.try_access()?;
    let reg2 = b.readl(...);

This is arguably error-prone. try_access_with() provides an arguably
safer alternative, by taking a closure that is run while the guard is
held, and by dropping the guard automatically after the closure
completes. This way, code can be organized more clearly around the
critical sections and the risk of forgetting to release the guard when
needed is considerably reduced:

    let reg = bar.try_access_with(|b| b.readl(...))?;

    something_that_might_sleep();

    let reg2 = bar.try_access_with(|b| b.readl(...))?;

The closure can return nothing, or any value including a Result which is
then wrapped inside the Option returned by try_access_with. Error
management is driver-specific, so users are encouraged to create their
own macros that map and flatten the returned values to something
appropriate for the code they are working on.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/revocable.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
index 1e5a9d25c21b279b01f90b02997492aa4880d84f..b91e40e8160be0cc0ff8e0699e48e063c9dbce22 100644
--- a/rust/kernel/revocable.rs
+++ b/rust/kernel/revocable.rs
@@ -123,6 +123,22 @@ pub fn try_access_with_guard<'a>(&'a self, _guard: &'a rcu::Guard) -> Option<&'a
         }
     }
 
+    /// Tries to access the wrapped object and run a closure on it while the guard is held.
+    ///
+    /// This is a convenience method to run short non-sleepable code blocks while ensuring the
+    /// guard is dropped afterwards. [`Self::try_access`] carries the risk that the caller will
+    /// forget to explicitly drop that returned guard before calling sleepable code; this method
+    /// adds an extra safety to make sure it doesn't happen.
+    ///
+    /// Returns `None` if the object has been revoked and is therefore no longer accessible, or the
+    /// result of the closure wrapped in `Some`. If the closure returns a [`Result`] then the
+    /// return type becomes `Option<Result<>>`, which can be inconvenient. Users are encouraged to
+    /// define their own macro that turns the `Option` into a proper error code and flattens the
+    /// inner result into it if it makes sense within their subsystem.
+    pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
+        self.try_access().map(|t| f(&*t))
+    }
+
     /// # Safety
     ///
     /// Callers must ensure that there are no more concurrent users of the revocable object.

-- 
2.49.0


