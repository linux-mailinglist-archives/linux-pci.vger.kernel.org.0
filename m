Return-Path: <linux-pci+bounces-30074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93884ADF117
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 17:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229243AD741
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 15:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5062EF640;
	Wed, 18 Jun 2025 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SaGB99ZF"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A2D2EBDEF;
	Wed, 18 Jun 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260092; cv=none; b=eP0fRNdW8GjvHyNWigZLd2OZTiHV2GpEVXZUhhYshYT4z3qELb/v2TcBE4zmNHSlSFbRdCFjqLg+fJb4fko9pt1W4IermP7dtdQdXV5u30fwpitxFx9wMdpv1YBeIjF4b90PXQZX4yYg9SEM3fpfgZTNgLioCTZL2kjJKszk3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260092; c=relaxed/simple;
	bh=H4SxOVHWpA+WytbY1ys3zjD433bGw9LydkjAUxEM9tA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r7Jh3GexUV4lTdBsHQ0JUJvq0aVPVBi0dwXg0qIF/Lph58aticpLbocGutD/docyOj1OhAGRfQL6ZhJhGmsFAJhynOnmBh7J9inrDMLLO6gu/9VJl62nqOc/6pKwP8hAYF19Hsz5Zydgk92hC7WFqhZMYQJ1zeQRXtk0oJaaRlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SaGB99ZF; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9m
	NC5p+IQWFHt/xuo/+vFezWiDfgz67e96tYDM0ksBc=; b=SaGB99ZFFOAu6jAaXd
	0NekQG/1FAbUCGHU2ZnFEAJFrEhWn2+yCR638jjUsYmaFOyRQ2LCzasaSu5Y49VO
	hkjrUjEPSQdg4g/qLrPzGwWe0mo2bJDUx6yV9GG+bCZzsECR62Zpqrys2tjWMFJX
	5r2yC/XLhaB1ofH2ltITvkhbg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDHoedq2VJo3qQFAQ--.15407S2;
	Wed, 18 Jun 2025 23:21:15 +0800 (CST)
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
Subject: [PATCH v2 00/13] PCI: dwc: Refactor register access with dw_pcie_clear_and_set_dword helper
Date: Wed, 18 Jun 2025 23:20:59 +0800
Message-Id: <20250618152112.1010147-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHoedq2VJo3qQFAQ--.15407S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1kJFW8ZF47Zr1rAw13urg_yoW5uryrpa
	y5tFW2kF1xJrZY93ZrXa929r1Yy3Z5AFZrKan3Ka4IgFy3CF9Fqry5tryft347GrWjqF12
	kr1Utayxu3Z3AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piq2NLUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxdwo2hS1CZ5SwABs8

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
 drivers/pci/controller/dwc/pcie-tegra194.c    | 155 ++++++++----------
 16 files changed, 239 insertions(+), 350 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.25.1


