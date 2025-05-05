Return-Path: <linux-pci+bounces-27171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CE4AA993D
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 18:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EB1189B74A
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 16:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF9526B2DE;
	Mon,  5 May 2025 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WRt98VaG"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446ED26B2C5;
	Mon,  5 May 2025 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462899; cv=none; b=YJmmcsJZ6sqxPKy3Da+5tfcW7V7mrRamWCvXU18ZXMK+nbiH3O1Dlkhj86h2NO18TufBhR+BXhtK4TPjzL+vDVZDaVtUh4v5PsVN3M2fiALqC4hiM742LNTsO3v6c4iHpQKWjyKSOsDsrzFiobNr+PHj9sYkICxwKvQiwSYmA2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462899; c=relaxed/simple;
	bh=tfZ9HbpLi4eVtL61sCRmj46Ofv8ja4hjrhPbfO+bYKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oIxmCrACbTexoOoVtix2cdRvGdYRy8QGT/WLTVK1UEChQKlWHfSCQ+SzJwcpejPFWkFopMbpqsUjLC07hWZte7qxWVVM0a7qOORow3NzQvZSMSLRGJ/xwy2504Hry6fiv0FR3rA94IJ+Pw1xHqaXKvt3xTodmiJvoYigwPsecbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WRt98VaG; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/4e1v
	m9yaiKz8b0+WzRhsKDbk4kXw2ujR+QVpAZ2tgc=; b=WRt98VaGdRJlbpPi9S/OG
	+ZTHyOLetLm1HSLCx322PrVZmfSc6G8D9qM/PwF5nmytAQqQ8Yi10rGAN8SbxJ1T
	EQ36xVTwX6fvXH+4YFppbeNJf4C7VN3x9+j/ij4GcBeHY9kXgL6N6LXPo+IsR69I
	D0RJWB7jAz9iJu1MlEuTUE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDn+lmO6BhoumvGBw--.3540S2;
	Tue, 06 May 2025 00:34:23 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	kw@linux.com
Cc: cassel@kernel.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v11 0/6] Refactor capability search into common macros
Date: Tue,  6 May 2025 00:34:14 +0800
Message-Id: <20250505163420.198012-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDn+lmO6BhoumvGBw--.3540S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF1UJry5CF17uryUuF15Arb_yoW5Xw4fpF
	15J3Z3Crs5AFZ2kan3A3Wa9a43Za97Ja4xJ3yfKwn3XF17uFWftrs2k3WrAF9rX397X3Zx
	ZFW5Jr95KF1qya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEdWFUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxVEo2gY4bmFPwABsu

1. PCI: Introduce generic bus config read helper function.
2. PCI: Clean up __pci_find_next_cap_ttl() readability.
3. PCI: Refactor capability search into common macros.
4. PCI: dwc: Use common PCI host bridge APIs for finding the capabilities.
5. PCI: cadence: Use common PCI host bridge APIs for finding the
   capabilities.
6. PCI: cadence: Use cdns_pcie_find_*capability to avoid hardcode.

---
Changes since v10:
- The patch [v10 2/6] remove #include <uapi/linux/pci_regs.h> and add macro definition comments.
- The patch [v10 3/6] remove #include <uapi/linux/pci_regs.h> and commit message were modified.
- The other patches have not been modified.

Changes since v9:
- Resolved [v9 4/6] compilation error.
  The latest 6.15 rc1 merge __dw_pcie_find_vsec_capability, which uses 
  dw_pcie_find_next_ext_capability.
- The other patches have not been modified.

Changes since v8:
- Split patch.
- The patch commit message were modified.
- Other patches(4/6, 5/6, 6/6) are unchanged.

Changes since v7:
- Patch 2/5 and 3/5 compilation error resolved.
- Other patches are unchanged.

Changes since v6:
- Refactor capability search into common macros.
- Delete pci-host-helpers.c and MAINTAINERS.

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
---

Hans Zhang (6):
  PCI: Introduce generic bus config read helper function
  PCI: Clean up __pci_find_next_cap_ttl() readability
  PCI: Refactor capability search into common macros
  PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
  PCI: cadence: Use common PCI host bridge APIs for finding the
    capabilities
  PCI: cadence: Use cdns_pcie_find_*capability to avoid hardcode.

 drivers/pci/access.c                          | 17 ++++
 .../pci/controller/cadence/pcie-cadence-ep.c  | 40 +++++----
 drivers/pci/controller/cadence/pcie-cadence.c | 28 ++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 18 ++--
 drivers/pci/controller/dwc/pcie-designware.c  | 76 ++--------------
 drivers/pci/pci.c                             | 68 ++-------------
 drivers/pci/pci.h                             | 87 +++++++++++++++++++
 include/uapi/linux/pci_regs.h                 |  2 +
 8 files changed, 188 insertions(+), 148 deletions(-)


base-commit: ca91b9500108d4cf083a635c2e11c884d5dd20ea
-- 
2.25.1


