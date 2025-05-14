Return-Path: <linux-pci+bounces-27734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E52AB70EC
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 18:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D921888DED
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 16:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61CE1B21B8;
	Wed, 14 May 2025 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VmoOv9uA"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB2B14900B;
	Wed, 14 May 2025 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239225; cv=none; b=nrCvqaRI1MCP31aAzuLM/JAF5HYcbDy083my2wWbzYLfULX/sND+EOVoPm+Z17GfyJ3guowVZgqxnAgwitVhagaYrNgL7pPwU2u8Ao0diG3Bd3o8rO160yUyaXiu6whBQ3lR1CVjm4g8YqsvN+aAYZNvYd/1iszdSQ9xOk9T5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239225; c=relaxed/simple;
	bh=nZ/xAcZFUK5W+kvFt62ZRN6Usy7slEUmRt1vB7ZWHnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hS1jrr5Au6cTXCht3eB+ZhOWERyu0QPdzOB1ggQOOnx8Db8S2264VDT/bJ9NOhn37Tieu34UEP0eP60GKMurYbo6L69Fw+oj8JeA40E/hf6/tGa6lSZg3XJRZTC8JYk48PGlRGsDLtXlLkjtoiPtvtdTL316G/xIrjXkESAPeAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VmoOv9uA; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wn
	eBS4nlvV0le2Nrp5XhT7onZfXQi2MY0e3ZJOJZyhw=; b=VmoOv9uA/V48UZVaZh
	kVCuyB8NUxIXKh7v8PPZZJ6/vmHXutBx9Wjru+AzazK4Hx9621mkRbhMsN8XjZFZ
	toVXKK1PjWoN2mc0Nf5mZUDpJZlSYFuaxHUXjI9Tmm01XKsYJ1OlpKbBFUJJX1ko
	0A7LzrSmmJ8u9p12LXpgFCH9U=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wC3VU0LwSRo5cN_BQ--.35962S2;
	Thu, 15 May 2025 00:12:59 +0800 (CST)
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
Subject: [PATCH v12 0/6] Refactor capability search into common macros
Date: Thu, 15 May 2025 00:12:52 +0800
Message-Id: <20250514161258.93844-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3VU0LwSRo5cN_BQ--.35962S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw4DJrW5JFWxCF43KF1DAwb_yoWrAryrpF
	yfG3ZxCr48ArZrC3Z7Aa1I9ay3X3Z7A34xJ3y3Kw13XF13uFyrtr1xKF4rAF9rKrZFq3W7
	ZFW3trykCF1DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pElApxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDw9No2gkvuBvxQAAsW

Dear Maintainers,

This patch series addresses long-standing code duplication in PCI
capability discovery logic across the PCI core and controller drivers.
The existing implementation ties capability search to fully initialized
PCI device structures, limiting its usability during early controller
initialization phases where device/bus structures may not yet be
available.

The primary goal is to decouple capability discovery from PCI device
dependencies by introducing a unified framework using config space
accessor-based macros. This enables:

1. Early Capability Discovery: Host controllers (e.g., Cadence, DWC)
can now perform capability searches during pre-initialization stages
using their native config accessors.

2. Code Consolidation: Common logic for standard and extended capability
searches is refactored into shared macros (`PCI_FIND_NEXT_CAP_TTL` and
`PCI_FIND_NEXT_EXT_CAPABILITY`), eliminating redundant implementations.

3. Safety and Maintainability: TTL checks are centralized within the
macros to prevent infinite loops, while hardcoded offsets in drivers
are replaced with dynamic discovery, reducing fragility.

Key improvements include:  
- Driver Conversions: DesignWare and Cadence drivers are migrated to
  use the new macros, removing device-specific assumptions and ensuring
  consistent error handling.

- Enhanced Readability: Magic numbers are replaced with symbolic
  constants, and config space accessors are standardized for clarity.

- Backward Compatibility: Existing PCI core behavior remains unchanged.

---
Changes since v11:
- Resolved some compilation warning.
- Add some include.
- Add the *** BLURB HERE *** description(Corrected by Mani and Krzysztof).

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
 drivers/pci/controller/dwc/pcie-designware.c  | 81 +++--------------
 drivers/pci/pci.c                             | 68 ++------------
 drivers/pci/pci.h                             | 88 +++++++++++++++++++
 include/uapi/linux/pci_regs.h                 |  2 +
 8 files changed, 194 insertions(+), 148 deletions(-)


base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
-- 
2.25.1


