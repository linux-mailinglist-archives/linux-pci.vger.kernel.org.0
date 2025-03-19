Return-Path: <linux-pci+bounces-24129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC779A68ED1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 15:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B39E7A779C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B13C1C68B6;
	Wed, 19 Mar 2025 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b9Xhx3td"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D11C2DC8;
	Wed, 19 Mar 2025 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393948; cv=fail; b=CLy2DoYMx/n9AHwoupeD1B7y+wal4KlByFBHs5+ZTaAbKsfkgichOCsaV7LxyrbuOoK0gx7JLq0E1jw24MZtsWfRJESvSGT5ZeOcLvMopqw0DT9Qi1Q2dCaEIZod6GIdMe/FAYdCzUx6j0bGNlfe6hPMSgd1bRZO5LboRURVqeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393948; c=relaxed/simple;
	bh=RaDT9Lk/zd25JCoFXD8nq79AgReb8SFzRFFXoN5u2Go=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G9p00pjxbaANUdjkLydepcuTPwbYySidZPFgIF7ljyoC5DYYtMulksvn3Fm3g4LWJC2yfdabjqajq8AU3S/IBZgNS1LCw0UGPcjIechu9PbmwwmmqYu2gL/pHzsWG0odJw0IVPs99dDhTqTbJSNDQIdCVMOMsVJ8KKmSDKOQlKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b9Xhx3td; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfASBVtSZqikUDzuNtg7OxJARK6G6AF8WXPE9j0g3blm4N44ctttZOMnAlkgpgZPlTDUTzmAi+g5RzPsLBlxfr4l7Vh7u3OPUAsNsiLDBKqULFlIez6lgWLlvmSRaghLj7FY/EajRA8KX5cfMv2toggqUYTnSEPRLjudYOY/djqqP+d8ScfowchsdmbsX7wZDs9Lx1bZulQdU3QSK2QwyvVjovE5LpvPPy+zC1Q7TYNnfMM6W90JzHBaKnYRei4f7343MlbmipICmlbInYYa0o4s5q/p2bCwIR+kBKPdDgLpcqtg6oiqVZnsziJMKKjESKvkq7JKo2lD8ayBt9Gc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8Oj/szeJStA1xEt/uzw4YL56XBlEZQEze9N67sFmw8=;
 b=jkW9V2HDYmPLvPeLZ+CIYy40/iOCn7/8zJiOFp1KdcHpfvX3MZxi2WYnDgg43vjsKScQJkjLThGSv7d+ZawiNAGI9Rdknsd3J7hOQJ5Be8l/e9Rzjn8Aqdq1JJGc8mN/Lk20e3iE2YClth12xZjP/5ri2aJIewN/T5doGYZTnOuchqmyHtvPQTxnxsH3Fvc+iB9Z3fRHm0qc3jqNBB2Anf19ALLrPZxUMF7Owp9LtuoA8MUKuSRbjlI+RjgOUDRo80nIvumfL2nGMhNJaeRxnKQ1X7WbcEr0MYIQLJL7a/a1E6btB9b6JLl3TMjEc92sFpeoZXjxgjvTYzbZ03lTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8Oj/szeJStA1xEt/uzw4YL56XBlEZQEze9N67sFmw8=;
 b=b9Xhx3tda96snIob5QEoWGukCs/mmXTr3/RrwZPp0EedH3ay/JjJsQPWUdz/kAFueqNk8EF0Py8AWa1VbJcUf561cn+Kc345IseOTu5z2Gm+dA1B645DRRX0NpY5QbrDeRmKtMFbreQAHjC7rx7JHG6GJxI1cJeflj0eX2xJiZfmvioGa06KH//iy5p1BzaTfk0zmoAwuV2NuEWKTJE9SkBtK3mzc9f/iwaEkgpvlZjydRprWIFT8sfRgU5zOPJ58lgBa6g6wIV7G3JLgOlEDsr/CYVZSmAMRhDkYgCEk6MAL8f2PV2v2Ipb6ACleuVtPnNxcVMQj30AA4c39sXzwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 14:19:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 14:19:02 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 19 Mar 2025 23:18:55 +0900
Subject: [PATCH v2 1/2] rust/revocable: add try_access_with() convenience
 method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-try_with-v2-1-822ec63c05fb@nvidia.com>
