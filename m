Return-Path: <linux-pci+bounces-25898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D15A89305
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 06:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC66D7AAF6D
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 04:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B1123F405;
	Tue, 15 Apr 2025 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d+laFYJI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F123E332;
	Tue, 15 Apr 2025 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744691852; cv=fail; b=uzo912zOiiPDCxeWeu+lHDnEDSqYRPHHJxBdNljOS2MkVzkDZtR8FUomkOl8yaGpd8iw101cI7IMVqpO8x6RQ2C1qlMqnvCIGsfGwLYUKFPb7x3xo4LANht09JpjW4t0kJuzPrEWCMwJpMkOo+WBUSeyrre6vtGmcjpIHGchUDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744691852; c=relaxed/simple;
	bh=vYrHm9EM1LVt/THLr3rQWmp23hexQa4XH+RGql905DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NMkiqN3vufIU65HI/mGBz6AXCZ9YrSdNbBW99jEx6Gos70jR98BRc4SbovzgFDKn7qKU8cCYTdgKcZmI5YUCoUOc2ULSja/2HnA+7tof4f4br4vRiP6UqFXiPp52aQQuLUZ6swWx3hn6gr6BLBJ8vlHR1vuImytCvix7goKqJ/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d+laFYJI; arc=fail smtp.client-ip=40.107.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4dQqKQS6nNlueWUwfJBzI92uEafiZKxaVIm3US0hmFFdWw2UtGFi8Rq5HoZgFSJ/6jNMcukUE+/rgQA+uZLqQF99IhYIF1dBEhtcSuxmJHVQ46IvJIIMMCfxTy4L+/CUNxvigE3su4mg1FQvUWMNH9OWJQd0T0+Gj9ZdJBVjkZX1y47z2YHXazM21FHTjjdcwZyeNC/lXsgq7JJ62bNYXS50JYnkRfQUryRhdVG2pM97skndMiCqGwonlben2bTKn7oPuV52iprIosT4dIdhUU+NfDn7umVxq8mo/HN5wDORRLMepDcQ+A0clTv+vMHFqlj+P8On9Bjk7ArZ2s8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpSLe4AogAK6ZCs6B0koDV/6s76H/sVo0rRGOFHLkH0=;
 b=qCi7G0Wrx9QWq2tOk6djmiJAN03U19B2uK6kC6XFJ0IgwvsCT04hOqgYUbAb3Q7L78iaBKs7WJAO92lFNtoSsgQuZ1P8L3+ION4tm64bAA5GmXeyRDaCk6BdoB17PQYfobLjHs9i+AUGeAiZ4znhxqZptB3hImEPKVxvqT5MK5xjE2/dZo+blMYhUUdhLFQBQwT1oHEdVrW69Fa2HLIrweNgJJJhW+YYpxzXl/X5sQ/P4tDRDg5N85aja+ioR2xde4wSAzfrhp4DWoGAJtTBWm3cLrWxhuQcRrgWG4XDN+y/BPwwyyW5DqILhEj16sMp6Q4HKUE4RF5KBZOkC7ZVVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpSLe4AogAK6ZCs6B0koDV/6s76H/sVo0rRGOFHLkH0=;
 b=d+laFYJIZHmFpFyoOBJcLChGVAPODmq5IeCTVyuaf7/Tfsimue2vw+VK+CeDUZuo/ka+RpXMNYMDFvW2iYqj3euWuMWT8g4/lf204Wxqk/rsFPiqGzniJj56f4INCSd3wIpQBnz/UE3GGHe8SOCpbHdx2zxh/hg4355U7AQ9avh3eukwRWZWQx3TUVibvqtsRYyF6NmD+tZQjGBYVdR1C7WK66XoZgf7TuOZa9hHe88extWz6mu5BF2ovlPgL0TvHIyDqvh9K7jlMfAeQj5YhW7JFDga2Zaggi/yrW7bjvc2JXd9f8n4YQo3qVDlWGSXCigKCbBJ1kSurPypwELsYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by IA1PR12MB6554.namprd12.prod.outlook.com (2603:10b6:208:3a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Tue, 15 Apr
 2025 04:37:27 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 04:37:27 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, rust-for-linux <rust-for-linux@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [v4,1/2] rust/revocable: add try_access_with() convenience method
Date: Tue, 15 Apr 2025 04:37:25 -0000
Message-ID: <174469184533.110.18104839986908904540@patchwork.local>
In-Reply-To: <20250411-try_with-v4-1-f470ac79e2e2@nvidia.com>
References: <20250411-try_with-v4-1-f470ac79e2e2@nvidia.com>
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BL0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:91::21) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|IA1PR12MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 2997efdb-6b42-4c37-decc-08dd7bd739c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXRHL25IZXRLbTNMcjIwVStxci9aQUJLNDIzb0JlWmpaM0I2bUtRL1RQT3pq?=
 =?utf-8?B?ZDI3bjVlTG1CbWlZNENTWnFhTzE4dDZlck5lbEJ5dHErelZLTlpvTHN0cG5R?=
 =?utf-8?B?K3VDYlB1dHhKS2NSWU5ObU9ZdE5jaVVDYTJGc2czVnpDemdnK0Zya3BBaGg1?=
 =?utf-8?B?TE9FY1N3aHJiQ0JqdlNHYnJXRUl5c28rek40UGZ2L1VpUGRSV2pQbk4vVldn?=
 =?utf-8?B?L3ljb0ZjYU9JOGN6Vm5sUnY3Rno5djMzclc0K09aYmNVWXFnaVlvaDREMWhE?=
 =?utf-8?B?YUxhUnVOL3p1aXhBdzhFaHlmcm5XR3YrQ0R6dTQ4a1g3b3dVaGw5Vk10MEtB?=
 =?utf-8?B?OVdYYktyWGFjOXhpN0kveldCOElXREg4N0tLR3FVZ2ZtMW8rOS9ETzBKTGR4?=
 =?utf-8?B?ZzYvSGlrZVVVenR6c3hVS2ovWm54TmJHQUJzeUNWT3I2bW82OS9WNEpTa1FP?=
 =?utf-8?B?REg0K2JGeGl4RGNvSDdmVjF2aVNYR3Zxay8vWVNvQndrazdyZHNDV3NDRVFU?=
 =?utf-8?B?cnpZbDhNblRzdEM1YjBxT0dkVnNPRDFySnlsSnhVNW40Z014KzVSQ2hOYUxR?=
 =?utf-8?B?MDM2VjNHNFUvSVlzc3R2cFBxeDZoL3lLWTRsWHorbU9LSHlkUm03TjBvdm9O?=
 =?utf-8?B?VS8vd2d4UnZDaXRRL1FONUdkc1hwbmdMN3dwVzZaRk1MNHdwdVVsbHlMeU5a?=
 =?utf-8?B?bkdYSzRoanZuSTRWcWFOUDA4TERpYTFlSVlFM2xJSVJzMlVpL0lvZTdWSEk4?=
 =?utf-8?B?L1Zrakd1cFJnajg0bDVNZnpYOEVUUmFHUHdHd2dNSzVCdkRaSGZEL2M5QkdG?=
 =?utf-8?B?MmpIcmkxUlM2cTAzbnorTS9TaVBPZ3VIVXFEZkZXUGFsVGpmSW5zQlNXWk5k?=
 =?utf-8?B?b0R4cTMxOEh2NG8yWitOTW1Nc1FTaE5CeHVBcUgrVHcrcWtXQ05VbDBtR2pW?=
 =?utf-8?B?bndSU2ZPTVpHVFNVeXRGdlIyVFFLdnBITUd4dlVwR2V1NEsyYXh4cVQxMDVX?=
 =?utf-8?B?cTdQbDc2Q25SVFl6RzB1QVV3NUpINStpcWM0N0YwMFRLb3FSaTBnM1VYUkls?=
 =?utf-8?B?UzlKLzZadTFmdERWamE2cEZtejFxRFg5U1FzVUk0ZHNTZUhTVm1SeHhJVTJL?=
 =?utf-8?B?WnZpSVZrbEpHT2l5MDZBU2JhYU1DSXl0R3UwdnY0c2k4L2pSaFdZTzQ0bm1V?=
 =?utf-8?B?L0tlUkFSRi9JRjErOUFualMydzlwb2FMQW1odGkzM1hZczRPeG9qUjJIbDVH?=
 =?utf-8?B?ajloV29JL2dvVVM2SE1pYVY0WXJzajBVcTl0aWQ0N0FIbFM0YlZmRXliTFBE?=
 =?utf-8?B?Z3cySWVTM0R1SWhCcFkxQmRVVWJnaWs1NmJUbTAxUDF3Z1pqYlZEYjBEZ0Yw?=
 =?utf-8?B?RmdIUUUxdWpWR1N4SC9EeXN4YjAyRnM5d1pYa2pmUEd3bmlSM1BaQzBTeE1M?=
 =?utf-8?B?UytDZC84RG9mOEJmVGlZdFphbkVJa0N2UDlDRm94Y3hIWUVyWHZGVkVCbE5P?=
 =?utf-8?B?Z0RKV0JwZVJ2eGJwRGUzNGNXUmFHa2ZVbHF6ZTFBamZSY09HRm44dDNsdUpB?=
 =?utf-8?B?K2liV1cySzVWa0huRys1WWRkTStoeXZKV3BoN0FhNER5OTUwT3c3VGViMTlI?=
 =?utf-8?B?U052NEc1aXpEcDBRdmZaRUdEa2lOOUZ4SGdYa1N1S2F0RnpLbXVKZmNPY0Ix?=
 =?utf-8?B?alNFMERMbyt3cHp5TnRaOEhCNTBObENqbVhmZE1zWGk0UUVMR1ZVbTdPcVdH?=
 =?utf-8?B?VkorK1BXV0ppcTMrNGowNTNaNGRUVCt4VHlLMlplWDByL2k0OWxnVzVxRkI0?=
 =?utf-8?B?R2RRbFZ5YlpFVlhIT2drWGx5WEdRdTlSYVllVkJjVmRSUklzM2hxVWh6ZHJk?=
 =?utf-8?B?TXA0cGJGS2tVcUErZENORU1NeVB2MC9MVG5sVnJoalVyclEwL2Z0TXF4dCtY?=
 =?utf-8?Q?n0/vda8GOP4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXF1elJJOW1IMGZlV004LzNDWDkrV2c4U1pFYUltbjVoYStCcUpEV053Vkw5?=
 =?utf-8?B?QTFMbjhWRnNhajg1OUt6VVFFTHZjdDJBeHRFTGIyaUk5c24yUlBVMVdKVGRH?=
 =?utf-8?B?Q0NSNUdBNGhZS1k5VnVsUjE1N2NWZW1SdTI0akdlaFVwa1FwYm5aNUlWaXl4?=
 =?utf-8?B?b213QVZPZHMweXNKT2t2aU9ldnJ6UzgxRHN6a1pkMG16YWpDcXBuQ05vNFBo?=
 =?utf-8?B?WnFHVDl4eTgyckFmTmlBZ3hvVTdxelRwS0N4R1N6RlFKaXg0NGxLMG14VGhC?=
 =?utf-8?B?ZUZFbk1qS3VOREszSlZHRHpabFVWbjJMSlVXNXlSc2JEdnRFVWM4NzBTY3hy?=
 =?utf-8?B?QlR3SWdnQlBGemxadjFQdnJ0UmNCYk1aWnRQdHRldmUyekNmS0NqT251ZjNG?=
 =?utf-8?B?VHZKNENDdVBjK1ZJalZHbU1CTVphdGVSdStHWVFPbHFnWG8vT0h2Ti9FVGJ4?=
 =?utf-8?B?SlY1SU0rR015OUtRYnBpWVIyVHhacE9udm1MLzhDSkNYSnhWTUZ4VnJEVXp3?=
 =?utf-8?B?Z0JMZWFFbzlwYStUd2Q5T1VOL0UrNVJtZU1qSUlpdytKaXhFMFBBSm55eUhj?=
 =?utf-8?B?b0J3SEd6S1JMMERjY0dOQkUrRzdlcU4zSXU4d0xzUUQxcHcvUWJLcVNlTXF6?=
 =?utf-8?B?ZUFTcm1qbjBiWXZNSytsZkdWbWhraFRzME85M1hYVytXeWxYTWxLUEhnMFha?=
 =?utf-8?B?SkFiNHJiak5GZ3hoSkw0TUlvZ3ZHUDQzUW5ibGhyZGQ2STRuQTZ5VWhvVWlo?=
 =?utf-8?B?cVJKVUlsaXBqQWRLS2N6TXZZZkVPejlsZUVaTWFsZnZSMzFHKzVvUVlZb0xj?=
 =?utf-8?B?MzhuRFJBeHM5RjNrRlEzVFYwc2dTWkZobHJGenRRSXZWWGIzMnNxU1pGVEtH?=
 =?utf-8?B?RG8vREl2ZnlWZkY0TGtaWjhPRGY4TzBVcWg3bWxIR2tLQU9BcmFOMDdrRG5W?=
 =?utf-8?B?VnhlS1dTYXJUMWd0M1VHZjUzL2Y2YzgwUFVtTFppdVBldkEwNXo3SlltQmk2?=
 =?utf-8?B?M05QdTNrV0pjbTFuUG9PK2hFZGZPZSs4UWhuNGNWQTlhUW40SU5HaHFwY1NQ?=
 =?utf-8?B?bVBhYk1IUFpuTWVseS9lN2ovUXdrKzE2RFVqanAwMVBJNTdsVkpiS1cxOFhh?=
 =?utf-8?B?TERCTUdrTUx1REVabmZNMDkrMjMrQ01SNnRzMUR0S01nTUwrbHlIYVRJVnQ2?=
 =?utf-8?B?QnpJZlFpTWJWa3FFSlVoTkIvMncvS0RYTnV5ZU1mVXo5VjBwdFRDcEZRUFA5?=
 =?utf-8?B?a3UvUGN1WW9SRXRiUm9HMWNONjVWemUwV0dkK3JNVXhxbldQcG9YaVlIYzBE?=
 =?utf-8?B?Vjc3NEd4UnU5KzhUTDBUc2xqM1VuWlByYUFzR0pHU2hXNDFLaTllMjF4QnFj?=
 =?utf-8?B?QWJ4U244VzNKcEw3ZkxBdWVXdUtMMHJmQ0ZWLzhLMjRtUWdqOThNY0RXc090?=
 =?utf-8?B?L3dYN1VocVhCUDh3VllwUE1KS0Q1bmk1V1NTUlE4c3l6V3BtQWRRMUdWOEE5?=
 =?utf-8?B?Z3l0azJEY3lsMzZZQmQ0LzQyRmJrbklqbXd5WGtsU0ZBbnBKZmRYT0tveGdr?=
 =?utf-8?B?NzNOTGJ3UDJyMUFRb3FKQ2dIQU1mUXdaYjlISzJGVDZpYU1FcExPYUVQQUxG?=
 =?utf-8?B?eElkbHZ4cnc2aHNvRytHYnhlZGRjZ3lXZmdRdGNWMzlyK1V3aTRqWVN0ZjBx?=
 =?utf-8?B?My9heEZBMjdvbUJhWEhrQndMazVOZTFxZ256MUlhUzFuK3dlVjE5Y0w2eTVF?=
 =?utf-8?B?VXlFeVdHTGFpQ1ZmZTBkT041VjNCaGRwVE9MVVd5NTYyZFkySExzR0VPbUJi?=
 =?utf-8?B?MGNsYTRtMGRObzdPV3B4cEdLL05ncFpkMG5EcVZnQ0dRQUNvMHIrNVAvWXhI?=
 =?utf-8?B?ZzgxUjhZcXBiaVllaUNRK0UyVE1zSHZYZ2JqY0xoUnhZdWR0aEJmYWNWMnc0?=
 =?utf-8?B?VDlnOHJVZFRNTnF1V3Y2ZS81ajdFcWd1Zk5UQytQeXN5UGpjZ3ZxZlorZU0v?=
 =?utf-8?B?TlBMNjVVWitzUkhCbjZzMmRwVDNkTFJtKytKeFQ0RjV6YXJnUklSMXNwVUZQ?=
 =?utf-8?B?aHBoZ09aSG50eHFVRXRmWnlZTWpHM1lSYmxhUlMyRkFzWVhKRlRJa1J5QVVs?=
 =?utf-8?Q?wcZUrAOFHRkd9YofmA6V6O4mj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2997efdb-6b42-4c37-decc-08dd7bd739c2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 04:37:27.4707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXEDrNl+foK2hjqjcTuD5UVIoPrUYugduixmvWpB0PxcYGCePRhIFpTclImaIvXU7TR+tDJzRFB9indCbRHF/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6554

