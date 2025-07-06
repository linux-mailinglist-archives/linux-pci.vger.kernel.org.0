Return-Path: <linux-pci+bounces-31574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6E1AFA2E8
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jul 2025 06:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981F018980AB
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jul 2025 04:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2AD1CF96;
	Sun,  6 Jul 2025 04:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="r6Dmio5j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233CE1362
	for <linux-pci@vger.kernel.org>; Sun,  6 Jul 2025 04:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751774447; cv=none; b=OKdDmTysEwUV+0w1tMD3kxntX8mRMTyBvqu8F/7WVUGJ2CzBCQhI+Fg5SDvYRnPnwSfrnttfUePDu41PgdokgAek3txKYPTXWZmHLaG9QHfMQ5Q0h9gemLbv77M+nqiNVvvYUWHyJW0W5+oDhqGhBFS2GOM7FRQYFUKaFutuv3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751774447; c=relaxed/simple;
	bh=rI/kI0oAHIyuWvj9cLhxLiqFjgAQNmnf7gDVSGfxKsI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VdPiiwoaxhwg7ZEL9Qx2ge+oZI4p2dQi0Fkkhy3aj6rNTkX2PlAcg2Z7plNPN/5HchoHaJZRAts73jzuT25mlrJabHFgsVFfPHBzd5Zmcd99qtDa/5JHIKjl91sL64HJea1grED9a7CkHTShgZ4JIo9CFyEwDUJE3ChSojaG2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=r6Dmio5j; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1751774439; x=1752033639;
	bh=gpd/usl0o6RHpKBvVUocgfEZk9/4I4i5Mm7Q5TNKVm0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=r6Dmio5jwAzk2lrH7eODpHW/s/eMvEwKsCKWKMc0MsVTpDLH7wZnagu0XLdJQwVk6
	 4AY5/hFqYIersJo8N5szBg3CXV8t9nOwDVHGbgKi77FoREqHroP+zaGygmOdXvBcoy
	 X76AIJcXYAq9xGzZpH/EfyRWXmfbp8VzJvO1+llLOmHVJWfyAIgCK9tCqX+gqT+y1J
	 5CuHqGGhDTRJoDLPTJ2dCVaeNqbGpk8JYPWqGqlxKo9mAETjWeoHyYsWLJt7V50n5L
	 PnYBtsGtdrolbx8NQ7EJt8npvhYemo4R4mceahKMTltc8NWIuFcU321lqik3oY4NlJ
	 h3h5AuqodvMOw==
Date: Sun, 06 Jul 2025 04:00:32 +0000
To: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: dakr@kernel.org, alex.gaynor@gmail.com, bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org, wt@penguintechs.org, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH v2] rust: pci: fix documentation related to Device instances
Message-ID: <20250706035944.18442-3-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: 3aa994d710a1d3aae738648b2fb2df6668803f52
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Device instances in the pci crate represent a valid struct pci_dev, not a
struct device.

Fixes: 7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device")
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
---

Notes:
    Changes:
   =20
      v1->v2:
        * Added Fixes: git trailer
        * Fixed warnings from ./scripts/checkpatch.pl

 rust/kernel/pci.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 6b94fd7a3ce9..b991fb440882 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -254,7 +254,8 @@ pub trait Driver: Send {
 ///
 /// # Invariants
 ///
-/// A [`Device`] instance represents a valid `struct device` created by th=
e C portion of the kernel.
+/// A [`Device`] instance represents a valid `struct pci_dev` created by t=
he C portion of the
+/// kernel.
 #[repr(transparent)]
 pub struct Device<Ctx: device::DeviceContext =3D device::Normal>(
     Opaque<bindings::pci_dev>,

base-commit: 2009a2d5696944d85c34d75e691a6f3884e787c0
--=20
2.47.2



