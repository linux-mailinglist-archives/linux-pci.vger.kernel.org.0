Return-Path: <linux-pci+bounces-31805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309D5AFF1E6
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 21:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8243B3B5CFF
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 19:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A179924A063;
	Wed,  9 Jul 2025 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCcTE6/R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C412C2459F8;
	Wed,  9 Jul 2025 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752089484; cv=none; b=b+0IbpCMnw17erPt6P4suXZ27rI968rdZLxFT1XgqgOGER/CTi1gaWjJ2blY4fTrDXRH6IIIvMvMllAQPhu9RUo69nH9FKqZDgDD5l442vnIxXQOaVzO0Dyq8+4xgKyhlvAGD/he1RkKl5z0puGL4lHicVXFOXN6+cmaE7k3gA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752089484; c=relaxed/simple;
	bh=3DNAJWvLRtEJowZIvRUsC3Fczpnq2whgqr5slNeRHe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+a/hAmAKTCCsT4qK0KW5cIZdQDCpy22x46JHFMSVdL7IJwQE+G5aVv5bu4j1QxH2e+pdltx87bBPr7JA3S/HuGFD1dpAEoTFXupnZ4lKwqTvANzXhGbzSvJb9OzDQk/syGA1k/ewH1HP5AQc/kWXq66oevNO41J3I3Yu4BVBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCcTE6/R; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d5bf3300e0so24564485a.0;
        Wed, 09 Jul 2025 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752089482; x=1752694282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8yQiVm26KnYiDPwr+Fn0NC/lRVqVNayR01QyLZe95Y=;
        b=TCcTE6/RhwQ7yObZzW2oYrHPG7WK6874HJp7MWsGFeNJ8lEpwZLtNEhqh+BNlYiz9q
         UdDUXRkmKoLboE1c81kuBkUsDwhr/oB+HupMTqmCoPgkdiIxsz4eXU8J6u8JiWSDx/BT
         Lx0OlY5deykKN1rb5DyJ4DLzFn9Dl+VQAuziVx8n84BXtdFQ06V93RUB6VKMFUPKEZxS
         iYmDtuQpaByFT/hNkKUk9o8R5lBsBZiR1A1OYtDBF25fbP/FCT+mJ8qvUK/9mPQmX3P1
         VovHGZgWatNKti3FeV5eVg9H4JSmJwXxUME0NP9aNIeIMwcOwbmlXnkaLo0bdofW3yDq
         t1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752089482; x=1752694282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8yQiVm26KnYiDPwr+Fn0NC/lRVqVNayR01QyLZe95Y=;
        b=A3S7Qbqjng5rvM2+wboNv+Em92kQ63NFwNiAgydgbkOyJQri2ARDTVCcAenuYqguVv
         miADe59nJ4MBX3ws93HdMkQKQtaZtGjLiA+Y4hVQOUo1Fw4FKrGr0fFj/xk5pt8ehGde
         JYPFUUjhKKLYVLP3QrbqEOZKXDfrz+OjICzkDgAXug2b5gs8D1SyD3FlXgW519TZuG3/
         M7DFzHU6H8L5LEUWsSy5s2tGD9D5rmfiocBILFqmYqIzZCk1wu4hpjvxQTL5QgtFLeO4
         ND9ByYKKarptnxErUqdfHd8F7KcFTSF29Pz9ercrh6fx0KWj4V2gpVFuHPlQJxzKhni+
         duMg==
X-Forwarded-Encrypted: i=1; AJvYcCXogc2DPHH0EZ6OS0c0fouEEmJhlyV7BckOJFiHlL85P/8Al6Ds+pYBBa19OL+3wJG5H5XA2wgi2HW4@vger.kernel.org, AJvYcCXxc8KWuZgc8ve4jyjsys/+mk7YjpzhH+WZ0wYKdamsZlB84Gida8YiQu87q265mOz2MQ0/W50k7uHN5Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRpp/WIgrjFThFzhLyzZVlL2Rm3EaPXH1wvTqxQgyMEl4McCUp
	t9bfqk8kSUCtkeYL7qVIvfbcRBn07MP5Ku2gzci+QmL3SHbasf5VVoah+O7sk7xJVJ8=
X-Gm-Gg: ASbGncvCtZzGZ+adK6p6TefwCJm803YKxcA+ueZV0SEfTOwwMmW1lEU5pG3wTJJy7Sl
	QSdORohF87oZ10pdl/3HvklBCcD2BgbIbhmKtCOstii0wKEnN46L7IzDOKO3/JUJKGolxvjvN1o
	WsdHHlasMs9J1XhQYaG1M1xER9TSBxMw8xySqF+gfdVzWt/Mv8y/hUEkuTForyIM9w9E0qZBZMv
	yRL7ChPsRsY9JBAZcKP0D287xB4AVTbniTPRJoSfRis5BiR8oqmNtaAhN6weDvfJkOtdO4cOiaC
	AkW08ZCAQm32TXDcvicFsXKysqz5+M/IdsuITdhmHf+flPyY4ivNqfQgYgJu/4BS06EA08IqvZ/
	ssZ/oImTmaxKsvrlp+RsN5hDobXvSL9AIYpYU6OBCetvHrg7+kO9w4k0uQA==
X-Google-Smtp-Source: AGHT+IHstsMLtpHJtmUeLaN3AyaPEQ9RkpBEHln6ZY+SMqs1MuqjLI0CBdNKRfIwAn8Gw5NogZG6Eg==
X-Received: by 2002:a05:620a:a81c:b0:7dc:c315:a399 with SMTP id af79cd13be357-7dcc315ad52mr12561485a.46.1752089481346;
        Wed, 09 Jul 2025 12:31:21 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbd94242sm991741285a.9.2025.07.09.12.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:31:20 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:31:15 -0400
