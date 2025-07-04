Return-Path: <linux-pci+bounces-31495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633B3AF8638
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 06:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0F27AD7A2
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 04:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576CD1519BC;
	Fri,  4 Jul 2025 04:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTG3fRYU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA40127735;
	Fri,  4 Jul 2025 04:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751602241; cv=none; b=YQUN+gXjgvJialBo/Fxe/WgZjzNBw6lrdVqMuO0ymnKcOQzxHiBC8ifKVlbdwHmOzvN7ibiGmkBbgqd6g9XX94xCFBhgJ1LiueV2umFhsi/ItP4R+GYZuAql1mzby+GDie+Ihuwqve2VrxspfcEGA42IDp5FZ+U1dwF1yvxSPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751602241; c=relaxed/simple;
	bh=UYnOJXNb5tVXYjvHRR3It8xW8zrJ9HPaV5rZRzi307A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKcCED/gOdEnnBwCX6cPszZ/Bpqd9U/A/nM93UugL8lb7GB1pEnpXc1nsNHN+cRmEjdBixAaU6G+UWRlildnibkJHTKmFKN9vCPB1Vj7mHcql9IHq+pGYZkKGfEgHsiAnr008xfLJCnyOChKiR7LxkG45msjDy71HSalwx0wxHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTG3fRYU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74931666cbcso537071b3a.0;
        Thu, 03 Jul 2025 21:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751602239; x=1752207039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rOsl7CR/Km27mQJQQ5nCcQyvHS1FKCs3qYBDakhTIoc=;
        b=TTG3fRYUpJJjqBPYFEUEpVfcTuaclRdzBk1omrqn+9CaACEMKKFJKlKHOmkHSIerVu
         I3jAxOUzQEfbmB/4hxFyolkef2JYCuFjsP7teHZSyUdWxR9byKKcmNPF78BGlh5B5G1s
         HMEkzdETTznNm15PdA2EiZ4ROWWy1BsnhEvCLPnTpcKXxk5GndlzlHt48iQt5H8+0iqO
         B6BxdSpjPgvhblhQWhAKye+OIBKaRwjiybmxDDC1ZJ0vrbfxKkhhpXv3/R5WYnxKiDCk
         r9heg00Iaq5o49H80m4vJ2vPQADy+O/ZL11MdPk+AZ3f+bMPbhw7ijO1k5P0z78Lp4Wd
         M6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751602239; x=1752207039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOsl7CR/Km27mQJQQ5nCcQyvHS1FKCs3qYBDakhTIoc=;
        b=hkfqMUuR4mUaQUhk6eMzaXY0jEVXvvluam+5n2Z73KAFDdMTv/gnCjJNi+03lo8sbI
         5gKoHDcXwW5Y62S6Bj7kH93rcr0YOD4YwZo7haBZRoAeZe7GbK10Nj7+51INCQ8kvQ6T
         rVCxBXP51NZqBeoqrA48/pia9Q+Klv9VAux5HiJrUUzV2WYcPG8HNodByPnEKyMeVLsV
         PS/Wujk5c/X8WjKDj5ie1BgeK5fch5xafTnHeBJc597tN4ehoFsYvKwyYoBPvNSJcppL
         NIcYZ8RPePNh9iYxjD+phRhgM1KBSVSPoILJraON4b6UsYvLizHtDfaPu305CjIrzYhU
         48BA==
