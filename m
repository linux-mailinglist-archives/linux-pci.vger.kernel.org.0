Return-Path: <linux-pci+bounces-5141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219A988B79F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 03:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AAF1F39279
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 02:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2243B12838D;
	Tue, 26 Mar 2024 02:51:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07985788E;
	Tue, 26 Mar 2024 02:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421469; cv=none; b=bkTvSkXBA+BwBMh4a8vp7Jsg8CAvrz6STJX5M5GjCy/RAsfMlUPIAw0UIFVc24y3aoPhPBrxp+0S6Ggq5+Jc/W+ORdoUxtj3xPkSsAnhxgpxC+k26WEZ5OK5/0c9Z7WEAxgLNGUydGIWzuitCdBHcGEXYd37kHYrZqLhPjmVywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421469; c=relaxed/simple;
	bh=RJdaASWxTwasvt7M/bMkENnG7NjMLJF5n+NQ1XSlHIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iDgS/zIQT3evP1/vWNEOaj0jSMvhW1MGCZCzdLAg6aYOdqYm7y2jC4XxYofphcQD9FfnnAauGyHvinhngUPr/ovpBNxKnYzWBJnaP3nPbxKvOm5kA1cn09hvdAHlBNeA5B6d7OabADzUccyjIivDcGONECa690pWMYJ0rVLhaDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.07,154,1708354800"; 
   d="scan'208";a="203200839"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Mar 2024 11:45:57 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6D8A7415DFB8;
	Tue, 26 Mar 2024 11:45:57 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com,
	mani@kernel.org
Cc: marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 0/6] PCI: dwc: rcar-gen4: Add R-Car V4H support
Date: Tue, 26 Mar 2024 11:45:34 +0900
Message-Id: <20240326024540.2336155-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pcie-rcar-gen4 driver can reuse other R-Car Gen4 support. However,
some initializing settings differs between R-Car S4-8 (r8a779f0) and
others. The R-Car S4-8 will be minority about the setting way. So,
R-Car V4H will be majority and this is generic initialization way
as "renesas,rcar-gen4-pcie{-ep}" compatible. For now, I tested
both R-Car S4-8 and R-Car V4H on this driver. I'll support one more
other SoC (R-Car V4M) in the future.

Changes from v1:
https://lore.kernel.org/linux-pci/20240229120719.2553638-1-yoshihiro.shimoda.uh@renesas.com/
- Based on v6.9-rc1.
- Add Acked-by and/or Reviewed-by in patch [126/6].

Yoshihiro Shimoda (6):
  dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4H compatible
  dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4H compatible
  PCI: dwc: Add PCIE_PORT_{FORCE,LANE_SKEW} macros
  PCI: dwc: rcar-gen4: Add a new function pointer for other SoC support
  PCI: dwc: rcar-gen4: Add support for other R-Car Gen4 PCIe controller
  misc: pci_endpoint_test: Add Device ID for R-Car V4H PCIe controller

 .../bindings/pci/rcar-gen4-pci-ep.yaml        |   4 +-
 .../bindings/pci/rcar-gen4-pci-host.yaml      |   4 +-
 drivers/misc/pci_endpoint_test.c              |   4 +
 drivers/pci/controller/dwc/pcie-designware.h  |   6 +
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 245 +++++++++++++++++-
 5 files changed, 255 insertions(+), 8 deletions(-)

-- 
2.25.1


