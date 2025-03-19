Return-Path: <linux-pci+bounces-24165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F845A69A33
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 21:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E347B7B0165
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 20:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9544E215F78;
	Wed, 19 Mar 2025 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0nefezm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2D10E0;
	Wed, 19 Mar 2025 20:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416288; cv=none; b=er/xyNTx9Z8TLTjmW/qzAOPT+baGEZGbKiB30MKnH/pCafXvEa+uoAeLVOg0vkxGU1BmbzBoUuKBKySPYMg8bX03ZpB75uq8RCBOhC4bgDmElWy+ohGuw/pN5nCoAq52BoSqXDH/gkjL+WMcVnXJrzBtgofcY49c8kcTJqzFC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416288; c=relaxed/simple;
	bh=6Xl/Pcaq5N7AF/vlFg1rfoIOXVG0Cl0VCCKDZcJgVOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUTCsuBmxiv3sOr06Y8S77XdugmBJdhUHdG/3LgDUnQWkYfT0yESnBMjnRRnTH5IDNaecm1Blp4N0+SnBvQvTaYTq6U1XXS/2A+WRXY88m/j7hzu7vkVtOjXhPPMUgZ06x61KWZg38P3hgdN2sZs9WkPOlWppz5/QZe9NtSpicc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0nefezm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEF5C4CEE7;
	Wed, 19 Mar 2025 20:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742416287;
	bh=6Xl/Pcaq5N7AF/vlFg1rfoIOXVG0Cl0VCCKDZcJgVOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0nefezm0QfeifDJoype7OPoLq8chL+cVhw+t9KdXPiyw4HsfFV7PWe+5FnrCyvR8
	 ccqqtxpx3ylIzSNKIlcxZLcMugFZuWm8jXEByVot2Wyytl1dm7JpjF01KOddL/hWUy
	 BYkTiKwXu54LOW6BYCBdg0x3UqHh+QfB6QLGhVr6gG4EFDautU9dFIlPzVZs+tAa49
	 iEmSWlQLwGylFmlH7mpnXdB0tCaI2IgND53h1cIbcrz9tJan9Bpz+3QHH5kHKjHlow
	 jgL0pmhkz/4I8rS/nbOxwgGU2iIpaScW25hTuQ0Ovy4XaWC8N/QdyjlYwMkaEJh2KM
	 trZG7Q69rxXzw==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/4] rust: device: implement bus_type_raw()
Date: Wed, 19 Mar 2025 21:30:26 +0100
Message-ID: <20250319203112.131959-3-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319203112.131959-1-dakr@kernel.org>
References: <20250319203112.131959-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement bus_type_raw(), which returns a raw pointer to the device'
struct bus_type.

This is useful for bus devices, to implement the following trait.

	impl TryFrom<&Device> for &pci::Device

With this a caller can try to get the bus specific device from a generic
device in a safe way. try_from() will only succeed if the generic
device' bus type pointer matches the pointer of the bus' type.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 76b341441f3f..e2de0efd4a27 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -78,6 +78,13 @@ pub fn parent<'a>(&self) -> Option<&'a Self> {
         }
     }
 
+    /// Returns a raw pointer to the device' bus type.
+    #[expect(unused)]
+    pub(crate) fn bus_type_raw(&self) -> *const bindings::bus_type {
+        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
+        unsafe { (*self.as_raw()).bus }
+    }
+
     /// Convert a raw C `struct device` pointer to a `&'a Device`.
     ///
     /// # Safety
-- 
2.48.1


