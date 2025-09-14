Return-Path: <linux-pci+bounces-36093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01135B5647D
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 05:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15EE423D00
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 03:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8C92594B7;
	Sun, 14 Sep 2025 03:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="GytkyEDg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BE2236457
	for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 03:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757819924; cv=none; b=bbR+23vLFMvc3aLJ0yD4z02xj3QyjDKV9Ulh0yfMxllv6A+bVnSQR6QpcHnmA2TsscBti8IH9a3oE8r1bm0FZo3o08GW7odR4+tG3q+NqOqW4Qb96zxFdoO4AB7H4zO5RkZLt/tauoKCcyFZLGJyZN8/fs8/Fn51aGOZbFlHxrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757819924; c=relaxed/simple;
	bh=8HO2CnGxw8Rdk4WqdBVxErp0DIVbRBXyJCZ0iU5iBmM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=H3xk9tmTAb9QWE1GHeCXj4lI09zrU8J0vsJEialX1cwi7564V7Ixhao4oQ7GXkGeapXoKzak2vUTPx+CoKlnLW/oo20sq3jMpIANdxoUervmfYhOXfc0w9RxAx6LNKRV8Bj0FasjhceZj3xXGgLw7ned8g8w/RXpWKJ198Ed0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=GytkyEDg; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1757819920; x=1758079120;
	bh=MRymjWNgeQmfyE+Ew0Sso7XVl0th26D1I2xxPRRCtl8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GytkyEDgoAg8CsVF75MsS7+9fxk5YLZFnHPxSA9OIkGcHPnscGcAMkcPrshtNeYsL
	 pVr6KzemNeCSJm9wFvPn6QxwSKVdfgwQAxbUQX5I7y7wabHFmEgjXJHtG6JIs+9shL
	 GYcJNoUZpYZAGM6FY01YHNDwog/5frwfJ0T1iWsoJP9d2OMVTBemRcXGjr3Y3QDHLR
	 56raGfapGYlcGxyUdl0ZKrPUy3G4M3Sjd9S3GW7vrX3o6HITb6Mri3yEuTk1jPotnT
	 Bw/WDxkPQdr8WQ4PRn5coUJe36GwMsCJyyK7QsdTvYTFXcdOa7g8f9unFGKoyRK50Q
	 fCaqf4uHwEm5A==
Date: Sun, 14 Sep 2025 03:18:34 +0000
To: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Rahul Rameshbabu <sergeantsagara@protonmail.com>, stable@kernel.org
Subject: [PATCH] rust: pci: fix incorrect platform reference in PCI driver probe doc comment
Message-ID: <20250914031759.9122-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: c356bd28e0d6c3f604f7b64224305d417f54c575
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Substitute 'platform' with 'pci'.

Link: https://lore.kernel.org/rust-for-linux/CANiq72msM5PT2mYKrX_RPXYtA4vap=
MRO=3DiSex1gQZqiXdpvvDA@mail.gmail.com/
Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractions=
")
Cc: stable@kernel.org
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
---
 rust/kernel/pci.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b553..c21cadfc879a 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -240,8 +240,8 @@ pub trait Driver: Send {
=20
     /// PCI driver probe.
     ///
-    /// Called when a new platform device is added or discovered.
-    /// Implementers should attempt to initialize the device here.
+    /// Called when a new pci device is added or discovered. Implementers =
should
+    /// attempt to initialize the device here.
     fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> Result=
<Pin<KBox<Self>>>;
=20
     /// Platform driver unbind.

base-commit: 099381a08db3539c6aab6616c94d7950d74fcd2d
--=20
2.47.2



