Return-Path: <linux-pci+bounces-25750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EFAA87304
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224F83AEDBA
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4BD1DB154;
	Sun, 13 Apr 2025 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bl5y12IT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6FD1A0711;
	Sun, 13 Apr 2025 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744565886; cv=none; b=fEVLNwTOx5W3lahdobzWasEy1NtrHA91rBlAHbSCeWdorYPfgv+klVj+vULePS96BKFqgtzYDqAue87pG2zlYZdMLhpJo+64Znpliffrt+nM7fZa9nZjTSC5Nozy5uvh5c5zR+kIEvk/ezX4FGtSKr8ZwnkZES/r0z7iKkaLJsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744565886; c=relaxed/simple;
	bh=B/4wpZfymQa2EZNIHKUkhiU9jz14uKnVoG+hwSh5Npc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gBlqXt3eaPwDpjsUESQCh1fDjkWd2q3Txk3peo0C2iTwTvRqlGJp/LvT+q+m21X/5AzhiuQ6goiKNkGZOriqEc5qTGGA5Ix0l2fwNBJvcNtGXGKFewu4y6D2S9ndByvhWbtTJBZtZ8NgPdfH9AZ4ScoT1r2RivJ7PGL6adxWhmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bl5y12IT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB80FC4CEDD;
	Sun, 13 Apr 2025 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744565885;
	bh=B/4wpZfymQa2EZNIHKUkhiU9jz14uKnVoG+hwSh5Npc=;
	h=From:To:Cc:Subject:Date:From;
	b=bl5y12IT4LGGcBXw7WS1SBz5KtTvBnocG0ZNdwiLbs1JHf2dMPwdTwx91oYc1u0/X
	 XenTCVf0bshSRGr89mVypR8joX6Lowz4pjIAfZTwhAncKOkuBKlXPJrk1tEobKQngz
	 TmYX5ohAtzo7jYhYdQZN6hMyfc6ibSdf+WU2O5AUr1wIXr5FKEvjHWtyNJOmpugrV2
	 5w5anKe+T3jJSIZrOomOdJcXzirYg9SEU1mmSnV4jbCU0RlHYLhi7ESlG0TiO4HWNW
	 Vs1R4FOvFo0xeSBXcLz/PhEgFsk78IX/GnsJ4OJSMSa901do5T9ADn1RcN8sBto3Pg
	 XjIUSCSqM1sHw==
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
Subject: [PATCH v2 0/9] Implement "Bound" device context
Date: Sun, 13 Apr 2025 19:36:55 +0200
Message-ID: <20250413173758.12068-1-dakr@kernel.org>
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

A branch containing the patches can be found in [1].

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/device-bound

Changes in v2:
  - add a safety requirement for impl_device_context_deref! (thanks to Benno for
    working this out)

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

 rust/kernel/device.rs   | 90 ++++++++++++++++++++++++++++++++++++++++-
 rust/kernel/devres.rs   | 17 ++++----
 rust/kernel/dma.rs      | 14 +++----
 rust/kernel/pci.rs      | 33 +++++----------
 rust/kernel/platform.rs | 32 ++++-----------
 5 files changed, 121 insertions(+), 65 deletions(-)


base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.49.0


