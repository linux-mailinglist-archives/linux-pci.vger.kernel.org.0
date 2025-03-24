Return-Path: <linux-pci+bounces-24586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3F2A6E5DC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 22:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D6218861D5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 21:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BEF1DB128;
	Mon, 24 Mar 2025 21:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcSxi2QO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFAC1B041E;
	Mon, 24 Mar 2025 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852535; cv=none; b=miQHf/hQ0TyAUTiOKv1sisbZWPgkkOvDGLKIlllRolnVP2h0jjc3G0B0ySd09PU5Z90ITTRsVlYufOLhwuAs1UrSSXTn1AoLOPTHIbLhckwGsxYYPlzJcZFB0fqxvDrDZq5xmzJoad/sF3jlnxrlpIwlqyCqUiKjUpAnMgl64nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852535; c=relaxed/simple;
	bh=c+tJq1UvWu2a0LsZFFCRYsrEzZEoy5kDizNP9ol012o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3tBSpCbMd4iqwNQBpYOMIeoYq0K33EzTggLBl9rQqcj2v7CP7pHO8VUZ9tzyZoNc4cyWaovqTgsBzaMHdO1HLmWgbhwlX74GASHdzbIkFpnViB7mvyrl8N0CZw9r8D0GrdwePQw/8m3ONapqLVIg/9LcYB5Um61LZP89DL6RY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcSxi2QO; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c08f9d0ef3so272004585a.2;
        Mon, 24 Mar 2025 14:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742852532; x=1743457332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Shkyw0VYIbldArfT0tbKW/lwbPbWjSentgVMxQM4+g=;
        b=GcSxi2QOpB7gUyhA8ECLCRY+GCk7oPPQdDF8s9o4u9G7sUJW57zFSou423rMqiHmGu
         08IuR7VgB+k0JnEte6DrgsMx0FCSrJqjW1KsjhODf8Ju9aiBXzHaXojM/gpUNUahIEHI
         adAI+fNwI2OSqg9NhHb7O7RHOKQP/LZbBFEmEJfKzPaS6i91vn9cyiiQnh+hnSntpe0P
         lJ9dmXmQhNLMgofS77fcT83G7TD3Bg5ZxAxvI1GnbS0gXhM5QbnDQPsCZ4LoN5wjGcHg
         R1aWA1pRqsfSDJGj8xDpHkCWXbrFi5n/gkX+mhgewxKsnlGgvkGr9RiMuDyEEQhH2i2S
         DAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742852532; x=1743457332;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Shkyw0VYIbldArfT0tbKW/lwbPbWjSentgVMxQM4+g=;
        b=pwN97n5sxFDJGzx+ezn2lA+WtZjOiMbX7QoD/j1t9IGhcQpQpqeVv9DeX8IAFpBuX3
         uwRyf1a6nm9/TrJAvH9EXbob+SNBRSugakbZkj0z4k+H4dOP6Vns/DIBpIVCUscWXpf0
         jNFVlSZott0nENEoQMJUWibPvSVeZc48/IxAcghdy6SlFCXCWAdDUV2Mt61BxjtmOMnx
         XoFAMG3SMOlsP1SgdJyAbcTtJolDI5qTeas960zT86IGj6fpa0F5LFEykhimmiWWl9qa
         4JUFg9MKeoy4/JWuyqrBZZ8upPBybaYbbcfwa1ruTnxyAxPjXmAuCdGm8omrIkmtA3AA
         QLtA==
X-Forwarded-Encrypted: i=1; AJvYcCUF8kfa6k6DGaSG+etuN5AFzvkK6z2GNI/32wnjfOHoVEdJPFN/y9D/4k+3CQcl74vX+u6LIsZ65KS0IJfvEFg=@vger.kernel.org, AJvYcCUMxLRKyIcDaZnQgCUsbqwrFabKmFaSBzWZZwSS1mxPGljg9ILjSXKlJkdB+Q6vZ9oEcvN6kgWgf4WrtRY=@vger.kernel.org, AJvYcCVe+nGgh53UibrcdvfHSyvIPCxFCeb8vmu9aLIfjeRcHOoM/A9thJX0lXChurKMJtPPyVSdR7UuynzU@vger.kernel.org
X-Gm-Message-State: AOJu0YwlNpaQJyequhIKZgKsCSAlITOF59h+YKGbI4gDBZTSv/z9gURR
	TnzLkDwer3DooijINEUoEpMKMgyLx9NJwcMO+rOObDUQpXm4Q0hl
X-Gm-Gg: ASbGncsj3ne4bZU8aRd92O3+3ZpmKf9Me8L4845GYW8svY8PrKcjcVABaV51EcO8VKf
	ZevYr8YDJHimlLvRXVKlUzVDzHQqX3USuxzM/KL7lXfXQsQKLMV1MEZJgnBaF1ohVb9Np7dVXga
	UF3Bof92SVJBeNeFgWBtSAJy2HxDv9fCkiWovmIHqEAJtTrJwDzVegWuJuUtT9ymLl65NEQikE3
	FgppwO5WtWZzo8RFGuoGW7F5p5lWYF/qJ61JjDZ8P6pF+1HZjeIn6oUgcui7Z34PiprCDAz564/
	YNaWjr3TAwiijPqBZCzBEbmJgNj9znpZsyZMYAQWTiGk4vxm5+qA04vN6n+EtwHTUrBxKFg13tH
	gicrysDohJPz0/FWkxxcQNadqEz6ilQ/uAro=
