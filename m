Return-Path: <linux-pci+bounces-4247-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9E986C8C8
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 13:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2521F2418F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 12:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486B07CF1C;
	Thu, 29 Feb 2024 12:07:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028A27CF05;
	Thu, 29 Feb 2024 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208454; cv=none; b=YORHhdbEYQP8oqAh36USskeZtKkZUhz/Fa+6MZxu//uWX/ppEIl/kSsSAMePnO+e5QnVZnIiBU6tjfxrpGbxS9F2yiPW3H96z6KYgtpvwGW3DJfV74eqe7lo7nf+0LaHpP434HE+JEA5WNfu685nJHabdMjevYLqhMikMRgfXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208454; c=relaxed/simple;
	bh=n7APBsPsInPrwEJdT1KvDSGQ+AFtmzx/CXPF1TCL1Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oHgaXZrbRpDTps0CTM3VtKzQEfNRRWe4IwLgO00V3vFbdPCjzWGzPMfccDy0C9orx/O5GGxN5NOnEX+XIfo1TRa8m8bxJAWnCER8RGQ5VGD+J+u+8tzt3iMGzPc/48ttFrDhkou9WxELV1IfkEAWWeyb5SJaBCM75LmDDdFT7ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.06,194,1705330800"; 
   d="scan'208";a="195830391"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Feb 2024 21:07:24 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0CDBA40031D4;
	Thu, 29 Feb 2024 21:07:24 +0900 (JST)
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
Subject: [PATCH 0/6] PCI: dwc: rcar-gen4: Add R-Car V4H support
Date: Thu, 29 Feb 2024 21:07:13 +0900
Message-Id: <20240229120719.2553638-1-yoshihiro.shimoda.uh@renesas.com>
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


