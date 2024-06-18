Return-Path: <linux-pci+bounces-8939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E09B90E004
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 01:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990F11F22792
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 23:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1EB185E50;
	Tue, 18 Jun 2024 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZE0nQmvW"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CC7176ADB
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754049; cv=none; b=iart4PJv7S/4V6GzmHGmzFgEA3DRup3Ab5lfzcTgGkssVtfY+T8NoBEO/73gjsjTAbbm1eDD9wwfCtnvsLOUoSoF8TCdWyEiFJxI6Bk7xOvCf2PCtnfM8pLLWEZlu2NvP0DMx/oBdew9IXoBc408pVsYptgWnH/At+jpoAzrKdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754049; c=relaxed/simple;
	bh=+Xk39ZwrIE1KGhHA9AKUZiS/VoU2xqjKZp1A3FfM24w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOBe/Yqb9v0WSrhVF09qA103McpSlUBgEEHpWmTmtsbSusoVyulkU2650vR5jiMasJRHFf0Bf3J+kqwZ3bsFWd7+gVoSCG3yjIQ0HnkE5cCtwJXaHHCCtgQOFLATw/aiM5UBQr3wI/it4fCNzPTMjnKxguA5MLxWtisfUji+XiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZE0nQmvW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718754045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q6H9H1SHefxyue1HrWMST8kDKDco4keX1wncuBDxteE=;
	b=ZE0nQmvWdG7rO9DO17wEvD5S6OgeNsJ+mOhAqofnaCWz9UJGqZfqTMyhmpAUqNw5ecgFWV
	FIpWaIpJNefkFyfaR5DZben4b3LTWp78p0RSGOvZ5Pu5HLb7Ig0z20/WkxuyYy1fKFyRJb
	UOu1xe+oWOlKzfwrTHgOHI7pZin5nDA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-a5-iAWvyP8ujtcYUBdc70g-1; Tue, 18 Jun 2024 19:40:43 -0400
X-MC-Unique: a5-iAWvyP8ujtcYUBdc70g-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52cb2fc9434so2581332e87.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 16:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754042; x=1719358842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6H9H1SHefxyue1HrWMST8kDKDco4keX1wncuBDxteE=;
        b=JRApJEVW1RMP3i4eAcIBby66OiVi/L52DfN7bHmgkYY3xXksjgMQ+2oB1sJBPNOp7p
         QBpG9xB5lkZwuQ+GOyQ5bdDou49lYXOzVFljCpkrJhVi3UGiIFp7kal79ZBIOv4iIjMp
         8SI8Ce29WfeIaEEotQ59/5cJH0I6bZWZh4HhN4RATjg4T4LtmS5CbNGv7UBgNHZ70VpV
         HwE8dD8mXDok52DDDpC1PRFVPAvqutcrsmIbcLk/GXvQ/WAj0j+hSH8jqE/Pf3+G8DWU
         AOXEo7Hh4lOF/5QR2aS08oHuVk7uSCdZXENQ+oo6q+xXd/hZD3N63iaN9IA9qoA9Fbnr
         KJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCUWoc1JESGdwVI0E721LdP5zJW0gGiRtqtt65E/2hTQ0sMpvew3LiH2YMjSdKN8nZjuEaWyaWtv+2dCXyK0QZNaNonrYVPDrpoF
X-Gm-Message-State: AOJu0YzAXlnqR7GTPjUb2OFnlH4WSdgjjp7MnVgG1z8HblEkVbfqu93Z
	64N9LavwxqgrtVJJ7JuiWV9fipu9/9cMwQqPoizXuA6rMdqcMMKAK+AkuvQB+qPvhJVzbBB9thR
	RYT6mHL6c1ePJXU29RF7n7v/Lab/og3KqO78oFzpHmxk/CrHSHnaY7b0QiA==
X-Received: by 2002:a05:6512:3151:b0:52c:897b:4c5a with SMTP id 2adb3069b0e04-52ccaa6595fmr408375e87.34.1718754042400;
        Tue, 18 Jun 2024 16:40:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmDtDAFR8V+id/nUJyFRf/A1MigXS0y4xOPObqrZY1ZBL1uSWuEi4ubFGyiuxHcNDLrMrT8w==
X-Received: by 2002:a05:6512:3151:b0:52c:897b:4c5a with SMTP id 2adb3069b0e04-52ccaa6595fmr408353e87.34.1718754041929;
        Tue, 18 Jun 2024 16:40:41 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3609aa60a59sm4760760f8f.84.2024.06.18.16.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 16:40:41 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v2 00/10] Device / Driver and PCI Rust abstractions
