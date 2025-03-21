Return-Path: <linux-pci+bounces-24409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E52A6C567
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3B9189F4C6
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 21:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D7C233126;
	Fri, 21 Mar 2025 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgjyGHhs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6402327A1;
	Fri, 21 Mar 2025 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742593713; cv=none; b=mxaI8qqBLkVIpzY2Gv2OZZ/pDOCUIP4Gy0VCGqtqpS542uw6tKxc9qTdm308D7xgmUIGVQ/gY9RNllkvo1QC31v6ImlwnSKC++JQLg2DgeKFlAu747BW7FW7q9g5fJ+q6+l+0X8/7o+06LmQ79wTQwRZin8D+400di38+3TPckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742593713; c=relaxed/simple;
	bh=gFVLFoBbRVI7YrvkgLG88tqFY5GkEJSMaYCfnvuQIig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdoqSq5yHnj8Ja+GSwx5WoHWzX3xMupBujoQmhIe5V6K4fF6xCtdqpX/ZClXoldYiSllY8YNBZ8HFXDH0lq6xQyN4q4jn3jx4JfBjAmO1TFgG9TfmjeyKOuyNkRqkTHrLOGsBnVvfgF8HxHBwwZJoj+2BYU8OaM0Bflw2QL7Ad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgjyGHhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD492C4CEE3;
	Fri, 21 Mar 2025 21:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742593713;
	bh=gFVLFoBbRVI7YrvkgLG88tqFY5GkEJSMaYCfnvuQIig=;
	h=From:To:Cc:Subject:Date:From;
	b=DgjyGHhsXrzBkoNFRqXgayI/ySiABNv4OJklgKlyZRkL9KBCeVRLWF/Af1NyXy3XM
	 REfXJNHwKoXc+el9kDFgqFCHxdgcBnWBNyclEqCRSLORIrB89bh4PhNvuuxEtgtSpC
	 9IyaMSuiLnb/fFP2iaH9XXD8eH+GGHgziClkC2MRna2PHGdS0JkR92JS85G7O4Xflm
	 9cP9G7u4rNVNvRN4COunHYH+S9JLGgGcBJYF+P57yhG4VNjSR79wvxco1Ysv2WNEwu
	 O2BR/3Z86NwveMbFfwi2XORTzE9Ux0C0E/5IOVJwkNRlYDmp8pdYp9OhuueIi/E3IK
	 Opmw5TFVvb+Fw==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
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
Subject: [PATCH v4 0/3] Implement TryFrom<&Device> for bus specific devices
Date: Fri, 21 Mar 2025 22:47:52 +0100
Message-ID: <20250321214826.140946-1-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series provides a mechanism to safely convert a struct device into its
corresponding bus specific device instance, if any.

In C a generic struct device is typically converted to a specific bus device
with container_of(). This requires the caller to know whether the generic struct
device is indeed embedded within the expected bus specific device type.

In Rust we can do the same thing by implementing the TryFrom trait, e.g.

        impl TryFrom<&Device> for pci::Device

This is a safe operation, since we can check whether dev->bus equals the the
expected struct bus_type.

A branch containing the patches can be found in [1].

This is needed for the auxiliary bus abstractions and connecting nova-core with
nova-drm. [2]

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/device
[2] https://gitlab.freedesktop.org/drm/nova/-/tree/staging/nova-drm

Changes in v4:
  - work around a minor issue in rustc < 1.82
    - https://blog.rust-lang.org/2024/10/17/Rust-1.82.0.html#safely-addressing-unsafe-statics

Changes in v3:
  - drop patch to add Device::parent(), will make it crate private and part of
    the auxbus series
  - safety comment: clarify that a device' bus type is guaranteed to be set
    correctly by the corresponding C code

Changes in v2:
  - s/unsafe { *self.as_raw() }.parent/unsafe { (*self.as_raw()).parent }/
  - expand safety comment on Device::bus_type_raw()

Danilo Krummrich (3):
  rust: device: implement bus_type_raw()
  rust: pci: impl TryFrom<&Device> for &pci::Device
  rust: platform: impl TryFrom<&Device> for &platform::Device

 rust/kernel/device.rs   |  9 +++++++++
 rust/kernel/pci.rs      | 25 +++++++++++++++++++++++--
 rust/kernel/platform.rs | 25 +++++++++++++++++++++++--
 3 files changed, 55 insertions(+), 4 deletions(-)


base-commit: 51d0de7596a458096756c895cfed6bc4a7ecac10
-- 
2.48.1


