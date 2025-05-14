Return-Path: <linux-pci+bounces-27703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD26AB694A
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 12:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5AE319E38AB
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B255D272E4F;
	Wed, 14 May 2025 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT30+mGw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C3F270ECD;
	Wed, 14 May 2025 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747220309; cv=none; b=mNiNCYu7BLScDMJK1cK4RwmD+RTGPN6RhTxzS32itKjw/qo7jncSdl2SdlZnu6O/sxWGoyAj+AojUbIcukjqiXQSjxuYqfmqgpQi+b8gMwecWK+FyRsHVFfUFbD17aHDl/O+/6O0lskBz5FqXcGK7s6zv7kdhbqNlfEi6R0OuJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747220309; c=relaxed/simple;
	bh=RUNW4w9FVJL1+Usey6e+ojTSS/JUX+Bi29r9OQXiPAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6rohjKt+ucOq0+j8gxrJ/ggvu+Z3KCQM/KE7bbgeOG9kqs2rWrMdXskNHfPyhRGQTFIXQQOfHG/OgUE8e+ry+3cNk/NyLHDdxnAQQFOCjEOG3uwrtilkcNPAiavwkFBSMxRo5XFTujBU7m+UeYNd4wZnHVPmmEjMjqmlmZf1sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PT30+mGw; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-607dceb1afdso4141933eaf.3;
        Wed, 14 May 2025 03:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747220307; x=1747825107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C73+/+k71y7rpMEG4ZBk7iq66KMxdwH82HY220kVGsw=;
        b=PT30+mGwktzgBF5mvWvGjWZ5lj3u5RTArHDtS5Bmxfu/L56wtUKA4OJVZaZkM1g+Fj
         72umSYXMoFyKkEo3COGuRU35eJcy/GyjZ3ITKw1T+bskJUT64AFXyM/m9d0Mjn6CMlp9
         tinr2jLBpFm2Dpt/MeQ+prz2o5aWDEH/PbHkQNFvMXCBr38CPgTzFGe1iuEePQGOzbY4
         IrEgTDbRlpy0Egypfjrplk++2HVk+IVCpMlw3T6EI5b82/vcBBjpdH24+HATIzP5Yeih
         vCdSkIweq66VOcJI+zSylHilCNilpapltoYYqBuywmBsa7eOI6WUJqFee7HbyNI0D+My
         D2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747220307; x=1747825107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C73+/+k71y7rpMEG4ZBk7iq66KMxdwH82HY220kVGsw=;
        b=G76htMUwEfvR0+oFe2ANaRDMNS7JpMxKO4edJOmqThKJJ+BhCUB9pC5grY9k7m8E7f
         M3gVMn1Mk0U/9a6O52nONayIvIPcCqNUjnsX1whKK8JL1OeeNJdeSDx4c+JaF3Zh2E8h
         o0MIaoMGCtrlRnyOJYzV1LjBmSv+46/CH1PbvY4JFsIPuH+NqHtGFQNKVmzXZVRO+ht0
         11cguv3BuwdyL+3N9VkGfmXeaHayMdN+wlvZ78lLNuNE8tMbGK7bQim6tADKENcJ+DxH
         Yoed/MU35ZxuRJRlyEWIsla8l2HkAY50CpkmYgYJGBRTD7Wn4iFZyNMmd/jXESUvfFZS
         03aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa311HRZbV1xvAPdGkPYUYoWITZ69PEyH9NynGWaIaGRZX2wpS22GHwbXo51XCo0R3rZ2qPMN2Hn+3kz6QZuo=@vger.kernel.org, AJvYcCWmJ0zbvlcHhsUjfgqfC+Fn2omdMz5bWz98JMgev3ZizSB3QNQJ0GUjijWHgD6+8EARxC5bM6nXru7kg4c=@vger.kernel.org, AJvYcCXZ7FMpduNChcqGo+AKgVOvGDxLjerVFEx9nRlRJdasqnBjpIJ/TV+38tkRmshEG0ShSlyAPfohZd8+@vger.kernel.org
X-Gm-Message-State: AOJu0YwnlLciHdXS6af1hnSJITsyByOdd3HC+8dR9eET9e5or7pdrmFl
	4EkMxBCPUGcBNdM52UzouzscIQsrlVVZULUYwzYrRMtySrxZyiTv
