Return-Path: <linux-pci+bounces-19243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42338A00C5F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 17:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4E07164761
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 16:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813281FA249;
	Fri,  3 Jan 2025 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OG8g4wuk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503CC1FA8F3;
	Fri,  3 Jan 2025 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922830; cv=none; b=t16rAk3eJA8ZRuzAQlvkv9yxhEK21YxyWxOT/oKa8Qah9HWGBBTTmAeDKsk1IWGmlI4HKKQeDSOue5U0H3aL0aA2RTHwsA9h2UJoY9tUQlDXCKGcMHJUVcwHxIEM3SB3mPo6ilsttf/HROy33bSIHxsT0dLjnhylN5esm3sQKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922830; c=relaxed/simple;
	bh=Ay1tki9Era+nIpnCONid/isRboWTp7NV/6rolAejqd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JV93N5hOohalufanFTL8L58H0ZZIDIsQEGpGpiZaUVdQAbfGq6Yy8vgjNlbAAcihkIM/k9Zx5+Qvg8buhfl5uJz/rMrJMEyezCV6KwycVAUGAkqK7s8qUjNlP/tMUBdxe43vKmMA62QfhHhfjAlvQKJfr/iUjOdCXftqCLSHr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OG8g4wuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79782C4CEE0;
	Fri,  3 Jan 2025 16:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735922829;
	bh=Ay1tki9Era+nIpnCONid/isRboWTp7NV/6rolAejqd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OG8g4wuk88YqdGYAV4wvZ8U+Uk9tlna6VYqUXkNR+4YXz/AlLBDa060vQNGtnmFwp
	 qu6MDQ2kfWhyfhUO5kgw8BmwDdkaYY2Zsz4JmTwrOKdaytinn2aum/F1hHaOAdGRSv
	 xaVEIF/j9HPQ4+nSLKGXooy1C+Tixz6kwQbs8uTMdzuyfwkGuoJu6KcyS6gDNeeOyY
	 EaG1bVGImCgTotxOdghA4oWX/IcdUD7aZ8wM0TjKW1WSvYzGu9rR7TCJy5ghIQ65NL
	 IxfMXB62xc74lNEjk6ppPD3HVROJkenQPYD3JKE6dHt38W4s+GqXvaoH8uAR5g5z5U
	 yuZeigQzghfdQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	bhelgaas@google.com,
	fujita.tomonori@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/3] rust: io: move module entry to its correct location
Date: Fri,  3 Jan 2025 17:46:02 +0100
Message-ID: <20250103164655.96590-3-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103164655.96590-1-dakr@kernel.org>
References: <20250103164655.96590-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module entry of `io` falsely ended up in the "use" block instead of
the "mod" block, hence move it to its correct location.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/lib.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b7351057ed9c..b11fa08de3c0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -48,6 +48,7 @@
 pub mod firmware;
 pub mod fs;
 pub mod init;
+pub mod io;
 pub mod ioctl;
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
@@ -84,7 +85,6 @@
 
 #[doc(hidden)]
 pub use bindings;
-pub mod io;
 pub use macros;
 pub use uapi;
 
-- 
2.47.1


