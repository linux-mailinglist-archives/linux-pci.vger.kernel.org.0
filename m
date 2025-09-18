Return-Path: <linux-pci+bounces-36424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 925BEB85A7A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 17:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C436221D6
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC9C30F93A;
	Thu, 18 Sep 2025 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Er0/+4DA"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6CC30F939;
	Thu, 18 Sep 2025 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209485; cv=none; b=O/3wJszZeysZPIbHPsY9l9s+QziMDm3xw1ffnbpbPjYo8BWhV3qihMEJSk72IwHq1C4BH15lg3i88jmjXnRZSXai3sBJuKy0oR0KDJFPb6HFejul28m67xiBsxFoQRthOxDRBzhyS4I5f3HPpcfg/jPAP56MctoNyXYfBV6WkIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209485; c=relaxed/simple;
	bh=kNhbnaZz9O0F4p7ucRW4mmMBjCu2zNDrBJriaH3FC64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Srudb57yVi1lPCWSR2TJccLm/IbENWnPNfVxtI6sg2dtl/iQV007QLgsZEr7P3bpNWyYEjM1tojAHfEmNwIJ/maAPaeMyac3LoUthetLW5NsJUgB/e2vzDQpv8PM3t+/L/Z62aZ0o4BAa+jenOHyij9qdpQf2wvGAQ/GK9hw0Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Er0/+4DA; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E4EEE2649D;
	Thu, 18 Sep 2025 17:31:21 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id admD6bqCwlFv; Thu, 18 Sep 2025 17:31:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1758209480; bh=kNhbnaZz9O0F4p7ucRW4mmMBjCu2zNDrBJriaH3FC64=;
	h=From:To:Cc:Subject:Date;
	b=Er0/+4DATvWq8LChdwoWUu4mCOryZT0oVFxIIV9N4ORORc2hW2iXF8uGNqcFSK2BD
	 4f5fLcc/z2HhRuYUbFvmUR8ppmQ+CkQJKwcUQyidSml1Cf8JIlg3DhFvBvWkARDR9g
	 2j1glEPrNCp5c01KvUQFG45oMHMgu89NFBGV185kUGUrUrFFrZoCsbYcEZTBTYxGp2
	 sJhRH6jt1bfYjMt8H7ZBuQBuPRNwMVwpSSOm3zMmAo+mLL/Msqy16k86jO3t2hPkpv
	 G5HaGRQLY/mWxXcj2vr0eJ2go4fpyTtNmsf0A8jUqEZftedcneQYkayFHuKl802qZD
	 aNdpRxAfMA25w==
From: Yao Zi <ziyao@disroot.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 0/3] Add PCIe Gen2x1 controller support for RK3528
Date: Thu, 18 Sep 2025 15:30:54 +0000
Message-ID: <20250918153057.56023-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK3528 ships one PCIe Gen2x1 controller that operates in RC
mode only. The SoC doesn't provide a separate MSI controller, thus the
one integrated in designware PCIe IP must be used. This series documents
the PCIe controller in dt-binding and describes it in the SoC devicetree.

Radxa E20C board is used for testing, whose LAN GbE port is provided
through an RTL8111H chip connected to PCIe controller. Its devicetree
is adjusted to enable the controller, and IPERF3 shows the interface
runs at full-speed. A typical result looks like

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  1.10 GBytes   942 Mbits/sec    0             sender
[  5]   0.00-10.01  sec  1.10 GBytes   941 Mbits/sec                  receiver

This series is based on next-20250917, thanks for your time and review.

Changed from v1
- Collect review tags
- SoC devicetree
  - Drop redundant PCLK_PCIE_PHY clock for PCIe node
  - Use 32-bit DBI address, adjust SoC ranges property and reorder nodes
  - Align cells of reg and ranges properties
- board devicetree
  - drop redundant pinconf pcie_reset_g
  - Add missing vpcie3v3-supply
- Link to v1: https://lore.kernel.org/all/20250906135246.19398-1-ziyao@disroot.org/

Yao Zi (3):
  dt-bindings: PCI: dwc: rockchip: Add RK3528 variant
  arm64: dts: rockchip: Add PCIe Gen2x1 controller for RK3528
  arm64: dts: rockchip: Enable PCIe controller on Radxa E20C

 .../bindings/pci/rockchip-dw-pcie.yaml        |  3 +
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   | 12 ++++
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 56 ++++++++++++++++++-
 3 files changed, 70 insertions(+), 1 deletion(-)

-- 
2.50.1


