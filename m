Return-Path: <linux-pci+bounces-23558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B41EA5E9B3
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 03:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D2B1896BF4
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 02:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1216FC5;
	Thu, 13 Mar 2025 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9UZCPCk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02E82E339B;
	Thu, 13 Mar 2025 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832255; cv=none; b=jNdjX184Zfhri5Bm/14wrx080AjG+oYi1yynOAtvStbGluTZQ3tN5ICbG24wZ0B6oOSQMFIZ+5Dj2yvaZ/KB0XQYwxj0d8iFqRbgeRi09soMYAP/fBHMsft5RMruSI2ftpH7yVtF/3J+i1N37vWmd/kBL/KgE7JEs2+eLeOygr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832255; c=relaxed/simple;
	bh=ZzBkCbP94JNW8bVsYEmxDasU8VlzdS23ZosxuRc1c5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dn3cMLDXhsDDOGeZZnL7Boz137yFw4trSY2zM9EaMNDhfHw+uoYU2Ik2hX3Nh/YHXu1xRll2TKRHDbP9vafV3onovrG0xPM/JtSwlN6pGtYCWu/+mb43tMLSaDP+IhigJAy/Nu9rhcAaWNukWYS/7fboGTmenGJUpoqSO/Ap/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9UZCPCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3026AC4CEDD;
	Thu, 13 Mar 2025 02:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741832253;
	bh=ZzBkCbP94JNW8bVsYEmxDasU8VlzdS23ZosxuRc1c5M=;
	h=From:To:Cc:Subject:Date:From;
	b=N9UZCPCk+O+4GMq8iwAgg/fNj7Vd6HM23gpWuIWpzWlK6bNJ75zercWQx9G7oe4hk
	 HxhJ381d094FdTRSNmQGn+U7xGWXQ7pj8O44W9y7mZKOQ7+IP7srpyY/jTQeJZxJPR
	 csJSP9WymZ9NzXgWR86MxHprTb7doGHOWYEGMeIFniHXRGBhXMGuomniJkSViQOOSp
	 61w1NawFkXCI2NRCFJYUu00DmKXHCG5EJuc1YhuFG+6ZSNkNnCW1rhXCndu2ZTVwe6
	 rpfmiHtYrx5wwbyRlgvb95udktqwF/cjbwRcXYCCoMJKIJFjNZywMzVPS/ZOr4yLNT
	 nnjli068YI9Aw==
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
Subject: [PATCH 0/4] Improve soundness of bus device abstractions
Date: Thu, 13 Mar 2025 03:13:30 +0100
Message-ID: <20250313021550.133041-1-dakr@kernel.org>
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

Danilo Krummrich (4):
  rust: pci: use to_result() in enable_device_mem()
  rust: device: implement device context marker
  rust: pci: fix unrestricted &mut pci::Device
  rust: platform: fix unrestricted &mut platform::Device

 drivers/gpu/nova-core/driver.rs      |   4 +-
 rust/kernel/device.rs                |  18 ++++
 rust/kernel/pci.rs                   | 131 ++++++++++++++++-----------
 rust/kernel/platform.rs              |  93 ++++++++++++-------
 samples/rust/rust_driver_pci.rs      |   8 +-
 samples/rust/rust_driver_platform.rs |  16 +++-
 6 files changed, 177 insertions(+), 93 deletions(-)


base-commit: b28786b190d1ae2df5e6a5181ad78c6f226ea3e1
-- 
2.48.1


