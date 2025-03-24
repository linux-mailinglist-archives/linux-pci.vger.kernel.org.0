Return-Path: <linux-pci+bounces-24579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95307A6E5BC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 22:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5B4188E641
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 21:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80711EA7E7;
	Mon, 24 Mar 2025 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7wnA3d2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB919005D;
	Mon, 24 Mar 2025 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852042; cv=none; b=jMEKUAW8YPauwii+ePdrelcTI71+2FzjseMW4bZu81c4Is5N/gqUvIrIGxV5sh/VtDfdqwYMaH/e6W9fsQ0wq3CcqlmnAoUL3AXN4FUxg76HvudI8uU69qL+6a89AO5V60yONMpPC9QuDD3w+L9GIMC8E1oT/DzbwCNqZIhCUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852042; c=relaxed/simple;
	bh=jXBOpo5UWtwyrzWvahiJ2pLNqcTsAoQ2rJCCE9+N488=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SWohPDmzquJ8vD/t5CbWfaVqNktsjlLPIG7zxOLVjwrjecWNbV445DT/V6DzONkyacfharLp1PeQJK4B1dXv4EPxp2x3Nc1PUsmED8ZaxnlWZPuiFJPI9aX5hVb4vJI1zaZZ4KphKWU9851tf7kaQrgTxVD/Bl7O7de+uSdhiTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7wnA3d2; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5ba363f1aso537575785a.0;
        Mon, 24 Mar 2025 14:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742852038; x=1743456838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLYdB8oz2i/GfcI4zN53mys18Ki2XN46F1DPNODr+Tk=;
        b=D7wnA3d2q2RvpG1ZV6mowS1KDLazGK8FMfdZRL7cBTqvd+XXzA854N+5o0w2z9FIjM
         /OrzBG+QtIG8LIqM0EFyc+iXErelZ2BWEQHaJWFVXzkQF8mnJaQcZPTCGNNDTarotAZf
         yCA5d6IRmqlGC5HD31Fm6DOV9dEqGTArFbTvPvxap46FP96abOrdEgsSf7APfR2L6uY2
         N2fV8FI9+lmr/npOEgE/FZ4tz5GA/lWsuiL58zXUCcGh4kPdeRFsduXTGJeATl/EEMH0
         f6scGGYzh2bqfVWMsybwcCe1v+W5vkKZ2XgrXUDoU8TY95KPAxC0RLSA7LjSpInVFQx1
         kmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742852038; x=1743456838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLYdB8oz2i/GfcI4zN53mys18Ki2XN46F1DPNODr+Tk=;
        b=EAOhkb+eu1pv+zOGrAclHrHENr+LrDUPOxd9hDhizgKh5cYXBmBD57Mjki3+gu4Tf5
         571sd3UqxDOxK2jTmXBSbelYHYgK5YigDDYhrnprwdlT5LxmjDRrPthzHJn03MDrCPxl
         MXv9N/6fvdswDRDOQZP5rqPUzzLhJRPi2WAEbH4XAR03TAhJ1EgYaLHfx0iD8KZulYot
         3hECbVM+BRxbZ8XMTqLPAMsH0Hcuj7vdjIOQyrNcyx3JY2ULzNaCWIc+UH+bpn6q322s
         mZ7lMxLghwWUuUOSw09OIZ9Js/MzbRW/PhvU+mnTq/8hsntvuo955xJU6XZR31BYutUt
         wxAw==
X-Forwarded-Encrypted: i=1; AJvYcCV9htNihED/eEIklK1X8g23zut7AsxULQINeEzVkyJrHJ+ldN25DMteLib1nL6ydFd6bsO5WyJPi/py@vger.kernel.org, AJvYcCVcRnNHxGKullXpPlRvfV4WExaIZKGt6sBQFZj5e8Kq7yW9IHdseVrER7KXWOZSCfoZMJfkraSbAJK2mqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xMmBMD047K8ONWQrpQ9IMYVFynABNlq77fHCvQUdP2EAPqBq
	su5pn47msvaDeE67ZcjZhAHwlYsuFXkgrVY8GmrT0mIgFGXXuv83
X-Gm-Gg: ASbGncuuGBupIZGIAuTu78Kjx3YI/CN21w345NHIt6XsJ01iAQX/z1eNoEr645DrlQP
	Rt5ZJn9+uW5nGPKOqcQ887389fT7hVEkZApBUNRLraZnYXlms8gyjxsiciIXz31c68B+VbiPLDO
	DYZWT69ktjPMWJcAI+JaGRasM3/3EkdwR6BHZO+aGZKMKitHpbTn0fjLpILryTYAie4zFEnM1ez
	7eGkQKC0w4x3GDFXJTT7f18IRAoOYiirEVkn5bRAq+tiO9qmFaqRLGqCRcHtfj/BaMN3P/vubEq
	KvJAPgypNBObhg6L/3Wmjm0mfrFFkZWDv1tX1I1jQIJmzw5nd9q+KxTEn7A+BcH9pqW1xoSvGEA
	8WWl0313wd1VXO6k2OXGiv4Co8ITHq790So4zUsdFmFhb9Z+oeI/a+g==
