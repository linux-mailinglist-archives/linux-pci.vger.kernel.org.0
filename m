Return-Path: <linux-pci+bounces-27546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA682AB248E
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 18:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D37A02C1D
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68E019CD1D;
	Sat, 10 May 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lI+XQvEN"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F420242936;
	Sat, 10 May 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746893265; cv=none; b=dtjgMYXXauj1k/RiEGMfYBpXn88TwJohjluCNN2ZUXLHzAhSVgOgx+UIBxYRl0t/IVUSen0oz4YCRGHGt6Oq7KgsJP5WhuyzDcWOGCU8ispSZ3CMsOqiO/dPY4LR4tNyLlCzCW9ovBNndhZpJbGQqSKulTJnzvTpMdx7X+2+RRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746893265; c=relaxed/simple;
	bh=6ZWkjWQxTdACnQ81i0FD3p/9UfIEmHD4+z/XUo4w4xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VaOM1GlsDadvwNpdndjuKHiPP56VTWXcVnTEyzQtet6shbpUt0RiJ0VY/9tiiEpuP/i0MHPf8xvG8X2T0+4OdgBH+OKGa5cWbP//mZiF8KDkNbtiKEF97Lc9ylxmd5njRu+MJNTjPIZLM1bM3oPgEUugdPB6v0h7X8HO3HT4CDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lI+XQvEN; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=EN
	7koMY1BdBivAUB/PxOjVeUuEit4SfGbK5sYjjdIcM=; b=lI+XQvENmnlTKsme0H
	V9rN+Niy43blQ/x2+zTzYBOkGpCbHlPesrMfsAwHeILKTvolCyKnXkFiX37DPVBi
	giRcxPFbrD2bnyqTJ7oYwZi1JnoRoXhTHiWpgd14/RbH9Y+SbzxjChBuPiOCKWOr
	kIn/34zGuEaDBeo6Ew9jbFLgQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD36iuveR9o3J32AA--.26781S2;
	Sun, 11 May 2025 00:07:12 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org
Cc: cassel@kernel.org,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [RESEND PATCH v2 0/3] Standardize link status check to return bool
Date: Sun, 11 May 2025 00:07:07 +0800
Message-Id: <20250510160710.392122-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD36iuveR9o3J32AA--.26781S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWDAw18WF13XFyrJw1UKFg_yoW8Zw1kpa
	45t3yxAF1rtF4Y9F1Yq3WDCa4YqFnrAasrK393Wa43XFy3CrWUXr13GFyFqasrJFW8Xr17
	KF13t3W7GFs3JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEdWFUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxRJo2gfb9TkxAAAsJ

1. PCI: dwc: Standardize link status check to return bool.
2. PCI: mobiveil: Refactor link status check.
3. PCI: cadence: Simplify j721e link status check.

---
Changes for RESEND:
- add Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Changes for v2:
- Remove the return of some functions (!!) .
- Patches 2/3 and 3/3 have not been modified.

Based on the following branch:
https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dw-rockchip
---

Hans Zhang (3):
  PCI: dwc: Standardize link status check to return bool
  PCI: mobiveil: Refactor link status check
  PCI: cadence: Simplify j721e link status check

 drivers/pci/controller/cadence/pci-j721e.c             | 6 +-----
 drivers/pci/controller/dwc/pci-dra7xx.c                | 4 ++--
 drivers/pci/controller/dwc/pci-exynos.c                | 4 ++--
 drivers/pci/controller/dwc/pci-keystone.c              | 5 ++---
 drivers/pci/controller/dwc/pci-meson.c                 | 6 +++---
 drivers/pci/controller/dwc/pcie-armada8k.c             | 6 +++---
 drivers/pci/controller/dwc/pcie-designware.c           | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h           | 4 ++--
 drivers/pci/controller/dwc/pcie-dw-rockchip.c          | 2 +-
 drivers/pci/controller/dwc/pcie-histb.c                | 9 +++------
 drivers/pci/controller/dwc/pcie-keembay.c              | 2 +-
 drivers/pci/controller/dwc/pcie-kirin.c                | 7 ++-----
 drivers/pci/controller/dwc/pcie-qcom-ep.c              | 2 +-
 drivers/pci/controller/dwc/pcie-qcom.c                 | 4 ++--
 drivers/pci/controller/dwc/pcie-rcar-gen4.c            | 2 +-
 drivers/pci/controller/dwc/pcie-spear13xx.c            | 7 ++-----
 drivers/pci/controller/dwc/pcie-tegra194.c             | 4 ++--
 drivers/pci/controller/dwc/pcie-uniphier.c             | 2 +-
 drivers/pci/controller/dwc/pcie-visconti.c             | 4 ++--
 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 9 ++-------
 drivers/pci/controller/mobiveil/pcie-mobiveil.h        | 2 +-
 21 files changed, 37 insertions(+), 56 deletions(-)


base-commit: 286ed198b899739862456f451eda884558526a9d
-- 
2.25.1


