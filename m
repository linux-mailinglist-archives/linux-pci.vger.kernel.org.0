Return-Path: <linux-pci+bounces-25024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D66A76F55
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 22:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD1DE7A3807
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 20:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD1E21D5BC;
	Mon, 31 Mar 2025 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf7OrCSN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E041121D5B4;
	Mon, 31 Mar 2025 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452959; cv=none; b=EgCzJbqCjhHWvexp/lj/FXwwfU8G7tkMngDGgQOG49bHd5HqIWL8ROaR9mMGWGDJlEuIHLgB0xht7Cr+mptRGmqKlF0Gu3TClX9YyhbOlWy3Bs8jK4n9InwOnlaAxulwaGhhGoOk0fYbRRHfC7bZXf6dGqc44rTNmNr/9AndLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452959; c=relaxed/simple;
	bh=jj5/lxEZE+tngZSVTxtZjkJcf2L2JtaOvEVjvyRamcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dX1JNGEd/w0CB8CwUFfvF7xIov5rAyCUGjW/ncqVvpm8TQZYebh6sTzPwlXXBsQZ+h8Pthz6fnDRdyag6EVlx2Vux8IPx9PNis7KqfjFk6qvtq7OFGR2g0ZJuB7dBo/+fcfKx8LXH20cO9Bod+JOkaLcEYuWbKOYU2/t3r9MhuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf7OrCSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD51C4CEE3;
	Mon, 31 Mar 2025 20:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743452958;
	bh=jj5/lxEZE+tngZSVTxtZjkJcf2L2JtaOvEVjvyRamcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cf7OrCSNGRbmlU5cpIPJ/M46rf/5H22gXE01GUizW+bsNdMq8TcLRj2o+VlH9eHwD
	 29vsy6IfbyQGzTvjIypH/HtONpTBktsuiv1z7iehuQbHYBr14P3U2iOFTubjRaCliH
	 KrUEq6eo8z1y7DsojIzZizXY3LdbcKw8Z0rm1y0fKE5DWQQwYXFRMU1ZRJlunsVwg5
	 nTnWpN/w2n2e/WbamKVBU68UqUcHY1msKh6Omhs6QRNyD0CzDi1aFdQ/aILuNLAbI3
	 KPYv4WddZf+p6lribO+t281a03J34u7u1vtBCspc+Zqp3Dnd8v72DaPSbyzWyB5JgJ
	 BWcrm3bFhA97w==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	abdiel.janulgue@gmail.com
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	robin.murphy@arm.com,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 7/9] rust: pci: move iomap_region() to impl Device<Bound>
Date: Mon, 31 Mar 2025 22:28:00 +0200
Message-ID: <20250331202805.338468-8-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331202805.338468-1-dakr@kernel.org>
References: <20250331202805.338468-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Require the Bound device context to be able to call iomap_region() and
iomap_region_sized(). Creating I/O mapping requires the device to be
bound.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index de140cce13cf..b93bf57d2b54 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -390,7 +390,9 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
         Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
     }
+}
 
+impl Device<device::Bound> {
     /// Mapps an entire PCI-BAR after performing a region-request on it. I/O operation bound checks
     /// can be performed on compile time for offsets (plus the requested type size) < SIZE.
     pub fn iomap_region_sized<const SIZE: usize>(
-- 
2.49.0


