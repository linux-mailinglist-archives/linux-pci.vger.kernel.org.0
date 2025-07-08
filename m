Return-Path: <linux-pci+bounces-31653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3A6AFC268
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 08:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EE64201D0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 06:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82842206A6;
	Tue,  8 Jul 2025 06:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p3hK9vbo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A021D3DF;
	Tue,  8 Jul 2025 06:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751954751; cv=fail; b=qQMZiVN6xdFRq6UXocc7t3cSVhD9T9UBj+OssdW+E1J3NoqYWo4AeW0ylKmS3SLWaznU4PED5KGUmVa/KSWxGclVvn3kbzcsgy6yun3h31H73/aYBVb3rSUofkI0n0DhzjU3HR6AM3+JAVnzkS9cXPk8WIOLCfdfRTTL7E5ud/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751954751; c=relaxed/simple;
	bh=tmsNhFFCvChbaqTZExlc9zJM9r178e9/AYfrKaN5xz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UAUzdMQJqVkn0o02G9fkjElD7DUzdKkqOJlG9AiWoLrMN9uc2QQgoMnRKap3Pp9NQInddKnYK70vjozVI0kC6xITi3JU/ydbRwVuhDVTRk+obkA1NbtNLkUSHS/ecQW3EAIR1CWz06WL5B9w3POSbRQ+rBoTFBHIRd7TeSJVk6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p3hK9vbo; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgE34KSTQfgWnpz3WhfQ3F5ajPvXsPwlloX3D9wlMtbjwNnDPPObHN/X0Qet6MTEhfWQN1EkT1C0x7AJbcPuR9SBEeYZDxgilVJ9YqD9l7Llk96KVUJZl57scXQAN9r3B82PIDOL9tVlQoz6XlJW644MC/+/gWHTioSkUVsltzmUyW+aN0nvlHvk+wyzbxk5U0Ca0L0Hi0cAKobrgLMzb2Sesw5/a14dVeeKlXP3iST0H9Jh3ju4kKl3BOMzZnotU/pwmAvFUBqeEf4XSmCWJCxEolA7jRzewKTrT1FLyoheyeX9iXYsGTW3CUsLq2jJ+bqxhNTx3eUE/DGih/nt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsi83D41GxoqWqZ0FTXR7nj3es26x5pSX5HWfArz/zo=;
 b=mPoM7eSCed6Uypa98gDhvXdZunQpwkbbZX/pF2aq13BRGcvlG8SFOXl31sOPNdhCqVD9SX7q+tXRWjuqZEBFVZnB9csmfaLEeTGpv/l02LpaeNXjgKd3CY7uU+BEnTvoq6xGF7NLOE+kMK9vrJOxFsK19kPJ8hsDT38eCjnNHK3w2qyvm+sRc//k5bEsqi8IcNv1zN61QfFxjtyMmkxaeTFNEVt70ACS5zIemCC/eECR+8HlWVmBAMq+5Bj6QzeOpxahN4CJxR69f0Xkx9Ny7eGrUE8wPOkqxv2Wtq0Tv752BVJYdLwuDeb5BdNRDr+lzN7DPGO1FqjbckfrEAj6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsi83D41GxoqWqZ0FTXR7nj3es26x5pSX5HWfArz/zo=;
 b=p3hK9vboat4AC01lYuUa6dW2nGrqwJ0OtT4H49O0ezBJTmbiroBc7trbcUL7e36ulm/juULTpfcVa0j4rBi3l3vzFw3/iU/VjI67b+Ojej3QW1u+g3q1UeuSW6o001lNHn1TGr4UJkTc2TCE16KvBe4nbmwXox+9agvpZxi5Uj27oaixGIEtKof+LvmNOn5LV3S7ueeq291lNfUoDv6SZzGuN6fQe4r0JmJEKdrBvmRz76TnL6/KnIdJEhgY8uWYEbxB7b/LsKS3M+zzVcE5ipi9dYaOw3DOkucTHHwPA+6ec2hAHUYc4rXeVHb4c3cMfufaeBveNGRUHy7kMWY1vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Tue, 8 Jul 2025 06:05:47 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 06:05:47 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rust: Add several miscellaneous PCI helpers
