Return-Path: <linux-pci+bounces-23761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B03BCA615F4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 17:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CB91892D24
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 16:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486E42040B4;
	Fri, 14 Mar 2025 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXc92o57"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF81202C55;
	Fri, 14 Mar 2025 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968579; cv=none; b=JXaX0P2UIHU1qUz6lVta6Z5IcPkZlUVzpfcvK318Fg33Z7OvI7tqATuIY3b36LRV31g5ObMokEb2/89M1AR1n9yGgeaUC0N8D2YtpIODQ2ub1xneBdzYofwksX9i2NqBdf+9ixPlrQtO1/4ydm4nn2gjJf7G1yfqHqUCMtELoBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968579; c=relaxed/simple;
	bh=EgFxuTDtw0Mv9w7MUEKo7ptgiuHiVtQ03WWVYzjjGeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cxqGvjcsR6d8W0EodrIpsNsWPTB8e/o2Vpn++a1xBQl28WEg+n/hambVi8T7tGJqGXRgPNftvwzw1sPtgzlPbN/Rq7ijLAjR5uCHBYuKsfGW5LjMYaJuycj4z8VDSKIpmHOv1/3h6fkKqZSz+vE5XONfa47ulRWThxL/m6LYjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXc92o57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74701C4CEEC;
	Fri, 14 Mar 2025 16:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741968578;
	bh=EgFxuTDtw0Mv9w7MUEKo7ptgiuHiVtQ03WWVYzjjGeI=;
	h=From:To:Cc:Subject:Date:From;
	b=lXc92o57IOowA5KO/9KakVaoZ7j3HrnQUjmusXTcyy1LoFOosjqe9nX86ej4KkOFg
	 35ch4bVcKac/D9i06lM2Am/hmjITOIbI91qEZu0xv3hVSoBjczkmcFWxOAnFyo9Hsh
	 MRyeWN8lCMYtc+X5DOdbWoqRyn1GvMxjBffQdJdJWq2HdGU4r7lzanyfawWQuPRv/k
	 hKEjFJv0MSpiCmy3F4JZY50Uok5W0ldAdDpNGX3M6Vh1loxe/6LUJTXUIV0/EbQYFH
	 NiSWirGeNEHUOnQKC5EPW4Wrx3ihI9rTXj/YSzztYIyXI72DMmWNIrK8ldSiDbmt1I
	 0LMNeV1Ry6Pgg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 0/4] Improve soundness of bus device abstractions
Date: Fri, 14 Mar 2025 17:09:03 +0100
Message-ID: <20250314160932.100165-1-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when sharing references of bus devices (e.g. ARef<pci::Device>), we
do not have a way to restrict which functions of a bus device can be called.

Consequently, it is possible to call all bus device functions concurrently from
any context. This includes functions, which access fields of the (bus) device,
which are not protected against concurrent access.

This is improved by applying an execution context to the bus device in form of a
generic type.

For instance, the PCI device reference that is passed to probe() has the type
pci::Device<Core>, which implements all functions that are only allowed to be
called from bus callbacks.

The implementation for the default context (pci::Device) contains all functions
that are safe to call from any context concurrently.

The context types can be extended as required, e.g. to limit availability  of
certain (bus) device functions to probe().

A branch containing the patches can be found in [1].

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/device

Changes in v2:
  - make `DeviceContext` trait sealed
  - impl From<&pci::Device<device::Core>> for ARef<pci::Device>
  - impl From<&platform::Device<device::Core>> for ARef<platform::Device>
  - rebase onto v6.14-rc6
  - apply RBs

Danilo Krummrich (4):
  rust: pci: use to_result() in enable_device_mem()
  rust: device: implement device context marker
  rust: pci: fix unrestricted &mut pci::Device
  rust: platform: fix unrestricted &mut platform::Device

 rust/kernel/device.rs                |  26 +++++
 rust/kernel/pci.rs                   | 137 +++++++++++++++++----------
 rust/kernel/platform.rs              |  95 +++++++++++++------
 samples/rust/rust_driver_pci.rs      |   8 +-
 samples/rust/rust_driver_platform.rs |  11 ++-
 5 files changed, 187 insertions(+), 90 deletions(-)


base-commit: 80e54e84911a923c40d7bee33a34c1b4be148d7a
-- 
2.48.1