Hello, Alexandre,

On Tue, 15 Apr 2025 04:37:01 GMT, Alexandre Courbot wrote:
> Revocable::try_access() returns a guard through which the wrapped object
> can be accessed. Code that can sleep is not allowed while the guard is
> held; thus, it is common for the caller to explicitly drop it before
> running sleepable code, e.g:
> 
>     let b = bar.try_access()?;
>     let reg = b.readl(...);
> 
>     // Don't forget this or things could go wrong!
>     drop(b);
> 
>     something_that_might_sleep();
> 
>     let b = bar.try_access()?;
>     let reg2 = b.readl(...);
> 
> This is arguably error-prone. try_access_with() provides an arguably
> safer alternative, by taking a closure that is run while the guard is
> held, and by dropping the guard automatically after the closure
> completes. This way, code can be organized more clearly around the
> critical sections and the risk of forgetting to release the guard when
> needed is considerably reduced:
> 
>     let reg = bar.try_access_with(|b| b.readl(...))?;
> 
>     something_that_might_sleep();
> 
>     let reg2 = bar.try_access_with(|b| b.readl(...))?;
> 
> The closure can return nothing, or any value including a Result which is
> then wrapped inside the Option returned by try_access_with. Error
> management is driver-specific, so users are encouraged to create their
> own macros that map and flatten the returned values to something
> appropriate for the code they are working on.
> 
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Thanks.

