Return-Path: <linux-pci+bounces-26567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09917A9952C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADAFF7B1E9D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CFD28A41A;
	Wed, 23 Apr 2025 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBC+81GD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142FE28A1E8;
	Wed, 23 Apr 2025 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745425822; cv=none; b=Vl2OQHoe9wjeQn2MdyiS0fOva/aB+6MAzO30TM8/RZDa5RHGNw0JyPOnN2iMxsVwIQG/QoVTrr89VxCTAbF9BHkDM1a65RzXSVyi3WMJnRtHWzmr+78L6p2mwEd6+CGFXoffwiN/mfVT7GspTjn6Cttj1FoPsUK9HP8n6g8vnkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745425822; c=relaxed/simple;
	bh=2DwSldyn2g2bf3cIIGysBmEmLfEvp5QhtgywZpbH7Jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nhQjDsJmPKZHxEHD4OQ/Gjv7EOicPXk8TbF++4cQSsJx00+UuDQy5oK6phal17emybb5dvFcq0lmf6QfzBhtVaKUkiQHfN95ASfEYQrJML9Bpob3+RIuSuCuN2+sCBQTkm1qIU8PhVxbd5JIpVvgMGZBU2i+NvxhzsWLc+QDQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBC+81GD; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c9376c4dbaso8913285a.0;
        Wed, 23 Apr 2025 09:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745425819; x=1746030619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JfIBCYWp6gLKc89yTU14vp4KvdB6Ey4V2d9LREVNw0o=;
        b=cBC+81GDZyVn0SeItgzk5G9tgoX0uSQAdFa59A6xsutxJzYgWOz6isMpB362Zc6elx
         yVT0ZNYuD9x4Lr2NYhermBS1/bVizDfaoqDJXln6tquvXLKsF0KFyXmMSuugTmGdtq5+
         5YmIzDgmzt7v2pqf01HRYUWesiRV5kwL21xqUndSh0bkXw08FeGLfSsBNK31cUVy2WuW
         aXuDuwN/fLlgnytqGDEcKoSZQIZ2E3ikKA9wR+vBtIoIfvGSwtFy4fc3DSCkEo6R1hzP
         nopjWiv3NH6a4kqLTc19Z/cWBd15jK+BTni0ZucH8Yhik+6Zt97k8V88XrD9wNv0Wluv
         z4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745425819; x=1746030619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfIBCYWp6gLKc89yTU14vp4KvdB6Ey4V2d9LREVNw0o=;
        b=rTePTUwkDjmDiGwL+dgfbDN4ZLkS0WREOvRtUB/HOiQG0FEJ2Vegkf1nCKApFhCdlB
         oSDmQ37psek8idYk2H6NmXFYB4F+x6s2JdSOP3Vl/GzOYDmquM2RQCyHYtuFGS1mnj8E
         pOa7A06khi5As2dbzcRQfcyq0pz2qvm3Icn69hYqHnNQEatWYX9NVAfxDksG5BLunh+R
         qutJsSZPsN1ojeSydo/caGh5Tpt1dqTGasX26qIYRuUYTaF22tkKxqfQsxEMl8SWsSlH
         qLO4OIpVqF3fpRw9Hr6f11kmtra1OBBrK86/cZwqB/7TaoCkujOMA0+8/y9CqyPuJbfn
         3kbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/0Ldn5A3R0KB/YvoF+IJvIJCHlVQbef3KzXxoa4cx3/YariIzRHQZ/pExQIwRJ4klt5KQHFIFTXnB0gM=@vger.kernel.org, AJvYcCWU17Xrv2Y0yUE6ux38p5VMjlb7ueNn/dCI3aQcU7nUNKeiHq1md2goPDowirZDTaVtiwrEh6x9CaYM@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVQ4O4tS2WON3lPGe4ajV3I7YFEhpdfJV9bACxdq5UTDZSePf
	Zds+waGl5sJlEE35A6F41gAnFM8BI6rw70rkXcePquhfTHJK9m8K
