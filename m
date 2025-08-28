Return-Path: <linux-pci+bounces-35014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AA6B39ECA
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 15:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08E1561397
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D204B311972;
	Thu, 28 Aug 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qdR4dy6I"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63B30CDA9;
	Thu, 28 Aug 2025 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387532; cv=fail; b=at12KYmBCfYeXP8dkEjFClA1c0KgfyMhzyI/mI8O2V8nGhpqhQ6iwI0eL/9zHd0fjiNLaU05K+B8jzh6YhOkqeWNMCnDsjXiA9K8/lJAYKXL7F6qrbgOclQEQM9xZPH8q10EWSODhtd8JjtoqQoNWCo1EKF6pmguqOtE9OiPAXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387532; c=relaxed/simple;
	bh=6jdnoOvHFPDF4VyGELmVX1+kHgWT0M+QFdBwj1ml2dU=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=CFMQNLXkdYIqv2ra8XiEGVAMuHuIzbQvkj3lvCYFnwk2LRtKb+wUBR/N8E7GPSvCeudx8btgYl7pYzKC3smVALO6xJQ0zFtPCDawikz+zuP/FFsgSbQ4Zhw6xYY+4gYo13pwT8sCqAMP3UXCQDyzeZIFkZWnSzWEMJ67G2Z5tO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qdR4dy6I; arc=fail smtp.client-ip=40.107.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qA5JPDvkZlBSjycSRXsl7XPXxQ+ABu8fVHZnADjkc3KGWw9w0WhN2gpnmS1UhimZOdMoI9x1mAWRZF6I7N3VGPz9k/eX0uoguLTFIDaVq4k7nEk6pQT0ayD5Kf0DmK4HC2sD1OEAKdCg8hs0hOCQxTijsaoo8s95mbUq0FrV+ySA4DDq6FE/Eto90yoJmDrGm+A13cVMelqsnC5MRf7/RaZ1PB6oTS8qvEcZi/Sl+EXlZwGiaMxklA5WATQoWwo5GbgcHscUsQncdciPjdTWjsGBP4wbqQsQ/iFC3NMNcJr1N2yJURgI7uf+e91jYOMu638H58VmFUA6goAPzFavKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrmll6ItgzPahoF6QTYsEXcti5U35K+5NUG4WDW/5y8=;
 b=oHkjA9X6Kkpi3KjjU4RA5XyxxGYmGc9RdpsXDJzbu7pjbsiyR+KZNAFticgs45pIp2PBfRJytwgSpCo9k2zl0xCwCuLwo97/R2BeoLIK7dL2fPC++D3Uqot4G6JGQaM1jAsdzZ0zuWaNFj6rpvwkS8xOOwbDBDvJ8SgGlGB3mEI5MEQNG1DUJWUNOwmwkLmBIK6naVKupULBip6o69dxhilfnFGqzHiUeClP0ExDydGIyzVbSyPSt70IGiygjfuoS/EPdwlbh4qHOuuTHa9PyPODv2XJxxqcZdhOacMMGYrfR+yUf9HGTmREnWncn+2mwni0TOrbB/F5Y1l6s+MhqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrmll6ItgzPahoF6QTYsEXcti5U35K+5NUG4WDW/5y8=;
 b=qdR4dy6ISNi9X7QLyKpuv6iAInYll7fkhabCM2M3ArWq1cU+dZD94stqMQDaZSp1rQiorNMq3YuxKV96zndq/3HLFW++IIQJG0aJXvQo/tByjiv/HO+ANQtnrf/8U3smwtf/BV0X+fbQtKnW303htIakVfmQolkkUZMpcsnL7f1TTMVGWMwZyFKnhoz8EzCsoNll8f5/Pl0XJyn4bip4pEojVB27ZKaFiOgO037lW2KIi49XD/YDtcc8+L4z0uWxRiatT8zlYMRKdz6quStJeQH5s10sKUBqFaWJu8N7ISJQt812qACXx4lmpXq9rFQLe3IHgTnrZGCcrrHXeOk95g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 13:25:22 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 13:25:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Aug 2025 22:25:18 +0900
Message-Id: <DCE3EV79EX7N.DCIT9JWFGXGG@nvidia.com>
Subject: Re: [PATCH v7 5/6] rust: pci: use pci::Vendor instead of
 bindings::PCI_VENDOR_ID_*
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
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250826231224.1241349-1-jhubbard@nvidia.com>
 <20250826231224.1241349-6-jhubbard@nvidia.com>
