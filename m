Return-Path: <linux-pci+bounces-24608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD1A6E8C6
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 05:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B04CE7A2109
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 04:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB54F2628C;
	Tue, 25 Mar 2025 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYkbUssC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A173A4A05;
	Tue, 25 Mar 2025 04:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742875374; cv=none; b=AHo4KWob556m/KuPt4jpxAoXe5BclgdpokhpCMWB5poWC6ERmdfd3N/xff82i7ARxGQvR4Fda/Udrv3JbH2EybgKGiv+pj7EUhK/HuWQVPQto5q9oMItrha5JAm3Pr9oO4/mwn4dKDeLtHls91nBO9Smuc6zrKnVDiR3FI7bKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742875374; c=relaxed/simple;
	bh=0QleKfKx3+7JEbvAep9cx/z5aVsYDS0vLUk7PkcEwag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGmbVY4ee7XuFRV5EdSIBh8wC/87sjDQvlvWSiaFewWgniz3P+j36MfJ2UZbUdxzZqW4O9NC6GbyprpJkNomN9mZ0O7invr+14/0SutupL26rGtQK/CfCUNUOSQBJTDF7GzQU8kh88N5ZYzaJ18I32lrKRjaLzl0x6QHEgwOFNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYkbUssC; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4774193fdffso24484371cf.1;
        Mon, 24 Mar 2025 21:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742875371; x=1743480171; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KGInYOKpBu6xGCgfKciFdK87cegZomp2gFItoPQocck=;
        b=QYkbUssCThtefZ6eAu19ixBTTEddKJP5hUhTHKn4x7ORLyE4K1S7GU6gYkDJGwB13B
         r+9ziPGRv0JRndu2P31oeF6p2LTg86vQ7RbKKPAXdmMHY2H4axFy9L7A7htfrf4KepSC
         ne69xe2Vu5RoU53oqqdl16LvUdib3gvtukqGaDG0XWn4LEyJCg6WWi8kuSnte0WrH8Z8
         oWGhDgLQIV7pFvTkG8GlGkfMqGP3InJsL3oqvvrlhVBwls+G8QHJqDYO788un4Bab8bO
         nf2gK+W/gFNFF7LZMLi01y4hPyI/ZZGJflttyrVbV2ys9kEOtVbY78U5mSkKzzisn1hM
         GGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742875371; x=1743480171;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGInYOKpBu6xGCgfKciFdK87cegZomp2gFItoPQocck=;
        b=SIsy9zr7DxvFhpOhoTqIeLLYcOdZ5YBgt7Ao7evM8kx2dL2t+C92zOUZM+BtZZ9swn
         +aEw+usxUsmi6FmZ79zPJiMPYTVXOMrcTXMVFSONbEi72meQDNKhbKxRtWBy6zxqcJUS
         njGvjHSXw9xHLv+7gm+yUt7lJ6pHVf3GrnIfmz7AqneBPvOI6SIg9ilIhc1pV/D7ZGtC
         6zxXeRql0LJQ7pn9y4HGbw+jCGZQ60qplizIt4dBd1x4dTRMdpiCSf/++nb8kLCgq1/1
         WOA3e3Cr7d23j077JcO6H4r+9l7ABFtZ8g8YrVksH90Ys07KK4XqhO93n9QgTSAP67+g
         /oQw==
X-Forwarded-Encrypted: i=1; AJvYcCVE5yEC9itrtKa2vUfZHR/68ZkhsD0tpFeO3DvKSBohxunBZCoAEJmQw/ezr/qP8VCjDcblEtw25mQby9MMepA=@vger.kernel.org, AJvYcCVpRVL05/jXWdQQ0MW1em8Ihx1RfzuS/dU+HIfsV/Tq9Oazwhyts30HBLmj5kg6JmkqhsnkhMD04TAw@vger.kernel.org, AJvYcCXPmVTu5hAm2KFLZxASrjpfXiYjhmGQLzwj3o4ZHj4jbcCVRSUP6uYeRhTsYr/fN/if+pEuowQRXmh2Z1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPWgsK46AZviSgcy1rKMIrm56zVjRM+k+09mlzc4oan2lugjx7
	ToM6GVqNyv6HjqZF/OjhcuZW5L3G6NhvKxKhuJ/A/uPf4cGpjUec
