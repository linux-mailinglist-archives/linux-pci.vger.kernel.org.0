Return-Path: <linux-pci+bounces-31738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01784AFDD11
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 03:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE8B488406
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 01:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC8213E41A;
	Wed,  9 Jul 2025 01:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tXcw7L1e"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC58220E6;
	Wed,  9 Jul 2025 01:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025409; cv=fail; b=CGdXw5mkmYNKttjjSIed2H+0Q3tD1o880SIbxKScguAV+vBGBnVmrFu/zPJE1oWleCL2x2SUeluJAPBOg/oZL4MgvQQbJdskNgdjeljaJid3mEdtWsmCryKtaJBwuSr/33dfZNYzQTZOC3DjA3RNoEAycsF5pZ6G7OfKRx8XhdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025409; c=relaxed/simple;
	bh=CsjUtvPxoQMfjbux3ujxciLgB63VU7oTSZBG+8TtCVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n7rHMWDfYLOzFnbOoXMbVbgpnsZQc45Axhdm/HKhpE0YvtOF2dPFmMDfW/+Xo90DwpLKXaXcGaRUCqIciS02wiSAKkz6fi9z81xFikBedta4upuNzpRobSJXIPId1ttZbRMgl7BdChyAzEYHWrBJDHmRsuelovXXqVYvw1lgbCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tXcw7L1e; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/y0LO75eflKMfTyceS/14NeAI9Cyi6nbwu3dUH00fkxLhhVoTN5z4iO84qe2r3P3YACcSHBNGG4GxVUVr0yUAqky/xKBpQeEw/lpwb4kcKBEscTW3c6vHet1uf5k+abp4C2R0wtMyGQLlX2sarzKPRG/hruVL35AivsUbxz975O/G5LC5chCKgkqxYtdnfL1oOM8iIUE3d/w+OgAifpbISaODkiHD5oEj4bLDLDDLT3eATdkg2r1cWbPyVi+V7NV1vSBjS+QP+w7HR1g6ZhHy2drz5ghwORYMIdde+KgTFQ/TDt6RwGySAOEazWljvB0B465e7ClzXeTUjArmIuhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2PVhOU9z7nETe4Wjg1KHX6mo7WvxCyWat1CkXuMWzs=;
 b=YaEVQhWLOwgYxJh5T08PYcnFNaQzwezDLe23Ij8qHR1SY5h8kwdYg3mmQwgIlfUQbvoaszy8EwXZNs1Jt1DhPtaBH2SUoKxM5KEkMiqFNDgyxVIcpWsSsHVCr/R+xp0N31m3nfGEs401l8DmqBzqk3MeimuVc83ooeNeDd8Znt8RKKx6ceoNhQZwxXTBFxQ59/F1paAY1uGBhnzlsedWcrazhjwCtt7ZWcwmxWOY9qJ+hAqCQryJ8NJJEARxqVDBvTu3Rwa+gLRlpPgVepA/qNoy8XCHXfWlmJ0LPJ5WcxNAnWLCXyBpVfgeFqw5F1ccTJqWBugZfoDd1XK6elVPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2PVhOU9z7nETe4Wjg1KHX6mo7WvxCyWat1CkXuMWzs=;
 b=tXcw7L1eQL71CiN7rAEl8f2C2MO2wMbrzQgJm4vH3yw1zzZ25UZvB5feVlY8WsdLudoWiAtIglwEkMWI+KPMfGSfduq8l7PTQP2z5aL+FwYOG2bNICU5lPdptlKzOb2asfsiqGMPGLtDzthgaVLWVo4w2mIOsMl5iORuG8H+dRNS4qC4rM5mXMjsaZcC65XcEoI8fgKVJ138miwS2aKv40nh8AqxfINF1Dq5GPaijg77qxt7dJYPWQk4W/aczaxS7z3WKVKvpfY96+Kkoo/veAe4YCBEMaUYoA6+I9mjardsU+6WQFJcC5GvNPHKYZA9FdDOV9Ix5oJJPrbEUU551Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY1PR12MB9699.namprd12.prod.outlook.com (2603:10b6:930:108::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.24; Wed, 9 Jul 2025 01:43:25 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8901.023; Wed, 9 Jul 2025
 01:43:25 +0000
Date: Wed, 9 Jul 2025 11:43:21 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: Add several miscellaneous PCI helpers
Message-ID: <g3hczsfsyntm736xu2nykhj7utbykmts5a4udkybk5ztb4ejnn@xyrkpvgayz7j>
References: <20250708060451.398323-1-apopple@nvidia.com>
 <20250708060451.398323-2-apopple@nvidia.com>
 <DB6KIR4X6GKM.3EJYQJXILGOGN@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6KIR4X6GKM.3EJYQJXILGOGN@kernel.org>
X-ClientProxiedBy: CH2PR14CA0037.namprd14.prod.outlook.com
 (2603:10b6:610:56::17) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY1PR12MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b54db6-f152-4e85-7bf6-08ddbe89fef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SOTB0Q+klSYbTDkmwc3U/WnnMXyWschnQACkc2mDLaMHVmVOMUes8IAIJ44j?=
 =?us-ascii?Q?jU/Ok4DbKy44p81ikMmC258zyq5v8bdSfnDNILY3ATFYMJ1/n+oUVO8upZ/n?=
 =?us-ascii?Q?sWgUdwNX5+uxno5I6ORFpQugJoYYMBi7LsIoP8kbmpA3AMVW6ZIV1M/lgttl?=
 =?us-ascii?Q?RYCguaGBFf7UcBYn0BfO2zkPLgfsL2J3RHlSIZ189AnEOvEufJsc2XnsmLYt?=
 =?us-ascii?Q?5DCI23ntpzQblclD0bjfEHscPnxgqT8h0P2sEZPXv/ZeFnSB0quQlfO6kssz?=
 =?us-ascii?Q?Wt5k73/kALtrZcCtAsde4zPTu75EOu2TKpzxKVQprt7sJRcoUqUSNRyR9LtZ?=
 =?us-ascii?Q?LtjXu4IHDj4rUX54GVDOO8m+PDbzeIwcawSWDlB7RzyP566Ku8oQSk8L2TQw?=
 =?us-ascii?Q?47V7XyjHyFq4aHAGECPVpGKjCoVZnruMXeBr+YflNV2a9HMWWnVbB2aOOgr+?=
 =?us-ascii?Q?1s+mTVejcs50LAT7/dGyDgPa5eVkxAuDyf9zxnqqkt1KecxlKcJwZb+vPk3B?=
 =?us-ascii?Q?CZpWy/tE++mVsJRjRTdCHJRJmf23ud3FZhEpe37VpvIcTwmnWy9Y7//hPhfS?=
 =?us-ascii?Q?RFqWnzFKgKvOxPWx+TvvWH4MIFA4heOmtd9buJmep2FFOmVpRDKafwN8IsmI?=
 =?us-ascii?Q?8BZ/nKxXyjnhjXrhyAudMD7hobMOY5B+9JFUgUgj+l8aUF94lMLNoYQxdAPQ?=
 =?us-ascii?Q?CxTyZagLnPqkpm8yLFN4+q3THCJfo/SFy97AOVTcCOyZI5jnc+oOxa13f1M7?=
 =?us-ascii?Q?dOV9ORuWoaVedaSxeRbjJttklXPodu/bQb86UvDXEYV2PBEA8kbgOgsjMjuD?=
 =?us-ascii?Q?Z/9ePXOkd5h8CiY3eRjAuF8QQ0pUj4ec5V/oHoAH6qhvnZ96c1QAP0AyGxYU?=
 =?us-ascii?Q?PHJ3wrf79nSHJt3rUXGn7ujZZZGNPqYtw62R1ak/anRPCZf8U/cSl/x/UkdO?=
 =?us-ascii?Q?vJ/yYx8uAjq/RsC3lQN/W0Rt3xwhNTIAguVJs1ZulJsL5Um254EzUo5UpUtD?=
 =?us-ascii?Q?hPaTkx1Kbs6p7/2hxjB7Xcz9Ccbj7bb987iXmDIzenLkcyBzuXWpQpdZyszv?=
 =?us-ascii?Q?aQ4wMc0Oove0VLnl11w3vymdUmmJh/X2o/eadVGPpBGRYtS91zaBjLOCtaic?=
 =?us-ascii?Q?+hqenCh5F2twjRjaCS+UAiHQzPc7rswH62qJvO1/DmOXfLimY5WXwIGRB8Kw?=
 =?us-ascii?Q?t9zzlN2f0N3gmMPDTmA+jGEINSPF7qVyeOVr/iW6ADGB2jRDBF9i8+iV151j?=
 =?us-ascii?Q?CgV4dIBh27+pLua897ZEuccSCV3litlVR6bO4dml5IHzuP80naQA+y6gjRwY?=
 =?us-ascii?Q?vGaLds8eRZ/AbSi8WeLFuP1mN/B4NlEjYsgSkA6+QTQNuUwN0RwwokYkT1PE?=
 =?us-ascii?Q?3xh6QQc5QDtxyU3FJBVLsd9t3/ZBdeM5fDtGCQsk1r4Tjbe1+JTIuAJuA0wP?=
 =?us-ascii?Q?OhRTnoBCzIo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MN2aY5s9PiR68cP0+j5mUGsftYNwE1PaB//3I8hWJz92EzRJ1jw1BolMHPgv?=
 =?us-ascii?Q?9jxgoEjCGwJoz78IvRCp/8O6Eo9aOycjmETl6bkWlYOGaMIUl2fjEy3OO/OJ?=
 =?us-ascii?Q?ZT2th95jRv9GdbyWSd5YUbYe3MDxsOlcqGtH/yGSZwY32kTRTGw8PB/n6Vd5?=
 =?us-ascii?Q?ic1bNnjGFxDA1PM7Tn5MiPdy9LLQVnSLX44UKKIENWXRBUMapTOJfPctDToh?=
 =?us-ascii?Q?FAbAZFv6kL0Bjxbk1xqUd0GusIn89JaKrTtOby8UnRAndclheohhJuSwpq/4?=
 =?us-ascii?Q?XcjaNI6lPHjGov5CrVw8jc7phMWiyFeSXWOvA+JDUeyoosS5C17e52+Lbh6h?=
 =?us-ascii?Q?VUB1VtsQMkv//35S7uN5kxkUuRXiWi0fi4sWQX4TajgRuxUC9vvHKReogwOg?=
 =?us-ascii?Q?XITbEnYveR7/KGF1dAUEMNZ4KdBq2xPVmpSOo4qMgi1gnOuzPdBZjczkRMBP?=
 =?us-ascii?Q?G9PRwiDzdy675PWC/XaGqlyvWm4cNVpdMYpwmYYVIDC85dWmb4K6iqLHHLwr?=
 =?us-ascii?Q?0OzERR0oRtgsNJmZQmv+S1byQvbw7CHxdsWPAxqUuVbEsw3/fM4lngKKw+Gz?=
 =?us-ascii?Q?NShVxUvV8rZrsm7udQCB0od5G4lyaZET8U2wMQTyc8m+8Tc1dAixt2gMLzD7?=
 =?us-ascii?Q?+4RYLS9HWofgcZJEW8ufkr+7MS5jHDm+OYNwdTjwlzsxJdFshsiSJqaeINpx?=
 =?us-ascii?Q?B1X7/WlIdyKw7YcMPLtnZwxwU3SmrV6wcRiTq9bgE+TQgBJjfcDwoXf/Ogks?=
 =?us-ascii?Q?heM6/SPQ8XzzBxIrZ27Z0Bawq7p2h3oZivQZyuvN8++xpEd+zwOvCFUKqSUQ?=
 =?us-ascii?Q?s0BdjyS6ROQN8k6xpYcL+KlONrPZHVXU3a01lceisD2N8zADkG26Bcb4zEbA?=
 =?us-ascii?Q?KL4Q3+T3VLEA9lHud9cKfSrRXi1tETxaX/sw48phe7U+D93rHbEUQ5zxT7+i?=
 =?us-ascii?Q?F50W5xgxqWdlIW3UOkOEfGaRU3AXOiTqOs2r75+aaWMgVT9EVQLXFkdqh6lY?=
 =?us-ascii?Q?Qgtu/9Zb9qaMUk4OwvL05liDCRNAGPtyixJAuDOJjTwJD6UcDWruta8MJPJl?=
 =?us-ascii?Q?a+DIdi18IFxmzbvhOTtGJjoJMMMNgA0zjLLaEhuzhaOdxDTLUFFw3XLPC6up?=
 =?us-ascii?Q?39uaKlSuDxweckjYnQYxcgJPN5LDwQRQCdSai/YoBuZmRxQs3Q762qurOfZt?=
 =?us-ascii?Q?+pI2wrva2HAs2Vdbw/QHtuuJbGojHa/m4x0/5EqpnP03Ghd0H4PGLz/hMEKS?=
 =?us-ascii?Q?/vvmtvl7aGIf+mKlrO51gWlfsWK/QFzd+VFUvv9n5A/siI4O+1sTROq7i+NV?=
 =?us-ascii?Q?Cq3WsJlLJVzAieA4sHhvZe/83tDRaVa6BHswXFDjbpkX2Asei8gc4fGJBYEB?=
 =?us-ascii?Q?2Xd1sm+z0Qw5d8QNKziLmn8zEqPE1m3Jpw1O7mLh711dflKnPznluhLXkhoP?=
 =?us-ascii?Q?kTvMF2mr8GBfvyFfV54eMDtrnVSr1uwsxy90D2xASKaUn2Ddok1Vd6e+Uc6e?=
 =?us-ascii?Q?deJ8dzvOAS4rovWsZRRupkW5gwwwY4oscEdtAUctTCv0pgxMzi5v7BleZWKt?=
 =?us-ascii?Q?MzgXtvswov7vPFylVSirIQWTlr2ImnyH1sqDpW24?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b54db6-f152-4e85-7bf6-08ddbe89fef1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 01:43:25.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jj4HBoYpRpfvaEtT71p1rk327Wh8sMinnyUIHDsjwD0y+t7bLPzwOGMpP36lFqgzEZuHp+Q66XMP2IzidVeAVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9699

On Tue, Jul 08, 2025 at 11:32:24AM +0200, Danilo Krummrich wrote:
> On Tue Jul 8, 2025 at 8:04 AM CEST, Alistair Popple wrote:
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 7f640ba8f19c..f41fd9facb90 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -393,6 +393,42 @@ pub fn device_id(&self) -> u16 {
> >          unsafe { (*self.as_raw()).device }
> >      }
> >  
> > +    /// Returns the PCI revision ID.
> > +    pub fn revision_id(&self) -> u8 {
> 
> We should add a compiler hint for those methods to be inlined.
> 
> > +        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
> 
> Let's refer to the type invariant for the validity of self.as_raw().
> 
> > +        unsafe { (*self.as_raw()).revision }
> > +    }
> 
> Both is also true for the existing methods vendor_id() and device_id(). Can you
> please fix them up in a separate patch as well?

Sure.

> Also, please add a brief note in the commit message where those will be used
> (even though I obviously know). :)

:) Will do.