Subject: [PATCH v4 5/6] rust: list: add `impl_list_item!` examples
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-list-no-offset-v4-5-a429e75840a9@gmail.com>
References: <20250709-list-no-offset-v4-0-a429e75840a9@gmail.com>
In-Reply-To: <20250709-list-no-offset-v4-0-a429e75840a9@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752089474; l=4790;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=3DNAJWvLRtEJowZIvRUsC3Fczpnq2whgqr5slNeRHe8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNp9mno1xwwB7+iVCKPc5wW+/gokOKXsP1KF6DjEXqwqfOhx6a5wQE+CUiGxj+K1mwUan2FJ5Gx
 UP+jDpst8gw4=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

There's a comprehensive example in `rust/kernel/list.rs` but it doesn't
exercise the `using ListLinksSelfPtr` variant nor the generic cases. Add
that here. Generalize `impl_has_list_links_self_ptr` to handle nested
fields in the same manner as `impl_has_list_links`.

Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/list/impl_list_item_mod.rs | 96 ++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 32087aee4c87..6b67c0ecc57b 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -82,20 +82,20 @@ macro_rules! impl_has_list_links_self_ptr {
     ($(impl$({$($generics:tt)*})?
        HasSelfPtr<$item_type:ty $(, $id:tt)?>
        for $self:ty
-       { self.$field:ident }
+       { self$(.$field:ident)* }
     )*) => {$(
         // SAFETY: The implementation of `raw_get_list_links` only compiles if the field has the
         // right type.
         unsafe impl$(<$($generics)*>)? $crate::list::HasSelfPtr<$item_type $(, $id)?> for $self {}
 
         unsafe impl$(<$($generics)*>)? $crate::list::HasListLinks$(<$id>)? for $self {
-            const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
+            const OFFSET: usize = ::core::mem::offset_of!(Self, $($field).*) as usize;
 
             #[inline]
             unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$id>)? {
                 // SAFETY: The caller promises that the pointer is not dangling.
                 let ptr: *mut $crate::list::ListLinksSelfPtr<$item_type $(, $id)?> =
-                    unsafe { ::core::ptr::addr_of_mut!((*ptr).$field) };
+                    unsafe { ::core::ptr::addr_of_mut!((*ptr)$(.$field)*) };
                 ptr.cast()
             }
         }
@@ -109,6 +109,96 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
 /// implement that trait.
 ///
 /// [`ListItem`]: crate::list::ListItem
+///
+/// # Examples
+///
+/// ```
+/// #[pin_data]
+/// struct SimpleListItem {
+///     value: u32,
+///     #[pin]
+///     links: kernel::list::ListLinks,
+/// }
+///
+/// kernel::list::impl_has_list_links! {
+///     impl HasListLinks<0> for SimpleListItem { self.links }
+/// }
+///
+/// kernel::list::impl_list_arc_safe! {
+///     impl ListArcSafe<0> for SimpleListItem { untracked; }
+/// }
+///
+/// kernel::list::impl_list_item! {
+///     impl ListItem<0> for SimpleListItem { using ListLinks; }
+/// }
+///
+/// struct ListLinksHolder {
+///     inner: kernel::list::ListLinks,
+/// }
+///
+/// #[pin_data]
+/// struct ComplexListItem<T, U> {
+///     value: Result<T, U>,
+///     #[pin]
+///     links: ListLinksHolder,
+/// }
+///
+/// kernel::list::impl_has_list_links! {
+///     impl{T, U} HasListLinks<0> for ComplexListItem<T, U> { self.links.inner }
+/// }
+///
+/// kernel::list::impl_list_arc_safe! {
+///     impl{T, U} ListArcSafe<0> for ComplexListItem<T, U> { untracked; }
+/// }
+///
+/// kernel::list::impl_list_item! {
+///     impl{T, U} ListItem<0> for ComplexListItem<T, U> { using ListLinks; }
+/// }
+/// ```
+///
+/// ```
+/// #[pin_data]
+/// struct SimpleListItem {
+///     value: u32,
+///     #[pin]
+///     links: kernel::list::ListLinksSelfPtr<SimpleListItem>,
+/// }
+///
+/// kernel::list::impl_list_arc_safe! {
+///     impl ListArcSafe<0> for SimpleListItem { untracked; }
+/// }
+///
+/// kernel::list::impl_has_list_links_self_ptr! {
+///     impl HasSelfPtr<SimpleListItem> for SimpleListItem { self.links }
+/// }
+///
+/// kernel::list::impl_list_item! {
+///     impl ListItem<0> for SimpleListItem { using ListLinksSelfPtr; }
+/// }
+///
+/// struct ListLinksSelfPtrHolder<T, U> {
+///     inner: kernel::list::ListLinksSelfPtr<ComplexListItem<T, U>>,
+/// }
+///
+/// #[pin_data]
+/// struct ComplexListItem<T, U> {
+///     value: Result<T, U>,
+///     #[pin]
+///     links: ListLinksSelfPtrHolder<T, U>,
+/// }
+///
+/// kernel::list::impl_list_arc_safe! {
+///     impl{T, U} ListArcSafe<0> for ComplexListItem<T, U> { untracked; }
+/// }
+///
+/// kernel::list::impl_has_list_links_self_ptr! {
+///     impl{T, U} HasSelfPtr<ComplexListItem<T, U>> for ComplexListItem<T, U> { self.links.inner }
+/// }
+///
+/// kernel::list::impl_list_item! {
+///     impl{T, U} ListItem<0> for ComplexListItem<T, U> { using ListLinksSelfPtr; }
+/// }
+/// ```
 #[macro_export]
 macro_rules! impl_list_item {
     (

-- 
2.50.0


