Return-Path: <linux-pci+bounces-23245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC02A58596
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 17:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044A33ACEBB
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 16:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C5E1E104E;
	Sun,  9 Mar 2025 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArVidusR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC4B1DF73C;
	Sun,  9 Mar 2025 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741536067; cv=none; b=t4G0ANpC9w1CFJA6gn08SHbo336vkLmslSeh7m+IS4viXOjvXGYpEBAlVIiIiCiBd/4slKRTV8YwmPx23lSJgReOpZ0+2m0+LRX2xIPvzIgFDpy4rfaukWc8knaDpGiNIvQqN2Ho0v/BG0awAV6gz1bZvr9TvWpAyI5yKNtFhAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741536067; c=relaxed/simple;
	bh=VZFIg4TXh9XzX0Mrmu1nOAtjzO8svjTQp2SnjUn+WA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ow4ZsaIiOarHm8v+x/2kxChJgNe/0/fNm1Hl866OiXTWXwTbQuRX4CzAbnhp/1nvvzbzHb5cjmDHZ4TOm7iauVmI8zDy+jPwuAnV13QiUNVcz7YXJKS22uJzI0CsfyIQ0vy0Fe/gyyWqVJmsAQRA8XhAuqOxV1KErN133SxHPXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArVidusR; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8ec399427so24625266d6.2;
        Sun, 09 Mar 2025 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741536064; x=1742140864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBllPpz7VEqR2WvVX+a/3v656rUk6jfALJLaE9Z8g2Q=;
        b=ArVidusRaKsapsfajZG0yrRyr88v4E+jPIznT2F9hSef2YkryiBqbDH24Bykvc9gBJ
         ulBokpHZjA+rpDfWXpvQ8qxMCvaF4KXdywg4h5hz4fLKh2Xgig8kq81tyNDk7GNSVI9h
         kRwUTDHDR7JpWT+fM1jcYqHayX4tMJ7B6rwXYxDwLIvp8rKTCYQqnucHhHXk4haNrG8R
         TO7Ce214Bt3J47drbpdSYil5oK7bbGNGjJs+GvURuBHa8mXbQqe2nWYx102ChGkxymL/
         2kRlKkgc2xEi8jCqZPTIIHQJueUBj2ORfhPaPgHdyZ7zYZVwWD1I7gc2ajcxNnPStDZJ
         an4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741536064; x=1742140864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBllPpz7VEqR2WvVX+a/3v656rUk6jfALJLaE9Z8g2Q=;
        b=R9YRhY/wdZbQKtsGtEDSyLBGuNy5UAq/R9yu/oQCRyySut3Lrv9q4P9jetw3hTxNBn
         NiI2GExE8AUcSnJQVjhoD+AdvUHXmfm0ylaQlTwEETHOJ520HIBMVHBOaFfGJRRGiVeP
         gPSNgH+9UW35OXtqIW2DBy/HwWRq/8Y3F3gvS8yWhtkuj6I6+8dJYRc22addW7BSciw5
         8DDqc7V2/cty8rZKngiadoERYA+SAK+3cEoTOP/PVRnn2AVjfRN9uWnHwLPHx6PqF4SZ
         BfYJNB6fublgy7L/nLSDFfCtQbglWDZM5vRg4+o0+9uoOaNy8SKnStjLQ77d1h7X+WSU
         We3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFbG0BtPc5H/UEIt1GqzDSced7CiaN5PXx18fPuMjWw6QPahSoIJX6HtTF9FMeMHahvyS8tOOcQ0lu@vger.kernel.org, AJvYcCVV7mDdOZdYOa6iTgq/1lbiBeYfU+kpUIxokQ5/f2do8NjzdhYpBTfZCRhj8Vm2C+dcD8NLKKI4PvLPcWCvrlc=@vger.kernel.org, AJvYcCVeYvWUhyOZrzid7JtzlKWbM+OtyYtHiFec3kaKeRf3RMLzgbbUDAYk3S5HXSrrYyjYlu0nvmH6gGIOiVnK5QPp@vger.kernel.org, AJvYcCXTD5iM5b+Wjb3wuLuOnT0RfiU2t+Dt85dznMELboHAwC5e2LdYIVQK/WDWkRBJVraTz3PEfafQsRfiYNE=@vger.kernel.org, AJvYcCXcB6psznbuyLsMfa9W285Gbh/u7hYHqWvFrSUwxCWzA2f5jt+pKeY3hDVRDlVJVjpoa1zYESVIVx/c@vger.kernel.org, AJvYcCXxzDfOyqKevlKdzUFRcrOojJhaTbLJ4r6Cq3ppmD50y88XjSeAP4FVSgzCqRwIyl5SIa+CBR32wKG2Q5ep@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd0oJtlXF0qdcyg0Q5uVGxexv7kwa3uZE0w3O/Trgnc9Pp76og
	XInqBwPTdZtcq9IvqFuO4WnY4Zd+K6Cv+KyfknWNXy8Mc4xeTH0o
