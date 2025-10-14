Return-Path: <linux-pci+bounces-38069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5556BDAB22
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 18:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF863AB2AD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E704F3019CA;
	Tue, 14 Oct 2025 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="TGzsmcQ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E262571A5;
	Tue, 14 Oct 2025 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460572; cv=none; b=io/zlmRfADKZ69MWFo6ULvV29rQTlhrRPyKyXUVJd8hGqRAoBWuYDEKbxCbLVKidCci+8Wix/qeCUGe4KQ1vEcZ+iLKBG2a79ixpq0x0F095z5Y3h0kL3xlAN/p4ye4HhZJL+tadWzzcz28UBd7a4KA+vg157IDnyqMag6GS81o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460572; c=relaxed/simple;
	bh=QnBzeT/6GmTm8hH+FsTbLNHm+ZptGc3ZyK1NlROAzuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cPmpkxkEekJ7CB97TsEJ0hyOrzVB1bGABECsC4QbBYyaiLinLV4iWiBRPLEzWd6ICGZH0QtzfOTzreaVaUjprXKc7zrKXzM/u+y1qpYKNEU2oLnpGq+SmAPJ5AQcCd+rqKZfOmIE3lYEEdhNnl+TiQkK3CW9UZo5vegqf0oMgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=TGzsmcQ5; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B5B87260EF;
	Tue, 14 Oct 2025 18:49:27 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 78QXG2VkBGJd; Tue, 14 Oct 2025 18:49:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760460566; bh=QnBzeT/6GmTm8hH+FsTbLNHm+ZptGc3ZyK1NlROAzuc=;
	h=From:To:Cc:Subject:Date;
	b=TGzsmcQ54DJ31kRuX2ynXgxGbhxgY0KGBbhp5h1pZkoVFRmQs9GuXjpN2tBlndsEJ
	 QFW7Luk1wZHBveq2cB4qZoas3uV6nttRxU0VYdyr05kPfJtCaT3FVV6yb5wz+H5MpP
	 yPknHxMpTQ7BjpDU0Pj5OIyepRLes31xoVBLvtzSclBXIN6RS5KqBZy12m7PPPnl1/
	 E2gZh2qXA9GGRN1GDcuPCQXQa2PNsWMdWGTfDG1T+b38Z8z2nom61QoZlWiySU3cuo
	 9doENEbX6RDDRfaiwDKW4LQYLUKcQBMaRW/vp9Qfa/McKdIKxz+9pP+9usiqN7i2u3
	 VOYFaeuThlUpQ==
From: Yao Zi <ziyao@disroot.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next 0/4] Add DWMAC glue driver for Motorcomm YT6801
Date: Tue, 14 Oct 2025 16:47:43 +0000
Message-ID: <20251014164746.50696-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds glue driver for Motorcomm YT6801 PCIe ethernet
controller, which is considered mostly compatible with DWMAC-4 IP by
inspecting the register layout[1]. It integrates a Motorcomm YT8531S PHY
(confirmed by reading PHY ID) and GMII is used to connect the PHY to
MAC[2].

The initialization logic of the MAC is mostly based on previous upstream
effort for the controller[3] and the Deepin-maintained downstream Linux
driver[4] licensed under GPL-2.0 according to its SPDX headers. However,
this series is a completely re-write of the previous patch series,
utilizing the existing DWMAC4 driver and introducing a glue driver only.

This series only aims to add basic networking functions for the
controller, features like WoL, RSS and LED control are omitted for now.
Testing is done on Loongson 3A5000 machine. Through a local GbE switch,
it reaches 871Mbps (TX)/942Mbps (RX) on average,

$ iperf3 -c 172.16.70.230
Connecting to host 172.16.70.230, port 5201
[  5] local 172.16.70.12 port 48590 connected to 172.16.70.230 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   113 MBytes   950 Mbits/sec    0    376 KBytes
[  5]   1.00-2.00   sec   113 MBytes   946 Mbits/sec    0    376 KBytes
[  5]   2.00-3.00   sec   112 MBytes   941 Mbits/sec    0    376 KBytes
[  5]   3.00-4.00   sec   112 MBytes   939 Mbits/sec    0    376 KBytes
[  5]   4.00-5.00   sec   112 MBytes   939 Mbits/sec    0    376 KBytes
[  5]   5.00-6.00   sec   113 MBytes   946 Mbits/sec    0    399 KBytes
[  5]   6.00-7.00   sec   112 MBytes   940 Mbits/sec    0    399 KBytes
[  5]   7.00-8.00   sec   112 MBytes   940 Mbits/sec    0    399 KBytes
[  5]   8.00-9.00   sec   112 MBytes   938 Mbits/sec    0    399 KBytes
[  5]   9.00-10.00  sec   112 MBytes   937 Mbits/sec    0    399 KBytes

Connecting to host 172.16.70.12, port 5201
[  5] local 172.16.70.230 port 50466 connected to 172.16.70.12 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   106 MBytes   884 Mbits/sec    0    486 KBytes
[  5]   1.00-2.00   sec   104 MBytes   870 Mbits/sec    0    486 KBytes
[  5]   2.00-3.00   sec   104 MBytes   868 Mbits/sec    0    486 KBytes
[  5]   3.00-4.00   sec   104 MBytes   869 Mbits/sec    0    486 KBytes
[  5]   4.00-5.00   sec   104 MBytes   873 Mbits/sec    0    486 KBytes
[  5]   5.00-6.00   sec   104 MBytes   871 Mbits/sec    0    486 KBytes
[  5]   6.00-7.00   sec   103 MBytes   867 Mbits/sec    0    512 KBytes
[  5]   7.00-8.00   sec   104 MBytes   872 Mbits/sec    0    512 KBytes
[  5]   8.00-9.00   sec   104 MBytes   873 Mbits/sec    0    512 KBytes
[  5]   9.00-10.00  sec   104 MBytes   874 Mbits/sec    0    512 KBytes

Thanks for your time and review.

[1]: https://lore.kernel.org/all/Z_T6vv013jraCzSD@shell.armlinux.org.uk/
[2]: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/
[3]: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/
[4]: https://github.com/deepin-community/kernel/tree/dc61248a0e21/drivers/net/ethernet/motorcomm/yt6801

Yao Zi (4):
  PCI: Add vendor ID for Motorcomm Electronic Technology
  net: phy: motorcomm: Support YT8531S PHY in YT6801 Ethernet controller
  net: stmmac: Add glue driver for Motorcomm YT6801 ethernet controller
  MAINTAINERS: Assign myself as maintainer of Motorcomm DWMAC glue
    driver

 MAINTAINERS                                   |   6 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   9 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-motorcomm.c | 388 ++++++++++++++++++
 drivers/net/phy/motorcomm.c                   |   4 +
 include/linux/pci_ids.h                       |   2 +
 6 files changed, 410 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c

-- 
2.50.1


