Return-Path: <linux-pci+bounces-6234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F54B8A49D7
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 10:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B622285E58
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36C72E645;
	Mon, 15 Apr 2024 08:11:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1792D054;
	Mon, 15 Apr 2024 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168704; cv=none; b=cynaCrzntgeHlWSKVTrgaTEl1lWB87/uhImNcjhSHAW/d4O+2PBi6Bb0Ho8dtr5LC0AriDKJy5Vy2RHX8VXkhRqic9tJQ/6WVNEQJuDQum/ipcEqQJ50ze3K9xbsFq+eATmwCzOqzH+2Oifa0xbb6A3u6XqOlwtmi+uQ/Tiv+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168704; c=relaxed/simple;
	bh=VqNTuQfKvyh49sn45VsMPW0/r9/45lZIiwTJ6IFKtM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jt+iE7Yw1NNhN2YX5r65eWNnwjybG3pCoqPq9MAi5ORG3QC2p5PZoeQfJ62eRwZCLkxSrwyVsO/J7HNZfVwZqqHrtDccc+knukCQE3+HgvDIAjtA72NjSA2ssihenzLQilST1A+dsA7w9JWxPdVSfh3nXB9ejfUPVKR0rSvYhOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.07,202,1708354800"; 
   d="scan'208";a="205421235"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Apr 2024 17:11:41 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3F7DB400C092;
	Mon, 15 Apr 2024 17:11:41 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v7 0/7] PCI: rcar-gen4: Add R-Car V4H support
Date: Mon, 15 Apr 2024 17:11:28 +0900
Message-Id: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pcie-rcar-gen4 driver can reuse other R-Car Gen4 support like
r8a779g0 (R-Car V4H) and r8a779h0 (R-Car V4M). However, some
initializing settings differ between R-Car S4-8 (r8a779f0) and
others. The R-Car S4-8 will be minority about the setting way. So,
R-Car V4H will be majority and this is generic initialization way
as "renesas,rcar-gen4-pcie{-ep}" compatible.

About the firmware downloading, we can get information from
the following wiki page:
https://elinux.org/index.php?title=R-Car/Boards/WhiteHawk&oldid=581944#PCIe_firmware

For now, I tested both R-Car S4-8 and R-Car V4H on this driver.
I'll support one more other SoC (R-Car V4M) in the future.

Changes from v6:
https://lore.kernel.org/linux-pci/20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com/
- Add Manivannan's Reviewed-by in patch [37]/7.
- Rename a struct from "platdata" to "drvdata" in patch [4/7].
- Revise the commit descriptions in patch [456]/7.
- Rename some functions in patch 6/7.
- Fix the return value of an error path in patch 6/7.

Changes from v5:
https://lore.kernel.org/linux-pci/20240408012458.3717977-1-yoshihiro.shimoda.uh@renesas.com/
- Drop "dwc: " prefixes from the subjects in patch [0456]/7.

Changes from v4:
https://lore.kernel.org/linux-pci/20240403053304.3695096-1-yoshihiro.shimoda.uh@renesas.com/
- Fix compatible string for renesas,r8a779f0-pcie-ep which was described
  accidentally from v3...

Yoshihiro Shimoda (7):
  dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4H compatible
  dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4H compatible
  PCI: dwc: Add PCIE_PORT_{FORCE,LANE_SKEW} macros
  PCI: rcar-gen4: Add rcar_gen4_pcie_drvdata
  PCI: rcar-gen4: Add .ltssm_enable() for other SoC support
  PCI: rcar-gen4: Add support for r8a779g0
  misc: pci_endpoint_test: Document a policy about adding pci_device_id

 .../bindings/pci/rcar-gen4-pci-ep.yaml        |   4 +-
 .../bindings/pci/rcar-gen4-pci-host.yaml      |   4 +-
 drivers/misc/pci_endpoint_test.c              |   1 +
 drivers/pci/controller/dwc/pcie-designware.h  |   6 +
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 272 +++++++++++++++++-
 5 files changed, 270 insertions(+), 17 deletions(-)

-- 
2.25.1