In-Reply-To: <20250826231224.1241349-6-jhubbard@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0179.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 581d6b7c-e9c4-4e57-9528-08dde63656f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXhBaW1SVXJWOEM1THp5bWJ2UEZnUS9VSVFOWTN0SWhrTlZyaUJ4SW9ZOTRY?=
 =?utf-8?B?V002elRzSW9XbEovaERxZHM3aG5iQ0VBSGRTcVRCYTl5QmJTa2R0OTZnWjhl?=
 =?utf-8?B?QUxyR0VmMFNCRVZLbWEyZ1FhNUMzS0p4VXJyelVLdUo2MEYyNzRiYkpSZmNi?=
 =?utf-8?B?NkZnTDkwQWwwL2U3RDFiR252cHB0TENVY3lzVFBuamRodkZpaW92eWxsTGk3?=
 =?utf-8?B?K1U3QXoyWjFxU1FjaTMxQTNLK1R0OUwrakRLcWd0MVhsWEFsamd6VVZMTWRh?=
 =?utf-8?B?cm42ZXduRFMxZ0pxaEJ6VlJ0OE1MWUJDcHRrbnlmNEFWR1k2aGhwTkpuL0VO?=
 =?utf-8?B?M2JjZEtkaVExUU95MUFjZDJNWlR5VzIvWlFGN0tyTmVLOHJrQlF6cWRIRHRB?=
 =?utf-8?B?eS9Ga1NnK1hXNnF6am9TNEZBU05hTzE2S1dXU0h3bkFSQVNwd2JtZWk2ZUN3?=
 =?utf-8?B?ZVNBSnFLaCs2TXhYYnhlQkdCOExFRnA1eUtUT0lzSm1BbkxFeXRWS2pCMTdF?=
 =?utf-8?B?RHdQS2t0b1BJa1RzRlBuYnc0NU9TU1paRTd2cEt5QmtFTEJSU2JZY2tjQ3U4?=
 =?utf-8?B?YnNMdFR6RldCekpXbWtZdTU0ZDNEN25xaUFtNjZ1V0sxd3Ivb0JraHk3THli?=
 =?utf-8?B?MUVGR2ZkS0tXOVBuVDZkSEZBK0tVY0pDTmg4TW1KdFM1Ri9rVmpZVEx5em9q?=
 =?utf-8?B?TWYxT1Z6SFFPOEpZYzdoKzNYTjhTcjh4NDRwd0FsdTRnaXpZQmRyTjYvMGpJ?=
 =?utf-8?B?NFhQeVNFU3IrenhuTEk0ZWlFSHovdGZ1SWRidlF3dk9EOXU5VzRKK3Y0ZW9l?=
 =?utf-8?B?UmxyS2NXalZSL3doR3Yvb2FUSXdsZ0VUbXRjbWNPbXpVdHY5SElsL3oxS0Fp?=
 =?utf-8?B?WHZYaXhvNnNiazFlT01qcE94bUp5R1lrQVZQNzByOCsvdm5NanFZcGF6VWRC?=
 =?utf-8?B?dGRFdDZCbmlXUGtTRGR5SFJkNzlIa1JHT0hhdTNvUm4wYWp5TThQWFIzQ2ZQ?=
 =?utf-8?B?WHh6Rk1RbXN6clRab2x1dERhUks3VWx5cElZeU1OSHZST3ZMSFZ5TG40WGZz?=
 =?utf-8?B?QzBhOWdWdDVJSmJ4ZStEMzZUZzAxY2tlZmhFTlpUZ2FUdkxpMmRWY3FFWGJo?=
 =?utf-8?B?dkE4NTZRdm00ekYwd0EzS3FSSkg5WkxZNzF1VHhnQ3lndnAzeFdraHZCTThr?=
 =?utf-8?B?NkppbFUzcDRGQ2l4R2lNT3hseDg3Tk4rMDVyb1ljSllTNDZoVnR3RGQyM3Ur?=
 =?utf-8?B?SWRIdTA5UHNZbWErdkJyb3NLK0w2aXZOSEw1ejYyQTRDaDNLalZxMUljSitQ?=
 =?utf-8?B?VmxDZjAvQ2g1TU9mOWZwbHpybjA0U3o0OEZFSzdqaVZxbjlHd1MxZG1QUDJZ?=
 =?utf-8?B?b2c2cndOYmhtcEdUZXB3TlQxWmNsL0pmY01hOHNmb0ZOMWVBQjhNNFQyTkRB?=
 =?utf-8?B?bFBsNm8vR3c0cUNpVWVnZU5VajUrRWN2MWplMWdsODFoaXJ4VmF3TGdVNjJ2?=
 =?utf-8?B?V1JaVndsS2ZVME1zL2R0NDJGSkI1cWswWktUY2d0UjdwRmNJMUt2SnlvYXE1?=
 =?utf-8?B?TURaYS9yd0lRUEhmOHhYRlNaM3BJVjd2RG5CNkl4SmVoN213Mk9Kay9XWVQr?=
 =?utf-8?B?NVJ0aWF0dUlOQ01DdXB6Zk94bUVkcnFxLzJYOUN3ekxaMkROL29xRHhvdThB?=
 =?utf-8?B?NDUwZXNxUUEzS1poVE54U2hrVmJtOFVIdFVGSVpEU2JFSU9DK1lpUzZVY3lY?=
 =?utf-8?B?OHQ5ZUZBWU5UcjRWUjB0d0ZOR09xZ1QwclNrcmx3ZkRPWUgzK3hLa0EzOGE3?=
 =?utf-8?B?ZkFHOWttdmg1K2cvZ2tjeUpqRDhVc0psS1d0V0tKYlVBWnZ6MFZQaGIzQ294?=
 =?utf-8?B?UEJXOVBpdElHbWJvOXJTSU1mMlFWNE5uSnVGRzhFSnJVVzRXNnl0RTBOektK?=
 =?utf-8?Q?n8CooggMfOo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTRGU1hhL1h0Z3FBVGo5anJrc2tvT0cxa3NnbUk4Z3A4VGdRaFFKd04wWklS?=
 =?utf-8?B?T1JnT1NmNVVuTlhhMStrWHBLVGFoUExHWTUwQnlDYy9hRXF5VU9YcXF4R3Nk?=
 =?utf-8?B?aU1FM3dCaEhLZnRIMlI4MGNiYTBFb1N6YVEyV09sTnRVZDI1aTMzM0lhUkli?=
 =?utf-8?B?Z2V2UFN4MG1jazNFeGFSamhLalFIZzkvK3JEcXpOOExkL3Faa204ZGFtYlZE?=
 =?utf-8?B?N2dKNXcwVWdMbkpPUEdIYXVndmc1Z2RDeHNKV2lCT0hULzVpdEZqSWJ4TDdO?=
 =?utf-8?B?bEczQmhoOU1zYk1BVHpFblVERFpVSzc5SjJuQVJYMVB4cllna3NmQVV3RXRw?=
 =?utf-8?B?a3NJWjVPb25MTDdHM0luMVdmZXhmRk41L29wMys0cVUvTzdjdVBPNXh6Z29E?=
 =?utf-8?B?dGZOSVd5aTQ1UUhtS0s0Q0RDZ1FkYlFRL1RWSk1yKzJVeDhLVlZHeXBnNkhO?=
 =?utf-8?B?RDNRaktrcTZxRDd3UWUwM1JWdnRGRDJLSnA0eUZRSGNiREpQZGpWOTFiT0xn?=
 =?utf-8?B?MWdzaXBHU3FDYjFZWktSZmxHVFExdStXR2FpWmJlRzdjR1hpWUxWK1Aya2pP?=
 =?utf-8?B?YmpMT09uMHJpVU9td1FkM0oxOHRwaTk1QmJKTHNSTWp3NUhFRWFkS3JvSEFV?=
 =?utf-8?B?bUdlakQyWGlqcmNzcG5wY2wyUzVhTFFvS3h6YlFjNENVM3BrYkxnbWVGUFdu?=
 =?utf-8?B?anlhRE1ydEdKQ2FsUFVtV3NQSGVMSzNDSXRQcTBrcE5zbTNlU0hzdWQzUzRi?=
 =?utf-8?B?MHZvVzVBYU03OHg5bDVIczFZM1ZuUkpKS0pUM0hCU2pKWlFGbTdwWENEV2hi?=
 =?utf-8?B?WENqYkNJOU9uQWVOUE83eEI3T3pqR0ZzTGlNenc3T1JvVVFwSGJzNHlZS1F0?=
 =?utf-8?B?dkR0NktSQkh2eGhpUlpzNXZFRGJKSXI5WjFwNE9VdFdyVFVHUFIvbE1sVi9w?=
 =?utf-8?B?ZW53NW01R1UvMHk3U1BVaFY5SG44NFN3QVlsclc3MmVDd1V5ZllnY3BqK0Z0?=
 =?utf-8?B?cnRKUTFDbStTanV4U25XNjZ4bFE2c1dOODB4aTBvNG94Q2VSc29uUURUMUty?=
 =?utf-8?B?K1JSZ2o5Y2VmMjk1RVgyTm04cmNHU1h3b21xdmtudXdDN1JPUjVBWlJFNU05?=
 =?utf-8?B?cTgvQnREejg1WHBXY0xma3F1eDMvYXRtMGlUNGdMMlRZZmwzeVAwcjNXQXNC?=
 =?utf-8?B?a2pQeUNnL1NOTENFRUtJUVlyb2NqR1FKbkE5UDF4ZlZSUStoSDZTQlA5cGt0?=
 =?utf-8?B?Zkl6d3J2ZEtTTEZpOUpydzIvSVlBSmhBaFNBam10R2E4NkFIVUUwUmNqS2l3?=
 =?utf-8?B?d05RdGo2a3dQcXlHQWNmSzRUNmlFQWxQUlhtUEdEeE9MRDNmb2ovN2F0YXpk?=
 =?utf-8?B?N0FxVE12TGRjSnJRU3FHd2F0VEFCeFpRb2laR0VnRlpibWRSVlVzQXdYR1FG?=
 =?utf-8?B?WVhpN3FMVG1odmJGODNjV0FocG5OY29CVzI5MFd1MG5mL3RMbWFUZ29VTUt2?=
 =?utf-8?B?ZUJYY3ArYjlRWlhKeDh3UmVSNlFUWXNjTkNoTDNKaUU5QndwOElyVWY1WDA3?=
 =?utf-8?B?UC8xY2g2VUc5RVpWK0xYKzhsak5nd000R1VZQUExWWc0MGxmTlR0RGh3VStx?=
 =?utf-8?B?MFFHbExCWC9XRjBjUnR2NFhZekt1dW0vREp6aHBnNWFFYzdIRTNTaTFEU0F1?=
 =?utf-8?B?aGgwMDM2WUpnaG9jVUdDUGdtSDgxSWdOZzlGc2daNFcwOTRFSTgwR3dUL2FM?=
 =?utf-8?B?empRU2FrNEZGdWc2NktadlZ6ZFpDTVB4NWZROGdSZ2g4RENGbFp1U0F3Snlt?=
 =?utf-8?B?R1lIeDhxZFNOQXFFNDZiWTVkOElaRXJ1V3ZWbHRmYy9vUTRCbDAvTWZTN0dQ?=
 =?utf-8?B?VzVuUFoyKzBNd0F4S1p6elJodzZGbGFsZTZYL0MxdWxpVW1wZkF3Y3FVOEFi?=
 =?utf-8?B?WTVabXgzMjZKd2ZZM3BPbnBybUFVaUZuREppVFBqSWhYZFZJQitMZFZXVUQ5?=
 =?utf-8?B?Yi84VTh1cG5NZGo0SDI5VXZYRGZqcHhlZ2l2UU1DQnNGR0diWUJJbWdhTHhy?=
 =?utf-8?B?MUpHRXp1OU5USWh6NGdJb3RkaDhKUHdhNXVHSHlUblJpR3E5RXZuYmtyY0VG?=
 =?utf-8?B?NGlZSEpyaURENHlWMjB0U2RBUS9PdEV2ZGtyVTRYSzZQdk1qVTcvL1B1MEV5?=
 =?utf-8?Q?It8fB2hvySJVAh9xR/hCVdmnnIjAlxXeriFl3N0iSwdh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581d6b7c-e9c4-4e57-9528-08dde63656f3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 13:25:22.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s15EVdUDl1WyoH5kqUAySvU0gRzmwRM7EvjwQhJFIm2E/G6eUkIKOkcVZ9SBirDixKBnZcSwN7RCAxJDxaH01g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196