X-Gm-Gg: ASbGncsvecGyQlictBHpAz7zQbQP/0U+X6dA1zXuKAqgj6oYvpfjKBtQpuK+OkpeBJw
	c261zC4CqnQZk59R6t9lVI9Ke2dEhvVodvA0WgJ3Pn0okGYzOYsbqKqViZ3CH/P9gc7sEKfMMs2
	FWX7Cm7Xu/f7sjiLhMDWRK3kKEIOMyDfw1ONRu5q/FwbLzecGy40Yg0oH31VSMBcctdRbnzTnSd
	bfV/DZ+Mq0lztlmlkLL8h5RSOFgjogYagUtIQzbFPOTQohljXAP7WM7OcF2ff4UDq9g6GYm0qgu
	VS/VT3yp3JRW/G4FIuKTiAYFYYKXX4vtJ+iE+tZRB9rV0JsTGWMYG8Glv4QcTs6mJBSeJU7dz9f
	ZVeyOw7/pvJgtsYffSx2ngyWdaMp/cwVq8sk=
X-Google-Smtp-Source: AGHT+IGgVbi/YlG27PUIcuRctsRoEQHsggM20XkTEzCPpJTzpTw4pxS0MwqWHBizCL/grByDThmSNA==
X-Received: by 2002:a05:622a:8c4:b0:476:8cad:72d7 with SMTP id d75a77b69052e-4771dd6086amr247712261cf.8.1742875371191;
        Mon, 24 Mar 2025 21:02:51 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d179f42sm55669171cf.25.2025.03.24.21.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 21:02:50 -0700 (PDT)
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfauth.phl.internal (Postfix) with ESMTP id 50714120007C;
	Tue, 25 Mar 2025 00:02:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Tue, 25 Mar 2025 00:02:50 -0400
X-ME-Sender: <xms:6iriZ8oxNAkGrfM0mRWiGFfg5hdpITz2bCv0nG7JqDzMQ8iGwfyocg>
    <xme:6iriZyrLIiqShoE_EqGU0JBJC4D7ln7xWEqV8LR_4g3QKiJoFw-MyLxXVvvAPm2Lq
    XCXk6P_itMkvEo_EQ>
X-ME-Received: <xmr:6iriZxOVcOG6x_xgnP3v9nye8ABWdGoUIhGBUULddb-FKZKgoEtTrNhN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieduieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeel
    tdfhgfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedujedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghl
    vgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrh
    ihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghi
    lhdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvg
    dprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhroh
    hsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:6iriZz73RU_t0RmI_MYZwAaVH9GULDlMd0xqudLhye4QEZ8s6bIixw>
    <xmx:6iriZ769V4qAtattThW_488CU8zjYkCl6pMGTaEvh1F27VhvYunZjg>
    <xmx:6iriZzga4-veHxbaLFmuAU1qp2lrJx0oyowqbu-2ACz3ofiF6-GSuQ>
    <xmx:6iriZ14Lfqd0hucK2yc13v4PE8DUmADu41QQUKzWEy6Va4GXDMdKbw>
    <xmx:6iriZ-IXOpYWm-GjaFspaA957CmkcCdLltVTT_JWhI2Yle1xHZ7ot4H8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 00:02:49 -0400 (EDT)
