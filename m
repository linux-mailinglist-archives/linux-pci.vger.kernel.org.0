Return-Path: <linux-pci+bounces-27001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7766DAA0C25
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 14:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F49D5A0AA4
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 12:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAC91D5AD4;
	Tue, 29 Apr 2025 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="l3iPfEKK"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB56B2C375D;
	Tue, 29 Apr 2025 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931074; cv=none; b=t91hQTs887nREJQhkEdjAqA7/9kU+PyKWhZuSIlNcg8jrc/+ag1DaC6q1x+8JDbHyjWmS+E1+wmGpp4Ihzi1ZeFZrDtqd2iXuxIP9mXFiCIrjltifgt64GDs26Tjru763Mg4ZMx/SizZNdor9S7UNCLsTiYSPWfEzwoUs98CJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931074; c=relaxed/simple;
	bh=Nh61M+3AOaEMe90mja8bA892MRdi/6kf7Er7e40gjlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BCc2+wUvACqErGliVTIQITDTD1Z34gVguYcIJ4wyIxsn8/AxKJYObcUAWTnyb4jLECfjfLm5sciFMIGDB+fpIX6yUaLk+QWZee1sEttA3OTx/65pegvPBlX6jfhYzdMCfjltk0wzv2XNTmKdHpmBvjZv53kp2x6UlQsD4iuu4QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=l3iPfEKK; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8o3FS
	boB7vwcWS5DCphH0qB7RTnXelES5xI2tIDdiCE=; b=l3iPfEKKuQHD0dra8m9Gu
	/xI8bSKAIb1cv1IUQlAOfqRuIcf060Xf1YGz43jDFX2njmlR8rYb4Sf7lxgGDrhG
	grYul2X8iAdo9jSgfBZwSLa2sBBWMnVCWyWjCpUuhdOJ+Sc7AXXb3CHv+JVS1uei
	wTvY9fJcQ/Xs0MCgXyGx20=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC3DRQeyxBoOlBzDQ--.23007S2;
	Tue, 29 Apr 2025 20:50:39 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	kw@linux.com
Cc: cassel@kernel.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v10 0/6] Refactor capability search into common macros
Date: Tue, 29 Apr 2025 20:50:30 +0800
Message-Id: <20250429125036.88060-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3DRQeyxBoOlBzDQ--.23007S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWruF48KrW3Ar4DKFy7Awb_yoW8urWfpF
	y3G3Z3Cr4rArZF9as3Aa129a15Jas7JFyxJ3yfKw1fXF13uFW5tr4xKr1rAFZrX397X3Zx
	ZF45Jr95KF1qy3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE031iUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwo+o2gQwOf7igABs3

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
 drivers/pci/pci.c                             | 68 ++------------
 drivers/pci/pci.h                             | 88 +++++++++++++++++++
 include/uapi/linux/pci_regs.h                 |  2 +
 8 files changed, 189 insertions(+), 148 deletions(-)


base-commit: a24588245776dafc227243a01bfbeb8a59bafba9
-- 
2.25.1


