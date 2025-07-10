Return-Path: <linux-pci+bounces-31894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9EFB00F93
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 01:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6195D542A87
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 23:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455292D8385;
	Thu, 10 Jul 2025 23:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="onvfgw0A"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909252D4B5A;
	Thu, 10 Jul 2025 23:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189759; cv=fail; b=IIgB9VJlelF197ej4SVSiiu1hJaheHYG/GI9AVUi5L9Va4SffuE5ld7LMQcWAVMmC8oT9Ex3vfyf+o+t7xqAlhM+ggQVqKckMAqnEujebReP+VCJbVamB8lkoonyTPhMzTsICO2K7dQWt2mpN4ph+1vQU1goc97n+z01LE/d37U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189759; c=relaxed/simple;
	bh=dexaULfYfUu5D1ONZ+egnLQkhUF5mV4T6HE/WKgfkbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=il2GSeGMCYXShqgRNfI2HVJFF9o/GdS7L4RqKcU2Rhzs+fReJ3cMjWzKTE1/H+rwScSuRFQmSGQR39paWTQGABUTloTFYSCxBIzFQrSvYxSH0Hyehbi8rojS05W/B/jnKG5PTUQZ7J/5l+c9aO5oHvVpGDHOUBMdIFu3/h6rpio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=onvfgw0A; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3SNNQ9dRrOnpiggzB8NSf8OsvqhsLQQcp+6uL1wpQLkmaK8WpEYJ+A8HLbEosZbEnsEkhKP5GMLMSGYHkce1uVamHGNQkYrJ6uUQSTLYprOtN5+41szTbDsIsb562joYaZjtxzJ6c+xLFLM6jzc1t7RAC2UMStACPhkTzMsCf0V5dfxUTqAJ3ghH37kmQUIiAQGmV8yCMMnGu1zwzggI/KZQLAvGKOZx9bNSR2J8M+CbYtKTp9za8UH5CEj6CXJLkxQ1jQBIoi3TRRe9zKUKErXekRzhW5gh2bkHzTjLW+Mhyj84KgrlqKE3antsokTeTUECN2lt/Cy4AV4qn7dsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9uJzZ3F60AhM6zTbw3/KP3B6M/+WboNwJic6MvIPgE=;
 b=ORIbeA79UB6Qp+/cUUkuPL3PDo8Mx0L8TeH3eEOjbB76vl7VyppmA/xmDhw+5gS0LT23IaRSZWTpOIhxmc25971baiQd/uUAyLxjDCYCvdMiYEUKT7x6/yj6CeUE8CX0e6WDRob+7tX0yL5j+HPEPhZctCBcDJEO4SnrsKxqtlp2Oq3fNndZcuk09Yc7lgUFUiGPR35m1QnGcIzDVv++sOGv4Rr6eYAvrSx6T5/Va0ft+IZyr99I3+RxVFUWXEBUT+skWBao0PYm4XCCqF4CJNQ7b+JQYUBYUpHYggG6w+6s1NxWTfDGejBCBKjfKh9TJ9/Yqcw9aQJFVK9/hKMaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9uJzZ3F60AhM6zTbw3/KP3B6M/+WboNwJic6MvIPgE=;
 b=onvfgw0ANVUBh9pPGKIMYCst2ZAQrXGtDgp+VNdtS4NQpJweZ3d+5cw/Pwj+ZHpEUBIsZL9nrEMEwy/1CadZiXgZpe1/kRRtT9OIuekzIiVtxTcMT+txOr5w5FDA7hqoAhi1drTzAvo/j+LkYLASbtDg5MGSepAhPljIGGS/zRLqJat/VoK9rR4rHC41O9dWNluhSwXhf708BtDJiLw713eI9dQZTrnQ50MTH7fgHEyONhNcyhEswrmaXSrC+UfrHgUYClykoqynD8r2ke5HJ+abObtbAbYjRUtI1LTce7NvBjEMa6zz7JBTeo3VU8aFdza/lzfaHtUpQg8nAjzwjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 23:22:34 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 23:22:34 +0000
