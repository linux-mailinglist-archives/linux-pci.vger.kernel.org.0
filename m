Return-Path: <linux-pci+bounces-26804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C157A9DB27
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 15:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72DA1BC3505
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A8C1A314B;
	Sat, 26 Apr 2025 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUwsKfEn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753532AEE2;
	Sat, 26 Apr 2025 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745674411; cv=none; b=irh2WXtW1ZniI1IW54dPVBzqmnjvJAzbBGAs3iCgJ2wollAALOPCdfdeE7ojHbT66szqmEKq9lyQWPaRBiB1fNDtTlDxY0W7/eEA5eAe1W75MsoUOgbh+liKcgypGNPX36QRa3jYvgIiZ1LoUwPqx2R1Myyu6MagwAKFUgfWUeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745674411; c=relaxed/simple;
	bh=Q51t3QQh20KldIs+eP0TWsJWWOPLKFAbPxB8JZmnv40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fu3E50dbJhqTblBFtMpuEG+Trt61uVLvtIGVnNI8Fl+GjZU4TotNrvdj9fitYXzt/ZiiA9mIL6Ztb11DrpiqmzqWoW9ISGaR8vNhSoOJAWw05n/YGU8F68/pMQe29/5cYYLdmww+F2ivyA+VabBGYXCxQegA4X6VcY9L95D7HdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUwsKfEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF01C4CEE2;
	Sat, 26 Apr 2025 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745674411;
	bh=Q51t3QQh20KldIs+eP0TWsJWWOPLKFAbPxB8JZmnv40=;
	h=From:To:Cc:Subject:Date:From;
	b=nUwsKfEnhVMbh7YJYJJsp2JfSJ3J10UvvjpI90Eza1oS4g5Me5GUWDAbBH6dz1j3u
	 efQUU/6xMslO6qD92QyjK1okcjiZeaLtxPrDTDeoCUvCQPRNxYX7z61/9276cmWzpy
	 B4L1rtj91FuNglRJnHT8Hwu/5qabad4/DxPvHAmfsQaikkcOC4uVrWINsur7Qok/0Y
	 aVc9slV9fezmOUnczz9h/NbLMpf8cMGPnWME/NAvg2CPhmx9df/0mSCoaa6sftBcui
	 bsrnqZhnDqZN60sQzJ3dDOjJ/5uo9rthQUC9XwMCwOZ4pk816vMl7sWmQjyIhIZXb0
	 Ew3IepcrCbN9Q==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	zhiw@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	bskeggs@nvidia.com,
	acurrid@nvidia.com,
	joelagnelf@nvidia.com,
	ttabi@nvidia.com,
	acourbot@nvidia.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/3] Devres optimization with bound devices
Date: Sat, 26 Apr 2025 15:30:38 +0200
Message-ID: <20250426133254.61383-1-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements a direct accessor for the data stored within
a Devres container for cases where we can proof that we own a reference
to a Device<Bound> (i.e. a bound device) of the same device that was used
to create the corresponding Devres container.

Usually, when accessing the data stored within a Devres container, it is
not clear whether the data has been revoked already due to the device
being unbound and, hence, we have to try whether the access is possible
and subsequently keep holding the RCU read lock for the duration of the
access.

However, when we can proof that we hold a reference to Device<Bound>
matching the device the Devres container has been created with, we can
guarantee that the device is not unbound for the duration of the
lifetime of the Device<Bound> reference and, hence, it is not possible
for the data within the Devres container to be revoked.

Therefore, in this case, we can bypass the atomic check and the RCU read
lock, which is a great optimization and simplification for drivers.

The patches of this series are also available in [1].

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/devres

Danilo Krummrich (3):
  rust: revocable: implement Revocable::access()
  rust: devres: implement Devres::access_with()
  samples: rust: pci: take advantage of Devres::access_with()

 rust/kernel/devres.rs           | 35 +++++++++++++++++++++++++++++++++
 rust/kernel/revocable.rs        | 12 +++++++++++
 samples/rust/rust_driver_pci.rs | 12 +++++------
 3 files changed, 53 insertions(+), 6 deletions(-)


base-commit: b5cb47f81a2857d270cabbbb3a9feec0e483caed
-- 
2.49.0


