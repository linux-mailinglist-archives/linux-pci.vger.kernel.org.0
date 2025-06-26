Return-Path: <linux-pci+bounces-30828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF2DAEA831
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 22:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2FAD3B8C41
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80E2255F49;
	Thu, 26 Jun 2025 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRlNPTCq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2BA1DEFE9;
	Thu, 26 Jun 2025 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750969260; cv=none; b=rE/iITLucd4gHZAJMYMRjw3/jLCf6SbuCbYAxqaNuY4gAZubwbXKjFk1y7JAhCVult4yPUc1dj2eYjMJ1RYHQKTzX3+z30iEGpCO0eHTQIA/3WenlTn7NTKcrs3bEa6a/SnYX1x1QhpbYr8RJww6XwKMF8/16sVSF+uDYtPedEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750969260; c=relaxed/simple;
	bh=zuYYb/svee76Q0/Y0zJae78b8I8+Z0dvNVyE4ndS0fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vA9gSU5/rptyvafpyR6toS9E95NMWyoP0tv5bu8flFeIHzCsnGUEiEalRBDcUbe0P8VsYTAaqMD5oVbKQBcV2JKZvEZXk85aXESfhv8EVVRfjNnD/aQyEM1BmI5hv1eteV8ZFnS6OiptYu1YE484RjaDO6wuzC6t4U8hZ/3e598=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRlNPTCq; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fad8b4c927so14004116d6.0;
        Thu, 26 Jun 2025 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750969258; x=1751574058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cq2sD7Val+E8B0RYM+I5xro1zxh/kLt1yENekp/Stac=;
        b=DRlNPTCqselPE2hcJqrWylrHaRzAsPxQN8cjVpv9s4wicfDlRUi8H+Kmd6ff9varyF
         kP/smKgAHnVpXk82QSSSNgTIrTleKC8tkAP7jdWrfMog1g527ygiKDO8voOs2j6fmppo
         Bh8fdl8AvCpAxa6pqOFAYbf0+0mMVTCCmdx+sblInKySX5vbog35Rd7KHyf4PstGKdzh
         UADVLiLm0O01tzW4ODo2IpwSjBkqWkj4XdxZz6E8nn36F/xnIrnDhdMAl9RGEuemzByV
         mT0iXzDQXYO3Ra5Z+GzsA3tezNvE4XJCFLrjdUYSeZBi9wMrZfg/+n2bWs66QD9KAEUz
         KHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750969258; x=1751574058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cq2sD7Val+E8B0RYM+I5xro1zxh/kLt1yENekp/Stac=;
        b=b/8LPTRuTBXnYGsvprBtYX/tMpTn3lnTwCMbKUMPgGG8UXI03GcrjWx9RE1ZnAaPQo
         hP14VyIraDoGWokrnfUCh+PdEU4KW/2mwRpNKkwTTPrUy99cPPRXlpyqlbNlDc1dDvwk
         WRcMnXRFbSj5a3Eg5yzTRG1nrBh/kEoYcbJt4gm6tKVgRROwaaYs/3JgzJtBhXSXqL5Y
         krJNYe8TDRYJo3hS6QWzjS3RHrm5PQNiihFeDUUZwM9G48KYIajCPWl+7xVdFJ1AOhfa
         nWEAS/d5VJx7HFbK9EtILrfymt7Urau4kb3Ra0RqqC3/tXOegwAqx9UYSsXBuC7WOe8o
         XCpg==
X-Forwarded-Encrypted: i=1; AJvYcCVqOPZWcCJA3cK4OqT5DdAj4s184Oq9Nmq0Wo2IfvCjCq+MYemmfmukHbRo1vD2YSrxJS/FLx2j/JhzSfyxQWE=@vger.kernel.org, AJvYcCWp8pbf6OPto7dbR+EKNLMU2zx0G5/eBQsAclK+suOo+l6/AIsCvM+q1d/n8oBD+G/LQ7qzcjNUWD6dNP4=@vger.kernel.org, AJvYcCX4SpurQ36ukSqgmH7lcNOBh+ruNglbPIvv5gpWrLTT4xIlcChEyFavQFdlynPD8WN+cMfz0h0GmSfv@vger.kernel.org
X-Gm-Message-State: AOJu0YzUixZfLT1LtfTv5fsC27KPyyVb77vWT5OnSv/Khw+7/r0wNiM7
	e5nJeCZ7/yeEczU7Zx44HVvjYNiKYCB4jQtLwWZN+cROFsIBnzj9pIDf
X-Gm-Gg: ASbGncvSzXzeKFSH6zKiuVGfM7E97++lo4KxwO2O8wMnx4YPGQVWVRcB7aOxIcQU6fy
	Aa4vMw61eLxIK4PQSIqJuS6lGb4FgbgnqvdohskWKh+vyc6dN+l9ns9M8d7U+VGAAuBCXE6Ja9n
	wQzzhbn2KM8mg0GTU79yFDHyOLcVxOpVyanb7zPmNH4bDO50Wy6ZElRY50CrY5cYLr9UzQoMvY5
	8rUenYdUAuFoSwNa698RaxglibGlmizwC3vuIGkAAjP6+tvKbW1/QQbl9nm791S+ZCLaQQBC8Zp
	gKV3ZTMMGK1wzGl1Des+FfX3p5dLkvOKZBUHSnILVwonQzqUmuIEDF/KAjw47sCYqa85kNecgVS
	Lhvd0M3FmGQRQFInTLbAjZGrT4wxBtQ10EKA/hg66hWYqOWR+CsAC1y7/URzxFtY=
