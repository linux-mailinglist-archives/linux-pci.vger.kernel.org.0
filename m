Return-Path: <linux-pci+bounces-8568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A732F902FAB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 06:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51991284F9D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 04:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389E0282E2;
	Tue, 11 Jun 2024 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZblmMN/q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACECE140E30;
	Tue, 11 Jun 2024 04:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718081630; cv=none; b=R1rB8wpk4Y6u5RGzkoLMv/QkBwEGwYPoALMxUsRzSpA8NV/tqFbF9napj+ZWkn6nFaDaPVfEUXSD8Gc1M+VDIcpl5+8nK9yWSR8XPsrF8qGKm6TZJdCEueHgLymIwsPeGfrpcmujxjV5YuBX8rRH02U0CZ/PGpjLB2SQ5yo91so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718081630; c=relaxed/simple;
	bh=1r/KZPJK7SnWqcEGiuRZWkZvSqQTaNiTQOLOtBD77Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wj+p5YvVNTB6dBjvkksQWP5VSYHwMtp1+VEKBc0h2YSQmoqmV52IjpU5Puy2r0Kkukj6MO6msUAxYghae81C2hGZ7LQmWg95aam8ZA+5Ta9MDgIZOSGo+iIiqDo2cR2e5X+o4FuP/5wKUGxDdYkyVaLAUJDL+sZ97XHnHItxA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZblmMN/q; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6c386a3ac43so409764a12.0;
        Mon, 10 Jun 2024 21:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718081628; x=1718686428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tkYvwHUb1vxYE4FRpnnovzeM3NUFslIev6dcv32PViU=;
        b=ZblmMN/qLUKk7GxHsZ4KgI+3I0w+ux/ZJpr/41xWZKLo1Nc29Yh6QimiwIZvbX3PxJ
         Zx5+nvvDFM94TPR0ul6j7ukT8q24/HBECBlaft3z5wTVKVwGsb9v+FD3JbcuDfoyZ6ht
         fVFHK2uq8KqKISYY4SffjzHcH7R7aukexTSpd44ioWbG7yzqg+RdYLO7JCo7WVFOuJf1
         NTuxuSrqEJBL9Gocg8L2h5AJR/fVuKx8u7q1sJcR2Pehu+Nl+P9imjvGssCoNSk44Zv7
         ZW2zrzSRbU6nMpEIMo3PsZVQMfyGFoVZbh+7EMC5pz6M1s10h3I4X2oXP2EXKOvARXEn
         EE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718081628; x=1718686428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkYvwHUb1vxYE4FRpnnovzeM3NUFslIev6dcv32PViU=;
        b=TiEGyOYy2/DfnCoEEvPHR+NI8gCE3+Pi9mAqHiSlfeyQNxQSKcnMgiIkQLihg76vCk
         OvP80aplcFH7Aid5wqmOBD49EPsjEK9PFMkq3DGYSy1YIL6kXFm+8C8wLOpGifT2/Db6
         tz4Nb6ztipS3VX7BT8n1UpgIToiMhpRP3wxpRHBWD2RkFVnFuY3uqIh2jWOoS5dCEScv
         5ORO3xVZ4Zc7A3H9g+2abNnDL43CQ/hz4oHeS90aNZdUHiANy9slZmJLiPX1GVO0pjUI
         dSN+UMTuZVFVx1DAiTKod3DlvOKlHOryG9Hs1lIsBqFQby+rX+O1nRoAFI9EpqnlbnlT
         W1nw==
X-Forwarded-Encrypted: i=1; AJvYcCWUuHsTud5hQLyWlIt+RQmFLL4pBZYuLlqxeZtCcr7UQoS0Sg0qJ8un8/rfdmDFyYVKImrBSuqaKJgzHoIGy/ImjBT7P2xiVbXG
X-Gm-Message-State: AOJu0YxMOjpImotVga5F4xQPiIrWIrIzmz32x11dtsRycLReIeXeIzE6
	OB03mSBWAcIrwrFAvvpV1Kw2BAHSkde10drWVkDE0Z55iQTG1LQ8Uz40yv27
X-Google-Smtp-Source: AGHT+IH0996eFFPs8rJllAfF6Ru2kQBs0zi4X0C+0CCdgKMqDUrYI1grs7VNdAPfCnuTM5xEw1GHyQ==
X-Received: by 2002:a17:90b:2b44:b0:2c2:c967:3e56 with SMTP id 98e67ed59e1d1-2c2c9677558mr10426910a91.4.1718081627514;
        Mon, 10 Jun 2024 21:53:47 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c31bb3c141sm1967277a91.10.2024.06.10.21.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 21:53:47 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hfdevel@gmx.net,
	naveenm@marvell.com,
	jdamato@fastly.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next v10 0/7] add ethernet driver for Tehuti Networks TN40xx chips
Date: Tue, 11 Jun 2024 13:52:10 +0900
Message-Id: <20240611045217.78529-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds a new 10G ethernet driver for Tehuti Networks
TN40xx chips. Note in mainline, there is a driver for Tehuti Networks
(drivers/net/ethernet/tehuti/tehuti.[hc]), which supports TN30xx
chips.

