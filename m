Return-Path: <linux-pci+bounces-25103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC945A7872A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 06:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC9A1889EAC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 04:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5235378F44;
	Wed,  2 Apr 2025 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fGSts1yz"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECE42746C;
	Wed,  2 Apr 2025 04:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743567682; cv=none; b=qpXLoVcJFgXMaK6vjxKRnyWZEId6b+Q/Aer6vFx/9EMqZTzTokOoI8bKMmsi+aEcP6JLTNy9KH3l7txTpawtzmg16aTWoU8m0Rf71nluMfsxiNOzNINfmg9aIEmhUYmv4jKpFZ4AZtU9uXbEoLQcz0PbkR0wp3ivC4EjelvAQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743567682; c=relaxed/simple;
	bh=ls5NTV4DQfJaNC2maDihZDOrTw8SyLsYt6nzMvhGDYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rYOttRW469uGW0xoLt7X+fdDrO63FYUMMepsimXfPvFHQqbJ4nl1aimVC2bAmOIRpEDExRiZJ/ilCT7iC9edUq/PxqzFbzRaZYk8Tl0frFx0YLwg9P4hrVIY0W0IdpFsxvSZ3TrtvMnouPLE84flUphzzCypX/fTYtSoQwR7+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fGSts1yz; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yJC8H
	bzIT+2T6qYVxwHQol7Zotfu76mcIHfKHiR6maQ=; b=fGSts1yzfaKks3yVtPJFF
	3Te/iscBfYgP3458tzUtkNdRIOV2mAi7jnTu6joWyZIpBx2+QxRrnZ1erOGOeO5g
	Sk6Nrkhn+txUvTTz2hm65hghLJNG66AMghj14Lc6U5bf9duzEqoKNZH6pyZkMIeD
	WyKOCkzfEiPk+iUmCuLkWI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXJtQIu+xn1HfgDQ--.39888S2;
	Wed, 02 Apr 2025 12:20:25 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	ilpo.jarvinen@linux.intel.com,
	robh@kernel.org,
	jingoohan1@gmail.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [v7 0/5] Refactor capability search into common macros
Date: Wed,  2 Apr 2025 12:20:15 +0800
Message-Id: <20250402042020.48681-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXJtQIu+xn1HfgDQ--.39888S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4xKr4xCw45Xr4fJFy5Arb_yoW8CF15pF
	yfJ3Z3Aw1rArWa93Z3Xa1FqFW3X3Z7ArW7XrWfK34fXF1fuF4DKrn7KF1rAFW7J397X3Zx
	ZF4UJr95KFnxAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEIzuLUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwsjo2fstXKvYAABsS

1. Refactor capability search into common macros.
2. Refactor capability search functions to eliminate code duplication.
2. DWC/CDNS use common PCI host bridge macros for finding the
   capabilities.
3. Use cdns_pcie_find_*capability to avoid hardcode.

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

Hans Zhang (5):
  PCI: Refactor capability search into common macros
  PCI: Refactor capability search functions to eliminate code
    duplication
  PCI: dwc: Use common PCI host bridge APIs for finding the capabilities
  PCI: cadence: Use common PCI host bridge APIs for finding the
    capabilities
  PCI: cadence: Use cdns_pcie_find_*capability to avoid hardcode.

 .../pci/controller/cadence/pcie-cadence-ep.c  | 40 +++++----
 drivers/pci/controller/cadence/pcie-cadence.c | 28 +++++++
 drivers/pci/controller/cadence/pcie-cadence.h | 18 +++--
 drivers/pci/controller/dwc/pcie-designware.c  | 72 ++---------------
 drivers/pci/pci.c                             | 79 +++++-------------
 drivers/pci/pci.h                             | 81 +++++++++++++++++++
 include/uapi/linux/pci_regs.h                 |  2 +
 7 files changed, 176 insertions(+), 144 deletions(-)


base-commit: acb4f33713b9f6cadb6143f211714c343465411c
-- 
2.25.1


