Return-Path: <linux-pci+bounces-31897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065D6B011F3
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 06:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F943B3646
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 04:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310C91A2632;
	Fri, 11 Jul 2025 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yr5IYiYj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BE73D6D;
	Fri, 11 Jul 2025 04:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752207025; cv=none; b=GcMmgdkFyv8BklO8SDvLNy/PcQ1RE40+6xpVt6xZ/G9A4W2vXIAAp3DXjOjYF7Egzv/C6c/kBgE99UuRdxZ6YLSINV9LKF2yR5VLUfVr9FrTAKCMNhD21pPhHnbkZah7Co+Of2qGsqXct91xh6AxVjBPxz2E6jlAMBeoF0Gsu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752207025; c=relaxed/simple;
	bh=sizDRPCJWGICcHP4/doFZ3qsK7Xiy8SySxy/WurYvy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMgZ9RpJP4GxSJDyviHyZoakEsSYQ5Af/9SMetlyY6rTvrjk5H/Fzxxf9xK4O/rINaVYkz1L/MP2vbQf2hnPZibRqurVHcyvDWLfC1ajAZHd2fiffPEDzVJY23Iv3TlXDOK+B5tr7NogV21ONBnEPr9zMRyYXh3VvWmROqwrN6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yr5IYiYj; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3137c2021a0so1384965a91.3;
        Thu, 10 Jul 2025 21:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752207023; x=1752811823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9uNjF8oTtQxPk0+hEJW3L80kLHxLWNl8NSdzEDPj7U=;
        b=Yr5IYiYjCZxNOxPtVbt6284Ojm+uvlbulGAcFWBaUPNXWkAQFmGKAVp2NcDra9IW1R
         8Rvxr9gUHoEf0bK1FtxMAddu0NzDlOm5lp+nnkN5vRWWLytV2n1KDlAvcSHuNak+AULu
         iM6X4z73iDdGv4smWprDjF/JFN8IvgnoE5ZTn5Nh6IZc1T9C/VJ09AD6mETuaO9ITv/i
         BSSSQdAAuBRHDs67hqZAS0+esqiaT0XW4NKc6B2aj1hjTfEScszAtvGUfr27pxZw8VqM
         KV6J0syk+xJUH9BSdeRUdqN3PciOpogpRhnuveyYUWvxsDbSQYF1RN2NcG4ZmXhj5TPG
         ratg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752207023; x=1752811823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9uNjF8oTtQxPk0+hEJW3L80kLHxLWNl8NSdzEDPj7U=;
        b=fn+lTdZn3kM0Enp9rxIrxpN/vk3Umr/NVDxrGDinG4AMbNt1ijMbjBowCGY0IDOVzm
         vT3nyewhHC0S7x3vPm+KMLCiwtmyHEgKnK28QbPU6d+DR1KjkyesPVUfQ8Uz4t1O81A7
         1V/ibjdMSWVP7LiEkoV5BGyf5HeI41GwXjwVJdyAZLuiY5ztOFNjanq/Iq1s+pUwXN2P
         CVGOinVSa+brETMARzP9SiiTIJOnVP0vipNIS7mIeL0fUZ0beLRmQYLcD93YzFLQoUmB
         FzyAKVgpk0IMHAE3NO8WJnHeLw9nkLm7VB1flHGL6S48+sbr6S9INM+JyE6q5z+KVmKl
         W21g==