Multiple vendors (DLink, Asus, Edimax, QNAP, etc) developed adapters
based on TN40xx chips. Tehuti Networks went out of business but the
drivers are still distributed under GPL2 with some of the hardware
(and also available on some sites). With some changes, I try to
upstream this driver with a new PHY driver in Rust.

The major change is replacing the PHY abstraction layer in the original
driver with phylink. TN40xx chips are used with various PHY hardware
(AMCC QT2025, TI TLK10232, Aqrate AQR105, and Marvell MV88X3120,
MV88X3310, and MV88E2010).

I've also been working on a new PHY driver for QT2025 in Rust [1]. For
now, I enable only adapters using QT2025 PHY in the PCI ID table of
this driver. I've tested this driver and the QT2025 PHY driver with
Edimax EN-9320 10G adapter and 10G-SR SFP+. In mainline, there are PHY
drivers for AQR105 and Marvell PHYs, which could work for some TN40xx
adapters with this driver.

To make reviewing easier, this patchset has only basic functions. Once
merged, I'll submit features like ethtool support.

v10:
- Add Edimax Vendor ID to pci_ids.h (cleanup for wireless drivers later)
- rename functions for mdio (use _c45 suffix for read/write and mdio_wait_nobusy)
- clean up some tn40_rxdb_ functions
- use unsinged int for static, nelem, and top in tn40_rxdb struct instead of int
- return -ENODEV instead of -1 when PHY isn't found
- remove the function to re-setting mdio speec to 1MHZ in tn40_priv_init()
- cleanup tn40_mdio_set_speed()
v9: https://lore.kernel.org/netdev/20240605232608.65471-1-fujita.tomonori@gmail.com/
- move phylink_connect_phy() to simplify the ndo_open callback
v8: https://lore.kernel.org/netdev/20240603064955.58327-1-fujita.tomonori@gmail.com/
- remove phylink_mac_change() call
- fix phylink_start() usage (call it after the driver is ready to operate).
- simplify the way to get the private struct from phylink_config pointer
- fix netif_stop_queue usage in mac_link_down callback
- remove MLO_AN_PHY usage
v7: https://lore.kernel.org/netdev/20240527203928.38206-7-fujita.tomonori@gmail.com/
- use page pool API for rx allocation
- fix NAPI API misuse
- fix error checking of mdio write
v6: https://lore.kernel.org/netdev/20240512085611.79747-2-fujita.tomonori@gmail.com/
- use the firmware for TN30xx chips
- move link up/down code to phylink's mac_link_up/mac_link_down callbacks
- clean up mdio access code
v5: https://lore.kernel.org/netdev/20240508113947.68530-1-fujita.tomonori@gmail.com/
- remove dma_set_mask_and_coherent fallback
- count tx_dropped
- use ndo_get_stats64 instead of ndo_get_stats
- remove unnecessary __packed attribute
- fix NAPI API usage
- rename tn40_recycle_skb to tn40_recycle_rx_buffer
- avoid high order page allocation (the maximum is order-1 now)
v4: https://lore.kernel.org/netdev/20240501230552.53185-1-fujita.tomonori@gmail.com/
- fix warning on 32bit build
- fix inline warnings
- fix header file inclusion
- fix TN40_NDEV_TXQ_LEN
- remove 'select PHYLIB' in Kconfig
- fix access to phydev
- clean up readx_poll_timeout_atomic usage
v3: https://lore.kernel.org/netdev/20240429043827.44407-1-fujita.tomonori@gmail.com/
- remove driver version
- use prefixes tn40_/TN40_ for all function, struct and define names
v2: https://lore.kernel.org/netdev/20240425010354.32605-1-fujita.tomonori@gmail.com/
- split mdio patch into mdio and phy support
- add phylink support
- clean up mdio read/write
- use the standard bit operation macros
- use upper_32/lower_32_bits macro
- use tn40_ prefix instead of bdx_
- fix Sparse errors
- fix compiler warnings
- fix style issues
v1: https://lore.kernel.org/netdev/20240415104352.4685-1-fujita.tomonori@gmail.com/

[1] https://lore.kernel.org/netdev/20240415104701.4772-1-fujita.tomonori@gmail.com/

FUJITA Tomonori (7):
  PCI: add Edimax Vendor ID to pci_ids.h
  net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
  net: tn40xx: add register defines
  net: tn40xx: add basic Tx handling
  net: tn40xx: add basic Rx handling
  net: tn40xx: add mdio bus support
  net: tn40xx: add phylink support

MAINTAINERS                             |    8 +-
 drivers/net/ethernet/tehuti/Kconfig     |   15 +
 drivers/net/ethernet/tehuti/Makefile    |    3 +
 drivers/net/ethernet/tehuti/tn40.c      | 1768 +++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h      |  231 +++
 drivers/net/ethernet/tehuti/tn40_mdio.c |  142 ++
 drivers/net/ethernet/tehuti/tn40_phy.c  |   76 +
 drivers/net/ethernet/tehuti/tn40_regs.h |  245 ++++
 include/linux/pci_ids.h                 |    2 +
 9 files changed, 2489 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h
 create mode 100644 drivers/net/ethernet/tehuti/tn40_mdio.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_phy.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40_regs.h


base-commit: 2ebb87f45b3c6adc97b29291102ecb97274f913f
-- 
2.34.1


