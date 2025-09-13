Return-Path: <linux-pci+bounces-36087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2370FB56252
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 19:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7311B27162
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D451FBEA8;
	Sat, 13 Sep 2025 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="weRtPNN9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2105B1E8332
	for <linux-pci@vger.kernel.org>; Sat, 13 Sep 2025 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757784385; cv=none; b=eN+y4TFxPYurxCdJ5b7fNJpDDGVyKB5ZmnQKo1HTbdzkgjwofQTqfX5OFZLFWJUx8K1plyfrvR5eraEh6+bXyNTW+CiaVLBjAr4XT7JeXrDkfgy0mIXSjpv3IgIFgNEv4U0pW3PqvUOFMZBw4G867+18dNIyR1HkgV1QDRc48h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757784385; c=relaxed/simple;
	bh=Wf2ZzSOt5660dGKv9igOpDU5akfcnDDqQb605DQBPxk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pTrMfrHT01+G0Eqma3pHv+RMpyEncnOIL0TpqpXsvtRM8LkMM5Ax0alDpD8nUogIzACXdIcn7Km6QW6ETnpS0CvNXquVMsH1jZBcwlmPs2RWU8Zo054W95f0HElwN92VCAlXHWeiCV7Aa38Nt1dSuRsiLFguRXkuNrCvuuCOzD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=weRtPNN9; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1757784380; x=1758043580;
	bh=nm6twt1cSQc5oagHyaklZaX2j2ffhTb0crzBpiIBMwU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=weRtPNN9t6WEITu2+86JapOAokMT0rCgy+iXtk+EcEugfAYo86AxTg6oNdM7h7dx5
	 W0VkwQn5KDMiEH+UkZ7uD5ei3+kvtNY2w5T6N4AvaN2vfBoVfA0keQT3xLmUyQ/dYq
	 e6Km2+UlQ+ZxagAjikEByDemlCc4wWJ65IoPmSGwBYZOjVy5kU4wcUomJLHeTxHVHV
	 2HRlSNamvNrVZhmrZHTp/qBAaplCFe3f76AYL6BWltVlpwVdjm8lrFEzu13Ew0cWu2
	 sqnUk1stHwFwUPhwfPgjXmbCl3yU39tcmDh146a+ZRSihV4ykhKT2C03vCuZU5YSL5
	 dhBmy6iTvARGA==
Date: Sat, 13 Sep 2025 17:26:11 +0000
To: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH] rust: pci: fix incorrect platform references in doc comments
Message-ID: <20250913172557.19074-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: 0ce628db2ce03996e49017e2cd6672b0a22d3d22
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Substitute 'platform' with 'pci' where appropriate in the comments.

Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractions=
")
Fixes: 18ebb25dfa18 ("rust: pci: implement Driver::unbind()")
---
 rust/kernel/pci.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b553..658e806a5da7 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -240,11 +240,11 @@ pub trait Driver: Send {
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
-    /// Platform driver unbind.
+    /// PCI driver unbind.
     ///
     /// Called when a [`Device`] is unbound from its bound [`Driver`]. Imp=
lementing this callback
     /// is optional.

base-commit: 099381a08db3539c6aab6616c94d7950d74fcd2d
--=20
2.47.2



