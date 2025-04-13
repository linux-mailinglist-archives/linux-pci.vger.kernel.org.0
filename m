Return-Path: <linux-pci+bounces-25757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A648CA87312
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9043BB56D
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7277D1F4CA5;
	Sun, 13 Apr 2025 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czTlta5D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E1C1F3FC0;
	Sun, 13 Apr 2025 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744565915; cv=none; b=epnAJHHOFNnK+bT/LJHnnZQ16JprLetc8qVd7H1UvsYND+34WENTO2tVFZ5qqMJskUzka+fcfGTIw69moJyAj9ywSjVI3AqSvAwOahV5R1iA8lckt5yNLlfE/vdohX+mLU35mL1Epqs09weYsdGHCU/rI0dEbnPLA/OrWpZa2Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744565915; c=relaxed/simple;
	bh=fkEeseR9PtCDZJ7E32DzZR1VXQCCuTAmIsu3dUC+V8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5PjvUgVFkqa9wQPHkB2bdCTJtjCwlgBOjoLr/gI2ajOwcSGJmRfUc15jxdUvPVKwPM+DY01w49JmJzt9vyKAuffqjJcPpIQNQSo+g5z575lxwUF80zBOiQplXS+Pb3GKNrXY6ASca7MF055JFXaPu20Trwt+muNJeV8hTAmpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czTlta5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133E0C4CEDD;
	Sun, 13 Apr 2025 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744565914;
	bh=fkEeseR9PtCDZJ7E32DzZR1VXQCCuTAmIsu3dUC+V8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=czTlta5DGrOUljqHgiTfzHhqbRYBnYnUVGEdplKN9m+GcYVq86rOJ7tIjXtNN+iL4
	 sW05mecavIWTV0TElJwCn1V/jj85hfFjb6Ez41EwsIuBVUNeYlPNgokCOdAASDZFQu
	 6/GOKKDgXA801XdeMOwii+pwTEBsCGW1wD4bTqd5eIfzt360MKjxffZyQbPGRRRqQ8
	 hXljhB8x3jPTBlARhbHqNlcn4Zvml8S9YiQ9NcrcGa3Td9tHO+r7MyoZ30gh0OpyEy
	 GaFdq5tOAwvEAH+Iwyhi3a218pgvQAIOr/DqGeJy85S3HpSrufX9wMXC7K2nf4xqoi
	 oBVsHBQcWqQyg==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	kwilczynski@kernel.org,
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
Subject: [PATCH v2 7/9] rust: pci: move iomap_region() to impl Device<Bound>
Date: Sun, 13 Apr 2025 19:37:02 +0200
Message-ID: <20250413173758.12068-8-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413173758.12068-1-dakr@kernel.org>
References: <20250413173758.12068-1-dakr@kernel.org>
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
index 1234b0c4a403..3664d35b8e79 100644
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


