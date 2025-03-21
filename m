Return-Path: <linux-pci+bounces-24363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A02A6BDDC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 16:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF72188DFB4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BFF1D6DDD;
	Fri, 21 Mar 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lga23/nq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE723BE;
	Fri, 21 Mar 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742569153; cv=none; b=pqvv1c8TO6lJ0gWrKQaoh7YtRrefrWhEvRdbcYLKMrIU0x/WkoFBHuAifzGvxAsDXAqEJBXT0yoGnNOVWvrklVPu9P2x2tTmajsp2FZ82UkomeWzlamaF6D2ObPYsAZnCSoc4vTpTwrGJWUg/bTqWQvWvBXS7ffqz/S8OVS9XlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742569153; c=relaxed/simple;
	bh=SasuqPXrFlUPpeyM81uLeoCDXlTTlAtVkXYfMgQo80c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAzG57Ajf7MNa6JqbW6rerWgTk+airfUNOLxUwQiHI2fsjm/4sK/KiGxWLRIGHA46jASEROxKRguHmdv1+WzyjlvjR5Coz4SsPt9nTNDEisKduBSD7kl26UWXEEDOMVJZrREGY3VhxQYMDNrihfT4QVpCwNy7LCpLCAwwS84DT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lga23/nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F331C4CEE3;
	Fri, 21 Mar 2025 14:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742569152;
	bh=SasuqPXrFlUPpeyM81uLeoCDXlTTlAtVkXYfMgQo80c=;
	h=From:To:Cc:Subject:Date:From;
	b=Lga23/nqLzxWhjrx5cfw3S6Xd2X+2W86ZX7hz5jj6PoQWuvJI0tiqLuix5NUZz5CX
	 sGOBDpApnQyAelCVn+mO6Ni9qwM1FNIve6YnBerORaHHXJ0/JvSen5VEtE87241BiP
	 9gZm/QDfu8g/4HayZ72glwEOTALAUO4nq+upGU6WPNKpXHy4YUDinPDNgBNeQbfyz/
	 2Fx9EW6EI3ERK0zWkZv4+NBA3niefhJdhom+djk6W+ONzbvIqMBfh3fRcJ+nfCd6Nr
	 D/kyebCE+8Ax6Q5XNtpZcmf0aP1AzN6AyzitcIqRlA+YGBy7OvPGxuEQ9KWSVMBb+p
	 kPOCCBZRN4tuw==
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
Subject: [PATCH v3 0/3] Implement TryFrom<&Device> for bus specific devices
Date: Fri, 21 Mar 2025 15:57:55 +0100
Message-ID: <20250321145906.3163-1-dakr@kernel.org>
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
 rust/kernel/pci.rs      | 22 ++++++++++++++++++++--
 rust/kernel/platform.rs | 22 ++++++++++++++++++++--
 3 files changed, 49 insertions(+), 4 deletions(-)


base-commit: 51d0de7596a458096756c895cfed6bc4a7ecac10
-- 
2.48.1


