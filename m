Return-Path: <linux-pci+bounces-45281-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDgvAnesb2miEwAAu9opvQ
	(envelope-from <linux-pci+bounces-45281-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:25:27 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E5C476F5
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F3C7967509
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 16:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5074643D500;
	Tue, 20 Jan 2026 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="p6mCgt/R"
X-Original-To: linux-pci@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022138.outbound.protection.outlook.com [52.101.101.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A6243CED7;
	Tue, 20 Jan 2026 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924493; cv=fail; b=gJv50ALOjm6CYk7efrBlLTa9S2Nlj+ObHuF05sGiW3gcwGy6rVrwK7PF1zY+f+WogfmuETxRgpNrAvBaAU6DTbohXSjWeQtcWy5OCeO4CgQgH1o9zo657X8yMCVRUrfz+PLNl8zFP10pRxOEMzty/3dr24B7FglUJ5BcgR5lijc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924493; c=relaxed/simple;
	bh=Vq94Y+iYiCR6p4FFrEcXXOjK4ict7/i6f3p6mHU2+Mc=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=Awc3UJK2MDmwMDEWszQwe/noIEYNhW8wbO608BIv0A6qcrKt4Zw4RpRmTiqHmeJnVkoyrkjstnPJDjSp+2DDfEtVJkhS4wfpId9ZSxBjvNACFyaiePJkSaqzOfRVy7gQgKcovOoxb9VMB7pUs1330wHMv9N2EShsmI6cTKe1UBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=p6mCgt/R; arc=fail smtp.client-ip=52.101.101.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfxKN6hiFEGnHGM82Hokys339aIhO8wO6QalNos7diGbM2q+JdDPkE+Tm7RLD/4zP2xyE6CXaMV/18vjYw5viJJXGqe+EFq0kUc84DUQtPRk+YkKCKf5TBEgHUim4tkYK+eDvXXM7g8W2zjrcjVaYkzCUDFfgjwCCKbJ/7Oc//0ofrXmQ/tIGGkaZb3lam81hyXqDJRk2f41naJI9HjnpYZ84QWB7+VQKMF/z54oNn2AKTe9iYzzcTIH74p01HZ1FvKLsqehRB0L1hRjuWO5FK5Wf5q9JIOC+svs9uZk83+XoVNM5wlmYk4hQ9chgBa+8L2XVT+78X8TbopblVt/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yS7ug2G2js3A/F/KzOEsiDx5ZvelnD6UL6M63GbIuMg=;
 b=bywQhGJ6L9LtVw/2BwJDbWMTi2Pe1kk02Cqc5DN0oAxk3T8HMEF0wpFFrPRcu46HkBAp0RE6k8MMEhmFpoIYKm5astt2ihco7R6Q/HiKaK3W8tfGHCQ6e55AvcvVE2SPle5iE7inhENIDxO+lty7mPyvowcV1qpxh4MlfMTlGYapwUYH9c/AZAYBy1aOLJd1XEBvnml9G0ub+5CZrK38Tufbe/dqCfP1SWxJgZUP4b+8Jma7fxBA/fxDrWRBRbpDSOK0qBeo49AChhLbSJKBZYQNAivNE3dXzUXBofmpk92h4eNFTU1aaJzwvYApKKWrDkpzAy9g8MRDSwBfiOw7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yS7ug2G2js3A/F/KzOEsiDx5ZvelnD6UL6M63GbIuMg=;
 b=p6mCgt/RxOZ5lybE5iFkhfkZg9ZldTR1vaYdg9cNcnhK2+9L9XTtiNqjVMWYcQmoERXZPqQhuBRtlgMmPBfIP4cmOWK/As3xkEq6kjHz9IbGu/G/sNSHY2zN3/UquQG/MAUtwx2HPGX7Lm4KhMAWvjftiZYcqmVx6gFXEQPharU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB6158.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Tue, 20 Jan
 2026 15:54:46 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9520.012; Tue, 20 Jan 2026
 15:54:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 15:54:45 +0000
Message-Id: <DFTJEACENL9R.28V5QOJXXNM0S@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v10 2/5] rust: io: separate generic I/O helpers from
 MMIO implementation
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260119202250.870588-1-zhiw@nvidia.com>
 <20260119202250.870588-3-zhiw@nvidia.com>
In-Reply-To: <20260119202250.870588-3-zhiw@nvidia.com>
X-ClientProxiedBy: LO4P123CA0341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::22) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e2b1c2-9ce8-49a6-64aa-08de583c3c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlhzUzZjNkc5bERUWkpDK2Jya0I4ZHJBVTFkSzYwcDBEczdWcXlUZ2wvbGp2?=
 =?utf-8?B?TDlhOGYzK3A4MjZmT1RxWU1EM3UwYWp6OG4rN3R4L3AwTEwrN0E5UkZFYzZ0?=
 =?utf-8?B?aVRKV1QyNisxR254RWNyeXdPVUxNbm5XVGkwcVpFYnlIYVJ4M1ZaOEVaYzZK?=
 =?utf-8?B?bjlNQjhwdEhLemdPNEtjcS9ucUdCY0lYbXVWZFlxK2dKeWlaUEZheFQ5REMz?=
 =?utf-8?B?MmpaSWg4bVN4ODZlY1hiVzNsT2hiQnovK1krUWlPdkg4RzV0c0JmSUtGUzB6?=
 =?utf-8?B?Z0pwSG5oUG9ZRkVYOWNEWmhQd25GK3NqV0RFVWxiVENjWUlldUVkR2RFRHhw?=
 =?utf-8?B?QUdJQ0N4bEp1U3lnOUgwNXVEL2VmRlExUWJLMmZFSE1jbVRxOGxtenUxM052?=
 =?utf-8?B?TmVZNUF4MTh3VGFVOWU4WUFIaGs3VlVma2xLc05kQnZZWUphUkk0SmQ5bEtW?=
 =?utf-8?B?KzJibVpCTGllK3ZHa1d0K0lyRXMycUlxZmU4VVkrWHVManFKRVdmMW1zTTBt?=
 =?utf-8?B?RlRJaHVGQmhIZE80ZEwrZmVjWW11UTdGVExJMzVsd2EybHY4Z0lpbFYyVmJ5?=
 =?utf-8?B?Z2dYNDFPbWMyQUJ0ZE5EQmxTbnZHTVMvVU1ySFltUFBYb3JPQllHZGZkc0hY?=
 =?utf-8?B?OHpzK1hiaTRlR21la3o1b2tyZzQySE1OYmZvcGdjYllrekFvdVF5VXAwRm9V?=
 =?utf-8?B?aTYrMzRwTHB1YWFNQ3NKcElqVEkwbGNRYTNGL01sZXNWRldGWGJCcFZ4Nmg1?=
 =?utf-8?B?c2dBTk1HQkYwU0lDdUprRU0weStLYkRWbmFicDRlMmZnZUIxeTFGbWxna083?=
 =?utf-8?B?OFJsaWZpbjhiSEdyNlZjMXFtM3lDUWlxYWV4STRQUjJmUUR6OWx5YUpJcUpp?=
 =?utf-8?B?a2pZeTI4cjBwVkFBaStBclpDMDNEeEdlTDBjbW53bDVJVHJESm4zYmoyQXE1?=
 =?utf-8?B?TXVtbVJrNTIvNXJDTVQyTWRRU2VQWHVHenNWMDFpRjJaU2pna3cwOU5oR1lx?=
 =?utf-8?B?OTNCUUhjaGZlV2NvYTVBS3pPU0FVbUdXQ21qUlhUeVFUeFRqd3JaSEVsWUlP?=
 =?utf-8?B?bWhCL21HUVdTcVBZUUovM3IvS1pQUEdYZTNFYVBudC9lZHFrQmJQSU1yYlF6?=
 =?utf-8?B?QzczSkcyZTRIUzdDSVlLL0xXRkRyT1ZuU1JXMGVuZDhqck9lemV5dW9Fa0xX?=
 =?utf-8?B?UkwvVTVreVMwcWd4Wlo1bUtYLzgrOVNxVll4ZWpzbkZ3VEkyamt1OVRJTG1i?=
 =?utf-8?B?OU9PTGhFT0Z2Y3IvNmhqMHFJdytFUERXSi9LcTFpaS9EYlZ2QXJ4UmVobTVZ?=
 =?utf-8?B?UWZablA4d1hwVWlGSm5lWTNQek0wNlVESlZBdFRyd3gxZTdiTFRVeDBsK3JJ?=
 =?utf-8?B?LzU0VUhhYkpyTjZhdFZRUGZValJ0ZkhLaWsyTmZLYk53TTZFTzJlb0pwZXo0?=
 =?utf-8?B?UW9ieThKUFZMT09nUUtGNGVMYWVWYk1UMVY1ZWExZHdxZFY0OTFKdUpzUWhv?=
 =?utf-8?B?QjZnOGhKeFdmS3UzbUQrbDB2VTV6cU9QRWhEZGhsalk2MGZZL20rKzBrR0hv?=
 =?utf-8?B?ZzA2LzBFQ29pbkRwclVsVmVrcWM1Z1p0YTFFbWhmNDJKaWUwMXRZcTVWMklT?=
 =?utf-8?B?SFNHaXBrdFF0amF5ZG40ODRoV0ZYdURkTThwRjFCcWF3YjNjZlB1cXdoMHhS?=
 =?utf-8?B?OGpDZVFMR2dlWXJSTUEwZ3Y1RmxJNWRkSDByYkJkRk9QYUwyLzBCeTI3cmZP?=
 =?utf-8?B?T2tjSlBoK3MwNzlYMnhlT3A3OTVGb2IwbG0xZ0JTZm9KS1VKdmJnN3B1cFQz?=
 =?utf-8?B?MENheFJiUGpCUFE5WlJSQStDajkyMHo4N21xb0pNbnMwa3BETGFaLzg5Q01q?=
 =?utf-8?B?aGlSNzZkVXdWZVNEN1RTeGVjazZZOW9jeVJ5eUdJU2prTG1QRmNSQWVCOVVC?=
 =?utf-8?B?T0ZBNjlMNm1UbEVXSlJiL3R3VkYxWWpOeVAvMHBCMTBWc2JmOXZ4SkFtMkJw?=
 =?utf-8?B?Y003REJjVFora0swZU1HRGVGR0N6cnFicFpzZm96blI5Y0lmS1B1TkZHbUlB?=
 =?utf-8?B?ZXFJM1NlRUl0NGZNYlAzTjdWKzBaS0RhUzJSUlRTTGMrVGxNM0hWT3NRMENi?=
 =?utf-8?Q?zfRM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFdlaFl2U1VoWUIrM3J0RVNKOVppYzNGdXR3YUhsbTlET1BnUjdPdmpPVTJ6?=
 =?utf-8?B?TXpKUUNyWkhSbENsaHhJMWlzbC9tUWZ0aG5xYXZ2U3VlaU9TcGIyWWhjcXo4?=
 =?utf-8?B?MHBRaTZucFlZa3h2Z29vYm9GZ0FOMDlBUkFzVDcxNmRqcnBZS2luVVNueHl4?=
 =?utf-8?B?UnJScjFSb3JScFp3cGtJQlZtMU5McXJtNFRaYVQrcVNtaVlDK2VTZllFS0hD?=
 =?utf-8?B?UjJoL2JYN1Q4Y1BJMjhJNStwYW5WYnkrd1JUa0RJa0JJc08yZHh2K09lcTNT?=
 =?utf-8?B?MmNQRmhSak1RN1p4dURwNXhmTi85R2VreGZleDlaeXJrUWE0NnFBNVc1RURN?=
 =?utf-8?B?bW1zYmp4MGh4ejJhMzUyOGJpeHhHWXhPcFZVdU05eVlrak1hR2ptU0gxZTlx?=
 =?utf-8?B?L0MrN2Y4QkVGd05EY2RLakVCbkcrdVZXSk5NVHdBVktoWTRDWTRjR1BuQ1du?=
 =?utf-8?B?YjlwbHBkdyt0d0lGRDRpSld6OVNLc09tT3lES2tDdTlPUjEwczFjNU1HUWhk?=
 =?utf-8?B?VUxOREQ5TUdJc0VTRmlWMUJJSENndGtzVUd3YjQ0R0VmY3hwWnRpMU5iWWNp?=
 =?utf-8?B?MjZUN2NWOGV6Y1BBTGNQemQ2Q2k1aXlKeDZlS3AxL3hBMm9PKzJ0S3VwOTk2?=
 =?utf-8?B?NlZiZFZCR005Z1l3UkxTYnc3RDV0RXNRNThsQkZMRHBlYXQ2MUZjOUoyUlV1?=
 =?utf-8?B?MlpER2FjbzM0c0JkaU1oRURQRzFJZWg1dVF6RGJZR0RUMzFLcHRmVmRrOW1G?=
 =?utf-8?B?emdwN3pDbVBvWlJoemd2TjJxazRPc3JRY1o2ZUttWlJCT0xBS1FUZjZTTHkw?=
 =?utf-8?B?VU1pblFxTk84REJPM3BsbEp0dnE4QUVKTThyN0JtRCt3SlNzY2o1OXlyc1Z3?=
 =?utf-8?B?UUthbzZ2YTNaUFBmV01SNFdocUpJU3p1UVFJcURuUStvbG5WKzI3a0krSlQ0?=
 =?utf-8?B?cmVSZXNtZjR0SlNwNUVza29qVFcyS2p5RHoxTng2cHN3MDBEYlNmWVZ3S2F3?=
 =?utf-8?B?YklHWW1sb3ZvQ2c0eVpaZXgzaEhDOXd5OVI2Uk5VNXJSMWZTV1pTeEF6NXNz?=
 =?utf-8?B?QnRDT29hNHNVZmZGekRvT2plcG5TVjhLRlhUWGJYZHR1L2NaU0JRTTJQV1Va?=
 =?utf-8?B?dHQ4OHhTQlhkL0Y2RStwdHZ0V2ZhSGRRVDJWV2FQV0dYYjhOSEQ0dmhaeWJH?=
 =?utf-8?B?YzEvd2xLb2JXdStQWTlZL0Y0by9NWlp0L1pwc3laQmIwZWJicENhRUNXS2Z2?=
 =?utf-8?B?K01jZmJDcHhnaGt5QVdsYTNPckVuZTZUQ3Qzcjd5OThpWTczUHE1c3NKMkZZ?=
 =?utf-8?B?Um9IZlVVWEg4WnRXOTJBQTNWSHlrUXYvYzVlV2tyWi9ZMVNuYTF3eWlOV1M2?=
 =?utf-8?B?TmgxRDF1M2VkYVplVERGcWNnWjhERE5CanUyZ2UzZVJDL3pZV0hqMHdkQ01W?=
 =?utf-8?B?RkdYS1NCejZiSWhoRGRuTEwrS2Nwb3lzOU5oS1c3bWp6dmxhTCtxa0loUzJW?=
 =?utf-8?B?YVJkUUxHRk5vL1U1MXBYNmwra2c4bGI2V0JiUDkreHYwUkFpRTFvUVZJWGFK?=
 =?utf-8?B?VHFJejZvM3R1VXRPNTE1VU1aaURZYUFqL2VJZjlOdGMySXZDVnhlQlFhZGpv?=
 =?utf-8?B?NHFnbkZ4QTJGQmFUd212Q1pHRkFmUUl4NG1ZeGpVK3lVUm9OVVpiYXVIbGJR?=
 =?utf-8?B?NFdTd1AzTklvU1dMMnJKRytJb0ZOSFlibzFMRUdVNGw0bEswbkZ4ZlkzNlM5?=
 =?utf-8?B?S3Fkd2R4OVM2cEVFMXk4OFo4elpSaHdxaHVFNll3dksvVjJhMEV5TXN0cGJx?=
 =?utf-8?B?Q3gwTVlkTldzZUJ2ZE5WdnR2NmVJdEJGQnJ5UmdrU2JpQXFMVDlGSzUwbTJZ?=
 =?utf-8?B?REd5REJZMVNtS3kxUDdsWDR4YU4xRm9VRXVpanpkVXBXMnJndW5GZ1QyczN1?=
 =?utf-8?B?SytCMFAzSnMyak5JY0lzNkhReUpJOVFoUUVWc3l2MmxBNDlHSU40TUluZmdC?=
 =?utf-8?B?SkhackE0Sm1WY2U0aFJTRDFoT1BXYkhWN0JxUWpVTytWOVduRmRjMi8vSDBD?=
 =?utf-8?B?VXFCcDFrLzVERHBYQWdLOU1lNmJhcGtBeUc5SndZUjNiN01yTW0yQVhudXVn?=
 =?utf-8?B?bXlkU3lmdnQ5WW9jUWppU1YyajlPRjAzVkVidm0rVTA0MnVSc2xYTnlhN2FJ?=
 =?utf-8?B?aVdXK1JxQVhDcmF3ZTFsWCtXK3dBOGVyZDFDdUdhMzErb01XdUtRbTNIdUd1?=
 =?utf-8?B?MDZwSFNUYzdTeFFsdVRhWG1YTkVFNElrUU9xcDcxcTl1TjlyN1J3NjFpaVJi?=
 =?utf-8?B?U29VUUlVN01kck5mSVNGclJPWmw5aTd0YVhiZHY0TjVVUXJXYjdvZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e2b1c2-9ce8-49a6-64aa-08de583c3c5a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:54:46.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywJcERRPdy3scODSJScFsUksm2u/o0CD2d/e6JaIiJCtkB7/meKUFM8CCbvy0um9bDJcvLQjP6zUHXhcsJBjLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6158
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-45281-lists,linux-pci=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,garyguo.net,protonmail.com,umich.edu,posteo.de,nvidia.com,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[garyguo.net,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pci@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pci];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,garyguo.net:email,garyguo.net:dkim,garyguo.net:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 70E5C476F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Jan 19, 2026 at 8:22 PM GMT, Zhi Wang wrote:
> The previous Io<SIZE> type combined both the generic I/O access helpers
> and MMIO implementation details in a single struct. This coupling prevent=
ed
> reusing the I/O helpers for other backends, such as PCI configuration
> space.
>
> Establish a clean separation between the I/O interface and concrete backe=
nds
> by separating generic I/O helpers from MMIO implementation.
>
> Introduce two traits to handle different access capabilities:
> - IoCapable<T> trait provides infallible I/O operations (read/write)
>   with compile-time bounds checking.
> - IoTryCapable<T> trait provides fallible I/O operations
>   (try_read/try_write) with runtime bounds checking.
> - The Io trait defines convenience accessors (read8/write8, try_read8/
>   try_write8, etc.) that forward to the corresponding IoCapable<T> or
>   IoTryCapable<T> implementations.