X-Google-Smtp-Source: AGHT+IFpIAq+fBVXqNCfPRHUyR2fuak4GTubSopHufh3JvkJxpJ/6pY2qFrOxr513xCe/NEH4yKIqg==
X-Received: by 2002:a05:6214:2e43:b0:6fb:6114:1034 with SMTP id 6a1803df08f44-700131c4812mr15208706d6.39.1750969257910;
        Thu, 26 Jun 2025 13:20:57 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd7718d048sm11578466d6.21.2025.06.26.13.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 13:20:57 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 00834F40066;
	Thu, 26 Jun 2025 16:20:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 26 Jun 2025 16:20:57 -0400
X-ME-Sender: <xms:qKtdaHIft1jfJYRilxsfCKnUv44zBDlAGlb6Q5kKSvg21ISNJZr9Eg>
    <xme:qKtdaLLrRm3eo3GLnW8t9SJ3u6_Uz7_17UbV5OuHu0-8iALLBfg_lm3liB_by2Ql8
    n9BjaNqe_-ZEF33yQ>
X-ME-Received: <xmr:qKtdaPuebNrI3OCejZ07SJyWAvYvVgYHZ1HE1005ZdknKO9YbQCVbq03AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffeivden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlih
    hnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgr
    rhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhroh
    htohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qKtdaAafXBUPSa9pDkEftAWmSO2xMYtbWtg-idP4P9GHRMMPXMqH8g>
    <xmx:qKtdaObdGlmk0SHsDAL5fuipyQcU8FfanAgzpvGBhB04EhDxd4bLLQ>
    <xmx:qKtdaEC7u5i3yulpRCLiuH0LspT4Rnk_qPQBvyLX1qt1ylXDml20Eg>
    <xmx:qKtdaMbLx0Pd4VgOpLGw8fdPOVZ17ZcZuicSpZ7k8LwEncusFhL94Q>
    <xmx:qKtdaCp0XvRLlFHrYEbTmXoBU9ObGiZu_s1GDBaxJHz_mnZqOhERDIOw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 16:20:56 -0400 (EDT)
Date: Thu, 26 Jun 2025 13:20:55 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 4/5] rust: types: ForeignOwnable: Add type Target
Message-ID: <aF2rpzSccqgoVvn0@tardis.local>
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-5-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626200054.243480-5-dakr@kernel.org>

On Thu, Jun 26, 2025 at 10:00:42PM +0200, Danilo Krummrich wrote:
> ForeignOwnable::Target defines the payload data of a ForeignOwnable. For
> Arc<T> for instance, ForeignOwnable::Target would just be T.
> 
> This is useful for cases where a trait bound is required on the target
> type of the ForeignOwnable. For instance:
> 
> 	fn example<P>(data: P)
> 	   where
> 	      P: ForeignOwnable,
> 	      P::Target: MyTrait,
> 	{}
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

One nit below:

> ---
>  rust/kernel/alloc/kbox.rs | 2 ++
>  rust/kernel/sync/arc.rs   | 1 +
>  rust/kernel/types.rs      | 4 ++++
>  3 files changed, 7 insertions(+)
> 
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index c386ff771d50..66fad9777567 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -403,6 +403,7 @@ unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
>  where
>      A: Allocator,
>  {
> +    type Target = T;
>      type PointedTo = T;
>      type Borrowed<'a> = &'a T;
>      type BorrowedMut<'a> = &'a mut T;
> @@ -435,6 +436,7 @@ unsafe impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
>  where
>      A: Allocator,
>  {
> +    type Target = T;
>      type PointedTo = T;
>      type Borrowed<'a> = Pin<&'a T>;
>      type BorrowedMut<'a> = Pin<&'a mut T>;
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index c7af0aa48a0a..24fb63597d35 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -374,6 +374,7 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
>  
>  // SAFETY: The `into_foreign` function returns a pointer that is well-aligned.
>  unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
> +    type Target = T;
>      type PointedTo = ArcInner<T>;
>      type Borrowed<'a> = ArcBorrow<'a, T>;
>      type BorrowedMut<'a> = Self::Borrowed<'a>;
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 3958a5f44d56..74c787b352a9 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -27,6 +27,9 @@
>  /// [`into_foreign`]: Self::into_foreign
>  /// [`PointedTo`]: Self::PointedTo
>  pub unsafe trait ForeignOwnable: Sized {
> +    /// The payload type of the foreign-owned value.
> +    type Target;

I think `ForeignOwnable` also implies a `T` maybe get dropped via a
pointer from `into_foreign()`. Not sure it's worth mentioning though.

Regards,
Boqun

> +
>      /// Type used when the value is foreign-owned. In practical terms only defines the alignment of
>      /// the pointer.
>      type PointedTo;
> @@ -128,6 +131,7 @@ unsafe fn try_from_foreign(ptr: *mut Self::PointedTo) -> Option<Self> {
>  
>  // SAFETY: The `into_foreign` function returns a pointer that is dangling, but well-aligned.
>  unsafe impl ForeignOwnable for () {
> +    type Target = ();
>      type PointedTo = ();
>      type Borrowed<'a> = ();
>      type BorrowedMut<'a> = ();
> -- 
> 2.49.0
> 

