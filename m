Return-Path: <linux-pci+bounces-43523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE9BCD5F89
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 13:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E6E4300CAE3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 12:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92179280CC1;
	Mon, 22 Dec 2025 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhshdWIr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD527FB2D;
	Mon, 22 Dec 2025 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766406240; cv=none; b=m9fee7Bps/LkBOi6bnvF7X2QbonQ8V1rqRGT4v99fG4pLNhS2Ev6LoANOl+JNSoH1cPheJ1ll72nw6MMgBxwtjt09PxJHCvJIrkSPZPjuLwu8AOs8ycENZIrWvYfnmF1MLaSTQR914Jg7+k2aUMOQj+PZwmerMbRI0lU2lNSzvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766406240; c=relaxed/simple;
	bh=cRfzS6hpsjm3mIVx+KnpeZYYf1Z9hwfZCyLq4++zOnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o/zEwA0QH6fNJ/4Yg/Jat5FdokgFxjAYpMvJdqGlHz227w3xdeskbsD7QmI76BJ77WibHobyn8WgJ2T6omIW8jjHnoUPQLPzPqG72UvVNXgSCyYIX46LppA0kFRbvcwiuPXu+SZyV+XnBbltAEUZtyIPUKyJI/WdAmy5J7FpHEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhshdWIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCD7C4CEF1;
	Mon, 22 Dec 2025 12:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766406239;
	bh=cRfzS6hpsjm3mIVx+KnpeZYYf1Z9hwfZCyLq4++zOnI=;
	h=From:Date:Subject:To:Cc:From;
	b=RhshdWIrgy3ZvMVqSXx16+LQ7o1+nkjQq3ksiMkPm8atU8nDqXoQ+6vRzfkfL9MRe
	 +Zzwskw+zQzhlnl60pBMfT81vUA46EbJWgxFLZK7vAh5gmBoyU72NaWiIQCN2Q27b+
	 QZKfvEXApYPjA8GiZZGOOUYPaqI4bTMIcicPIDkx9XagPCOB5d1R/0roo9FZD3JCbW
	 KYU7v3Wy0K5tsQQEtq+nYJl8BeEvAJJYh1fKxCfqiOUfuvxmY3/XfVQW5MUrVo5suJ
	 QHL4Digr2IG+vTfWd1isEMJxUNJjijlWDAHRDW3VaockkIFb8a1dTGQUNOsjpPblgA
	 QaH2QOYsn9AWg==
From: Tamir Duberstein <tamird@kernel.org>
Date: Mon, 22 Dec 2025 13:23:54 +0100
Subject: [PATCH] samples: rust: pci: replace `kernel::c_str!` with
 C-Strings
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-cstr-pci-v1-1-a0397c61bbe4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAQBCF4VfRXNuyY5W8ilysMRgXaAcpeXeLy
 6/+cy5QDsIKVXJB4ENUljnCpgnQ6OeBjXTRgBkWFhEN6RbMSmKcK8nb3nmfW4j5GriX87uqm9+
 6txPT9u7hvh+A1X+LbAAAAA==
X-Change-ID: 20251222-cstr-pci-448ca1f4aa31
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1766406236; l=1610;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=eIiCZEpCXwm0lYW7nlIcBC4LISLHmRjJ00ysC+jHjbI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJobuKeGzjj3ZQiIDYXhu86F4ytiiGBMjxXU/dz8Py9vOSdaZqBykF18s3n9TbFt+QxhWYWzZAe
 9xPy3F4ByQgc=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

From: Tamir Duberstein <tamird@gmail.com>

C-String literals were added in Rust 1.77. Replace instances of
`kernel::c_str!` with C-String literals where possible.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 samples/rust/rust_driver_pci.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 5823787bea8e..991cc111fd63 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{c_str, device::Core, devres::Devres, pci, prelude::*, sync::aref::ARef};
+use kernel::{device::Core, devres::Devres, pci, prelude::*, sync::aref::ARef};
 
 struct Regs;
 
@@ -79,7 +79,7 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> impl PinInit<Self, Er
             pdev.set_master();
 
             Ok(try_pin_init!(Self {
-                bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, c_str!("rust_driver_pci")),
+                bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, c"rust_driver_pci"),
                 index: *info,
                 _: {
                     let bar = bar.access(pdev.as_ref())?;

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251222-cstr-pci-448ca1f4aa31

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