Date: Tue,  8 Jul 2025 16:04:51 +1000
Message-ID: <20250708060451.398323-2-apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250708060451.398323-1-apopple@nvidia.com>
References: <20250708060451.398323-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:610:11a::23) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: cd83088b-fa3d-4e57-7529-08ddbde57b17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXNGWWw2OWhVYXF5OHNnbm80cGNlOXdNRFRiNTdJSFpQSVgzWGpIRmRqak5n?=
 =?utf-8?B?am0reHl3Vkk2WDNFVDVBT21YYzN1WGZNSEFvWXEzZTBUVUFzMlh0SE82SXha?=
 =?utf-8?B?M1RWNnpnSVpsU2QvRElqWDVrUnoyeE9qbDBqS1FWU2hVODZzMDFuUWFibjJN?=
 =?utf-8?B?cW1Dc1lUdU9UNVQzdzZBVEk4WHRDeEVlQm81UmkrUkpSc252bzlEWmtsNDRY?=
 =?utf-8?B?Tk5ZTW9TQkN1bElaQkY3aUlELzdQdnZON0RHZnZqOHRiWWdGMFp4SmkyelQ3?=
 =?utf-8?B?OXRMQXprV1Z4VnhvaEl6VnpLQ2ZESmNBVEs0TkJqZ0JQdlhYV3k1MGtyZVRJ?=
 =?utf-8?B?b1pGNjY4SWZhUEdCd0ZpOXFHUXVCRXJZR2VnY0x1MWVVUy9yc3BYQjJ6Ym9k?=
 =?utf-8?B?clZkRm1mclRpWEV1bDFMOWo0c0VaWWMrdW12bmM0OEVwdXdzdzNhU1UwUWhI?=
 =?utf-8?B?K3NPb3V4eVZOb0pYMXJocXpvMGl5SHhrRWtIdG5yc0plZ0hWc0dhWmc1c3gz?=
 =?utf-8?B?Y3pSMVVDNXJiSEtrZnphNzhzTitJYTlJZXRFMzE4MVhWbCtRVHVrWVV2L1JI?=
 =?utf-8?B?UjNDWWhjUDVEQ0M4WjdGUHFUNTlaSm9CNDRIQ3l2Rm1hYWdRL0g5M0E0UTBi?=
 =?utf-8?B?Z1pzQXRwdWI1TEU2ZVhwYkdJVHJQY256UGtKR3Y3d2tHcXF6S2ZoOWl1M2dL?=
 =?utf-8?B?TFJHSFd3ZS9aRFJwVXBiYnRrR290SFltV2M4MmtiOEllLytDNy93SWRnSi9Q?=
 =?utf-8?B?S0tUZ1VCTnVQUGZkODBWMW1wN3N6TVBGOElBWWorTTNqUGVoTGRLakRWVTZo?=
 =?utf-8?B?VXpSbEozeXlXZndpTGpCa1R6MHltdkltdDBCL0RVVUN6cnZzMGhoa2cyeXo2?=
 =?utf-8?B?MjlpaTA3aXAzTlRuTjR6MjRKZnNySUhjZVFDNUdFaTZ2c21RT1hSR04xSDZ4?=
 =?utf-8?B?WEJPdUl5VkNwZFAwRWlaSEFISWpyZWhWS1FzQi9IZlZrdWxHVTJybU5EVWEy?=
 =?utf-8?B?YmN0TkkxRXVqdkdnaDZFMFRjRm5pNjg5UXhiUTQ4ck5yWHNRbFQ5dWEyRmh0?=
 =?utf-8?B?T2hBMnlJbGVoSGlIQmE2N0EwS09WS1h0ZjZlR1VzK3I4S21hNGJOaHVZZzF3?=
 =?utf-8?B?TXZudmUwdmo4Vm1BTDNvZ2dzN25VSEw4U0JYcU0rNTlxRXlnWjdZd1VLVisx?=
 =?utf-8?B?eldPd084SUdPemo1UGhOMm5XQ1k3aUtVMi9GOXFnQ2FNckZmaFduMGJOTWl0?=
 =?utf-8?B?U1RucjlyQWNzM0NqYzczVTVMQTVZTHdtSUozK3VreUY2T25oUmM3Tno3R21T?=
 =?utf-8?B?R3RES0s1eExmWWxZU0l6KzR0UjhFZk8yN0J1SFA3Nms0ZlcvMVF2TisrWUlX?=
 =?utf-8?B?TmRkMTJQSDk0b3hVTmNLQXpBVDVQc1YxQVZteDBRS0xSK2E2cytkN2RMcm5r?=
 =?utf-8?B?MWJwZlpMZUtTdHJiOFlva0xUcFFrbjRMNGhlVGxKZWs3b040ZzE5RVUwMUs3?=
 =?utf-8?B?WFdDNEw1YjZTb0dXWFZmZ2pSMXBGV09sVG9DbVdkMktmUG5naDFNYjJ6VTkv?=
 =?utf-8?B?cE1mNFU5eUU0MWNkaElDM1BwemVsdlJ1dThLM1I2b2JmYmVFVlNkcFdNQmdm?=
 =?utf-8?B?YmVTb1Rjd0lFNE5xcWRtZ2dZTStvZDJBS01SZ2UvK1F1cUt0SWdoRzVSR0o0?=
 =?utf-8?B?a054VXkxemk3Y0hMblZzRzJ0ZFNEb25TcHRnNFpkZkNyamx1bHY2cThvU094?=
 =?utf-8?B?anZiL0hlYUYrZFBNNjVRZmNYL1ZubElITGpNVEw5dllEVmh2ZkFlaFYzejd4?=
 =?utf-8?B?TnRUN2RnSGkrRVRyN0hZVmJHbkdoZUZ6UkY4Wjg0c0JCbTVQYnpIaEZHQWtX?=
 =?utf-8?B?a3M1emRkck9FYW0xQjNQSzlvMTJVeVJPbitIUXlISjN4VkNQcllhUHIray82?=
 =?utf-8?Q?bnMmmiV4AXU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkI0SDBKcEE1dzVqY1R1c29vS0xCQ2NNSEFlM3N6MEVocmlmbVlIYlloYWh1?=
 =?utf-8?B?c2dXV0orN0hWSytjcXVHbXJpc2dsZUxZV3pNVVBPclpJcUxXU0hnSHVGcnhm?=
 =?utf-8?B?M0N2R1VscHlCcTl3a0pyeFR6YWlGR0lpTm9LaVFmbWptUmYwY1BGQXpWeU1C?=
 =?utf-8?B?dktoWDRkR3BhVUx2N2RIRnNkNUM4OWJ0UWgzb0VWYlRQN2grMjhpZXJaSEI2?=
 =?utf-8?B?VzVmQnM2a1BpZ1hpR1JoSnZyS20vUTFPT0hQQ2pYSU9jdTE0dmxFSVdNWlVp?=
 =?utf-8?B?YkExTkpwR051SVJhTmVXQ3c0SzI4VkhVZjdrTjA2OGdMall6aEUrVVB2dTJX?=
 =?utf-8?B?alptWEh1Zkk4dS9VVUhIMjJaTGhaWEJhcDRYb3lSanZ0UUdybHYwb1NySmpm?=
 =?utf-8?B?QkJuL3pOdlJ4dTJmMWwvK3RoVWQxdzZsMU50SmYxa21KTWJYMWdVUllRWXFQ?=
 =?utf-8?B?OFFSandWTG5JMmcvZFF0eEtZOFB6Tkcrd3F3MVpCSWQwekpHdU1nTkRwY3pq?=
 =?utf-8?B?bjREd1ZaTlRodEUrZ1lSajBqd3ZxaXg1NGtSVm5ZQ0RYR1BuSkZEczNRSHpn?=
 =?utf-8?B?WnN3eWFCY1Z0dFErVXQzSGNlMUFjdWtiNHpnN3R1NlNNd1FtanpOaTNTOUQy?=
 =?utf-8?B?a2lQLzJ5elFjUUdHTGJ0ZmZVb2F5MlppczVTWno0dThEeDMzcFc2c1VCTEEx?=
 =?utf-8?B?NXhnWGJIWWFPdWg2c2lVcFBvUlYvenFGK0hDOW1MUzdla2l4NGRaVmV2SEZ5?=
 =?utf-8?B?T3lkaEptVWZKZ3F2eStXZ0VodkNiQU16TkFkd0RKRUhxUGpFUmQ3QWY2UjU0?=
 =?utf-8?B?dXh5TGljdmFVTU9hbG5teFJ4TUcxUDVPT3RPRlhRZlJKTEVWdU4wb1Q4bWZ4?=
 =?utf-8?B?bEYrZFpKQ2R0NkFYSU0xMW1kWHRTdUpkNFdTQTU0SFZHRnFnNEpEMmQ2dEN2?=
 =?utf-8?B?TnNULzNicGJuZEo0OGY0akF3YWhwT2dacklYSWNLVC9HZ2xGaGRCSnJBazNN?=
 =?utf-8?B?QTl1SzV5d3kzS1Qwd3BhS3p6Y2pGUEtCT3ZhbGEwUkZtLzNNcGlEZzR5UU5F?=
 =?utf-8?B?NFA1dHE0emFMUWVTSVhOdUsrOTdQZE5lMnB6ZDZ4RTZtdjgycXgvTXhvLzVR?=
 =?utf-8?B?K1ZpdmFNUXhQU2h1c2QrYVMzRUt0MEJNVlNhbHY2Wm9FbTZDT0ZWZ1N1Qytm?=
 =?utf-8?B?UUJxZEtVSlp2bm1UTUEvd3ZTQ29mc042dWFPamtmb3MxazNRVU8vbFF4V2Fi?=
 =?utf-8?B?ckgzMDBkaEpLL1FFQjJmSmM2cXNyZ2UwcERLN1dYOFkram5Yem1ZOVdEbHE3?=
 =?utf-8?B?ZjJ5ejRxN0MwNDJVTWNoRm1wR1RMdzc4OHIvK3BwbDZMc2Nva09SM0RCZkp6?=
 =?utf-8?B?V1l6cEhad2dlcFNGeHBNUGdDbXJrSlNCTlE2dGRwdHQ1MTNZWFkvdzNBSktr?=
 =?utf-8?B?K1NQajBhMlhOdEVmODJWMThleWFjT2tCYWdrNWhFR1lYeWkvMEI5NjYrSTU2?=
 =?utf-8?B?N0FTTVY3QzBKVXhqcWN4Q0FhMWdNcVVmajNaNE9DY1IyOWI4THZwZUp2MWpq?=
 =?utf-8?B?NFhyYXh5TkNtZDViY0pzdmc3aWgzamNLSkN0cHNTSVBDRGV0c1Btam45U0Vy?=
 =?utf-8?B?TVJ6eWsvcUNqKzZRREpjL0E0Yzk1Q3V2MzdWWkpTUHFLZ3RrSm1tQTFmQ3Yy?=
 =?utf-8?B?emFKU2JOdUYrdXNuVVB5Mzk3RmZHanRqbmwwMGN5YjRLdTJ3QnVzcWZiRFBt?=
 =?utf-8?B?MHl2Rkg0elhsc3F5S3EvUkc5emM5RzNQcmtESU5VbzFPdGJNSGt4TFJsR1lq?=
 =?utf-8?B?YTh2VytiaWI3VE93Wk5MSHVibW1YaGE3N2VRcHBueHExNjZVVS9kak9pNEx3?=
 =?utf-8?B?M0QwcFNXRXZYTmh1NU5VUDRHRXJnb2k4NkQ0WG9pOGE4NWpneEZjVzVQbndC?=
 =?utf-8?B?enNySDdoR2dKTFpvN1JHUXRZWGpnMjUzaldxbzIxUHNnckVuTFVSZjdoa0Y1?=
 =?utf-8?B?c3BKWWNERzg4dEowVXN3N0VxVDY1WFB3UnZ1RnB2S3JRSDFZdXJLdUZYM3RR?=
 =?utf-8?B?MzVVYmNucmVMaS94OWYreGs3Wm80b2V2aS9OMXcvWFBjdUdsMk9LV1FwWWtm?=
 =?utf-8?Q?qx3gEsHS95LNc7xN/SGnXxCe1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd83088b-fa3d-4e57-7529-08ddbde57b17
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 06:05:47.1526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ce2Kf49EMd5+gB7aa1aj5XQYw4SharBVKx2VGWn2keeTBMbcdmosD4yPguQYsp7buKrgzNSqR9CI2nvrkJAeeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274