X-Gm-Gg: ASbGncuOYKpTlghQ3kzucB8TORuqx8ypF9LmNyP5QfgO8YklkcIvdVuUmAu3vH+DlRe
	eqMrlyvngdhYHyKyo2/j8BSNgnPWrUHcSMWc4VNundL9WG+F9CEecL/YYf6KIVzUJpp4IbLpvlR
	6RGiBAf/FGwSq+ERFVViEldK8As7/K3sXXxI1EAoYLKccq1VDX4dQRmPhEADXNsEzEDvXnMgO47
	SrGIYB+0O4W7oEe99/yhkrZPZf7OCarphypc7KQ8wiZmmtEh0FTY+JM91PYF6Y6UHgcm3O/c3bU
	ZFFS1XANpvo6sgAKSQZ7WqygfVm5JJAYLn0fHkLebTkHrmChi0a2+CMwf06nJwv/mU+m1xVhMxS
	zgFwJvi2ALaVmI3ic05ZTC3c=
X-Google-Smtp-Source: AGHT+IH5rbBVbJfVaX8PQXrPTnS8jh4TFSktnCqyB8PVszPAz+uSMgqHz+BpZJQHRVKPA8CKVmLw9w==
X-Received: by 2002:a05:6870:4150:b0:2da:843d:e530 with SMTP id 586e51a60fabf-2e32b051a3amr1631804fac.2.1747220306876;
        Wed, 14 May 2025 03:58:26 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2dba060be9esm2654535fac.10.2025.05.14.03.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 03:58:26 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: dakr@kernel.org,
	a.hindborg@kernel.org,
	airlied@gmail.com,
	akpm@linux-foundation.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	andrewjballance@gmail.com,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	daniel.almeida@collabora.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	kwilczynski@kernel.org,
	me@kloenk.dev,
	ojeda@kernel.org,
	raag.jadav@intel.com,
	rafael@kernel.org,
	simona@ffwll.ch,
	tmgross@umich.edu
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v2 0/6] rust: add support for port io
Date: Wed, 14 May 2025 05:57:28 -0500
Message-ID: <20250514105734.3898411-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

currently the rust `Io` type maps to the c read{b, w, l, q}/write{b, w, l, q}
functions and have no support for port io. this can be a problem for pci::Bar
because the pointer returned by pci_iomap can be either PIO or MMIO [0].

this patch series splits the `Io` type into `Io`, and `MMIo`. `Io` can be
used to access PIO or MMIO. `MMIo` can only access memory mapped IO but
might, depending on the arch, be faster than `Io`. and updates pci::Bar,
so that it is generic over Io and, a user can optionally give a compile
time hint about the type of io. 

Link: https://docs.kernel.org/6.11/driver-api/pci/pci.html#c.pci_iomap [0]

changes in v2:
  - remove `PortIo`
  - typo fixes
  - squash "fixup" patches so that patches will not introduce build fails
  - move some changes across patches so that build will not fail
  - changes macro define in rust/helpers/io.c to use full rust name
  - specialize `io_backend` for the x86 case
  - do not modify lib/iomap.c
  - rebased on v6.15-rc6

Link to v1: https://lore.kernel.org/rust-for-linux/20250509031524.2604087-1-andrewjballance@gmail.com/  

Andrew Ballance (3):
  rust: io: add new Io type
  rust: io: add from_raw_cookie functions
  rust: pci: make Bar generic over Io

Fiona Behrens (3):
  rust: helpers: io: use macro to generate io accessor functions
  rust: io: make Io use IoAccess trait
  rust: io: implement Debug for IoRaw and add some doctests

 drivers/gpu/nova-core/driver.rs |   4 +-
 drivers/gpu/nova-core/regs.rs   |   1 +
 rust/helpers/io.c               | 112 ++----
 rust/kernel/devres.rs           |   4 +-
 rust/kernel/io.rs               | 645 +++++++++++++++++++++++---------
 rust/kernel/pci.rs              | 101 +++--
 samples/rust/rust_driver_pci.rs |   6 +-
 7 files changed, 595 insertions(+), 278 deletions(-)


base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
-- 
2.49.0