X-Forwarded-Encrypted: i=1; AJvYcCUqyVyhvcfEvxTPIitzjmVwT8y5FgR6KFJVKdG+HbXpulmjdJPET72fIIa4/7VUrtXnmb7C76Eb2Y475dYj@vger.kernel.org, AJvYcCUvyEKxLdG7OXDZfWhUEBs2XrmgAMB9EdQq28ZrRrl76d2dJAkXR5jUUCuvpF+da3N704UYASNKi3SK@vger.kernel.org, AJvYcCUx9jg2xNm1k1r1N1hy6yKvLZBx5kXoq0qJ4YWiI8HmUFdWtZzTR6Ya5YG37OzdP3QJpYJ4RPcmUeoy@vger.kernel.org, AJvYcCUzqjUf9G2eVDuBU1f2Aw04Yv/2Osk29GQ25Ohp8EuvZsQhnvpL6MFAyjKoMrrHJzCWSzyazzOuffs6xvZtAZg=@vger.kernel.org, AJvYcCVWWeCVcpPBeLCIrBjdeOC+OYleWzWGk240jhQIxdyZ23f/lUZ4VoudTMhAFnNSvXWzF1y+4twB@vger.kernel.org
X-Gm-Message-State: AOJu0YwodPnLEA/cgw7FpS2vc3Sa5mIJAEQfe0Vlz9cCey1zdM2UPSPm
	1zMXuBGZK9Kh1+Rli1UwCdv1SjpwGtfvdALpvMx6Q71YZDPlijtTjVn5WnNiZvT3
X-Gm-Gg: ASbGncv93nkTN1BONm1Juzyuxi3uqHJ6lI28im6dEdeRsMLKaqU2dKrhTRn0oKRiQwS
	Cp6KhZSkTSgD6u4Ul7nMLZeP2vv+hzdhm6Hy0Bg5FRKdg6H4AmKadDBEN8tO5SrxOsN5VICpVSW
	51EhOj8HHPMAjf8PpbYz+s435oW6mKd0Ny+3EmnnobNObmZH9357G74mWtEJJRJk132fNPVrab7
	t1uAez4/FmX2BAWec1e2PgwX5aHfck1n7L2GhZPM54qHOhH6JcYdf7K0BU/4HF2zdrgdMv8/u/G
	CQ04guc56VeVW0HAcLhTyelNf+ZOu01nf+Pp2Z3ahlKAYiWHK4ndAJS4lyOdk0wQDVMhGi7++Lz
	t2cb94RAraYSC7RbkZrJ9NePBHPl9pEaJs2FZ6ckV9xr5ow==
X-Google-Smtp-Source: AGHT+IGijwZ/VaDDoU4q/O6ib72Y7x9Bzt5VkHerKX1ea/rm2xa62dpX8WJCTcQOWARzdJIAIhb63g==
X-Received: by 2002:a05:6a00:b49:b0:736:4644:86ee with SMTP id d2e1a72fcca58-74ce69b2315mr1616237b3a.14.1751602238785;
        Thu, 03 Jul 2025 21:10:38 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35ccb9esm1055290b3a.50.2025.07.03.21.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 21:10:38 -0700 (PDT)
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
Subject: [PATCH v3 0/3] rust: Build PHY device tables by using module_device_table macro
Date: Fri,  4 Jul 2025 13:10:00 +0900
Message-ID: <20250704041003.734033-1-fujita.tomonori@gmail.com>
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

v3:
- Fix Safety comments and typo
v2: https://lore.kernel.org/lkml/20250701141252.600113-1-fujita.tomonori@gmail.com/
- Split off index-related parts of RawDeviceId into RawDeviceIdIndex
v1: https://lore.kernel.org/lkml/20250623060951.118564-1-fujita.tomonori@gmail.com/

FUJITA Tomonori (3):
  rust: device_id: split out index support into a separate trait
  rust: net::phy represent DeviceId as transparent wrapper over
    mdio_device_id
  rust: net::phy Change module_phy_driver macro to use
    module_device_table macro

 rust/kernel/auxiliary.rs |  11 +++--
 rust/kernel/device_id.rs |  91 ++++++++++++++++++++++++----------
 rust/kernel/net/phy.rs   | 104 +++++++++++++++++++--------------------
 rust/kernel/of.rs        |  15 ++++--
 rust/kernel/pci.rs       |  11 +++--
 5 files changed, 138 insertions(+), 94 deletions(-)


base-commit: 2009a2d5696944d85c34d75e691a6f3884e787c0
-- 
2.43.0


