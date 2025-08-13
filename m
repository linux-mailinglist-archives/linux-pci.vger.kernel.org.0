Return-Path: <linux-pci+bounces-33913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0791EB23FC8
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982EA189F5AD
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37EE2980A8;
	Wed, 13 Aug 2025 04:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ExX1Pt2z"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CBA1922FB;
	Wed, 13 Aug 2025 04:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755060351; cv=none; b=rj4ouCtg7jyUcUSNeFaO7f7vMr74oVf9qtxf3DJ4b0OByMvjKjwhDdk32ZpuFJSHI7VzOafTigzj4o8FEqEpVYjT62P1CRfKn7RZzJr6InyBcFvMNZceDg2kSe4zIDMKg8xV7kWAcenXzNb3f6lbm4tKVCaH4o8EImxTCLYYPUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755060351; c=relaxed/simple;
	bh=4D16ckHsCI6f9VJDGaCX5efX+aFNJp2qg7K9dcx9Aho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cjnKgHtjO9uZGiBHEthLyXKa+BSig/QSIkzsJcRtCNU4NZWiSBoRpP6sDUCkmIl3HFbwYB5DKBpeVh5d9xJlFht7K/v0pGWw9kGitdntpM7A2rPfv2TahEydYGmLtGfG1aBYQ9OptbBVe8qti9bnZPC75qOHgSQos4bpT7FijhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ExX1Pt2z; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=cC
	x19TelBHXMpEu0YblsMsh+7ZnKxfp6szt8ia2Ykj0=; b=ExX1Pt2zy3CRdW49QW
	Dt6FlVKMVV+gJwYPFPRWktd7FZtC9utjbFXj/aVhpcK4RfjsfzZqg+iEBrBmcGKT
	eHhL/paO93IZM5VE4z+UFuBbd8rJ8GYp7MtHAVKypu+ScqziILSTvEUFAp3Jyj6g
	BP8huNU8+oMA8/cwqBSKI1znk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3ErhtGJxo3nYVAA--.2375S2;
	Wed, 13 Aug 2025 12:45:34 +0800 (CST)
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
Subject: [PATCH v4 00/13] PCI: dwc: Refactor register access with dw_pcie_clear_and_set_dword helper
Date: Wed, 13 Aug 2025 12:45:18 +0800
Message-Id: <20250813044531.180411-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3ErhtGJxo3nYVAA--.2375S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1kJFW8ZF47Zr1rAw13urg_yoW5KF43pa
	y5tFW2kF1xJrs093ZrXa929r1Yy3Z3AFZrGrs7K34IqFy3CFyqqryrtryrt347GrWjqF12
	kr1Utayxuwn3JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piKLvZUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxyoo2icD7TgfwAAsE

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


Changes for v4:
- Rebase to v6.17-rc1

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
 .../controller/dwc/pcie-designware-debugfs.c  |  66 +++-----
 .../pci/controller/dwc/pcie-designware-ep.c   |  20 +--
 .../pci/controller/dwc/pcie-designware-host.c |  26 +--
 drivers/pci/controller/dwc/pcie-designware.c  |  75 ++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |  27 +--
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |   7 +-
 drivers/pci/controller/dwc/pcie-fu740.c       |   5 +-
 drivers/pci/controller/dwc/pcie-qcom-common.c |  59 ++++---
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  14 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  23 +--
 drivers/pci/controller/dwc/pcie-tegra194.c    | 158 +++++++-----------
 16 files changed, 239 insertions(+), 352 deletions(-)


base-commit: 53e760d8949895390e256e723e7ee46618310361
-- 
2.25.1


