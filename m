Return-Path: <linux-pci+bounces-23155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA6A5743E
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 22:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200663AB009
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 21:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B706256C90;
	Fri,  7 Mar 2025 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5GzOjzw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77F2080FD;
	Fri,  7 Mar 2025 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384736; cv=none; b=KW7mRjsAG96vBZkgn8w2e8UC/ZLM80e3mGYV/spHpeYd7xLj0dZOCO8m+1HafvBRE6TQ6i2IfIqkFmqsjT8IFYn9hEYau8Nq+2uh6H1CqClwGB1dX1k1OVmF3j8+wTyQn2kSG38TIyQ+jgiWjcSvDtH2CF/cus6+AQNAmgIQHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384736; c=relaxed/simple;
	bh=VZFIg4TXh9XzX0Mrmu1nOAtjzO8svjTQp2SnjUn+WA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SlGlofRB1UXNA2slFFCYCeyxqvQz3r9zJn0jjLfHztpnYFeVk+MRqucCI0B+6dgGufAMb/QgWtSf4/tZ4ICIeoi2E6HJq9sACxGXORutfibQjfuxCYw4KVaxbjTSkhKcZW3hcXxGNJP9qitRuX9u9OwxZOTeDj9z6io0/e3jDu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5GzOjzw; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c2303a56d6so263177885a.3;
        Fri, 07 Mar 2025 13:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741384733; x=1741989533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBllPpz7VEqR2WvVX+a/3v656rUk6jfALJLaE9Z8g2Q=;
        b=d5GzOjzw48W+wP52r1beMv/QiwoxDBxzCy6L2ilbTdYGpDhKpDZMYok+Tjd92uu0FO
         PnwWN1g+uTs/FiXZPYU6x7KlByiNirHgbUKG/umdjGwIhXF7EeX5h57gTdh/omGi7Xg3
         rra/PLqzscnWgI9eSLS863obTudxbBM3Xt0qUVuVeCzk1xKibkxXKtxbHnIUiOFEvGOr
         QfZ3KBG832Vif8q+NuZ/Zc4BJV4VOTryPwDTugWSOiTL7pqEeLotsYEaK8Ig4jNSdbXy
         ul1TFSskln/xwzfNghzaCdj1fsURPoW9qtsVP1s3WQVHTYwVEZ7MZuMKzUmPjvh33WzF
         5Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741384733; x=1741989533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBllPpz7VEqR2WvVX+a/3v656rUk6jfALJLaE9Z8g2Q=;
        b=bSM2GmqeLxi5UVyh0l0We4lDKZrT7Cq7QQObq68pfQfligoxXVNoShqEGuxszmFxkv
         33JUnCLtipF4Vk+fX+7o1fWUc3jksR20yWEL5L2U7dd8RhrmtVK1wyKZ6c/kYU6D2Mob
         2ZGxiEWlyc/W3vUHSQRb4nGFtbKvaYv6GCj817fhvI1nK79mKjHHuLglbOER9Nt0fJkv
         vBOCCtxWY6VtU7HA964jfoLEJ5xy2SgUlc3AuwCkzL9BadZMwL5WxhgOvkQKanQkbqry
         57l+pAVO68vnMtLmFCGnzNkweZNbwS0RHeUlTCu0YNQk2cbM+aLj3+DS02wrS0t7jXEh
         5gYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFdQX4RkZ1DKVrhG85raABctaJM4bzGdCCAti9U4qB4pnRXJx7+bhOJ8TJyMGdEyHrfvTjmU4P6BcZ@vger.kernel.org, AJvYcCVoDJBhYTU/E6XfSRtT1IU/S5rzjH1WxEYJI7rd/2Po70bu4As2arMPTh9Sj5Y5bBgVg7DmZF9lDJtrwvE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CIPjPFQ8CIYJiueVGPS8XySKqu3Vd0vxdnKTIsHdhNJpn6vU
	RF6XEnxKNjxKUeDzpX11xIabMlp1dOtmNC2mHGxqXkjFkVOaEnQ6
X-Gm-Gg: ASbGncs12o4oUJu7+ewPukj9MOv63ld4z9aB611x4BJTn9jkKMHHZk3jDsc+KspCSxD
	I8kJAx/esDDOpNZjSbiKIbxk6JoUzPxc5NTx8qMdi2CKcQBA6vqXuA9Byx+W8761pp9zPpgVgd7
	wWziecCcap1CkxPE9lc6uLzovhcFrmTe5mLV/hHHGd4tFd2erEua1jsg0fX2CzmRHQobfOV5UZz
	rym0LYowvaQZCfeimreI9Ke9HjJ7dC/sslJXqqbQHSmwO1vGF10oluni9tcLNZRzFNadUJ1XSe+
	B+SWaAHND8MyUOVgRnWOCwVZ2ihp/0Q+0h9DRDGlTKGnzYU0arUAz56OcnNbdhZZ2mVDoEwUyav
	3sBvPnQ==
X-Google-Smtp-Source: AGHT+IHLFuMF0VQ8xchyAnM9AT7ceUIMIfHOEUiWKPyd1s3L478m3cq6fV54xQofYp8fBlxNscZC3Q==
X-Received: by 2002:a05:620a:2b83:b0:7c3:d45b:c0bc with SMTP id af79cd13be357-7c4e618c1b1mr922678085a.36.1741384733255;
        Fri, 07 Mar 2025 13:58:53 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([2600:4041:5be7:7c00:f0dd:49a0:8ab6:b3b6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a481sm293735085a.13.2025.03.07.13.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 13:58:52 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 07 Mar 2025 16:58:48 -0500
Subject: [PATCH 1/2] rust: retain pointer mut-ness in `container_of!`
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-no-offset-v1-1-0c728f63b69c@gmail.com>
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com>
In-Reply-To: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
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


