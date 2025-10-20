Return-Path: <linux-pci+bounces-38813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D500BF3EB2
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 00:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1509B18C0BA7
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 22:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0832E9EC9;
	Mon, 20 Oct 2025 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9AjTje0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C6D21CC47;
	Mon, 20 Oct 2025 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999734; cv=none; b=CZGQflHQFpJrJu0W+6dq2q4NZw6CkQ9vJAlt4cfPMBlxwwFelZAoBiTH2LCO/+T4HamP/Xltu5dAfPfr7ElJasIFArjy6kr00qrlpF/OB+1nU/XrOU8FZHvI/nSzP/PCXO/yBprsQEmjSUfw2yMXcwGu1gBxNp6Y4X7YMwylWyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999734; c=relaxed/simple;
	bh=Jzu6GE+Y5gSfBw0CMzkmAGlk+O6zXt7aAA6tQpARfnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sq+57/cxfigYqkRq6w+8hxvnd+Rg4k+1TnEABBz5ERpNVRcWXVbE7UTdO8+gvgrCfrL4iN1zhkQYClkaQIVJXANQgmYwDrSNT1Jn0n2HsTXeoGtS+E1woUpMrnnirfFrWK7ELVtDVaKZZCvc9gOYuWSw6Zik1rP601c96Zt8Er8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9AjTje0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDEDC4CEFB;
	Mon, 20 Oct 2025 22:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760999733;
	bh=Jzu6GE+Y5gSfBw0CMzkmAGlk+O6zXt7aAA6tQpARfnI=;
	h=From:To:Cc:Subject:Date:From;
	b=d9AjTje0WVrJYmz2K///1/8FIKjBGVBBGqhzq43byE3fEIYCAP7X96VoWCdZZjO3u
	 s1LFhB8kYbhgvHjNC0tm7CmCD2WMyk4cpRNCTMsC4oD/T6rmgHftc6ak5fn6vUOSc/
	 UHQIS7M9ajCa8KnbzQhs+9uCQ2eLzOIENpz5E0RrjrBBqoUvpVt6f3fbdbs9B1mKCF
	 o2hvAqV/g1NjuH0H0pfukJwtmWXdO5/UQZ35R/dHIxV8Glkuc8fjiD5hZMfPOM3jVT
	 9wy1VaZrKPutz32TwVhElFhfOh5LswmlgWp1pgShixSSetuYiA/Ug4+YIHIFLApGnz
	 SQ5wp6PHsP18g==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	acourbot@nvidia.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	pcolberg@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/8] Device::drvdata() and driver/driver interaction (auxiliary)
Date: Tue, 21 Oct 2025 00:34:22 +0200
Message-ID: <20251020223516.241050-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tl;dr:

Implement a safe Device<Bound>::drvdata() accessor (used for driver to
driver interactions) based on the auxiliary bus.

This provides a way to derive a driver's device private data when
serving as a parent in a driver hierarchy, such as a driver utilizing
the auxiliary bus.

