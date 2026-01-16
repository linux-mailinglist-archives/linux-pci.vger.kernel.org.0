Return-Path: <linux-pci+bounces-45036-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D566D30211
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 12:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF3F9305D9B7
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 11:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E6323EAB0;
	Fri, 16 Jan 2026 11:07:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2583A34EF06;
	Fri, 16 Jan 2026 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768561647; cv=none; b=DtmBMJ4AFvS5d9/1/L4DWg3/WqN6++KBa7RbtefP0pLFUsUKfmgi2Hn8DiKUta+6C9aoM5fnSv+xroKunH2utebuxhdYHCItMZFQOnZdWl5x5JUFex9DqcxeZ6S0ueIXpUOGLEkSsmmwxRCTrE2lu/ezmyhlRD9PstEJGVrRvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768561647; c=relaxed/simple;
	bh=6DoUbnO4ABW1lXdTi+sz5elr5Hyv/koKCXJLA+cqV9o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AnJV6kt4R6XJyFmetfLE/Cfe/KQyCFC1zkwWCAqIhnwJmF7ELj3XldVhLe7gmqHGT98dwUTu7ua04A0xSw7mdjTZzC4NVXkrLaWYrYoGbzQi2QpxmCjRkhwEBc6IjnmpfDAvTictgGkYxtZpUbIIjsC1fw9MTj40x8bb+jO6E1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 60GB2fnv031253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Fri, 16 Jan 2026 19:02:41 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Jan
 2026 19:02:40 +0800
From: Randolph <randolph@andestech.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alex@ghiti.fr>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ben717@andestech.com>, <inochiama@gmail.com>,
        <thippeswamy.havalige@amd.com>, <namcao@linutronix.de>,
        <shradha.t@samsung.com>, <pjw@kernel.org>,
        <christian.bruel@foss.st.com>, <quic_wenbyao@quicinc.com>,
        <vincent.guittot@linaro.org>, <elder@riscstar.com>,
        <s-vadapalli@ti.com>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH v10 0/4]  Add support for Andes Qilai SoC PCIe controller
Date: Fri, 16 Jan 2026 19:02:30 +0800
Message-ID: <20260116110234.1908263-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 60GB2fnv031253

Add support for Andes Qilai SoC PCIe controller

These patches introduce driver support for the PCIe controller on the
Andes Qilai SoC.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
Changes in v10:
- Use "qilai" instead of "andes" as the tag

Changes in v9:
- Drop the patch that adjusts the number of OB/IB windows.
- Made minor adjustments based on the reviewer's suggestions.

Changes in v8:
- Fix the compile error reported by the kernel test robot.

Changes in v7:
- Remove unnecessary nodes and property in DTS bindings

Changes in v6:
- Fix typo in the logic for adjusting the number of OB/IB windows

Changes in v5:
- Add support to adjust the number of OB/IB windows in the glue driver.
- Fix the number of OB windows in the Qilai PCIe driver.
- Remove meaningless properties from the device tree.
- Made minor adjustments based on the reviewer's suggestions.

Changes in v4:
- Add .post_init callback for enabling IOCP cache.  
- Sort by vender name in Kconfig 
- Using PROBE_PREFER_ASYNCHRONOUS as default probe type.
- Made minor adjustments based on the reviewer's suggestions.

Changes in v3:
- Remove outbound ATU address range validation callback and logic.
- Add logic to skip failed outbound iATU configuration and continue.
- Using PROBE_PREFER_ASYNCHRONOUS as default probe type.
- Made minor adjustments based on the reviewer's suggestions.

Changes in v2:
- Remove the patch that adds the dma-ranges property to the SoC node.
- Add dma-ranges to the PCIe parent node bus node.
- Refactor and rename outbound ATU address range validation callback and logic.
- Use parent_bus_offset instead of cpu_addr_fixup().
- Using PROBE_DEFAULT_STRATEGY as default probe type.
- Made minor adjustments based on the reviewer's suggestions.

Randolph Lin (4):
  dt-bindings: PCI: Add Andes QiLai PCIe support
  riscv: dts: qilai: Add PCIe node into the QiLai SoC
  PCI: qilai: Add Andes QiLai SoC PCIe host driver support
  MAINTAINERS: Add maintainers for Andes QiLai PCIe driver

 .../bindings/pci/andestech,qilai-pcie.yaml    |  86 ++++++++
 MAINTAINERS                                   |   7 +
 arch/riscv/boot/dts/andes/qilai.dtsi          | 106 ++++++++++
 drivers/pci/controller/dwc/Kconfig            |  13 ++
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-andes-qilai.c | 198 ++++++++++++++++++
 6 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-andes-qilai.c

-- 
2.34.1