Date: Mon, 24 Mar 2025 21:02:48 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/5] rust: list: use consistent type parameter names
Message-ID: <Z-Iq6Okk1j3ImH1u@Mac.home>
References: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com>
 <20250324-list-no-offset-v1-3-afd2b7fc442a@gmail.com>
 <67e1d1b3.050a0220.4c4ff.6e89@mx.google.com>
 <CAJ-ks9moCO83cGkKuONR-2JMN61x18T2UVO98jhspDR=uyaVqw@mail.gmail.com>
 <CAJ-ks9kPhb00-Dv8KucYGOVjLFMVYvfpBnqrV87M+eJmODAmyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kPhb00-Dv8KucYGOVjLFMVYvfpBnqrV87M+eJmODAmyw@mail.gmail.com>

On Mon, Mar 24, 2025 at 05:56:57PM -0400, Tamir Duberstein wrote:
> On Mon, Mar 24, 2025 at 5:51 PM Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > On Mon, Mar 24, 2025 at 5:42 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > >
> > > On Mon, Mar 24, 2025 at 05:33:45PM -0400, Tamir Duberstein wrote:
> > > > Refer to the type parameters of `impl_has_list_links{,_self_ptr}!` by
> > > > the same name used in `impl_list_item!`.
> > > >
> > > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > > ---
> > > >  rust/kernel/list/impl_list_item_mod.rs | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
> > > > index 5ed66fdce953..9d2102138c48 100644
> > > > --- a/rust/kernel/list/impl_list_item_mod.rs
> > > > +++ b/rust/kernel/list/impl_list_item_mod.rs
> > > > @@ -41,7 +41,7 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID> {
> > > >  /// Implements the [`HasListLinks`] trait for the given type.
> > > >  #[macro_export]
> > > >  macro_rules! impl_has_list_links {
> > > > -    ($(impl$(<$($implarg:ident),*>)?
> > > > +    ($(impl$(<$($generics:ident),*>)?
> > > >         HasListLinks$(<$id:tt>)?
> > > >         for $self:ty
> > > >         { self$(.$field:ident)* }
> > > > @@ -51,7 +51,7 @@ macro_rules! impl_has_list_links {
> > > >          //
> > > >          // The behavior of `raw_get_list_links` is not changed since the `addr_of_mut!` macro is
> > > >          // equivalent to the pointer offset operation in the trait definition.
> > > > -        unsafe impl$(<$($implarg),*>)? $crate::list::HasListLinks$(<$id>)? for $self {
> > > > +        unsafe impl$(<$($generics),*>)? $crate::list::HasListLinks$(<$id>)? for $self {
> > > >              const OFFSET: usize = ::core::mem::offset_of!(Self, $($field).*) as usize;
> > > >
> > > >              #[inline]
> > > > @@ -81,16 +81,16 @@ pub unsafe trait HasSelfPtr<T: ?Sized, const ID: u64 = 0>
> > > >  /// Implements the [`HasListLinks`] and [`HasSelfPtr`] traits for the given type.
> > > >  #[macro_export]
> > > >  macro_rules! impl_has_list_links_self_ptr {
> > > > -    ($(impl$({$($implarg:tt)*})?
> > > > +    ($(impl$({$($generics:tt)*})?
> > >
> > > While you're at it, can you also change this to be
> > >
> > >         ($(impl$(<$($generics:tt)*>)?
> > >
> > > ?
> > >
> > > I don't know why we chose <> for impl_has_list_links, but {} for
> > > impl_has_list_links_self_ptr ;-)
> >
> > This doesn't work in all cases:
> >
> > error: local ambiguity when calling macro `impl_has_work`: multiple
> > parsing options: built-in NTs tt ('generics') or 1 other option.
> >    --> ../rust/kernel/workqueue.rs:522:11
> >     |
> > 522 |     impl<T> HasWork<Self> for ClosureWork<T> { self.work }
> >
> > The reason that `impl_has_list_links` uses <> and all others use {} is
> > that `impl_has_list_links` is the only one that captures the generic
> > parameter as an `ident`, the rest use `tt`. So we could change

Why impl_has_list_links uses generics at `ident` but rest use `tt`? I'm
a bit curious.

Regards,
Boqun

> > `impl_has_list_links` to use {}, but not the other way around.
> 
> I've changed it to `{}` so it's consistent everywhere.

