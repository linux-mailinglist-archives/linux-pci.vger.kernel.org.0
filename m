Return-Path: <linux-pci+bounces-36094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80306B5647E
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 05:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4094F423D2A
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 03:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE37424169A;
	Sun, 14 Sep 2025 03:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Y/q6CQFQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2952D158DAC
	for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 03:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757819969; cv=none; b=ij7bM+mxdMIcUhXMtDq7cW84n3ZrVhPBI+XpQ7wpSzIzRCONNmM2BhC/y7g96fLhIYmDQQk13NVKukWSBkgma/QXhKErh7CF4dzCXulZBhMduENOFgqlDcf/y+Klzn8IhXQpyeR5ihtoRI1BydhsYSWpDNumr5DMjQUq/12WNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757819969; c=relaxed/simple;
	bh=85dF99pIbn6AH9GPkzTohCZZZihGYeGW/3C7S2O1bA8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dkDokCSKH9/QejMZjAaIYVq9Z7W01dPjBe5Qa5lNI4n0RJnKVhEAY+lP+FFkcgtjB35Qp1CHcyimOdGNoV4eZa9KGmuVg+iOrKmksyfo1hnh3zW418VfpapIyAJ0ha/yF5mLDEMwoDSE9hg0HyUOUDyyYx9NibRd8Z4qdA7kvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Y/q6CQFQ; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1757819965; x=1758079165;
	bh=IiPBwCshBfHLdnwVP1Xr/VZasVm16o3JkjnqwUqiGGo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Y/q6CQFQVfsvIGDLXiAuxSMO2g/4FQs2yK9roqSm7FFQl4VJ786R5Y+mZgACLQ7Tm
	 yHhEHTVWjW+L7AXZxkce54gN46p5UzSseuv9LBwR7oIHXRE9wB1TrI3m4qHfPMgFLG
	 4AU3OqFcEzYtE5NY2UvTNIRhQ0hCLOrw3LUgbAmDmQ08pubPDuOxqwSghQ/asNO+Ge
	 vUfsC2LXJIPknOFE5p9onAFnk/0jRmZeddRndDWS6wW38opCBlcEMYS7IGWJfSduqJ
	 0c1emwFPi63IVe67KUq6ymb7vkmZFrLT1m5rQLqpMggggU/rkCOZo8oNOmqErmjHAx
	 RY9SZphLM9BFg==
Date: Sun, 14 Sep 2025 03:19:19 +0000
To: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH] rust: pci: fix incorrect platform reference in PCI driver unbind doc comment
Message-ID: <20250914031901.9399-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: c0c840400873c61a247d108c09ea6f4cf5b6894a
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
Fixes: 18ebb25dfa18 ("rust: pci: implement Driver::unbind()")
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
---
 rust/kernel/pci.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b553..a07a7fd3d94b 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -244,7 +244,7 @@ pub trait Driver: Send {
     /// Implementers should attempt to initialize the device here.
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