X-Google-Smtp-Source: AGHT+IEhrv6Ny4E6jksCPXyYsMYyMKqcU946IpYnjimcFYzESWuGYTSeITIPQrWWoMP2jB9I87MPNg==
X-Received: by 2002:a05:620a:4089:b0:7c5:4daa:2511 with SMTP id af79cd13be357-7c5ba1f1102mr1963053785a.52.1742852037913;
        Mon, 24 Mar 2025 14:33:57 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:43c7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5d7eb96fesm63232185a.90.2025.03.24.14.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:33:57 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 17:33:43 -0400
Subject: [PATCH 1/5] rust: retain pointer mut-ness in `container_of!`
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-list-no-offset-v1-1-afd2b7fc442a@gmail.com>
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

Avoid casting the input pointer to `*const _`, allowing the output
pointer to be `*mut` if the input is `*mut`. This allows a number of
`*const` to `*mut` conversions to be removed at the cost of slightly
worse ergonomics when the macro is used with a reference rather than a
pointer; the only example of this was in the macro's own doctest.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/lib.rs      |  5 ++---
 rust/kernel/pci.rs      |  2 +-
 rust/kernel/platform.rs |  2 +-
 rust/kernel/rbtree.rs   | 23 ++++++++++-------------
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ba0f3b0297b2..cffa0d837f06 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -190,7 +190,7 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
 /// }
 ///
 /// let test = Test { a: 10, b: 20 };
-/// let b_ptr = &test.b;
+/// let b_ptr: *const _ = &test.b;
 /// // SAFETY: The pointer points at the `b` field of a `Test`, so the resulting pointer will be
 /// // in-bounds of the same allocation as `b_ptr`.
 /// let test_alias = unsafe { container_of!(b_ptr, Test, b) };
@@ -199,9 +199,8 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
 #[macro_export]
 macro_rules! container_of {
     ($ptr:expr, $type:ty, $($f:tt)*) => {{
-        let ptr = $ptr as *const _ as *const u8;
         let offset: usize = ::core::mem::offset_of!($type, $($f)*);
-        ptr.sub(offset) as *const $type
+        $ptr.byte_sub(offset).cast::<$type>()
     }}
 }
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index f7b2743828ae..271a7690a9a0 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -364,7 +364,7 @@ pub unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
     fn as_raw(&self) -> *mut bindings::pci_dev {
         // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
         // embedded in `struct pci_dev`.
-        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) as _ }
+        unsafe { container_of!(self.0.as_raw(), bindings::pci_dev, dev) }
     }
 
     /// Returns the PCI vendor ID.
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 1297f5292ba9..84a4ecc642a1 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -189,7 +189,7 @@ unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
     fn as_raw(&self) -> *mut bindings::platform_device {
         // SAFETY: By the type invariant `self.0.as_raw` is a pointer to the `struct device`
         // embedded in `struct platform_device`.
-        unsafe { container_of!(self.0.as_raw(), bindings::platform_device, dev) }.cast_mut()
+        unsafe { container_of!(self.0.as_raw(), bindings::platform_device, dev) }
     }
 }
 
diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 5246b2c8a4ff..8d978c896747 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -424,7 +424,7 @@ pub fn cursor_lower_bound(&mut self, key: &K) -> Option<Cursor<'_, K, V>>
         while !node.is_null() {
             // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
             // point to the links field of `Node<K, V>` objects.
-            let this = unsafe { container_of!(node, Node<K, V>, links) }.cast_mut();
+            let this = unsafe { container_of!(node, Node<K, V>, links) };
             // SAFETY: `this` is a non-null node so it is valid by the type invariants.
             let this_key = unsafe { &(*this).key };
             // SAFETY: `node` is a non-null node so it is valid by the type invariants.
@@ -496,7 +496,7 @@ fn drop(&mut self) {
             // but it is not observable. The loop invariant is still maintained.
 
             // SAFETY: `this` is valid per the loop invariant.
-            unsafe { drop(KBox::from_raw(this.cast_mut())) };
+            unsafe { drop(KBox::from_raw(this)) };
         }
     }
 }
