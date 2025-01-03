Return-Path: <linux-pci+bounces-19241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E58A00C5A
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 17:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6D5188028D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 16:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC82E1FA8F5;
	Fri,  3 Jan 2025 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pI+M8LIu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6331FBE8C;
	Fri,  3 Jan 2025 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922822; cv=none; b=mt5T0Oe2G+rotqhusyR3QJw79X1LxeUsaNQx57xEsfF6NR7u2StiU/kVE28OrGNuDoBRBVCy5O5VpzY9zvm7pXNT/JjVBjOp0uyP9BZUbYSehW+bhItVtNiBA/ipN1xilGj1tqfkTvZrgwRpAODQXfcwkXE/dKfGU2hPyPstiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922822; c=relaxed/simple;
	bh=JlclBmU+7aNNkKpFtS3j2IsHfxgZgnHrbWtmyIC+Cb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eu/65wa1+Tr7PIvS11NU2zomA1eLuSRGxML3zwyCoK4ehLqjgx1ZUu1dVqbwgsukBm1cuGpNx+tIgtA6BQ0bOj2xh81SRJxHdP/cfR6pxRtop311VM/rspnc/17u8uQ8haL9CY8mt7HUfMxyBmAg0AAoeFXNbmb8fr2HlHEiqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pI+M8LIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A74C4CECE;
	Fri,  3 Jan 2025 16:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735922822;
	bh=JlclBmU+7aNNkKpFtS3j2IsHfxgZgnHrbWtmyIC+Cb0=;
	h=From:To:Cc:Subject:Date:From;
	b=pI+M8LIud258aoMvZmLwXlMgfNMVstxfLSZyukVBqTDqChLMRULjC7yad0PdAtQoM
	 omGEtyW48kTKDCN2ptPeYYyp9YGMOoujm0Misa9krMNMmw1OJwZ9UrZ08x9pjjFuC0
	 rCst2ISyiq0UAht56wPg+khlkqPMLNmPZelzCF3m6PWg18EPFlgiTyN0mZDQrhKI9f
	 z9MfzNKKzVIa4jJm0UeuVt0LkEKWfhB9JzivaCHB2dIMav+B55vOqY128nqv6DJ0ym
	 pVN/p48eYZvtsAPREmVaERF2mMeHfTGaOoTXr/xzOmjTQWdW8xijT9BgPHxaDXh36R
	 yzx1/46itRa1w==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	bhelgaas@google.com,
	fujita.tomonori@gmail.com
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/3] Fixes for Rust Device / Driver abstractions
Date: Fri,  3 Jan 2025 17:46:00 +0100
Message-ID: <20250103164655.96590-1-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series contains a few fixes for the preceding series [1] introducing
device / driver Rust abstractions.

Except for the CONFIG_PCI_MSI dependency fix, there's no functional change.

[1] https://lore.kernel.org/rust-for-linux/20241219170425.12036-1-dakr@kernel.org/

Danilo Krummrich (3):
  rust: pci: do not depend on CONFIG_PCI_MSI
  rust: io: move module entry to its correct location
  rust: driver: address soundness issue in `RegistrationOps`

 rust/kernel/driver.rs   | 25 ++++++++++++++++++++-----
 rust/kernel/lib.rs      |  6 +++---
 rust/kernel/pci.rs      |  8 +++++---
 rust/kernel/platform.rs |  8 +++++---
 4 files changed, 33 insertions(+), 14 deletions(-)


base-commit: 06e843bbbf2107463249ea6f6b1a736f5647e24a
prerequisite-patch-id: 5ce64efa11560206236db2b2f014ceaa3d2e9fa3
prerequisite-patch-id: e86a1e93ce4e9e8440be0bb641ef99def521b75f
-- 
2.47.1


