Return-Path: <linux-pci+bounces-5581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B544F896413
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 07:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636D4284DD7
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 05:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A271046537;
	Wed,  3 Apr 2024 05:33:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA2A46425;
	Wed,  3 Apr 2024 05:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712122394; cv=none; b=pPHgBFFyGstXm539+8PAVOTpfvYWEZeGwftcb+uB1/E0gRj3OpBtlDGEc7PW+sCIe173nBlSMryVotglhJxjqdiygZ4zZsC2D/pPNuUeWPhcVPgsnM/SkN9gpwKJS8lYcElZtCPaRAJlFfiP6zoTkZJiJADNhEgWe8MnBqoFmeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712122394; c=relaxed/simple;
	bh=xDhXjAvXqTCmcUrvtexn41JXCf26s2FR6f/j30L6SMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D8lkB65uKNj6g2eks6A+u7YcemIa50aHYpGPj760B+z8ieE7KM8k4HbRJ7D1myvWnwdf8wxsRTW0Q5XLBPVIjyHe2zXCCJ7Tfr5Mh1TqNMzoEuFDyHdm1QNwZ41ytZ+Pc+NfIugK6EN78pjF5Jw9PrEg4QIPRPPrNp0jYe8kbbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.07,176,1708354800"; 
   d="scan'208";a="204148816"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Apr 2024 14:33:08 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 84059400296A;
	Wed,  3 Apr 2024 14:33:08 +0900 (JST)
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
Subject: [PATCH v4 0/7] PCI: dwc: rcar-gen4: Add R-Car V4H support
Date: Wed,  3 Apr 2024 14:32:57 +0900
Message-Id: <20240403053304.3695096-1-yoshihiro.shimoda.uh@renesas.com>
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
as "renesas,rcar-gen4-pcie{-ep}" compatible. For now, I tested
both R-Car S4-8 and R-Car V4H on this driver. I'll support one more
other SoC (R-Car V4M) in the future.

Changes from v3:
https://lore.kernel.org/linux-pci/20240401023942.134704-1-yoshihiro.shimoda.uh@renesas.com/
- Modify the code to use "do .. while" instead of goto in patch 6/7.

Changes from v2:
https://lore.kernel.org/linux-pci/20240326024540.2336155-1-yoshihiro.shimoda.uh@renesas.com/
- Add a new patch which just add a platdata in patch 4/7.
- Modify the subjects in patch [56]/7.
- Modify the description and code about Bjorn's comment in patch [56]/7.
- Add missing MODULE_FIRMWARE(9 in patch 6/7.
- Document a policy aboud adding pci_device_id instead of adding r8a779g0's id
  in patch 7/7.

Changes from v1:
https://lore.kernel.org/linux-pci/20240229120719.2553638-1-yoshihiro.shimoda.uh@renesas.com/
- Based on v6.9-rc1.
- Add Acked-by and/or Reviewed-by in patch [126/6].

Yoshihiro Shimoda (7):
  dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4H compatible
  dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4H compatible
  PCI: dwc: Add PCIE_PORT_{FORCE,LANE_SKEW} macros
  PCI: dwc: rcar-gen4: Add rcar_gen4_pcie_platdata
  PCI: dwc: rcar-gen4: Add .ltssm_enable() for other SoC support
  PCI: dwc: rcar-gen4: Add support for r8a779g0
  misc: pci_endpoint_test: Document a policy about adding pci_device_id

 .../bindings/pci/rcar-gen4-pci-ep.yaml        |   4 +-
 .../bindings/pci/rcar-gen4-pci-host.yaml      |   4 +-
 drivers/misc/pci_endpoint_test.c              |   1 +
 drivers/pci/controller/dwc/pcie-designware.h  |   6 +
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 272 +++++++++++++++++-
 5 files changed, 270 insertions(+), 17 deletions(-)

-- 
2.25.1


