Return-Path: <linux-pci+bounces-24163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C7CA69A2F
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 21:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5724119C5746
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 20:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1071A238C;
	Wed, 19 Mar 2025 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjhVSV/3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08B010E0;
	Wed, 19 Mar 2025 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416281; cv=none; b=Lv4CsMEY+jhCuNMQUnAy2HYV0oiSSNgk58jNM+60+HEdzdIYGTuIcuS7XOU+YIBRy5/xjrNa0rd7tQYTsvxHYovza6ys+3zvQyKPaZifW0so8IiNHU54yE6Ft99/BzIaRE4JY02ZJUnXj48tJFfLL6bRU4Sau/JqmNwQjxfrCLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416281; c=relaxed/simple;
	bh=Wnai5NFQ8iqGMkSxaLtLfDCC/banB4IOawxKl1R9oKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOFaIdLpEuONUhvizuOBLJ8amUoBgCoBd0HT43Ws737zIMt0+SD093cprgdSDOl+q5tGc7c9FPt2qqtta9F/oKNcW349TcZ6JvlhL7e1PDRpsKKzPaG6zhNPt3loCw1uWMgZJOWLgJR6ANFcMNukLy74xbaOe5EE/bUb3mnv1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjhVSV/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4B9C4CEE4;
	Wed, 19 Mar 2025 20:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742416280;
	bh=Wnai5NFQ8iqGMkSxaLtLfDCC/banB4IOawxKl1R9oKw=;
	h=From:To:Cc:Subject:Date:From;
	b=GjhVSV/3Fv2BtV2Be4jIGUgyQnpkBKoNhpZTpb+G62+hiq5vSRn36AqmMuh9DHycm
	 zahw5UnrxO3HxruhNOWClSxGEeNxueCklxN58aFlTeJBIYOmAf1ffmvStQTpTz1ZKw
	 fbe2HIdhpkgAhgkVeLRDnlLcq5+VEX5d72C+Q+Q/EcIY4/gm224W6MbkJseHc76yvB
	 hoiWnu6IxeH9cKqFSfnzMNSpCavHaqT/PgQGjKbowba+5ncf4sYhWSaj8qrpWwAHVt
	 TJHMQFUrFNsUR7h8wwl5wNe1Nbaffi0uRB+j1qD9j1H/k61NxiUO9shyqxBQCpxaXP
	 uF/zBapMWFgrA==
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
Subject: [PATCH 0/4] Implement TryFrom<&Device> for bus specific devices
Date: Wed, 19 Mar 2025 21:30:24 +0100
Message-ID: <20250319203112.131959-1-dakr@kernel.org>
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

Additionally, provide an accessor for a device' parent.

A branch containing the patches can be found in [1].

This is needed for the auxiliary bus abstractions and connecting nova-core with
nova-drm. [2]

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/device
[2] https://gitlab.freedesktop.org/drm/nova/-/tree/staging/nova-drm

Danilo Krummrich (4):
  rust: device: implement Device::parent()
  rust: device: implement bus_type_raw()
  rust: pci: impl TryFrom<&Device> for &pci::Device
  rust: platform: impl TryFrom<&Device> for &platform::Device

 rust/kernel/device.rs   | 19 +++++++++++++++++++
 rust/kernel/pci.rs      | 21 +++++++++++++++++++--
 rust/kernel/platform.rs | 22 ++++++++++++++++++++--
 3 files changed, 58 insertions(+), 4 deletions(-)

-- 
2.48.1


