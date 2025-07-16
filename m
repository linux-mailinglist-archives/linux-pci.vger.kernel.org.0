Return-Path: <linux-pci+bounces-32292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBCBB07ACB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E96565935
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEF82F5493;
	Wed, 16 Jul 2025 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V8QWarkJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181C1274B30;
	Wed, 16 Jul 2025 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682356; cv=none; b=jCP9jtqyuPN1dG7L2fchwVZqwuj/aa4Gerf1PKkNiL/2Z1/8OWQZeorux4pzmsrw2UEjUf2h4KWAMKb/kit3t4+2gaSju8+PCmv7OEO+86oaWVa37c27tUJ1bYweD+rXciPVOVttmGXOQaN9uEwbh1CV6fNQsQnH1eWRkBfLvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682356; c=relaxed/simple;
	bh=Y7Y3yvNuOxNpwgHPNpY9Rwif2XuASlswAwe+6Lw2zIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DTePno8O8siaLN/ojXN4SgDe2JNuIioUuSXa55iY3e5TlUECQ2Pa3AhsrCM4t0CTWydLiczivmknB0DkY2c6K2FnZxeLgHqrpzCx1ptuQ8i9zmoWAuV0DeeOUdDdjfyN0d6OvJTACA/ksGVfTtJNPKvbymKbrCBCANNWShvQEZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V8QWarkJ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0a
	r1qOZLZdjjoiPFVhTxjLYjGvXCNT27rtc5a+oaVnM=; b=V8QWarkJXsYC8tyggP
	4HcwpBcsOQ5F88r67UMTAs7wCsvxWSanMnYs7r494w8SAvGcb7BpQWrV3xp0fHOU
	Vp33JAWfJ7RTnZcvExGn0zq1d1+U+/VFh8max6w1twXTC6yCAceO2sUN+Rq/bQYR
	tEoJcPfycW3zlyVpcqe0FprmE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnMkhWz3doF6jWAw--.24466S2;
	Thu, 17 Jul 2025 00:12:08 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: robh@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v14 0/7] Refactor capability search into common macros
Date: Thu, 17 Jul 2025 00:11:56 +0800
Message-Id: <20250716161203.83823-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnMkhWz3doF6jWAw--.24466S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw4DJrW5JFWxCF43KF1DAwb_yoWrtrW7pF
	4rC3ZxGw48ArZrC3Z7Ja1I9ay3X3Z7A347J3y3Kw13XF13uFy8tr4xKF4rAF9rKrZFq3W7
	ZF4UtrykCFn8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piasjUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhWMo2h3yLuCdwAAsZ

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
searches is refactored into shared macros (`PCI_FIND_NEXT_CAP` and
`PCI_FIND_NEXT_EXT_CAP`), eliminating redundant implementations.

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
Changes since v13:
- Split patch 3/6 into two patches for searching standard and extended capability. (Bjorn)
- Optimize the code based on the review comments from Bjorn.
- Patch 5/7 and 6/7 use simplified macro definitions: PCI_FIND_NEXT_CAP(), PCI_FIND_NEXT_EXT_CAP().
- The other patches have not been modified.

Changes since v12:
- Modify some commit messages, code format issues, and optimize the function return values.

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

Hans Zhang (7):
  PCI: Introduce generic bus config read helper function
  PCI: Clean up __pci_find_next_cap_ttl() readability
  PCI: Refactor standard capability search into common macro
  PCI: Refactor extended capability search into common macro
  PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
  PCI: cadence: Use common PCI host bridge APIs for finding the
    capabilities
  PCI: cadence: Use cdns_pcie_find_*capability to avoid hardcode

 drivers/pci/access.c                          | 15 ++++
 .../pci/controller/cadence/pcie-cadence-ep.c  | 38 ++++----
 drivers/pci/controller/cadence/pcie-cadence.c | 30 +++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 18 ++--
 drivers/pci/controller/dwc/pcie-designware.c  | 83 ++++--------------
 drivers/pci/pci.c                             | 76 +++-------------
 drivers/pci/pci.h                             | 87 +++++++++++++++++++
 include/uapi/linux/pci_regs.h                 |  3 +
 8 files changed, 196 insertions(+), 154 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.25.1


