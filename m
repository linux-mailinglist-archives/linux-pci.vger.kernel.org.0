Return-Path: <linux-pci+bounces-34769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D052DB370DB
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 19:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8899E366FDC
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 17:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F032E2DFE;
	Tue, 26 Aug 2025 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cgz855Pn"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5392E1EFF;
	Tue, 26 Aug 2025 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227837; cv=none; b=Mfjf/qMHsW0g/yDfn9Evwhyy4tj07coUIxX+5jRh9fxsObXZIZKMTf1TpyD2yDVcf5emBRlZ1eObxkRT6qnfn2Jol1fTiZ4jDRKFnHHTSAddTX0vOvhCFuA8g6kd8EY+l/I2aWoZIm3ffXz/dk9Gdsr9H/lOh6h7EwfGFrV11To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227837; c=relaxed/simple;
	bh=C7vIGge6pWneUbN6NxFvop7zonf4Uq/iHHHVE4CMRP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tNzLD0NQ0bgbZiRzUWdbxm6ddPIeAmk7v3VN7ZxBo9jPrCpa+drJpq90wDXXKShWRWk5vLGueoS94OfjYk8LDPOGh6hpeJVLXgDKefm/T/fBZ/RlxAbSfv2Hz2M53Soc9Fl8EjmyJAohmjcM/uY4H+/GLASWKyNKSOAscEsdi5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cgz855Pn; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GY
	0fQwBZFV53gDtniXYPAseyh8Wgc5jwrqG1OowGqM8=; b=cgz855PnX4zFzSKpZY
	cLRY+LCLHyiubjWz32jViB0fL7xI1l1tQaMisC/abaVGHXn8L/KCAao4rYr184T9
	VYPpCgiNeiuX46V1FDE7J3tIYLBp4+XR/swKT3Jphk5+2OSwkaYcBcRSuhK1f7XO
	JAH0br5u4QrEBJ7WgvxAdv+nY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH5Svt6K1o9DIiEg--.25085S2;
	Wed, 27 Aug 2025 01:03:41 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 0/8] PCI: Replace short msleep() calls with more precise delay functions
Date: Wed, 27 Aug 2025 01:03:07 +0800
Message-Id: <20250826170315.721551-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH5Svt6K1o9DIiEg--.25085S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFykZw1UXF4xJw4DCw4rXwb_yoW8Cw4DpF
	W5Gan0yF4xJFW3Ca1xuayxuFy5ZFs3AFWjgrZ3G34a9anxZ3WYqF4fKr1rAFyjgrW0q3Zr
	ur1ak3WxAayjyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pic_-kUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxO1o2it3wnvHQABs+

This series improves code readability and maintainability in the PCI
subsystem by replacing hard-coded delay values with descriptive macros.

The changes include:
- Adding macros for various delay values used in PCI operations
- Replacing msleep(2) with fsleep(2000) for precise secondary bus reset
- Keeping the same delay values but using macros for better documentation

These changes make the code easier to understand and maintain, while
ensuring that the timing requirements specified in the PCIe r7.0
specification are met.

---
Changes for v3:
https://patchwork.kernel.org/project/linux-pci/cover/20250822155908.625553-1-18255117159@163.com/

- According to Bjorn's suggestion, split the first patch of v2 and add
  macro definitions to the remaining patches.

Changes for v2:
https://patchwork.kernel.org/project/linux-pci/patch/20250820160944.489061-1-18255117159@163.com/

- According to the Maintainer's suggestion, it was modified to fsleep,
  usleep_range, and macro definitions were used instead of hard code. (Bjorn)
---
Hans Zhang (8):
  PCI: Add macro for secondary bus reset delay
  PCI: Replace msleep with fsleep for precise secondary bus reset
  PCI: Add macro for link status check delay
  PCI: rcar-host: Add macro for speed change monitoring delay
  PCI: brcmstb: Add macro for link up check delay
  PCI: rcar: Add macro for PHY ready check delay
  PCI: pciehp: Add macros for hotplug operation delays
  PCI/DPC: Add macro for RP busy check delay

 drivers/pci/controller/pcie-brcmstb.c   |  4 +++-
 drivers/pci/controller/pcie-rcar-host.c |  4 +++-
 drivers/pci/controller/pcie-rcar.c      |  4 +++-
 drivers/pci/hotplug/pciehp_hpc.c        |  7 +++++--
 drivers/pci/pci.c                       | 11 +++++------
 drivers/pci/pci.h                       |  3 +++
 drivers/pci/pcie/dpc.c                  |  4 +++-
 7 files changed, 25 insertions(+), 12 deletions(-)


base-commit: fab1beda7597fac1cecc01707d55eadb6bbe773c
-- 
2.25.1


