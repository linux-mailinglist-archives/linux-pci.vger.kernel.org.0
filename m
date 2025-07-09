Return-Path: <linux-pci+bounces-31804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE44AFF1E4
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 21:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651051C818B9
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 19:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2166B246771;
	Wed,  9 Jul 2025 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7DPBAw0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79215243378;
	Wed,  9 Jul 2025 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752089483; cv=none; b=kWeeEjtirHprdAjhYx+IY7EUHLc7AHGuRKl8lOZ+g/dX2r7e+aY34S9a2x5fAI2uN3JmXYTMb/Z5cJBnS/g11D7DndQ1q78Bsf4ZkoLhFQ+9ZabFuUGFcDO1eOH+R7ENua64fjpPy5AXaxvPLbOBpD1Neb1NSmM0g7cvMvnaRN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752089483; c=relaxed/simple;
	bh=+/OtAaGDpV4UJ40Bzj2NyhOOSjckTGuVHZjo7qrtKq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T4aV2xllj6F5byij+yaJ8cxLQ0+XTwXrv7mPQH02AemnHWj/QVG7dO0UGltxGJKBrRcFxG0dvAchDQqm77IHEyM2mHiWZUPEX9/Sb7eri1wxYoqnPQGuXXpJHDcjjVWAYmzudXhhJa4A3FmlbXa7ucP2uGoWOwKb0aJNwdRfyYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7DPBAw0; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d9f5bf544cso27295385a.0;
        Wed, 09 Jul 2025 12:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752089480; x=1752694280; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSaOrQSOQ/YLPFSVJBn7bVwB69tP2YNrYHZvxht3dSE=;
        b=P7DPBAw0NdmBSTAznIZP4mh59oUU1khhQ9QvZI1g8Onn6tEr1uo/OHii8O3D3hsGso
         UgvyiBn/kHidmM9RCuoUrV8wreMUreiC0R6J2fqnE2fsew061yFFiJQbBJTaU/gm18Cc
         /3trC8TuMLLQ78D4jGxPbtDtsyKUHwC+5XEzpaLZ7qapOnp9QY8CSA/R8q12mJSqQpqX
         2coB6oDA6lKGikgctSQZeDGzITUPsWQJJGwYOKhVrz62LgVzLnz1YnmOANCa2QeEifQR
         23RbQ0JQzznWHJEnK2mPcWk9VgKX46EBaoNXGEK3p6wi9rgrFeuZvN8qxD3GOReY3XDV
         5sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752089480; x=1752694280;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSaOrQSOQ/YLPFSVJBn7bVwB69tP2YNrYHZvxht3dSE=;
        b=mfX2gkM7yBEpmhWakYF5++fuxDCxWnJSoPs/Me5stcFxnWvMpvtD+OkHo5rP+eoUr1
         xLN/+tfyQ/8i1lpcT8kis7m/gzxLz04KjiGGCwT6sXnJoosoRPyFeFLsjyJf3Z06PElW
         qAwK0H7qWUHiy26lQGsgi0xoSmgx0rbxK3phn02EeYvAtzFKFV3NKNepIgrJVbNBuM+S
         xigcql3vVaa5FgcidcDjFVpHfJMVOFM2vAJA+fIenS/SgJOiC3yiJCZAh7hZEWhlh9a6
         5yvVN0EFPXRH2nw7OT1NX9LgUqXNmcowTXoHqG3IMn2ADL1n+AwIwtCU9ga0V/f44KL8
         Q7pw==
X-Forwarded-Encrypted: i=1; AJvYcCWp5TNSWp0VSP8hqopoEMz8fdUNzIJpsIrSxw+DjekWD8KuB1ld0qCL/nyPqtgZYXfnfa8jVBM6eLrA@vger.kernel.org, AJvYcCXH38J9DvZ83IDNDx75Qn6vaGA/xkNyfYhhnvpJjJ546gqqjttFJAPNSf4sydgYw0wrOaLnh2E1kD2Jtv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm1uylejgk4vzQOyZP+NpWYUR0pS/Z+ZaHDijDUY6ndeYPJOKL
	GVusoR6GZO/EWWv1FEJNdiOI0K7FPuVd+2SjJ57C/3raqlfagF/Robed
X-Gm-Gg: ASbGncvawOp6vzsXJmB39uXI86DTo6tgYwWkexPe5DbzIiQZcmzy3u6A5RQ0+8WDgDU
	mcBuioQclz7OXRzVKAOsQeAu0PJNzS+2oYZ2T22K8eErab6KBkIb1SAQY5fkNDc8PhUhEkQpWg1
	EzE6eLtGqSGPiPk2Y00v+NAn0ILFSY2hLWuTbXcJ5j8tqukXuC/DIXp+25CLlGtlITCA+8LkpNo
	ajxml91aGWdBBmzCQ8y4Ygu3xSY3bxMNPmeITIe7dchJU5K7dG7Roi7zVAmFtqcD4Hg4cqCmvIF
	4MLLECkt5r4LlUOkClTUgAHSXHLBQUJrXY6x/TAleisuai2/xaPtGlRr/B+dHC5llWQ8CNRLbzc
	6J0GAYwSZcJzERG6ylOQ0j8SnVYEa/S5A2boH1tKp65g5bdKSpAuuW8+Vcg==
X-Google-Smtp-Source: AGHT+IHEh6B6b0eKQFJTeHG1DYBHbKPc/AHXwXbCtA8nW6xzzsDc0yIk20y6+7wgq3QIr4rrabDsZw==
X-Received: by 2002:a05:620a:444b:b0:7ce:e010:88b9 with SMTP id af79cd13be357-7db7b80e1ddmr561496485a.13.1752089480235;
        Wed, 09 Jul 2025 12:31:20 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbd94242sm991741285a.9.2025.07.09.12.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:31:19 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:31:14 -0400
Subject: [PATCH v4 4/6] rust: list: use fully qualified path
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-list-no-offset-v4-4-a429e75840a9@gmail.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1752089474; l=2377;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=+/OtAaGDpV4UJ40Bzj2NyhOOSjckTGuVHZjo7qrtKq8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QN2TNDZfV95jOttUvC0uhemNcK7YBmuSsjOaHsf7GMgdOkuAXnfs6E/15hO4ic87HkWNyMNmemw
 0iIq3Q8/FMwg=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Use a fully qualified path rooted at `$crate` rather than relying on
imports in the invoking scope.

Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/list/impl_list_item_mod.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 050299380330..32087aee4c87 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -4,8 +4,6 @@
 
 //! Helpers for implementing list traits safely.
 
-use crate::list::ListLinks;
-
 /// Declares that this type has a `ListLinks<ID>` field at a fixed offset.
 ///
 /// This trait is only used to help implement `ListItem` safely. If `ListItem` is implemented
@@ -27,11 +25,11 @@ pub unsafe trait HasListLinks<const ID: u64 = 0> {
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
         unsafe { ptr.cast::<u8>().add(Self::OFFSET).cast() }
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
2.50.0


