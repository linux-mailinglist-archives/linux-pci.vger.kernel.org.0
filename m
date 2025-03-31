Return-Path: <linux-pci+bounces-25017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E50A76F43
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 22:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4601882FB8
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 20:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BF021A44C;
	Mon, 31 Mar 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlknMpqS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CF42185B1;
	Mon, 31 Mar 2025 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452930; cv=none; b=CpZ5qIE5lVqKdqd8puLW1WVsnq/OeZIYFKVj3Fk6ZxpTGBIB0iWA4imf0463NrPQy8XC1vdGOl7S70u5GGgaYoq+oCaeCa69c2yHUhV7vsqq0fz+Qk57cdV8VOzDWKmwcAvhB27I2JwiLcKEovOWgEyczuNWBDnk/o3N9ayA8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452930; c=relaxed/simple;
	bh=Rrf+5xSTJqr72Z1AgQYdkyHpTJi/G7k0zIP9x0ej4BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=riDPNFXleaOsuaG9MeFZkRbK4WPAxe+H8bxCz1YZA4PmFKMS55guKTIB0hUcScqM9iTMJ1f+Y33vBygT27RKhPozCdTza9hIJqjk33IA7hjrf1rpON3wN1pNb1V+/tRhn4/4Sij6pc8vfKbc+VEyeN/isS1KbLSHfFDjRYVdB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlknMpqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF06EC4CEE3;
	Mon, 31 Mar 2025 20:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743452929;
	bh=Rrf+5xSTJqr72Z1AgQYdkyHpTJi/G7k0zIP9x0ej4BQ=;
	h=From:To:Cc:Subject:Date:From;
	b=rlknMpqS+hm6xR8cXi/IsjNDkTNyVL4MFD3C5yOis4Sk+gjV1waL7iBGP6mLFO42G
	 a9XG0FWPPEm2ZWmgiVpMK+ZBKRRdqWm/w6c+kNffEFc/VvpqiUGwCXHdDO2DGzhBRU
	 CoiC4IMWIPOrAw5Yerdtgz+RBpA8aOrCosW7ZRfPjXlf6Y0R2i6nzQMtLGBCarHCer
	 RmKztntFkPdyypDWT0zq+M6KaqGT3tfqhsHFU5L2M3YRgwGBolZk/+8REIpnklByfr
	 5AoUw1meDcE5uKG3a6BKlABcPnNTYU63C1lx3I2ms7EZDz0yDNV+hr3PIALCywvztH
	 ASSgsRnzNs16g==
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
Subject: [PATCH 0/9] Implement "Bound" device context
Date: Mon, 31 Mar 2025 22:27:53 +0200
Message-ID: <20250331202805.338468-1-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we do not ensure that APIs that require a bound device instance can
only be called with a bound device.

Examples of such APIs are Devres, dma::CoherentAllocation and
pci::Device::iomap_region().

This patch series introduces the "Bound" device context such that we can ensure
to only ever pass a bound device to APIs that require this precondition.

In order to get there, we need some prerequisites:

(1) Implement macros to consistently derive Deref implementations for the
    different device contexts. For instance, Device<Core> can be dereferenced to
    Device<Bound>, since all device references we get from "core" bus callbacks
    are guaranteed to be from a bound device. Device<Bound> can always be
    dereferenced to Device (i.e. Device<Normal>), since the "Normal" device
    context has no specific requirements.

(2) Implement device context support for the generic Device type. Some APIs such
    as Devres and dma::CoherentAllocation work with generic devices.

(3) Preserve device context generics in bus specific device' AsRef
    implementation, such that we can derive the device context when converting
    from a bus specific device reference to a generic device reference.

With this, Devres::new(), for instance, can take a &Device<Bound> argument and
hence ensure that it can't be called with a Device reference that is not
guaranteed to be bound to a driver.

This patch series is based on driver-core-next (with rust-next merged into it);
a branch containing the commits can be found in [1]. It is targeting v6.16-rc1.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/device-bound

Danilo Krummrich (9):
  rust: device: implement impl_device_context_deref!
  rust: device: implement impl_device_context_into_aref!
  rust: device: implement device context for Device
  rust: platform: preserve device context in AsRef
  rust: pci: preserve device context in AsRef
  rust: device: implement Bound device context
  rust: pci: move iomap_region() to impl Device<Bound>
  rust: devres: require a bound device
  rust: dma: require a bound device

 rust/kernel/device.rs   | 71 +++++++++++++++++++++++++++++++++++++++--
 rust/kernel/devres.rs   | 17 ++++------
 rust/kernel/dma.rs      | 14 ++++----
 rust/kernel/pci.rs      | 31 ++++++------------
 rust/kernel/platform.rs | 30 ++++-------------
 5 files changed, 98 insertions(+), 65 deletions(-)

-- 
2.49.0


