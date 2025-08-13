Return-Path: <linux-pci+bounces-33948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDACB24C75
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 16:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A9E174660
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 14:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29862F656B;
	Wed, 13 Aug 2025 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T3x5NyNt"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5952ED869;
	Wed, 13 Aug 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096371; cv=none; b=WU6ujbSy1/I3qwSQ1amj4sATS25jqh4twejNHzwb715blwpDRdrBaaqbbjrb06EJUvTz/JL7pYqbdfR6vrPNYVRLclhD+NaGWN5m/ql9y8Qf/7PSGN2tqoStkCcK7D/uJdGN+KX+mUm/lVlOYcuDLMqYbK/wKb4SFwZscLf0fWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096371; c=relaxed/simple;
	bh=preLNkAdXEBs8bedSRyMQzGMOEOyagy6wT8/dWlJDSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YMXQ+QVWxDoK8p2HKV3aNq0rgMqzYpDoZeQ+NrQ+MkyrM2SVd9oRBoxTlC0eMxSBZi3lbpmK5PFWhRbRlCOvoCk77TFR4R9hQOIEDs7eY4p13VfepdouhtwwCnzuofz0eRjFO1Mcbk2M3pniU1cUn75Xa+sKHpa881G08qznkvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=T3x5NyNt; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Nm
	fXUFTfRJLMIdTmLpwDCei8wSWCsYaJYrt8l8FlfpA=; b=T3x5NyNtp4zShc0Frb
	AezGSm0fcbicdDJKLmb2TGjMnn5QlTTWBUPW+einjf1jQt816HjbCHEMSUxPXpa/
	ZL4aHTrcoPrKLdpNG5wBesWvljSTppQjnfPNrQs8aarbZ0fB2bO2ISHPtY59jg0+
	DVyPxjeZwM+vsqSWcQfdvGJ30=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHYosMpZxo4mzXAw--.28032S2;
	Wed, 13 Aug 2025 22:45:33 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: robh@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	schnelle@linux.ibm.com,
	gbayer@linux.ibm.com,
	lukas@wunner.de,
	arnd@kernel.org,
	geert@linux-m68k.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v15 0/6] Refactor capability search into common macros
Date: Wed, 13 Aug 2025 22:45:23 +0800
Message-Id: <20250813144529.303548-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDHYosMpZxo4mzXAw--.28032S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFy5AFyktF15Zr1kWr4rXwb_yoW7Xw1UpF
	Z3C3ZxGw4DArZFk3Z7Ja1I9a43Xas7ArW3J3y3Kw1fXFy7uFy8tr4xKF4rCF9rKrZ2q3W7
	ZF4aq34kCFn8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR78nnUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxCoo2icmQXo8AABsp

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
Dear Niklas and Gerd,

Can you test this series of patches on the s390?

Thank you very much.
---

---
Changes since v14:
- Delete the first patch in the v14 series.
- The functions that can obtain the values of the registers u8/u16/u32 are
  directly called in PCI_FIND_NEXT_CAP() and PCI_FIND_NEXT_EXT_CAP().
  Use the pci_bus_read_config_byte/word/dword function directly.
- Delete dw_pcie_read_cfg and redefine three functions: dw_pcie_read_cfg_byte/word/dword.
- Delete cdns_pcie_read_cfg and redefine three functions: cdns_pcie_read_cfg_byte/word/dword.

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

Hans Zhang (6):
  PCI: Clean up __pci_find_next_cap_ttl() readability
  PCI: Refactor capability search into PCI_FIND_NEXT_CAP()
  PCI: Refactor extended capability search into PCI_FIND_NEXT_EXT_CAP()
  PCI: dwc: Use PCI core APIs to find capabilities
  PCI: cadence: Use PCI core APIs to find capabilities
  PCI: cadence: Use cdns_pcie_find_*capability() to avoid hardcoding
    offsets

 .../pci/controller/cadence/pcie-cadence-ep.c  | 38 +++++----
 drivers/pci/controller/cadence/pcie-cadence.c | 14 +++
 drivers/pci/controller/cadence/pcie-cadence.h | 39 +++++++--
 drivers/pci/controller/dwc/pcie-designware.c  | 77 ++---------------
 drivers/pci/controller/dwc/pcie-designware.h  | 21 +++++
 drivers/pci/pci.c                             | 76 +++--------------
 drivers/pci/pci.h                             | 85 +++++++++++++++++++
 include/uapi/linux/pci_regs.h                 |  3 +
 8 files changed, 194 insertions(+), 159 deletions(-)


base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58
-- 
2.25.1


