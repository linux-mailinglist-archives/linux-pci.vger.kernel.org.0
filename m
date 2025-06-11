Return-Path: <linux-pci+bounces-29480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BABAD5C9A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 18:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B64172C1B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49E81624E9;
	Wed, 11 Jun 2025 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Tu/SRJo6"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE912E610F;
	Wed, 11 Jun 2025 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660455; cv=none; b=qLWQ1WMPbDWwxPo1R10233dSlt3btBDFuaod3Wt3Elr8oyteeZUk7Ye3pkDF0fMpReCip5200RF+DsIttfQV+EtadS5sw//pWE+VheOUJNLdj6x9mZlx/bXr4c6sPAxbs/SwlUd3ke3Em9JNI+JRzkhDltjO4CJawQOEg1aNymc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660455; c=relaxed/simple;
	bh=U6sLFAnNN8QkT6mXpZ5wVrd2IHHgNj6ewk8t7QwkI18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HD3QneeO7A1lQUspd+FB5KRRUtdvdeQ1bnhtpirh/2AFA3cN6aRSudsYpnDgd42cIVY2uvZYdE/PxUkoGQJvHqqlrwX8vo6TzM4rBXzP7pwb2+nByilqkTLFKAiwJN0N312RopRpkuWQenW+x6ZIG0g6YRU2H7qiVvRmjJ2K18g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Tu/SRJo6; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Re
	dA2VYCsCry1H9Vk53UVO0f37h0GmgLmt8VnAMRk+M=; b=Tu/SRJo6xMhY/W5C8a
	sK3GZKEIfn+3zM/0Yr1xrZiS6ornJuSGAkFZdh0xArUpmL3+w50vP2V2M+Nufi2/
	mYo9dvXXw9Dk4pvxJnuy8mBIW1ZYA6nBJnGDZJzvX1mFO4s6Kl2cuaG7lpztsNfK
	T8EYYLwm7ufAHA9mxWG9uopIM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3f1U8r0loaGtLHw--.58832S2;
	Thu, 12 Jun 2025 00:30:53 +0800 (CST)
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
Subject: [PATCH 00/13] PCI: dwc: Refactor register access with dw_pcie_clear_and_set_dword helper
Date: Thu, 12 Jun 2025 00:30:47 +0800
Message-Id: <20250611163047.860247-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f1U8r0loaGtLHw--.58832S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1kJFW8ZF1DAw43AFW8JFb_yoW5CF47pa
	yYqFW3AF1xtrsI9w17Xay09r15KF95ArZrGws3Ga4IgF1xAF9Fqryrtryfta47KrW0q3W2
	9r1jqa1xGrn3AFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEMKZJUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDx1po2hJrMw-CwAAst

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
---

Hans Zhang (13):
  PCI: dwc: Add dw_pcie_clear_and_set_dword() for register bit
    manipulation
  PCI: dwc: Refactor dwc to use dw_pcie_clear_and_set_dword()
  PCI: dwc: Refactor dra7xx to use dw_pcie_clear_and_set_dword()
  PCI: dwc: Refactor imx6 to use dw_pcie_clear_and_set_dword()
  PCI: dwc: Refactor meson to use dw_pcie_clear_and_set_dword()
  PCI: dwc: Refactor armada8k to use dw_pcie_clear_and_set_dword()
  PCI: dwc: Refactor bt1 to use dw_pcie_clear_and_set_dword()
  PCI: dwc: Refactor rockchip to use dw_pcie_clear_and_set_dword()
  PCI: dwc: Refactor fu740 to use dw_pcie_clear_and_set_dword()
  PCI: dwc: Refactor qcom common to use dw_pcie_clear_and_set_dword()
  PCI: dwc: Refactor qcom-ep to use dw_pcie_clear_and_set_dword()
  PCI: dwc: Refactor rcar-gen4 to use dw_pcie_clear_and_set_dword()
  PCI: dwc: Refactor tegra194 to use dw_pcie_clear_and_set_dword()

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