X-Google-Smtp-Source: AGHT+IHLTf64tYHTEfgzC8U8yh+VPIkssh1JNylqaoWQmk+iCaoBk4tmRwTQHKVQ2PpRD76yr4DFkg==
X-Received: by 2002:a05:620a:26a0:b0:7c5:a5a2:eea3 with SMTP id af79cd13be357-7c5ba191a14mr1930615885a.34.1742852532019;
        Mon, 24 Mar 2025 14:42:12 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92b2999sm557698885a.22.2025.03.24.14.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:42:11 -0700 (PDT)
Message-ID: <67e1d1b3.050a0220.4c4ff.6e89@mx.google.com>
X-Google-Original-Message-ID: <Z-HRsI2IiZ_y6mD2@winterfell.>
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0DA9A120006C;
	Mon, 24 Mar 2025 17:42:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 24 Mar 2025 17:42:11 -0400
X-ME-Sender: <xms:stHhZ-nfvJrm09fQEofrnmNDensfea-zW_fmIvEZGMYwJc9GNXwo1w>
    <xme:stHhZ13IWFS42m73RXHtPqF7_HDkO_rFPi-jNnOG_Y9HaBsYqMKmSLX5GB2_A5YDC
    gr_GsV1W-RgRNnoVw>
X-ME-Received: <xmr:stHhZ8o17QD7NDfITS9qt4-VEpEFTgGtYaA375GVahybKuyeic4W5G1ugbtEIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudejpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehtrghmihhrugesghhmrghilhdrtghomh
    dprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgv
    gidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhi
    hguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhl
    rdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpd
    hrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehtmhhgrhhosh
    hssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:stHhZynPboqekNatTy8osoGDuD6QcaJZh0zNn1Af_C3JVJlnmJzjzg>
    <xmx:stHhZ83OXENMiRG_WUG_8gKcoxYC4q43YnNkp-jixbllkuCoTrIBJw>
    <xmx:stHhZ5vXMvx-g-Ue5KIryESCmp78O1IEVG-SYMGmo9kQHKFtxHswLQ>
    <xmx:stHhZ4Wg3K7MUhdABPsZ8oCRn0ROI6KsEzhzv7Rh_A1V-ElBwEVOeg>
    <xmx:s9HhZ32jdAWO1xKBLvB0lT5qtcDmr9oRIVg5BPgQNGHxe1zFYoU006OF>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 17:42:10 -0400 (EDT)
Date: Mon, 24 Mar 2025 14:42:08 -0700
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
References: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com>
 <20250324-list-no-offset-v1-3-afd2b7fc442a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-list-no-offset-v1-3-afd2b7fc442a@gmail.com>

On Mon, Mar 24, 2025 at 05:33:45PM -0400, Tamir Duberstein wrote:
> Refer to the type parameters of `impl_has_list_links{,_self_ptr}!` by
> the same name used in `impl_list_item!`.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/list/impl_list_item_mod.rs | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
> index 5ed66fdce953..9d2102138c48 100644
> --- a/rust/kernel/list/impl_list_item_mod.rs
> +++ b/rust/kernel/list/impl_list_item_mod.rs
> @@ -41,7 +41,7 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID> {
>  /// Implements the [`HasListLinks`] trait for the given type.
>  #[macro_export]
>  macro_rules! impl_has_list_links {
> -    ($(impl$(<$($implarg:ident),*>)?
> +    ($(impl$(<$($generics:ident),*>)?
>         HasListLinks$(<$id:tt>)?
>         for $self:ty
>         { self$(.$field:ident)* }
> @@ -51,7 +51,7 @@ macro_rules! impl_has_list_links {
>          //
>          // The behavior of `raw_get_list_links` is not changed since the `addr_of_mut!` macro is
>          // equivalent to the pointer offset operation in the trait definition.
> -        unsafe impl$(<$($implarg),*>)? $crate::list::HasListLinks$(<$id>)? for $self {
> +        unsafe impl$(<$($generics),*>)? $crate::list::HasListLinks$(<$id>)? for $self {
>              const OFFSET: usize = ::core::mem::offset_of!(Self, $($field).*) as usize;
>  
>              #[inline]
> @@ -81,16 +81,16 @@ pub unsafe trait HasSelfPtr<T: ?Sized, const ID: u64 = 0>
>  /// Implements the [`HasListLinks`] and [`HasSelfPtr`] traits for the given type.
>  #[macro_export]
>  macro_rules! impl_has_list_links_self_ptr {
> -    ($(impl$({$($implarg:tt)*})?
> +    ($(impl$({$($generics:tt)*})?

While you're at it, can you also change this to be

	($(impl$(<$($generics:tt)*>)?

?

I don't know why we chose <> for impl_has_list_links, but {} for
impl_has_list_links_self_ptr ;-)

Regards,
Boqun

>         HasSelfPtr<$item_type:ty $(, $id:tt)?>
>         for $self:ty
>         { self.$field:ident }
>      )*) => {$(
>          // SAFETY: The implementation of `raw_get_list_links` only compiles if the field has the
>          // right type.
> -        unsafe impl$(<$($implarg)*>)? $crate::list::HasSelfPtr<$item_type $(, $id)?> for $self {}
> +        unsafe impl$(<$($generics)*>)? $crate::list::HasSelfPtr<$item_type $(, $id)?> for $self {}
>  
> -        unsafe impl$(<$($implarg)*>)? $crate::list::HasListLinks$(<$id>)? for $self {
> +        unsafe impl$(<$($generics)*>)? $crate::list::HasListLinks$(<$id>)? for $self {
>              const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
>  
>              #[inline]
> 
> -- 
> 2.48.1
> 

