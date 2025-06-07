Return-Path: <linux-pci+bounces-29150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F19AD0E77
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 18:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA318188C9AF
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D84C20B1FC;
	Sat,  7 Jun 2025 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ngOE0trU"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B621FC7CA;
	Sat,  7 Jun 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312878; cv=none; b=JD+/mIK4e595VCu3V+ha1IamuTDfgAUHLsTr5Zy3d6BMrssebMByBqijA4wX2W7jGpt1EaCVMd0yTM7ifLukJdKPjMZAFU+JhIJx238B5w6N2k8fUaUR2VXnY+dmjqNMZHe9fjjgunGWXlw+8L5i/PNN4oeO9pskI9CK+vdTIy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312878; c=relaxed/simple;
	bh=Mhcp0hEdMJCbnYrbWpH0e2lZ/PEpZ1MZptwxDkCdGuA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sDAWirSLyvVVISptYd61vC7CdX6MPgJh/5g8eu/4r+OQO8yls7Qcf2Ir5L/l1MaCR2NwWOeTsP1UYPA/juLb/02cNEBHecQKIn88aHGy2ZHmBjyvdHe5YHZhWWcmenfetKVc0lpJW8QYH4TL7aEugO2Fq23JHPbPDnocM903BNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ngOE0trU; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0M
	P0K/Hn/u9gluhGKFkPMeVR0IZKhtz92UsXQUcKSfU=; b=ngOE0trUZElXrTp5lu
	QmeHX2NXYFDIAFlZWscYxZf3RZDx/zbcdNR0I9KmGxbBYP3PuZ8lNEC1DruPclyf
	H3BeRj6s2xfZzJYycvFAqtcz1thCJWLv/ZYKOeWQn0Toh5LLeu2x7Fqdgr1fQyC7
	BVeBBP+HY1Vd3NtJUTNdsq8wo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHuXJPZURoL9paGw--.4161S2;
	Sun, 08 Jun 2025 00:14:08 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v13 0/6] Refactor capability search into common macros
Date: Sun,  8 Jun 2025 00:13:59 +0800
Message-Id: <20250607161405.808585-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHuXJPZURoL9paGw--.4161S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw4DJrW5JFWxCF43KF1DAwb_yoWrCr4kpF
	yfC3ZxCr48ArZrC3Z7Ja1I9ay3Xan7A34xJ3y3Kw1fXF13uFy8tr4xKr4rAF9rGrZFq3W7
	ZF45trykCF1DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEl4iOUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxFlo2hEXgmrngAAsC

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

Hans Zhang (6):
  PCI: Introduce generic bus config read helper function
  PCI: Clean up __pci_find_next_cap_ttl() readability
  PCI: Refactor capability search into common macros
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


base-commit: ec7714e4947909190ffb3041a03311a975350fe0
-- 
2.25.1