References: <20250319-try_with-v2-0-822ec63c05fb@nvidia.com>
In-Reply-To: <20250319-try_with-v2-0-822ec63c05fb@nvidia.com>
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
X-ClientProxiedBy: OS3P286CA0124.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f7::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: ed278e9c-e1b0-4793-d634-08dd66f0ffd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWlncDlyZGtScjRyUWRZcHRTY1lZOUdlRWU3SHYxOHFFa0pITEx2RHFFdldI?=
 =?utf-8?B?dElVU0VZSUxyTU9sU3p1Titvam9QeldqMkpXOHlaeG84U1p3ZVhOdWhiWnpE?=
 =?utf-8?B?MDgwMFNUNlpjRytwZUJETHpXZEVyUlZwK00zVHNQNkx5SjRQdU9oY20yWndW?=
 =?utf-8?B?dC9ScWtHcHdhLzBKRDJhZVBFUGtJYTUwWVFYNlQzTVBhUjQrdHIxZVFXL0JD?=
 =?utf-8?B?UklHQzREZVE3ZXNuTlY5YlVJWGZQK294M2lVNmV6cE9iY2RVa1ZHSzNGT0hP?=
 =?utf-8?B?bWxUYWhCVk4yTmZkSFlQM0FJVmRHc0JsUlhCTDFYdDBlTzJEK2dJWmkxK1RU?=
 =?utf-8?B?dzBnU1NvaEhPYkFnRnBUNkRjZlBxdkk0ZWN1VUhMa2d4K21rOFM5d25NbnN2?=
 =?utf-8?B?cHk3SGtnZU5kQ2Y0OEFPY09saDlwWjhMMW83b0dIR09iNlJLU0xEeHlicFQv?=
 =?utf-8?B?c2ZOSExZWEttK042MzRVS1c1NWZNamNWN05hRE5CeVQ3Qi9ORG1EWmJnOE9p?=
 =?utf-8?B?eWtZbjBqdzJtd0pZMEV2M25NVlJWck10elNBKzlMMHBMS1pOdTh5c0lUUktu?=
 =?utf-8?B?MnNhcWlFWVE3bnFYeSsvTnRoZGFlazNhVDFiSXkxdzMyWm03akdmU2s1dFhN?=
 =?utf-8?B?bFE4Q3JKMHIyUGc5Nmd1Nmo3anNQZ3NPSldpemw3K2xaUEZhM2xSVnB2RDht?=
 =?utf-8?B?WTgza1J3QTBhM1lEWVdpUzY5VkNwS2tDVlpCbTZNN2c1ZnVOTUZpZGNqU3Jl?=
 =?utf-8?B?M0ltN2ErMFpaNCt1K1NkNUYwOFBqcUJnVmVZanI5Tzl1QlRlMXlBWlU3MXRM?=
 =?utf-8?B?M0dGdzVHaFFiSGVhWnVPWXlpY1NJblBzbmJTL01yanozakE1bTdIa01JL29U?=
 =?utf-8?B?cnNRNkg3SjljVnZQU2hDWGw2TTJYbmprNmxLaWhQZ2NXcmI4NHMzUHVLVEN3?=
 =?utf-8?B?ZmZvd0s1bGkvMjZ2ZktCelgwNTFYaXgyMExPMXhuRWhUaUNZclVTa1JtL1Ra?=
 =?utf-8?B?UEZ1T3Q5ZFJ4TUxueTNxdExpQk1obWRLWXFkaS9QV3pXWS8wamlndmZOcjhN?=
 =?utf-8?B?alowbDMyM0U4Q1M4cEFzS1RQeVlxK1ZVYmRHOXpyNGRoLzUweGMrOG5uRE5B?=
 =?utf-8?B?Nis1ZVpYd3paRFcyMzZiZXVDb1ZZUEY2NGNreWlObTFRb0kwaVFjQ20zZHlB?=
 =?utf-8?B?dmlva1k3QmRwR0p2NS8zc2dodDA3R2JhMnRndHUwQnBWQXdhRkdSY0ZEeEdy?=
 =?utf-8?B?WU9hZ1l2cGR6a2ZsL2tXTkdCWCsxSzd0RFJnZW9MdFJTYkgxS1ZjZ3oyNERn?=
 =?utf-8?B?aDlZL3ZBU1lzNlFqUlAxOU5VdHFTSzRoeGw5ajJIZ2tqWUZ1Z3FEemMraXZk?=
 =?utf-8?B?dVRXQkcvU1Z1aHhCOUJDL1Fya1l5R0hNbTZrVzJPWlNMcitmRGhKOGVqUVg3?=
 =?utf-8?B?VEtsREpZcU9ENWZYQ0dpSUFldW5WcjR4TjVoSVQwWnVwRmlXWnExY0I4cFhE?=
 =?utf-8?B?MGFnbEhuT25vS1FIUTUwTEtUbmJ4Qk9YNm0xR2xGazF5cHhFQ1lzWTZiZXNy?=
 =?utf-8?B?ODkva3JmMWJoZkx1RkU5U2dnbmMwMFZDNlFJY1EvZGpwZ0lMV3VoUHBHK1RS?=
 =?utf-8?B?cFlSMmsrenRudm01b1BJSmI5N2gxWlVEMU1aQzlpMkdLMkwvSHdaeDVHVlRE?=
 =?utf-8?B?MGdkUFRaT1JWVzdxRHZuU1piakEwS29CTFMzdDlPWk5LM3JmbkdDbFFOWjdW?=
 =?utf-8?B?eHVCUjFJQ2hOYi9ZRHNJME1WcDJCZUFzbFZiaXdsdVdLRUNubkNoeWFuWnp6?=
 =?utf-8?B?WWJzMUM4TVVCZktEUnFZZCs2d01TWU5OYmcxSzhUcTVqdUZ1amdWdGg0eXpJ?=
 =?utf-8?B?SEh2aFJPR1V5bDRkN0U1eVdBcXowMythT09uT1dMZVg3c3VjUWZsQlJ0RXdo?=
 =?utf-8?Q?oTV+LX74408=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnB0TzhpUW84U0xJVDBiZmM3eGNkYVJSS2Q5TENOSDJ4c3BVM0h1UzF2TG5N?=
 =?utf-8?B?aUd5RkI4VExiM1k3K2t1aDlyZ2w4THlwZmFzMWltdnA2dTJzbmNDWXE5T2or?=
 =?utf-8?B?K1NJbUZVdzlLMjllVVZ0UDBJang3azVpcWlDSFpEN21pUHNFNUJaR1QrUlFX?=
 =?utf-8?B?cWk3aS9BVUF5a2F4TGY0UGtNd0tDN3BnTm5UWjkxQVNNV0VSMGRqYXZqMXB6?=
 =?utf-8?B?cDcxSHVQVTdBVGZhZ0o4TUtLT08wWEJUbTdaWlZxcVNhNExCT3VCRzdETnAz?=
 =?utf-8?B?Z1BuMGQ0d1J2SGtsc1BtbExYMmJwblRGaXdiYmZBblpRb2x2dlB0UDdYZkow?=
 =?utf-8?B?elNmclk4VGc0cWw0NVo1cWdlb2xLRnpiNEQvY044cVpTNXVvRjFMK0xRUURx?=
 =?utf-8?B?RlUzK0MvOXdsSFFMRWNFZWxDTWMvazZBZ1U0bnp6MnlPcnVRSisvMW84aGxU?=
 =?utf-8?B?bjJEcVJBQU9UKzRtL08vbVVxTUI3N2Jia2ZNUzZQeXJ1WWhZYU1xNWtrL0FO?=
 =?utf-8?B?bkdESkYveWdYVWI1QVczUndySVFYYnIrcWFZQitiNS9YL3RuRHMxcHNyYlFH?=
 =?utf-8?B?UkYrNU1GSDVjeE1ZSERyTEJYUFZCYXo5QXYwd2pmY0tlM3hQZEc3bGtEakNz?=
 =?utf-8?B?dHVZcG1UVFk3RkRLcTdMNS9LTXF2R1BTK1JrY291NkJpbkVwQnp3MlVJOTRD?=
 =?utf-8?B?akljb09ocHNhaDVmTUc0NnR3T0RtL0lvZkV6OG5PenpjUTNOT3hPQVZGT1Qw?=
 =?utf-8?B?ZHpkS3Z4bng0S0JxQy9Gdks2QTAzSWVyemZNanRwS0ZTRDNDNlhyUDl1RGhs?=
 =?utf-8?B?OURDRjhrTTlrZkRrY2kvQitDSWZDWm9QNnpjb1llSGlxSUp3YUVDVWhYTmxr?=
 =?utf-8?B?emxudnBqdWhtamlrZUw1ZkNDWFdZbzdMNGlSd003NUhLRFNkVnM4aGxNakti?=
 =?utf-8?B?QlAyanVhLzUraVNCeFA0aDg5SE9PQlRGbEd5SjhiY3hScEQrNlhLVU9HWDht?=
 =?utf-8?B?OXdya0FzTFJ3aG9GRjRibHpETTZoSDc0TVBqZjhBTU5lYkZsUnNWTm9pSXAy?=
 =?utf-8?B?Qi9xdndDbHY1Qm5iN0xXNE45S0I3NmlHS0ZuQjk4SWZnaTlCR3l3VEtidktQ?=
 =?utf-8?B?YUZ6elhTZG5Wa3FYSXZFUU1CY2ZzS1RYSlpkcHNBRnJSTjFDaDQ4Q3dmSHE3?=
 =?utf-8?B?Rk9KTkptbkRDM3RQV3FBZDdPU2dpUmRWSXlsK2kvdGRHL1JISmZuNFpzTDIw?=
 =?utf-8?B?Y3dpSWF1VHZyZXIwSkNNRWE2Z3p3MXlxWXZRUUhzempJY2VqdW1Jdzd1N3ZI?=
 =?utf-8?B?QmJUVVF1SXVyV3JQN09sMmZnTGsvVlZCWkdha1pZL3lWZm41TkFKRnV6MHBp?=
 =?utf-8?B?MXJsUUJlUW51OEZuTzcwK1FTWDM4RmVvNG9UKzltRER3d3hUbmxGTjRVNmZY?=
 =?utf-8?B?Y0F5VGtaVUdQemdBVkd2Ui9PVHZGbm5XOFIrMXlPdnVTS01RYVVPNVZHRWNL?=
 =?utf-8?B?c3ZKY2ppZmI1dmdGeGI1TmNzTW9xSkNPd3ZxQS9iajNSTm1ENFNBTUhIWTJI?=
 =?utf-8?B?a1g1WWhRald6YUpRVnN4K3NidTlUM1R5aTBST2hTQ0tvVi9paTFtb1ZHVS9B?=
 =?utf-8?B?b0F1QXltSGRPWUROOXVIdm5aRlJoWGgyU0VNVExrSy9aaVlBd1F1Qk9xcDdX?=
 =?utf-8?B?UWgwSHhadGJsRzh3eFpySkZhM1psZ3VPYWlFeTc2aVV1Z1haVlJxNE1HYnpY?=
 =?utf-8?B?OXJqOS9OcnlmZzlzTW5uZzVYVm1qM0FJQi9saFptS1F6aXpWVE1aMFo3aVls?=
 =?utf-8?B?SmZHU1FPaFVWS2tFTkh0S2hzYmVIMC9KMGYzRUlWQ1hwWHp6dzRVZXMxR3h2?=
 =?utf-8?B?U2E3cHZaUmk5UTRLRWQ3cEFMenFVd2lzTHN1czBqRWh2U3JDNEx2UC81Ukg1?=
 =?utf-8?B?MWxremRseDgrOHFxUTdMampiaWFPdHFHbDJsTUwweWpyMGY0WlNiSlkyaDJi?=
 =?utf-8?B?RHR5TDNLRG9oT1Z3T1ZpYmJLbWR3Z1BPbG5NRFV3cXBVZnNtWFJsUGpGeU12?=
 =?utf-8?B?bVZnUWlyc1NqTlBIV0hMVzB0QU5ORG5Pd3lrVGNMaE5LSGI5eGVMM0krSmFy?=
 =?utf-8?B?YVlTZFZnMnFPRm1DMmFlbWpOYVNTNmo4UmFxWG5lRVBYNDdkQ2pzdGxPYkln?=
 =?utf-8?Q?xExuCyQFyWPGv605xjgQH8fQ0Tk6cM8MzDxULMx9DlLO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed278e9c-e1b0-4793-d634-08dd66f0ffd6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:19:02.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80jYlA6QQSZ8M0xG4wtBGATZbKOUwxz9wCeo0xGijO+/RQy4eKCNm4q8RBjTQ8IoFSvpurN5uVcgB7yPXfbVBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643

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
2.48.1