On Wed Aug 27, 2025 at 8:12 AM JST, John Hubbard wrote:
<snip>
> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
> index 4b0ad8d4edc6..fd7a789e3015 100644
> --- a/rust/kernel/pci/id.rs
> +++ b/rust/kernel/pci/id.rs
> @@ -118,15 +118,14 @@ fn try_from(value: u32) -> Result<Self, Self::Error=
> {
>  /// ```
>  /// # use kernel::{device::Core, pci::{self, Vendor}, prelude::*};
>  /// fn log_device_info(pdev: &pci::Device<Core>) -> Result<()> {
> -///     // Compare raw vendor ID with known vendor constant
> -///     let vendor_id =3D pdev.vendor_id();
> -///     if vendor_id =3D=3D Vendor::NVIDIA.as_raw() {
> -///         dev_info!(
> -///             pdev.as_ref(),
> -///             "Found NVIDIA device: 0x{:x}\n",
> -///             pdev.device_id()
> -///         );
> -///     }
> +///     // Get the validated PCI vendor ID
> +///     let vendor =3D pdev.vendor_id();
> +///     dev_info!(
> +///         pdev.as_ref(),
> +///         "Device: Vendor=3D{}, Device=3D0x{:x}\n",
> +///         vendor,
> +///         pdev.device_id()
> +///     );

Why not use this new example starting from patch 2, which introduced the
previous code that this patch removes?


