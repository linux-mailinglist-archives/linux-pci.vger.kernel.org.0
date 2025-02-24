Return-Path: <linux-pci+bounces-22251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5014A42BA6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 19:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A567188AC8F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32483266194;
	Mon, 24 Feb 2025 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="jgnoQ/tH"
X-Original-To: linux-pci@vger.kernel.org
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3314E8828;
	Mon, 24 Feb 2025 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422216; cv=none; b=PB2anSOqyfZOS1zSWWpN4ltYoW/mBeauD1wsx5FP8OQclyrdr5JyzaM4YWo3VRvuYtfRBufG7ctaJJAYTuG6l6P5Y7dQQXrIPWb9wSf+ewp4/iLMVtBuTMCGc5OfVTbwTOSVuw3prItPMoE6NKBnyf5Bj137Hh0o5tk36HkGweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422216; c=relaxed/simple;
	bh=Vl6urr6HQFsUbyaJvMwo6I4XeN66kqeEoBFOmL22k9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p4qxbAjX2HECLrHboXkaAlL6ZmePfzH9ydbYG6ZeMvixTTCRZa02oIBBpk9kPEyV8/RQ50GTWIXboHRy1S9AOt4FJUloa80bWChxQIGuX6xxMa9131O9rJAo4pbHNLFRDYGOuAkgiGFUq40FkSbW1rFatBmjcPlaz2XApSNpkG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=jgnoQ/tH; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1740422207; bh=DOBfBGdX7ZZpM/xley3bGLMroG6LxxKexfb2wwpHXiI=;
	h=From:Date:Subject:To:Cc;
	b=jgnoQ/tH7GHyoYuDPZaTRXuib9NV/QbG//1IdFGsG81vY8iDXvu47JMDLxXD/9HGO
	 AQhUrrJuz+mP0mVH3zvl0uZZdH9n6x8XFlLsr6ZrWq1h5Uivr0pV2EW68moEUvyufr
	 35qhXr0YUVDWnwFhveVuLl5nd3G0D4a1EsvMK++E=
Date: Mon, 24 Feb 2025 19:36:43 +0100
Subject: [PATCH] rust: io: fix devres test with new io accessor functions
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-rust-iowrite-read8-fix-v1-1-c6abee346897@kloenk.dev>
X-B4-Tracking: v=1; b=H4sIADq8vGcC/02MSw7CMAwFr1J5jUWJiPhcBbFw0gf1JkFOWipVv
 TuBFbs3T5pZqcAUha7dSoZZi+bU4LDrKI6SnmAdGpPrne+dO7JNpbLmt2kFG2Q480MX9s5LjAF
 yOXlq8svQ7l/4dm8cpICDSYrjNzeYzjCO2bD/25ywVNq2D8Vs+SCXAAAA
X-Change-ID: 20250224-rust-iowrite-read8-fix-525accbea975
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=849; i=me@kloenk.dev;
 h=from:subject:message-id; bh=Vl6urr6HQFsUbyaJvMwo6I4XeN66kqeEoBFOmL22k9E=;
 b=owJ4nJvAy8zAJdbGuXyr5NPHToyn1ZIY0vfssfkR3/pp+aGXNc9WpWTlVWtk1/r57XXZlrr79
 rKYA0r1tjkdpSwMYlwMsmKKLFu87t//kbksy/7+3W6YOaxMIEMYuDgFYCLcoQx/xZZaTqyOORL9
 oS5LpqFky4GEjUfeyMb6i6wpkY4RzhX2YPgrqr27+eCph7ce+alOmvNpv+DUv/7PrXxvyDsn1Zz
 3/HiYFQAJHE6a
X-Developer-Key: i=me@kloenk.dev; a=openpgp;
 fpr=B44ADFDFF869A66A3FDFDD8B8609A7B519E5E342

Fix doctest of `Devres` which still used `writeb` instead of `write8`.

Fixes: 354fd6e86fac ("rust: io: rename `io::Io` accessors")
Signed-off-by: Fiona Behrens <me@kloenk.dev>
---
 rust/kernel/devres.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 942376f6f3af..ddb1ce4a78d9 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -92,7 +92,7 @@ struct DevresInner<T> {
 /// let devres = Devres::new(&dev, iomem, GFP_KERNEL)?;
 ///
 /// let res = devres.try_access().ok_or(ENXIO)?;
-/// res.writel(0x42, 0x0);
+/// res.write8(0x42, 0x0);
 /// # Ok(())
 /// # }
 /// ```

---
base-commit: 354fd6e86fac60b7c1ce2e6c83d4e6bf8af95f59
change-id: 20250224-rust-iowrite-read8-fix-525accbea975

Best regards,
-- 
Fiona Behrens <me@kloenk.dev>


