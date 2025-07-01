Return-Path: <linux-pci+bounces-31176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC8AEFBCC
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 16:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1004A7629
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 14:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA4527602D;
	Tue,  1 Jul 2025 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBljitUU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA48C13C3F2;
	Tue,  1 Jul 2025 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379265; cv=none; b=aj/tjaVf4DRXWO6ajl90L+MN6gv7UWaUWN7J2gWG2/7z7STk/PA01umqiB3WheVlsDdFS6cZjRU8qTVDc1eyEtbM4SJI9gLv+kBDB731j2O1moSKmzRFuiXHMVWPjwl3jLAbTAu4ygZMjP9erwEVauYsDhuVuMZo9Qynj7p54Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379265; c=relaxed/simple;
	bh=8ETo8H9n7F/2G/4Ja2z58kxRn+BOSZ78QHcn7HYjt/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aio0nGO3IDuMpogn258l1KrkmgBg0W1viBBsCXFTDZ7NLSUGhA871YRCYrav4Csfr5TlPMzZQJSA1/Lnr7NPjzaxXdPH+KLrcS5TT4UWljH3z5fPUFE9RWu6zfF3BBRxIV2Wal8zxuL5Ilh4VutQRRNmxYJ7LmBJHEeaeR9ibsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBljitUU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2349f096605so37727835ad.3;
        Tue, 01 Jul 2025 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751379263; x=1751984063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGOa1cF1iUH0+69hZgkZqAynW/NiPDvEYRmh1fAZi7Q=;
        b=bBljitUUNW9QxfrqIbp0/K2vrVyjm7hfegAdSK9c95RKC07e9zLBoWef5ZR6U0FSJO
         AJUY6L5bPxPmMmR61/6PZMjaNttOPs/9iY1qJV+e25Aryl4bz/bR/lMe4mJenF8DbHaQ
         fmAR8OlK0aqosQXFepkDViY9z9kQE5PpcxTkwkRhinnCzQ8tLnb9Pzqj++1olKlfqZ6p
         v1r+0CJcs2bsAPlie/Dn3P0MsxvFi25StK5HTzfpn4sZ5BYtQRDquxLjKWMMCHd/Rdzj
         gtg11o7ulIQ9FtBuyB8+qogWnBlIyDUHmNzTTn8sfrEuy2cooDvqIA/on3EKWTOGw/DJ
         HMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751379263; x=1751984063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGOa1cF1iUH0+69hZgkZqAynW/NiPDvEYRmh1fAZi7Q=;
        b=wkNDtWn281Nz9OC0R4ACekyYszz+WnGbnQPNGgQXyZNjBMS7gvTfUpTIqMUnEfK1f8
         9DE7SybkGIKm3mV0OEEnVGyRHjz22W3arMV7sPw/coSHS5WNSbIPek/kTYMCxvxVptSP
         l09MiBJ/5J6Hhk9AZ/fx8lfxt2bsjVYxSpi88cl7t10ZmL+PufbODUyJ1XCPZLseUjKg
         BRywkq64i+DmEWijt9JehH5tk6mY9j7GHi3jyw4TISxfDORVPftQOt/siz+jYei/LMMt
         xnAEW9DBEZvlEvfZsavgjJywPLHdGBLo9U/WXicHuGQJtpRoWud06deBcCZQpfLqm3Nd
         CV4w==
X-Forwarded-Encrypted: i=1; AJvYcCUakNZowJRVlcO9UBhQAz824LkVWPWI+taBTe/CAh8/RB7vLf1tdCRh2fjeckTRY4UDjwJd6t8XSvuzoYh4Op8=@vger.kernel.org, AJvYcCV3YGcG2K2X6YAawWprr1rsS+dObrh4HZoyKF0H8adP6u6l5Y1+l2R2gsTfWC9T4SW0SUX9jQy2njL5@vger.kernel.org, AJvYcCVKItcc5uqSqVuvLh2HshrDTEdfQUBBbYF0olgQuD/86UmrF/X/2tLITcrRN94S+OIL63J5cuVc@vger.kernel.org, AJvYcCX3H022YrHGxBmev1O/FyXVqht4TOOQrrcOTCBdqqPsQeb3tCzCKZAv7lM7QSBmYPGpiK3NwP44iyGr@vger.kernel.org, AJvYcCXayJOiZVE/ty65gk7g0pxf3V6yjLue20zo4Ls6IGQLPXU3G/H2sW//bDrmDKOzwz5sZS/y4Rek8d4NVoHS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy49vakbKpNQI8HroSKSp4ZKG5KjeR+ierLZJLzIc4jf+SqGgLZ
	cZrKvku3sKyeZmnOz5fliJ1lL/W+KcT1FaLCLYRFw83/oYs9Y/MEMZuZ