Does the runtime bound checking correlate to I/O sizes at all? I think it c=
ould
be that `IoCapable<ufoo>` gives you `try_readfoo` and then `IoCapable<ufoo>=
 +
IoKnownSize` gives you `readfoo`?

For example, is there a case where a type would have `IoTryCapable<u16>`,
`IoTryCapable<u32>`, `IoCapable<u32>`, but not `IoCapable<u16>`?

>
> This separation allows backends to selectively implement only the operati=
ons
> they support. For example, PCI configuration space can implement IoCapabl=
e<T>
> for infallible operations while MMIO regions can implement both IoCapable=
<T>
> and IoTryCapable<T>.

I think try_ methods could still remain available even if there's a known s=
ize?

>
> Move the MMIO-specific logic into a dedicated Mmio<SIZE> type that
> implements Io and the corresponding `IoCapable<T>` and `IoTryCapable<T>` =
traits.
> Rename IoRaw to MmioRaw and update consumers to use the new types.
>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  drivers/gpu/drm/tyr/regs.rs            |   1 +
>  drivers/gpu/nova-core/gsp/sequencer.rs |   5 +-
>  drivers/gpu/nova-core/regs/macros.rs   |  90 +++---
>  drivers/gpu/nova-core/vbios.rs         |   1 +
>  rust/kernel/devres.rs                  |  15 +-
>  rust/kernel/io.rs                      | 396 ++++++++++++++++++++-----
>  rust/kernel/io/mem.rs                  |  16 +-
>  rust/kernel/io/poll.rs                 |  16 +-
>  rust/kernel/pci/io.rs                  |  12 +-
>  samples/rust/rust_driver_pci.rs        |   1 +
>  10 files changed, 420 insertions(+), 133 deletions(-)
>
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index f46933aaa221..d3a541cb37c6 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -11,6 +11,7 @@
>  use kernel::device::Bound;
>  use kernel::device::Device;
>  use kernel::devres::Devres;
> +use kernel::io::Io;
>  use kernel::prelude::*;
> =20
>  use crate::driver::IoMem;
> diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-co=
re/gsp/sequencer.rs
> index 2d0369c49092..862cf7f27143 100644
> --- a/drivers/gpu/nova-core/gsp/sequencer.rs
> +++ b/drivers/gpu/nova-core/gsp/sequencer.rs
> @@ -12,7 +12,10 @@
> =20
>  use kernel::{
>      device,
> -    io::poll::read_poll_timeout,
> +    io::{
> +        poll::read_poll_timeout,
> +        Io, //
> +    },
>      prelude::*,
>      time::{
>          delay::fsleep,
> diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core=
/regs/macros.rs
> index fd1a815fa57d..6909ed8743bd 100644
> --- a/drivers/gpu/nova-core/regs/macros.rs
> +++ b/drivers/gpu/nova-core/regs/macros.rs
> @@ -369,16 +369,18 @@ impl $name {
> =20
>              /// Read the register from its address in `io`.
>              #[inline(always)]
> -            pub(crate) fn read<const SIZE: usize, T>(io: &T) -> Self whe=
re
> -                T: ::core::ops::Deref<Target =3D ::kernel::io::Io<SIZE>>=
,
> +            pub(crate) fn read<T, I>(io: &T) -> Self where
> +                T: ::core::ops::Deref<Target =3D I>,

Normally it's quite usual to see `Deref` on the bounds, as auto-deref solve=
s the
task. However, it won't work for generics hence I suppose it's why the boun=
d
exist here in the first place.

Would it make sense for whatever the smart pointer is here to gain a forwar=
ding
implementation of `Io` instead?

Also, I suppose we can still have `IoCapable: Io` this is just a single bou=
nd.

Best,
Gary

> +                I: ::kernel::io::Io + ::kernel::io::IoCapable<u32>,
>              {
>                  Self(io.read32($offset))
>              }
> =20
> <snip>


