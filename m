Return-Path: <linux-pci+bounces-9713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9D09257A7
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 12:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C7828CA4A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6DD1428E5;
	Wed,  3 Jul 2024 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="wZ2SUwZT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469917741;
	Wed,  3 Jul 2024 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000864; cv=none; b=RZWDReTX1HTzc085k0I3G+OGeUlL6nFkQYykOhi64/3L11WnwFScZkfuKrm+TSHo0IWkJ2698Av2WOc41QdMBWWmIA3tAIfPjL6uNEJdq5FNMVA44VC+6Jiq5Ks7a1tsGK8YE0IU5ATSR8KCqCoFC3+zmeW+zZrWThDdKp4xv6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000864; c=relaxed/simple;
	bh=ThCcL5mAtdacLqb8bqiSQmLe1aprXGFClfJaW/G0l/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nFRrR5FIqeSdwdVBH6lz0KkINXcZuyJEsoJ3gjcT/RMvFj0c12hYK7WfwzmLCLjPYWPxdX5BFtMxUVdk1tgnh1+rrDyPXT0YbImd6BOXt6RNgH9xyprCHG7so4lIgR9qo2hysBEGit7mRuEiyrgyhLY0vhxQqpzJ5xcAYLBxrxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=wZ2SUwZT; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 917151F9C8;
	Wed,  3 Jul 2024 12:00:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1720000857;
	bh=UZB7vKNvk9EzHbC+viEOoK/8xOvWR8i2ClJAslwI80w=; h=From:To:Subject;
	b=wZ2SUwZT23FyFNyJn+aw8MzK0uE/iFWBdtZ8C6JzvSN4a7Vsxftq+12eNs38SYakr
	 7L1nhY9h656D9EMB/cvC0wpGGhDdrjJ+H1TvMlj5kO1Pq46FIlAHat/qSz4UQD4rGJ
	 KYY+V01IqOtyUpM11ugPrNEkXt7JRSykK7auWRi/lneWtJZyNH5ye8GOjnmcnBsWsz
	 vd1JjmnPz8SV212pqCIs932epbgLlfFulR1WQtsVVVnqHDRvuhysQYx27VW1ruzkGW
	 HjiLrvFe+m/g5355+W2LZts4x7y6abTkhmokCzsDMul7pnIxXdB2TKpV5tqPx+uEfW
	 qtHFdpesanGAw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v1 0/2] PCI: ti: k3: Fix TI J721E PERST# polarity
Date: Wed,  3 Jul 2024 12:00:34 +0200
Message-Id: <20240703100036.17896-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Fix PCIe PERST# signal polarity in TI J721E used on TI K3 machines.

PCIe PERST# needs to be de-asserted for PCIe to work, however, the driver is
doing the opposite and the device tree files are defining the signal with the
wrong polarity to cope with that. Fix both the driver and the affected DT
files.

Emanuele Ghidoli (2):
  arm64: dts: ti: Mark PCIe PERST# polarity active low in DT
  PCI: j721e: Fix PERST# polarity

 arch/arm64/boot/dts/ti/k3-am642-evm.dts                  | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts | 2 +-
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-sm.dts | 2 +-
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts         | 2 +-
 arch/arm64/boot/dts/ti/k3-am69-sk.dts                    | 6 +++---
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts    | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts       | 2 +-
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts    | 6 +++---
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                   | 4 ++--
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts   | 2 +-
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts                  | 2 +-
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts                 | 4 ++--
 drivers/pci/controller/cadence/pci-j721e.c               | 4 ++--
 13 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.39.2


