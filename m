Return-Path: <linux-pci+bounces-24582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116B1A6E5C2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 22:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4B3175592
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 21:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072601EF0AB;
	Mon, 24 Mar 2025 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmwtLKQM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D91EDA22;
	Mon, 24 Mar 2025 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852044; cv=none; b=otZwO4KXckPgxfg6vMmcHR6CQiXS1+M//8iHp3qbc1gOk65QX6KR7yxysAj6kz9P74eSyb/AsZ8vu19/OdSQ5hF4vpvVBY2eRd/UNiV05X9ffQa+qAJKbT2ZrZHzD1O2Yp3GMc28v5e0eJ6hT9XPCtsqxjYZbgNtcfntz6L3rFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852044; c=relaxed/simple;
	bh=yh8j1BJZqcNaOViRUXHo+n8R+JB96pf3PLd2pg6YpqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QdOLnfbSIWxJQTuUblr0b4/zROpY+8vcJvw2LJkV6mn6viGwZBEFOG+FyaUI1hlB4bl2EWXLCL8Pibsd4p6geulE1AWD+77xXORyMs5WpIFY0ibw9FbL6daFiTGzZHcJ2kskcMqZj/RK3yW5GNNozWD4AApDwYBsbd72j8T1uJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmwtLKQM; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c59e7039eeso684609485a.2;
        Mon, 24 Mar 2025 14:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742852042; x=1743456842; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7f6jbjUsppRuEOrY1E+FMO2KFZ0EMMyVLzWv4tcTkY=;
        b=QmwtLKQM9gRUp5vsLDHtc3F0ON8i6BFXDavZ3gJzx2EiIJ3ckBDolpNMfH/bU1Ge7g
         7HlWQAucmXHSIlydtNU6aVn9iXY7yeRgABM0L/2e6zdCxncsgqZ3pECWDRZywZc9zaQP
         HnhVgwAM19rQU5qcivvYSJCSYlt3c+ZQ07IYKh6v66t52JbimPRB9jbpo25N/a9Jxdv+
         67zgjVxBbXUcmMoZuSe9EiYXZLLehc1CjW+6fIGn9M9cmahOabfqCfFbTUFNh3OxXx+p
         8X+R4GWJgjOI50cP1AjeThOp22FGA5Tc6rscNAZt2ryH5HBqfJ2pQxSJME+j9UOKb3Pr
         kGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742852042; x=1743456842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7f6jbjUsppRuEOrY1E+FMO2KFZ0EMMyVLzWv4tcTkY=;
        b=VIyoJ8LXOHx78ItcIJGVt3pS2w9pcpwfPTQnsIz7mMlW8Z0SZHxWHNTfzVuAae50Nk
         Ojm2+ZWBI4rBRMTjFSchUaMITIkq2HMsIMywef5o5wF4OGUBCXPdV3btK9hVLcIJcaSC
         XsVict+H+MR2bhnfE8NL0DlwBdn2JLGrnRGxTW3+C4xmyzI8EmGOJZk4CqTHaCIxSw2G
         DE2ZRKLQKp8j7XIh0UFsBPA6e3VnzXt8THU9Z4Ug7jUmAhKOJ5ZqHLFpsr6jE8Ppn/ZE
         6WraoFu3/c56wKtYvTtEhoBrarZcQZsOwxVaOl8+vog2hl39MIMOMPg4VczOJTcgQKv8
         tr6w==
X-Forwarded-Encrypted: i=1; AJvYcCUdhah7O4MJyE/uJ3gRsZMQCPVrWPkIZZ6y/pbYyYtf9RN1llnHB+z97zZFWOITpGTv65Y56t+WF/td@vger.kernel.org, AJvYcCWutKp5g6BiarpF4kXAh6GQ74yAvRh/I5N5NiNlJKnr06/wjjGi6V99q1RHFQrMvMLayU2pIhcSUu43/2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjCiDKkeHVg3/F4dERPJ+jjYVQOgpEZyH+Y3UtY+mf0sFcCFpW
	J8koOYlojT6aW8MHejU41ZUyiHp7zIJ5do2T+e1UdJqeosDHsWnL
X-Gm-Gg: ASbGnct1hbwfTyq3lMrv0KE1VC98Ucljy/5u07xWrLail73Oy6xcy1tcLFJqYNXVPqV
	pRwsz3xB98barpUnbaVlT1aM0n62yiYCJeIOfz6wNycQUmyspxWnP1+Mi4ZqbKOlX5FlmYvRtBg
	3Qlrb55kluTWaLgKt164t4uzfJKvsfwYTM/IVQll9Zf6WU/wr3/RlcXskuMqR19DiQaw34nhfid
	Z6dLVv5KTYge865NVPdDJUkJw3H727v9qXedqeBbtBQMsj+Z+gaBzn7So6129nG2HRil1xbTB4I
	r61C+1P1hff0oB1G7DjepNCzvKsrGHGSbEuWk6RY6oimsGrpYvkk3hUfjevrLVS0s2jo/1/ERI0
	z8ZtXQoLOdDCFtQ7H+dYJQ4FNJehwxgzU6vvmzU1DtcE6brabtj8D0Q==
X-Google-Smtp-Source: AGHT+IHBBppkA5P6kDHFKkn9EMKpLq42qkA/PD+O6pTDyDgDPYueCmlOuvUnjSi8OryUSMFnXPy2bw==
X-Received: by 2002:a05:620a:31a4:b0:7c5:3ef2:8c40 with SMTP id af79cd13be357-7c5ba13371emr2057320785a.12.1742852042015;
        Mon, 24 Mar 2025 14:34:02 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:43c7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5d7eb96fesm63232185a.90.2025.03.24.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:34:01 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 17:33:46 -0400
Subject: [PATCH 4/5] rust: list: use consistent self parameter name
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-list-no-offset-v1-4-afd2b7fc442a@gmail.com>
References: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com>
In-Reply-To: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Refer to the self parameter of `impl_list_item!` by the same name used
in `impl_has_list_links{,_self_ptr}!`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/list/impl_list_item_mod.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 9d2102138c48..705b46150b97 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -114,12 +114,12 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
 #[macro_export]
 macro_rules! impl_list_item {
     (
-        $(impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
+        $(impl$({$($generics:tt)*})? ListItem<$num:tt> for $self:ty {
             using ListLinks;
         })*
     ) => {$(
         // SAFETY: See GUARANTEES comment on each method.
-        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $t {
+        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $self {
             // GUARANTEES:
             // * This returns the same pointer as `prepare_to_insert` because `prepare_to_insert`
             //   is implemented in terms of `view_links`.
@@ -178,12 +178,12 @@ unsafe fn post_remove(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
     )*};
 
     (
-        $(impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
+        $(impl$({$($generics:tt)*})? ListItem<$num:tt> for $self:ty {
             using ListLinksSelfPtr;
         })*
     ) => {$(
         // SAFETY: See GUARANTEES comment on each method.
-        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $t {
+        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $self {
             // GUARANTEES:
             // This implementation of `ListItem` will not give out exclusive access to the same
             // `ListLinks` several times because calls to `prepare_to_insert` and `post_remove`

-- 
2.48.1