Please have a look at patch 8 ("samples: rust: auxiliary: illustrate
driver interaction") to see how it turns out.

--

Full cover letter:

In C dev_get_drvdata() has specific requirements under which it is valid
to access the returned pointer. That is, drivers have to ensure that

  (1) for the duration the returned pointer is accessed the driver is
      bound and remains to be bound to the corresponding device,

  (2) the returned void * is treated according to the driver's private
      data type, i.e. according to what has been passed to
      dev_set_drvdata().

In Rust, (1) can be ensured by simply requiring the Bound device
context, i.e. provide the drvdata() method for Device<Bound> only.

For (2) we would usually make the device type generic over the driver
type, e.g. Device<T: Driver>, where <T as Driver>::Data is the type of
the driver's private data.

However, a device does not have a driver type known at compile time and
may be bound to multiple drivers throughout its lifetime.

Hence, in order to be able to provide a safe accessor for the driver's
device private data, we have to do the type check on runtime.

This is achieved by letting a driver assert the expected type, which is
then compared to a type hash stored in struct device_private when
dev_set_drvdata() is called [2].

Example:

        // `dev` is a `&Device<Bound>`.
        let data = dev.drvdata::<SampleDriver>()?;

There are two aspects to note:

  (1) Technically, the same check could be achieved by comparing the
      struct device_driver pointer of struct device with the struct
      device_driver pointer of the driver struct (e.g. struct
      pci_driver).

      However, this would - in addition the pointer comparison - require
      to tie back the private driver data type to the struct
      device_driver pointer of the driver struct to prove correctness.

      Besides that, accessing the driver struct (stored in the module
      structure) isn't trivial and would result into horrible code and
      API ergonomics.

  (2) Having a direct accessor to the driver's private data is not
      commonly required (at least in Rust): Bus callback methods already
      provide access to the driver's device private data through a &self
      argument, while other driver entry points such as IRQs,
      workqueues, timers, IOCTLs, etc. have their own private data with
      separate ownership and lifetime.

      In other words, a driver's device private data is only relevant
      for driver model contexts (such a file private is only relevant
      for file contexts).

Having that said, the motivation for accessing the driver's device
private data with Device<Bound>::drvdata() are interactions between
drivers. For instance, when an auxiliary driver calls back into its
parent, the parent has to be capable to derive its private data from the
corresponding device (i.e. the parent of the auxiliary device).

Therefore this patch series also contains the corresponding patches for
the auxiliary bus abstraction, i.e. guarantee that the auxiliary
device's parent is guaranteed to be bound when the auxiliary device
itself is guaranteed to be bound, plus the corresponding
Device<Bound>::parent() method.

Finally, illustrate how things turn out by updating the auxiliary sample
driver.

Similarly, the same thing can be done for PCI virtual function drivers
calling back into the corresponding physical function driver or MFD.

The former (PCI PF/VF interaction) will be addressed by a separate patch
series. Both, auxiliary and PCI PF/VF is required by the Nova project.

A branch containing the series can be found in [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=drvdata
[2] Type hash (TypeId) stored in struct device_private:

        The Rust type stored in struct device_private could be replaced
        by a dedicated (and transparent) private pointer (e.g.
        struct device_private::rust).

        While I'm not overly concerned about the extra allocation (not a
        hot path at all), I still wanted to try to store it directly in
        struct device_private, see how it turns out and gather opinions.

        Additionally, I don't expect any additional Rust specific
        private data to be required. But even if, changing things up to
        use a separate transparent allocation in the future is trivial.

Danilo Krummrich (8):
  rust: device: narrow the generic of drvdata_obtain()
  rust: device: introduce Device::drvdata()
  rust: auxiliary: consider auxiliary devices always have a parent
  rust: auxiliary: unregister on parent device unbind
  rust: auxiliary: move parent() to impl Device
  rust: auxiliary: implement parent() for Device<Bound>
  samples: rust: auxiliary: misc cleanup of ParentDriver::connect()
  samples: rust: auxiliary: illustrate driver interaction

 drivers/base/base.h                   |  16 ++++
 drivers/gpu/drm/nova/file.rs          |   2 +-
 drivers/gpu/nova-core/driver.rs       |   8 +-
 rust/bindings/bindings_helper.h       |   6 ++
 rust/kernel/auxiliary.rs              | 108 ++++++++++++++++----------
 rust/kernel/device.rs                 |  83 ++++++++++++++++++--
 rust/kernel/pci.rs                    |   2 +-
 rust/kernel/platform.rs               |   2 +-
 rust/kernel/usb.rs                    |   4 +-
 samples/rust/rust_driver_auxiliary.rs |  44 +++++++----
 10 files changed, 207 insertions(+), 68 deletions(-)


base-commit: b782675fc7b5ba0124e26cab935a5285278c8278
-- 
2.51.0


