Return-Path: <linux-pci+bounces-35289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBA8B3ED96
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 19:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D874E0120
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E17320A20;
	Mon,  1 Sep 2025 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu6OJ+S4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2220030E839;
	Mon,  1 Sep 2025 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756749498; cv=none; b=Ko78vDFkrwcHkEBBsl1G6COIbjnITP3s+okgWk/yHD40zuQCQNbYLXsUOUgBKM2XlANLIelfqNKpCgrifjGso6RKeHxpzdvPDO3wvVb7s8Qtuduo/d5595aZ1Yobf+97h/ERlxUtY1lq5bSUvYYlukgrwYGVdZRdO2gZiFtcMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756749498; c=relaxed/simple;
	bh=lnUYxEo+qbQ/4L8pc1O8ViES3IqqvQLMaCk/XcJ2ZZY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=tOI9D0HThTljHAV3zqhNV/ak/VgxXHPrdG2GfMo1ywwHktxlDVwgl+8gufhFb4GVMv8e/iypV/dE1kOQyhDoDK/KLum1yxcojPEvPwzzMCiZYj5r4deNmK3crV+PIToOmBfLgGFhoJONQ12PADLMu2Ggjx89nDp9dFfY13060wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xu6OJ+S4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5EDC4CEF7;
	Mon,  1 Sep 2025 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756749497;
	bh=lnUYxEo+qbQ/4L8pc1O8ViES3IqqvQLMaCk/XcJ2ZZY=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=Xu6OJ+S416039lcQl4+pAQ8cJbk+JNPmi8uGtmHLpLMOU+d8DhBYVYD+qpvto5aXn
	 CaXjNnhZxpzdmX7Qyfi29U9SvWv6eFeYsmNOSBNjd+Jv6B01BHplQ47vHpfIgqiru3
	 xWOye+MsWB2q7for6LafODy2ijg7hQRnFigzy6ANdmbfbHpeszEsM8DiEj+pmwa9oT
	 oME75FpJxUOaZP/cfCR7EcMGqE6Q//F5cKQBO0iosgx8EmhHi0K3PqdW/srebeoAB2
	 eRxTxWBlOG2dx1g9CuNl7X7Jc6urnHpxh8YAauCuUQaqieytpdMp+yY/gdZ3JpdUZf
	 6AH2ttoIWVGwA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Sep 2025 19:58:11 +0200
Message-Id: <DCHNPZ8G5FP8.3VTQ0RQMQ6NT@kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v8 0/6] rust, nova-core: PCI Class, Vendor support
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Elle Rhumsaa" <elle@weathered-steel.dev>
References: <20250829223632.144030-1-jhubbard@nvidia.com>
In-Reply-To: <20250829223632.144030-1-jhubbard@nvidia.com>

On Sat Aug 30, 2025 at 12:36 AM CEST, John Hubbard wrote:
> Changes since v7:
>
> * Applied changes from Danilo's and Alex's and reviews (thanks!):
>     * Removed a blank line, one each, from the Class and Vendor macros.
>     * Moved example code location from struct Vendor, to vendor_id(),
>       and introduced it in a later commit, in its final form.
>     * Applied Alex's Reviewed-by tag to the series.

I think you forgot to align Debug and Display, i.e. Debug still prints deci=
mal
values.

Is this intentional? If not, no worries, I can fix it up on apply (which a =
few
minor doc-comment nits):

diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index f6ce8f8a2a4d..f534133aed3d 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -26,7 +26,7 @@
 ///     Ok(())
 /// }
 /// ```
-#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+#[derive(Clone, Copy, PartialEq, Eq)]
 #[repr(transparent)]
 pub struct Class(u32);

@@ -81,12 +81,18 @@ const fn to_24bit_class(val: u32) -> u32 {
     }
 }

-impl fmt::Display for Class {
+impl fmt::Debug for Class {
     fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         write!(f, "0x{:06x}", self.0)
     }
 }

+impl fmt::Display for Class {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        <Self as fmt::Debug>::fmt(self, f)
+    }
+}
+
 impl ClassMask {
     /// Get the raw mask value.
     #[inline]