Date: Wed, 19 Jun 2024 01:39:46 +0200
Message-ID: <20240618234025.15036-1-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements basic device / driver, PCI and devres Rust
abstractions.

This patch series is sent in the context of [1], and the corresponding patch
series [2], which contains some basic DRM Rust abstractions and a stub
implementation of the Nova GPU driver.

Nova is intended to be developed upstream, starting out with just a stub driver
to lift some initial required infrastructure upstream. A more detailed
explanation can be found in [1].

As mentioned above, a driver serving as example on how these abstractions are
used within a (DRM) driver can be found in [2].

Additionally, the device / driver bits can also be found in [3], all
abstractions required for Nova in [4] and Nova in [5].

This patch series is based on [6] (which has been merged in the driver-core tree
already), as well as two more patches:

- "rust: init: introduce Opaque::try_ffi_init" [7]
- "rust: introduce InPlaceModule" [8]

@Wedson, please let me know if you want to send the two separately or if you
want me to pick them up for this series.

Changes in v2:
==============
- statically initialize driver structures (Greg)
- move base device ID abstractions to a separate source file (Greg)
- remove `DeviceRemoval` trait in favor of using a `Devres` callback to
  unregister drivers
- remove `device::Data`, we don't need this abstraction anymore now that we
  `Devres` to revoke resources and registrations
- pass the module name to `Module::init` and `InPlaceModule::init` in a separate
  patch
- rework of `Io` including compile time boundary checks (Miguel, Wedson)
- adjust PCI abstractions accordingly and implement a `module_pci_driver!` macro
- rework `pci::Bar` to support a const SIZE
- increase the total amount of Documentation, rephrase some safety comments and
  commit messages for less ambiguity
- fix compilation issues with some documentation examples

[1] https://lore.kernel.org/dri-devel/Zfsj0_tb-0-tNrJy@cassiopeiae/T/#u
[2] https://lore.kernel.org/dri-devel/20240618233324.14217-1-dakr@redhat.com/
[3] https://github.com/Rust-for-Linux/linux/tree/staging/rust-device
[4] https://github.com/Rust-for-Linux/linux/tree/staging/dev
[5] https://gitlab.freedesktop.org/drm/nova/-/tree/nova-next
[6] https://lore.kernel.org/rust-for-linux/20240618154841.6716-1-dakr@redhat.com/
[7] https://github.com/Rust-for-Linux/linux/commit/9c49161db95f4eb4e55e62873b835fb6c1a0bb39
[8] https://github.com/Rust-for-Linux/linux/commit/e74d5d33dd2b9361e8cebae77227e3f924b50034

Danilo Krummrich (6):
  rust: pass module name to `Module::init`
  rust: implement generic driver registration
  rust: add `io::Io` base type
  rust: add devres abstraction
  rust: pci: add basic PCI device / driver abstractions
  rust: pci: implement I/O mappable `pci::Bar`

Wedson Almeida Filho (4):
  rust: implement `IdArray`, `IdTable` and `RawDeviceId`
  rust: add rcu abstraction
  rust: add `Revocable` type
  rust: add `dev_*` print macros.

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  | 145 ++++++++++
 rust/kernel/device.rs           | 319 +++++++++++++++++++++-
 rust/kernel/device_id.rs        | 336 +++++++++++++++++++++++
 rust/kernel/devres.rs           | 168 ++++++++++++
 rust/kernel/driver.rs           | 128 +++++++++
 rust/kernel/io.rs               | 219 +++++++++++++++
 rust/kernel/lib.rs              |  22 +-
 rust/kernel/net/phy.rs          |   2 +-
 rust/kernel/pci.rs              | 467 ++++++++++++++++++++++++++++++++
 rust/kernel/prelude.rs          |   2 +
 rust/kernel/revocable.rs        | 209 ++++++++++++++
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/rcu.rs         |  52 ++++
 rust/macros/module.rs           |   3 +-
 samples/rust/rust_minimal.rs    |   2 +-
 samples/rust/rust_print.rs      |   2 +-
 17 files changed, 2069 insertions(+), 9 deletions(-)
 create mode 100644 rust/kernel/device_id.rs
 create mode 100644 rust/kernel/devres.rs
 create mode 100644 rust/kernel/driver.rs
 create mode 100644 rust/kernel/io.rs
 create mode 100644 rust/kernel/pci.rs
 create mode 100644 rust/kernel/revocable.rs
 create mode 100644 rust/kernel/sync/rcu.rs


base-commit: e74d5d33dd2b9361e8cebae77227e3f924b50034
-- 
2.45.1


