Return-Path: <linux-pci+bounces-30781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF1DAEA20D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 17:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098881891CA7
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01482FCFE0;
	Thu, 26 Jun 2025 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JRj1rGyz"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E182F0021;
	Thu, 26 Jun 2025 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949536; cv=none; b=vAg17H8r3NjSUAYew4H/qnH9sdXm1k1HZpyoDGZ20qVHNONb544Z4BNcf5l4nJF2R5oWIReFbSgQzvwmXUsAnHn/8HdauwZgk3K2K769wL0nvvVe1FTy9a7eNnCv95hXjn6KYidXz57T12HklC+6W8Hps2mOMMpHeVProS2pmjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949536; c=relaxed/simple;
	bh=IINQXdddsv9v8OFzqdfK6OuldBkZzVjxdjRhoD5PohM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O+Xo0SH7fhONrT4e9ysiaYYappvhCklV5Wr+c9Qx+Js6J2gXRbLRFvb1rpUs/RrbCgBcVhkaKba1zVaBGE+YcR8MG5XHVyw6FyMBj0BPlp55DhqfYcfV5BFJb/Y2iZGmZS9m7yNUCcJlxgPWCp2oEJ39WkMRhmF5gggB38rf/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JRj1rGyz; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aQ
	K4/iwHnDi8KtZvqXcjHjQQy/mgawTfVJdbK7fzM6U=; b=JRj1rGyzvtpO+/K/D5
	iSHqHBn2fTIx/ilWPPsYR++NpRJ817SO5nrfwTaJBbMnM7ZhBf0xn1BdX9QRuOD2
	Nrm5/snRxMIZBa/pyuQNQVAxOnjf64c5tG/S1a7q3DS0h0/zIT49uaOj5LqRPjHy
	HjvK3XyvcQkE7oLSi8SO52YiQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDn7zyJXl1o5R7ZAg--.58392S2;
	Thu, 26 Jun 2025 22:51:54 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 00/13] PCI: dwc: Refactor register access with dw_pcie_clear_and_set_dword helper
Date: Thu, 26 Jun 2025 22:50:27 +0800
Message-Id: <20250626145040.14180-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7zyJXl1o5R7ZAg--.58392S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1kJFW8ZF47Zr1rAw13urg_yoW5Kryxpa
	y5tFW2kF1xJrs093ZrXa9a9r1Yy3Z3ArZrGFs7K34IgFy3CFyqqryrtryft347GrWjqr12
	kr1Utayxuwn3JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piBWlDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxp4o2hdWY1vkgABsH

Register bit manipulation in DesignWare PCIe controllers currently
uses repetitive read-modify-write sequences across multiple drivers.
This pattern leads to code duplication and increases maintenance
complexity as each driver implements similar logic with minor variations.

This series introduces dw_pcie_clear_and_set_dword() to centralize atomic
register modification. The helper performs read-clear-set-write operations
in a single function, replacing open-coded implementations. Subsequent
patches refactor individual drivers to use this helper, eliminating
redundant code and ensuring consistent bit handling.

The change reduces overall code size by ~350 lines while improving
maintainability. Each controller driver is updated in a separate
patch to preserve bisectability and simplify review.

---
Hi all,

At the beginning, two patches were made, 0001*.patch, and the others were
one patch. After consideration, I still split the patches. If splitting
is not necessary, I will recombine them into two patches in future
versions.


Changes for v3:
- patch 0002: s/u32 val = 0;/u32 val; (pcie-designware-debugfs.c -> set_event_number())
- patch 0013: Remove several val = 0. (Mani)
- patch 0013: s/PCIE_PL_CHK_REG_CONTROL_STATUS/0. (Error in copying the code.) (Mani)

Changes for v2:
- Re-send it in the company environment so that the entire patch series is in the 00/13 cover letter. (Bjorn)
- Modify the subject. (Bjorn and Frank)
---

Hans Zhang (13):
  PCI: dwc: Add dw_pcie_clear_and_set_dword() for register bit
    manipulation
  PCI: dwc: Refactor code by using dw_pcie_clear_and_set_dword()
  PCI: dra7xx: Refactor code by using dw_pcie_clear_and_set_dword()
  PCI: imx6: Refactor code by using dw_pcie_clear_and_set_dword()
  PCI: meson: Refactor code by using dw_pcie_clear_and_set_dword()
  PCI: armada8k: Refactor code by using dw_pcie_clear_and_set_dword()
  PCI: bt1: Refactor code by using dw_pcie_clear_and_set_dword()
  PCI: dw-rockchip: Refactor code by using dw_pcie_clear_and_set_dword()
  PCI: fu740: Refactor code by using dw_pcie_clear_and_set_dword()
  PCI: qcom: Refactor code by using dw_pcie_clear_and_set_dword()
  PCI: qcom-ep: Refactor code by using dw_pcie_clear_and_set_dword()
  PCI: rcar-gen4: Refactor code by using dw_pcie_clear_and_set_dword()
  PCI: tegra194: Refactor code by using dw_pcie_clear_and_set_dword()

 drivers/pci/controller/dwc/pci-dra7xx.c       |  10 +-
 drivers/pci/controller/dwc/pci-imx6.c         |  26 ++-
 drivers/pci/controller/dwc/pci-meson.c        |  22 +--
 drivers/pci/controller/dwc/pcie-armada8k.c    |  48 ++----
 drivers/pci/controller/dwc/pcie-bt1.c         |   5 +-
 .../controller/dwc/pcie-designware-debugfs.c  |  67 +++-----
 .../pci/controller/dwc/pcie-designware-ep.c   |  20 +--
 .../pci/controller/dwc/pcie-designware-host.c |  27 ++-
 drivers/pci/controller/dwc/pcie-designware.c  |  74 ++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |  27 +--
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |   7 +-
 drivers/pci/controller/dwc/pcie-fu740.c       |   5 +-
 drivers/pci/controller/dwc/pcie-qcom-common.c |  59 ++++---
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  14 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  23 +--
 drivers/pci/controller/dwc/pcie-tegra194.c    | 157 +++++++-----------
 16 files changed, 239 insertions(+), 352 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.25.1


