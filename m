Return-Path: <linux-pci+bounces-30300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0583CAE2BD6
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 21:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553653BA764
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 19:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9623C224893;
	Sat, 21 Jun 2025 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nk7HRXwF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E751B414E;
	Sat, 21 Jun 2025 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535488; cv=none; b=eeq20SO2nac9f2jUDKA08PK7SimsolfHumfoAth2pcdbnH9zCLLGkk1CJde3f+DbuE7BYBjOffXi+ogXrZ49+5a1owR9ZJFLMxwSVSAjTrATJA4wULSn63oCYb8P281kTKixmgtyPB9PRVoLABjBBnEiY0c/5tswOkl4eBDU1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535488; c=relaxed/simple;
	bh=dNb7xAF9Q/a6CUsX7C6s6yY6BMrON4Y9eNUkNm0UIcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E5tWaZDSrVaE+TOFP//sx1iFzqpD9fvhQjStLq4PZVOG4VLZfaxZLYgLOGwgZYdu7fBJ6EWTgujkwhxVPEfBYulrnRrZIc25faLGKnVqiyr+2bjYKJffBIgtw3F3+uZTyZPVp+9znEvs6u1BAUKRQF4KEg58Ys3hCXa0uMuqIyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nk7HRXwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFD3C4CEE7;
	Sat, 21 Jun 2025 19:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750535487;
	bh=dNb7xAF9Q/a6CUsX7C6s6yY6BMrON4Y9eNUkNm0UIcI=;
	h=From:To:Cc:Subject:Date:From;
	b=nk7HRXwFGqn+hYTXTTyqKYXjD97C91odMQqoXIhITnK+pveD0pJ1qO8+P19cas6fO
	 tiy5qCqJc+tOVf6sKVEyC7fzrbeE397nWVmzQElGT7MGucdw1V+gs3ubpZx6u61A6G
	 IeesnsZ0/OxfEkwqgRReAvFa5om2iMA+Vej6dtYpYuo+YxIuUYX2h/rAn2aQUni6mv
	 lEnrA9HrKtZZh6Vgy6fYUM0PGpKyxpdcx81vsS/c/6+OGwLHMxZ5JNz/Fq7Oyl66DU
	 nTTGTZVGi04i8AlgIAL1Nqfpu6ydSwvuhRvLZaQEb1nSk1M4Bhr1blzUPNOrG8x0u5
	 E4VPL9/LnEWaw==
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
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/8] Device: generic accessors for drvdata + Driver::unbind()
Date: Sat, 21 Jun 2025 21:43:26 +0200
Message-ID: <20250621195118.124245-1-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series consists of the following three parts.

  1. Introduce the 'Internal' device context (semantically identical to the
     'Core' device context), but only accessible for bus abstractions.

  2. Introduce generic accessors for a device's driver_data  pointer. Those are
     implemented for the 'Internal' device context only, in order to only enable
     bus abstractions to mess with the driver_data pointer of struct device.

  3. Implement the Driver::unbind() callback (details below).

Driver::unbind()
----------------

Currently, there's really only one core callback for drivers, which is
probe().

Now, this isn't entirely true, since there is also the drop() callback of
the driver type (serving as the driver's private data), which is returned
by probe() and is dropped in remove().

On the C side remove() mainly serves two purposes:

  (1) Tear down the device that is operated by the driver, e.g. call bus
      specific functions, write I/O memory to reset the device, etc.

  (2) Release the resources that have been allocated by a driver for a
      specific device.

The drop() callback mentioned above is intended to cover (2) as the Rust
idiomatic way.

However, it is partially insufficient and inefficient to cover (1)
properly, since drop() can't be called with additional arguments, such as
the reference to the corresponding device that has the correct device
context, i.e. the Core device context.

This makes it inefficient (but not impossible) to access device
resources, e.g. to write device registers, and impossible to call device
methods, which are only accessible under the Core device context.

In order to solve this, add an additional callback for (1), which we
call unbind().

The reason for calling it unbind() is that, unlike remove(), it is *only*
meant to be used to perform teardown operations on the device (1), but
*not* to release resources (2).

Danilo Krummrich (8):
  rust: device: introduce device::Internal
  rust: device: add drvdata accessors
  rust: platform: use generic device drvdata accessors
  rust: pci: use generic device drvdata accessors
  rust: auxiliary: use generic device drvdata accessors
  rust: platform: implement Driver::unbind()
  rust: pci: implement Driver::unbind()
  samples: rust: pci: reset pci-testdev in unbind()

 rust/helpers/auxiliary.c        | 10 ------
 rust/helpers/device.c           | 10 ++++++
 rust/helpers/pci.c              | 10 ------
 rust/helpers/platform.c         | 10 ------
 rust/kernel/auxiliary.rs        | 35 +++++++++-----------
 rust/kernel/device.rs           | 57 ++++++++++++++++++++++++++++++++-
 rust/kernel/pci.rs              | 47 +++++++++++++++++----------
 rust/kernel/platform.rs         | 52 +++++++++++++++++++-----------
 samples/rust/rust_driver_pci.rs | 11 ++++++-
 9 files changed, 154 insertions(+), 88 deletions(-)


base-commit: b29929b819f35503024c6a7e6ad442f6e36c68a0
-- 
2.49.0


