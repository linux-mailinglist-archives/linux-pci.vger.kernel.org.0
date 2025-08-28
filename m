Return-Path: <linux-pci+bounces-35022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61831B39F90
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 16:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBC917517D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B936522B8D0;
	Thu, 28 Aug 2025 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A2IDiQXS"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F742288EE;
	Thu, 28 Aug 2025 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389659; cv=none; b=kbejw6OAG1YtDdYv1bbteFfyVFWO43w7MSs0FUMKqhyajjZbM177Aa4RtYjvHiNCfDfZqz+xvH5Zq8LQXmoH2prpeEPCbfKeuaSI9frZeUwlq5yWgIuos3TwGqsDgVvro5QvTpP6trGGRa2NC+vGcYdvyrUStqho702a8jRv7YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389659; c=relaxed/simple;
	bh=kdIAGJr5Wd7M1RAwUlRIedLCZo414UAkfIqizROIako=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bMW7SUM1aws55R2/WtZtX1pxzxGJWKxMN2rW4AmDIwbAY44Z6HC5u9JboD+UCcS56qU6EN1iGaT3ZfeMxx1q8VqXbfjgjc4RTgRSSvSvyBQQSMZOx7tHJICPQpiJ1ahlK9HGBK2Z/uSTq0dlsRvg/b2CqoxoFJfZrNdM/2eHUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=A2IDiQXS; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Kr
	hMgVKCw4qM6/B3CaW3n3M+BwEyI+IA1IgGyxnNRUc=; b=A2IDiQXS+kHLxhixi0
	9tpPKGyuaTPfRsoVADien5jIhMGpXjmf3rF0oGxX4i68ENeVkrrc88aSXpb0o9Y0
	bXp+NENODuLv4fZXBXCGmzODci2j4/AN6uwf5ZZGYEr4PKj3Wrg9lG5aczO0zC2G
	8TEBXDJjxfCR8C12C2BQW8/LY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXBtYDYbBoN0ahAw--.5480S2;
	Thu, 28 Aug 2025 22:00:36 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v5 00/13] PCI: dwc: Refactor register access with dw_pcie_*_dword helper
Date: Thu, 28 Aug 2025 21:59:38 +0800
Message-Id: <20250828135951.758100-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAXBtYDYbBoN0ahAw--.5480S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1kJFW8ZFWftF1UuFWUCFg_yoWrXw48pa
	y5tFWSvF1xJFWY9F4xX3W7ur1Yy3Z3AayDK393Kw1IqFy3ZFyjqr1rtFyFka47Gr4jqF12
	yr17tFZ7CanrAFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUKsbUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwG3o2iwWuZ9YAABsu

From: Hans Zhang <hans.zhang@cixtech.com>

Register bit manipulation in DesignWare PCIe controllers currently
uses repetitive read-modify-write sequences across multiple drivers.
This pattern leads to code duplication and increases maintenance
complexity as each driver implements similar logic with minor variations.

This series introduces dw_pcie_*_dword() to centralize atomic
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


Changes for v5:
https://patchwork.kernel.org/project/linux-pci/patch/20250813044531.180411-1-18255117159@163.com/

- According to Mani's reminder, following Lukas' previous suggestion for
  another patch, add the dw_pcie_clear/set_dword API.
- Fix the error pointed out by Mani.
- Use the dw_pcie_clear/set_dword API for some of the calls in other patches.

Changes for v4:
https://patchwork.kernel.org/project/linux-pci/cover/20250626145040.14180-1-18255117159@163.com/

- Rebase to v6.17-rc1

Changes for v3:
https://patchwork.kernel.org/project/linux-pci/patch/20250618152112.1010147-1-18255117159@163.com/

- patch 0002: s/u32 val = 0;/u32 val; (pcie-designware-debugfs.c -> set_event_number())
- patch 0013: Remove several val = 0. (Mani)
- patch 0013: s/PCIE_PL_CHK_REG_CONTROL_STATUS/0. (Error in copying the code.) (Mani)

Changes for v2:
- Re-send it in the company environment so that the entire patch series is in the 00/13 cover letter. (Bjorn)
- Modify the subject. (Bjorn and Frank)
---

Hans Zhang (13):
  PCI: dwc: Add dw_pcie_*_dword() for register bit manipulation
  PCI: dwc: Refactor code by using dw_pcie_*_dword()
  PCI: dra7xx: Refactor code by using dw_pcie_*_dword()
  PCI: imx6: Refactor code by using dw_pcie_*_dword()
  PCI: meson: Refactor code by using dw_pcie_*_dword()
  PCI: armada8k: Refactor code by using dw_pcie_*_dword()
  PCI: bt1: Refactor code by using dw_pcie_*_dword()
  PCI: dw-rockchip: Refactor code by using dw_pcie_*_dword()
  PCI: fu740: Refactor code by using dw_pcie_*_dword()
  PCI: qcom: Refactor code by using dw_pcie_*_dword()
  PCI: qcom-ep: Refactor code by using dw_pcie_*_dword()
  PCI: rcar-gen4: Refactor code by using dw_pcie_*_dword()
  PCI: tegra194: Refactor code by using dw_pcie_*_dword()

 drivers/pci/controller/dwc/pci-dra7xx.c       |  10 +-
 drivers/pci/controller/dwc/pci-imx6.c         |  26 ++--
 drivers/pci/controller/dwc/pci-meson.c        |  22 ++--
 drivers/pci/controller/dwc/pcie-armada8k.c    |  43 +++---
 drivers/pci/controller/dwc/pcie-bt1.c         |   5 +-
 .../controller/dwc/pcie-designware-debugfs.c  |  48 +++----
 .../pci/controller/dwc/pcie-designware-ep.c   |  19 ++-
 .../pci/controller/dwc/pcie-designware-host.c |  26 ++--
 drivers/pci/controller/dwc/pcie-designware.c  |  75 +++++------
 drivers/pci/controller/dwc/pcie-designware.h  |  37 ++++--
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |   7 +-
 drivers/pci/controller/dwc/pcie-fu740.c       |   5 +-
 drivers/pci/controller/dwc/pcie-qcom-common.c |  62 +++++----
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  14 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  23 ++--
 drivers/pci/controller/dwc/pcie-tegra194.c    | 122 +++++++-----------
 16 files changed, 223 insertions(+), 321 deletions(-)

-- 
2.49.0