Date: Fri, 11 Jul 2025 09:22:29 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Benno Lossin <lossin@kernel.org>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
Message-ID: <cgh5cj42vkxc66f2utpa3eznvqaqtdo3gszahfhempujj3kxdc@zaor2sx4cosp>
References: <20250710022415.923972-1-apopple@nvidia.com>
 <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
X-ClientProxiedBy: SY6PR01CA0054.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::23) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf3cbd5-9f2b-4884-2d40-08ddc008a62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l0Ctf2kHfwyUC1XFGxlPv+JH2TAsrDa0CxhuQTgvuGP/5DDZIxhmpXM7frpv?=
 =?us-ascii?Q?wu7Jg0Z3v9MhwYwIpzd1sagL1+mQhrNdB5S2UEFI83mYOnryld9lWEhGE5eD?=
 =?us-ascii?Q?1Lg9qXINxoXh2trQCVdlw8c6f4JJurbXdA4ASTHDtIb8NfmzRypDTyJXHZNZ?=
 =?us-ascii?Q?3501zBadGkqZqjYqQ3rzJ6hP9lBBMMewBvE07LR8t5LCta4W++kvwAYYR1UD?=
 =?us-ascii?Q?OEEYR3EwHLqB3VdvcXnVVvzVjPJx3jM7hyAFgmZw5G1e52/K0DsmmhkLNPPz?=
 =?us-ascii?Q?Uz/pWkNq9HlHTAWczYQxaCU6wokMhj0nnFUAsjMHz8zHHygwEV6rkm9X0oYM?=
 =?us-ascii?Q?r3Y5MJSiSrMYABpQZYNPZxrGTQ3xn8FiyHHNXGm5+85gAhzeF9FFK0YwZtgF?=
 =?us-ascii?Q?glPkwiec78t1+EJeMIV5xHcdl5nyvopeSTMex0l8GiIgA6Ukb2XwItxzmGEe?=
 =?us-ascii?Q?8CoIb69yjhC7jckkcOGSeOm+eTD+X3ZXnEEN2V9iff0gUBP/WP/6LBBsuxW+?=
 =?us-ascii?Q?h57SeZW6urEHX74YxJk0no9+/RXOJRDEgzr5khQEv2sNBsql+7ypL3c+dHGf?=
 =?us-ascii?Q?7wWi055Lmn55EGS3l+SC6CfE1kB5uwpNAD0ElAKaJzfuJ6uPToC7UDcIpCOb?=
 =?us-ascii?Q?azRKLz4Fmz853KejcpUYYUuk+y/DyEw75WEubn4oHdw2KdY1j4KsuyruqTfA?=
 =?us-ascii?Q?Rwp0XS3QFzbkQwhJ/p3oFaniXh04/z/UdPIITZb5EP9ToKdGu7n9xnD3WPI3?=
 =?us-ascii?Q?dslTnpFBd4JzT076EyJN9TRrgVERFIVdlw/yMfFV3ObPTnEAALxwiegfNdhN?=
 =?us-ascii?Q?Y+p6xgUPfM00V3h0HkIUrOR5jOiHvI97Ixsbp13A7tTk9PdLQjuxo/rgXQR0?=
 =?us-ascii?Q?/CVmQ9NbBDKJzaFFeu+/jGqnqaB1Z74lViT52UwqcFU5ucR2ELIGPyEx4Ach?=
 =?us-ascii?Q?TV/HO6CdUZQ0eKX8xBaSIioMC41BSrgYCWoudCth87uG875mWWNwvOCPaftX?=
 =?us-ascii?Q?Zw+Lu/730f2r1LMWzQIqLqpLdvCbyRtiFiH1vlfEISejbVbellkR5fJVk8lY?=
 =?us-ascii?Q?Id9s0v8gPsFXSyKVPZkgNxGwa6WMIB739YQg+PBDqsVt4Z9MGcPhfa2mCYbg?=
 =?us-ascii?Q?NsD5dn0Iiq808ck64cGKLY5KQirm3Uwg0cSuy3zy9g8Q5CJ5lSh0gJRCgCmo?=
 =?us-ascii?Q?665LFrZaswOiNvpmys0F0Imc6208ig4VHMwVSn4rvdzp5r9mYuyHv5TNl+Pa?=
 =?us-ascii?Q?UUnXiPVdH2WhPh0TtKXTLd8sfbchHwDdeKGrlWs/YRjMgjUDRfTQw8RBxzI9?=
 =?us-ascii?Q?FDRewSHIT6EZdaPMHhQn4q24/UP9lTDeuMu7gfVsu0uwH9S7gTkrjsZ7uxOZ?=
 =?us-ascii?Q?zrh3BkN2UCnMgIVp7iLimT0+jF9nUBrBtwPwtY4+k56MeSTCFvV9rR45ngNW?=
 =?us-ascii?Q?4iMlVsz6pes=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tiaIdmX4qkskyAGA5WYJfMcdJVRmjMLNwPg//Qm74IEacdouOJIjMRTEAKzb?=
 =?us-ascii?Q?FWaL6uRrGRtukZR6UkwkeceSKLqHe8FsVFgOhXBMf57pNIzzgagGgbJrtBtj?=
 =?us-ascii?Q?E/LuLV2X//yVH+UtQJg7pLdI5GvfMparTTlMRGqCz0fxLu8JHPGctH2xpNur?=
 =?us-ascii?Q?mA+MZ+luHz5EQR7zv7mKCoA9kmLJcXrzkXIh6o+zZs/zHrGBAWabqn1q9SQ+?=
 =?us-ascii?Q?ozyvo0nDWxgAmgwOuXPreyCVuvoJf/jKqWyV8bVkxqErpjq4hVtGjhnKSxLT?=
 =?us-ascii?Q?fwxReF0ts7MyhWO/KohdeBmgzPAL13QcauFSU4fxiYtn3ZBnMxPt85d4n5db?=
 =?us-ascii?Q?gj6ibON9fxcPd9R2iXNZKYUkmc4aW9jRt9XjUOFfc588vVYxDYbdUReQm5JB?=
 =?us-ascii?Q?DTH38vLpSs6KRnP04FEJ95XOU2mpDZ9k3eynioMS5I6lrA+e59y9ZTxz2kpx?=
 =?us-ascii?Q?g1j40XlsAVK/aULZJeEBcJ2anMxuV00a9ZOdahkAcJTRIr76Fvkw6NQ0wraT?=
 =?us-ascii?Q?ZbAO2LVWcZov+zlmZQp+K9oNTDSZDzupJAuyuWLx1gBQ/HGeBsRNIRjGHNts?=
 =?us-ascii?Q?ZCsHNULKaYGnKNjdOTHCPlqCPlqEDIg5zOtRWSisbiLNVIm0V2aYAjpef8oM?=
 =?us-ascii?Q?n+Uo3q7/ph7Meg7MunTfrH9L32+VMfirBh753Dfzikor5A4pcDO5Q3MaqZDn?=
 =?us-ascii?Q?ApBrwy0vGLIvSRgeYX6tWu0IBAZt3yMopwxi0dE3aiWARvfM9c6RgD9d3fIe?=
 =?us-ascii?Q?EUFpHNgzM9tiUA0xor+eLkXgT+0x5hPHd5xNmofgGqRPOImGPa6bebAoY/6V?=
 =?us-ascii?Q?6USVPms/FVtQSYyhOC8tdSu0ytRkfJNsYT9LMl6UOb5TMal0E6TZr0+sIYxU?=
 =?us-ascii?Q?tddOQ2TomLh598JXnmiY4JpmcFp4bne9pW25jHs7c6gHEsi/AnDvNwT8qIW4?=
 =?us-ascii?Q?0dObSxhrRocevICjLI281dFTxTQ4sNi/ClEo4uQPMPbR2nw6HWGN+FYVd/Zs?=
 =?us-ascii?Q?JkNsU9s4kJfgc3ZodOv/w84IuAMW9/BKZ8RZRT3B+QEjyr6ECGmkYRWLmWZD?=
 =?us-ascii?Q?i2Ov7VVFwrt1NH68YGpXGmJ5dqeZSCy2P4bJpuNfXbvXyjoy62oStz3BtAoP?=
 =?us-ascii?Q?HH7J3V8gZ3zvackb7QyD1IuY8JI7yHcjIbgU+t6x8Xy4kfgN9Aq9L4NI0YXx?=
 =?us-ascii?Q?mvOpTQGJsCBd9bSliVjlHdk9dctgmYK/6969uJ07ZF0rA9fkIJCQ/xRL+baz?=
 =?us-ascii?Q?IEwrI37zl5n641qTWv4uggbDmH68iZZ7JExBkXtHxBwRGQVg6pYS9Scjes9h?=
 =?us-ascii?Q?Ncs4BSNblURyrRUH/P6LHTBR8wH4xTcVFUSn6Sf3aPsShYR7QUeApHVR3xud?=
 =?us-ascii?Q?Z9fOLsvJhniH7EF2tjpZK23RUkVpYCxIEVIHMw3+tj7rY9l67yPD0WYHWhcj?=
 =?us-ascii?Q?A4S+FSJalljonq9N02+4G4wE8T8Ehf8oXzQcKPNSVgbSMWDvHjID7ijE5Yx1?=
 =?us-ascii?Q?8eBiglBp3kEapzUSYQ7MJrVdoExmd9MCy8bMUXpio+9RNI0EzkvqSsBaCBwp?=
 =?us-ascii?Q?a4Y4RaPKD1jWvu1EkZ8tMg3f+hfFA7NJqR9xZS7G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf3cbd5-9f2b-4884-2d40-08ddc008a62d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 23:22:33.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ud4UDTJjuCK5+GpJBbqWWA9WgZYvJCZs10/DviKFR9zQNudHf8BHYpexaMa0VrhbIQljiY1MAFqkV8R7ue6P9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144