X-Gm-Gg: ASbGncti3wNzPa6ZIJWcShJUnpPRS/TcmowU5fz5JAosZ4MYVeu1GksyslK7cPu1zyR
	CkwnottBltBRYStrzcGB9vYo6ai0PKcmRQJihJlPeTuui2HiqrqMAgHJDiVwgDEWjBMA/dGm2PZ
	pWO/3Yij7c7msdMQdyrBvwweakKt5LiZpDuXenhiBb5qt6N349TTFyk39ddPYqF6oYzyzCwuEL+
	m1uAprj9kZMhfoA6tuqvk4rutNBjCVN8cFZoi18XTgCQlv9GWMtym78uQNPQC0FHB6VcvRpndcZ
	zjrQUkysLrHRw7zPSQsqf9crMKFgh7uU6bF9fl0uYw7urEkpNwZap0+7dEdw7XVdnXszyg7emDr
	DJuT1a5UWaHpky7QhY/1rmiw8gjSFrZfDd8Y=
X-Google-Smtp-Source: AGHT+IGXEWlJgT1GJH4Lu3G7lkA9vOpM3RPD4pkXk4Jh5ip6sI+bOgT/C1FpaAIQB/cVKubhZC0uDw==
X-Received: by 2002:a17:902:d4c5:b0:234:e655:a632 with SMTP id d9443c01a7336-23ac4883265mr257175855ad.51.1751379262756;
        Tue, 01 Jul 2025 07:14:22 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b8324sm107240885ad.178.2025.07.01.07.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:14:22 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: alex.gaynor@gmail.com,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	rafael@kernel.org,
	robh@kernel.org,
	saravanak@google.com
Cc: a.hindborg@kernel.org,
	aliceryhl@google.com,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	david.m.ertman@intel.com,
	devicetree@vger.kernel.org,
	gary@garyguo.net,
	ira.weiny@intel.com,
	kwilczynski@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lossin@kernel.org,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: [PATCH v2 0/3] rust: Build PHY device tables by using module_device_table macro
Date: Tue,  1 Jul 2025 23:12:49 +0900
Message-ID: <20250701141252.600113-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Build PHY device tables by using module_device_table macro.

The PHY abstractions have been generating their own device tables
manually instead of using the module_device_table macro provided by
the device_id crate. However, the format of device tables occasionally
changes [1] [2], requiring updates to both the device_id crate and the custom
format used by the PHY abstractions, which is cumbersome to maintain.

[1]: https://lore.kernel.org/lkml/20241119235705.1576946-14-masahiroy@kernel.org/
[2]: https://lore.kernel.org/lkml/6e2f70b07a710e761eb68d089d96cee7b27bb2d5.1750511018.git.legion@kernel.org/

v2:
- Split off index-related parts of RawDeviceId into RawDeviceIdIndex
v1: https://lore.kernel.org/lkml/20250623060951.118564-1-fujita.tomonori@gmail.com/

FUJITA Tomonori (3):
  rust: device_id: split out index support into a separate trait
  rust: net::phy represent DeviceId as transparent wrapper over
    mdio_device_id
  rust: net::phy Change module_phy_driver macro to use
    module_device_table macro

 rust/kernel/auxiliary.rs |   7 ++-
 rust/kernel/device_id.rs |  80 +++++++++++++++++++++++-------
 rust/kernel/net/phy.rs   | 104 +++++++++++++++++++--------------------
 rust/kernel/of.rs        |  11 ++++-
 rust/kernel/pci.rs       |   7 ++-
 5 files changed, 132 insertions(+), 77 deletions(-)


base-commit: 769e324b66b0d92d04f315d0c45a0f72737c7494
-- 
2.43.0