@@ -761,7 +761,7 @@ pub fn remove_current(self) -> (Option<Self>, RBTreeNode<K, V>) {
         let next = self.get_neighbor_raw(Direction::Next);
         // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
         // point to the links field of `Node<K, V>` objects.
-        let this = unsafe { container_of!(self.current.as_ptr(), Node<K, V>, links) }.cast_mut();
+        let this = unsafe { container_of!(self.current.as_ptr(), Node<K, V>, links) };
         // SAFETY: `this` is valid by the type invariants as described above.
         let node = unsafe { KBox::from_raw(this) };
         let node = RBTreeNode { node };
@@ -806,7 +806,7 @@ fn remove_neighbor(&mut self, direction: Direction) -> Option<RBTreeNode<K, V>>
             unsafe { bindings::rb_erase(neighbor, addr_of_mut!(self.tree.root)) };
             // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
             // point to the links field of `Node<K, V>` objects.
-            let this = unsafe { container_of!(neighbor, Node<K, V>, links) }.cast_mut();
+            let this = unsafe { container_of!(neighbor, Node<K, V>, links) };
             // SAFETY: `this` is valid by the type invariants as described above.
             let node = unsafe { KBox::from_raw(this) };
             return Some(RBTreeNode { node });
@@ -912,7 +912,7 @@ unsafe fn to_key_value_mut<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, &'b
     unsafe fn to_key_value_raw<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, *mut V) {
         // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
         // point to the links field of `Node<K, V>` objects.
-        let this = unsafe { container_of!(node.as_ptr(), Node<K, V>, links) }.cast_mut();
+        let this = unsafe { container_of!(node.as_ptr(), Node<K, V>, links) };
         // SAFETY: The passed `node` is the current node or a non-null neighbor,
         // thus `this` is valid by the type invariants.
         let k = unsafe { &(*this).key };
@@ -1021,7 +1021,7 @@ fn next(&mut self) -> Option<Self::Item> {
 
         // SAFETY: By the type invariant of `IterRaw`, `self.next` is a valid node in an `RBTree`,
         // and by the type invariant of `RBTree`, all nodes point to the links field of `Node<K, V>` objects.
-        let cur = unsafe { container_of!(self.next, Node<K, V>, links) }.cast_mut();
+        let cur = unsafe { container_of!(self.next, Node<K, V>, links) };
 
         // SAFETY: `self.next` is a valid tree node by the type invariants.
         self.next = unsafe { bindings::rb_next(self.next) };
@@ -1216,7 +1216,7 @@ pub fn get_mut(&mut self) -> &mut V {
         // SAFETY:
         // - `self.node_links` is a valid pointer to a node in the tree.
         // - We have exclusive access to the underlying tree, and can thus give out a mutable reference.
-        unsafe { &mut (*(container_of!(self.node_links, Node<K, V>, links).cast_mut())).value }
+        unsafe { &mut (*(container_of!(self.node_links, Node<K, V>, links))).value }
     }
 
     /// Converts the entry into a mutable reference to its value.
@@ -1226,7 +1226,7 @@ pub fn into_mut(self) -> &'a mut V {
         // SAFETY:
         // - `self.node_links` is a valid pointer to a node in the tree.
         // - This consumes the `&'a mut RBTree<K, V>`, therefore it can give out a mutable reference that lives for `'a`.
-        unsafe { &mut (*(container_of!(self.node_links, Node<K, V>, links).cast_mut())).value }
+        unsafe { &mut (*(container_of!(self.node_links, Node<K, V>, links))).value }
     }
 
     /// Remove this entry from the [`RBTree`].
@@ -1239,9 +1239,7 @@ pub fn remove_node(self) -> RBTreeNode<K, V> {
         RBTreeNode {
             // SAFETY: The node was a node in the tree, but we removed it, so we can convert it
             // back into a box.
-            node: unsafe {
-                KBox::from_raw(container_of!(self.node_links, Node<K, V>, links).cast_mut())
-            },
+            node: unsafe { KBox::from_raw(container_of!(self.node_links, Node<K, V>, links)) },
         }
     }
 
@@ -1272,8 +1270,7 @@ fn replace(self, node: RBTreeNode<K, V>) -> RBTreeNode<K, V> {
         // SAFETY:
         // - `self.node_ptr` produces a valid pointer to a node in the tree.
         // - Now that we removed this entry from the tree, we can convert the node to a box.
-        let old_node =
-            unsafe { KBox::from_raw(container_of!(self.node_links, Node<K, V>, links).cast_mut()) };
+        let old_node = unsafe { KBox::from_raw(container_of!(self.node_links, Node<K, V>, links)) };
 
         RBTreeNode { node: old_node }
     }

-- 
2.48.1