Add bindings to obtain a PCI device's resource start address, bus/
device function, revision ID and subsystem device and vendor IDs.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: "Björn Roy Baron" <bjorn3_gh@protonmail.com>
Cc: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Trevor Gross <tmgross@umich.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 rust/helpers/pci.c | 10 ++++++++++
 rust/kernel/pci.rs | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index cd0e6bf2cc4d..59d15bd4bdb1 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -12,6 +12,16 @@ void *rust_helper_pci_get_drvdata(struct pci_dev *pdev)
 	return pci_get_drvdata(pdev);
 }
 
+u16 rust_helper_pci_dev_id(struct pci_dev *dev)
+{
+	return PCI_DEVID(dev->bus->number, dev->devfn);
+}
+
+resource_size_t rust_helper_pci_resource_start(struct pci_dev *pdev, int bar)
+{
+	return pci_resource_start(pdev, bar);
+}
+
 resource_size_t rust_helper_pci_resource_len(struct pci_dev *pdev, int bar)
 {
 	return pci_resource_len(pdev, bar);
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 7f640ba8f19c..f41fd9facb90 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -393,6 +393,42 @@ pub fn device_id(&self) -> u16 {
         unsafe { (*self.as_raw()).device }
     }
 
+    /// Returns the PCI revision ID.
+    pub fn revision_id(&self) -> u8 {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).revision }
+    }
+
+    /// Returns the PCI bus device/function.
+    pub fn dev_id(&self) -> u16 {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { bindings::pci_dev_id(self.as_raw()) }
+    }
+
+    /// Returns the PCI subsystem vendor ID.
+    pub fn subsystem_vendor_id(&self) -> u16 {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).subsystem_vendor }
+    }
+
+    /// Returns the PCI subsystem device ID.
+    pub fn subsystem_device_id(&self) -> u16 {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).subsystem_device }
+    }
+
+    /// Returns the start of the given PCI bar resource.
+    pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
+        if !Bar::index_is_valid(bar) {
+            return Err(EINVAL);
+        }
+
+        // SAFETY:
+        // - `bar` is a valid bar number, as guaranteed by the above call to `Bar::index_is_valid`,
+        // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
+        Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
+    }
+
     /// Returns the size of the given PCI bar resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {
-- 
2.47.2