X-Gm-Gg: ASbGnctUxL1NPZIJEzuVAWXq9RIKRcgs8Fd34XInqCb5HcacLiXodZLTBW4gPEWPNkb
	+T7eD912lDuKp3z25AK3+8tuvUxr8Rryzob+B05+V8M3BTaZAIyBHt+RHKbcev7pQVi7ZvLqNED
	MhSvXpr4BQ3S0RVzjP5LteGZ15mEdvgP3KsAukjc17a2+B0QVA0Wb4xDxyZz9mVsC8kWPzVjkMc
	iSR2pZ5LtVWqOuaLcSBZj/dLz/X/k4D3O9mUnmf/YHLKHAkqmuw7Wrds0vTfeSX9KECodKpS8Tr
	AH1czhhpNleKVlSPJWWqMZw6tmX0y4V+Xv0ADnpBprcm0UNCmyMXK+7yF0rw0rLSIDI=
X-Google-Smtp-Source: AGHT+IESqVUQFR+cQRbu+bscWrxEcSiPg+y+zXbo0sToWAnpe+xZUI43s4fil9r2PHX7RLN1yiDR6g==
X-Received: by 2002:a05:6214:2428:b0:6e8:97d2:99a2 with SMTP id 6a1803df08f44-6e900681c78mr153498936d6.39.1741536064328;
        Sun, 09 Mar 2025 09:01:04 -0700 (PDT)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534d38dsm512531485a.44.2025.03.09.09.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 09:01:03 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 09 Mar 2025 12:00:40 -0400
Subject: [PATCH v2 1/5] rust: retain pointer mut-ness in `container_of!`
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-ptr-as-ptr-v2-1-25d60ad922b7@gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
In-Reply-To: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
 linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Avoid casting the input pointer to `*const _`, allowing the output
pointer to be `*mut` if the input is `*mut`. This allows a number of
`*const` to `*mut` conversions to be removed at the cost of slightly
worse ergonomics when the macro is used with a reference rather than a
pointer; the only example of this was in the macro's own doctest.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/lib.rs      |  5 ++---
 rust/kernel/pci.rs      |  2 +-
 rust/kernel/platform.rs |  2 +-
 rust/kernel/rbtree.rs   | 23 ++++++++++-------------
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 7697c60b2d1a..9cd6b6864739 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -187,7 +187,7 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
 /// }
 ///
 /// let test = Test { a: 10, b: 20 };
-/// let b_ptr = &test.b;
+/// let b_ptr: *const _ = &test.b;
 /// // SAFETY: The pointer points at the `b` field of a `Test`, so the resulting pointer will be
 /// // in-bounds of the same allocation as `b_ptr`.
 /// let test_alias = unsafe { container_of!(b_ptr, Test, b) };
@@ -196,9 +196,8 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
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
index 4c98b5b9aa1e..c37476576f02 100644
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
index 50e6b0421813..c51617569c01 100644
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
index 0d1e75810664..1fdea2806cfa 100644
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


