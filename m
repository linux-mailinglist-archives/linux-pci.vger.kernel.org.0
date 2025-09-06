Return-Path: <linux-pci+bounces-35595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E16B46F0C
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 15:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B7D1B25095
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AF12EDD41;
	Sat,  6 Sep 2025 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="O2oYry+i"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338D016F265;
	Sat,  6 Sep 2025 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757166789; cv=none; b=bNq0bN1an8kw5lUALhN6QLXmlIs/Ex0J8MWrhcX5EUlIyRZ2i3zJn7w7HfyKsYTQ+dIp4NKUpTmNeIbYcEnoX74sFCcEt6PLhH6PHJ4asYUE7QaL0pXeNOyI+rWBRa/DuM9MeEWRAhKcEo7nLza9TqtJ4Dweh4Ko2KaqcE9MrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757166789; c=relaxed/simple;
	bh=sbSOKYEZAbDsrQxHT2FLZ1m3Ipyvre5ODuB7BBRX+l0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BjMyo/e5KIGTCndWbypV7ya+sByz1mjI5FGaFv3O2Q8OlerJC4K+3S9rFq8Jip84b0x7ncAoPnpMcWWjZqNu/YKF8GH+3xfdH4tCu1GZyTYY+ysH6EHwJi8hy8My1ro8aCyxXsvdaR3FFSMWWaDXnBJderFUpxfRbp56pVps1tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=O2oYry+i; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id EB8DA251ED;
	Sat,  6 Sep 2025 15:53:03 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qmvn1vWBqIBy; Sat,  6 Sep 2025 15:53:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757166783; bh=sbSOKYEZAbDsrQxHT2FLZ1m3Ipyvre5ODuB7BBRX+l0=;
	h=From:To:Cc:Subject:Date;
	b=O2oYry+iKtFFPltH0qtByVrCX+rYbXZiwAg4qSZ0EzcCsZu9yTLjYwPNtB2JgMlLf
	 2AN+ZmO/k64owytMybq/ymMxVU7uRXrJu0A+pYlIkszCUdVes8+wN2kHoFAT023X+k
	 QChQ9RTgyZYOV0cNY8y6gjusXNMUTy1ZAlSDjkqXXzU+7bPynaKhTnbJnSnrV6P/Pv
	 CXUy2V2tcj/jup4FHOMQos2C70LzmciNKk9rZHPSdQ5rQ5Op2V09e0nbiPU/MLBUu7
	 NRgUi1JYXjUYP9ZxIHUZdfAI/yyBWiUzijh03oEqfOZJdvxw3s8W7A1dsM+laWMhnD
	 Ko3kweRT53T+Q==
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
Subject: [PATCH 0/3] Add PCIe Gen2x1 controller support for RK3528
Date: Sat,  6 Sep 2025 13:52:43 +0000
Message-ID: <20250906135246.19398-1-ziyao@disroot.org>
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
[  5]   0.00-10.00  sec  1.09 GBytes   936 Mbits/sec    0            sender
[  5]   0.00-10.00  sec  1.09 GBytes   934 Mbits/sec                  receiver

This series is based on next-20250905. It's worth noting that
commit 727e914bbfbb ("PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
cond_[startup|shutdown]_parent()") (already contained in next-20250905)
is necessary for normal operation of designware PCIe IP's integrated MSI
controller.

Thanks for your time and review.

Yao Zi (3):
  dt-bindings: PCI: dwc: rockchip: Add RK3528 variant
  arm64: dts: rockchip: Add PCIe Gen2x1 controller for RK3528
  arm64: dts: rockchip: Enable PCIe controller on Radxa E20C

 .../bindings/pci/rockchip-dw-pcie.yaml        |  3 +
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   | 17 ++++++
 arch/arm64/boot/dts/rockchip/rk3528.dtsi      | 56 ++++++++++++++++++-
 3 files changed, 75 insertions(+), 1 deletion(-)

-- 
2.50.1