On Thu, Jul 10, 2025 at 10:01:05AM +0200, Benno Lossin wrote:
> On Thu Jul 10, 2025 at 4:24 AM CEST, Alistair Popple wrote:
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 8435f8132e38..5c35a66a5251 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -371,14 +371,18 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
> >  
> >  impl Device {
> >      /// Returns the PCI vendor ID.
> > +    #[inline]
> >      pub fn vendor_id(&self) -> u16 {
> > -        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
> > +        // SAFETY: by its type invariant `self.as_raw` is always a valid pointer to a
> 
> s/by its type invariant/by the type invariants of `Self`,/
> s/always//
> 
> Also, which invariant does this refer to? The only one that I can see
> is:
> 
>     /// A [`Device`] instance represents a valid `struct device` created by the C portion of the kernel.

Actually isn't that wrong? Shouldn't that read for "a valid `struct pci_dev`"?

> And this doesn't say anything about the validity of `self.as_raw()`...

Isn't it up to whatever created this pci::Device to ensure the underlying struct
pci_dev remains valid for at least the lifetime of `Self`? Sorry I'm quite new
to Rust (and especially Rust in the kernel), so not sure what the best way to
express that in a SAFETY style comment would be. Are you saying the list of
invariants for pci::Device also needs expanding?

Thanks.

> > +        // `struct pci_dev`.
> >          unsafe { (*self.as_raw()).vendor }
> >      }
> >  
> >      /// Returns the PCI device ID.
> > +    #[inline]
> >      pub fn device_id(&self) -> u16 {
> > -        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
> > +        // SAFETY: by its type invariant `self.as_raw` is always a valid pointer to a
> > +        // `struct pci_dev`.
> 
> Ditto here.
> 
> ---
> Cheers,
> Benno
> 
> >          unsafe { (*self.as_raw()).device }
> >      }
> >  
> 

