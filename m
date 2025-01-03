Return-Path: <linux-pci+bounces-19242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FC5A00C5C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 17:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2252818843C3
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADDE1FBEB7;
	Fri,  3 Jan 2025 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtPhSPt2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE361FBE9E;
	Fri,  3 Jan 2025 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922826; cv=none; b=TiJFKsfxQlWJ8dv/yroUyQSnxnV7R0p4+9BiZgAV5h0O7b/c1uHh/XTJPKACG72ErGS1ltW+1tlH7a2nSh8AKgRr0tcw9BVf2ZTqLBlEhT5ZhWyE/ShXLdrq6zsVyzo6wZHQpGSdRv1gdGQPHxD2oiOzttnqjKmRFQeCdBanoBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922826; c=relaxed/simple;
	bh=L4CI2sWxV0mXBri8isrl2gtO7Mwaf4FLlktx2xGmygU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKSpemMz/FgBgD4RcxEXm8vyK8uav6Kx+98DvfLjSn4XyXH7mi6DeLRh/r7Er5kT1apZFIe8nV3sTsfAnp3GJbLsdFIHGDPcIzEHlU/SsfFJk03p23QbslfpsohAODiPUqyCipArY7BqugWJcksvTydpgSLlBrYTp7xqRDxUVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtPhSPt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BEEC4CEDC;
	Fri,  3 Jan 2025 16:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735922826;
	bh=L4CI2sWxV0mXBri8isrl2gtO7Mwaf4FLlktx2xGmygU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtPhSPt2wU+YAGorHryEmLPVk96EmwsASPwAUYScQcLL15mTNU92DFzjI+Uj6XdNq
	 vdP4E66Vk2Ho2lEy+ieGave0RzMnHzMaqnlwT1R0YyKvyV5vreqQpthb32R5exzp9k
	 tPQtWp3cKsts1hkMwfebUHKkMAXKmhmP3hMueBl+4AOCmh5bd/w6WwMgXj6xwmVSwV
	 aikshqkBJ4BC5F3vfz6WREBYFq48Ck0lAh82K1Vw9JnWP5n6AixVKYqEpmvMhFAFw7
	 izTqfcgBz7xd/G5vKZFNXApyCHvHoV5HI1YjAAmHVuzo5GTqb79JeybUXKtzkixaoo
	 DkPZq/FRtPaqA==
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
	Danilo Krummrich <dakr@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/3] rust: pci: do not depend on CONFIG_PCI_MSI
Date: Fri,  3 Jan 2025 17:46:01 +0100
Message-ID: <20250103164655.96590-2-dakr@kernel.org>
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

The PCI abstractions do not actually depend on CONFIG_PCI_MSI; it also
breaks drivers that only depend on CONFIG_PCI, hence drop it.

While at it, move the module entry to its correct location.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501030744.4ucqC1cB-lkp@intel.com/
Fixes: 3a9c09193657 ("rust: pci: add basic PCI device / driver abstractions")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/lib.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e59250dc6c6e..b7351057ed9c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -58,6 +58,8 @@
 pub mod net;
 pub mod of;
 pub mod page;
+#[cfg(CONFIG_PCI)]
+pub mod pci;
 pub mod pid_namespace;
 pub mod platform;
 pub mod prelude;
@@ -84,8 +86,6 @@
 pub use bindings;
 pub mod io;
 pub use macros;
-#[cfg(all(CONFIG_PCI, CONFIG_PCI_MSI))]
-pub mod pci;
 pub use uapi;
 
 #[doc(hidden)]
-- 
2.47.1


