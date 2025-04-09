Return-Path: <linux-pci+bounces-25553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371AAA821A4
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 12:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0BC1B85CBC
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C238B25D8E1;
	Wed,  9 Apr 2025 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmfAgq6T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F68228CA5;
	Wed,  9 Apr 2025 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744193018; cv=none; b=ujEw5RlHvgcJGtTfyeYHzlJ92FylnXhekdMVJmvpGTWCNRoSxELx9P4dXLjf7vyRcWex4lJqhCZ0MoVKepcraw186K5h+VsQ1o5qao+nZqn+x0aBdrzIoLreZQpGBuehqdS9PT66vdawlEmvYnNNHawtVZB6Ew/Erj+1boOJa5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744193018; c=relaxed/simple;
	bh=YTJhL9POJYoOfWPi7cmSzRLm5vXe5zAp+v4fPIVZ7pI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uprp/anMjSZgCoixMWsBcrCGRW4uhx47H7D/uJ8i53Z+gkGVzXpplTttM2KN+qIWlpBH03kPtWsXNvxKva+pXhawcBuwfnZn6oaTfBRD/ogcZoQqN3NLghWL+MVz0J6dZf9zvqR1AdEj94sg3d6F1hx7AsYIY66TRx3meHVQU58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmfAgq6T; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47677b77725so69471231cf.3;
        Wed, 09 Apr 2025 03:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744193016; x=1744797816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8z0YQi4YLnBqqRN0VZf4Fw4EtNxgeWDKD/TMdUA4iQ=;
        b=nmfAgq6TaOPo8cP0yggoSpnYVkh5UllOgmdCeEzOIYSGxLW9yxxBPx7OqvLDznh4VM
         3bCJQVV05CwxkFRCY7wnpZ0P5HUBPFwttSGFolbHoRhWPLsoOuLN8Vot/77GeZthw/0I
         qXe4rX1Llx3J6fuShCA3kQT79jA+i1Sfusyt5cslFyksD2Pe4RDe7SjVRGqLBuZxyXm9
         l3tFavsDQanmInIeqd62d2W03GPMzl0VBvF72lH3HJ8Jeh1Nffpjdc4/ETJhkedRrs0l
         bXcHOsvd7R4Ee1gniBQVTbtb5k586EXol/+7ZBm4NfQ/UYrgB/1dp5D5GAqU6goHzTxx
         nX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744193016; x=1744797816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8z0YQi4YLnBqqRN0VZf4Fw4EtNxgeWDKD/TMdUA4iQ=;
        b=nBEk6Qg56tj4pgjHr6eD3EhPFfqjiZ3Mfmvc9cfcUxJ0wtTYCIN5t2+JD3XQ8BxojT
         HQlb3dOvAnAQU2+KS+OFRyRKKl4fz0o/7jv0AKd7Gt8oIq2aM0+3L9fk9nQ6/Pjwc6X5
         MGP9stHLxWCWcyd6UOIB1pyfJwSDlWoa7BhTNN8WlKSr480kvQ5h9Xk/6yS0TkCwGPLc
         9xAkfJ7T0FnezghA8qvsKJomT0gCE6miM9s7/yGksbcPn3I5nEzYa8DZcORpHZIQDWM/
         g5ARkMdfhNm8OKQkdvNmLWrtIDeG6pD9Si6LSLEbeFz6XphWHN00tUXjZgF+eGv3E/04
         hRdA==
X-Forwarded-Encrypted: i=1; AJvYcCWulxEY9t1CBMHWbFvPCls7xSM1MzjmtkUUK6A7bNuEj8p2oXCMj3FgjJUZ6Ikw0Lw0qG8tn5ILCobpvAkvcuE=@vger.kernel.org, AJvYcCX1vJBZmwm/z1kj2JiOn9Lr8qaEsfNxYWAQQ00NeDSDzGu0ie8MSywt+oHTfPyOcG2HwC0NIkEhkb8X@vger.kernel.org, AJvYcCXwGvoHuoA0tDPK/CvmPoPolhd5BBySqs7cxPeSSMOTGy00Pyusl783XxQ5J/ryl4AjMTxUL3ss6GuJuWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuAixCPBqTS+9NYHflt6jPMCZMybx9G1SZ7RNll2ecsq2angz4
	BrXd/NHExInQyuDMf2SmVotE5vgfXWikE7MqXIDGMb3lAofJjeIe
X-Gm-Gg: ASbGncsOlsxEpUGLyMs5BKN0vRCjRsi8jg+NYkLPgjR9exfvkvXzj7kQ2Iug0wwOHPx
	tQEjbFy0vvp6wff3+ow+G/g2z0BNIgCE4+Vh+6UL8nPl0LeTFCcoOd43nCGW/rxJyDmmp83E1p5
	h+Rv/wsD/+eP3Bv4AK5DmpqrWvI5m56oO1Qrq24La91sCIErhYI9UNjkJ0qlCp55ShqG/vYL1mX
	zfngw9/RLMzspzynK2I2yMF55PoKsxrPGZzcjurL2ck4u3oxFvhi5DIxWTu+mRavw4kxRu81Q3b
	JcgTMhPeVKO/rnHunolk46xVMcapYNsEVqvhN2inzDb9IKaRX7QwKG3IVrDyYQ==
X-Google-Smtp-Source: AGHT+IGpSQMkPSuyGczqelODInn+o06rFtSM/uvcuHZLXSjNIjg/D3Vf7tgo5SrrzTuK2GH2sm3/nw==
X-Received: by 2002:a05:622a:1981:b0:476:9e90:101d with SMTP id d75a77b69052e-4795f35260amr36524261cf.38.1744193015431;
        Wed, 09 Apr 2025 03:03:35 -0700 (PDT)
Received: from [192.168.1.159] ([2600:4041:5be7:7c00:70db:4589:e2e1:f14])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47964de11absm5149601cf.34.2025.04.09.03.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:03:34 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Apr 2025 06:03:21 -0400
Subject: [PATCH v2 1/2] rust: retain pointer mut-ness in `container_of!`
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-no-offset-v2-1-dda8e141a909@gmail.com>
References: <20250409-no-offset-v2-0-dda8e141a909@gmail.com>
In-Reply-To: <20250409-no-offset-v2-0-dda8e141a909@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
 rust/kernel/lib.rs    |  5 ++---
 rust/kernel/rbtree.rs | 23 ++++++++++-------------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index de07aadd1ff5..1df11156302a 100644
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
2.49.0


