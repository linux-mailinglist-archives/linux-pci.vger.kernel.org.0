Return-Path: <linux-pci+bounces-24466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259DCA6D010
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 17:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C479B1892F89
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 16:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53E41514EE;
	Sun, 23 Mar 2025 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DFNk0OEY"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8C914A0A3;
	Sun, 23 Mar 2025 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742748621; cv=none; b=q2ttI1xAmUlNV6+4NVCBy04eo9kEjNdVnHDdWpbOKyRiy6p81PZHC9yS0uL/6OnjyjXiwd1+Qg1tekyhDTmcZqHRcK45v48gefs/ByiZBlVm5uF2RjQrIBCnG4Gwjypmg6S1+tSLuCposWsTH9GNCaeqkCNqhejkzYPLZPKbl3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742748621; c=relaxed/simple;
	bh=zPOvcKeUlRXqtM1HLWr+7nnJMp2iWtlKIwbZBONKPhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ecgxmYnv2cyrgyjWTDw9AaEctfL9Q+hi5gVqCYf7NUQLNrS6qvbmN772BVS5ECBTuB7Mt6nuFVvDdjZHnW3+X1WjiwYZJcU/uWz80Dv53X9LM7olqcu/KiOLraUsOQnXLhTyVMtqqyNVj896Aj10QS5KqwZx9qCZxrC1Yl9f1O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DFNk0OEY; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Mtr/t
	9tWneDxjlXitL9L9CrnUhfQSRGTxaexGpKhaqI=; b=DFNk0OEYJt8ptsq3Vt8EN
	BXjKTi8FwtfOrRdkptE68YwPqP7eSiRdUN19IEKLC5M/kFL1+voSXfZU6TrHIzO0
	8GseOt9fMBdrRSBjesTLvavrpdtL9IGqRh4Iw7HNXNNPb44qPLjXcZ86ToXsCW6M
	rmW3nv4st6RQYKjV+Gt0SQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXX3qlO+Bnk_g8AA--.12082S2;
	Mon, 24 Mar 2025 00:49:42 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [v6 0/5] Introduce generic capability search functions
Date: Mon, 24 Mar 2025 00:48:47 +0800
Message-Id: <20250323164852.430546-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDXX3qlO+Bnk_g8AA--.12082S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar13XFW3Xw4UJr47Zr15XFb_yoW8Cw18pF
	yrGwn3CF1rJFW3Cws3Aa1Fka43X3Z7J3srJ39xKw1fXF17CFyDJrn3tFyrJFZrJws7Xr13
	ZF45JryxKFs8AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEGYLPUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxkZo2fgMeLaoQABsC

1. Introduce generic capability search functions.
2. dwc/cdns use common PCI host bridge APIs for finding the capabilities.
3. Use cdns_pcie_find_*capability to avoid hardcode.
4. Add new patch for MAINTAINERS.

Changes since v5:
- If you put the helpers in drivers/pci/pci.c, they unnecessarily enlarge
  the kernel's .text section even if it's known already at compile time
  that they're never going to be used (e.g. on x86).
- Move the API for find capabilitys to a new file called
  pci-host-helpers.c.
- Add new patch for MAINTAINERS.

Changes since v4:
- Resolved [v4 1/4] compilation warning.
- The patch subject and commit message were modified.

Changes since v3:
- Resolved [v3 1/4] compilation error.
- Other patches are not modified.

Changes since v2:
- Add and split into a series of patches.

Hans Zhang (5):
  PCI: Introduce generic capability search functions
  PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
  PCI: cadence: Use common PCI host bridge APIs for finding the
    capabilities
  PCI: cadence: Use cdns_pcie_find_*capability to avoid hardcode.
  MAINTAINERS: Add entry for PCI host controller helpers

 MAINTAINERS                                   |  6 ++
 drivers/pci/controller/Kconfig                | 17 ++++
 drivers/pci/controller/Makefile               |  1 +
 drivers/pci/controller/cadence/Kconfig        |  1 +
 .../pci/controller/cadence/pcie-cadence-ep.c  | 40 ++++----
 drivers/pci/controller/cadence/pcie-cadence.c | 25 +++++
 drivers/pci/controller/cadence/pcie-cadence.h |  8 +-
 drivers/pci/controller/dwc/Kconfig            |  1 +
 drivers/pci/controller/dwc/pcie-designware.c  | 71 +-------------
 drivers/pci/controller/pci-host-helpers.c     | 98 +++++++++++++++++++
 drivers/pci/pci.h                             |  7 ++
 11 files changed, 187 insertions(+), 88 deletions(-)
 create mode 100644 drivers/pci/controller/pci-host-helpers.c


base-commit: a1cffe8cc8aef85f1b07c4464f0998b9785b795a
-- 
2.25.1