X-Gm-Gg: ASbGncsLPYqyxjDA5S78Vyyxuu3jsL76Lj2jeLoPUR2JhDYlp2A2vQ3Melq0y8GW/iq
	AK0tPFgoPElelbhwJISOPsQLd41Wou534hhOgvPeSkZ+yX0mFRtOOv8jfu+DS0dBVG1imSHgtK0
	Q6NB7qVAWzLZc1F3THk3Dg+ySmD6DIiheV3wwDBe4ZDZLVwvKLBmYtT6WSpOnaWKjYrp7hrRkDc
	HOwzK3KixXE9ia/mt/AFBXZ8QAyphFrpiKTfc9+XtClW3DVhLY8Qn67H2Uo/HHB0/IMgJ7MDXiE
	Anzchc4usYOLsnYAEpmrR8evEkpsyzLpUgM41Lnvq0VLZcxiqy2E6pT0AZ5+BoFpKe/Vv7/AWwn
	37GDXT/UZQtoqxVvOk0cMJfg53WJxof4zn0mPM69waPkK8u8NfA==
X-Google-Smtp-Source: AGHT+IF5r/0Ij/BQ+LtpZ4kxi2aLxCs2O3cDLnfKvN7jmzxD7sJ0n17zDnYKsBZK3tS/qukXc9ue4w==
X-Received: by 2002:a05:620a:1d92:b0:7c4:bca3:6372 with SMTP id af79cd13be357-7c94d75ee3fmr450770985a.0.1745425818677;
        Wed, 23 Apr 2025 09:30:18 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:e2b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4dac4sm698031885a.86.2025.04.23.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:30:17 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Apr 2025 12:30:05 -0400
Subject: [PATCH v3 4/6] rust: list: use fully qualified path
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-list-no-offset-v3-4-9d0c2b89340e@gmail.com>
References: <20250423-list-no-offset-v3-0-9d0c2b89340e@gmail.com>
In-Reply-To: <20250423-list-no-offset-v3-0-9d0c2b89340e@gmail.com>
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

Use a fully qualified path rooted at `$crate` rather than relying on
imports in the invoking scope.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/list/impl_list_item_mod.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index d79bebb363ce..3f6cd1b090a7 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -4,8 +4,6 @@
 
 //! Helpers for implementing list traits safely.
 
-use crate::list::ListLinks;
-
 /// Declares that this type has a `ListLinks<ID>` field at a fixed offset.
 ///
 /// This trait is only used to help implement `ListItem` safely. If `ListItem` is implemented
@@ -27,14 +25,14 @@ pub unsafe trait HasListLinks<const ID: u64 = 0> {
     ///
     /// The provided pointer must point at a valid struct of type `Self`.
     ///
-    /// [`ListLinks<T, ID>`]: ListLinks
+    /// [`ListLinks<T, ID>`]: crate::list::ListLinks
     // We don't really need this method, but it's necessary for the implementation of
     // `impl_has_list_links!` to be correct.
     #[inline]
-    unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID> {
+    unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut crate::list::ListLinks<ID> {
         // SAFETY: The caller promises that the pointer is valid. The implementer promises that the
         // `OFFSET` constant is correct.
-        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut ListLinks<ID> }
+        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut crate::list::ListLinks<ID> }
     }
 }
 
@@ -222,7 +220,9 @@ unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate::list::ListLinks<$nu
             //   this value is not in a list.
             unsafe fn view_links(me: *const Self) -> *mut $crate::list::ListLinks<$num> {
                 // SAFETY: The caller promises that `me` points at a valid value of type `Self`.
-                unsafe { <Self as HasListLinks<$num>>::raw_get_list_links(me.cast_mut()) }
+                unsafe {
+                    <Self as $crate::list::HasListLinks<$num>>::raw_get_list_links(me.cast_mut())
+                }
             }
 
             // This function is also used as the implementation of `post_remove`, so the caller

-- 
2.49.0


