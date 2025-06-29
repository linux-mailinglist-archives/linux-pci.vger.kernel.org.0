Return-Path: <linux-pci+bounces-31020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9F5AECB7A
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 07:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0AF61897593
	for <lists+linux-pci@lfdr.de>; Sun, 29 Jun 2025 05:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730D8194AD5;
	Sun, 29 Jun 2025 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="KHJc1C4I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F53A8F54;
	Sun, 29 Jun 2025 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751176686; cv=none; b=FHWthXuYhom0mCHe4wEN2Ff/Pa9NKesUIR5Zifqii5MPirjrBhhGZ0CWYZaH6gRLqFUfoGyrUPRwSgI51dUOeW4xY3/XJdollfIywYS/2u8/W6H5EOFi8vY+CflmlWkX6tN6dYWxf5BPCLWdKaddSv+LY0c0wZrj9KxntDWp9qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751176686; c=relaxed/simple;
	bh=LBTVqn4nd52IP3ymQby+uNNgqbogjUUTRQYWhjATGOw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XGdZlk1ahs+xk+atnB7xK36MZPvrNqWS0GDj1lVqKgwOF9gzrdxu1bvolqPKf8+MlsBF8wrD98gT494U2FsAAWNEywKRkXJRP8YjpZSxag+QQOh6qoBRW5zVon1xgKLADP3vfTI6QiUwMdIM2UbALyCOgt8fDEuYb6pDuJgtV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=KHJc1C4I; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1751176682; x=1751435882;
	bh=QBuHJ2caIAnRk1nqtnKI7AaBTYgRMIUnTJtgYpDVMMM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KHJc1C4IBoO+OXbGRE6ThxsRxhX7nLK0AhtethI3BM9iVPh1m3eZksdtMR4mgI7fq
	 ptRJraoTh37YfU97CyC7zbCgD0vm53Sp9akiIKthghXQ/OgbWUSMX39Q9cHjGN77QS
	 gW9XBiONhkZ4OqTyzJ86u6/nd5nz9nrmIiFA5glzlqXH6v8F5CtWB2nGJUheaFBrMo
	 HaNoLChLwGJg0pehXjBOUCDEFjdyO76b7zm0MMJabvcOBlyRpP+Hui0XEhkjvnJ0bj
	 y+24OYpQqGWQAKZUSWmJ5tzD/OGLGFyVi+cu1HqybMzlLebbWwamZTVx0t172rODlF
	 +dIxW+ld0BYJQ==
Date: Sun, 29 Jun 2025 05:57:56 +0000
To: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH] rust: pci: fix documentation related to Device instances
Message-ID: <20250629055729.94204-2-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: 2912ab8be809de1087b671238885b55531e63d7c
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Device instances in the pci crate represent a valid struct pci_dev, not a s=
truct
device.

Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
---

Notes:
    Notes:
   =20
    I noticed this while working on my HID abstraction work and figured it =
would be
    a small fixup I could send afterwards.
   =20
    Link: https://lore.kernel.org/rust-for-linux/20250629045031.92358-2-ser=
geantsagara@protonmail.com/

 rust/kernel/pci.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 6b94fd7a3ce9..af25a3fe92e5 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -254,7 +254,7 @@ pub trait Driver: Send {
 ///
 /// # Invariants
 ///
-/// A [`Device`] instance represents a valid `struct device` created by th=
e C portion of the kernel.
+/// A [`Device`] instance represents a valid `struct pci_dev` created by t=
he C portion of the kernel.
 #[repr(transparent)]
 pub struct Device<Ctx: device::DeviceContext =3D device::Normal>(
     Opaque<bindings::pci_dev>,
--=20
2.49.0



