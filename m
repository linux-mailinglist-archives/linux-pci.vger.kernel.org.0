Return-Path: <linux-pci+bounces-30339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A82AE3553
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 08:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE07B3A93FD
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 06:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87C01DE88A;
	Mon, 23 Jun 2025 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7UuYKrw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326887261A;
	Mon, 23 Jun 2025 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750659026; cv=none; b=rmlvmicLO7vdqHrSKBi6nHmTHs+apStfEZIdHTF6hCE0at6b2K1MNjwbATUVlhS0oHoqqA+lu6Q9lFkQ7fh2jxTXCQsrFoI3Es1x/XQ/h/ybo2p1YEz4hJxbILTTTNOESfKQmp4Ohi5Wp1BoF5dV5JMLaZX8SOXyJSnTF4dJX5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750659026; c=relaxed/simple;
	bh=1FbdaPTGY2nkkiH3v1/OvarCc7OhJSufmV4jDwa0tto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KRFkSaHe8M2SulOr1fB5vTSxG2ljWt9zTlEbQNX9hog6HRVr5xBlVrU9xHczd3zHVXn+DGeP73uIPwO//JzINkJbuypaFVFv6d2soKYbul40VsS9kDGlt7O+MDR4zys8RrSrXNrlOGPZI9r67yw4N87SZqFFHEyU4hsA2E6OkQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7UuYKrw; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so4042897a12.0;
        Sun, 22 Jun 2025 23:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750659024; x=1751263824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hs1dCl7RewtWSXUKYyaWjku6DL8XfWJfCrsSKStuxO0=;
        b=C7UuYKrwf3V9eccaDXCRKFtKzMyBolSJmk70Lc/7qU61H4sNJVxFiDph+MXziXLBjZ
         CEjNnnrbUPoyX6V8lW/n9tpkgUNgSxhRwTVhhvytlZkObIyIgwzPUs5ao1MH4AkI2Ans
         tLkAI1gJLTdXdXFaFHd5mJrJ8Ir4cRmwg/HuiKFyvz8z3FkeF6KbyGO2QPsWbV3nQqld
         Fh1b11evL2XjV4IvmdFG0tBsPctJFy705New8evXBAgqSE3dwYGEdIfu5hh4O2EF+S0p
         ehQkR09FP4+vYONRkTdA3JGJgKewMHU2A8XOxLiPsFgcHX1duiXMavuzjTdZhOH5CcME
         NUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750659024; x=1751263824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hs1dCl7RewtWSXUKYyaWjku6DL8XfWJfCrsSKStuxO0=;
        b=dZXwm+nJJNadV/pJDIks9Cfp4mEPu8uUXDvlQdUra9iIJ6mMVjAXxwYY4S1PdoTPvO
         wqAI39nyl4k9jnlapbWTuehvAeS7BH4npd1zcd0BlfBsPLrLJ8pp23SYBJzwwg+F3bCE
         GCcfJnlm4F+V68DopIa4JAGgtxNMTzDb+yXU0HPqrAzCfkJraRpybzUGr6x1QFa+d+uN
         EylKOSeqK4kJOh3grS6aD2pL/lrmT8/8uAFXCTMHeQEKA0EJ0X498I11bar4YSyBMs/z
         NdBtbH0FHQBCDo5R+YIeP3bd+E7D2iX6CQjPa0Vii4VL1FAEyZrj3Jxcxv2KLuCHuWBo
         fC9A==
X-Forwarded-Encrypted: i=1; AJvYcCVdx4+oEW0PkW6QGPupIvbzJ6XE3bXYWHEYJQwz+CKevpQszEZKVRrT8gdH4Uj4IM9Vy93QdsLHu1wr@vger.kernel.org, AJvYcCWZWE+bxmsyo+jY+KyICIOyQ/aBp/xWhfSSUJS9lqFUskl39bKYzHNkwjJaQ+qNjVP5Ga9/5CZt6KDv@vger.kernel.org, AJvYcCXRxhCkM2WXISj6HYbEluKMPQilpVa1iycxurKwVXEeL/ETMnSKvo6+3I0mdhAuE8jfn8Go2oT1@vger.kernel.org, AJvYcCXyN0J5mRNr3H8idVqOy9bIemazJMJTVCTfPTxgBMWbo9icPBkgBiGggS/D1tzBPTo9m/z74cmrE93gBVBm@vger.kernel.org, AJvYcCXzKiagQ+OIGlNqgBWCDHHY1OrH1/+36FAnS8tALF1gYCA2QP7k9lJffLwuy3/tDOHRMivGJi7DNCDw9voJfrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCUVwphWc/0dMtozfJZiBiBCW6ZzQf5IVvYgzxcEjhjDKExGD
	pkHxBYwcPbBhQ4Ma0sOwltWg4j8bSvfKidqwbwjpV8kcJ3uB3fE5tfNT
X-Gm-Gg: ASbGncslH2jWy1GrcCm6Wdh4d83f6kSSEGBUFVOC/AnHlFoMIygNRyQtLzvWcGzFpRc
	hKze0uY9j29/u7XdhyqektbFWkl3GjlR63AioJHPop4jafA1IPHbNp5ksSWRMBhfQntGy6Wr+sd
	GSgR8QQKh+bAPdy772zMoep9dfOnmZOI9m/ALTCT/8YILiI/DCuuLEQmvNvgFdvgXyKYRwmyX2L
	rsG3wT60v9p0vXUJFEqscUjMimFf5McScih53smd6WgJKTdLECo1lc2IA/QtDI+gIVJp208rpbU
	hhsK8H0fI5obgTezk3x5A4dlrLtMTe/H5aXIjEC3mcbbBJzGcyvNBLwl2XD07OapIp2sHwjQKHs
	C4bKoZZYNw7C1xUKl/IpD6jDN8fkZXRFRrIM=
X-Google-Smtp-Source: AGHT+IFNJrfDeIuQLlvRrICS1UM8+U3hOcQLJwskTndAABsHQL9FRPQ681RsyaiszcYD/dgaUfc7Vw==
X-Received: by 2002:a05:6a21:9208:b0:1ee:d418:f764 with SMTP id adf61e73a8af0-22026f8d9bbmr16566516637.38.1750659024308;
        Sun, 22 Jun 2025 23:10:24 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a623e8csm7391703b3a.83.2025.06.22.23.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 23:10:23 -0700 (PDT)
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
Subject: [PATCH v1 0/3] rust: Build PHY device tables by using module_device_table macro
Date: Mon, 23 Jun 2025 15:09:48 +0900
Message-ID: <20250623060951.118564-1-fujita.tomonori@gmail.com>
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

FUJITA Tomonori (3):
  rust: device_id: make DRIVER_DATA_OFFSET optional
  rust: net::phy represent DeviceId as transparent wrapper over
    mdio_device_id
  rust: net::phy Change module_phy_driver macro to use
    module_device_table macro

 rust/kernel/auxiliary.rs |   6 ++-
 rust/kernel/device_id.rs |  26 ++++++----
 rust/kernel/net/phy.rs   | 109 ++++++++++++++++++++-------------------
 rust/kernel/of.rs        |   3 +-
 rust/kernel/pci.rs       |   3 +-
 5 files changed, 79 insertions(+), 68 deletions(-)


base-commit: dc35ddcf97e99b18559d0855071030e664aae44d
-- 
2.43.0


