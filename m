Return-Path: <linux-pci+bounces-38973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 328C6BFB41F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 11:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C904450416B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5715E31DD98;
	Wed, 22 Oct 2025 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kJd3rLOl"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F831B13C;
	Wed, 22 Oct 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127070; cv=none; b=n0IsnvEkUdY8blfZi+FSf7gJh2ocT4p6wD7PcNbQKGCkBUHkASrGnGpcz5wassFtIJWvFfQZGJjUjYwo0eA4zyuzx32sACY+UiZF1GMV0wQReSaszWPs1K4/FSaYsJjqv1u+v/ztEXj9M1kKV8l/nwKLFtRAS2xxWXG63v1i8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127070; c=relaxed/simple;
	bh=4Y+D80iSt9jpECU5J61hwIKVS1QvaZTv8PlOVYO3NPo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YG3Kq1Ov/V4CH4Q9kAlSjNRKuEvwSA/mZFO7WIJgBNqYh8slrnN0a5J0LaawfPeNKF4+nx8rC4WCZjxb7H/tKkWPAejXs0Wiq+WJC7UmY8PHInmgjefrTA/mDPcCBoviluuDSsiZykCxgdBrYlSUdDq36EFuo8b3EvQKbqLKFKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kJd3rLOl; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59M9vMZ81387139;
	Wed, 22 Oct 2025 04:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761127042;
	bh=p5zzKjVDjdZgk+qCBL/BN7PWbaszOVdrduoIeN0+Bas=;
	h=From:To:CC:Subject:Date;
	b=kJd3rLOlaBNbaS2ejmkek5WmleeL2c812cu0a+FGJYL8WOHf/C0vlz/umDhXisRmL
	 81hCCUv8XtrSJqV5Gg3n3jXJHhcw26VOqqTgJt5HxchXggwetf4+eX00a58HWptDnI
	 0mp+82YRvA/dWddubfsBttGT/6HPhIyJOl7bejv4=
Received: from DFLE204.ent.ti.com (dfle204.ent.ti.com [10.64.6.62])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59M9vMYX2266279
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Oct 2025 04:57:22 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 04:57:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 04:57:22 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59M9vFcV1029418;
	Wed, 22 Oct 2025 04:57:16 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <quic_wenbyao@quicinc.com>, <inochiama@gmail.com>,
        <mayank.rana@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
        <shradha.t@samsung.com>, <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>, <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 0/4] PCI: Keystone: Enable loadable module support
Date: Wed, 22 Oct 2025 15:27:08 +0530
Message-ID: <20251022095724.997218-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello,

This series enables support for the 'pci-keystone.c' driver to be built
as a loadable module. The motivation for the series is that PCIe is not
a necessity for booting Linux due to which the 'pci-keystone.c' driver
does not need to be built-in.

Series is based on 6.18-rc1 tag of Mainline Linux.

DEPENDENCY
----------
This series has __NO__ dependencies since the dependencies stated in the
cover-letter of the v3 series at:
https://lore.kernel.org/r/20250922071222.2814937-1-s-vadapalli@ti.com/
have been satisfied.

v3:
https://lore.kernel.org/r/20250922071222.2814937-1-s-vadapalli@ti.com/
Changes since v3:
- Rebased series on 6.18-rc1 tag of Mainline Linux.
- Patch 4 has been updated to remove the '__init' keyword from functions
  to avoid triggering an exception due to '__init' memory being freed
  before functions are invoked. This is the equivalent of:
  https://lore.kernel.org/r/20250912100802.3136121-3-s-vadapalli@ti.com/
  while addressing Bjorn's feedback at:
  https://lore.kernel.org/r/20251002143627.GA267439@bhelgaas/
  by introducing a new 'init' function specifically for registering the
  fault handler while the rest of the driver remains the same.

Series has been tested on AM654-EVM with an NVMe SSD connected to the
PCIe Connector of the EVM. Test Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/332e8d65c66ed93e95c2d89ec1ee3f68

Regards,
Siddharth.

Siddharth Vadapalli (4):
  PCI: Export pci_get_host_bridge_device() for use by pci-keystone
  PCI: dwc: Export dw_pcie_allocate_domains() and
    dw_pcie_ep_raise_msix_irq()
  PCI: keystone: Exit ks_pcie_probe() for invalid mode
  PCI: keystone: Add support to build as a loadable module

 drivers/pci/controller/dwc/Kconfig            |  6 +--
 drivers/pci/controller/dwc/pci-keystone.c     | 38 +++++++++++++------
 .../pci/controller/dwc/pcie-designware-ep.c   |  1 +
 .../pci/controller/dwc/pcie-designware-host.c |  1 +
 drivers/pci/host-bridge.c                     |  1 +
 include/linux/pci.h                           |  1 +
 6 files changed, 33 insertions(+), 15 deletions(-)

-- 
2.51.0