X-Forwarded-Encrypted: i=1; AJvYcCUJlW6M0iavS//Xi+CBYT/U6q/MezrVxE+/MSnnn4gneXpSeYk2PD9bnMYHgueFftZvy5AkZ7Qdwymg@vger.kernel.org, AJvYcCVcmPiZbwzKOF8ERwj3nD3coUKwl4EzUBApxgCf2nk1Y6Tm++c3PdhFdb+4x6r6RINq2ljtBQZt@vger.kernel.org, AJvYcCW6B7Fu4bnfykRuqn/ivouAatnC81H2JzDWtvurktSYk1UlH6OxdJtegWyj50HNTHGdwmDlMVb3e+IkEQ7Z@vger.kernel.org, AJvYcCWSEjQ6jKDz1P29bc73xhomzXmx2gnPzg4yD6BFuiqIWG1r6kHnHjPYpgbRhprCMjDfeAupLsAOegKyIc4fwYU=@vger.kernel.org, AJvYcCWt49ei4lxRUQKzp/pfAWdrPlyhnZc5u2On0tS8dAhmvIVC4wsTRKwhsfXdtfsr16JpQ6cSJuSmzQAmzg==@vger.kernel.org, AJvYcCXmBp81SaD1jq10g2kqoty57RwoLhOzfstxjCDqCjeYmla99Pc7ari0v6dwzlutQkYxDg3aVfx9/Ely@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJoNBcB9hd1e9HYsBllUmy2oyfGvx1mZHfJ84as/LuVcgF8e8
	LHpvu6jZYd2/jyidqxLPWgtOAqHoWzXVFI4YjAsbzGCdljoZcQMoOcpL
X-Gm-Gg: ASbGncsdd7frMh6fk541bNHyXPLQxYlNMoKm/tQPOyOXIK+dIdU3rmfPRk69grivpWI
	3lPyaQVhIi4fz5Mk9tnE3QHzalckPVguGRiniL9WyfDkgXgfzzpSM0fTa3mW4ZDNUYV0gcStVy+
	uYb5GtBvekiYPYwFlpb1ZQnNun3jXS5jHZMvhEdGufZpjUycYi+pkpbRiYFpIEVNwv9rGH/fQhD
	PUQ30vZMtIxccT+WGTSevK8V2yU8j4AtMdlRU/l8t9hK6D/lbVPNVYE9THuGDzX707+56q256BR
	LoNxfVQp3p0hwE5Y7CWMtLNJelxY6OvXD0OO3vFDMzW7JHFnufXp0nJrI+XQValvHxMkIaWP5h/
	eDFjuGekwj2VaHQ/DrC/Ov9Vrdr2lFMZPHXSQNuhct6UQcAnuDHZKifIDbud2+23zTYoepIc=
X-Google-Smtp-Source: AGHT+IE1i7+doG0MB1VIutKCSwuGpp0+Wo3W3hUMtDdGs3TyfkwZmYkfICSEt4EID2JBsb8hwrtIGw==
X-Received: by 2002:a17:90b:1f92:b0:312:daf3:bac9 with SMTP id 98e67ed59e1d1-31c4cdb9612mr2039246a91.34.1752207022787;
        Thu, 10 Jul 2025 21:10:22 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6f4fc8sm3902095a12.51.2025.07.10.21.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 21:10:22 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: alex.gaynor@gmail.com,
	dakr@kernel.org,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	rafael@kernel.org,
	robh@kernel.org,
	saravanak@google.com,
	tmgross@umich.edu
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
	lenb@kernel.org,
	leon@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lossin@kernel.org,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v4 0/3] rust: Build PHY device tables by using module_device_table macro
Date: Fri, 11 Jul 2025 13:09:44 +0900
Message-ID: <20250711040947.1252162-1-fujita.tomonori@gmail.com>
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

Danilo, I incorporated your fixes into the first patch and mentioned
them in the commit message. Let me know if you'd rather take a
different approach.

v4:
- Rebased on driver-core-next
- Improve docs based on Trevor's comments
v3: https://lore.kernel.org/lkml/20250704041003.734033-1-fujita.tomonori@gmail.com/
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

 rust/kernel/acpi.rs      |  15 ++++--
 rust/kernel/auxiliary.rs |  11 ++--
 rust/kernel/device_id.rs |  91 ++++++++++++++++++++++++---------
 rust/kernel/driver.rs    |   8 ++-
 rust/kernel/net/phy.rs   | 106 +++++++++++++++++++--------------------
 rust/kernel/of.rs        |  15 ++++--
 rust/kernel/pci.rs       |  11 ++--
 7 files changed, 156 insertions(+), 101 deletions(-)


base-commit: 3964d07dd821efe9680e90c51c86661a98e60a0f
-- 
2.43.0


